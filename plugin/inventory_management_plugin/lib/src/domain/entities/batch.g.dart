// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BatchImpl _$$BatchImplFromJson(Map<String, dynamic> json) => _$BatchImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      productId: json['productId'] as String,
      batchNumber: json['batchNumber'] as String,
      manufacturingDate: json['manufacturingDate'] == null
          ? null
          : DateTime.parse(json['manufacturingDate'] as String),
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
      supplierId: json['supplierId'] as String?,
      costPrice: (json['costPrice'] as num?)?.toDouble(),
      currentQuantity: (json['currentQuantity'] as num?)?.toDouble() ?? 0,
      initialQuantity: (json['initialQuantity'] as num?)?.toDouble() ?? 0,
      branchId: json['branchId'] as String?,
      status: json['status'] as String? ?? 'active',
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      purchaseOrderId: json['purchaseOrderId'] as String?,
      warehouseLocation: json['warehouseLocation'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      sellingPrice: (json['sellingPrice'] as num?)?.toDouble(),
      qualityStatus: json['qualityStatus'] as String?,
      testResults: json['testResults'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$BatchImplToJson(_$BatchImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'productId': instance.productId,
      'batchNumber': instance.batchNumber,
      'manufacturingDate': instance.manufacturingDate?.toIso8601String(),
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'supplierId': instance.supplierId,
      'costPrice': instance.costPrice,
      'currentQuantity': instance.currentQuantity,
      'initialQuantity': instance.initialQuantity,
      'branchId': instance.branchId,
      'status': instance.status,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'purchaseOrderId': instance.purchaseOrderId,
      'warehouseLocation': instance.warehouseLocation,
      'metadata': instance.metadata,
      'tags': instance.tags,
      'sellingPrice': instance.sellingPrice,
      'qualityStatus': instance.qualityStatus,
      'testResults': instance.testResults,
    };
