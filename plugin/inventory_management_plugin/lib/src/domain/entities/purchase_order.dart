import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_order.freezed.dart';
part 'purchase_order.g.dart';

enum PurchaseOrderStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('sent')
  sent,
  @JsonValue('partial')
  partial,
  @JsonValue('received')
  received,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('overdue')
  overdue,
}

@freezed
class PurchaseOrder with _$PurchaseOrder {
  const factory PurchaseOrder({
    required String id,
    required String organizationId,
    required String supplierId,
    required String poNumber,
    required DateTime orderDate,
    DateTime? expectedDate,
    required PurchaseOrderStatus status,
    @Default(0) double totalAmount,
    @Default(0) double taxAmount,
    @Default(0) double discountAmount,
    @Default(0) double shippingAmount,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String createdBy,
    @Default([]) List<PurchaseOrderItem> items,
    DateTime? syncedAt,
    
    // Additional fields
    String? branchId,
    String? warehouseId,
    String? paymentTerms,
    String? shippingAddress,
    String? billingAddress,
    String? approvedBy,
    DateTime? approvedAt,
    String? receivedBy,
    DateTime? receivedAt,
    @Default({}) Map<String, dynamic> metadata,
    @Default({}) Map<String, dynamic> customFields,
    String? currency,
    double? exchangeRate,
  }) = _PurchaseOrder;
  
  const PurchaseOrder._();
  
  factory PurchaseOrder.fromJson(Map<String, dynamic> json) => 
      _$PurchaseOrderFromJson(json);
  
  // Helper methods
  double get subtotal => items.fold(0, (sum, item) => sum + item.subtotal);
  double get netAmount => subtotal - discountAmount;
  double get grandTotal => netAmount + taxAmount + shippingAmount;
  
  bool get isDraft => status == PurchaseOrderStatus.draft;
  bool get isSent => status == PurchaseOrderStatus.sent;
  bool get isPartiallyReceived => status == PurchaseOrderStatus.partial;
  bool get isFullyReceived => status == PurchaseOrderStatus.received;
  bool get isCancelled => status == PurchaseOrderStatus.cancelled;
  bool get isOverdue => status == PurchaseOrderStatus.overdue || 
      (expectedDate != null && expectedDate!.isBefore(DateTime.now()) && !isFullyReceived);
  
  bool get canEdit => isDraft;
  bool get canSend => isDraft;
  bool get canReceive => isSent || isPartiallyReceived;
  bool get canCancel => !isFullyReceived && !isCancelled;
  bool get canApprove => isDraft && approvedAt == null;
  
  double get totalReceivedQuantity => 
      items.fold(0, (sum, item) => sum + item.receivedQuantity);
      
  double get totalOrderedQuantity => 
      items.fold(0, (sum, item) => sum + item.quantity);
      
  double get receivePercentage {
    if (totalOrderedQuantity == 0) return 0;
    return (totalReceivedQuantity / totalOrderedQuantity) * 100;
  }
  
  int get daysOverdue {
    if (expectedDate == null || isFullyReceived) return 0;
    final diff = DateTime.now().difference(expectedDate!).inDays;
    return diff > 0 ? diff : 0;
  }
  
  String get statusDisplayName {
    switch (status) {
      case PurchaseOrderStatus.draft:
        return 'Draft';
      case PurchaseOrderStatus.sent:
        return 'Sent';
      case PurchaseOrderStatus.partial:
        return 'Partially Received';
      case PurchaseOrderStatus.received:
        return 'Received';
      case PurchaseOrderStatus.cancelled:
        return 'Cancelled';
      case PurchaseOrderStatus.overdue:
        return 'Overdue';
    }
  }
}

@freezed
class PurchaseOrderItem with _$PurchaseOrderItem {
  const factory PurchaseOrderItem({
    required String id,
    required String purchaseOrderId,
    required String productId,
    required double quantity,
    @Default(0) double receivedQuantity,
    required double unitPrice,
    @Default(0) double taxRate,
    @Default(0) double discountRate,
    @Default(0) double discountAmount,
    required DateTime createdAt,
    
    // Additional fields
    String? productName,
    String? productSku,
    String? unit,
    String? notes,
    String? batchNumber,
    DateTime? expiryDate,
    @Default({}) Map<String, dynamic> metadata,
  }) = _PurchaseOrderItem;
  
  const PurchaseOrderItem._();
  
  factory PurchaseOrderItem.fromJson(Map<String, dynamic> json) => 
      _$PurchaseOrderItemFromJson(json);
  
  // Helper methods
  double get subtotal => quantity * unitPrice;
  double get totalDiscountAmount => discountAmount + (subtotal * (discountRate / 100));
  double get taxableAmount => subtotal - totalDiscountAmount;
  double get taxAmount => taxableAmount * (taxRate / 100);
  double get totalAmount => taxableAmount + taxAmount;
  
  double get remainingQuantity => quantity - receivedQuantity;
  bool get isFullyReceived => receivedQuantity >= quantity;
  bool get isPartiallyReceived => receivedQuantity > 0 && receivedQuantity < quantity;
  bool get isNotReceived => receivedQuantity == 0;
  
  double get receivePercentage => 
      quantity > 0 ? (receivedQuantity / quantity) * 100 : 0;
      
  double get receivedValue => receivedQuantity * unitPrice;
  double get remainingValue => remainingQuantity * unitPrice;
}