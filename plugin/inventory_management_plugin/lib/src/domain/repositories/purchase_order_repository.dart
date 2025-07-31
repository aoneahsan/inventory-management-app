import '../entities/purchase_order.dart';
import '../entities/purchase_order_item.dart';
import '../entities/inventory_movement.dart';
import 'base_repository.dart';

/// Repository interface for PurchaseOrder entity
abstract class PurchaseOrderRepository extends BaseRepository<PurchaseOrder> {
  /// Get purchase order by PO number
  Future<PurchaseOrder?> getByPoNumber(String poNumber, {String? organizationId});
  
  /// Get purchase orders by supplier
  Future<List<PurchaseOrder>> getBySupplier(String supplierId, {
    DateTime? startDate,
    DateTime? endDate,
    PurchaseOrderStatus? status,
  });
  
  /// Get purchase orders by branch
  Future<List<PurchaseOrder>> getByBranch(String branchId, {
    DateTime? startDate,
    DateTime? endDate,
    PurchaseOrderStatus? status,
  });
  
  /// Get purchase orders by status
  Future<List<PurchaseOrder>> getByStatus(PurchaseOrderStatus status, {
    String? organizationId,
    String? branchId,
  });
  
  /// Get purchase order items
  Future<List<PurchaseOrderItem>> getPurchaseOrderItems(String purchaseOrderId);
  
  /// Create purchase order with items
  Future<PurchaseOrder> createWithItems(
    PurchaseOrder purchaseOrder,
    List<PurchaseOrderItem> items,
  );
  
  /// Update purchase order status
  Future<PurchaseOrder> updateStatus(
    String purchaseOrderId,
    PurchaseOrderStatus status, {
    String? updatedBy,
  });
  
  /// Approve purchase order
  Future<PurchaseOrder> approve(String purchaseOrderId, String approvedBy);
  
  /// Reject purchase order
  Future<PurchaseOrder> reject(String purchaseOrderId, String rejectedBy, String reason);
  
  /// Cancel purchase order
  Future<PurchaseOrder> cancel(String purchaseOrderId, String cancelledBy, String reason);
  
  /// Receive purchase order items
  Future<PurchaseOrder> receiveItems({
    required String purchaseOrderId,
    required List<ReceivedItem> items,
    required String receivedBy,
    String? notes,
  });
  
  /// Partial receive
  Future<PurchaseOrder> partialReceive({
    required String purchaseOrderId,
    required List<ReceivedItem> items,
    required String receivedBy,
    String? notes,
  });
  
  /// Get pending purchase orders
  Future<List<PurchaseOrder>> getPendingOrders({
    String? organizationId,
    String? supplierId,
    String? branchId,
  });
  
  /// Get overdue purchase orders
  Future<List<PurchaseOrder>> getOverdueOrders({
    String? organizationId,
    DateTime? asOfDate,
  });
  
  /// Get purchase order summary
  Future<PurchaseOrderSummary> getSummary({
    String? organizationId,
    String? branchId,
    DateTime? startDate,
    DateTime? endDate,
  });
  
  /// Generate goods receipt note
  Future<GoodsReceiptNote> generateGRN(String purchaseOrderId);
  
  /// Get supplier performance
  Future<SupplierPerformance> getSupplierPerformance(
    String supplierId, {
    DateTime? startDate,
    DateTime? endDate,
  });
}