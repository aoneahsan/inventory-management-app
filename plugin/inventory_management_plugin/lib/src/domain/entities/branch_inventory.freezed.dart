// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'branch_inventory.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BranchInventory _$BranchInventoryFromJson(Map<String, dynamic> json) {
  return _BranchInventory.fromJson(json);
}

/// @nodoc
mixin _$BranchInventory {
  String get id => throw _privateConstructorUsedError;
  String get branchId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  double get currentStock => throw _privateConstructorUsedError;
  double get reservedStock => throw _privateConstructorUsedError;
  double get availableStock => throw _privateConstructorUsedError;
  double get minStock => throw _privateConstructorUsedError;
  double? get maxStock => throw _privateConstructorUsedError;
  double? get reorderPoint => throw _privateConstructorUsedError;
  double get reorderQuantity => throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional tracking fields
  String? get warehouseLocation => throw _privateConstructorUsedError;
  String? get shelfLocation => throw _privateConstructorUsedError;
  double get incomingStock => throw _privateConstructorUsedError;
  double get outgoingStock => throw _privateConstructorUsedError;
  DateTime? get lastStockTakeDate => throw _privateConstructorUsedError;
  double? get lastStockTakeQuantity => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  double get averageDailySales => throw _privateConstructorUsedError;
  int get daysOfStock => throw _privateConstructorUsedError;
  String? get preferredSupplierId => throw _privateConstructorUsedError;
  List<StockAlert> get activeAlerts => throw _privateConstructorUsedError;

  /// Serializes this BranchInventory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BranchInventory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BranchInventoryCopyWith<BranchInventory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BranchInventoryCopyWith<$Res> {
  factory $BranchInventoryCopyWith(
          BranchInventory value, $Res Function(BranchInventory) then) =
      _$BranchInventoryCopyWithImpl<$Res, BranchInventory>;
  @useResult
  $Res call(
      {String id,
      String branchId,
      String productId,
      double currentStock,
      double reservedStock,
      double availableStock,
      double minStock,
      double? maxStock,
      double? reorderPoint,
      double reorderQuantity,
      DateTime lastUpdated,
      DateTime? syncedAt,
      String? warehouseLocation,
      String? shelfLocation,
      double incomingStock,
      double outgoingStock,
      DateTime? lastStockTakeDate,
      double? lastStockTakeQuantity,
      Map<String, dynamic> metadata,
      double averageDailySales,
      int daysOfStock,
      String? preferredSupplierId,
      List<StockAlert> activeAlerts});
}

/// @nodoc
class _$BranchInventoryCopyWithImpl<$Res, $Val extends BranchInventory>
    implements $BranchInventoryCopyWith<$Res> {
  _$BranchInventoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BranchInventory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? branchId = null,
    Object? productId = null,
    Object? currentStock = null,
    Object? reservedStock = null,
    Object? availableStock = null,
    Object? minStock = null,
    Object? maxStock = freezed,
    Object? reorderPoint = freezed,
    Object? reorderQuantity = null,
    Object? lastUpdated = null,
    Object? syncedAt = freezed,
    Object? warehouseLocation = freezed,
    Object? shelfLocation = freezed,
    Object? incomingStock = null,
    Object? outgoingStock = null,
    Object? lastStockTakeDate = freezed,
    Object? lastStockTakeQuantity = freezed,
    Object? metadata = null,
    Object? averageDailySales = null,
    Object? daysOfStock = null,
    Object? preferredSupplierId = freezed,
    Object? activeAlerts = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      branchId: null == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      currentStock: null == currentStock
          ? _value.currentStock
          : currentStock // ignore: cast_nullable_to_non_nullable
              as double,
      reservedStock: null == reservedStock
          ? _value.reservedStock
          : reservedStock // ignore: cast_nullable_to_non_nullable
              as double,
      availableStock: null == availableStock
          ? _value.availableStock
          : availableStock // ignore: cast_nullable_to_non_nullable
              as double,
      minStock: null == minStock
          ? _value.minStock
          : minStock // ignore: cast_nullable_to_non_nullable
              as double,
      maxStock: freezed == maxStock
          ? _value.maxStock
          : maxStock // ignore: cast_nullable_to_non_nullable
              as double?,
      reorderPoint: freezed == reorderPoint
          ? _value.reorderPoint
          : reorderPoint // ignore: cast_nullable_to_non_nullable
              as double?,
      reorderQuantity: null == reorderQuantity
          ? _value.reorderQuantity
          : reorderQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      warehouseLocation: freezed == warehouseLocation
          ? _value.warehouseLocation
          : warehouseLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      shelfLocation: freezed == shelfLocation
          ? _value.shelfLocation
          : shelfLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      incomingStock: null == incomingStock
          ? _value.incomingStock
          : incomingStock // ignore: cast_nullable_to_non_nullable
              as double,
      outgoingStock: null == outgoingStock
          ? _value.outgoingStock
          : outgoingStock // ignore: cast_nullable_to_non_nullable
              as double,
      lastStockTakeDate: freezed == lastStockTakeDate
          ? _value.lastStockTakeDate
          : lastStockTakeDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastStockTakeQuantity: freezed == lastStockTakeQuantity
          ? _value.lastStockTakeQuantity
          : lastStockTakeQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      averageDailySales: null == averageDailySales
          ? _value.averageDailySales
          : averageDailySales // ignore: cast_nullable_to_non_nullable
              as double,
      daysOfStock: null == daysOfStock
          ? _value.daysOfStock
          : daysOfStock // ignore: cast_nullable_to_non_nullable
              as int,
      preferredSupplierId: freezed == preferredSupplierId
          ? _value.preferredSupplierId
          : preferredSupplierId // ignore: cast_nullable_to_non_nullable
              as String?,
      activeAlerts: null == activeAlerts
          ? _value.activeAlerts
          : activeAlerts // ignore: cast_nullable_to_non_nullable
              as List<StockAlert>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BranchInventoryImplCopyWith<$Res>
    implements $BranchInventoryCopyWith<$Res> {
  factory _$$BranchInventoryImplCopyWith(_$BranchInventoryImpl value,
          $Res Function(_$BranchInventoryImpl) then) =
      __$$BranchInventoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String branchId,
      String productId,
      double currentStock,
      double reservedStock,
      double availableStock,
      double minStock,
      double? maxStock,
      double? reorderPoint,
      double reorderQuantity,
      DateTime lastUpdated,
      DateTime? syncedAt,
      String? warehouseLocation,
      String? shelfLocation,
      double incomingStock,
      double outgoingStock,
      DateTime? lastStockTakeDate,
      double? lastStockTakeQuantity,
      Map<String, dynamic> metadata,
      double averageDailySales,
      int daysOfStock,
      String? preferredSupplierId,
      List<StockAlert> activeAlerts});
}

/// @nodoc
class __$$BranchInventoryImplCopyWithImpl<$Res>
    extends _$BranchInventoryCopyWithImpl<$Res, _$BranchInventoryImpl>
    implements _$$BranchInventoryImplCopyWith<$Res> {
  __$$BranchInventoryImplCopyWithImpl(
      _$BranchInventoryImpl _value, $Res Function(_$BranchInventoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of BranchInventory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? branchId = null,
    Object? productId = null,
    Object? currentStock = null,
    Object? reservedStock = null,
    Object? availableStock = null,
    Object? minStock = null,
    Object? maxStock = freezed,
    Object? reorderPoint = freezed,
    Object? reorderQuantity = null,
    Object? lastUpdated = null,
    Object? syncedAt = freezed,
    Object? warehouseLocation = freezed,
    Object? shelfLocation = freezed,
    Object? incomingStock = null,
    Object? outgoingStock = null,
    Object? lastStockTakeDate = freezed,
    Object? lastStockTakeQuantity = freezed,
    Object? metadata = null,
    Object? averageDailySales = null,
    Object? daysOfStock = null,
    Object? preferredSupplierId = freezed,
    Object? activeAlerts = null,
  }) {
    return _then(_$BranchInventoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      branchId: null == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      currentStock: null == currentStock
          ? _value.currentStock
          : currentStock // ignore: cast_nullable_to_non_nullable
              as double,
      reservedStock: null == reservedStock
          ? _value.reservedStock
          : reservedStock // ignore: cast_nullable_to_non_nullable
              as double,
      availableStock: null == availableStock
          ? _value.availableStock
          : availableStock // ignore: cast_nullable_to_non_nullable
              as double,
      minStock: null == minStock
          ? _value.minStock
          : minStock // ignore: cast_nullable_to_non_nullable
              as double,
      maxStock: freezed == maxStock
          ? _value.maxStock
          : maxStock // ignore: cast_nullable_to_non_nullable
              as double?,
      reorderPoint: freezed == reorderPoint
          ? _value.reorderPoint
          : reorderPoint // ignore: cast_nullable_to_non_nullable
              as double?,
      reorderQuantity: null == reorderQuantity
          ? _value.reorderQuantity
          : reorderQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      warehouseLocation: freezed == warehouseLocation
          ? _value.warehouseLocation
          : warehouseLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      shelfLocation: freezed == shelfLocation
          ? _value.shelfLocation
          : shelfLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      incomingStock: null == incomingStock
          ? _value.incomingStock
          : incomingStock // ignore: cast_nullable_to_non_nullable
              as double,
      outgoingStock: null == outgoingStock
          ? _value.outgoingStock
          : outgoingStock // ignore: cast_nullable_to_non_nullable
              as double,
      lastStockTakeDate: freezed == lastStockTakeDate
          ? _value.lastStockTakeDate
          : lastStockTakeDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastStockTakeQuantity: freezed == lastStockTakeQuantity
          ? _value.lastStockTakeQuantity
          : lastStockTakeQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      averageDailySales: null == averageDailySales
          ? _value.averageDailySales
          : averageDailySales // ignore: cast_nullable_to_non_nullable
              as double,
      daysOfStock: null == daysOfStock
          ? _value.daysOfStock
          : daysOfStock // ignore: cast_nullable_to_non_nullable
              as int,
      preferredSupplierId: freezed == preferredSupplierId
          ? _value.preferredSupplierId
          : preferredSupplierId // ignore: cast_nullable_to_non_nullable
              as String?,
      activeAlerts: null == activeAlerts
          ? _value._activeAlerts
          : activeAlerts // ignore: cast_nullable_to_non_nullable
              as List<StockAlert>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BranchInventoryImpl extends _BranchInventory {
  const _$BranchInventoryImpl(
      {required this.id,
      required this.branchId,
      required this.productId,
      this.currentStock = 0,
      this.reservedStock = 0,
      this.availableStock = 0,
      this.minStock = 0,
      this.maxStock,
      this.reorderPoint,
      this.reorderQuantity = 0,
      required this.lastUpdated,
      this.syncedAt,
      this.warehouseLocation,
      this.shelfLocation,
      this.incomingStock = 0,
      this.outgoingStock = 0,
      this.lastStockTakeDate,
      this.lastStockTakeQuantity,
      final Map<String, dynamic> metadata = const {},
      this.averageDailySales = 0,
      this.daysOfStock = 0,
      this.preferredSupplierId,
      final List<StockAlert> activeAlerts = const []})
      : _metadata = metadata,
        _activeAlerts = activeAlerts,
        super._();

  factory _$BranchInventoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$BranchInventoryImplFromJson(json);

  @override
  final String id;
  @override
  final String branchId;
  @override
  final String productId;
  @override
  @JsonKey()
  final double currentStock;
  @override
  @JsonKey()
  final double reservedStock;
  @override
  @JsonKey()
  final double availableStock;
  @override
  @JsonKey()
  final double minStock;
  @override
  final double? maxStock;
  @override
  final double? reorderPoint;
  @override
  @JsonKey()
  final double reorderQuantity;
  @override
  final DateTime lastUpdated;
  @override
  final DateTime? syncedAt;
// Additional tracking fields
  @override
  final String? warehouseLocation;
  @override
  final String? shelfLocation;
  @override
  @JsonKey()
  final double incomingStock;
  @override
  @JsonKey()
  final double outgoingStock;
  @override
  final DateTime? lastStockTakeDate;
  @override
  final double? lastStockTakeQuantity;
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
  final double averageDailySales;
  @override
  @JsonKey()
  final int daysOfStock;
  @override
  final String? preferredSupplierId;
  final List<StockAlert> _activeAlerts;
  @override
  @JsonKey()
  List<StockAlert> get activeAlerts {
    if (_activeAlerts is EqualUnmodifiableListView) return _activeAlerts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeAlerts);
  }

  @override
  String toString() {
    return 'BranchInventory(id: $id, branchId: $branchId, productId: $productId, currentStock: $currentStock, reservedStock: $reservedStock, availableStock: $availableStock, minStock: $minStock, maxStock: $maxStock, reorderPoint: $reorderPoint, reorderQuantity: $reorderQuantity, lastUpdated: $lastUpdated, syncedAt: $syncedAt, warehouseLocation: $warehouseLocation, shelfLocation: $shelfLocation, incomingStock: $incomingStock, outgoingStock: $outgoingStock, lastStockTakeDate: $lastStockTakeDate, lastStockTakeQuantity: $lastStockTakeQuantity, metadata: $metadata, averageDailySales: $averageDailySales, daysOfStock: $daysOfStock, preferredSupplierId: $preferredSupplierId, activeAlerts: $activeAlerts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BranchInventoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.branchId, branchId) ||
                other.branchId == branchId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.currentStock, currentStock) ||
                other.currentStock == currentStock) &&
            (identical(other.reservedStock, reservedStock) ||
                other.reservedStock == reservedStock) &&
            (identical(other.availableStock, availableStock) ||
                other.availableStock == availableStock) &&
            (identical(other.minStock, minStock) ||
                other.minStock == minStock) &&
            (identical(other.maxStock, maxStock) ||
                other.maxStock == maxStock) &&
            (identical(other.reorderPoint, reorderPoint) ||
                other.reorderPoint == reorderPoint) &&
            (identical(other.reorderQuantity, reorderQuantity) ||
                other.reorderQuantity == reorderQuantity) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.warehouseLocation, warehouseLocation) ||
                other.warehouseLocation == warehouseLocation) &&
            (identical(other.shelfLocation, shelfLocation) ||
                other.shelfLocation == shelfLocation) &&
            (identical(other.incomingStock, incomingStock) ||
                other.incomingStock == incomingStock) &&
            (identical(other.outgoingStock, outgoingStock) ||
                other.outgoingStock == outgoingStock) &&
            (identical(other.lastStockTakeDate, lastStockTakeDate) ||
                other.lastStockTakeDate == lastStockTakeDate) &&
            (identical(other.lastStockTakeQuantity, lastStockTakeQuantity) ||
                other.lastStockTakeQuantity == lastStockTakeQuantity) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.averageDailySales, averageDailySales) ||
                other.averageDailySales == averageDailySales) &&
            (identical(other.daysOfStock, daysOfStock) ||
                other.daysOfStock == daysOfStock) &&
            (identical(other.preferredSupplierId, preferredSupplierId) ||
                other.preferredSupplierId == preferredSupplierId) &&
            const DeepCollectionEquality()
                .equals(other._activeAlerts, _activeAlerts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        branchId,
        productId,
        currentStock,
        reservedStock,
        availableStock,
        minStock,
        maxStock,
        reorderPoint,
        reorderQuantity,
        lastUpdated,
        syncedAt,
        warehouseLocation,
        shelfLocation,
        incomingStock,
        outgoingStock,
        lastStockTakeDate,
        lastStockTakeQuantity,
        const DeepCollectionEquality().hash(_metadata),
        averageDailySales,
        daysOfStock,
        preferredSupplierId,
        const DeepCollectionEquality().hash(_activeAlerts)
      ]);

  /// Create a copy of BranchInventory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BranchInventoryImplCopyWith<_$BranchInventoryImpl> get copyWith =>
      __$$BranchInventoryImplCopyWithImpl<_$BranchInventoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BranchInventoryImplToJson(
      this,
    );
  }
}

abstract class _BranchInventory extends BranchInventory {
  const factory _BranchInventory(
      {required final String id,
      required final String branchId,
      required final String productId,
      final double currentStock,
      final double reservedStock,
      final double availableStock,
      final double minStock,
      final double? maxStock,
      final double? reorderPoint,
      final double reorderQuantity,
      required final DateTime lastUpdated,
      final DateTime? syncedAt,
      final String? warehouseLocation,
      final String? shelfLocation,
      final double incomingStock,
      final double outgoingStock,
      final DateTime? lastStockTakeDate,
      final double? lastStockTakeQuantity,
      final Map<String, dynamic> metadata,
      final double averageDailySales,
      final int daysOfStock,
      final String? preferredSupplierId,
      final List<StockAlert> activeAlerts}) = _$BranchInventoryImpl;
  const _BranchInventory._() : super._();

  factory _BranchInventory.fromJson(Map<String, dynamic> json) =
      _$BranchInventoryImpl.fromJson;

  @override
  String get id;
  @override
  String get branchId;
  @override
  String get productId;
  @override
  double get currentStock;
  @override
  double get reservedStock;
  @override
  double get availableStock;
  @override
  double get minStock;
  @override
  double? get maxStock;
  @override
  double? get reorderPoint;
  @override
  double get reorderQuantity;
  @override
  DateTime get lastUpdated;
  @override
  DateTime? get syncedAt; // Additional tracking fields
  @override
  String? get warehouseLocation;
  @override
  String? get shelfLocation;
  @override
  double get incomingStock;
  @override
  double get outgoingStock;
  @override
  DateTime? get lastStockTakeDate;
  @override
  double? get lastStockTakeQuantity;
  @override
  Map<String, dynamic> get metadata;
  @override
  double get averageDailySales;
  @override
  int get daysOfStock;
  @override
  String? get preferredSupplierId;
  @override
  List<StockAlert> get activeAlerts;

  /// Create a copy of BranchInventory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BranchInventoryImplCopyWith<_$BranchInventoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StockAlert _$StockAlertFromJson(Map<String, dynamic> json) {
  return _StockAlert.fromJson(json);
}

/// @nodoc
mixin _$StockAlert {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  AlertSeverity get severity => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get acknowledgedAt => throw _privateConstructorUsedError;
  String? get acknowledgedBy => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this StockAlert to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StockAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StockAlertCopyWith<StockAlert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockAlertCopyWith<$Res> {
  factory $StockAlertCopyWith(
          StockAlert value, $Res Function(StockAlert) then) =
      _$StockAlertCopyWithImpl<$Res, StockAlert>;
  @useResult
  $Res call(
      {String id,
      String type,
      String message,
      AlertSeverity severity,
      DateTime createdAt,
      DateTime? acknowledgedAt,
      String? acknowledgedBy,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$StockAlertCopyWithImpl<$Res, $Val extends StockAlert>
    implements $StockAlertCopyWith<$Res> {
  _$StockAlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StockAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? message = null,
    Object? severity = null,
    Object? createdAt = null,
    Object? acknowledgedAt = freezed,
    Object? acknowledgedBy = freezed,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as AlertSeverity,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      acknowledgedAt: freezed == acknowledgedAt
          ? _value.acknowledgedAt
          : acknowledgedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      acknowledgedBy: freezed == acknowledgedBy
          ? _value.acknowledgedBy
          : acknowledgedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StockAlertImplCopyWith<$Res>
    implements $StockAlertCopyWith<$Res> {
  factory _$$StockAlertImplCopyWith(
          _$StockAlertImpl value, $Res Function(_$StockAlertImpl) then) =
      __$$StockAlertImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String type,
      String message,
      AlertSeverity severity,
      DateTime createdAt,
      DateTime? acknowledgedAt,
      String? acknowledgedBy,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$$StockAlertImplCopyWithImpl<$Res>
    extends _$StockAlertCopyWithImpl<$Res, _$StockAlertImpl>
    implements _$$StockAlertImplCopyWith<$Res> {
  __$$StockAlertImplCopyWithImpl(
      _$StockAlertImpl _value, $Res Function(_$StockAlertImpl) _then)
      : super(_value, _then);

  /// Create a copy of StockAlert
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? message = null,
    Object? severity = null,
    Object? createdAt = null,
    Object? acknowledgedAt = freezed,
    Object? acknowledgedBy = freezed,
    Object? metadata = null,
  }) {
    return _then(_$StockAlertImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as AlertSeverity,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      acknowledgedAt: freezed == acknowledgedAt
          ? _value.acknowledgedAt
          : acknowledgedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      acknowledgedBy: freezed == acknowledgedBy
          ? _value.acknowledgedBy
          : acknowledgedBy // ignore: cast_nullable_to_non_nullable
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
class _$StockAlertImpl implements _StockAlert {
  const _$StockAlertImpl(
      {required this.id,
      required this.type,
      required this.message,
      required this.severity,
      required this.createdAt,
      this.acknowledgedAt,
      this.acknowledgedBy,
      final Map<String, dynamic> metadata = const {}})
      : _metadata = metadata;

  factory _$StockAlertImpl.fromJson(Map<String, dynamic> json) =>
      _$$StockAlertImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final String message;
  @override
  final AlertSeverity severity;
  @override
  final DateTime createdAt;
  @override
  final DateTime? acknowledgedAt;
  @override
  final String? acknowledgedBy;
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
    return 'StockAlert(id: $id, type: $type, message: $message, severity: $severity, createdAt: $createdAt, acknowledgedAt: $acknowledgedAt, acknowledgedBy: $acknowledgedBy, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockAlertImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.acknowledgedAt, acknowledgedAt) ||
                other.acknowledgedAt == acknowledgedAt) &&
            (identical(other.acknowledgedBy, acknowledgedBy) ||
                other.acknowledgedBy == acknowledgedBy) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      message,
      severity,
      createdAt,
      acknowledgedAt,
      acknowledgedBy,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of StockAlert
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StockAlertImplCopyWith<_$StockAlertImpl> get copyWith =>
      __$$StockAlertImplCopyWithImpl<_$StockAlertImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StockAlertImplToJson(
      this,
    );
  }
}

abstract class _StockAlert implements StockAlert {
  const factory _StockAlert(
      {required final String id,
      required final String type,
      required final String message,
      required final AlertSeverity severity,
      required final DateTime createdAt,
      final DateTime? acknowledgedAt,
      final String? acknowledgedBy,
      final Map<String, dynamic> metadata}) = _$StockAlertImpl;

  factory _StockAlert.fromJson(Map<String, dynamic> json) =
      _$StockAlertImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String get message;
  @override
  AlertSeverity get severity;
  @override
  DateTime get createdAt;
  @override
  DateTime? get acknowledgedAt;
  @override
  String? get acknowledgedBy;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of StockAlert
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StockAlertImplCopyWith<_$StockAlertImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
