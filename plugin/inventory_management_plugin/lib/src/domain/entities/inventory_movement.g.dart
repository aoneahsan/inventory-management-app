// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_movement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InventoryMovementImpl _$$InventoryMovementImplFromJson(
        Map<String, dynamic> json) =>
    _$InventoryMovementImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      productId: json['productId'] as String,
      type: $enumDecode(_$MovementTypeEnumMap, json['type']),
      quantity: (json['quantity'] as num).toDouble(),
      unitCost: (json['unitCost'] as num?)?.toDouble(),
      totalCost: (json['totalCost'] as num?)?.toDouble(),
      reason: json['reason'] as String?,
      referenceNumber: json['referenceNumber'] as String?,
      referenceId: json['referenceId'] as String?,
      referenceType: json['referenceType'] as String?,
      fromBranchId: json['fromBranchId'] as String?,
      toBranchId: json['toBranchId'] as String?,
      fromLocation: json['fromLocation'] as String?,
      toLocation: json['toLocation'] as String?,
      performedBy: json['performedBy'] as String,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      batchId: json['batchId'] as String?,
      serialNumber: json['serialNumber'] as String?,
      status: json['status'] as String? ?? 'pending',
      approvedBy: json['approvedBy'] as String?,
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      stockBefore: (json['stockBefore'] as num?)?.toDouble(),
      stockAfter: (json['stockAfter'] as num?)?.toDouble(),
      supplierId: json['supplierId'] as String?,
      customerId: json['customerId'] as String?,
    );

Map<String, dynamic> _$$InventoryMovementImplToJson(
        _$InventoryMovementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'productId': instance.productId,
      'type': _$MovementTypeEnumMap[instance.type]!,
      'quantity': instance.quantity,
      'unitCost': instance.unitCost,
      'totalCost': instance.totalCost,
      'reason': instance.reason,
      'referenceNumber': instance.referenceNumber,
      'referenceId': instance.referenceId,
      'referenceType': instance.referenceType,
      'fromBranchId': instance.fromBranchId,
      'toBranchId': instance.toBranchId,
      'fromLocation': instance.fromLocation,
      'toLocation': instance.toLocation,
      'performedBy': instance.performedBy,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'batchId': instance.batchId,
      'serialNumber': instance.serialNumber,
      'status': instance.status,
      'approvedBy': instance.approvedBy,
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'metadata': instance.metadata,
      'stockBefore': instance.stockBefore,
      'stockAfter': instance.stockAfter,
      'supplierId': instance.supplierId,
      'customerId': instance.customerId,
    };

const _$MovementTypeEnumMap = {
  MovementType.purchase: 'purchase',
  MovementType.sale: 'sale',
  MovementType.adjustment: 'adjustment',
  MovementType.transfer: 'transfer',
  MovementType.return_: 'return',
  MovementType.damage: 'damage',
  MovementType.expired: 'expired',
  MovementType.productionIn: 'production_in',
  MovementType.productionOut: 'production_out',
  MovementType.stockTake: 'stock_take',
  MovementType.repackagingIn: 'repackaging_in',
  MovementType.repackagingOut: 'repackaging_out',
};
