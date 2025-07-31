import 'dart:convert';

import '../../domain/entities/tax_rate.dart';
import '../database/database_schema.dart';
import 'base_model.dart';

/// Database model for TaxRate entity
class TaxRateModel extends BaseModel {
  final TaxRate taxRate;
  
  TaxRateModel(this.taxRate);
  
  @override
  String get tableName => DatabaseSchema.taxRatesTable;
  
  @override
  Map<String, dynamic> toDatabase() {
    return {
      DatabaseSchema.id: taxRate.id,
      DatabaseSchema.organizationId: taxRate.organizationId,
      'name': taxRate.name,
      'code': taxRate.code,
      'rate': taxRate.rate,
      'type': taxRate.type.name,
      'description': taxRate.description,
      'hsn_code': taxRate.hsnCode,
      'sac_code': taxRate.sacCode,
      'cgst_rate': taxRate.cgstRate,
      'sgst_rate': taxRate.sgstRate,
      'igst_rate': taxRate.igstRate,
      'cess_rate': taxRate.cessRate,
      'effective_from': dateTimeToMillis(taxRate.effectiveFrom),
      'effective_to': dateTimeToMillis(taxRate.effectiveTo),
      'country': taxRate.country,
      'state': taxRate.state,
      'is_compound': boolToInt(taxRate.isCompound),
      'is_inclusive': boolToInt(taxRate.isInclusive),
      'apply_on_shipping': boolToInt(taxRate.applyOnShipping),
      'apply_on_discounts': boolToInt(taxRate.applyOnDiscounts),
      DatabaseSchema.isActive: boolToInt(taxRate.isActive),
      DatabaseSchema.metadata: encodeMetadata(taxRate.metadata),
      DatabaseSchema.createdAt: dateTimeToMillis(taxRate.createdAt),
      DatabaseSchema.updatedAt: dateTimeToMillis(taxRate.updatedAt),
      DatabaseSchema.syncedAt: dateTimeToMillis(taxRate.syncedAt),
    };
  }
  
  /// Create TaxRate from database map
  factory TaxRateModel.fromDatabase(Map<String, dynamic> map) {
    final taxRate = _fromMap(map);
    return TaxRateModel(taxRate);
  }
  
  static TaxRate _fromMap(Map<String, dynamic> map) {
    return TaxRate(
      id: map[DatabaseSchema.id] as String,
      organizationId: map[DatabaseSchema.organizationId] as String,
      name: map['name'] as String,
      code: map['code'] as String,
      rate: (map['rate'] as num).toDouble(),
      type: _parseTaxType(map['type'] as String),
      description: map['description'] as String?,
      hsnCode: map['hsn_code'] as String?,
      sacCode: map['sac_code'] as String?,
      cgstRate: (map['cgst_rate'] as num?)?.toDouble(),
      sgstRate: (map['sgst_rate'] as num?)?.toDouble(),
      igstRate: (map['igst_rate'] as num?)?.toDouble(),
      cessRate: (map['cess_rate'] as num?)?.toDouble(),
      effectiveFrom: map['effective_from'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['effective_from'] as int)
          : null,
      effectiveTo: map['effective_to'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['effective_to'] as int)
          : null,
      country: map['country'] as String?,
      state: map['state'] as String?,
      isCompound: map['is_compound'] == 1,
      isInclusive: map['is_inclusive'] == 1,
      applyOnShipping: map['apply_on_shipping'] == 1,
      applyOnDiscounts: map['apply_on_discounts'] == 1,
      isActive: map[DatabaseSchema.isActive] == 1,
      metadata: _decodeMetadata(map[DatabaseSchema.metadata] as String?),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.createdAt] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.updatedAt] as int),
      syncedAt: map[DatabaseSchema.syncedAt] != null
          ? DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.syncedAt] as int)
          : null,
    );
  }
  
  static TaxType _parseTaxType(String type) {
    try {
      return TaxType.values.firstWhere((e) => e.name == type);
    } catch (_) {
      return TaxType.sales;
    }
  }
  
  static Map<String, dynamic> _decodeMetadata(String? metadata) {
    if (metadata == null || metadata.isEmpty) return {};
    try {
      return Map<String, dynamic>.from(json.decode(metadata));
    } catch (_) {
      return {};
    }
  }
}