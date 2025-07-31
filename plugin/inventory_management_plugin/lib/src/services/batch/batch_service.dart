import 'dart:async';
import '../../domain/entities/batch.dart';
import '../../domain/entities/serial_number.dart';
import '../../domain/entities/inventory_movement.dart';
import '../../domain/repositories/batch_repository.dart';
import '../../domain/repositories/serial_number_repository.dart';
import '../../domain/repositories/inventory_movement_repository.dart';
import '../../core/utils/logger.dart';
import '../../core/utils/id_generator.dart';
import '../sync/sync_service.dart';

/// Service for managing product batches and serial numbers
class BatchService {
  final BatchRepository _batchRepository;
  final SerialNumberRepository _serialNumberRepository;
  final InventoryMovementRepository _movementRepository;
  final SyncService? _syncService;

  BatchService({
    required BatchRepository batchRepository,
    required SerialNumberRepository serialNumberRepository,
    required InventoryMovementRepository movementRepository,
    SyncService? syncService,
  })  : _batchRepository = batchRepository,
        _serialNumberRepository = serialNumberRepository,
        _movementRepository = movementRepository,
        _syncService = syncService;

  /// Creates a new batch
  Future<Batch> createBatch({
    required String productId,
    required String branchId,
    required String batchNumber,
    required double quantity,
    required double unitCost,
    DateTime? manufacturingDate,
    DateTime? expiryDate,
    String? supplierId,
    String? purchaseOrderId,
    String? notes,
  }) async {
    try {
      // Validate batch number uniqueness
      final existing = await _batchRepository.getBatchByNumber(batchNumber);
      if (existing != null) {
        throw Exception('Batch number already exists: $batchNumber');
      }

      final batch = Batch(
        id: IdGenerator.generateId(),
        organizationId: '', // Will be set from context
        branchId: branchId,
        productId: productId,
        batchNumber: batchNumber,
        manufacturingDate: manufacturingDate,
        expiryDate: expiryDate,
        quantity: quantity,
        unitCost: unitCost,
        supplierId: supplierId,
        purchaseOrderId: purchaseOrderId,
        notes: notes,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        syncStatus: 'pending',
      );

      final createdBatch = await _batchRepository.createBatch(batch);

      // Sync if available
      if (_syncService != null) {
        await _syncService!.syncBatch(createdBatch);
      }

      Logger.info('Batch created: $batchNumber');
      return createdBatch;
    } catch (e) {
      Logger.error('Error creating batch: $e');
      rethrow;
    }
  }

  /// Creates serial numbers for a product
  Future<List<SerialNumber>> createSerialNumbers({
    required String productId,
    required String branchId,
    required List<String> serialNumbers,
    String? batchId,
    String? supplierId,
    String? purchaseOrderId,
  }) async {
    try {
      final createdSerials = <SerialNumber>[];

      for (final serial in serialNumbers) {
        // Validate serial number uniqueness
        final existing = await _serialNumberRepository.getBySerialNumber(serial);
        if (existing != null) {
          throw Exception('Serial number already exists: $serial');
        }

        final serialNumber = SerialNumber(
          id: IdGenerator.generateId(),
          organizationId: '', // Will be set from context
          productId: productId,
          serialNumber: serial,
          batchId: batchId,
          status: 'available',
          currentBranchId: branchId,
          supplierId: supplierId,
          purchaseOrderId: purchaseOrderId,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          syncStatus: 'pending',
        );

        final created = await _serialNumberRepository.createSerialNumber(serialNumber);
        createdSerials.add(created);
      }

      // Sync if available
      if (_syncService != null) {
        for (final serial in createdSerials) {
          await _syncService!.syncSerialNumber(serial);
        }
      }

      Logger.info('Created ${createdSerials.length} serial numbers');
      return createdSerials;
    } catch (e) {
      Logger.error('Error creating serial numbers: $e');
      rethrow;
    }
  }

  /// Allocates batch quantity for a sale or transfer
  Future<List<Batch>> allocateBatchQuantity({
    required String productId,
    required String branchId,
    required double requiredQuantity,
    String? preferredBatchId,
    bool useFifo = true,
  }) async {
    try {
      final activeBatches = await _batchRepository.getActiveBatches(productId);
      final branchBatches = activeBatches
          .where((b) => b.branchId == branchId)
          .toList();

      if (branchBatches.isEmpty) {
        throw Exception('No active batches available for product');
      }

      // Sort batches based on FIFO/LIFO
      if (useFifo) {
        branchBatches.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      } else {
        branchBatches.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      }

      // If preferred batch, move it to front
      if (preferredBatchId != null) {
        final preferredIndex = branchBatches.indexWhere((b) => b.id == preferredBatchId);
        if (preferredIndex > 0) {
          final preferred = branchBatches.removeAt(preferredIndex);
          branchBatches.insert(0, preferred);
        }
      }

      // Allocate from batches
      final allocations = <Batch>[];
      double remaining = requiredQuantity;

      for (final batch in branchBatches) {
        if (remaining <= 0) break;

        final available = batch.quantity;
        final toAllocate = available >= remaining ? remaining : available;

        if (toAllocate > 0) {
          allocations.add(batch.copyWith(quantity: toAllocate));
          remaining -= toAllocate;
        }
      }

      if (remaining > 0) {
        throw Exception('Insufficient batch quantity. Required: $requiredQuantity, Available: ${requiredQuantity - remaining}');
      }

      return allocations;
    } catch (e) {
      Logger.error('Error allocating batch quantity: $e');
      rethrow;
    }
  }

  /// Updates batch quantity after movement
  Future<void> updateBatchQuantity({
    required String batchId,
    required double quantityChange,
    required String movementType,
  }) async {
    try {
      final batch = await _batchRepository.getBatchById(batchId);
      if (batch == null) {
        throw Exception('Batch not found');
      }

      double newQuantity = batch.quantity;
      
      if (['sale', 'damage', 'adjustment_out', 'transfer_out'].contains(movementType)) {
        newQuantity -= quantityChange;
      } else if (['purchase', 'return', 'adjustment_in', 'transfer_in'].contains(movementType)) {
        newQuantity += quantityChange;
      }

      if (newQuantity < 0) {
        throw Exception('Insufficient batch quantity');
      }

      await _batchRepository.updateBatchQuantity(batchId, newQuantity);

      Logger.info('Updated batch $batchId quantity: $newQuantity');
    } catch (e) {
      Logger.error('Error updating batch quantity: $e');
      rethrow;
    }
  }

  /// Updates serial number status
  Future<void> updateSerialNumberStatus({
    required String serialNumber,
    required String status,
    String? saleId,
    String? customerId,
    String? currentBranchId,
    String? notes,
  }) async {
    try {
      final serial = await _serialNumberRepository.getBySerialNumber(serialNumber);
      if (serial == null) {
        throw Exception('Serial number not found');
      }

      final updated = serial.copyWith(
        status: status,
        saleId: saleId ?? serial.saleId,
        customerId: customerId ?? serial.customerId,
        currentBranchId: currentBranchId ?? serial.currentBranchId,
        notes: notes,
        updatedAt: DateTime.now(),
      );

      await _serialNumberRepository.updateSerialNumber(updated);

      // Sync if available
      if (_syncService != null) {
        await _syncService!.syncSerialNumber(updated);
      }

      Logger.info('Updated serial number $serialNumber status to $status');
    } catch (e) {
      Logger.error('Error updating serial number status: $e');
      rethrow;
    }
  }

  /// Gets expiring batches
  Future<List<Batch>> getExpiringBatches({
    int daysBeforeExpiry = 30,
    String? branchId,
  }) async {
    try {
      var batches = await _batchRepository.getExpiringBatches(daysBeforeExpiry);
      
      if (branchId != null) {
        batches = batches.where((b) => b.branchId == branchId).toList();
      }

      return batches;
    } catch (e) {
      Logger.error('Error getting expiring batches: $e');
      rethrow;
    }
  }

  /// Gets expired batches
  Future<List<Batch>> getExpiredBatches({String? branchId}) async {
    try {
      var batches = await _batchRepository.getExpiredBatches();
      
      if (branchId != null) {
        batches = batches.where((b) => b.branchId == branchId).toList();
      }

      return batches;
    } catch (e) {
      Logger.error('Error getting expired batches: $e');
      rethrow;
    }
  }

  /// Gets serial number history
  Future<List<SerialNumber>> getSerialNumberHistory(String serialNumber) async {
    try {
      final serial = await _serialNumberRepository.getBySerialNumber(serialNumber);
      if (serial == null) {
        throw Exception('Serial number not found');
      }

      // Get movement history for this serial
      final movements = await _movementRepository.getMovementsByProduct(serial.productId);
      
      // Filter movements that reference this serial number
      final serialMovements = movements.where((m) => 
        m.notes?.contains(serialNumber) ?? false
      ).toList();

      return [serial]; // Return serial with its current state
    } catch (e) {
      Logger.error('Error getting serial number history: $e');
      rethrow;
    }
  }

  /// Validates serial numbers for a transaction
  Future<bool> validateSerialNumbers({
    required List<String> serialNumbers,
    required String productId,
    required String branchId,
  }) async {
    try {
      for (final serial in serialNumbers) {
        final serialNumber = await _serialNumberRepository.getBySerialNumber(serial);
        
        if (serialNumber == null) {
          throw Exception('Serial number not found: $serial');
        }
        
        if (serialNumber.productId != productId) {
          throw Exception('Serial number $serial does not belong to this product');
        }
        
        if (serialNumber.currentBranchId != branchId) {
          throw Exception('Serial number $serial is not in this branch');
        }
        
        if (serialNumber.status != 'available') {
          throw Exception('Serial number $serial is not available (status: ${serialNumber.status})');
        }
      }

      return true;
    } catch (e) {
      Logger.error('Error validating serial numbers: $e');
      rethrow;
    }
  }

  /// Watches batches for a product
  Stream<List<Batch>> watchBatches(String productId) {
    return _batchRepository.watchBatchesByProduct(productId);
  }

  /// Watches serial numbers for a product
  Stream<List<SerialNumber>> watchSerialNumbers(String productId) {
    return _serialNumberRepository.watchSerialNumbersByProduct(productId);
  }

  void dispose() {
    _batchRepository.dispose();
    _serialNumberRepository.dispose();
  }
}