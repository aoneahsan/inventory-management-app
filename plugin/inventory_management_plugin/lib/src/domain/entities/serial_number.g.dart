// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serial_number.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SerialNumberImpl _$$SerialNumberImplFromJson(Map<String, dynamic> json) =>
    _$SerialNumberImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      productId: json['productId'] as String,
      serialNumber: json['serialNumber'] as String,
      batchId: json['batchId'] as String?,
      status: $enumDecode(_$SerialStatusEnumMap, json['status']),
      branchId: json['branchId'] as String?,
      purchaseDate: json['purchaseDate'] == null
          ? null
          : DateTime.parse(json['purchaseDate'] as String),
      purchasePrice: (json['purchasePrice'] as num?)?.toDouble(),
      purchaseOrderId: json['purchaseOrderId'] as String?,
      supplierId: json['supplierId'] as String?,
      saleId: json['saleId'] as String?,
      customerId: json['customerId'] as String?,
      saleDate: json['saleDate'] == null
          ? null
          : DateTime.parse(json['saleDate'] as String),
      salePrice: (json['salePrice'] as num?)?.toDouble(),
      warrantyEndDate: json['warrantyEndDate'] == null
          ? null
          : DateTime.parse(json['warrantyEndDate'] as String),
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      currentLocation: json['currentLocation'] as String?,
      movements: (json['movements'] as List<dynamic>?)
              ?.map((e) => SerialMovement.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      lastScannedBy: json['lastScannedBy'] as String?,
      lastScannedAt: json['lastScannedAt'] == null
          ? null
          : DateTime.parse(json['lastScannedAt'] as String),
      customFields: json['customFields'] as Map<String, dynamic>? ?? const {},
      returnReason: json['returnReason'] as String?,
      returnDate: json['returnDate'] == null
          ? null
          : DateTime.parse(json['returnDate'] as String),
      repairNotes: json['repairNotes'] as String?,
      repairCost: (json['repairCost'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$SerialNumberImplToJson(_$SerialNumberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'productId': instance.productId,
      'serialNumber': instance.serialNumber,
      'batchId': instance.batchId,
      'status': _$SerialStatusEnumMap[instance.status]!,
      'branchId': instance.branchId,
      'purchaseDate': instance.purchaseDate?.toIso8601String(),
      'purchasePrice': instance.purchasePrice,
      'purchaseOrderId': instance.purchaseOrderId,
      'supplierId': instance.supplierId,
      'saleId': instance.saleId,
      'customerId': instance.customerId,
      'saleDate': instance.saleDate?.toIso8601String(),
      'salePrice': instance.salePrice,
      'warrantyEndDate': instance.warrantyEndDate?.toIso8601String(),
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'currentLocation': instance.currentLocation,
      'movements': instance.movements,
      'metadata': instance.metadata,
      'lastScannedBy': instance.lastScannedBy,
      'lastScannedAt': instance.lastScannedAt?.toIso8601String(),
      'customFields': instance.customFields,
      'returnReason': instance.returnReason,
      'returnDate': instance.returnDate?.toIso8601String(),
      'repairNotes': instance.repairNotes,
      'repairCost': instance.repairCost,
    };

const _$SerialStatusEnumMap = {
  SerialStatus.available: 'available',
  SerialStatus.sold: 'sold',
  SerialStatus.returned: 'returned',
  SerialStatus.damaged: 'damaged',
  SerialStatus.lost: 'lost',
  SerialStatus.inTransit: 'in_transit',
  SerialStatus.reserved: 'reserved',
  SerialStatus.underRepair: 'under_repair',
};

_$SerialMovementImpl _$$SerialMovementImplFromJson(Map<String, dynamic> json) =>
    _$SerialMovementImpl(
      id: json['id'] as String,
      serialNumberId: json['serialNumberId'] as String,
      movementType: json['movementType'] as String,
      fromLocation: json['fromLocation'] as String?,
      toLocation: json['toLocation'] as String?,
      fromBranchId: json['fromBranchId'] as String?,
      toBranchId: json['toBranchId'] as String?,
      performedBy: json['performedBy'] as String,
      notes: json['notes'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$SerialMovementImplToJson(
        _$SerialMovementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serialNumberId': instance.serialNumberId,
      'movementType': instance.movementType,
      'fromLocation': instance.fromLocation,
      'toLocation': instance.toLocation,
      'fromBranchId': instance.fromBranchId,
      'toBranchId': instance.toBranchId,
      'performedBy': instance.performedBy,
      'notes': instance.notes,
      'timestamp': instance.timestamp.toIso8601String(),
      'metadata': instance.metadata,
    };
