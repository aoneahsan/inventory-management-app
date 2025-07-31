// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Register _$RegisterFromJson(Map<String, dynamic> json) {
  return _Register.fromJson(json);
}

/// @nodoc
mixin _$Register {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get branchId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  double get openingBalance => throw _privateConstructorUsedError;
  double get currentBalance => throw _privateConstructorUsedError;
  double get expectedBalance => throw _privateConstructorUsedError;
  RegisterStatus get status => throw _privateConstructorUsedError;
  String get openedBy => throw _privateConstructorUsedError;
  DateTime get openedAt => throw _privateConstructorUsedError;
  String? get closedBy => throw _privateConstructorUsedError;
  DateTime? get closedAt => throw _privateConstructorUsedError;
  Map<String, int> get denominations => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional fields
  double get totalSales => throw _privateConstructorUsedError;
  double get totalRefunds => throw _privateConstructorUsedError;
  double get totalCashIn => throw _privateConstructorUsedError;
  double get totalCashOut => throw _privateConstructorUsedError;
  int get transactionCount => throw _privateConstructorUsedError;
  Map<String, double> get paymentMethodTotals =>
      throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  List<RegisterTransaction> get recentTransactions =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  String? get terminalId => throw _privateConstructorUsedError;
  bool get requiresFloatCount => throw _privateConstructorUsedError;
  DateTime? get lastActivityAt => throw _privateConstructorUsedError;

  /// Serializes this Register to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Register
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterCopyWith<Register> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterCopyWith<$Res> {
  factory $RegisterCopyWith(Register value, $Res Function(Register) then) =
      _$RegisterCopyWithImpl<$Res, Register>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String branchId,
      String name,
      String? location,
      double openingBalance,
      double currentBalance,
      double expectedBalance,
      RegisterStatus status,
      String openedBy,
      DateTime openedAt,
      String? closedBy,
      DateTime? closedAt,
      Map<String, int> denominations,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      double totalSales,
      double totalRefunds,
      double totalCashIn,
      double totalCashOut,
      int transactionCount,
      Map<String, double> paymentMethodTotals,
      String? notes,
      List<RegisterTransaction> recentTransactions,
      Map<String, dynamic> metadata,
      String? terminalId,
      bool requiresFloatCount,
      DateTime? lastActivityAt});
}

/// @nodoc
class _$RegisterCopyWithImpl<$Res, $Val extends Register>
    implements $RegisterCopyWith<$Res> {
  _$RegisterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Register
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? branchId = null,
    Object? name = null,
    Object? location = freezed,
    Object? openingBalance = null,
    Object? currentBalance = null,
    Object? expectedBalance = null,
    Object? status = null,
    Object? openedBy = null,
    Object? openedAt = null,
    Object? closedBy = freezed,
    Object? closedAt = freezed,
    Object? denominations = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? totalSales = null,
    Object? totalRefunds = null,
    Object? totalCashIn = null,
    Object? totalCashOut = null,
    Object? transactionCount = null,
    Object? paymentMethodTotals = null,
    Object? notes = freezed,
    Object? recentTransactions = null,
    Object? metadata = null,
    Object? terminalId = freezed,
    Object? requiresFloatCount = null,
    Object? lastActivityAt = freezed,
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
      branchId: null == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      openingBalance: null == openingBalance
          ? _value.openingBalance
          : openingBalance // ignore: cast_nullable_to_non_nullable
              as double,
      currentBalance: null == currentBalance
          ? _value.currentBalance
          : currentBalance // ignore: cast_nullable_to_non_nullable
              as double,
      expectedBalance: null == expectedBalance
          ? _value.expectedBalance
          : expectedBalance // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RegisterStatus,
      openedBy: null == openedBy
          ? _value.openedBy
          : openedBy // ignore: cast_nullable_to_non_nullable
              as String,
      openedAt: null == openedAt
          ? _value.openedAt
          : openedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      closedBy: freezed == closedBy
          ? _value.closedBy
          : closedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      closedAt: freezed == closedAt
          ? _value.closedAt
          : closedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      denominations: null == denominations
          ? _value.denominations
          : denominations // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
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
      totalSales: null == totalSales
          ? _value.totalSales
          : totalSales // ignore: cast_nullable_to_non_nullable
              as double,
      totalRefunds: null == totalRefunds
          ? _value.totalRefunds
          : totalRefunds // ignore: cast_nullable_to_non_nullable
              as double,
      totalCashIn: null == totalCashIn
          ? _value.totalCashIn
          : totalCashIn // ignore: cast_nullable_to_non_nullable
              as double,
      totalCashOut: null == totalCashOut
          ? _value.totalCashOut
          : totalCashOut // ignore: cast_nullable_to_non_nullable
              as double,
      transactionCount: null == transactionCount
          ? _value.transactionCount
          : transactionCount // ignore: cast_nullable_to_non_nullable
              as int,
      paymentMethodTotals: null == paymentMethodTotals
          ? _value.paymentMethodTotals
          : paymentMethodTotals // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      recentTransactions: null == recentTransactions
          ? _value.recentTransactions
          : recentTransactions // ignore: cast_nullable_to_non_nullable
              as List<RegisterTransaction>,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      terminalId: freezed == terminalId
          ? _value.terminalId
          : terminalId // ignore: cast_nullable_to_non_nullable
              as String?,
      requiresFloatCount: null == requiresFloatCount
          ? _value.requiresFloatCount
          : requiresFloatCount // ignore: cast_nullable_to_non_nullable
              as bool,
      lastActivityAt: freezed == lastActivityAt
          ? _value.lastActivityAt
          : lastActivityAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterImplCopyWith<$Res>
    implements $RegisterCopyWith<$Res> {
  factory _$$RegisterImplCopyWith(
          _$RegisterImpl value, $Res Function(_$RegisterImpl) then) =
      __$$RegisterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String branchId,
      String name,
      String? location,
      double openingBalance,
      double currentBalance,
      double expectedBalance,
      RegisterStatus status,
      String openedBy,
      DateTime openedAt,
      String? closedBy,
      DateTime? closedAt,
      Map<String, int> denominations,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      double totalSales,
      double totalRefunds,
      double totalCashIn,
      double totalCashOut,
      int transactionCount,
      Map<String, double> paymentMethodTotals,
      String? notes,
      List<RegisterTransaction> recentTransactions,
      Map<String, dynamic> metadata,
      String? terminalId,
      bool requiresFloatCount,
      DateTime? lastActivityAt});
}

/// @nodoc
class __$$RegisterImplCopyWithImpl<$Res>
    extends _$RegisterCopyWithImpl<$Res, _$RegisterImpl>
    implements _$$RegisterImplCopyWith<$Res> {
  __$$RegisterImplCopyWithImpl(
      _$RegisterImpl _value, $Res Function(_$RegisterImpl) _then)
      : super(_value, _then);

  /// Create a copy of Register
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? branchId = null,
    Object? name = null,
    Object? location = freezed,
    Object? openingBalance = null,
    Object? currentBalance = null,
    Object? expectedBalance = null,
    Object? status = null,
    Object? openedBy = null,
    Object? openedAt = null,
    Object? closedBy = freezed,
    Object? closedAt = freezed,
    Object? denominations = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? totalSales = null,
    Object? totalRefunds = null,
    Object? totalCashIn = null,
    Object? totalCashOut = null,
    Object? transactionCount = null,
    Object? paymentMethodTotals = null,
    Object? notes = freezed,
    Object? recentTransactions = null,
    Object? metadata = null,
    Object? terminalId = freezed,
    Object? requiresFloatCount = null,
    Object? lastActivityAt = freezed,
  }) {
    return _then(_$RegisterImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      branchId: null == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      openingBalance: null == openingBalance
          ? _value.openingBalance
          : openingBalance // ignore: cast_nullable_to_non_nullable
              as double,
      currentBalance: null == currentBalance
          ? _value.currentBalance
          : currentBalance // ignore: cast_nullable_to_non_nullable
              as double,
      expectedBalance: null == expectedBalance
          ? _value.expectedBalance
          : expectedBalance // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RegisterStatus,
      openedBy: null == openedBy
          ? _value.openedBy
          : openedBy // ignore: cast_nullable_to_non_nullable
              as String,
      openedAt: null == openedAt
          ? _value.openedAt
          : openedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      closedBy: freezed == closedBy
          ? _value.closedBy
          : closedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      closedAt: freezed == closedAt
          ? _value.closedAt
          : closedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      denominations: null == denominations
          ? _value._denominations
          : denominations // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
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
      totalSales: null == totalSales
          ? _value.totalSales
          : totalSales // ignore: cast_nullable_to_non_nullable
              as double,
      totalRefunds: null == totalRefunds
          ? _value.totalRefunds
          : totalRefunds // ignore: cast_nullable_to_non_nullable
              as double,
      totalCashIn: null == totalCashIn
          ? _value.totalCashIn
          : totalCashIn // ignore: cast_nullable_to_non_nullable
              as double,
      totalCashOut: null == totalCashOut
          ? _value.totalCashOut
          : totalCashOut // ignore: cast_nullable_to_non_nullable
              as double,
      transactionCount: null == transactionCount
          ? _value.transactionCount
          : transactionCount // ignore: cast_nullable_to_non_nullable
              as int,
      paymentMethodTotals: null == paymentMethodTotals
          ? _value._paymentMethodTotals
          : paymentMethodTotals // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      recentTransactions: null == recentTransactions
          ? _value._recentTransactions
          : recentTransactions // ignore: cast_nullable_to_non_nullable
              as List<RegisterTransaction>,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      terminalId: freezed == terminalId
          ? _value.terminalId
          : terminalId // ignore: cast_nullable_to_non_nullable
              as String?,
      requiresFloatCount: null == requiresFloatCount
          ? _value.requiresFloatCount
          : requiresFloatCount // ignore: cast_nullable_to_non_nullable
              as bool,
      lastActivityAt: freezed == lastActivityAt
          ? _value.lastActivityAt
          : lastActivityAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisterImpl extends _Register {
  const _$RegisterImpl(
      {required this.id,
      required this.organizationId,
      required this.branchId,
      required this.name,
      this.location,
      this.openingBalance = 0,
      this.currentBalance = 0,
      this.expectedBalance = 0,
      required this.status,
      required this.openedBy,
      required this.openedAt,
      this.closedBy,
      this.closedAt,
      final Map<String, int> denominations = const {},
      required this.createdAt,
      required this.updatedAt,
      this.syncedAt,
      this.totalSales = 0,
      this.totalRefunds = 0,
      this.totalCashIn = 0,
      this.totalCashOut = 0,
      this.transactionCount = 0,
      final Map<String, double> paymentMethodTotals = const {},
      this.notes,
      final List<RegisterTransaction> recentTransactions = const [],
      final Map<String, dynamic> metadata = const {},
      this.terminalId,
      this.requiresFloatCount = false,
      this.lastActivityAt})
      : _denominations = denominations,
        _paymentMethodTotals = paymentMethodTotals,
        _recentTransactions = recentTransactions,
        _metadata = metadata,
        super._();

  factory _$RegisterImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String branchId;
  @override
  final String name;
  @override
  final String? location;
  @override
  @JsonKey()
  final double openingBalance;
  @override
  @JsonKey()
  final double currentBalance;
  @override
  @JsonKey()
  final double expectedBalance;
  @override
  final RegisterStatus status;
  @override
  final String openedBy;
  @override
  final DateTime openedAt;
  @override
  final String? closedBy;
  @override
  final DateTime? closedAt;
  final Map<String, int> _denominations;
  @override
  @JsonKey()
  Map<String, int> get denominations {
    if (_denominations is EqualUnmodifiableMapView) return _denominations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_denominations);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? syncedAt;
// Additional fields
  @override
  @JsonKey()
  final double totalSales;
  @override
  @JsonKey()
  final double totalRefunds;
  @override
  @JsonKey()
  final double totalCashIn;
  @override
  @JsonKey()
  final double totalCashOut;
  @override
  @JsonKey()
  final int transactionCount;
  final Map<String, double> _paymentMethodTotals;
  @override
  @JsonKey()
  Map<String, double> get paymentMethodTotals {
    if (_paymentMethodTotals is EqualUnmodifiableMapView)
      return _paymentMethodTotals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_paymentMethodTotals);
  }

  @override
  final String? notes;
  final List<RegisterTransaction> _recentTransactions;
  @override
  @JsonKey()
  List<RegisterTransaction> get recentTransactions {
    if (_recentTransactions is EqualUnmodifiableListView)
      return _recentTransactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentTransactions);
  }

  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  final String? terminalId;
  @override
  @JsonKey()
  final bool requiresFloatCount;
  @override
  final DateTime? lastActivityAt;

  @override
  String toString() {
    return 'Register(id: $id, organizationId: $organizationId, branchId: $branchId, name: $name, location: $location, openingBalance: $openingBalance, currentBalance: $currentBalance, expectedBalance: $expectedBalance, status: $status, openedBy: $openedBy, openedAt: $openedAt, closedBy: $closedBy, closedAt: $closedAt, denominations: $denominations, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt, totalSales: $totalSales, totalRefunds: $totalRefunds, totalCashIn: $totalCashIn, totalCashOut: $totalCashOut, transactionCount: $transactionCount, paymentMethodTotals: $paymentMethodTotals, notes: $notes, recentTransactions: $recentTransactions, metadata: $metadata, terminalId: $terminalId, requiresFloatCount: $requiresFloatCount, lastActivityAt: $lastActivityAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.branchId, branchId) ||
                other.branchId == branchId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.openingBalance, openingBalance) ||
                other.openingBalance == openingBalance) &&
            (identical(other.currentBalance, currentBalance) ||
                other.currentBalance == currentBalance) &&
            (identical(other.expectedBalance, expectedBalance) ||
                other.expectedBalance == expectedBalance) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.openedBy, openedBy) ||
                other.openedBy == openedBy) &&
            (identical(other.openedAt, openedAt) ||
                other.openedAt == openedAt) &&
            (identical(other.closedBy, closedBy) ||
                other.closedBy == closedBy) &&
            (identical(other.closedAt, closedAt) ||
                other.closedAt == closedAt) &&
            const DeepCollectionEquality()
                .equals(other._denominations, _denominations) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.totalSales, totalSales) ||
                other.totalSales == totalSales) &&
            (identical(other.totalRefunds, totalRefunds) ||
                other.totalRefunds == totalRefunds) &&
            (identical(other.totalCashIn, totalCashIn) ||
                other.totalCashIn == totalCashIn) &&
            (identical(other.totalCashOut, totalCashOut) ||
                other.totalCashOut == totalCashOut) &&
            (identical(other.transactionCount, transactionCount) ||
                other.transactionCount == transactionCount) &&
            const DeepCollectionEquality()
                .equals(other._paymentMethodTotals, _paymentMethodTotals) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality()
                .equals(other._recentTransactions, _recentTransactions) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.terminalId, terminalId) ||
                other.terminalId == terminalId) &&
            (identical(other.requiresFloatCount, requiresFloatCount) ||
                other.requiresFloatCount == requiresFloatCount) &&
            (identical(other.lastActivityAt, lastActivityAt) ||
                other.lastActivityAt == lastActivityAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        organizationId,
        branchId,
        name,
        location,
        openingBalance,
        currentBalance,
        expectedBalance,
        status,
        openedBy,
        openedAt,
        closedBy,
        closedAt,
        const DeepCollectionEquality().hash(_denominations),
        createdAt,
        updatedAt,
        syncedAt,
        totalSales,
        totalRefunds,
        totalCashIn,
        totalCashOut,
        transactionCount,
        const DeepCollectionEquality().hash(_paymentMethodTotals),
        notes,
        const DeepCollectionEquality().hash(_recentTransactions),
        const DeepCollectionEquality().hash(_metadata),
        terminalId,
        requiresFloatCount,
        lastActivityAt
      ]);

  /// Create a copy of Register
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterImplCopyWith<_$RegisterImpl> get copyWith =>
      __$$RegisterImplCopyWithImpl<_$RegisterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterImplToJson(
      this,
    );
  }
}

abstract class _Register extends Register {
  const factory _Register(
      {required final String id,
      required final String organizationId,
      required final String branchId,
      required final String name,
      final String? location,
      final double openingBalance,
      final double currentBalance,
      final double expectedBalance,
      required final RegisterStatus status,
      required final String openedBy,
      required final DateTime openedAt,
      final String? closedBy,
      final DateTime? closedAt,
      final Map<String, int> denominations,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final DateTime? syncedAt,
      final double totalSales,
      final double totalRefunds,
      final double totalCashIn,
      final double totalCashOut,
      final int transactionCount,
      final Map<String, double> paymentMethodTotals,
      final String? notes,
      final List<RegisterTransaction> recentTransactions,
      final Map<String, dynamic> metadata,
      final String? terminalId,
      final bool requiresFloatCount,
      final DateTime? lastActivityAt}) = _$RegisterImpl;
  const _Register._() : super._();

  factory _Register.fromJson(Map<String, dynamic> json) =
      _$RegisterImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String get branchId;
  @override
  String get name;
  @override
  String? get location;
  @override
  double get openingBalance;
  @override
  double get currentBalance;
  @override
  double get expectedBalance;
  @override
  RegisterStatus get status;
  @override
  String get openedBy;
  @override
  DateTime get openedAt;
  @override
  String? get closedBy;
  @override
  DateTime? get closedAt;
  @override
  Map<String, int> get denominations;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get syncedAt; // Additional fields
  @override
  double get totalSales;
  @override
  double get totalRefunds;
  @override
  double get totalCashIn;
  @override
  double get totalCashOut;
  @override
  int get transactionCount;
  @override
  Map<String, double> get paymentMethodTotals;
  @override
  String? get notes;
  @override
  List<RegisterTransaction> get recentTransactions;
  @override
  Map<String, dynamic> get metadata;
  @override
  String? get terminalId;
  @override
  bool get requiresFloatCount;
  @override
  DateTime? get lastActivityAt;

  /// Create a copy of Register
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterImplCopyWith<_$RegisterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RegisterTransaction _$RegisterTransactionFromJson(Map<String, dynamic> json) {
  return _RegisterTransaction.fromJson(json);
}

/// @nodoc
mixin _$RegisterTransaction {
  String get id => throw _privateConstructorUsedError;
  String get registerId => throw _privateConstructorUsedError;
  RegisterTransactionType get type => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  String get performedBy => throw _privateConstructorUsedError;
  DateTime get createdAt =>
      throw _privateConstructorUsedError; // Additional fields
  String? get referenceId => throw _privateConstructorUsedError;
  String? get referenceType => throw _privateConstructorUsedError;
  String? get paymentMethod => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this RegisterTransaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegisterTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterTransactionCopyWith<RegisterTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterTransactionCopyWith<$Res> {
  factory $RegisterTransactionCopyWith(
          RegisterTransaction value, $Res Function(RegisterTransaction) then) =
      _$RegisterTransactionCopyWithImpl<$Res, RegisterTransaction>;
  @useResult
  $Res call(
      {String id,
      String registerId,
      RegisterTransactionType type,
      double amount,
      String? reason,
      String performedBy,
      DateTime createdAt,
      String? referenceId,
      String? referenceType,
      String? paymentMethod,
      Map<String, dynamic> metadata,
      String? notes});
}

/// @nodoc
class _$RegisterTransactionCopyWithImpl<$Res, $Val extends RegisterTransaction>
    implements $RegisterTransactionCopyWith<$Res> {
  _$RegisterTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? registerId = null,
    Object? type = null,
    Object? amount = null,
    Object? reason = freezed,
    Object? performedBy = null,
    Object? createdAt = null,
    Object? referenceId = freezed,
    Object? referenceType = freezed,
    Object? paymentMethod = freezed,
    Object? metadata = null,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      registerId: null == registerId
          ? _value.registerId
          : registerId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RegisterTransactionType,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      performedBy: null == performedBy
          ? _value.performedBy
          : performedBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      referenceId: freezed == referenceId
          ? _value.referenceId
          : referenceId // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceType: freezed == referenceType
          ? _value.referenceType
          : referenceType // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterTransactionImplCopyWith<$Res>
    implements $RegisterTransactionCopyWith<$Res> {
  factory _$$RegisterTransactionImplCopyWith(_$RegisterTransactionImpl value,
          $Res Function(_$RegisterTransactionImpl) then) =
      __$$RegisterTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String registerId,
      RegisterTransactionType type,
      double amount,
      String? reason,
      String performedBy,
      DateTime createdAt,
      String? referenceId,
      String? referenceType,
      String? paymentMethod,
      Map<String, dynamic> metadata,
      String? notes});
}

/// @nodoc
class __$$RegisterTransactionImplCopyWithImpl<$Res>
    extends _$RegisterTransactionCopyWithImpl<$Res, _$RegisterTransactionImpl>
    implements _$$RegisterTransactionImplCopyWith<$Res> {
  __$$RegisterTransactionImplCopyWithImpl(_$RegisterTransactionImpl _value,
      $Res Function(_$RegisterTransactionImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? registerId = null,
    Object? type = null,
    Object? amount = null,
    Object? reason = freezed,
    Object? performedBy = null,
    Object? createdAt = null,
    Object? referenceId = freezed,
    Object? referenceType = freezed,
    Object? paymentMethod = freezed,
    Object? metadata = null,
    Object? notes = freezed,
  }) {
    return _then(_$RegisterTransactionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      registerId: null == registerId
          ? _value.registerId
          : registerId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RegisterTransactionType,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      performedBy: null == performedBy
          ? _value.performedBy
          : performedBy // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      referenceId: freezed == referenceId
          ? _value.referenceId
          : referenceId // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceType: freezed == referenceType
          ? _value.referenceType
          : referenceType // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisterTransactionImpl extends _RegisterTransaction {
  const _$RegisterTransactionImpl(
      {required this.id,
      required this.registerId,
      required this.type,
      required this.amount,
      this.reason,
      required this.performedBy,
      required this.createdAt,
      this.referenceId,
      this.referenceType,
      this.paymentMethod,
      final Map<String, dynamic> metadata = const {},
      this.notes})
      : _metadata = metadata,
        super._();

  factory _$RegisterTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterTransactionImplFromJson(json);

  @override
  final String id;
  @override
  final String registerId;
  @override
  final RegisterTransactionType type;
  @override
  final double amount;
  @override
  final String? reason;
  @override
  final String performedBy;
  @override
  final DateTime createdAt;
// Additional fields
  @override
  final String? referenceId;
  @override
  final String? referenceType;
  @override
  final String? paymentMethod;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  final String? notes;

  @override
  String toString() {
    return 'RegisterTransaction(id: $id, registerId: $registerId, type: $type, amount: $amount, reason: $reason, performedBy: $performedBy, createdAt: $createdAt, referenceId: $referenceId, referenceType: $referenceType, paymentMethod: $paymentMethod, metadata: $metadata, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.registerId, registerId) ||
                other.registerId == registerId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.performedBy, performedBy) ||
                other.performedBy == performedBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.referenceId, referenceId) ||
                other.referenceId == referenceId) &&
            (identical(other.referenceType, referenceType) ||
                other.referenceType == referenceType) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      registerId,
      type,
      amount,
      reason,
      performedBy,
      createdAt,
      referenceId,
      referenceType,
      paymentMethod,
      const DeepCollectionEquality().hash(_metadata),
      notes);

  /// Create a copy of RegisterTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterTransactionImplCopyWith<_$RegisterTransactionImpl> get copyWith =>
      __$$RegisterTransactionImplCopyWithImpl<_$RegisterTransactionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterTransactionImplToJson(
      this,
    );
  }
}

abstract class _RegisterTransaction extends RegisterTransaction {
  const factory _RegisterTransaction(
      {required final String id,
      required final String registerId,
      required final RegisterTransactionType type,
      required final double amount,
      final String? reason,
      required final String performedBy,
      required final DateTime createdAt,
      final String? referenceId,
      final String? referenceType,
      final String? paymentMethod,
      final Map<String, dynamic> metadata,
      final String? notes}) = _$RegisterTransactionImpl;
  const _RegisterTransaction._() : super._();

  factory _RegisterTransaction.fromJson(Map<String, dynamic> json) =
      _$RegisterTransactionImpl.fromJson;

  @override
  String get id;
  @override
  String get registerId;
  @override
  RegisterTransactionType get type;
  @override
  double get amount;
  @override
  String? get reason;
  @override
  String get performedBy;
  @override
  DateTime get createdAt; // Additional fields
  @override
  String? get referenceId;
  @override
  String? get referenceType;
  @override
  String? get paymentMethod;
  @override
  Map<String, dynamic> get metadata;
  @override
  String? get notes;

  /// Create a copy of RegisterTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterTransactionImplCopyWith<_$RegisterTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RegisterReport _$RegisterReportFromJson(Map<String, dynamic> json) {
  return _RegisterReport.fromJson(json);
}

/// @nodoc
mixin _$RegisterReport {
  String get registerId => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  double get openingBalance => throw _privateConstructorUsedError;
  double get closingBalance => throw _privateConstructorUsedError;
  double get expectedBalance => throw _privateConstructorUsedError;
  double get discrepancy => throw _privateConstructorUsedError;
  Map<String, double> get salesByPaymentMethod =>
      throw _privateConstructorUsedError;
  Map<String, double> get refundsByPaymentMethod =>
      throw _privateConstructorUsedError;
  double get totalSales => throw _privateConstructorUsedError;
  double get totalRefunds => throw _privateConstructorUsedError;
  double get totalCashIn => throw _privateConstructorUsedError;
  double get totalCashOut => throw _privateConstructorUsedError;
  double get netRevenue => throw _privateConstructorUsedError;
  int get transactionCount => throw _privateConstructorUsedError;
  Map<String, int> get denominationCounts => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get preparedBy => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  String? get approvedBy => throw _privateConstructorUsedError;

  /// Serializes this RegisterReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegisterReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterReportCopyWith<RegisterReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterReportCopyWith<$Res> {
  factory $RegisterReportCopyWith(
          RegisterReport value, $Res Function(RegisterReport) then) =
      _$RegisterReportCopyWithImpl<$Res, RegisterReport>;
  @useResult
  $Res call(
      {String registerId,
      DateTime startTime,
      DateTime endTime,
      double openingBalance,
      double closingBalance,
      double expectedBalance,
      double discrepancy,
      Map<String, double> salesByPaymentMethod,
      Map<String, double> refundsByPaymentMethod,
      double totalSales,
      double totalRefunds,
      double totalCashIn,
      double totalCashOut,
      double netRevenue,
      int transactionCount,
      Map<String, int> denominationCounts,
      String? notes,
      String? preparedBy,
      DateTime? approvedAt,
      String? approvedBy});
}

/// @nodoc
class _$RegisterReportCopyWithImpl<$Res, $Val extends RegisterReport>
    implements $RegisterReportCopyWith<$Res> {
  _$RegisterReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registerId = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? openingBalance = null,
    Object? closingBalance = null,
    Object? expectedBalance = null,
    Object? discrepancy = null,
    Object? salesByPaymentMethod = null,
    Object? refundsByPaymentMethod = null,
    Object? totalSales = null,
    Object? totalRefunds = null,
    Object? totalCashIn = null,
    Object? totalCashOut = null,
    Object? netRevenue = null,
    Object? transactionCount = null,
    Object? denominationCounts = null,
    Object? notes = freezed,
    Object? preparedBy = freezed,
    Object? approvedAt = freezed,
    Object? approvedBy = freezed,
  }) {
    return _then(_value.copyWith(
      registerId: null == registerId
          ? _value.registerId
          : registerId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      openingBalance: null == openingBalance
          ? _value.openingBalance
          : openingBalance // ignore: cast_nullable_to_non_nullable
              as double,
      closingBalance: null == closingBalance
          ? _value.closingBalance
          : closingBalance // ignore: cast_nullable_to_non_nullable
              as double,
      expectedBalance: null == expectedBalance
          ? _value.expectedBalance
          : expectedBalance // ignore: cast_nullable_to_non_nullable
              as double,
      discrepancy: null == discrepancy
          ? _value.discrepancy
          : discrepancy // ignore: cast_nullable_to_non_nullable
              as double,
      salesByPaymentMethod: null == salesByPaymentMethod
          ? _value.salesByPaymentMethod
          : salesByPaymentMethod // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      refundsByPaymentMethod: null == refundsByPaymentMethod
          ? _value.refundsByPaymentMethod
          : refundsByPaymentMethod // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      totalSales: null == totalSales
          ? _value.totalSales
          : totalSales // ignore: cast_nullable_to_non_nullable
              as double,
      totalRefunds: null == totalRefunds
          ? _value.totalRefunds
          : totalRefunds // ignore: cast_nullable_to_non_nullable
              as double,
      totalCashIn: null == totalCashIn
          ? _value.totalCashIn
          : totalCashIn // ignore: cast_nullable_to_non_nullable
              as double,
      totalCashOut: null == totalCashOut
          ? _value.totalCashOut
          : totalCashOut // ignore: cast_nullable_to_non_nullable
              as double,
      netRevenue: null == netRevenue
          ? _value.netRevenue
          : netRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      transactionCount: null == transactionCount
          ? _value.transactionCount
          : transactionCount // ignore: cast_nullable_to_non_nullable
              as int,
      denominationCounts: null == denominationCounts
          ? _value.denominationCounts
          : denominationCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      preparedBy: freezed == preparedBy
          ? _value.preparedBy
          : preparedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterReportImplCopyWith<$Res>
    implements $RegisterReportCopyWith<$Res> {
  factory _$$RegisterReportImplCopyWith(_$RegisterReportImpl value,
          $Res Function(_$RegisterReportImpl) then) =
      __$$RegisterReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String registerId,
      DateTime startTime,
      DateTime endTime,
      double openingBalance,
      double closingBalance,
      double expectedBalance,
      double discrepancy,
      Map<String, double> salesByPaymentMethod,
      Map<String, double> refundsByPaymentMethod,
      double totalSales,
      double totalRefunds,
      double totalCashIn,
      double totalCashOut,
      double netRevenue,
      int transactionCount,
      Map<String, int> denominationCounts,
      String? notes,
      String? preparedBy,
      DateTime? approvedAt,
      String? approvedBy});
}

/// @nodoc
class __$$RegisterReportImplCopyWithImpl<$Res>
    extends _$RegisterReportCopyWithImpl<$Res, _$RegisterReportImpl>
    implements _$$RegisterReportImplCopyWith<$Res> {
  __$$RegisterReportImplCopyWithImpl(
      _$RegisterReportImpl _value, $Res Function(_$RegisterReportImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? registerId = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? openingBalance = null,
    Object? closingBalance = null,
    Object? expectedBalance = null,
    Object? discrepancy = null,
    Object? salesByPaymentMethod = null,
    Object? refundsByPaymentMethod = null,
    Object? totalSales = null,
    Object? totalRefunds = null,
    Object? totalCashIn = null,
    Object? totalCashOut = null,
    Object? netRevenue = null,
    Object? transactionCount = null,
    Object? denominationCounts = null,
    Object? notes = freezed,
    Object? preparedBy = freezed,
    Object? approvedAt = freezed,
    Object? approvedBy = freezed,
  }) {
    return _then(_$RegisterReportImpl(
      registerId: null == registerId
          ? _value.registerId
          : registerId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      openingBalance: null == openingBalance
          ? _value.openingBalance
          : openingBalance // ignore: cast_nullable_to_non_nullable
              as double,
      closingBalance: null == closingBalance
          ? _value.closingBalance
          : closingBalance // ignore: cast_nullable_to_non_nullable
              as double,
      expectedBalance: null == expectedBalance
          ? _value.expectedBalance
          : expectedBalance // ignore: cast_nullable_to_non_nullable
              as double,
      discrepancy: null == discrepancy
          ? _value.discrepancy
          : discrepancy // ignore: cast_nullable_to_non_nullable
              as double,
      salesByPaymentMethod: null == salesByPaymentMethod
          ? _value._salesByPaymentMethod
          : salesByPaymentMethod // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      refundsByPaymentMethod: null == refundsByPaymentMethod
          ? _value._refundsByPaymentMethod
          : refundsByPaymentMethod // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      totalSales: null == totalSales
          ? _value.totalSales
          : totalSales // ignore: cast_nullable_to_non_nullable
              as double,
      totalRefunds: null == totalRefunds
          ? _value.totalRefunds
          : totalRefunds // ignore: cast_nullable_to_non_nullable
              as double,
      totalCashIn: null == totalCashIn
          ? _value.totalCashIn
          : totalCashIn // ignore: cast_nullable_to_non_nullable
              as double,
      totalCashOut: null == totalCashOut
          ? _value.totalCashOut
          : totalCashOut // ignore: cast_nullable_to_non_nullable
              as double,
      netRevenue: null == netRevenue
          ? _value.netRevenue
          : netRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      transactionCount: null == transactionCount
          ? _value.transactionCount
          : transactionCount // ignore: cast_nullable_to_non_nullable
              as int,
      denominationCounts: null == denominationCounts
          ? _value._denominationCounts
          : denominationCounts // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      preparedBy: freezed == preparedBy
          ? _value.preparedBy
          : preparedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisterReportImpl implements _RegisterReport {
  const _$RegisterReportImpl(
      {required this.registerId,
      required this.startTime,
      required this.endTime,
      required this.openingBalance,
      required this.closingBalance,
      required this.expectedBalance,
      required this.discrepancy,
      required final Map<String, double> salesByPaymentMethod,
      required final Map<String, double> refundsByPaymentMethod,
      required this.totalSales,
      required this.totalRefunds,
      required this.totalCashIn,
      required this.totalCashOut,
      required this.netRevenue,
      required this.transactionCount,
      required final Map<String, int> denominationCounts,
      this.notes,
      this.preparedBy,
      this.approvedAt,
      this.approvedBy})
      : _salesByPaymentMethod = salesByPaymentMethod,
        _refundsByPaymentMethod = refundsByPaymentMethod,
        _denominationCounts = denominationCounts;

  factory _$RegisterReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterReportImplFromJson(json);

  @override
  final String registerId;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final double openingBalance;
  @override
  final double closingBalance;
  @override
  final double expectedBalance;
  @override
  final double discrepancy;
  final Map<String, double> _salesByPaymentMethod;
  @override
  Map<String, double> get salesByPaymentMethod {
    if (_salesByPaymentMethod is EqualUnmodifiableMapView)
      return _salesByPaymentMethod;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_salesByPaymentMethod);
  }

  final Map<String, double> _refundsByPaymentMethod;
  @override
  Map<String, double> get refundsByPaymentMethod {
    if (_refundsByPaymentMethod is EqualUnmodifiableMapView)
      return _refundsByPaymentMethod;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_refundsByPaymentMethod);
  }

  @override
  final double totalSales;
  @override
  final double totalRefunds;
  @override
  final double totalCashIn;
  @override
  final double totalCashOut;
  @override
  final double netRevenue;
  @override
  final int transactionCount;
  final Map<String, int> _denominationCounts;
  @override
  Map<String, int> get denominationCounts {
    if (_denominationCounts is EqualUnmodifiableMapView)
      return _denominationCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_denominationCounts);
  }

  @override
  final String? notes;
  @override
  final String? preparedBy;
  @override
  final DateTime? approvedAt;
  @override
  final String? approvedBy;

  @override
  String toString() {
    return 'RegisterReport(registerId: $registerId, startTime: $startTime, endTime: $endTime, openingBalance: $openingBalance, closingBalance: $closingBalance, expectedBalance: $expectedBalance, discrepancy: $discrepancy, salesByPaymentMethod: $salesByPaymentMethod, refundsByPaymentMethod: $refundsByPaymentMethod, totalSales: $totalSales, totalRefunds: $totalRefunds, totalCashIn: $totalCashIn, totalCashOut: $totalCashOut, netRevenue: $netRevenue, transactionCount: $transactionCount, denominationCounts: $denominationCounts, notes: $notes, preparedBy: $preparedBy, approvedAt: $approvedAt, approvedBy: $approvedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterReportImpl &&
            (identical(other.registerId, registerId) ||
                other.registerId == registerId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.openingBalance, openingBalance) ||
                other.openingBalance == openingBalance) &&
            (identical(other.closingBalance, closingBalance) ||
                other.closingBalance == closingBalance) &&
            (identical(other.expectedBalance, expectedBalance) ||
                other.expectedBalance == expectedBalance) &&
            (identical(other.discrepancy, discrepancy) ||
                other.discrepancy == discrepancy) &&
            const DeepCollectionEquality()
                .equals(other._salesByPaymentMethod, _salesByPaymentMethod) &&
            const DeepCollectionEquality().equals(
                other._refundsByPaymentMethod, _refundsByPaymentMethod) &&
            (identical(other.totalSales, totalSales) ||
                other.totalSales == totalSales) &&
            (identical(other.totalRefunds, totalRefunds) ||
                other.totalRefunds == totalRefunds) &&
            (identical(other.totalCashIn, totalCashIn) ||
                other.totalCashIn == totalCashIn) &&
            (identical(other.totalCashOut, totalCashOut) ||
                other.totalCashOut == totalCashOut) &&
            (identical(other.netRevenue, netRevenue) ||
                other.netRevenue == netRevenue) &&
            (identical(other.transactionCount, transactionCount) ||
                other.transactionCount == transactionCount) &&
            const DeepCollectionEquality()
                .equals(other._denominationCounts, _denominationCounts) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.preparedBy, preparedBy) ||
                other.preparedBy == preparedBy) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        registerId,
        startTime,
        endTime,
        openingBalance,
        closingBalance,
        expectedBalance,
        discrepancy,
        const DeepCollectionEquality().hash(_salesByPaymentMethod),
        const DeepCollectionEquality().hash(_refundsByPaymentMethod),
        totalSales,
        totalRefunds,
        totalCashIn,
        totalCashOut,
        netRevenue,
        transactionCount,
        const DeepCollectionEquality().hash(_denominationCounts),
        notes,
        preparedBy,
        approvedAt,
        approvedBy
      ]);

  /// Create a copy of RegisterReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterReportImplCopyWith<_$RegisterReportImpl> get copyWith =>
      __$$RegisterReportImplCopyWithImpl<_$RegisterReportImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterReportImplToJson(
      this,
    );
  }
}

abstract class _RegisterReport implements RegisterReport {
  const factory _RegisterReport(
      {required final String registerId,
      required final DateTime startTime,
      required final DateTime endTime,
      required final double openingBalance,
      required final double closingBalance,
      required final double expectedBalance,
      required final double discrepancy,
      required final Map<String, double> salesByPaymentMethod,
      required final Map<String, double> refundsByPaymentMethod,
      required final double totalSales,
      required final double totalRefunds,
      required final double totalCashIn,
      required final double totalCashOut,
      required final double netRevenue,
      required final int transactionCount,
      required final Map<String, int> denominationCounts,
      final String? notes,
      final String? preparedBy,
      final DateTime? approvedAt,
      final String? approvedBy}) = _$RegisterReportImpl;

  factory _RegisterReport.fromJson(Map<String, dynamic> json) =
      _$RegisterReportImpl.fromJson;

  @override
  String get registerId;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  double get openingBalance;
  @override
  double get closingBalance;
  @override
  double get expectedBalance;
  @override
  double get discrepancy;
  @override
  Map<String, double> get salesByPaymentMethod;
  @override
  Map<String, double> get refundsByPaymentMethod;
  @override
  double get totalSales;
  @override
  double get totalRefunds;
  @override
  double get totalCashIn;
  @override
  double get totalCashOut;
  @override
  double get netRevenue;
  @override
  int get transactionCount;
  @override
  Map<String, int> get denominationCounts;
  @override
  String? get notes;
  @override
  String? get preparedBy;
  @override
  DateTime? get approvedAt;
  @override
  String? get approvedBy;

  /// Create a copy of RegisterReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterReportImplCopyWith<_$RegisterReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
