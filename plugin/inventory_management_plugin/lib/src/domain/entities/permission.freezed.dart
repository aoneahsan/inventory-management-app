// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permission.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Permission _$PermissionFromJson(Map<String, dynamic> json) {
  return _Permission.fromJson(json);
}

/// @nodoc
mixin _$Permission {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  PermissionCategory get category => throw _privateConstructorUsedError;
  bool get isSystemPermission => throw _privateConstructorUsedError;
  List<String> get dependencies => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional fields
  String? get module => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  int get priority => throw _privateConstructorUsedError;
  String? get groupName => throw _privateConstructorUsedError;

  /// Serializes this Permission to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Permission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PermissionCopyWith<Permission> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionCopyWith<$Res> {
  factory $PermissionCopyWith(
          Permission value, $Res Function(Permission) then) =
      _$PermissionCopyWithImpl<$Res, Permission>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      PermissionCategory category,
      bool isSystemPermission,
      List<String> dependencies,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? module,
      bool isActive,
      Map<String, dynamic> metadata,
      int priority,
      String? groupName});
}

/// @nodoc
class _$PermissionCopyWithImpl<$Res, $Val extends Permission>
    implements $PermissionCopyWith<$Res> {
  _$PermissionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Permission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? category = null,
    Object? isSystemPermission = null,
    Object? dependencies = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? module = freezed,
    Object? isActive = null,
    Object? metadata = null,
    Object? priority = null,
    Object? groupName = freezed,
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
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as PermissionCategory,
      isSystemPermission: null == isSystemPermission
          ? _value.isSystemPermission
          : isSystemPermission // ignore: cast_nullable_to_non_nullable
              as bool,
      dependencies: null == dependencies
          ? _value.dependencies
          : dependencies // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
      module: freezed == module
          ? _value.module
          : module // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      groupName: freezed == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PermissionImplCopyWith<$Res>
    implements $PermissionCopyWith<$Res> {
  factory _$$PermissionImplCopyWith(
          _$PermissionImpl value, $Res Function(_$PermissionImpl) then) =
      __$$PermissionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      PermissionCategory category,
      bool isSystemPermission,
      List<String> dependencies,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? module,
      bool isActive,
      Map<String, dynamic> metadata,
      int priority,
      String? groupName});
}

/// @nodoc
class __$$PermissionImplCopyWithImpl<$Res>
    extends _$PermissionCopyWithImpl<$Res, _$PermissionImpl>
    implements _$$PermissionImplCopyWith<$Res> {
  __$$PermissionImplCopyWithImpl(
      _$PermissionImpl _value, $Res Function(_$PermissionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Permission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? category = null,
    Object? isSystemPermission = null,
    Object? dependencies = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? module = freezed,
    Object? isActive = null,
    Object? metadata = null,
    Object? priority = null,
    Object? groupName = freezed,
  }) {
    return _then(_$PermissionImpl(
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
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as PermissionCategory,
      isSystemPermission: null == isSystemPermission
          ? _value.isSystemPermission
          : isSystemPermission // ignore: cast_nullable_to_non_nullable
              as bool,
      dependencies: null == dependencies
          ? _value._dependencies
          : dependencies // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
      module: freezed == module
          ? _value.module
          : module // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      groupName: freezed == groupName
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PermissionImpl extends _Permission {
  const _$PermissionImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.category,
      this.isSystemPermission = false,
      final List<String> dependencies = const [],
      required this.createdAt,
      required this.updatedAt,
      this.syncedAt,
      this.module,
      this.isActive = true,
      final Map<String, dynamic> metadata = const {},
      this.priority = 0,
      this.groupName})
      : _dependencies = dependencies,
        _metadata = metadata,
        super._();

  factory _$PermissionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PermissionImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final PermissionCategory category;
  @override
  @JsonKey()
  final bool isSystemPermission;
  final List<String> _dependencies;
  @override
  @JsonKey()
  List<String> get dependencies {
    if (_dependencies is EqualUnmodifiableListView) return _dependencies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dependencies);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? syncedAt;
// Additional fields
  @override
  final String? module;
  @override
  @JsonKey()
  final bool isActive;
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
  final int priority;
  @override
  final String? groupName;

  @override
  String toString() {
    return 'Permission(id: $id, name: $name, description: $description, category: $category, isSystemPermission: $isSystemPermission, dependencies: $dependencies, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt, module: $module, isActive: $isActive, metadata: $metadata, priority: $priority, groupName: $groupName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.isSystemPermission, isSystemPermission) ||
                other.isSystemPermission == isSystemPermission) &&
            const DeepCollectionEquality()
                .equals(other._dependencies, _dependencies) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.module, module) || other.module == module) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      category,
      isSystemPermission,
      const DeepCollectionEquality().hash(_dependencies),
      createdAt,
      updatedAt,
      syncedAt,
      module,
      isActive,
      const DeepCollectionEquality().hash(_metadata),
      priority,
      groupName);

  /// Create a copy of Permission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionImplCopyWith<_$PermissionImpl> get copyWith =>
      __$$PermissionImplCopyWithImpl<_$PermissionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PermissionImplToJson(
      this,
    );
  }
}

abstract class _Permission extends Permission {
  const factory _Permission(
      {required final String id,
      required final String name,
      required final String description,
      required final PermissionCategory category,
      final bool isSystemPermission,
      final List<String> dependencies,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final DateTime? syncedAt,
      final String? module,
      final bool isActive,
      final Map<String, dynamic> metadata,
      final int priority,
      final String? groupName}) = _$PermissionImpl;
  const _Permission._() : super._();

  factory _Permission.fromJson(Map<String, dynamic> json) =
      _$PermissionImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  PermissionCategory get category;
  @override
  bool get isSystemPermission;
  @override
  List<String> get dependencies;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get syncedAt; // Additional fields
  @override
  String? get module;
  @override
  bool get isActive;
  @override
  Map<String, dynamic> get metadata;
  @override
  int get priority;
  @override
  String? get groupName;

  /// Create a copy of Permission
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PermissionImplCopyWith<_$PermissionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RolePermission _$RolePermissionFromJson(Map<String, dynamic> json) {
  return _RolePermission.fromJson(json);
}

/// @nodoc
mixin _$RolePermission {
  String get roleId => throw _privateConstructorUsedError;
  String get permissionId => throw _privateConstructorUsedError;
  bool get granted => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt =>
      throw _privateConstructorUsedError; // Additional fields
  String? get grantedBy => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  Map<String, dynamic> get conditions => throw _privateConstructorUsedError;

  /// Serializes this RolePermission to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RolePermission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RolePermissionCopyWith<RolePermission> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RolePermissionCopyWith<$Res> {
  factory $RolePermissionCopyWith(
          RolePermission value, $Res Function(RolePermission) then) =
      _$RolePermissionCopyWithImpl<$Res, RolePermission>;
  @useResult
  $Res call(
      {String roleId,
      String permissionId,
      bool granted,
      DateTime createdAt,
      DateTime updatedAt,
      String? grantedBy,
      DateTime? expiresAt,
      Map<String, dynamic> conditions});
}

/// @nodoc
class _$RolePermissionCopyWithImpl<$Res, $Val extends RolePermission>
    implements $RolePermissionCopyWith<$Res> {
  _$RolePermissionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RolePermission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roleId = null,
    Object? permissionId = null,
    Object? granted = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? grantedBy = freezed,
    Object? expiresAt = freezed,
    Object? conditions = null,
  }) {
    return _then(_value.copyWith(
      roleId: null == roleId
          ? _value.roleId
          : roleId // ignore: cast_nullable_to_non_nullable
              as String,
      permissionId: null == permissionId
          ? _value.permissionId
          : permissionId // ignore: cast_nullable_to_non_nullable
              as String,
      granted: null == granted
          ? _value.granted
          : granted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      grantedBy: freezed == grantedBy
          ? _value.grantedBy
          : grantedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      conditions: null == conditions
          ? _value.conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RolePermissionImplCopyWith<$Res>
    implements $RolePermissionCopyWith<$Res> {
  factory _$$RolePermissionImplCopyWith(_$RolePermissionImpl value,
          $Res Function(_$RolePermissionImpl) then) =
      __$$RolePermissionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String roleId,
      String permissionId,
      bool granted,
      DateTime createdAt,
      DateTime updatedAt,
      String? grantedBy,
      DateTime? expiresAt,
      Map<String, dynamic> conditions});
}

/// @nodoc
class __$$RolePermissionImplCopyWithImpl<$Res>
    extends _$RolePermissionCopyWithImpl<$Res, _$RolePermissionImpl>
    implements _$$RolePermissionImplCopyWith<$Res> {
  __$$RolePermissionImplCopyWithImpl(
      _$RolePermissionImpl _value, $Res Function(_$RolePermissionImpl) _then)
      : super(_value, _then);

  /// Create a copy of RolePermission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roleId = null,
    Object? permissionId = null,
    Object? granted = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? grantedBy = freezed,
    Object? expiresAt = freezed,
    Object? conditions = null,
  }) {
    return _then(_$RolePermissionImpl(
      roleId: null == roleId
          ? _value.roleId
          : roleId // ignore: cast_nullable_to_non_nullable
              as String,
      permissionId: null == permissionId
          ? _value.permissionId
          : permissionId // ignore: cast_nullable_to_non_nullable
              as String,
      granted: null == granted
          ? _value.granted
          : granted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      grantedBy: freezed == grantedBy
          ? _value.grantedBy
          : grantedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      conditions: null == conditions
          ? _value._conditions
          : conditions // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RolePermissionImpl extends _RolePermission {
  const _$RolePermissionImpl(
      {required this.roleId,
      required this.permissionId,
      this.granted = true,
      required this.createdAt,
      required this.updatedAt,
      this.grantedBy,
      this.expiresAt,
      final Map<String, dynamic> conditions = const {}})
      : _conditions = conditions,
        super._();

  factory _$RolePermissionImpl.fromJson(Map<String, dynamic> json) =>
      _$$RolePermissionImplFromJson(json);

  @override
  final String roleId;
  @override
  final String permissionId;
  @override
  @JsonKey()
  final bool granted;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
// Additional fields
  @override
  final String? grantedBy;
  @override
  final DateTime? expiresAt;
  final Map<String, dynamic> _conditions;
  @override
  @JsonKey()
  Map<String, dynamic> get conditions {
    if (_conditions is EqualUnmodifiableMapView) return _conditions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_conditions);
  }

  @override
  String toString() {
    return 'RolePermission(roleId: $roleId, permissionId: $permissionId, granted: $granted, createdAt: $createdAt, updatedAt: $updatedAt, grantedBy: $grantedBy, expiresAt: $expiresAt, conditions: $conditions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RolePermissionImpl &&
            (identical(other.roleId, roleId) || other.roleId == roleId) &&
            (identical(other.permissionId, permissionId) ||
                other.permissionId == permissionId) &&
            (identical(other.granted, granted) || other.granted == granted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.grantedBy, grantedBy) ||
                other.grantedBy == grantedBy) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            const DeepCollectionEquality()
                .equals(other._conditions, _conditions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      roleId,
      permissionId,
      granted,
      createdAt,
      updatedAt,
      grantedBy,
      expiresAt,
      const DeepCollectionEquality().hash(_conditions));

  /// Create a copy of RolePermission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RolePermissionImplCopyWith<_$RolePermissionImpl> get copyWith =>
      __$$RolePermissionImplCopyWithImpl<_$RolePermissionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RolePermissionImplToJson(
      this,
    );
  }
}

abstract class _RolePermission extends RolePermission {
  const factory _RolePermission(
      {required final String roleId,
      required final String permissionId,
      final bool granted,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final String? grantedBy,
      final DateTime? expiresAt,
      final Map<String, dynamic> conditions}) = _$RolePermissionImpl;
  const _RolePermission._() : super._();

  factory _RolePermission.fromJson(Map<String, dynamic> json) =
      _$RolePermissionImpl.fromJson;

  @override
  String get roleId;
  @override
  String get permissionId;
  @override
  bool get granted;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt; // Additional fields
  @override
  String? get grantedBy;
  @override
  DateTime? get expiresAt;
  @override
  Map<String, dynamic> get conditions;

  /// Create a copy of RolePermission
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RolePermissionImplCopyWith<_$RolePermissionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
