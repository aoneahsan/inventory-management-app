// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'role.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Role _$RoleFromJson(Map<String, dynamic> json) {
  return _Role.fromJson(json);
}

/// @nodoc
mixin _$Role {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get organizationId => throw _privateConstructorUsedError;
  bool get isSystemRole => throw _privateConstructorUsedError;
  bool get isCustomRole => throw _privateConstructorUsedError;
  List<String> get permissions => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional fields
  String? get color => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError;
  int? get maxUsers => throw _privateConstructorUsedError;
  List<String> get inheritedRoles => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;
  String? get parentRoleId => throw _privateConstructorUsedError;

  /// Serializes this Role to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Role
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoleCopyWith<Role> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoleCopyWith<$Res> {
  factory $RoleCopyWith(Role value, $Res Function(Role) then) =
      _$RoleCopyWithImpl<$Res, Role>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String? organizationId,
      bool isSystemRole,
      bool isCustomRole,
      List<String> permissions,
      int sortOrder,
      bool isActive,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? color,
      String? icon,
      Map<String, dynamic> metadata,
      bool isDefault,
      int? maxUsers,
      List<String> inheritedRoles,
      String? createdBy,
      String? parentRoleId});
}

/// @nodoc
class _$RoleCopyWithImpl<$Res, $Val extends Role>
    implements $RoleCopyWith<$Res> {
  _$RoleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Role
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? organizationId = freezed,
    Object? isSystemRole = null,
    Object? isCustomRole = null,
    Object? permissions = null,
    Object? sortOrder = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? color = freezed,
    Object? icon = freezed,
    Object? metadata = null,
    Object? isDefault = null,
    Object? maxUsers = freezed,
    Object? inheritedRoles = null,
    Object? createdBy = freezed,
    Object? parentRoleId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
      isSystemRole: null == isSystemRole
          ? _value.isSystemRole
          : isSystemRole // ignore: cast_nullable_to_non_nullable
              as bool,
      isCustomRole: null == isCustomRole
          ? _value.isCustomRole
          : isCustomRole // ignore: cast_nullable_to_non_nullable
              as bool,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      maxUsers: freezed == maxUsers
          ? _value.maxUsers
          : maxUsers // ignore: cast_nullable_to_non_nullable
              as int?,
      inheritedRoles: null == inheritedRoles
          ? _value.inheritedRoles
          : inheritedRoles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      parentRoleId: freezed == parentRoleId
          ? _value.parentRoleId
          : parentRoleId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoleImplCopyWith<$Res> implements $RoleCopyWith<$Res> {
  factory _$$RoleImplCopyWith(
          _$RoleImpl value, $Res Function(_$RoleImpl) then) =
      __$$RoleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String? organizationId,
      bool isSystemRole,
      bool isCustomRole,
      List<String> permissions,
      int sortOrder,
      bool isActive,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? color,
      String? icon,
      Map<String, dynamic> metadata,
      bool isDefault,
      int? maxUsers,
      List<String> inheritedRoles,
      String? createdBy,
      String? parentRoleId});
}

/// @nodoc
class __$$RoleImplCopyWithImpl<$Res>
    extends _$RoleCopyWithImpl<$Res, _$RoleImpl>
    implements _$$RoleImplCopyWith<$Res> {
  __$$RoleImplCopyWithImpl(_$RoleImpl _value, $Res Function(_$RoleImpl) _then)
      : super(_value, _then);

  /// Create a copy of Role
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? organizationId = freezed,
    Object? isSystemRole = null,
    Object? isCustomRole = null,
    Object? permissions = null,
    Object? sortOrder = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? color = freezed,
    Object? icon = freezed,
    Object? metadata = null,
    Object? isDefault = null,
    Object? maxUsers = freezed,
    Object? inheritedRoles = null,
    Object? createdBy = freezed,
    Object? parentRoleId = freezed,
  }) {
    return _then(_$RoleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
      isSystemRole: null == isSystemRole
          ? _value.isSystemRole
          : isSystemRole // ignore: cast_nullable_to_non_nullable
              as bool,
      isCustomRole: null == isCustomRole
          ? _value.isCustomRole
          : isCustomRole // ignore: cast_nullable_to_non_nullable
              as bool,
      permissions: null == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      maxUsers: freezed == maxUsers
          ? _value.maxUsers
          : maxUsers // ignore: cast_nullable_to_non_nullable
              as int?,
      inheritedRoles: null == inheritedRoles
          ? _value._inheritedRoles
          : inheritedRoles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      parentRoleId: freezed == parentRoleId
          ? _value.parentRoleId
          : parentRoleId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoleImpl extends _Role {
  const _$RoleImpl(
      {required this.id,
      required this.name,
      required this.description,
      this.organizationId,
      this.isSystemRole = false,
      this.isCustomRole = false,
      final List<String> permissions = const [],
      this.sortOrder = 0,
      this.isActive = true,
      required this.createdAt,
      required this.updatedAt,
      this.syncedAt,
      this.color,
      this.icon,
      final Map<String, dynamic> metadata = const {},
      this.isDefault = false,
      this.maxUsers,
      final List<String> inheritedRoles = const [],
      this.createdBy,
      this.parentRoleId})
      : _permissions = permissions,
        _metadata = metadata,
        _inheritedRoles = inheritedRoles,
        super._();

  factory _$RoleImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoleImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String? organizationId;
  @override
  @JsonKey()
  final bool isSystemRole;
  @override
  @JsonKey()
  final bool isCustomRole;
  final List<String> _permissions;
  @override
  @JsonKey()
  List<String> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  @override
  @JsonKey()
  final int sortOrder;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? syncedAt;
// Additional fields
  @override
  final String? color;
  @override
  final String? icon;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  @JsonKey()
  final bool isDefault;
  @override
  final int? maxUsers;
  final List<String> _inheritedRoles;
  @override
  @JsonKey()
  List<String> get inheritedRoles {
    if (_inheritedRoles is EqualUnmodifiableListView) return _inheritedRoles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inheritedRoles);
  }

  @override
  final String? createdBy;
  @override
  final String? parentRoleId;

  @override
  String toString() {
    return 'Role(id: $id, name: $name, description: $description, organizationId: $organizationId, isSystemRole: $isSystemRole, isCustomRole: $isCustomRole, permissions: $permissions, sortOrder: $sortOrder, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt, color: $color, icon: $icon, metadata: $metadata, isDefault: $isDefault, maxUsers: $maxUsers, inheritedRoles: $inheritedRoles, createdBy: $createdBy, parentRoleId: $parentRoleId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.isSystemRole, isSystemRole) ||
                other.isSystemRole == isSystemRole) &&
            (identical(other.isCustomRole, isCustomRole) ||
                other.isCustomRole == isCustomRole) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.maxUsers, maxUsers) ||
                other.maxUsers == maxUsers) &&
            const DeepCollectionEquality()
                .equals(other._inheritedRoles, _inheritedRoles) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.parentRoleId, parentRoleId) ||
                other.parentRoleId == parentRoleId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        description,
        organizationId,
        isSystemRole,
        isCustomRole,
        const DeepCollectionEquality().hash(_permissions),
        sortOrder,
        isActive,
        createdAt,
        updatedAt,
        syncedAt,
        color,
        icon,
        const DeepCollectionEquality().hash(_metadata),
        isDefault,
        maxUsers,
        const DeepCollectionEquality().hash(_inheritedRoles),
        createdBy,
        parentRoleId
      ]);

  /// Create a copy of Role
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoleImplCopyWith<_$RoleImpl> get copyWith =>
      __$$RoleImplCopyWithImpl<_$RoleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoleImplToJson(
      this,
    );
  }
}

abstract class _Role extends Role {
  const factory _Role(
      {required final String id,
      required final String name,
      required final String description,
      final String? organizationId,
      final bool isSystemRole,
      final bool isCustomRole,
      final List<String> permissions,
      final int sortOrder,
      final bool isActive,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final DateTime? syncedAt,
      final String? color,
      final String? icon,
      final Map<String, dynamic> metadata,
      final bool isDefault,
      final int? maxUsers,
      final List<String> inheritedRoles,
      final String? createdBy,
      final String? parentRoleId}) = _$RoleImpl;
  const _Role._() : super._();

  factory _Role.fromJson(Map<String, dynamic> json) = _$RoleImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String? get organizationId;
  @override
  bool get isSystemRole;
  @override
  bool get isCustomRole;
  @override
  List<String> get permissions;
  @override
  int get sortOrder;
  @override
  bool get isActive;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get syncedAt; // Additional fields
  @override
  String? get color;
  @override
  String? get icon;
  @override
  Map<String, dynamic> get metadata;
  @override
  bool get isDefault;
  @override
  int? get maxUsers;
  @override
  List<String> get inheritedRoles;
  @override
  String? get createdBy;
  @override
  String? get parentRoleId;

  /// Create a copy of Role
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoleImplCopyWith<_$RoleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RoleTemplate _$RoleTemplateFromJson(Map<String, dynamic> json) {
  return _RoleTemplate.fromJson(json);
}

/// @nodoc
mixin _$RoleTemplate {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get permissions => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this RoleTemplate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoleTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoleTemplateCopyWith<RoleTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoleTemplateCopyWith<$Res> {
  factory $RoleTemplateCopyWith(
          RoleTemplate value, $Res Function(RoleTemplate) then) =
      _$RoleTemplateCopyWithImpl<$Res, RoleTemplate>;
  @useResult
  $Res call(
      {String name,
      String description,
      List<String> permissions,
      String? color,
      String? icon,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$RoleTemplateCopyWithImpl<$Res, $Val extends RoleTemplate>
    implements $RoleTemplateCopyWith<$Res> {
  _$RoleTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoleTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? permissions = null,
    Object? color = freezed,
    Object? icon = freezed,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoleTemplateImplCopyWith<$Res>
    implements $RoleTemplateCopyWith<$Res> {
  factory _$$RoleTemplateImplCopyWith(
          _$RoleTemplateImpl value, $Res Function(_$RoleTemplateImpl) then) =
      __$$RoleTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String description,
      List<String> permissions,
      String? color,
      String? icon,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$$RoleTemplateImplCopyWithImpl<$Res>
    extends _$RoleTemplateCopyWithImpl<$Res, _$RoleTemplateImpl>
    implements _$$RoleTemplateImplCopyWith<$Res> {
  __$$RoleTemplateImplCopyWithImpl(
      _$RoleTemplateImpl _value, $Res Function(_$RoleTemplateImpl) _then)
      : super(_value, _then);

  /// Create a copy of RoleTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? permissions = null,
    Object? color = freezed,
    Object? icon = freezed,
    Object? metadata = null,
  }) {
    return _then(_$RoleTemplateImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoleTemplateImpl extends _RoleTemplate {
  const _$RoleTemplateImpl(
      {required this.name,
      required this.description,
      required final List<String> permissions,
      this.color,
      this.icon,
      final Map<String, dynamic> metadata = const {}})
      : _permissions = permissions,
        _metadata = metadata,
        super._();

  factory _$RoleTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoleTemplateImplFromJson(json);

  @override
  final String name;
  @override
  final String description;
  final List<String> _permissions;
  @override
  List<String> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  @override
  final String? color;
  @override
  final String? icon;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'RoleTemplate(name: $name, description: $description, permissions: $permissions, color: $color, icon: $icon, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoleTemplateImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      description,
      const DeepCollectionEquality().hash(_permissions),
      color,
      icon,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of RoleTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoleTemplateImplCopyWith<_$RoleTemplateImpl> get copyWith =>
      __$$RoleTemplateImplCopyWithImpl<_$RoleTemplateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoleTemplateImplToJson(
      this,
    );
  }
}

abstract class _RoleTemplate extends RoleTemplate {
  const factory _RoleTemplate(
      {required final String name,
      required final String description,
      required final List<String> permissions,
      final String? color,
      final String? icon,
      final Map<String, dynamic> metadata}) = _$RoleTemplateImpl;
  const _RoleTemplate._() : super._();

  factory _RoleTemplate.fromJson(Map<String, dynamic> json) =
      _$RoleTemplateImpl.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  List<String> get permissions;
  @override
  String? get color;
  @override
  String? get icon;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of RoleTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoleTemplateImplCopyWith<_$RoleTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
