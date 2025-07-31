// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PurchaseBillImpl _$$PurchaseBillImplFromJson(Map<String, dynamic> json) =>
    _$PurchaseBillImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      supplierId: json['supplierId'] as String,
      purchaseOrderId: json['purchaseOrderId'] as String?,
      billNumber: json['billNumber'] as String,
      billDate: DateTime.parse(json['billDate'] as String),
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      status:
          $enumDecodeNullable(_$PurchaseBillStatusEnumMap, json['status']) ??
              PurchaseBillStatus.draft,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      paidAmount: (json['paidAmount'] as num?)?.toDouble() ?? 0,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      supplierBillNumber: json['supplierBillNumber'] as String?,
      referenceNumber: json['referenceNumber'] as String?,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => PurchaseBillItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      subtotal: (json['subtotal'] as num?)?.toDouble(),
      taxAmount: (json['taxAmount'] as num?)?.toDouble(),
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
      discountType: json['discountType'] as String?,
      discountValue: (json['discountValue'] as num?)?.toDouble(),
      shippingAmount: (json['shippingAmount'] as num?)?.toDouble(),
      otherCharges: (json['otherCharges'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      exchangeRate: (json['exchangeRate'] as num?)?.toDouble(),
      paymentTerm:
          $enumDecodeNullable(_$PaymentTermEnumMap, json['paymentTerm']) ??
              PaymentTerm.net30,
      customPaymentDays: (json['customPaymentDays'] as num?)?.toInt(),
      billingAddress: json['billingAddress'] as String?,
      shippingAddress: json['shippingAddress'] as String?,
      attachmentUrls: (json['attachmentUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      approvedBy: json['approvedBy'] as String?,
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      cancelledBy: json['cancelledBy'] as String?,
      cancelledAt: json['cancelledAt'] == null
          ? null
          : DateTime.parse(json['cancelledAt'] as String),
      cancellationReason: json['cancellationReason'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      payments: (json['payments'] as List<dynamic>?)
              ?.map((e) =>
                  PurchaseBillPayment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      lastPaymentId: json['lastPaymentId'] as String?,
      lastPaymentDate: json['lastPaymentDate'] == null
          ? null
          : DateTime.parse(json['lastPaymentDate'] as String),
    );

Map<String, dynamic> _$$PurchaseBillImplToJson(_$PurchaseBillImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'supplierId': instance.supplierId,
      'purchaseOrderId': instance.purchaseOrderId,
      'billNumber': instance.billNumber,
      'billDate': instance.billDate.toIso8601String(),
      'dueDate': instance.dueDate?.toIso8601String(),
      'status': _$PurchaseBillStatusEnumMap[instance.status]!,
      'totalAmount': instance.totalAmount,
      'paidAmount': instance.paidAmount,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'supplierBillNumber': instance.supplierBillNumber,
      'referenceNumber': instance.referenceNumber,
      'items': instance.items,
      'subtotal': instance.subtotal,
      'taxAmount': instance.taxAmount,
      'discountAmount': instance.discountAmount,
      'discountType': instance.discountType,
      'discountValue': instance.discountValue,
      'shippingAmount': instance.shippingAmount,
      'otherCharges': instance.otherCharges,
      'currency': instance.currency,
      'exchangeRate': instance.exchangeRate,
      'paymentTerm': _$PaymentTermEnumMap[instance.paymentTerm]!,
      'customPaymentDays': instance.customPaymentDays,
      'billingAddress': instance.billingAddress,
      'shippingAddress': instance.shippingAddress,
      'attachmentUrls': instance.attachmentUrls,
      'approvedBy': instance.approvedBy,
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'cancelledBy': instance.cancelledBy,
      'cancelledAt': instance.cancelledAt?.toIso8601String(),
      'cancellationReason': instance.cancellationReason,
      'metadata': instance.metadata,
      'payments': instance.payments,
      'lastPaymentId': instance.lastPaymentId,
      'lastPaymentDate': instance.lastPaymentDate?.toIso8601String(),
    };

const _$PurchaseBillStatusEnumMap = {
  PurchaseBillStatus.draft: 'draft',
  PurchaseBillStatus.pending: 'pending',
  PurchaseBillStatus.partial: 'partial',
  PurchaseBillStatus.paid: 'paid',
  PurchaseBillStatus.overdue: 'overdue',
  PurchaseBillStatus.cancelled: 'cancelled',
  PurchaseBillStatus.disputed: 'disputed',
};

const _$PaymentTermEnumMap = {
  PaymentTerm.immediate: 'immediate',
  PaymentTerm.net7: 'net_7',
  PaymentTerm.net15: 'net_15',
  PaymentTerm.net30: 'net_30',
  PaymentTerm.net45: 'net_45',
  PaymentTerm.net60: 'net_60',
  PaymentTerm.net90: 'net_90',
  PaymentTerm.custom: 'custom',
};

_$PurchaseBillItemImpl _$$PurchaseBillItemImplFromJson(
        Map<String, dynamic> json) =>
    _$PurchaseBillItemImpl(
      id: json['id'] as String,
      billId: json['billId'] as String,
      productId: json['productId'] as String,
      productName: json['productName'] as String?,
      productSku: json['productSku'] as String?,
      quantity: (json['quantity'] as num).toDouble(),
      unitPrice: (json['unitPrice'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      description: json['description'] as String?,
      taxRate: (json['taxRate'] as num?)?.toDouble(),
      taxAmount: (json['taxAmount'] as num?)?.toDouble(),
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$PurchaseBillItemImplToJson(
        _$PurchaseBillItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'billId': instance.billId,
      'productId': instance.productId,
      'productName': instance.productName,
      'productSku': instance.productSku,
      'quantity': instance.quantity,
      'unitPrice': instance.unitPrice,
      'totalAmount': instance.totalAmount,
      'description': instance.description,
      'taxRate': instance.taxRate,
      'taxAmount': instance.taxAmount,
      'discountAmount': instance.discountAmount,
      'unit': instance.unit,
      'metadata': instance.metadata,
    };

_$PurchaseBillPaymentImpl _$$PurchaseBillPaymentImplFromJson(
        Map<String, dynamic> json) =>
    _$PurchaseBillPaymentImpl(
      id: json['id'] as String,
      billId: json['billId'] as String,
      amount: (json['amount'] as num).toDouble(),
      paymentDate: DateTime.parse(json['paymentDate'] as String),
      paymentMethod: json['paymentMethod'] as String,
      referenceNumber: json['referenceNumber'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      createdBy: json['createdBy'] as String?,
    );

Map<String, dynamic> _$$PurchaseBillPaymentImplToJson(
        _$PurchaseBillPaymentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'billId': instance.billId,
      'amount': instance.amount,
      'paymentDate': instance.paymentDate.toIso8601String(),
      'paymentMethod': instance.paymentMethod,
      'referenceNumber': instance.referenceNumber,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'createdBy': instance.createdBy,
    };
