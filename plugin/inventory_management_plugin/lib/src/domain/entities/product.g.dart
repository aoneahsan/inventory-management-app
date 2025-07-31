// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      name: json['name'] as String,
      sku: json['sku'] as String,
      barcode: json['barcode'] as String?,
      description: json['description'] as String?,
      categoryId: json['categoryId'] as String?,
      unit: json['unit'] as String? ?? 'pcs',
      stockQuantity: (json['stockQuantity'] as num?)?.toDouble() ?? 0,
      reorderPoint: (json['reorderPoint'] as num?)?.toDouble() ?? 0,
      reorderQuantity: (json['reorderQuantity'] as num?)?.toDouble() ?? 0,
      costPrice: (json['costPrice'] as num?)?.toDouble() ?? 0,
      sellingPrice: (json['sellingPrice'] as num?)?.toDouble() ?? 0,
      taxRate: (json['taxRate'] as num?)?.toDouble() ?? 0,
      imageUrl: json['imageUrl'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      isComposite: json['isComposite'] as bool? ?? false,
      trackInventory: json['trackInventory'] as bool? ?? true,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      hsn: json['hsn'] as String?,
      sac: json['sac'] as String?,
      minStock: (json['minStock'] as num?)?.toDouble() ?? 0,
      maxStock: (json['maxStock'] as num?)?.toDouble(),
      warehouseLocation: json['warehouseLocation'] as String?,
      supplierId: json['supplierId'] as String?,
      brandName: json['brandName'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      variants: json['variants'] == null
          ? null
          : ProductVariants.fromJson(json['variants'] as Map<String, dynamic>),
      branchStock: (json['branchStock'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      trackSerialNumbers: json['trackSerialNumbers'] as bool? ?? false,
      trackBatches: json['trackBatches'] as bool? ?? false,
      shelfLifeDays: (json['shelfLifeDays'] as num?)?.toInt() ?? 30,
      customFields: json['customFields'] as String?,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'name': instance.name,
      'sku': instance.sku,
      'barcode': instance.barcode,
      'description': instance.description,
      'categoryId': instance.categoryId,
      'unit': instance.unit,
      'stockQuantity': instance.stockQuantity,
      'reorderPoint': instance.reorderPoint,
      'reorderQuantity': instance.reorderQuantity,
      'costPrice': instance.costPrice,
      'sellingPrice': instance.sellingPrice,
      'taxRate': instance.taxRate,
      'imageUrl': instance.imageUrl,
      'isActive': instance.isActive,
      'isComposite': instance.isComposite,
      'trackInventory': instance.trackInventory,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'hsn': instance.hsn,
      'sac': instance.sac,
      'minStock': instance.minStock,
      'maxStock': instance.maxStock,
      'warehouseLocation': instance.warehouseLocation,
      'supplierId': instance.supplierId,
      'brandName': instance.brandName,
      'tags': instance.tags,
      'variants': instance.variants,
      'branchStock': instance.branchStock,
      'trackSerialNumbers': instance.trackSerialNumbers,
      'trackBatches': instance.trackBatches,
      'shelfLifeDays': instance.shelfLifeDays,
      'customFields': instance.customFields,
    };

_$ProductVariantsImpl _$$ProductVariantsImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductVariantsImpl(
      attributes: (json['attributes'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k, (e as List<dynamic>).map((e) => e as String).toList()),
          ) ??
          const {},
      variants: (json['variants'] as List<dynamic>?)
              ?.map((e) => ProductVariant.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ProductVariantsImplToJson(
        _$ProductVariantsImpl instance) =>
    <String, dynamic>{
      'attributes': instance.attributes,
      'variants': instance.variants,
    };

_$ProductVariantImpl _$$ProductVariantImplFromJson(Map<String, dynamic> json) =>
    _$ProductVariantImpl(
      id: json['id'] as String,
      sku: json['sku'] as String,
      barcode: json['barcode'] as String?,
      attributes: Map<String, String>.from(json['attributes'] as Map),
      stockQuantity: (json['stockQuantity'] as num?)?.toDouble() ?? 0,
      costPrice: (json['costPrice'] as num?)?.toDouble(),
      sellingPrice: (json['sellingPrice'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'] as String?,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$$ProductVariantImplToJson(
        _$ProductVariantImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'barcode': instance.barcode,
      'attributes': instance.attributes,
      'stockQuantity': instance.stockQuantity,
      'costPrice': instance.costPrice,
      'sellingPrice': instance.sellingPrice,
      'imageUrl': instance.imageUrl,
      'isActive': instance.isActive,
    };
