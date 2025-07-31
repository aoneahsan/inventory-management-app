// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PurchaseOrderImpl _$$PurchaseOrderImplFromJson(Map<String, dynamic> json) =>
    _$PurchaseOrderImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      supplierId: json['supplierId'] as String,
      poNumber: json['poNumber'] as String,
      orderDate: DateTime.parse(json['orderDate'] as String),
      expectedDate: json['expectedDate'] == null
          ? null
          : DateTime.parse(json['expectedDate'] as String),
      status: $enumDecode(_$PurchaseOrderStatusEnumMap, json['status']),
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0,
      taxAmount: (json['taxAmount'] as num?)?.toDouble() ?? 0,
      discountAmount: (json['discountAmount'] as num?)?.toDouble() ?? 0,
      shippingAmount: (json['shippingAmount'] as num?)?.toDouble() ?? 0,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      createdBy: json['createdBy'] as String,
      items: (json['items'] as List<dynamic>?)
              ?.map(
                  (e) => PurchaseOrderItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      branchId: json['branchId'] as String?,
      warehouseId: json['warehouseId'] as String?,
      paymentTerms: json['paymentTerms'] as String?,
      shippingAddress: json['shippingAddress'] as String?,
      billingAddress: json['billingAddress'] as String?,
      approvedBy: json['approvedBy'] as String?,
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      receivedBy: json['receivedBy'] as String?,
      receivedAt: json['receivedAt'] == null
          ? null
          : DateTime.parse(json['receivedAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      customFields: json['customFields'] as Map<String, dynamic>? ?? const {},
      currency: json['currency'] as String?,
      exchangeRate: (json['exchangeRate'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$PurchaseOrderImplToJson(_$PurchaseOrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'supplierId': instance.supplierId,
      'poNumber': instance.poNumber,
      'orderDate': instance.orderDate.toIso8601String(),
      'expectedDate': instance.expectedDate?.toIso8601String(),
      'status': _$PurchaseOrderStatusEnumMap[instance.status]!,
      'totalAmount': instance.totalAmount,
      'taxAmount': instance.taxAmount,
      'discountAmount': instance.discountAmount,
      'shippingAmount': instance.shippingAmount,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'createdBy': instance.createdBy,
      'items': instance.items,
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'branchId': instance.branchId,
      'warehouseId': instance.warehouseId,
      'paymentTerms': instance.paymentTerms,
      'shippingAddress': instance.shippingAddress,
      'billingAddress': instance.billingAddress,
      'approvedBy': instance.approvedBy,
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'receivedBy': instance.receivedBy,
      'receivedAt': instance.receivedAt?.toIso8601String(),
      'metadata': instance.metadata,
      'customFields': instance.customFields,
      'currency': instance.currency,
      'exchangeRate': instance.exchangeRate,
    };

const _$PurchaseOrderStatusEnumMap = {
  PurchaseOrderStatus.draft: 'draft',
  PurchaseOrderStatus.sent: 'sent',
  PurchaseOrderStatus.partial: 'partial',
  PurchaseOrderStatus.received: 'received',
  PurchaseOrderStatus.cancelled: 'cancelled',
  PurchaseOrderStatus.overdue: 'overdue',
};

_$PurchaseOrderItemImpl _$$PurchaseOrderItemImplFromJson(
        Map<String, dynamic> json) =>
    _$PurchaseOrderItemImpl(
      id: json['id'] as String,
      purchaseOrderId: json['purchaseOrderId'] as String,
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      receivedQuantity: (json['receivedQuantity'] as num?)?.toDouble() ?? 0,
      unitPrice: (json['unitPrice'] as num).toDouble(),
      taxRate: (json['taxRate'] as num?)?.toDouble() ?? 0,
      discountRate: (json['discountRate'] as num?)?.toDouble() ?? 0,
      discountAmount: (json['discountAmount'] as num?)?.toDouble() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      productName: json['productName'] as String?,
      productSku: json['productSku'] as String?,
      unit: json['unit'] as String?,
      notes: json['notes'] as String?,
      batchNumber: json['batchNumber'] as String?,
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$PurchaseOrderItemImplToJson(
        _$PurchaseOrderItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'purchaseOrderId': instance.purchaseOrderId,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'receivedQuantity': instance.receivedQuantity,
      'unitPrice': instance.unitPrice,
      'taxRate': instance.taxRate,
      'discountRate': instance.discountRate,
      'discountAmount': instance.discountAmount,
      'createdAt': instance.createdAt.toIso8601String(),
      'productName': instance.productName,
      'productSku': instance.productSku,
      'unit': instance.unit,
      'notes': instance.notes,
      'batchNumber': instance.batchNumber,
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'metadata': instance.metadata,
    };
