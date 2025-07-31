import 'dart:convert';

import '../../domain/entities/branch.dart';
import '../database/database_schema.dart';
import 'base_model.dart';

/// Database model for Branch entity
class BranchModel extends BaseModel {
  final Branch branch;
  
  BranchModel(this.branch);
  
  @override
  String get tableName => DatabaseSchema.branchesTable;
  
  @override
  Map<String, dynamic> toDatabase() {
    return {
      DatabaseSchema.id: branch.id,
      DatabaseSchema.organizationId: branch.organizationId,
      'name': branch.name,
      'code': branch.code,
      'type': branch.type?.name,
      'address': branch.address,
      'city': branch.city,
      'state': branch.state,
      'country': branch.country,
      'postal_code': branch.postalCode,
      'phone': branch.phone,
      'email': branch.email,
      'manager_id': branch.managerId,
      DatabaseSchema.isActive: boolToInt(branch.isActive),
      'is_warehouse': boolToInt(branch.isWarehouse),
      'can_sell': boolToInt(branch.canSell),
      DatabaseSchema.metadata: encodeMetadata(branch.metadata),
      DatabaseSchema.createdAt: dateTimeToMillis(branch.createdAt),
      DatabaseSchema.updatedAt: dateTimeToMillis(branch.updatedAt),
      DatabaseSchema.syncedAt: dateTimeToMillis(branch.syncedAt),
    };
  }
  
  /// Create Branch from database map
  factory BranchModel.fromDatabase(Map<String, dynamic> map) {
    final branch = _fromMap(map);
    return BranchModel(branch);
  }
  
  static Branch _fromMap(Map<String, dynamic> map) {
    return Branch(
      id: map[DatabaseSchema.id] as String,
      organizationId: map[DatabaseSchema.organizationId] as String,
      name: map['name'] as String,
      code: map['code'] as String,
      type: _parseBranchType(map['type'] as String?),
      address: map['address'] as String?,
      city: map['city'] as String?,
      state: map['state'] as String?,
      country: map['country'] as String?,
      postalCode: map['postal_code'] as String?,
      phone: map['phone'] as String?,
      email: map['email'] as String?,
      managerId: map['manager_id'] as String?,
      isActive: map[DatabaseSchema.isActive] == 1,
      isWarehouse: map['is_warehouse'] == 1,
      canSell: map['can_sell'] == 1,
      metadata: _decodeMetadata(map[DatabaseSchema.metadata] as String?),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.createdAt] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.updatedAt] as int),
      syncedAt: map[DatabaseSchema.syncedAt] != null
          ? DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.syncedAt] as int)
          : null,
    );
  }
  
  static BranchType? _parseBranchType(String? type) {
    if (type == null) return null;
    try {
      return BranchType.values.firstWhere((e) => e.name == type);
    } catch (_) {
      return BranchType.store;
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