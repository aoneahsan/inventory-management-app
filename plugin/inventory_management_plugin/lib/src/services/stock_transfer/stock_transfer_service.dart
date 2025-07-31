import 'dart:async';
import '../../domain/entities/stock_transfer.dart';
import '../../domain/entities/stock_transfer_item.dart';
import '../../domain/entities/inventory_movement.dart';
import '../../domain/repositories/stock_transfer_repository.dart';
import '../../domain/repositories/inventory_movement_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../core/utils/logger.dart';
import '../../core/utils/id_generator.dart';
import '../sync/sync_service.dart';

/// Service for managing stock transfers between branches
class StockTransferService {
  final StockTransferRepository _transferRepository;
  final InventoryMovementRepository _movementRepository;
  final ProductRepository _productRepository;
  final SyncService? _syncService;

  StockTransferService({
    required StockTransferRepository transferRepository,
    required InventoryMovementRepository movementRepository,
    required ProductRepository productRepository,
    SyncService? syncService,
  })  : _transferRepository = transferRepository,
        _movementRepository = movementRepository,
        _productRepository = productRepository,
        _syncService = syncService;

  /// Initiates a new stock transfer
  Future<StockTransfer> initiateTransfer({
    required String fromBranchId,
    required String toBranchId,
    required List<StockTransferItem> items,
    required String userId,
    String? notes,
  }) async {
    try {
      // Validate stock availability
      await _validateStockAvailability(fromBranchId, items);

      // Generate transfer number
      final transferNumber = _generateTransferNumber();

      // Create transfer
      final transfer = StockTransfer(
        id: IdGenerator.generateId(),
        organizationId: '', // Will be set from context
        fromBranchId: fromBranchId,
        toBranchId: toBranchId,
        transferNumber: transferNumber,
        status: 'pending',
        items: items,
        notes: notes,
        initiatedBy: userId,
        initiatedAt: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        syncStatus: 'pending',
      );

      final createdTransfer = await _transferRepository.createTransfer(transfer);

      // Create outgoing inventory movements
      await _createOutgoingMovements(createdTransfer);

      // Sync if available
      if (_syncService != null) {
        await _syncService!.syncTransfer(createdTransfer);
      }

      Logger.info('Transfer initiated: ${createdTransfer.transferNumber}');
      return createdTransfer;
    } catch (e) {
      Logger.error('Error initiating transfer: $e');
      rethrow;
    }
  }

  /// Approves a pending transfer
  Future<StockTransfer> approveTransfer({
    required String transferId,
    required String approvedBy,
  }) async {
    try {
      final transfer = await _transferRepository.getTransferById(transferId);
      if (transfer == null) {
        throw Exception('Transfer not found');
      }

      if (transfer.status != 'pending') {
        throw Exception('Only pending transfers can be approved');
      }

      final updatedTransfer = transfer.copyWith(
        status: 'in_transit',
        approvedBy: approvedBy,
        approvedAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final result = await _transferRepository.updateTransfer(updatedTransfer);

      // Sync if available
      if (_syncService != null) {
        await _syncService!.syncTransfer(result);
      }

      Logger.info('Transfer approved: ${result.transferNumber}');
      return result;
    } catch (e) {
      Logger.error('Error approving transfer: $e');
      rethrow;
    }
  }

  /// Receives items at destination branch
  Future<StockTransfer> receiveTransfer({
    required String transferId,
    required String receivedBy,
    Map<String, double>? actualQuantities,
  }) async {
    try {
      final transfer = await _transferRepository.getTransferById(transferId);
      if (transfer == null) {
        throw Exception('Transfer not found');
      }

      if (transfer.status != 'in_transit') {
        throw Exception('Only in-transit transfers can be received');
      }

      // Update items with actual quantities if provided
      List<StockTransferItem> updatedItems = transfer.items;
      if (actualQuantities != null) {
        updatedItems = transfer.items.map((item) {
          final actualQty = actualQuantities[item.productId];
          if (actualQty != null) {
            return item.copyWith(
              receivedQuantity: actualQty,
              discrepancyReason: actualQty != item.quantity
                  ? 'Quantity mismatch during receiving'
                  : null,
            );
          }
          return item.copyWith(receivedQuantity: item.quantity);
        }).toList();
      }

      final updatedTransfer = transfer.copyWith(
        status: 'completed',
        items: updatedItems,
        receivedBy: receivedBy,
        receivedAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final result = await _transferRepository.updateTransfer(updatedTransfer);

      // Create incoming inventory movements
      await _createIncomingMovements(result);

      // Sync if available
      if (_syncService != null) {
        await _syncService!.syncTransfer(result);
      }

      Logger.info('Transfer received: ${result.transferNumber}');
      return result;
    } catch (e) {
      Logger.error('Error receiving transfer: $e');
      rethrow;
    }
  }

  /// Cancels a transfer
  Future<StockTransfer> cancelTransfer({
    required String transferId,
    required String cancelledBy,
    String? reason,
  }) async {
    try {
      final transfer = await _transferRepository.getTransferById(transferId);
      if (transfer == null) {
        throw Exception('Transfer not found');
      }

      if (transfer.status == 'completed' || transfer.status == 'cancelled') {
        throw Exception('Cannot cancel ${transfer.status} transfer');
      }

      // If in_transit, need to reverse outgoing movements
      if (transfer.status == 'in_transit') {
        await _reverseOutgoingMovements(transfer);
      }

      final updatedTransfer = transfer.copyWith(
        status: 'cancelled',
        notes: '${transfer.notes ?? ''}\nCancelled by $cancelledBy: ${reason ?? 'No reason provided'}',
        updatedAt: DateTime.now(),
      );

      final result = await _transferRepository.updateTransfer(updatedTransfer);

      // Sync if available
      if (_syncService != null) {
        await _syncService!.syncTransfer(result);
      }

      Logger.info('Transfer cancelled: ${result.transferNumber}');
      return result;
    } catch (e) {
      Logger.error('Error cancelling transfer: $e');
      rethrow;
    }
  }

  /// Gets pending transfers for a branch
  Future<List<StockTransfer>> getPendingTransfers(String branchId) async {
    try {
      return await _transferRepository.getPendingTransfers(branchId);
    } catch (e) {
      Logger.error('Error getting pending transfers: $e');
      rethrow;
    }
  }

  /// Gets transfer history
  Future<List<StockTransfer>> getTransferHistory({
    String? branchId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      List<StockTransfer> transfers;
      
      if (branchId != null) {
        transfers = await _transferRepository.getTransfersByBranch(branchId);
      } else {
        transfers = await _transferRepository.getAllTransfers();
      }

      // Filter by date if provided
      if (startDate != null || endDate != null) {
        transfers = transfers.where((t) {
          if (startDate != null && t.createdAt.isBefore(startDate)) return false;
          if (endDate != null && t.createdAt.isAfter(endDate)) return false;
          return true;
        }).toList();
      }

      return transfers;
    } catch (e) {
      Logger.error('Error getting transfer history: $e');
      rethrow;
    }
  }

  /// Watches transfers for a branch
  Stream<List<StockTransfer>> watchTransfers(String branchId) {
    return _transferRepository.watchTransfersByBranch(branchId);
  }

  /// Validates stock availability
  Future<void> _validateStockAvailability(
    String branchId,
    List<StockTransferItem> items,
  ) async {
    for (final item in items) {
      final stock = await _movementRepository.getProductStock(
        item.productId,
        branchId,
      );

      if (stock < item.quantity) {
        final product = await _productRepository.getProductById(item.productId);
        throw Exception(
          'Insufficient stock for ${product?.name ?? item.productId}. '
          'Available: $stock, Requested: ${item.quantity}',
        );
      }
    }
  }

  /// Creates outgoing inventory movements
  Future<void> _createOutgoingMovements(StockTransfer transfer) async {
    for (final item in transfer.items) {
      final movement = InventoryMovement(
        id: IdGenerator.generateId(),
        organizationId: transfer.organizationId,
        branchId: transfer.fromBranchId,
        productId: item.productId,
        movementType: 'transfer_out',
        quantity: item.quantity,
        unitCost: 0, // Will be calculated based on FIFO/LIFO
        totalCost: 0,
        referenceType: 'stock_transfer',
        referenceId: transfer.id,
        performedBy: transfer.initiatedBy,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        syncStatus: 'pending',
      );

      await _movementRepository.createMovement(movement);
    }
  }

  /// Creates incoming inventory movements
  Future<void> _createIncomingMovements(StockTransfer transfer) async {
    for (final item in transfer.items) {
      final quantity = item.receivedQuantity ?? item.quantity;
      
      final movement = InventoryMovement(
        id: IdGenerator.generateId(),
        organizationId: transfer.organizationId,
        branchId: transfer.toBranchId,
        productId: item.productId,
        movementType: 'transfer_in',
        quantity: quantity,
        unitCost: 0, // Will be calculated based on transfer cost
        totalCost: 0,
        referenceType: 'stock_transfer',
        referenceId: transfer.id,
        performedBy: transfer.receivedBy ?? transfer.initiatedBy,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        syncStatus: 'pending',
      );

      await _movementRepository.createMovement(movement);
    }
  }

  /// Reverses outgoing movements when cancelling
  Future<void> _reverseOutgoingMovements(StockTransfer transfer) async {
    for (final item in transfer.items) {
      final movement = InventoryMovement(
        id: IdGenerator.generateId(),
        organizationId: transfer.organizationId,
        branchId: transfer.fromBranchId,
        productId: item.productId,
        movementType: 'transfer_in',
        quantity: item.quantity,
        unitCost: 0,
        totalCost: 0,
        referenceType: 'stock_transfer_reversal',
        referenceId: transfer.id,
        notes: 'Reversal for cancelled transfer ${transfer.transferNumber}',
        performedBy: transfer.initiatedBy,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        syncStatus: 'pending',
      );

      await _movementRepository.createMovement(movement);
    }
  }

  /// Generates a unique transfer number
  String _generateTransferNumber() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    return 'ST-${timestamp.substring(timestamp.length - 8)}';
  }

  void dispose() {
    _transferRepository.dispose();
  }
}