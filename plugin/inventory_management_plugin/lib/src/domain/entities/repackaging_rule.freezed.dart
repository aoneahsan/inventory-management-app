// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repackaging_rule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RepackagingRule _$RepackagingRuleFromJson(Map<String, dynamic> json) {
  return _RepackagingRule.fromJson(json);
}

/// @nodoc
mixin _$RepackagingRule {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get fromProductId => throw _privateConstructorUsedError;
  String get toProductId => throw _privateConstructorUsedError;
  double get conversionRate => throw _privateConstructorUsedError;
  String? get ruleName => throw _privateConstructorUsedError;
  double get conversionFactor => throw _privateConstructorUsedError;
  bool get requiresApproval => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional fields
  RepackagingType get type => throw _privateConstructorUsedError;
  String? get fromProductName => throw _privateConstructorUsedError;
  String? get toProductName => throw _privateConstructorUsedError;
  String? get fromUnit => throw _privateConstructorUsedError;
  String? get toUnit => throw _privateConstructorUsedError;
  double? get wastagePercentage => throw _privateConstructorUsedError;
  double? get laborCost => throw _privateConstructorUsedError;
  double? get packagingCost => throw _privateConstructorUsedError;
  double? get otherCosts => throw _privateConstructorUsedError;
  int get processingTimeMinutes => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get instructions => throw _privateConstructorUsedError;
  List<String> get requiredTools => throw _privateConstructorUsedError;
  Map<String, dynamic> get qualityChecks => throw _privateConstructorUsedError;
  bool get trackBatches => throw _privateConstructorUsedError;
  bool get maintainSerialNumbers => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;
  int get priority => throw _privateConstructorUsedError;
  double? get minQuantity => throw _privateConstructorUsedError;
  double? get maxQuantity => throw _privateConstructorUsedError;
  List<RepackagingComponent> get additionalComponents =>
      throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this RepackagingRule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RepackagingRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RepackagingRuleCopyWith<RepackagingRule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepackagingRuleCopyWith<$Res> {
  factory $RepackagingRuleCopyWith(
          RepackagingRule value, $Res Function(RepackagingRule) then) =
      _$RepackagingRuleCopyWithImpl<$Res, RepackagingRule>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String fromProductId,
      String toProductId,
      double conversionRate,
      String? ruleName,
      double conversionFactor,
      bool requiresApproval,
      bool isActive,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      RepackagingType type,
      String? fromProductName,
      String? toProductName,
      String? fromUnit,
      String? toUnit,
      double? wastagePercentage,
      double? laborCost,
      double? packagingCost,
      double? otherCosts,
      int processingTimeMinutes,
      String? description,
      String? instructions,
      List<String> requiredTools,
      Map<String, dynamic> qualityChecks,
      bool trackBatches,
      bool maintainSerialNumbers,
      String? categoryId,
      int priority,
      double? minQuantity,
      double? maxQuantity,
      List<RepackagingComponent> additionalComponents,
      String? createdBy,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$RepackagingRuleCopyWithImpl<$Res, $Val extends RepackagingRule>
    implements $RepackagingRuleCopyWith<$Res> {
  _$RepackagingRuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RepackagingRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? fromProductId = null,
    Object? toProductId = null,
    Object? conversionRate = null,
    Object? ruleName = freezed,
    Object? conversionFactor = null,
    Object? requiresApproval = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? type = null,
    Object? fromProductName = freezed,
    Object? toProductName = freezed,
    Object? fromUnit = freezed,
    Object? toUnit = freezed,
    Object? wastagePercentage = freezed,
    Object? laborCost = freezed,
    Object? packagingCost = freezed,
    Object? otherCosts = freezed,
    Object? processingTimeMinutes = null,
    Object? description = freezed,
    Object? instructions = freezed,
    Object? requiredTools = null,
    Object? qualityChecks = null,
    Object? trackBatches = null,
    Object? maintainSerialNumbers = null,
    Object? categoryId = freezed,
    Object? priority = null,
    Object? minQuantity = freezed,
    Object? maxQuantity = freezed,
    Object? additionalComponents = null,
    Object? createdBy = freezed,
    Object? metadata = null,
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
      fromProductId: null == fromProductId
          ? _value.fromProductId
          : fromProductId // ignore: cast_nullable_to_non_nullable
              as String,
      toProductId: null == toProductId
          ? _value.toProductId
          : toProductId // ignore: cast_nullable_to_non_nullable
              as String,
      conversionRate: null == conversionRate
          ? _value.conversionRate
          : conversionRate // ignore: cast_nullable_to_non_nullable
              as double,
      ruleName: freezed == ruleName
          ? _value.ruleName
          : ruleName // ignore: cast_nullable_to_non_nullable
              as String?,
      conversionFactor: null == conversionFactor
          ? _value.conversionFactor
          : conversionFactor // ignore: cast_nullable_to_non_nullable
              as double,
      requiresApproval: null == requiresApproval
          ? _value.requiresApproval
          : requiresApproval // ignore: cast_nullable_to_non_nullable
              as bool,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RepackagingType,
      fromProductName: freezed == fromProductName
          ? _value.fromProductName
          : fromProductName // ignore: cast_nullable_to_non_nullable
              as String?,
      toProductName: freezed == toProductName
          ? _value.toProductName
          : toProductName // ignore: cast_nullable_to_non_nullable
              as String?,
      fromUnit: freezed == fromUnit
          ? _value.fromUnit
          : fromUnit // ignore: cast_nullable_to_non_nullable
              as String?,
      toUnit: freezed == toUnit
          ? _value.toUnit
          : toUnit // ignore: cast_nullable_to_non_nullable
              as String?,
      wastagePercentage: freezed == wastagePercentage
          ? _value.wastagePercentage
          : wastagePercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      laborCost: freezed == laborCost
          ? _value.laborCost
          : laborCost // ignore: cast_nullable_to_non_nullable
              as double?,
      packagingCost: freezed == packagingCost
          ? _value.packagingCost
          : packagingCost // ignore: cast_nullable_to_non_nullable
              as double?,
      otherCosts: freezed == otherCosts
          ? _value.otherCosts
          : otherCosts // ignore: cast_nullable_to_non_nullable
              as double?,
      processingTimeMinutes: null == processingTimeMinutes
          ? _value.processingTimeMinutes
          : processingTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      instructions: freezed == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as String?,
      requiredTools: null == requiredTools
          ? _value.requiredTools
          : requiredTools // ignore: cast_nullable_to_non_nullable
              as List<String>,
      qualityChecks: null == qualityChecks
          ? _value.qualityChecks
          : qualityChecks // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      trackBatches: null == trackBatches
          ? _value.trackBatches
          : trackBatches // ignore: cast_nullable_to_non_nullable
              as bool,
      maintainSerialNumbers: null == maintainSerialNumbers
          ? _value.maintainSerialNumbers
          : maintainSerialNumbers // ignore: cast_nullable_to_non_nullable
              as bool,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      minQuantity: freezed == minQuantity
          ? _value.minQuantity
          : minQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      maxQuantity: freezed == maxQuantity
          ? _value.maxQuantity
          : maxQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      additionalComponents: null == additionalComponents
          ? _value.additionalComponents
          : additionalComponents // ignore: cast_nullable_to_non_nullable
              as List<RepackagingComponent>,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RepackagingRuleImplCopyWith<$Res>
    implements $RepackagingRuleCopyWith<$Res> {
  factory _$$RepackagingRuleImplCopyWith(_$RepackagingRuleImpl value,
          $Res Function(_$RepackagingRuleImpl) then) =
      __$$RepackagingRuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String fromProductId,
      String toProductId,
      double conversionRate,
      String? ruleName,
      double conversionFactor,
      bool requiresApproval,
      bool isActive,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      RepackagingType type,
      String? fromProductName,
      String? toProductName,
      String? fromUnit,
      String? toUnit,
      double? wastagePercentage,
      double? laborCost,
      double? packagingCost,
      double? otherCosts,
      int processingTimeMinutes,
      String? description,
      String? instructions,
      List<String> requiredTools,
      Map<String, dynamic> qualityChecks,
      bool trackBatches,
      bool maintainSerialNumbers,
      String? categoryId,
      int priority,
      double? minQuantity,
      double? maxQuantity,
      List<RepackagingComponent> additionalComponents,
      String? createdBy,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$$RepackagingRuleImplCopyWithImpl<$Res>
    extends _$RepackagingRuleCopyWithImpl<$Res, _$RepackagingRuleImpl>
    implements _$$RepackagingRuleImplCopyWith<$Res> {
  __$$RepackagingRuleImplCopyWithImpl(
      _$RepackagingRuleImpl _value, $Res Function(_$RepackagingRuleImpl) _then)
      : super(_value, _then);

  /// Create a copy of RepackagingRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? fromProductId = null,
    Object? toProductId = null,
    Object? conversionRate = null,
    Object? ruleName = freezed,
    Object? conversionFactor = null,
    Object? requiresApproval = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? type = null,
    Object? fromProductName = freezed,
    Object? toProductName = freezed,
    Object? fromUnit = freezed,
    Object? toUnit = freezed,
    Object? wastagePercentage = freezed,
    Object? laborCost = freezed,
    Object? packagingCost = freezed,
    Object? otherCosts = freezed,
    Object? processingTimeMinutes = null,
    Object? description = freezed,
    Object? instructions = freezed,
    Object? requiredTools = null,
    Object? qualityChecks = null,
    Object? trackBatches = null,
    Object? maintainSerialNumbers = null,
    Object? categoryId = freezed,
    Object? priority = null,
    Object? minQuantity = freezed,
    Object? maxQuantity = freezed,
    Object? additionalComponents = null,
    Object? createdBy = freezed,
    Object? metadata = null,
  }) {
    return _then(_$RepackagingRuleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      fromProductId: null == fromProductId
          ? _value.fromProductId
          : fromProductId // ignore: cast_nullable_to_non_nullable
              as String,
      toProductId: null == toProductId
          ? _value.toProductId
          : toProductId // ignore: cast_nullable_to_non_nullable
              as String,
      conversionRate: null == conversionRate
          ? _value.conversionRate
          : conversionRate // ignore: cast_nullable_to_non_nullable
              as double,
      ruleName: freezed == ruleName
          ? _value.ruleName
          : ruleName // ignore: cast_nullable_to_non_nullable
              as String?,
      conversionFactor: null == conversionFactor
          ? _value.conversionFactor
          : conversionFactor // ignore: cast_nullable_to_non_nullable
              as double,
      requiresApproval: null == requiresApproval
          ? _value.requiresApproval
          : requiresApproval // ignore: cast_nullable_to_non_nullable
              as bool,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RepackagingType,
      fromProductName: freezed == fromProductName
          ? _value.fromProductName
          : fromProductName // ignore: cast_nullable_to_non_nullable
              as String?,
      toProductName: freezed == toProductName
          ? _value.toProductName
          : toProductName // ignore: cast_nullable_to_non_nullable
              as String?,
      fromUnit: freezed == fromUnit
          ? _value.fromUnit
          : fromUnit // ignore: cast_nullable_to_non_nullable
              as String?,
      toUnit: freezed == toUnit
          ? _value.toUnit
          : toUnit // ignore: cast_nullable_to_non_nullable
              as String?,
      wastagePercentage: freezed == wastagePercentage
          ? _value.wastagePercentage
          : wastagePercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      laborCost: freezed == laborCost
          ? _value.laborCost
          : laborCost // ignore: cast_nullable_to_non_nullable
              as double?,
      packagingCost: freezed == packagingCost
          ? _value.packagingCost
          : packagingCost // ignore: cast_nullable_to_non_nullable
              as double?,
      otherCosts: freezed == otherCosts
          ? _value.otherCosts
          : otherCosts // ignore: cast_nullable_to_non_nullable
              as double?,
      processingTimeMinutes: null == processingTimeMinutes
          ? _value.processingTimeMinutes
          : processingTimeMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      instructions: freezed == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as String?,
      requiredTools: null == requiredTools
          ? _value._requiredTools
          : requiredTools // ignore: cast_nullable_to_non_nullable
              as List<String>,
      qualityChecks: null == qualityChecks
          ? _value._qualityChecks
          : qualityChecks // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      trackBatches: null == trackBatches
          ? _value.trackBatches
          : trackBatches // ignore: cast_nullable_to_non_nullable
              as bool,
      maintainSerialNumbers: null == maintainSerialNumbers
          ? _value.maintainSerialNumbers
          : maintainSerialNumbers // ignore: cast_nullable_to_non_nullable
              as bool,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      minQuantity: freezed == minQuantity
          ? _value.minQuantity
          : minQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      maxQuantity: freezed == maxQuantity
          ? _value.maxQuantity
          : maxQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      additionalComponents: null == additionalComponents
          ? _value._additionalComponents
          : additionalComponents // ignore: cast_nullable_to_non_nullable
              as List<RepackagingComponent>,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
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
class _$RepackagingRuleImpl extends _RepackagingRule {
  const _$RepackagingRuleImpl(
      {required this.id,
      required this.organizationId,
      required this.fromProductId,
      required this.toProductId,
      required this.conversionRate,
      this.ruleName,
      this.conversionFactor = 1.0,
      this.requiresApproval = false,
      this.isActive = true,
      required this.createdAt,
      required this.updatedAt,
      this.syncedAt,
      this.type = RepackagingType.transform,
      this.fromProductName,
      this.toProductName,
      this.fromUnit,
      this.toUnit,
      this.wastagePercentage,
      this.laborCost,
      this.packagingCost,
      this.otherCosts,
      this.processingTimeMinutes = 0,
      this.description,
      this.instructions,
      final List<String> requiredTools = const [],
      final Map<String, dynamic> qualityChecks = const {},
      this.trackBatches = false,
      this.maintainSerialNumbers = false,
      this.categoryId,
      this.priority = 0,
      this.minQuantity,
      this.maxQuantity,
      final List<RepackagingComponent> additionalComponents = const [],
      this.createdBy,
      final Map<String, dynamic> metadata = const {}})
      : _requiredTools = requiredTools,
        _qualityChecks = qualityChecks,
        _additionalComponents = additionalComponents,
        _metadata = metadata,
        super._();

  factory _$RepackagingRuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$RepackagingRuleImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String fromProductId;
  @override
  final String toProductId;
  @override
  final double conversionRate;
  @override
  final String? ruleName;
  @override
  @JsonKey()
  final double conversionFactor;
  @override
  @JsonKey()
  final bool requiresApproval;
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
  @JsonKey()
  final RepackagingType type;
  @override
  final String? fromProductName;
  @override
  final String? toProductName;
  @override
  final String? fromUnit;
  @override
  final String? toUnit;
  @override
  final double? wastagePercentage;
  @override
  final double? laborCost;
  @override
  final double? packagingCost;
  @override
  final double? otherCosts;
  @override
  @JsonKey()
  final int processingTimeMinutes;
  @override
  final String? description;
  @override
  final String? instructions;
  final List<String> _requiredTools;
  @override
  @JsonKey()
  List<String> get requiredTools {
    if (_requiredTools is EqualUnmodifiableListView) return _requiredTools;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requiredTools);
  }

  final Map<String, dynamic> _qualityChecks;
  @override
  @JsonKey()
  Map<String, dynamic> get qualityChecks {
    if (_qualityChecks is EqualUnmodifiableMapView) return _qualityChecks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_qualityChecks);
  }

  @override
  @JsonKey()
  final bool trackBatches;
  @override
  @JsonKey()
  final bool maintainSerialNumbers;
  @override
  final String? categoryId;
  @override
  @JsonKey()
  final int priority;
  @override
  final double? minQuantity;
  @override
  final double? maxQuantity;
  final List<RepackagingComponent> _additionalComponents;
  @override
  @JsonKey()
  List<RepackagingComponent> get additionalComponents {
    if (_additionalComponents is EqualUnmodifiableListView)
      return _additionalComponents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_additionalComponents);
  }

  @override
  final String? createdBy;
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
    return 'RepackagingRule(id: $id, organizationId: $organizationId, fromProductId: $fromProductId, toProductId: $toProductId, conversionRate: $conversionRate, ruleName: $ruleName, conversionFactor: $conversionFactor, requiresApproval: $requiresApproval, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt, type: $type, fromProductName: $fromProductName, toProductName: $toProductName, fromUnit: $fromUnit, toUnit: $toUnit, wastagePercentage: $wastagePercentage, laborCost: $laborCost, packagingCost: $packagingCost, otherCosts: $otherCosts, processingTimeMinutes: $processingTimeMinutes, description: $description, instructions: $instructions, requiredTools: $requiredTools, qualityChecks: $qualityChecks, trackBatches: $trackBatches, maintainSerialNumbers: $maintainSerialNumbers, categoryId: $categoryId, priority: $priority, minQuantity: $minQuantity, maxQuantity: $maxQuantity, additionalComponents: $additionalComponents, createdBy: $createdBy, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepackagingRuleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.fromProductId, fromProductId) ||
                other.fromProductId == fromProductId) &&
            (identical(other.toProductId, toProductId) ||
                other.toProductId == toProductId) &&
            (identical(other.conversionRate, conversionRate) ||
                other.conversionRate == conversionRate) &&
            (identical(other.ruleName, ruleName) ||
                other.ruleName == ruleName) &&
            (identical(other.conversionFactor, conversionFactor) ||
                other.conversionFactor == conversionFactor) &&
            (identical(other.requiresApproval, requiresApproval) ||
                other.requiresApproval == requiresApproval) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.fromProductName, fromProductName) ||
                other.fromProductName == fromProductName) &&
            (identical(other.toProductName, toProductName) ||
                other.toProductName == toProductName) &&
            (identical(other.fromUnit, fromUnit) ||
                other.fromUnit == fromUnit) &&
            (identical(other.toUnit, toUnit) || other.toUnit == toUnit) &&
            (identical(other.wastagePercentage, wastagePercentage) ||
                other.wastagePercentage == wastagePercentage) &&
            (identical(other.laborCost, laborCost) ||
                other.laborCost == laborCost) &&
            (identical(other.packagingCost, packagingCost) ||
                other.packagingCost == packagingCost) &&
            (identical(other.otherCosts, otherCosts) ||
                other.otherCosts == otherCosts) &&
            (identical(other.processingTimeMinutes, processingTimeMinutes) ||
                other.processingTimeMinutes == processingTimeMinutes) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.instructions, instructions) ||
                other.instructions == instructions) &&
            const DeepCollectionEquality()
                .equals(other._requiredTools, _requiredTools) &&
            const DeepCollectionEquality()
                .equals(other._qualityChecks, _qualityChecks) &&
            (identical(other.trackBatches, trackBatches) ||
                other.trackBatches == trackBatches) &&
            (identical(other.maintainSerialNumbers, maintainSerialNumbers) ||
                other.maintainSerialNumbers == maintainSerialNumbers) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.minQuantity, minQuantity) ||
                other.minQuantity == minQuantity) &&
            (identical(other.maxQuantity, maxQuantity) ||
                other.maxQuantity == maxQuantity) &&
            const DeepCollectionEquality()
                .equals(other._additionalComponents, _additionalComponents) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        organizationId,
        fromProductId,
        toProductId,
        conversionRate,
        ruleName,
        conversionFactor,
        requiresApproval,
        isActive,
        createdAt,
        updatedAt,
        syncedAt,
        type,
        fromProductName,
        toProductName,
        fromUnit,
        toUnit,
        wastagePercentage,
        laborCost,
        packagingCost,
        otherCosts,
        processingTimeMinutes,
        description,
        instructions,
        const DeepCollectionEquality().hash(_requiredTools),
        const DeepCollectionEquality().hash(_qualityChecks),
        trackBatches,
        maintainSerialNumbers,
        categoryId,
        priority,
        minQuantity,
        maxQuantity,
        const DeepCollectionEquality().hash(_additionalComponents),
        createdBy,
        const DeepCollectionEquality().hash(_metadata)
      ]);

  /// Create a copy of RepackagingRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RepackagingRuleImplCopyWith<_$RepackagingRuleImpl> get copyWith =>
      __$$RepackagingRuleImplCopyWithImpl<_$RepackagingRuleImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RepackagingRuleImplToJson(
      this,
    );
  }
}

abstract class _RepackagingRule extends RepackagingRule {
  const factory _RepackagingRule(
      {required final String id,
      required final String organizationId,
      required final String fromProductId,
      required final String toProductId,
      required final double conversionRate,
      final String? ruleName,
      final double conversionFactor,
      final bool requiresApproval,
      final bool isActive,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final DateTime? syncedAt,
      final RepackagingType type,
      final String? fromProductName,
      final String? toProductName,
      final String? fromUnit,
      final String? toUnit,
      final double? wastagePercentage,
      final double? laborCost,
      final double? packagingCost,
      final double? otherCosts,
      final int processingTimeMinutes,
      final String? description,
      final String? instructions,
      final List<String> requiredTools,
      final Map<String, dynamic> qualityChecks,
      final bool trackBatches,
      final bool maintainSerialNumbers,
      final String? categoryId,
      final int priority,
      final double? minQuantity,
      final double? maxQuantity,
      final List<RepackagingComponent> additionalComponents,
      final String? createdBy,
      final Map<String, dynamic> metadata}) = _$RepackagingRuleImpl;
  const _RepackagingRule._() : super._();

  factory _RepackagingRule.fromJson(Map<String, dynamic> json) =
      _$RepackagingRuleImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String get fromProductId;
  @override
  String get toProductId;
  @override
  double get conversionRate;
  @override
  String? get ruleName;
  @override
  double get conversionFactor;
  @override
  bool get requiresApproval;
  @override
  bool get isActive;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get syncedAt; // Additional fields
  @override
  RepackagingType get type;
  @override
  String? get fromProductName;
  @override
  String? get toProductName;
  @override
  String? get fromUnit;
  @override
  String? get toUnit;
  @override
  double? get wastagePercentage;
  @override
  double? get laborCost;
  @override
  double? get packagingCost;
  @override
  double? get otherCosts;
  @override
  int get processingTimeMinutes;
  @override
  String? get description;
  @override
  String? get instructions;
  @override
  List<String> get requiredTools;
  @override
  Map<String, dynamic> get qualityChecks;
  @override
  bool get trackBatches;
  @override
  bool get maintainSerialNumbers;
  @override
  String? get categoryId;
  @override
  int get priority;
  @override
  double? get minQuantity;
  @override
  double? get maxQuantity;
  @override
  List<RepackagingComponent> get additionalComponents;
  @override
  String? get createdBy;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of RepackagingRule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RepackagingRuleImplCopyWith<_$RepackagingRuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RepackagingComponent _$RepackagingComponentFromJson(Map<String, dynamic> json) {
  return _RepackagingComponent.fromJson(json);
}

/// @nodoc
mixin _$RepackagingComponent {
  String get productId => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  double get unitCost => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this RepackagingComponent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RepackagingComponent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RepackagingComponentCopyWith<RepackagingComponent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepackagingComponentCopyWith<$Res> {
  factory $RepackagingComponentCopyWith(RepackagingComponent value,
          $Res Function(RepackagingComponent) then) =
      _$RepackagingComponentCopyWithImpl<$Res, RepackagingComponent>;
  @useResult
  $Res call(
      {String productId,
      String productName,
      double quantity,
      double unitCost,
      String? unit,
      String? notes});
}

/// @nodoc
class _$RepackagingComponentCopyWithImpl<$Res,
        $Val extends RepackagingComponent>
    implements $RepackagingComponentCopyWith<$Res> {
  _$RepackagingComponentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RepackagingComponent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? productName = null,
    Object? quantity = null,
    Object? unitCost = null,
    Object? unit = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitCost: null == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RepackagingComponentImplCopyWith<$Res>
    implements $RepackagingComponentCopyWith<$Res> {
  factory _$$RepackagingComponentImplCopyWith(_$RepackagingComponentImpl value,
          $Res Function(_$RepackagingComponentImpl) then) =
      __$$RepackagingComponentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String productId,
      String productName,
      double quantity,
      double unitCost,
      String? unit,
      String? notes});
}

/// @nodoc
class __$$RepackagingComponentImplCopyWithImpl<$Res>
    extends _$RepackagingComponentCopyWithImpl<$Res, _$RepackagingComponentImpl>
    implements _$$RepackagingComponentImplCopyWith<$Res> {
  __$$RepackagingComponentImplCopyWithImpl(_$RepackagingComponentImpl _value,
      $Res Function(_$RepackagingComponentImpl) _then)
      : super(_value, _then);

  /// Create a copy of RepackagingComponent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? productName = null,
    Object? quantity = null,
    Object? unitCost = null,
    Object? unit = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$RepackagingComponentImpl(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitCost: null == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RepackagingComponentImpl extends _RepackagingComponent {
  const _$RepackagingComponentImpl(
      {required this.productId,
      required this.productName,
      required this.quantity,
      this.unitCost = 0,
      this.unit,
      this.notes})
      : super._();

  factory _$RepackagingComponentImpl.fromJson(Map<String, dynamic> json) =>
      _$$RepackagingComponentImplFromJson(json);

  @override
  final String productId;
  @override
  final String productName;
  @override
  final double quantity;
  @override
  @JsonKey()
  final double unitCost;
  @override
  final String? unit;
  @override
  final String? notes;

  @override
  String toString() {
    return 'RepackagingComponent(productId: $productId, productName: $productName, quantity: $quantity, unitCost: $unitCost, unit: $unit, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepackagingComponentImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitCost, unitCost) ||
                other.unitCost == unitCost) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, productId, productName, quantity, unitCost, unit, notes);

  /// Create a copy of RepackagingComponent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RepackagingComponentImplCopyWith<_$RepackagingComponentImpl>
      get copyWith =>
          __$$RepackagingComponentImplCopyWithImpl<_$RepackagingComponentImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RepackagingComponentImplToJson(
      this,
    );
  }
}

abstract class _RepackagingComponent extends RepackagingComponent {
  const factory _RepackagingComponent(
      {required final String productId,
      required final String productName,
      required final double quantity,
      final double unitCost,
      final String? unit,
      final String? notes}) = _$RepackagingComponentImpl;
  const _RepackagingComponent._() : super._();

  factory _RepackagingComponent.fromJson(Map<String, dynamic> json) =
      _$RepackagingComponentImpl.fromJson;

  @override
  String get productId;
  @override
  String get productName;
  @override
  double get quantity;
  @override
  double get unitCost;
  @override
  String? get unit;
  @override
  String? get notes;

  /// Create a copy of RepackagingComponent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RepackagingComponentImplCopyWith<_$RepackagingComponentImpl>
      get copyWith => throw _privateConstructorUsedError;
}

RepackagingTransaction _$RepackagingTransactionFromJson(
    Map<String, dynamic> json) {
  return _RepackagingTransaction.fromJson(json);
}

/// @nodoc
mixin _$RepackagingTransaction {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get ruleId => throw _privateConstructorUsedError;
  String get branchId => throw _privateConstructorUsedError;
  double get inputQuantity => throw _privateConstructorUsedError;
  double get outputQuantity => throw _privateConstructorUsedError;
  double get actualOutputQuantity => throw _privateConstructorUsedError;
  RepackagingStatus get status => throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  String? get performedBy => throw _privateConstructorUsedError;
  String? get approvedBy => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  String? get batchId => throw _privateConstructorUsedError;
  List<String> get serialNumbers => throw _privateConstructorUsedError;
  double? get totalCost => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  Map<String, dynamic> get qualityCheckResults =>
      throw _privateConstructorUsedError;
  String? get failureReason => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt => throw _privateConstructorUsedError;

  /// Serializes this RepackagingTransaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RepackagingTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RepackagingTransactionCopyWith<RepackagingTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepackagingTransactionCopyWith<$Res> {
  factory $RepackagingTransactionCopyWith(RepackagingTransaction value,
          $Res Function(RepackagingTransaction) then) =
      _$RepackagingTransactionCopyWithImpl<$Res, RepackagingTransaction>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String ruleId,
      String branchId,
      double inputQuantity,
      double outputQuantity,
      double actualOutputQuantity,
      RepackagingStatus status,
      DateTime? startedAt,
      DateTime? completedAt,
      String? performedBy,
      String? approvedBy,
      DateTime? approvedAt,
      String? batchId,
      List<String> serialNumbers,
      double? totalCost,
      String? notes,
      Map<String, dynamic> qualityCheckResults,
      String? failureReason,
      DateTime createdAt,
      DateTime? syncedAt});
}

/// @nodoc
class _$RepackagingTransactionCopyWithImpl<$Res,
        $Val extends RepackagingTransaction>
    implements $RepackagingTransactionCopyWith<$Res> {
  _$RepackagingTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RepackagingTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? ruleId = null,
    Object? branchId = null,
    Object? inputQuantity = null,
    Object? outputQuantity = null,
    Object? actualOutputQuantity = null,
    Object? status = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? performedBy = freezed,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
    Object? batchId = freezed,
    Object? serialNumbers = null,
    Object? totalCost = freezed,
    Object? notes = freezed,
    Object? qualityCheckResults = null,
    Object? failureReason = freezed,
    Object? createdAt = null,
    Object? syncedAt = freezed,
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
      ruleId: null == ruleId
          ? _value.ruleId
          : ruleId // ignore: cast_nullable_to_non_nullable
              as String,
      branchId: null == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as String,
      inputQuantity: null == inputQuantity
          ? _value.inputQuantity
          : inputQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      outputQuantity: null == outputQuantity
          ? _value.outputQuantity
          : outputQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      actualOutputQuantity: null == actualOutputQuantity
          ? _value.actualOutputQuantity
          : actualOutputQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RepackagingStatus,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      performedBy: freezed == performedBy
          ? _value.performedBy
          : performedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      batchId: freezed == batchId
          ? _value.batchId
          : batchId // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNumbers: null == serialNumbers
          ? _value.serialNumbers
          : serialNumbers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalCost: freezed == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      qualityCheckResults: null == qualityCheckResults
          ? _value.qualityCheckResults
          : qualityCheckResults // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      failureReason: freezed == failureReason
          ? _value.failureReason
          : failureReason // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RepackagingTransactionImplCopyWith<$Res>
    implements $RepackagingTransactionCopyWith<$Res> {
  factory _$$RepackagingTransactionImplCopyWith(
          _$RepackagingTransactionImpl value,
          $Res Function(_$RepackagingTransactionImpl) then) =
      __$$RepackagingTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String ruleId,
      String branchId,
      double inputQuantity,
      double outputQuantity,
      double actualOutputQuantity,
      RepackagingStatus status,
      DateTime? startedAt,
      DateTime? completedAt,
      String? performedBy,
      String? approvedBy,
      DateTime? approvedAt,
      String? batchId,
      List<String> serialNumbers,
      double? totalCost,
      String? notes,
      Map<String, dynamic> qualityCheckResults,
      String? failureReason,
      DateTime createdAt,
      DateTime? syncedAt});
}

/// @nodoc
class __$$RepackagingTransactionImplCopyWithImpl<$Res>
    extends _$RepackagingTransactionCopyWithImpl<$Res,
        _$RepackagingTransactionImpl>
    implements _$$RepackagingTransactionImplCopyWith<$Res> {
  __$$RepackagingTransactionImplCopyWithImpl(
      _$RepackagingTransactionImpl _value,
      $Res Function(_$RepackagingTransactionImpl) _then)
      : super(_value, _then);

  /// Create a copy of RepackagingTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? ruleId = null,
    Object? branchId = null,
    Object? inputQuantity = null,
    Object? outputQuantity = null,
    Object? actualOutputQuantity = null,
    Object? status = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? performedBy = freezed,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
    Object? batchId = freezed,
    Object? serialNumbers = null,
    Object? totalCost = freezed,
    Object? notes = freezed,
    Object? qualityCheckResults = null,
    Object? failureReason = freezed,
    Object? createdAt = null,
    Object? syncedAt = freezed,
  }) {
    return _then(_$RepackagingTransactionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      ruleId: null == ruleId
          ? _value.ruleId
          : ruleId // ignore: cast_nullable_to_non_nullable
              as String,
      branchId: null == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as String,
      inputQuantity: null == inputQuantity
          ? _value.inputQuantity
          : inputQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      outputQuantity: null == outputQuantity
          ? _value.outputQuantity
          : outputQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      actualOutputQuantity: null == actualOutputQuantity
          ? _value.actualOutputQuantity
          : actualOutputQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RepackagingStatus,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      performedBy: freezed == performedBy
          ? _value.performedBy
          : performedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      batchId: freezed == batchId
          ? _value.batchId
          : batchId // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNumbers: null == serialNumbers
          ? _value._serialNumbers
          : serialNumbers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalCost: freezed == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      qualityCheckResults: null == qualityCheckResults
          ? _value._qualityCheckResults
          : qualityCheckResults // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      failureReason: freezed == failureReason
          ? _value.failureReason
          : failureReason // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RepackagingTransactionImpl extends _RepackagingTransaction {
  const _$RepackagingTransactionImpl(
      {required this.id,
      required this.organizationId,
      required this.ruleId,
      required this.branchId,
      required this.inputQuantity,
      required this.outputQuantity,
      required this.actualOutputQuantity,
      this.status = RepackagingStatus.pending,
      this.startedAt,
      this.completedAt,
      this.performedBy,
      this.approvedBy,
      this.approvedAt,
      this.batchId,
      final List<String> serialNumbers = const [],
      this.totalCost,
      this.notes,
      final Map<String, dynamic> qualityCheckResults = const {},
      this.failureReason,
      required this.createdAt,
      this.syncedAt})
      : _serialNumbers = serialNumbers,
        _qualityCheckResults = qualityCheckResults,
        super._();

  factory _$RepackagingTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$RepackagingTransactionImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String ruleId;
  @override
  final String branchId;
  @override
  final double inputQuantity;
  @override
  final double outputQuantity;
  @override
  final double actualOutputQuantity;
  @override
  @JsonKey()
  final RepackagingStatus status;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? completedAt;
  @override
  final String? performedBy;
  @override
  final String? approvedBy;
  @override
  final DateTime? approvedAt;
  @override
  final String? batchId;
  final List<String> _serialNumbers;
  @override
  @JsonKey()
  List<String> get serialNumbers {
    if (_serialNumbers is EqualUnmodifiableListView) return _serialNumbers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_serialNumbers);
  }

  @override
  final double? totalCost;
  @override
  final String? notes;
  final Map<String, dynamic> _qualityCheckResults;
  @override
  @JsonKey()
  Map<String, dynamic> get qualityCheckResults {
    if (_qualityCheckResults is EqualUnmodifiableMapView)
      return _qualityCheckResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_qualityCheckResults);
  }

  @override
  final String? failureReason;
  @override
  final DateTime createdAt;
  @override
  final DateTime? syncedAt;

  @override
  String toString() {
    return 'RepackagingTransaction(id: $id, organizationId: $organizationId, ruleId: $ruleId, branchId: $branchId, inputQuantity: $inputQuantity, outputQuantity: $outputQuantity, actualOutputQuantity: $actualOutputQuantity, status: $status, startedAt: $startedAt, completedAt: $completedAt, performedBy: $performedBy, approvedBy: $approvedBy, approvedAt: $approvedAt, batchId: $batchId, serialNumbers: $serialNumbers, totalCost: $totalCost, notes: $notes, qualityCheckResults: $qualityCheckResults, failureReason: $failureReason, createdAt: $createdAt, syncedAt: $syncedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepackagingTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.ruleId, ruleId) || other.ruleId == ruleId) &&
            (identical(other.branchId, branchId) ||
                other.branchId == branchId) &&
            (identical(other.inputQuantity, inputQuantity) ||
                other.inputQuantity == inputQuantity) &&
            (identical(other.outputQuantity, outputQuantity) ||
                other.outputQuantity == outputQuantity) &&
            (identical(other.actualOutputQuantity, actualOutputQuantity) ||
                other.actualOutputQuantity == actualOutputQuantity) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.performedBy, performedBy) ||
                other.performedBy == performedBy) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.batchId, batchId) || other.batchId == batchId) &&
            const DeepCollectionEquality()
                .equals(other._serialNumbers, _serialNumbers) &&
            (identical(other.totalCost, totalCost) ||
                other.totalCost == totalCost) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality()
                .equals(other._qualityCheckResults, _qualityCheckResults) &&
            (identical(other.failureReason, failureReason) ||
                other.failureReason == failureReason) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        organizationId,
        ruleId,
        branchId,
        inputQuantity,
        outputQuantity,
        actualOutputQuantity,
        status,
        startedAt,
        completedAt,
        performedBy,
        approvedBy,
        approvedAt,
        batchId,
        const DeepCollectionEquality().hash(_serialNumbers),
        totalCost,
        notes,
        const DeepCollectionEquality().hash(_qualityCheckResults),
        failureReason,
        createdAt,
        syncedAt
      ]);

  /// Create a copy of RepackagingTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RepackagingTransactionImplCopyWith<_$RepackagingTransactionImpl>
      get copyWith => __$$RepackagingTransactionImplCopyWithImpl<
          _$RepackagingTransactionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RepackagingTransactionImplToJson(
      this,
    );
  }
}

abstract class _RepackagingTransaction extends RepackagingTransaction {
  const factory _RepackagingTransaction(
      {required final String id,
      required final String organizationId,
      required final String ruleId,
      required final String branchId,
      required final double inputQuantity,
      required final double outputQuantity,
      required final double actualOutputQuantity,
      final RepackagingStatus status,
      final DateTime? startedAt,
      final DateTime? completedAt,
      final String? performedBy,
      final String? approvedBy,
      final DateTime? approvedAt,
      final String? batchId,
      final List<String> serialNumbers,
      final double? totalCost,
      final String? notes,
      final Map<String, dynamic> qualityCheckResults,
      final String? failureReason,
      required final DateTime createdAt,
      final DateTime? syncedAt}) = _$RepackagingTransactionImpl;
  const _RepackagingTransaction._() : super._();

  factory _RepackagingTransaction.fromJson(Map<String, dynamic> json) =
      _$RepackagingTransactionImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String get ruleId;
  @override
  String get branchId;
  @override
  double get inputQuantity;
  @override
  double get outputQuantity;
  @override
  double get actualOutputQuantity;
  @override
  RepackagingStatus get status;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get completedAt;
  @override
  String? get performedBy;
  @override
  String? get approvedBy;
  @override
  DateTime? get approvedAt;
  @override
  String? get batchId;
  @override
  List<String> get serialNumbers;
  @override
  double? get totalCost;
  @override
  String? get notes;
  @override
  Map<String, dynamic> get qualityCheckResults;
  @override
  String? get failureReason;
  @override
  DateTime get createdAt;
  @override
  DateTime? get syncedAt;

  /// Create a copy of RepackagingTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RepackagingTransactionImplCopyWith<_$RepackagingTransactionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
