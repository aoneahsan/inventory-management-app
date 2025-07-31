import 'dart:convert';

import '../../domain/entities/user.dart';
import '../database/database_schema.dart';
import 'base_model.dart';

/// Database model for User entity
class UserModel extends BaseModel {
  final User user;
  
  UserModel(this.user);
  
  @override
  String get tableName => DatabaseSchema.usersTable;
  
  @override
  Map<String, dynamic> toDatabase() {
    return {
      DatabaseSchema.id: user.id,
      DatabaseSchema.organizationId: user.organizationId,
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
      'role_id': user.roleId,
      'branch_id': user.branchId,
      DatabaseSchema.isActive: boolToInt(user.isActive),
      'last_login_at': dateTimeToMillis(user.lastLoginAt),
      DatabaseSchema.metadata: encodeMetadata(user.metadata),
      DatabaseSchema.createdAt: dateTimeToMillis(user.createdAt),
      DatabaseSchema.updatedAt: dateTimeToMillis(user.updatedAt),
      DatabaseSchema.syncedAt: dateTimeToMillis(user.syncedAt),
    };
  }
  
  /// Create User from database map
  factory UserModel.fromDatabase(Map<String, dynamic> map) {
    final user = _fromMap(map);
    return UserModel(user);
  }
  
  static User _fromMap(Map<String, dynamic> map) {
    return User(
      id: map[DatabaseSchema.id] as String,
      organizationId: map[DatabaseSchema.organizationId] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String?,
      roleId: map['role_id'] as String?,
      branchId: map['branch_id'] as String?,
      isActive: map[DatabaseSchema.isActive] == 1,
      lastLoginAt: map['last_login_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['last_login_at'] as int)
          : null,
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