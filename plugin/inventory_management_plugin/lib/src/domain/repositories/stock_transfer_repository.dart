import '../entities/stock_transfer.dart';
import '../entities/stock_transfer_item.dart';
import 'base_repository.dart';

/// Repository interface for StockTransfer entity
abstract class StockTransferRepository extends BaseRepository<StockTransfer> {
  /// Get transfer by transfer number
  Future<StockTransfer?> getByTransferNumber(String transferNumber, {String? organizationId});
  
  /// Get transfers by source branch
  Future<List<StockTransfer>> getBySourceBranch(String branchId, {
    DateTime? startDate,
    DateTime? endDate,
    StockTransferStatus? status,
  });
  
  /// Get transfers by destination branch
  Future<List<StockTransfer>> getByDestinationBranch(String branchId, {
    DateTime? startDate,
    DateTime? endDate,
    StockTransferStatus? status,
  });
  
  /// Get transfers by status
  Future<List<StockTransfer>> getByStatus(StockTransferStatus status, {
    String? organizationId,
    String? branchId,
  });
  
  /// Get transfer items
  Future<List<StockTransferItem>> getTransferItems(String transferId);
  
  /// Create transfer with items
  Future<StockTransfer> createWithItems(
    StockTransfer transfer,
    List<StockTransferItem> items,
  );
  
  /// Update transfer status
  Future<StockTransfer> updateStatus(
    String transferId,
    StockTransferStatus status, {
    String? updatedBy,
  });
  
  /// Approve transfer
  Future<StockTransfer> approve(String transferId, String approvedBy);
  
  /// Reject transfer
  Future<StockTransfer> reject(
    String transferId,
    String rejectedBy,
    String reason,
  );
  
  /// Ship transfer
  Future<StockTransfer> ship(
    String transferId,
    String shippedBy, {
    String? trackingNumber,
    String? shippingMethod,
    double? shippingCost,
  });
  
  /// Receive transfer
  Future<StockTransfer> receive(
    String transferId,
    String receivedBy, {
    List<ReceivedTransferItem>? receivedItems,
    String? notes,
  });
  
  /// Cancel transfer
  Future<StockTransfer> cancel(
    String transferId,
    String cancelledBy,
    String reason,
  );
  
  /// Get pending transfers
  Future<List<StockTransfer>> getPendingTransfers({
    String? organizationId,
    String? branchId,
  });
  
  /// Get in-transit transfers
  Future<List<StockTransfer>> getInTransitTransfers({
    String? organizationId,
    String? branchId,
  });
  
  /// Get overdue transfers
  Future<List<StockTransfer>> getOverdueTransfers({
    String? organizationId,
    DateTime? asOfDate,
  });
  
  /// Get transfer summary
  Future<TransferSummary> getSummary({
    String? organizationId,
    String? branchId,
    DateTime? startDate,
    DateTime? endDate,
  });
  
  /// Get transfer route analysis
  Future<List<TransferRoute>> getRouteAnalysis({
    String? organizationId,
    DateTime? startDate,
    DateTime? endDate,
  });
}