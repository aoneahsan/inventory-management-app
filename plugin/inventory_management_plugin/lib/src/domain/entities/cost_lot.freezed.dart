// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cost_lot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CostLot _$CostLotFromJson(Map<String, dynamic> json) {
  return _CostLot.fromJson(json);
}

/// @nodoc
mixin _$CostLot {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  String? get branchId => throw _privateConstructorUsedError;
  String get lotNumber => throw _privateConstructorUsedError;
  DateTime get purchaseDate => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  double get remainingQuantity => throw _privateConstructorUsedError;
  double get unitCost => throw _privateConstructorUsedError;
  String? get supplierId => throw _privateConstructorUsedError;
  String? get purchaseOrderId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional fields
  String? get batchId => throw _privateConstructorUsedError;
  DateTime? get expiryDate => throw _privateConstructorUsedError;
  LotStatus get status => throw _privateConstructorUsedError;
  String? get warehouseLocation => throw _privateConstructorUsedError;
  double? get landedCost => throw _privateConstructorUsedError;
  Map<String, double> get additionalCosts => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  double? get exchangeRate => throw _privateConstructorUsedError;
  String? get invoiceNumber => throw _privateConstructorUsedError;
  DateTime? get receivedDate => throw _privateConstructorUsedError;
  String? get receivedBy => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  double? get taxAmount => throw _privateConstructorUsedError;
  double? get discountAmount => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  List<CostLotMovement> get movements => throw _privateConstructorUsedError;

  /// Serializes this CostLot to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CostLot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CostLotCopyWith<CostLot> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CostLotCopyWith<$Res> {
  factory $CostLotCopyWith(CostLot value, $Res Function(CostLot) then) =
      _$CostLotCopyWithImpl<$Res, CostLot>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String productId,
      String? branchId,
      String lotNumber,
      DateTime purchaseDate,
      double quantity,
      double remainingQuantity,
      double unitCost,
      String? supplierId,
      String? purchaseOrderId,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? batchId,
      DateTime? expiryDate,
      LotStatus status,
      String? warehouseLocation,
      double? landedCost,
      Map<String, double> additionalCosts,
      String? currency,
      double? exchangeRate,
      String? invoiceNumber,
      DateTime? receivedDate,
      String? receivedBy,
      Map<String, dynamic> metadata,
      double? taxAmount,
      double? discountAmount,
      String? notes,
      List<CostLotMovement> movements});
}

/// @nodoc
class _$CostLotCopyWithImpl<$Res, $Val extends CostLot>
    implements $CostLotCopyWith<$Res> {
  _$CostLotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CostLot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? productId = null,
    Object? branchId = freezed,
    Object? lotNumber = null,
    Object? purchaseDate = null,
    Object? quantity = null,
    Object? remainingQuantity = null,
    Object? unitCost = null,
    Object? supplierId = freezed,
    Object? purchaseOrderId = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? batchId = freezed,
    Object? expiryDate = freezed,
    Object? status = null,
    Object? warehouseLocation = freezed,
    Object? landedCost = freezed,
    Object? additionalCosts = null,
    Object? currency = freezed,
    Object? exchangeRate = freezed,
    Object? invoiceNumber = freezed,
    Object? receivedDate = freezed,
    Object? receivedBy = freezed,
    Object? metadata = null,
    Object? taxAmount = freezed,
    Object? discountAmount = freezed,
    Object? notes = freezed,
    Object? movements = null,
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
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      branchId: freezed == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as String?,
      lotNumber: null == lotNumber
          ? _value.lotNumber
          : lotNumber // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseDate: null == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      remainingQuantity: null == remainingQuantity
          ? _value.remainingQuantity
          : remainingQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitCost: null == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double,
      supplierId: freezed == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as String?,
      purchaseOrderId: freezed == purchaseOrderId
          ? _value.purchaseOrderId
          : purchaseOrderId // ignore: cast_nullable_to_non_nullable
              as String?,
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
      batchId: freezed == batchId
          ? _value.batchId
          : batchId // ignore: cast_nullable_to_non_nullable
              as String?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LotStatus,
      warehouseLocation: freezed == warehouseLocation
          ? _value.warehouseLocation
          : warehouseLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      landedCost: freezed == landedCost
          ? _value.landedCost
          : landedCost // ignore: cast_nullable_to_non_nullable
              as double?,
      additionalCosts: null == additionalCosts
          ? _value.additionalCosts
          : additionalCosts // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      exchangeRate: freezed == exchangeRate
          ? _value.exchangeRate
          : exchangeRate // ignore: cast_nullable_to_non_nullable
              as double?,
      invoiceNumber: freezed == invoiceNumber
          ? _value.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      receivedDate: freezed == receivedDate
          ? _value.receivedDate
          : receivedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      receivedBy: freezed == receivedBy
          ? _value.receivedBy
          : receivedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      taxAmount: freezed == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      movements: null == movements
          ? _value.movements
          : movements // ignore: cast_nullable_to_non_nullable
              as List<CostLotMovement>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CostLotImplCopyWith<$Res> implements $CostLotCopyWith<$Res> {
  factory _$$CostLotImplCopyWith(
          _$CostLotImpl value, $Res Function(_$CostLotImpl) then) =
      __$$CostLotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String productId,
      String? branchId,
      String lotNumber,
      DateTime purchaseDate,
      double quantity,
      double remainingQuantity,
      double unitCost,
      String? supplierId,
      String? purchaseOrderId,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? batchId,
      DateTime? expiryDate,
      LotStatus status,
      String? warehouseLocation,
      double? landedCost,
      Map<String, double> additionalCosts,
      String? currency,
      double? exchangeRate,
      String? invoiceNumber,
      DateTime? receivedDate,
      String? receivedBy,
      Map<String, dynamic> metadata,
      double? taxAmount,
      double? discountAmount,
      String? notes,
      List<CostLotMovement> movements});
}

/// @nodoc
class __$$CostLotImplCopyWithImpl<$Res>
    extends _$CostLotCopyWithImpl<$Res, _$CostLotImpl>
    implements _$$CostLotImplCopyWith<$Res> {
  __$$CostLotImplCopyWithImpl(
      _$CostLotImpl _value, $Res Function(_$CostLotImpl) _then)
      : super(_value, _then);

  /// Create a copy of CostLot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? productId = null,
    Object? branchId = freezed,
    Object? lotNumber = null,
    Object? purchaseDate = null,
    Object? quantity = null,
    Object? remainingQuantity = null,
    Object? unitCost = null,
    Object? supplierId = freezed,
    Object? purchaseOrderId = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? batchId = freezed,
    Object? expiryDate = freezed,
    Object? status = null,
    Object? warehouseLocation = freezed,
    Object? landedCost = freezed,
    Object? additionalCosts = null,
    Object? currency = freezed,
    Object? exchangeRate = freezed,
    Object? invoiceNumber = freezed,
    Object? receivedDate = freezed,
    Object? receivedBy = freezed,
    Object? metadata = null,
    Object? taxAmount = freezed,
    Object? discountAmount = freezed,
    Object? notes = freezed,
    Object? movements = null,
  }) {
    return _then(_$CostLotImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      branchId: freezed == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as String?,
      lotNumber: null == lotNumber
          ? _value.lotNumber
          : lotNumber // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseDate: null == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      remainingQuantity: null == remainingQuantity
          ? _value.remainingQuantity
          : remainingQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitCost: null == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double,
      supplierId: freezed == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as String?,
      purchaseOrderId: freezed == purchaseOrderId
          ? _value.purchaseOrderId
          : purchaseOrderId // ignore: cast_nullable_to_non_nullable
              as String?,
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
      batchId: freezed == batchId
          ? _value.batchId
          : batchId // ignore: cast_nullable_to_non_nullable
              as String?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LotStatus,
      warehouseLocation: freezed == warehouseLocation
          ? _value.warehouseLocation
          : warehouseLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      landedCost: freezed == landedCost
          ? _value.landedCost
          : landedCost // ignore: cast_nullable_to_non_nullable
              as double?,
      additionalCosts: null == additionalCosts
          ? _value._additionalCosts
          : additionalCosts // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      exchangeRate: freezed == exchangeRate
          ? _value.exchangeRate
          : exchangeRate // ignore: cast_nullable_to_non_nullable
              as double?,
      invoiceNumber: freezed == invoiceNumber
          ? _value.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      receivedDate: freezed == receivedDate
          ? _value.receivedDate
          : receivedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      receivedBy: freezed == receivedBy
          ? _value.receivedBy
          : receivedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      taxAmount: freezed == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      movements: null == movements
          ? _value._movements
          : movements // ignore: cast_nullable_to_non_nullable
              as List<CostLotMovement>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CostLotImpl extends _CostLot {
  const _$CostLotImpl(
      {required this.id,
      required this.organizationId,
      required this.productId,
      this.branchId,
      required this.lotNumber,
      required this.purchaseDate,
      required this.quantity,
      required this.remainingQuantity,
      required this.unitCost,
      this.supplierId,
      this.purchaseOrderId,
      required this.createdAt,
      required this.updatedAt,
      this.syncedAt,
      this.batchId,
      this.expiryDate,
      this.status = LotStatus.active,
      this.warehouseLocation,
      this.landedCost,
      final Map<String, double> additionalCosts = const {},
      this.currency,
      this.exchangeRate,
      this.invoiceNumber,
      this.receivedDate,
      this.receivedBy,
      final Map<String, dynamic> metadata = const {},
      this.taxAmount,
      this.discountAmount,
      this.notes,
      final List<CostLotMovement> movements = const []})
      : _additionalCosts = additionalCosts,
        _metadata = metadata,
        _movements = movements,
        super._();

  factory _$CostLotImpl.fromJson(Map<String, dynamic> json) =>
      _$$CostLotImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String productId;
  @override
  final String? branchId;
  @override
  final String lotNumber;
  @override
  final DateTime purchaseDate;
  @override
  final double quantity;
  @override
  final double remainingQuantity;
  @override
  final double unitCost;
  @override
  final String? supplierId;
  @override
  final String? purchaseOrderId;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? syncedAt;
// Additional fields
  @override
  final String? batchId;
  @override
  final DateTime? expiryDate;
  @override
  @JsonKey()
  final LotStatus status;
  @override
  final String? warehouseLocation;
  @override
  final double? landedCost;
  final Map<String, double> _additionalCosts;
  @override
  @JsonKey()
  Map<String, double> get additionalCosts {
    if (_additionalCosts is EqualUnmodifiableMapView) return _additionalCosts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_additionalCosts);
  }

  @override
  final String? currency;
  @override
  final double? exchangeRate;
  @override
  final String? invoiceNumber;
  @override
  final DateTime? receivedDate;
  @override
  final String? receivedBy;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  final double? taxAmount;
  @override
  final double? discountAmount;
  @override
  final String? notes;
  final List<CostLotMovement> _movements;
  @override
  @JsonKey()
  List<CostLotMovement> get movements {
    if (_movements is EqualUnmodifiableListView) return _movements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_movements);
  }

  @override
  String toString() {
    return 'CostLot(id: $id, organizationId: $organizationId, productId: $productId, branchId: $branchId, lotNumber: $lotNumber, purchaseDate: $purchaseDate, quantity: $quantity, remainingQuantity: $remainingQuantity, unitCost: $unitCost, supplierId: $supplierId, purchaseOrderId: $purchaseOrderId, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt, batchId: $batchId, expiryDate: $expiryDate, status: $status, warehouseLocation: $warehouseLocation, landedCost: $landedCost, additionalCosts: $additionalCosts, currency: $currency, exchangeRate: $exchangeRate, invoiceNumber: $invoiceNumber, receivedDate: $receivedDate, receivedBy: $receivedBy, metadata: $metadata, taxAmount: $taxAmount, discountAmount: $discountAmount, notes: $notes, movements: $movements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CostLotImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.branchId, branchId) ||
                other.branchId == branchId) &&
            (identical(other.lotNumber, lotNumber) ||
                other.lotNumber == lotNumber) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.remainingQuantity, remainingQuantity) ||
                other.remainingQuantity == remainingQuantity) &&
            (identical(other.unitCost, unitCost) ||
                other.unitCost == unitCost) &&
            (identical(other.supplierId, supplierId) ||
                other.supplierId == supplierId) &&
            (identical(other.purchaseOrderId, purchaseOrderId) ||
                other.purchaseOrderId == purchaseOrderId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.batchId, batchId) || other.batchId == batchId) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.warehouseLocation, warehouseLocation) ||
                other.warehouseLocation == warehouseLocation) &&
            (identical(other.landedCost, landedCost) ||
                other.landedCost == landedCost) &&
            const DeepCollectionEquality()
                .equals(other._additionalCosts, _additionalCosts) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.exchangeRate, exchangeRate) ||
                other.exchangeRate == exchangeRate) &&
            (identical(other.invoiceNumber, invoiceNumber) ||
                other.invoiceNumber == invoiceNumber) &&
            (identical(other.receivedDate, receivedDate) ||
                other.receivedDate == receivedDate) &&
            (identical(other.receivedBy, receivedBy) ||
                other.receivedBy == receivedBy) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.taxAmount, taxAmount) ||
                other.taxAmount == taxAmount) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality()
                .equals(other._movements, _movements));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        organizationId,
        productId,
        branchId,
        lotNumber,
        purchaseDate,
        quantity,
        remainingQuantity,
        unitCost,
        supplierId,
        purchaseOrderId,
        createdAt,
        updatedAt,
        syncedAt,
        batchId,
        expiryDate,
        status,
        warehouseLocation,
        landedCost,
        const DeepCollectionEquality().hash(_additionalCosts),
        currency,
        exchangeRate,
        invoiceNumber,
        receivedDate,
        receivedBy,
        const DeepCollectionEquality().hash(_metadata),
        taxAmount,
        discountAmount,
        notes,
        const DeepCollectionEquality().hash(_movements)
      ]);

  /// Create a copy of CostLot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CostLotImplCopyWith<_$CostLotImpl> get copyWith =>
      __$$CostLotImplCopyWithImpl<_$CostLotImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CostLotImplToJson(
      this,
    );
  }
}

abstract class _CostLot extends CostLot {
  const factory _CostLot(
      {required final String id,
      required final String organizationId,
      required final String productId,
      final String? branchId,
      required final String lotNumber,
      required final DateTime purchaseDate,
      required final double quantity,
      required final double remainingQuantity,
      required final double unitCost,
      final String? supplierId,
      final String? purchaseOrderId,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final DateTime? syncedAt,
      final String? batchId,
      final DateTime? expiryDate,
      final LotStatus status,
      final String? warehouseLocation,
      final double? landedCost,
      final Map<String, double> additionalCosts,
      final String? currency,
      final double? exchangeRate,
      final String? invoiceNumber,
      final DateTime? receivedDate,
      final String? receivedBy,
      final Map<String, dynamic> metadata,
      final double? taxAmount,
      final double? discountAmount,
      final String? notes,
      final List<CostLotMovement> movements}) = _$CostLotImpl;
  const _CostLot._() : super._();

  factory _CostLot.fromJson(Map<String, dynamic> json) = _$CostLotImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String get productId;
  @override
  String? get branchId;
  @override
  String get lotNumber;
  @override
  DateTime get purchaseDate;
  @override
  double get quantity;
  @override
  double get remainingQuantity;
  @override
  double get unitCost;
  @override
  String? get supplierId;
  @override
  String? get purchaseOrderId;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get syncedAt; // Additional fields
  @override
  String? get batchId;
  @override
  DateTime? get expiryDate;
  @override
  LotStatus get status;
  @override
  String? get warehouseLocation;
  @override
  double? get landedCost;
  @override
  Map<String, double> get additionalCosts;
  @override
  String? get currency;
  @override
  double? get exchangeRate;
  @override
  String? get invoiceNumber;
  @override
  DateTime? get receivedDate;
  @override
  String? get receivedBy;
  @override
  Map<String, dynamic> get metadata;
  @override
  double? get taxAmount;
  @override
  double? get discountAmount;
  @override
  String? get notes;
  @override
  List<CostLotMovement> get movements;

  /// Create a copy of CostLot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CostLotImplCopyWith<_$CostLotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CostLotMovement _$CostLotMovementFromJson(Map<String, dynamic> json) {
  return _CostLotMovement.fromJson(json);
}

/// @nodoc
mixin _$CostLotMovement {
  String get id => throw _privateConstructorUsedError;
  String get costLotId => throw _privateConstructorUsedError;
  String get movementType => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  DateTime get movementDate => throw _privateConstructorUsedError;
  String? get referenceId => throw _privateConstructorUsedError;
  String? get referenceType => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this CostLotMovement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CostLotMovement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CostLotMovementCopyWith<CostLotMovement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CostLotMovementCopyWith<$Res> {
  factory $CostLotMovementCopyWith(
          CostLotMovement value, $Res Function(CostLotMovement) then) =
      _$CostLotMovementCopyWithImpl<$Res, CostLotMovement>;
  @useResult
  $Res call(
      {String id,
      String costLotId,
      String movementType,
      double quantity,
      DateTime movementDate,
      String? referenceId,
      String? referenceType,
      String? notes,
      DateTime createdAt});
}

/// @nodoc
class _$CostLotMovementCopyWithImpl<$Res, $Val extends CostLotMovement>
    implements $CostLotMovementCopyWith<$Res> {
  _$CostLotMovementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CostLotMovement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? costLotId = null,
    Object? movementType = null,
    Object? quantity = null,
    Object? movementDate = null,
    Object? referenceId = freezed,
    Object? referenceType = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      costLotId: null == costLotId
          ? _value.costLotId
          : costLotId // ignore: cast_nullable_to_non_nullable
              as String,
      movementType: null == movementType
          ? _value.movementType
          : movementType // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      movementDate: null == movementDate
          ? _value.movementDate
          : movementDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      referenceId: freezed == referenceId
          ? _value.referenceId
          : referenceId // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceType: freezed == referenceType
          ? _value.referenceType
          : referenceType // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CostLotMovementImplCopyWith<$Res>
    implements $CostLotMovementCopyWith<$Res> {
  factory _$$CostLotMovementImplCopyWith(_$CostLotMovementImpl value,
          $Res Function(_$CostLotMovementImpl) then) =
      __$$CostLotMovementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String costLotId,
      String movementType,
      double quantity,
      DateTime movementDate,
      String? referenceId,
      String? referenceType,
      String? notes,
      DateTime createdAt});
}

/// @nodoc
class __$$CostLotMovementImplCopyWithImpl<$Res>
    extends _$CostLotMovementCopyWithImpl<$Res, _$CostLotMovementImpl>
    implements _$$CostLotMovementImplCopyWith<$Res> {
  __$$CostLotMovementImplCopyWithImpl(
      _$CostLotMovementImpl _value, $Res Function(_$CostLotMovementImpl) _then)
      : super(_value, _then);

  /// Create a copy of CostLotMovement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? costLotId = null,
    Object? movementType = null,
    Object? quantity = null,
    Object? movementDate = null,
    Object? referenceId = freezed,
    Object? referenceType = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$CostLotMovementImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      costLotId: null == costLotId
          ? _value.costLotId
          : costLotId // ignore: cast_nullable_to_non_nullable
              as String,
      movementType: null == movementType
          ? _value.movementType
          : movementType // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      movementDate: null == movementDate
          ? _value.movementDate
          : movementDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      referenceId: freezed == referenceId
          ? _value.referenceId
          : referenceId // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceType: freezed == referenceType
          ? _value.referenceType
          : referenceType // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CostLotMovementImpl implements _CostLotMovement {
  const _$CostLotMovementImpl(
      {required this.id,
      required this.costLotId,
      required this.movementType,
      required this.quantity,
      required this.movementDate,
      this.referenceId,
      this.referenceType,
      this.notes,
      required this.createdAt});

  factory _$CostLotMovementImpl.fromJson(Map<String, dynamic> json) =>
      _$$CostLotMovementImplFromJson(json);

  @override
  final String id;
  @override
  final String costLotId;
  @override
  final String movementType;
  @override
  final double quantity;
  @override
  final DateTime movementDate;
  @override
  final String? referenceId;
  @override
  final String? referenceType;
  @override
  final String? notes;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'CostLotMovement(id: $id, costLotId: $costLotId, movementType: $movementType, quantity: $quantity, movementDate: $movementDate, referenceId: $referenceId, referenceType: $referenceType, notes: $notes, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CostLotMovementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.costLotId, costLotId) ||
                other.costLotId == costLotId) &&
            (identical(other.movementType, movementType) ||
                other.movementType == movementType) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.movementDate, movementDate) ||
                other.movementDate == movementDate) &&
            (identical(other.referenceId, referenceId) ||
                other.referenceId == referenceId) &&
            (identical(other.referenceType, referenceType) ||
                other.referenceType == referenceType) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, costLotId, movementType,
      quantity, movementDate, referenceId, referenceType, notes, createdAt);

  /// Create a copy of CostLotMovement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CostLotMovementImplCopyWith<_$CostLotMovementImpl> get copyWith =>
      __$$CostLotMovementImplCopyWithImpl<_$CostLotMovementImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CostLotMovementImplToJson(
      this,
    );
  }
}

abstract class _CostLotMovement implements CostLotMovement {
  const factory _CostLotMovement(
      {required final String id,
      required final String costLotId,
      required final String movementType,
      required final double quantity,
      required final DateTime movementDate,
      final String? referenceId,
      final String? referenceType,
      final String? notes,
      required final DateTime createdAt}) = _$CostLotMovementImpl;

  factory _CostLotMovement.fromJson(Map<String, dynamic> json) =
      _$CostLotMovementImpl.fromJson;

  @override
  String get id;
  @override
  String get costLotId;
  @override
  String get movementType;
  @override
  double get quantity;
  @override
  DateTime get movementDate;
  @override
  String? get referenceId;
  @override
  String? get referenceType;
  @override
  String? get notes;
  @override
  DateTime get createdAt;

  /// Create a copy of CostLotMovement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CostLotMovementImplCopyWith<_$CostLotMovementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CostLotAllocation _$CostLotAllocationFromJson(Map<String, dynamic> json) {
  return _CostLotAllocation.fromJson(json);
}

/// @nodoc
mixin _$CostLotAllocation {
  String get costLotId => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  double get unitCost => throw _privateConstructorUsedError;
  double get totalCost => throw _privateConstructorUsedError;

  /// Serializes this CostLotAllocation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CostLotAllocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CostLotAllocationCopyWith<CostLotAllocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CostLotAllocationCopyWith<$Res> {
  factory $CostLotAllocationCopyWith(
          CostLotAllocation value, $Res Function(CostLotAllocation) then) =
      _$CostLotAllocationCopyWithImpl<$Res, CostLotAllocation>;
  @useResult
  $Res call(
      {String costLotId, double quantity, double unitCost, double totalCost});
}

/// @nodoc
class _$CostLotAllocationCopyWithImpl<$Res, $Val extends CostLotAllocation>
    implements $CostLotAllocationCopyWith<$Res> {
  _$CostLotAllocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CostLotAllocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? costLotId = null,
    Object? quantity = null,
    Object? unitCost = null,
    Object? totalCost = null,
  }) {
    return _then(_value.copyWith(
      costLotId: null == costLotId
          ? _value.costLotId
          : costLotId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitCost: null == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double,
      totalCost: null == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CostLotAllocationImplCopyWith<$Res>
    implements $CostLotAllocationCopyWith<$Res> {
  factory _$$CostLotAllocationImplCopyWith(_$CostLotAllocationImpl value,
          $Res Function(_$CostLotAllocationImpl) then) =
      __$$CostLotAllocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String costLotId, double quantity, double unitCost, double totalCost});
}

/// @nodoc
class __$$CostLotAllocationImplCopyWithImpl<$Res>
    extends _$CostLotAllocationCopyWithImpl<$Res, _$CostLotAllocationImpl>
    implements _$$CostLotAllocationImplCopyWith<$Res> {
  __$$CostLotAllocationImplCopyWithImpl(_$CostLotAllocationImpl _value,
      $Res Function(_$CostLotAllocationImpl) _then)
      : super(_value, _then);

  /// Create a copy of CostLotAllocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? costLotId = null,
    Object? quantity = null,
    Object? unitCost = null,
    Object? totalCost = null,
  }) {
    return _then(_$CostLotAllocationImpl(
      costLotId: null == costLotId
          ? _value.costLotId
          : costLotId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitCost: null == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double,
      totalCost: null == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CostLotAllocationImpl implements _CostLotAllocation {
  const _$CostLotAllocationImpl(
      {required this.costLotId,
      required this.quantity,
      required this.unitCost,
      required this.totalCost});

  factory _$CostLotAllocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$CostLotAllocationImplFromJson(json);

  @override
  final String costLotId;
  @override
  final double quantity;
  @override
  final double unitCost;
  @override
  final double totalCost;

  @override
  String toString() {
    return 'CostLotAllocation(costLotId: $costLotId, quantity: $quantity, unitCost: $unitCost, totalCost: $totalCost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CostLotAllocationImpl &&
            (identical(other.costLotId, costLotId) ||
                other.costLotId == costLotId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitCost, unitCost) ||
                other.unitCost == unitCost) &&
            (identical(other.totalCost, totalCost) ||
                other.totalCost == totalCost));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, costLotId, quantity, unitCost, totalCost);

  /// Create a copy of CostLotAllocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CostLotAllocationImplCopyWith<_$CostLotAllocationImpl> get copyWith =>
      __$$CostLotAllocationImplCopyWithImpl<_$CostLotAllocationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CostLotAllocationImplToJson(
      this,
    );
  }
}

abstract class _CostLotAllocation implements CostLotAllocation {
  const factory _CostLotAllocation(
      {required final String costLotId,
      required final double quantity,
      required final double unitCost,
      required final double totalCost}) = _$CostLotAllocationImpl;

  factory _CostLotAllocation.fromJson(Map<String, dynamic> json) =
      _$CostLotAllocationImpl.fromJson;

  @override
  String get costLotId;
  @override
  double get quantity;
  @override
  double get unitCost;
  @override
  double get totalCost;

  /// Create a copy of CostLotAllocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CostLotAllocationImplCopyWith<_$CostLotAllocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
