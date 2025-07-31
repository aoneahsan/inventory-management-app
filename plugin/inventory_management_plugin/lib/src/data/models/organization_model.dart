import 'dart:convert';

import '../../domain/entities/organization.dart';
import '../database/database_schema.dart';
import 'base_model.dart';

/// Database model for Organization entity
class OrganizationModel extends BaseModel {
  final Organization organization;
  
  OrganizationModel(this.organization);
  
  @override
  String get tableName => DatabaseSchema.organizationsTable;
  
  @override
  Map<String, dynamic> toDatabase() {
    return {
      DatabaseSchema.id: organization.id,
      'name': organization.name,
      'code': organization.code,
      'address': organization.address,
      'phone': organization.phone,
      'email': organization.email,
      'website': organization.website,
      'tax_number': organization.taxNumber,
      'logo_url': organization.logoUrl,
      'subscription_plan': organization.subscriptionPlan,
      'subscription_status': organization.subscriptionStatus,
      'subscription_end_date': dateTimeToMillis(organization.subscriptionEndDate),
      DatabaseSchema.isActive: boolToInt(organization.isActive),
      DatabaseSchema.metadata: encodeMetadata(organization.metadata),
      DatabaseSchema.createdAt: dateTimeToMillis(organization.createdAt),
      DatabaseSchema.updatedAt: dateTimeToMillis(organization.updatedAt),
      DatabaseSchema.syncedAt: dateTimeToMillis(organization.syncedAt),
    };
  }
  
  /// Create Organization from database map
  factory OrganizationModel.fromDatabase(Map<String, dynamic> map) {
    final organization = _fromMap(map);
    return OrganizationModel(organization);
  }
  
  static Organization _fromMap(Map<String, dynamic> map) {
    return Organization(
      id: map[DatabaseSchema.id] as String,
      name: map['name'] as String,
      code: map['code'] as String,
      address: map['address'] as String?,
      phone: map['phone'] as String?,
      email: map['email'] as String?,
      website: map['website'] as String?,
      taxNumber: map['tax_number'] as String?,
      logoUrl: map['logo_url'] as String?,
      subscriptionPlan: map['subscription_plan'] as String? ?? 'basic',
      subscriptionStatus: map['subscription_status'] as String? ?? 'active',
      subscriptionEndDate: map['subscription_end_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['subscription_end_date'] as int)
          : null,
      isActive: map[DatabaseSchema.isActive] == 1,
      metadata: _decodeMetadata(map[DatabaseSchema.metadata] as String?),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.createdAt] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.updatedAt] as int),
      syncedAt: map[DatabaseSchema.syncedAt] != null
          ? DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.syncedAt] as int)
          : null,
    );
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