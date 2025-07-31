import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_order_item.freezed.dart';
part 'purchase_order_item.g.dart';

/// Purchase order item entity
@freezed
class PurchaseOrderItem with _$PurchaseOrderItem {
  const factory PurchaseOrderItem({
    required String id,
    required String purchaseOrderId,
    required String productId,
    required double quantity,
    required double unitPrice,
    required double subtotal,
    @Default(0) double taxAmount,
    @Default(0) double discountAmount,
    required double totalAmount,
    double? receivedQuantity,
    DateTime? receivedDate,
    String? batchNumber,
    DateTime? expiryDate,
    String? notes,
    required DateTime createdAt,
  }) = _PurchaseOrderItem;

  factory PurchaseOrderItem.fromJson(Map<String, dynamic> json) =>
      _$PurchaseOrderItemFromJson(json);
}