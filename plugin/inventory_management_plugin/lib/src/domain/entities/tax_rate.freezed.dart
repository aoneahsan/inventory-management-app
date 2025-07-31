// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tax_rate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaxRate _$TaxRateFromJson(Map<String, dynamic> json) {
  return _TaxRate.fromJson(json);
}

/// @nodoc
mixin _$TaxRate {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  double get rate => throw _privateConstructorUsedError;
  TaxType get type => throw _privateConstructorUsedError;
  bool get isCompound => throw _privateConstructorUsedError;
  bool get isInclusive => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  double? get cgstRate => throw _privateConstructorUsedError;
  double? get sgstRate => throw _privateConstructorUsedError;
  double? get igstRate => throw _privateConstructorUsedError;
  double? get cessRate => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional fields
  String? get description => throw _privateConstructorUsedError;
  List<String> get applicableToCategories => throw _privateConstructorUsedError;
  List<String> get applicableToProducts => throw _privateConstructorUsedError;
  DateTime? get effectiveFrom => throw _privateConstructorUsedError;
  DateTime? get effectiveTo => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  int get priority => throw _privateConstructorUsedError;
  String? get parentTaxId => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError;

  /// Serializes this TaxRate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaxRate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaxRateCopyWith<TaxRate> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaxRateCopyWith<$Res> {
  factory $TaxRateCopyWith(TaxRate value, $Res Function(TaxRate) then) =
      _$TaxRateCopyWithImpl<$Res, TaxRate>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String name,
      String code,
      double rate,
      TaxType type,
      bool isCompound,
      bool isInclusive,
      bool isActive,
      double? cgstRate,
      double? sgstRate,
      double? igstRate,
      double? cessRate,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? description,
      List<String> applicableToCategories,
      List<String> applicableToProducts,
      DateTime? effectiveFrom,
      DateTime? effectiveTo,
      Map<String, dynamic> metadata,
      int priority,
      String? parentTaxId,
      bool isDefault});
}

/// @nodoc
class _$TaxRateCopyWithImpl<$Res, $Val extends TaxRate>
    implements $TaxRateCopyWith<$Res> {
  _$TaxRateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaxRate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? name = null,
    Object? code = null,
    Object? rate = null,
    Object? type = null,
    Object? isCompound = null,
    Object? isInclusive = null,
    Object? isActive = null,
    Object? cgstRate = freezed,
    Object? sgstRate = freezed,
    Object? igstRate = freezed,
    Object? cessRate = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? description = freezed,
    Object? applicableToCategories = null,
    Object? applicableToProducts = null,
    Object? effectiveFrom = freezed,
    Object? effectiveTo = freezed,
    Object? metadata = null,
    Object? priority = null,
    Object? parentTaxId = freezed,
    Object? isDefault = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TaxType,
      isCompound: null == isCompound
          ? _value.isCompound
          : isCompound // ignore: cast_nullable_to_non_nullable
              as bool,
      isInclusive: null == isInclusive
          ? _value.isInclusive
          : isInclusive // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      cgstRate: freezed == cgstRate
          ? _value.cgstRate
          : cgstRate // ignore: cast_nullable_to_non_nullable
              as double?,
      sgstRate: freezed == sgstRate
          ? _value.sgstRate
          : sgstRate // ignore: cast_nullable_to_non_nullable
              as double?,
      igstRate: freezed == igstRate
          ? _value.igstRate
          : igstRate // ignore: cast_nullable_to_non_nullable
              as double?,
      cessRate: freezed == cessRate
          ? _value.cessRate
          : cessRate // ignore: cast_nullable_to_non_nullable
              as double?,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      applicableToCategories: null == applicableToCategories
          ? _value.applicableToCategories
          : applicableToCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      applicableToProducts: null == applicableToProducts
          ? _value.applicableToProducts
          : applicableToProducts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      effectiveFrom: freezed == effectiveFrom
          ? _value.effectiveFrom
          : effectiveFrom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      effectiveTo: freezed == effectiveTo
          ? _value.effectiveTo
          : effectiveTo // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      parentTaxId: freezed == parentTaxId
          ? _value.parentTaxId
          : parentTaxId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaxRateImplCopyWith<$Res> implements $TaxRateCopyWith<$Res> {
  factory _$$TaxRateImplCopyWith(
          _$TaxRateImpl value, $Res Function(_$TaxRateImpl) then) =
      __$$TaxRateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String name,
      String code,
      double rate,
      TaxType type,
      bool isCompound,
      bool isInclusive,
      bool isActive,
      double? cgstRate,
      double? sgstRate,
      double? igstRate,
      double? cessRate,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? description,
      List<String> applicableToCategories,
      List<String> applicableToProducts,
      DateTime? effectiveFrom,
      DateTime? effectiveTo,
      Map<String, dynamic> metadata,
      int priority,
      String? parentTaxId,
      bool isDefault});
}

/// @nodoc
class __$$TaxRateImplCopyWithImpl<$Res>
    extends _$TaxRateCopyWithImpl<$Res, _$TaxRateImpl>
    implements _$$TaxRateImplCopyWith<$Res> {
  __$$TaxRateImplCopyWithImpl(
      _$TaxRateImpl _value, $Res Function(_$TaxRateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaxRate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? name = null,
    Object? code = null,
    Object? rate = null,
    Object? type = null,
    Object? isCompound = null,
    Object? isInclusive = null,
    Object? isActive = null,
    Object? cgstRate = freezed,
    Object? sgstRate = freezed,
    Object? igstRate = freezed,
    Object? cessRate = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? description = freezed,
    Object? applicableToCategories = null,
    Object? applicableToProducts = null,
    Object? effectiveFrom = freezed,
    Object? effectiveTo = freezed,
    Object? metadata = null,
    Object? priority = null,
    Object? parentTaxId = freezed,
    Object? isDefault = null,
  }) {
    return _then(_$TaxRateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      rate: null == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TaxType,
      isCompound: null == isCompound
          ? _value.isCompound
          : isCompound // ignore: cast_nullable_to_non_nullable
              as bool,
      isInclusive: null == isInclusive
          ? _value.isInclusive
          : isInclusive // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      cgstRate: freezed == cgstRate
          ? _value.cgstRate
          : cgstRate // ignore: cast_nullable_to_non_nullable
              as double?,
      sgstRate: freezed == sgstRate
          ? _value.sgstRate
          : sgstRate // ignore: cast_nullable_to_non_nullable
              as double?,
      igstRate: freezed == igstRate
          ? _value.igstRate
          : igstRate // ignore: cast_nullable_to_non_nullable
              as double?,
      cessRate: freezed == cessRate
          ? _value.cessRate
          : cessRate // ignore: cast_nullable_to_non_nullable
              as double?,
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      applicableToCategories: null == applicableToCategories
          ? _value._applicableToCategories
          : applicableToCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      applicableToProducts: null == applicableToProducts
          ? _value._applicableToProducts
          : applicableToProducts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      effectiveFrom: freezed == effectiveFrom
          ? _value.effectiveFrom
          : effectiveFrom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      effectiveTo: freezed == effectiveTo
          ? _value.effectiveTo
          : effectiveTo // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      parentTaxId: freezed == parentTaxId
          ? _value.parentTaxId
          : parentTaxId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaxRateImpl extends _TaxRate {
  const _$TaxRateImpl(
      {required this.id,
      required this.organizationId,
      required this.name,
      required this.code,
      required this.rate,
      required this.type,
      this.isCompound = false,
      this.isInclusive = false,
      this.isActive = true,
      this.cgstRate,
      this.sgstRate,
      this.igstRate,
      this.cessRate,
      required this.createdAt,
      required this.updatedAt,
      this.syncedAt,
      this.description,
      final List<String> applicableToCategories = const [],
      final List<String> applicableToProducts = const [],
      this.effectiveFrom,
      this.effectiveTo,
      final Map<String, dynamic> metadata = const {},
      this.priority = 0,
      this.parentTaxId,
      this.isDefault = false})
      : _applicableToCategories = applicableToCategories,
        _applicableToProducts = applicableToProducts,
        _metadata = metadata,
        super._();

  factory _$TaxRateImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaxRateImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String name;
  @override
  final String code;
  @override
  final double rate;
  @override
  final TaxType type;
  @override
  @JsonKey()
  final bool isCompound;
  @override
  @JsonKey()
  final bool isInclusive;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final double? cgstRate;
  @override
  final double? sgstRate;
  @override
  final double? igstRate;
  @override
  final double? cessRate;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? syncedAt;
// Additional fields
  @override
  final String? description;
  final List<String> _applicableToCategories;
  @override
  @JsonKey()
  List<String> get applicableToCategories {
    if (_applicableToCategories is EqualUnmodifiableListView)
      return _applicableToCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_applicableToCategories);
  }

  final List<String> _applicableToProducts;
  @override
  @JsonKey()
  List<String> get applicableToProducts {
    if (_applicableToProducts is EqualUnmodifiableListView)
      return _applicableToProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_applicableToProducts);
  }

  @override
  final DateTime? effectiveFrom;
  @override
  final DateTime? effectiveTo;
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
  final String? parentTaxId;
  @override
  @JsonKey()
  final bool isDefault;

  @override
  String toString() {
    return 'TaxRate(id: $id, organizationId: $organizationId, name: $name, code: $code, rate: $rate, type: $type, isCompound: $isCompound, isInclusive: $isInclusive, isActive: $isActive, cgstRate: $cgstRate, sgstRate: $sgstRate, igstRate: $igstRate, cessRate: $cessRate, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt, description: $description, applicableToCategories: $applicableToCategories, applicableToProducts: $applicableToProducts, effectiveFrom: $effectiveFrom, effectiveTo: $effectiveTo, metadata: $metadata, priority: $priority, parentTaxId: $parentTaxId, isDefault: $isDefault)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaxRateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isCompound, isCompound) ||
                other.isCompound == isCompound) &&
            (identical(other.isInclusive, isInclusive) ||
                other.isInclusive == isInclusive) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.cgstRate, cgstRate) ||
                other.cgstRate == cgstRate) &&
            (identical(other.sgstRate, sgstRate) ||
                other.sgstRate == sgstRate) &&
            (identical(other.igstRate, igstRate) ||
                other.igstRate == igstRate) &&
            (identical(other.cessRate, cessRate) ||
                other.cessRate == cessRate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
                other._applicableToCategories, _applicableToCategories) &&
            const DeepCollectionEquality()
                .equals(other._applicableToProducts, _applicableToProducts) &&
            (identical(other.effectiveFrom, effectiveFrom) ||
                other.effectiveFrom == effectiveFrom) &&
            (identical(other.effectiveTo, effectiveTo) ||
                other.effectiveTo == effectiveTo) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.parentTaxId, parentTaxId) ||
                other.parentTaxId == parentTaxId) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        organizationId,
        name,
        code,
        rate,
        type,
        isCompound,
        isInclusive,
        isActive,
        cgstRate,
        sgstRate,
        igstRate,
        cessRate,
        createdAt,
        updatedAt,
        syncedAt,
        description,
        const DeepCollectionEquality().hash(_applicableToCategories),
        const DeepCollectionEquality().hash(_applicableToProducts),
        effectiveFrom,
        effectiveTo,
        const DeepCollectionEquality().hash(_metadata),
        priority,
        parentTaxId,
        isDefault
      ]);

  /// Create a copy of TaxRate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaxRateImplCopyWith<_$TaxRateImpl> get copyWith =>
      __$$TaxRateImplCopyWithImpl<_$TaxRateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaxRateImplToJson(
      this,
    );
  }
}

abstract class _TaxRate extends TaxRate {
  const factory _TaxRate(
      {required final String id,
      required final String organizationId,
      required final String name,
      required final String code,
      required final double rate,
      required final TaxType type,
      final bool isCompound,
      final bool isInclusive,
      final bool isActive,
      final double? cgstRate,
      final double? sgstRate,
      final double? igstRate,
      final double? cessRate,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final DateTime? syncedAt,
      final String? description,
      final List<String> applicableToCategories,
      final List<String> applicableToProducts,
      final DateTime? effectiveFrom,
      final DateTime? effectiveTo,
      final Map<String, dynamic> metadata,
      final int priority,
      final String? parentTaxId,
      final bool isDefault}) = _$TaxRateImpl;
  const _TaxRate._() : super._();

  factory _TaxRate.fromJson(Map<String, dynamic> json) = _$TaxRateImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String get name;
  @override
  String get code;
  @override
  double get rate;
  @override
  TaxType get type;
  @override
  bool get isCompound;
  @override
  bool get isInclusive;
  @override
  bool get isActive;
  @override
  double? get cgstRate;
  @override
  double? get sgstRate;
  @override
  double? get igstRate;
  @override
  double? get cessRate;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get syncedAt; // Additional fields
  @override
  String? get description;
  @override
  List<String> get applicableToCategories;
  @override
  List<String> get applicableToProducts;
  @override
  DateTime? get effectiveFrom;
  @override
  DateTime? get effectiveTo;
  @override
  Map<String, dynamic> get metadata;
  @override
  int get priority;
  @override
  String? get parentTaxId;
  @override
  bool get isDefault;

  /// Create a copy of TaxRate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaxRateImplCopyWith<_$TaxRateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HsnCode _$HsnCodeFromJson(Map<String, dynamic> json) {
  return _HsnCode.fromJson(json);
}

/// @nodoc
mixin _$HsnCode {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get taxRateId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional fields
  String? get chapter => throw _privateConstructorUsedError;
  String? get section => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this HsnCode to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HsnCode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HsnCodeCopyWith<HsnCode> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HsnCodeCopyWith<$Res> {
  factory $HsnCodeCopyWith(HsnCode value, $Res Function(HsnCode) then) =
      _$HsnCodeCopyWithImpl<$Res, HsnCode>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String code,
      String? description,
      String? taxRateId,
      DateTime createdAt,
      DateTime? updatedAt,
      DateTime? syncedAt,
      String? chapter,
      String? section,
      Map<String, dynamic> metadata,
      bool isActive});
}

/// @nodoc
class _$HsnCodeCopyWithImpl<$Res, $Val extends HsnCode>
    implements $HsnCodeCopyWith<$Res> {
  _$HsnCodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HsnCode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? code = null,
    Object? description = freezed,
    Object? taxRateId = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? syncedAt = freezed,
    Object? chapter = freezed,
    Object? section = freezed,
    Object? metadata = null,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      taxRateId: freezed == taxRateId
          ? _value.taxRateId
          : taxRateId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      chapter: freezed == chapter
          ? _value.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as String?,
      section: freezed == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HsnCodeImplCopyWith<$Res> implements $HsnCodeCopyWith<$Res> {
  factory _$$HsnCodeImplCopyWith(
          _$HsnCodeImpl value, $Res Function(_$HsnCodeImpl) then) =
      __$$HsnCodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String code,
      String? description,
      String? taxRateId,
      DateTime createdAt,
      DateTime? updatedAt,
      DateTime? syncedAt,
      String? chapter,
      String? section,
      Map<String, dynamic> metadata,
      bool isActive});
}

/// @nodoc
class __$$HsnCodeImplCopyWithImpl<$Res>
    extends _$HsnCodeCopyWithImpl<$Res, _$HsnCodeImpl>
    implements _$$HsnCodeImplCopyWith<$Res> {
  __$$HsnCodeImplCopyWithImpl(
      _$HsnCodeImpl _value, $Res Function(_$HsnCodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of HsnCode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? code = null,
    Object? description = freezed,
    Object? taxRateId = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? syncedAt = freezed,
    Object? chapter = freezed,
    Object? section = freezed,
    Object? metadata = null,
    Object? isActive = null,
  }) {
    return _then(_$HsnCodeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      taxRateId: freezed == taxRateId
          ? _value.taxRateId
          : taxRateId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      chapter: freezed == chapter
          ? _value.chapter
          : chapter // ignore: cast_nullable_to_non_nullable
              as String?,
      section: freezed == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HsnCodeImpl extends _HsnCode {
  const _$HsnCodeImpl(
      {required this.id,
      required this.organizationId,
      required this.code,
      this.description,
      this.taxRateId,
      required this.createdAt,
      this.updatedAt,
      this.syncedAt,
      this.chapter,
      this.section,
      final Map<String, dynamic> metadata = const {},
      this.isActive = true})
      : _metadata = metadata,
        super._();

  factory _$HsnCodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$HsnCodeImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String code;
  @override
  final String? description;
  @override
  final String? taxRateId;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? syncedAt;
// Additional fields
  @override
  final String? chapter;
  @override
  final String? section;
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
  final bool isActive;

  @override
  String toString() {
    return 'HsnCode(id: $id, organizationId: $organizationId, code: $code, description: $description, taxRateId: $taxRateId, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt, chapter: $chapter, section: $section, metadata: $metadata, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HsnCodeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.taxRateId, taxRateId) ||
                other.taxRateId == taxRateId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.chapter, chapter) || other.chapter == chapter) &&
            (identical(other.section, section) || other.section == section) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      organizationId,
      code,
      description,
      taxRateId,
      createdAt,
      updatedAt,
      syncedAt,
      chapter,
      section,
      const DeepCollectionEquality().hash(_metadata),
      isActive);

  /// Create a copy of HsnCode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HsnCodeImplCopyWith<_$HsnCodeImpl> get copyWith =>
      __$$HsnCodeImplCopyWithImpl<_$HsnCodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HsnCodeImplToJson(
      this,
    );
  }
}

abstract class _HsnCode extends HsnCode {
  const factory _HsnCode(
      {required final String id,
      required final String organizationId,
      required final String code,
      final String? description,
      final String? taxRateId,
      required final DateTime createdAt,
      final DateTime? updatedAt,
      final DateTime? syncedAt,
      final String? chapter,
      final String? section,
      final Map<String, dynamic> metadata,
      final bool isActive}) = _$HsnCodeImpl;
  const _HsnCode._() : super._();

  factory _HsnCode.fromJson(Map<String, dynamic> json) = _$HsnCodeImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String get code;
  @override
  String? get description;
  @override
  String? get taxRateId;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get syncedAt; // Additional fields
  @override
  String? get chapter;
  @override
  String? get section;
  @override
  Map<String, dynamic> get metadata;
  @override
  bool get isActive;

  /// Create a copy of HsnCode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HsnCodeImplCopyWith<_$HsnCodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
