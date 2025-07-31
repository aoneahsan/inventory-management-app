// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'composite_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompositeItemImpl _$$CompositeItemImplFromJson(Map<String, dynamic> json) =>
    _$CompositeItemImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      description: json['description'] as String?,
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
      costPrice: (json['costPrice'] as num?)?.toDouble(),
      isActive: json['isActive'] as bool? ?? true,
      autoAssemble: json['autoAssemble'] as bool? ?? false,
      canBeSoldSeparately: json['canBeSoldSeparately'] as bool? ?? true,
      assemblyType:
          $enumDecodeNullable(_$AssemblyTypeEnumMap, json['assemblyType']) ??
              AssemblyType.manual,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      components: (json['components'] as List<dynamic>?)
              ?.map((e) =>
                  CompositeItemComponent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      sku: json['sku'] as String?,
      barcode: json['barcode'] as String?,
      categoryId: json['categoryId'] as String?,
      taxRate: (json['taxRate'] as num?)?.toDouble() ?? 0,
      imageUrl: json['imageUrl'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      assemblyTime: (json['assemblyTime'] as num?)?.toDouble() ?? 0,
      assemblyInstructions: json['assemblyInstructions'] as String?,
      trackInventory: json['trackInventory'] as bool? ?? false,
      currentStock: (json['currentStock'] as num?)?.toDouble() ?? 0,
      unit: json['unit'] as String?,
      minStock: (json['minStock'] as num?)?.toDouble() ?? 0,
      maxStock: (json['maxStock'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$CompositeItemImplToJson(_$CompositeItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
      'sellingPrice': instance.sellingPrice,
      'costPrice': instance.costPrice,
      'isActive': instance.isActive,
      'autoAssemble': instance.autoAssemble,
      'canBeSoldSeparately': instance.canBeSoldSeparately,
      'assemblyType': _$AssemblyTypeEnumMap[instance.assemblyType]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'components': instance.components,
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'sku': instance.sku,
      'barcode': instance.barcode,
      'categoryId': instance.categoryId,
      'taxRate': instance.taxRate,
      'imageUrl': instance.imageUrl,
      'metadata': instance.metadata,
      'assemblyTime': instance.assemblyTime,
      'assemblyInstructions': instance.assemblyInstructions,
      'trackInventory': instance.trackInventory,
      'currentStock': instance.currentStock,
      'unit': instance.unit,
      'minStock': instance.minStock,
      'maxStock': instance.maxStock,
    };

const _$AssemblyTypeEnumMap = {
  AssemblyType.manual: 'manual',
  AssemblyType.automatic: 'automatic',
  AssemblyType.onDemand: 'on_demand',
};

_$CompositeItemComponentImpl _$$CompositeItemComponentImplFromJson(
        Map<String, dynamic> json) =>
    _$CompositeItemComponentImpl(
      id: json['id'] as String,
      compositeItemId: json['compositeItemId'] as String,
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unitCost: (json['unitCost'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      productName: json['productName'] as String?,
      productSku: json['productSku'] as String?,
      unit: json['unit'] as String?,
      isOptional: json['isOptional'] as bool? ?? false,
      minQuantity: (json['minQuantity'] as num?)?.toDouble(),
      maxQuantity: (json['maxQuantity'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$CompositeItemComponentImplToJson(
        _$CompositeItemComponentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'compositeItemId': instance.compositeItemId,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'unitCost': instance.unitCost,
      'createdAt': instance.createdAt.toIso8601String(),
      'productName': instance.productName,
      'productSku': instance.productSku,
      'unit': instance.unit,
      'isOptional': instance.isOptional,
      'minQuantity': instance.minQuantity,
      'maxQuantity': instance.maxQuantity,
      'notes': instance.notes,
      'sortOrder': instance.sortOrder,
    };

_$CompositeItemAssemblyImpl _$$CompositeItemAssemblyImplFromJson(
        Map<String, dynamic> json) =>
    _$CompositeItemAssemblyImpl(
      id: json['id'] as String,
      compositeItemId: json['compositeItemId'] as String,
      branchId: json['branchId'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      assemblyDate: DateTime.parse(json['assemblyDate'] as String),
      assembledBy: json['assembledBy'] as String,
      status: json['status'] as String? ?? 'pending',
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      notes: json['notes'] as String?,
      componentsUsed: (json['componentsUsed'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      totalCost: (json['totalCost'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$CompositeItemAssemblyImplToJson(
        _$CompositeItemAssemblyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'compositeItemId': instance.compositeItemId,
      'branchId': instance.branchId,
      'quantity': instance.quantity,
      'assemblyDate': instance.assemblyDate.toIso8601String(),
      'assembledBy': instance.assembledBy,
      'status': instance.status,
      'completedAt': instance.completedAt?.toIso8601String(),
      'notes': instance.notes,
      'componentsUsed': instance.componentsUsed,
      'totalCost': instance.totalCost,
      'createdAt': instance.createdAt.toIso8601String(),
    };
