import 'dart:async';
import '../../domain/entities/purchase_order.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/purchase_order_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/inventory_movement_repository.dart';
import '../../core/utils/logger.dart';
import '../sync/sync_service.dart';

/// Service for managing purchase orders
class PurchaseOrderService {
  final PurchaseOrderRepository _orderRepository;
  final ProductRepository _productRepository;
  final InventoryMovementRepository _movementRepository;
  final SyncService? _syncService;
  
  PurchaseOrderService({
    required PurchaseOrderRepository orderRepository,
    required ProductRepository productRepository,
    required InventoryMovementRepository movementRepository,
    SyncService? syncService,
  })  : _orderRepository = orderRepository,
        _productRepository = productRepository,
        _movementRepository = movementRepository,
        _syncService = syncService;
  
  /// Create a new purchase order
  Future<PurchaseOrder> createPurchaseOrder({
    required String organizationId,
    required String branchId,
    required String supplierId,
    required List<PurchaseOrderItem> items,
    DateTime? expectedDelivery,
    String? notes,
  }) async {
    try {
      // Calculate totals
      double subtotal = 0;
      double totalTax = 0;
      
      for (final item in items) {
        subtotal += item.quantity * item.unitCost;
        totalTax += item.taxAmount ?? 0;
      }
      
      final order = PurchaseOrder(
        id: _generateOrderId(),
        organizationId: organizationId,
        branchId: branchId,
        supplierId: supplierId,
        orderNumber: _generateOrderNumber(),
        status: PurchaseOrderStatus.draft,
        orderDate: DateTime.now(),
        expectedDelivery: expectedDelivery,
        items: items,
        subtotal: subtotal,
        taxAmount: totalTax,
        totalAmount: subtotal + totalTax,
        notes: notes,
        createdAt: DateTime.now(),
        syncedAt: null,
      );
      
      final created = await _orderRepository.create(order);
      
      if (_syncService != null) {
        await _syncService.addToSyncQueue(
          tableName: 'purchase_orders',
          operation: 'create',
          recordId: created.id,
          data: created.toJson(),
        );
      }
      
      Logger.info('Purchase order created: ${created.id}');
      return created;
    } catch (e) {
      Logger.error('Failed to create purchase order', error: e);
      rethrow;
    }
  }
  
  /// Submit purchase order
  Future<PurchaseOrder> submitOrder(String orderId) async {
    try {
      final order = await _orderRepository.getById(orderId);
      if (order == null) throw Exception('Order not found');
      
      if (order.status != PurchaseOrderStatus.draft) {
        throw Exception('Only draft orders can be submitted');
      }
      
      final updated = order.copyWith(
        status: PurchaseOrderStatus.ordered,
        submittedAt: DateTime.now(),
      );
      
      await _orderRepository.update(updated);
      
      Logger.info('Purchase order submitted: $orderId');
      return updated;
    } catch (e) {
      Logger.error('Failed to submit order', error: e);
      rethrow;
    }
  }
  
  /// Receive items for purchase order
  Future<PurchaseOrder> receiveItems({
    required String orderId,
    required List<ReceivedItem> receivedItems,
    String? receivedBy,
    String? notes,
  }) async {
    try {
      final order = await _orderRepository.getById(orderId);
      if (order == null) throw Exception('Order not found');
      
      if (order.status != PurchaseOrderStatus.ordered) {
        throw Exception('Can only receive items for ordered status');
      }
      
      // Create inventory movements
      for (final received in receivedItems) {
        await _movementRepository.create(received.toInventoryMovement(
          organizationId: order.organizationId,
          branchId: order.branchId,
          purchaseOrderId: orderId,
          performedBy: receivedBy,
        ));
      }
      
      // Update order status
      final allReceived = _checkAllItemsReceived(order, receivedItems);
      final updated = order.copyWith(
        status: allReceived 
            ? PurchaseOrderStatus.received 
            : PurchaseOrderStatus.partiallyReceived,
        receivedAt: DateTime.now(),
      );
      
      await _orderRepository.update(updated);
      
      Logger.info('Items received for order: $orderId');
      return updated;
    } catch (e) {
      Logger.error('Failed to receive items', error: e);
      rethrow;
    }
  }
  
  /// Cancel purchase order
  Future<void> cancelOrder(String orderId, String reason) async {
    try {
      final order = await _orderRepository.getById(orderId);
      if (order == null) throw Exception('Order not found');
      
      if (order.status == PurchaseOrderStatus.received ||
          order.status == PurchaseOrderStatus.cancelled) {
        throw Exception('Cannot cancel order with status: ${order.status}');
      }
      
      await _orderRepository.update(order.copyWith(
        status: PurchaseOrderStatus.cancelled,
        notes: '${order.notes ?? ''}\nCancelled: $reason',
      ));
      
      Logger.info('Purchase order cancelled: $orderId');
    } catch (e) {
      Logger.error('Failed to cancel order', error: e);
      rethrow;
    }
  }
  
  String _generateOrderId() => 'PO${DateTime.now().millisecondsSinceEpoch}';
  
  String _generateOrderNumber() => 'PO-${DateTime.now().millisecondsSinceEpoch}';
  
  bool _checkAllItemsReceived(
    PurchaseOrder order, 
    List<ReceivedItem> receivedItems,
  ) {
    // Implementation would check if all items are fully received
    return receivedItems.length == order.items.length;
  }
}

/// Represents a received item
class ReceivedItem {
  final String productId;
  final double quantity;
  final double unitCost;
  final String? batchId;
  final String? notes;
  
  ReceivedItem({
    required this.productId,
    required this.quantity,
    required this.unitCost,
    this.batchId,
    this.notes,
  });
  
  dynamic toInventoryMovement({
    required String organizationId,
    required String branchId,
    required String purchaseOrderId,
    String? performedBy,
  }) {
    // Would create inventory movement entity
    return {};
  }
}