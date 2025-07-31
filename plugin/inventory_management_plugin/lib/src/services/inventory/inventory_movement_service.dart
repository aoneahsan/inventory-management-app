import 'dart:async';
import '../../domain/entities/inventory_movement.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/inventory_movement_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/value_objects/repository_types.dart';
import '../../core/utils/logger.dart';
import '../sync/sync_service.dart';

/// Service for managing inventory movements
class InventoryMovementService {
  final InventoryMovementRepository _movementRepository;
  final ProductRepository _productRepository;
  final SyncService? _syncService;
  final _movementStreamController = StreamController<List<InventoryMovement>>.broadcast();
  
  InventoryMovementService({
    required InventoryMovementRepository movementRepository,
    required ProductRepository productRepository,
    SyncService? syncService,
  })  : _movementRepository = movementRepository,
        _productRepository = productRepository,
        _syncService = syncService;
  
  Stream<List<InventoryMovement>> get movementsStream => _movementStreamController.stream;
  
  /// Create a purchase movement (stock in)
  Future<InventoryMovement> createPurchaseMovement({
    required String organizationId,
    required String branchId,
    required String productId,
    required double quantity,
    required double unitCost,
    required String purchaseOrderId,
    String? batchId,
    String? notes,
    String? performedBy,
  }) async {
    try {
      final movement = InventoryMovement(
        id: _generateMovementId(),
        organizationId: organizationId,
        branchId: branchId,
        productId: productId,
        movementType: MovementType.purchase,
        quantity: quantity,
        unitCost: unitCost,
        referenceType: ReferenceType.purchaseOrder,
        referenceId: purchaseOrderId,
        batchId: batchId,
        notes: notes,
        performedBy: performedBy,
        createdAt: DateTime.now(),
        syncedAt: null,
      );
      
      final created = await _movementRepository.create(movement);
      
      // Add to sync queue
      if (_syncService != null) {
        await _syncService.addToSyncQueue(
          tableName: 'inventory_movements',
          operation: 'create',
          recordId: created.id,
          data: created.toJson(),
        );
      }
      
      Logger.info('Purchase movement created: ${created.id}');
      await _refreshMovementStream(branchId: branchId);
      
      return created;
    } catch (e) {
      Logger.error('Failed to create purchase movement', error: e);
      rethrow;
    }
  }
  
  /// Create a sale movement (stock out)
  Future<InventoryMovement> createSaleMovement({
    required String organizationId,
    required String branchId,
    required String productId,
    required double quantity,
    required String saleId,
    double? unitCost,
    String? batchId,
    String? serialNumber,
    String? notes,
    String? performedBy,
  }) async {
    try {
      // Verify stock availability
      final available = await checkStockAvailability(
        productId: productId,
        branchId: branchId,
        quantity: quantity,
      );
      
      if (!available) {
        throw Exception('Insufficient stock for product: $productId');
      }
      
      final movement = InventoryMovement(
        id: _generateMovementId(),
        organizationId: organizationId,
        branchId: branchId,
        productId: productId,
        movementType: MovementType.sale,
        quantity: -quantity, // Negative for stock out
        unitCost: unitCost,
        referenceType: ReferenceType.sale,
        referenceId: saleId,
        batchId: batchId,
        serialNumber: serialNumber,
        notes: notes,
        performedBy: performedBy,
        createdAt: DateTime.now(),
        syncedAt: null,
      );
      
      final created = await _movementRepository.create(movement);
      
      // Add to sync queue
      if (_syncService != null) {
        await _syncService.addToSyncQueue(
          tableName: 'inventory_movements',
          operation: 'create',
          recordId: created.id,
          data: created.toJson(),
        );
      }
      
      Logger.info('Sale movement created: ${created.id}');
      await _refreshMovementStream(branchId: branchId);
      
      return created;
    } catch (e) {
      Logger.error('Failed to create sale movement', error: e);
      rethrow;
    }
  }
  
  /// Create an adjustment movement
  Future<InventoryMovement> createAdjustment({
    required String organizationId,
    required String branchId,
    required String productId,
    required double quantity,
    required String reason,
    double? unitCost,
    String? batchId,
    String? serialNumber,
    String? performedBy,
  }) async {
    try {
      final movement = await _movementRepository.createAdjustment(
        productId: productId,
        branchId: branchId,
        quantity: quantity,
        reason: reason,
        batchId: batchId,
        serialNumber: serialNumber,
        performedBy: performedBy,
      );
      
      // Add to sync queue
      if (_syncService != null) {
        await _syncService.addToSyncQueue(
          tableName: 'inventory_movements',
          operation: 'create',
          recordId: movement.id,
          data: movement.toJson(),
        );
      }
      
      Logger.info('Adjustment created: ${movement.id}');
      await _refreshMovementStream(branchId: branchId);
      
      return movement;
    } catch (e) {
      Logger.error('Failed to create adjustment', error: e);
      rethrow;
    }
  }
  
  /// Create transfer movements between branches
  Future<List<InventoryMovement>> createTransfer({
    required String organizationId,
    required String fromBranchId,
    required String toBranchId,
    required String productId,
    required double quantity,
    required String transferId,
    double? unitCost,
    String? batchId,
    String? serialNumber,
    String? performedBy,
  }) async {
    try {
      // Verify stock availability
      final available = await checkStockAvailability(
        productId: productId,
        branchId: fromBranchId,
        quantity: quantity,
      );
      
      if (!available) {
        throw Exception('Insufficient stock for transfer');
      }
      
      final movements = await _movementRepository.createTransfer(
        productId: productId,
        fromBranchId: fromBranchId,
        toBranchId: toBranchId,
        quantity: quantity,
        transferId: transferId,
        batchId: batchId,
        serialNumber: serialNumber,
        performedBy: performedBy,
      );
      
      // Add to sync queue
      if (_syncService != null) {
        for (final movement in movements) {
          await _syncService.addToSyncQueue(
            tableName: 'inventory_movements',
            operation: 'create',
            recordId: movement.id,
            data: movement.toJson(),
          );
        }
      }
      
      Logger.info('Transfer movements created: ${movements.map((m) => m.id).join(', ')}');
      await _refreshMovementStream(branchId: fromBranchId);
      await _refreshMovementStream(branchId: toBranchId);
      
      return movements;
    } catch (e) {
      Logger.error('Failed to create transfer movements', error: e);
      rethrow;
    }
  }
  
  /// Get movements by product
  Future<List<InventoryMovement>> getProductMovements(
    String productId, {
    String? branchId,
    DateTime? startDate,
    DateTime? endDate,
    MovementType? type,
  }) async {
    try {
      return await _movementRepository.getByProduct(
        productId,
        branchId: branchId,
        startDate: startDate,
        endDate: endDate,
        type: type,
      );
    } catch (e) {
      Logger.error('Failed to get product movements', error: e);
      rethrow;
    }
  }
  
  /// Get movements by branch
  Future<List<InventoryMovement>> getBranchMovements(
    String branchId, {
    DateTime? startDate,
    DateTime? endDate,
    MovementType? type,
  }) async {
    try {
      return await _movementRepository.getByBranch(
        branchId,
        startDate: startDate,
        endDate: endDate,
        type: type,
      );
    } catch (e) {
      Logger.error('Failed to get branch movements', error: e);
      rethrow;
    }
  }
  
  /// Get stock balance for a product at a branch
  Future<double> getStockBalance({
    required String productId,
    required String branchId,
    DateTime? asOfDate,
  }) async {
    try {
      return await _movementRepository.getStockBalance(
        productId: productId,
        branchId: branchId,
        asOfDate: asOfDate,
      );
    } catch (e) {
      Logger.error('Failed to get stock balance', error: e);
      rethrow;
    }
  }
  
  /// Check stock availability
  Future<bool> checkStockAvailability({
    required String productId,
    required String branchId,
    required double quantity,
  }) async {
    try {
      final balance = await getStockBalance(
        productId: productId,
        branchId: branchId,
      );
      
      return balance >= quantity;
    } catch (e) {
      Logger.error('Failed to check stock availability', error: e);
      return false;
    }
  }
  
  /// Get stock movement summary
  Future<StockMovementSummary> getMovementSummary({
    String? productId,
    String? branchId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      return await _movementRepository.getMovementSummary(
        productId: productId,
        branchId: branchId,
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      Logger.error('Failed to get movement summary', error: e);
      rethrow;
    }
  }
  
  /// Get stock valuation
  Future<StockValuation> getStockValuation({
    String? productId,
    String? branchId,
    DateTime? asOfDate,
  }) async {
    try {
      return await _movementRepository.getStockValuation(
        productId: productId,
        branchId: branchId,
        asOfDate: asOfDate,
      );
    } catch (e) {
      Logger.error('Failed to get stock valuation', error: e);
      rethrow;
    }
  }
  
  /// Recalculate stock balance
  Future<void> recalculateBalance({
    required String productId,
    required String branchId,
  }) async {
    try {
      await _movementRepository.recalculateBalance(
        productId: productId,
        branchId: branchId,
      );
      
      Logger.info('Stock balance recalculated for product: $productId, branch: $branchId');
      await _refreshMovementStream(branchId: branchId);
    } catch (e) {
      Logger.error('Failed to recalculate stock balance', error: e);
      rethrow;
    }
  }
  
  /// Perform stock take
  Future<InventoryMovement> performStockTake({
    required String organizationId,
    required String branchId,
    required String productId,
    required double countedQuantity,
    required String performedBy,
    String? notes,
  }) async {
    try {
      // Get current balance
      final currentBalance = await getStockBalance(
        productId: productId,
        branchId: branchId,
      );
      
      final difference = countedQuantity - currentBalance;
      
      if (difference == 0) {
        Logger.info('Stock take: No adjustment needed for product $productId');
        throw Exception('No adjustment needed - counted quantity matches system quantity');
      }
      
      // Create adjustment
      final reason = difference > 0
          ? 'Stock take - excess found'
          : 'Stock take - shortage found';
      
      final fullNotes = notes != null
          ? '$reason. $notes'
          : reason;
      
      return await createAdjustment(
        organizationId: organizationId,
        branchId: branchId,
        productId: productId,
        quantity: difference,
        reason: fullNotes,
        performedBy: performedBy,
      );
    } catch (e) {
      Logger.error('Failed to perform stock take', error: e);
      rethrow;
    }
  }
  
  /// Get low stock products
  Future<List<Product>> getLowStockProducts({
    String? organizationId,
    String? branchId,
  }) async {
    try {
      final products = await _productRepository.getLowStockProducts(
        organizationId: organizationId,
      );
      
      if (branchId != null) {
        // Filter by branch stock levels
        final productsWithStock = <Product>[];
        
        for (final product in products) {
          final balance = await getStockBalance(
            productId: product.id,
            branchId: branchId,
          );
          
          if (balance <= product.reorderPoint) {
            productsWithStock.add(product);
          }
        }
        
        return productsWithStock;
      }
      
      return products;
    } catch (e) {
      Logger.error('Failed to get low stock products', error: e);
      rethrow;
    }
  }
  
  /// Generate movement ID
  String _generateMovementId() {
    return 'MOV${DateTime.now().millisecondsSinceEpoch}';
  }
  
  /// Refresh movement stream
  Future<void> _refreshMovementStream({String? branchId}) async {
    try {
      final movements = branchId != null
          ? await getBranchMovements(branchId)
          : await _movementRepository.getAll();
      
      _movementStreamController.add(movements);
    } catch (e) {
      Logger.error('Failed to refresh movement stream', error: e);
    }
  }
  
  /// Dispose resources
  void dispose() {
    _movementStreamController.close();
  }
}