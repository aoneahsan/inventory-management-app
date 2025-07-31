import '../entities/inventory_movement.dart';
import 'base_repository.dart';

/// Repository interface for InventoryMovement entity
abstract class InventoryMovementRepository extends BaseRepository<InventoryMovement> {
  /// Get movements by product
  Future<List<InventoryMovement>> getByProduct(String productId, {
    String? branchId,
    DateTime? startDate,
    DateTime? endDate,
    MovementType? type,
  });
  
  /// Get movements by branch
  Future<List<InventoryMovement>> getByBranch(String branchId, {
    DateTime? startDate,
    DateTime? endDate,
    MovementType? type,
  });
  
  /// Get movements by type
  Future<List<InventoryMovement>> getByType(MovementType type, {
    String? organizationId,
    String? branchId,
    DateTime? startDate,
    DateTime? endDate,
  });
  
  /// Get movements by reference
  Future<List<InventoryMovement>> getByReference({
    required ReferenceType referenceType,
    required String referenceId,
  });
  
  /// Get movements by batch
  Future<List<InventoryMovement>> getByBatch(String batchId);
  
  /// Get movements by serial number
  Future<List<InventoryMovement>> getBySerialNumber(String serialNumber);
  
  /// Create adjustment
  Future<InventoryMovement> createAdjustment({
    required String productId,
    required String branchId,
    required double quantity,
    required String reason,
    String? batchId,
    String? serialNumber,
    String? performedBy,
  });
  
  /// Create transfer movement
  Future<List<InventoryMovement>> createTransfer({
    required String productId,
    required String fromBranchId,
    required String toBranchId,
    required double quantity,
    required String transferId,
    String? batchId,
    String? serialNumber,
    String? performedBy,
  });
  
  /// Get stock balance
  Future<double> getStockBalance({
    required String productId,
    required String branchId,
    DateTime? asOfDate,
  });
  
  /// Get stock movement summary
  Future<StockMovementSummary> getMovementSummary({
    String? productId,
    String? branchId,
    required DateTime startDate,
    required DateTime endDate,
  });
  
  /// Get stock valuation
  Future<StockValuation> getStockValuation({
    String? productId,
    String? branchId,
    DateTime? asOfDate,
  });
  
  /// Recalculate stock balance
  Future<void> recalculateBalance({
    required String productId,
    required String branchId,
  });
}