// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SaleImpl _$$SaleImplFromJson(Map<String, dynamic> json) => _$SaleImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      branchId: json['branchId'] as String?,
      registerId: json['registerId'] as String?,
      saleNumber: json['saleNumber'] as String,
      customerId: json['customerId'] as String?,
      saleDate: DateTime.parse(json['saleDate'] as String),
      subtotal: (json['subtotal'] as num).toDouble(),
      taxAmount: (json['taxAmount'] as num?)?.toDouble() ?? 0,
      discountAmount: (json['discountAmount'] as num?)?.toDouble() ?? 0,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      paidAmount: (json['paidAmount'] as num?)?.toDouble() ?? 0,
      changeAmount: (json['changeAmount'] as num?)?.toDouble() ?? 0,
      paymentStatus: json['paymentStatus'] as String? ?? 'pending',
      paymentMethods: (json['paymentMethods'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      notes: json['notes'] as String?,
      cashierId: json['cashierId'] as String,
      voided: json['voided'] as bool? ?? false,
      voidedBy: json['voidedBy'] as String?,
      voidedAt: json['voidedAt'] == null
          ? null
          : DateTime.parse(json['voidedAt'] as String),
      voidReason: json['voidReason'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => SaleItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      status: json['status'] as String? ?? 'completed',
      invoiceNumber: json['invoiceNumber'] as String?,
      referenceNumber: json['referenceNumber'] as String?,
      isReturn: json['isReturn'] as bool? ?? false,
      originalSaleId: json['originalSaleId'] as String?,
      isOffline: json['isOffline'] as bool? ?? false,
      shippingAddress: json['shippingAddress'] as String?,
      shippingCost: (json['shippingCost'] as num?)?.toDouble() ?? 0,
      couponCode: json['couponCode'] as String?,
      couponDiscount: (json['couponDiscount'] as num?)?.toDouble() ?? 0,
      loyaltyPointsEarned: (json['loyaltyPointsEarned'] as num?)?.toInt() ?? 0,
      loyaltyPointsRedeemed:
          (json['loyaltyPointsRedeemed'] as num?)?.toInt() ?? 0,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      salesPersonId: json['salesPersonId'] as String?,
      tipAmount: (json['tipAmount'] as num?)?.toDouble() ?? 0,
      serviceCharge: (json['serviceCharge'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$SaleImplToJson(_$SaleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'branchId': instance.branchId,
      'registerId': instance.registerId,
      'saleNumber': instance.saleNumber,
      'customerId': instance.customerId,
      'saleDate': instance.saleDate.toIso8601String(),
      'subtotal': instance.subtotal,
      'taxAmount': instance.taxAmount,
      'discountAmount': instance.discountAmount,
      'totalAmount': instance.totalAmount,
      'paidAmount': instance.paidAmount,
      'changeAmount': instance.changeAmount,
      'paymentStatus': instance.paymentStatus,
      'paymentMethods': instance.paymentMethods,
      'notes': instance.notes,
      'cashierId': instance.cashierId,
      'voided': instance.voided,
      'voidedBy': instance.voidedBy,
      'voidedAt': instance.voidedAt?.toIso8601String(),
      'voidReason': instance.voidReason,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'items': instance.items,
      'status': instance.status,
      'invoiceNumber': instance.invoiceNumber,
      'referenceNumber': instance.referenceNumber,
      'isReturn': instance.isReturn,
      'originalSaleId': instance.originalSaleId,
      'isOffline': instance.isOffline,
      'shippingAddress': instance.shippingAddress,
      'shippingCost': instance.shippingCost,
      'couponCode': instance.couponCode,
      'couponDiscount': instance.couponDiscount,
      'loyaltyPointsEarned': instance.loyaltyPointsEarned,
      'loyaltyPointsRedeemed': instance.loyaltyPointsRedeemed,
      'metadata': instance.metadata,
      'salesPersonId': instance.salesPersonId,
      'tipAmount': instance.tipAmount,
      'serviceCharge': instance.serviceCharge,
    };

_$SaleItemImpl _$$SaleItemImplFromJson(Map<String, dynamic> json) =>
    _$SaleItemImpl(
      id: json['id'] as String,
      saleId: json['saleId'] as String,
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unitPrice: (json['unitPrice'] as num).toDouble(),
      costPrice: (json['costPrice'] as num?)?.toDouble(),
      discountRate: (json['discountRate'] as num?)?.toDouble() ?? 0,
      discountAmount: (json['discountAmount'] as num?)?.toDouble() ?? 0,
      taxRate: (json['taxRate'] as num?)?.toDouble() ?? 0,
      taxAmount: (json['taxAmount'] as num?)?.toDouble() ?? 0,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      productName: json['productName'] as String,
      productSku: json['productSku'] as String?,
      productBarcode: json['productBarcode'] as String?,
      variantId: json['variantId'] as String?,
      variantName: json['variantName'] as String?,
      unitOfMeasure: json['unitOfMeasure'] as String?,
      serialNumber: json['serialNumber'] as String?,
      batchNumber: json['batchNumber'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      isReturn: json['isReturn'] as bool? ?? false,
      returnQuantity: (json['returnQuantity'] as num?)?.toDouble(),
      returnReason: json['returnReason'] as String?,
    );

Map<String, dynamic> _$$SaleItemImplToJson(_$SaleItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'saleId': instance.saleId,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'unitPrice': instance.unitPrice,
      'costPrice': instance.costPrice,
      'discountRate': instance.discountRate,
      'discountAmount': instance.discountAmount,
      'taxRate': instance.taxRate,
      'taxAmount': instance.taxAmount,
      'totalAmount': instance.totalAmount,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'productName': instance.productName,
      'productSku': instance.productSku,
      'productBarcode': instance.productBarcode,
      'variantId': instance.variantId,
      'variantName': instance.variantName,
      'unitOfMeasure': instance.unitOfMeasure,
      'serialNumber': instance.serialNumber,
      'batchNumber': instance.batchNumber,
      'metadata': instance.metadata,
      'isReturn': instance.isReturn,
      'returnQuantity': instance.returnQuantity,
      'returnReason': instance.returnReason,
    };
