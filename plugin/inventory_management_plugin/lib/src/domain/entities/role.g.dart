// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoleImpl _$$RoleImplFromJson(Map<String, dynamic> json) => _$RoleImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      organizationId: json['organizationId'] as String?,
      isSystemRole: json['isSystemRole'] as bool? ?? false,
      isCustomRole: json['isCustomRole'] as bool? ?? false,
      permissions: (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      color: json['color'] as String?,
      icon: json['icon'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      isDefault: json['isDefault'] as bool? ?? false,
      maxUsers: (json['maxUsers'] as num?)?.toInt(),
      inheritedRoles: (json['inheritedRoles'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdBy: json['createdBy'] as String?,
      parentRoleId: json['parentRoleId'] as String?,
    );

Map<String, dynamic> _$$RoleImplToJson(_$RoleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'organizationId': instance.organizationId,
      'isSystemRole': instance.isSystemRole,
      'isCustomRole': instance.isCustomRole,
      'permissions': instance.permissions,
      'sortOrder': instance.sortOrder,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'color': instance.color,
      'icon': instance.icon,
      'metadata': instance.metadata,
      'isDefault': instance.isDefault,
      'maxUsers': instance.maxUsers,
      'inheritedRoles': instance.inheritedRoles,
      'createdBy': instance.createdBy,
      'parentRoleId': instance.parentRoleId,
    };

_$RoleTemplateImpl _$$RoleTemplateImplFromJson(Map<String, dynamic> json) =>
    _$RoleTemplateImpl(
      name: json['name'] as String,
      description: json['description'] as String,
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      color: json['color'] as String?,
      icon: json['icon'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$RoleTemplateImplToJson(_$RoleTemplateImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'permissions': instance.permissions,
      'color': instance.color,
      'icon': instance.icon,
      'metadata': instance.metadata,
    };
