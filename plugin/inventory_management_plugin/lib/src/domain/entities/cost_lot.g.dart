// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cost_lot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CostLotImpl _$$CostLotImplFromJson(Map<String, dynamic> json) =>
    _$CostLotImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      productId: json['productId'] as String,
      branchId: json['branchId'] as String?,
      lotNumber: json['lotNumber'] as String,
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
      quantity: (json['quantity'] as num).toDouble(),
      remainingQuantity: (json['remainingQuantity'] as num).toDouble(),
      unitCost: (json['unitCost'] as num).toDouble(),
      supplierId: json['supplierId'] as String?,
      purchaseOrderId: json['purchaseOrderId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      batchId: json['batchId'] as String?,
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
      status: $enumDecodeNullable(_$LotStatusEnumMap, json['status']) ??
          LotStatus.active,
      warehouseLocation: json['warehouseLocation'] as String?,
      landedCost: (json['landedCost'] as num?)?.toDouble(),
      additionalCosts: (json['additionalCosts'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      currency: json['currency'] as String?,
      exchangeRate: (json['exchangeRate'] as num?)?.toDouble(),
      invoiceNumber: json['invoiceNumber'] as String?,
      receivedDate: json['receivedDate'] == null
          ? null
          : DateTime.parse(json['receivedDate'] as String),
      receivedBy: json['receivedBy'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      taxAmount: (json['taxAmount'] as num?)?.toDouble(),
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
      movements: (json['movements'] as List<dynamic>?)
              ?.map((e) => CostLotMovement.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CostLotImplToJson(_$CostLotImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'productId': instance.productId,
      'branchId': instance.branchId,
      'lotNumber': instance.lotNumber,
      'purchaseDate': instance.purchaseDate.toIso8601String(),
      'quantity': instance.quantity,
      'remainingQuantity': instance.remainingQuantity,
      'unitCost': instance.unitCost,
      'supplierId': instance.supplierId,
      'purchaseOrderId': instance.purchaseOrderId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'batchId': instance.batchId,
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'status': _$LotStatusEnumMap[instance.status]!,
      'warehouseLocation': instance.warehouseLocation,
      'landedCost': instance.landedCost,
      'additionalCosts': instance.additionalCosts,
      'currency': instance.currency,
      'exchangeRate': instance.exchangeRate,
      'invoiceNumber': instance.invoiceNumber,
      'receivedDate': instance.receivedDate?.toIso8601String(),
      'receivedBy': instance.receivedBy,
      'metadata': instance.metadata,
      'taxAmount': instance.taxAmount,
      'discountAmount': instance.discountAmount,
      'notes': instance.notes,
      'movements': instance.movements,
    };

const _$LotStatusEnumMap = {
  LotStatus.active: 'active',
  LotStatus.consumed: 'consumed',
  LotStatus.expired: 'expired',
  LotStatus.damaged: 'damaged',
  LotStatus.returned: 'returned',
};

_$CostLotMovementImpl _$$CostLotMovementImplFromJson(
        Map<String, dynamic> json) =>
    _$CostLotMovementImpl(
      id: json['id'] as String,
      costLotId: json['costLotId'] as String,
      movementType: json['movementType'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      movementDate: DateTime.parse(json['movementDate'] as String),
      referenceId: json['referenceId'] as String?,
      referenceType: json['referenceType'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$CostLotMovementImplToJson(
        _$CostLotMovementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'costLotId': instance.costLotId,
      'movementType': instance.movementType,
      'quantity': instance.quantity,
      'movementDate': instance.movementDate.toIso8601String(),
      'referenceId': instance.referenceId,
      'referenceType': instance.referenceType,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$CostLotAllocationImpl _$$CostLotAllocationImplFromJson(
        Map<String, dynamic> json) =>
    _$CostLotAllocationImpl(
      costLotId: json['costLotId'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unitCost: (json['unitCost'] as num).toDouble(),
      totalCost: (json['totalCost'] as num).toDouble(),
    );

Map<String, dynamic> _$$CostLotAllocationImplToJson(
        _$CostLotAllocationImpl instance) =>
    <String, dynamic>{
      'costLotId': instance.costLotId,
      'quantity': instance.quantity,
      'unitCost': instance.unitCost,
      'totalCost': instance.totalCost,
    };
