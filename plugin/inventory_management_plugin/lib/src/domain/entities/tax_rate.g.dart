// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax_rate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaxRateImpl _$$TaxRateImplFromJson(Map<String, dynamic> json) =>
    _$TaxRateImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      rate: (json['rate'] as num).toDouble(),
      type: $enumDecode(_$TaxTypeEnumMap, json['type']),
      isCompound: json['isCompound'] as bool? ?? false,
      isInclusive: json['isInclusive'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      cgstRate: (json['cgstRate'] as num?)?.toDouble(),
      sgstRate: (json['sgstRate'] as num?)?.toDouble(),
      igstRate: (json['igstRate'] as num?)?.toDouble(),
      cessRate: (json['cessRate'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      description: json['description'] as String?,
      applicableToCategories: (json['applicableToCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      applicableToProducts: (json['applicableToProducts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      effectiveFrom: json['effectiveFrom'] == null
          ? null
          : DateTime.parse(json['effectiveFrom'] as String),
      effectiveTo: json['effectiveTo'] == null
          ? null
          : DateTime.parse(json['effectiveTo'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      priority: (json['priority'] as num?)?.toInt() ?? 0,
      parentTaxId: json['parentTaxId'] as String?,
      isDefault: json['isDefault'] as bool? ?? false,
    );

Map<String, dynamic> _$$TaxRateImplToJson(_$TaxRateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'name': instance.name,
      'code': instance.code,
      'rate': instance.rate,
      'type': _$TaxTypeEnumMap[instance.type]!,
      'isCompound': instance.isCompound,
      'isInclusive': instance.isInclusive,
      'isActive': instance.isActive,
      'cgstRate': instance.cgstRate,
      'sgstRate': instance.sgstRate,
      'igstRate': instance.igstRate,
      'cessRate': instance.cessRate,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'description': instance.description,
      'applicableToCategories': instance.applicableToCategories,
      'applicableToProducts': instance.applicableToProducts,
      'effectiveFrom': instance.effectiveFrom?.toIso8601String(),
      'effectiveTo': instance.effectiveTo?.toIso8601String(),
      'metadata': instance.metadata,
      'priority': instance.priority,
      'parentTaxId': instance.parentTaxId,
      'isDefault': instance.isDefault,
    };

const _$TaxTypeEnumMap = {
  TaxType.gst: 'GST',
  TaxType.vat: 'VAT',
  TaxType.salesTax: 'Sales Tax',
  TaxType.serviceTax: 'Service Tax',
  TaxType.excise: 'Excise',
  TaxType.customDuty: 'Custom Duty',
  TaxType.other: 'Other',
};

_$HsnCodeImpl _$$HsnCodeImplFromJson(Map<String, dynamic> json) =>
    _$HsnCodeImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      code: json['code'] as String,
      description: json['description'] as String?,
      taxRateId: json['taxRateId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      chapter: json['chapter'] as String?,
      section: json['section'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$$HsnCodeImplToJson(_$HsnCodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'code': instance.code,
      'description': instance.description,
      'taxRateId': instance.taxRateId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'chapter': instance.chapter,
      'section': instance.section,
      'metadata': instance.metadata,
      'isActive': instance.isActive,
    };
