import '../entities/batch.dart';
import '../entities/inventory_movement.dart';
import 'base_repository.dart';

/// Repository interface for Batch entity
abstract class BatchRepository extends BaseRepository<Batch> {
  /// Get batch by batch number
  Future<Batch?> getByBatchNumber(String batchNumber, {String? organizationId});
  
  /// Get batches by product
  Future<List<Batch>> getByProduct(String productId, {
    String? branchId,
    BatchStatus? status,
  });
  
  /// Get batches by supplier
  Future<List<Batch>> getBySupplier(String supplierId, {
    String? productId,
    BatchStatus? status,
  });
  
  /// Get batches by status
  Future<List<Batch>> getByStatus(BatchStatus status, {
    String? organizationId,
    String? productId,
  });
  
  /// Get expiring batches
  Future<List<Batch>> getExpiringBatches({
    String? organizationId,
    String? branchId,
    int daysBeforeExpiry = 30,
  });
  
  /// Get expired batches
  Future<List<Batch>> getExpiredBatches({
    String? organizationId,
    String? branchId,
  });
  
  /// Get available batches for product
  Future<List<Batch>> getAvailableBatches(String productId, {
    String? branchId,
    bool includeExpired = false,
  });
  
  /// Update batch quantity
  Future<void> updateQuantity(String batchId, double quantity);
  
  /// Allocate batch quantity
  Future<bool> allocateQuantity(String batchId, double quantity);
  
  /// Release batch allocation
  Future<void> releaseAllocation(String batchId, double quantity);
  
  /// Mark batch as recalled
  Future<Batch> recallBatch(
    String batchId, {
    required String reason,
    required String recalledBy,
  });
  
  /// Dispose batch
  Future<Batch> disposeBatch(
    String batchId, {
    required String reason,
    required String disposedBy,
  });
  
  /// Update quality check status
  Future<Batch> updateQualityStatus(
    String batchId, {
    required QualityCheckStatus status,
    required String checkedBy,
    String? notes,
  });
  
  /// Get batch movements
  Future<List<InventoryMovement>> getBatchMovements(String batchId, {
    DateTime? startDate,
    DateTime? endDate,
  });
  
  /// Get batch allocation
  Future<BatchAllocation> getBatchAllocation(String batchId);
  
  /// Get FIFO batches
  Future<List<Batch>> getFIFOBatches(String productId, {
    String? branchId,
    double requiredQuantity = 0,
  });
  
  /// Get LIFO batches
  Future<List<Batch>> getLIFOBatches(String productId, {
    String? branchId,
    double requiredQuantity = 0,
  });
  
  /// Get batch valuation
  Future<BatchValuation> getBatchValuation({
    String? productId,
    String? branchId,
    DateTime? asOfDate,
  });
}