// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PermissionImpl _$$PermissionImplFromJson(Map<String, dynamic> json) =>
    _$PermissionImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      category: $enumDecode(_$PermissionCategoryEnumMap, json['category']),
      isSystemPermission: json['isSystemPermission'] as bool? ?? false,
      dependencies: (json['dependencies'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      module: json['module'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      priority: (json['priority'] as num?)?.toInt() ?? 0,
      groupName: json['groupName'] as String?,
    );

Map<String, dynamic> _$$PermissionImplToJson(_$PermissionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': _$PermissionCategoryEnumMap[instance.category]!,
      'isSystemPermission': instance.isSystemPermission,
      'dependencies': instance.dependencies,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'module': instance.module,
      'isActive': instance.isActive,
      'metadata': instance.metadata,
      'priority': instance.priority,
      'groupName': instance.groupName,
    };

const _$PermissionCategoryEnumMap = {
  PermissionCategory.system: 'system',
  PermissionCategory.organization: 'organization',
  PermissionCategory.inventory: 'inventory',
  PermissionCategory.sales: 'sales',
  PermissionCategory.purchase: 'purchase',
  PermissionCategory.users: 'users',
  PermissionCategory.reports: 'reports',
  PermissionCategory.settings: 'settings',
  PermissionCategory.pos: 'pos',
  PermissionCategory.finance: 'finance',
};

_$RolePermissionImpl _$$RolePermissionImplFromJson(Map<String, dynamic> json) =>
    _$RolePermissionImpl(
      roleId: json['roleId'] as String,
      permissionId: json['permissionId'] as String,
      granted: json['granted'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      grantedBy: json['grantedBy'] as String?,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      conditions: json['conditions'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$RolePermissionImplToJson(
        _$RolePermissionImpl instance) =>
    <String, dynamic>{
      'roleId': instance.roleId,
      'permissionId': instance.permissionId,
      'granted': instance.granted,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'grantedBy': instance.grantedBy,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'conditions': instance.conditions,
    };
