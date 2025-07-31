// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_transfer_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StockTransferItem _$StockTransferItemFromJson(Map<String, dynamic> json) {
  return _StockTransferItem.fromJson(json);
}

/// @nodoc
mixin _$StockTransferItem {
  String get id => throw _privateConstructorUsedError;
  String get stockTransferId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  double get requestedQuantity => throw _privateConstructorUsedError;
  double? get approvedQuantity => throw _privateConstructorUsedError;
  double? get shippedQuantity => throw _privateConstructorUsedError;
  double? get receivedQuantity => throw _privateConstructorUsedError;
  String? get batchId => throw _privateConstructorUsedError;
  String? get serialNumber => throw _privateConstructorUsedError;
  String? get discrepancyReason => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this StockTransferItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StockTransferItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StockTransferItemCopyWith<StockTransferItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockTransferItemCopyWith<$Res> {
  factory $StockTransferItemCopyWith(
          StockTransferItem value, $Res Function(StockTransferItem) then) =
      _$StockTransferItemCopyWithImpl<$Res, StockTransferItem>;
  @useResult
  $Res call(
      {String id,
      String stockTransferId,
      String productId,
      double requestedQuantity,
      double? approvedQuantity,
      double? shippedQuantity,
      double? receivedQuantity,
      String? batchId,
      String? serialNumber,
      String? discrepancyReason,
      String? notes,
      DateTime createdAt});
}

/// @nodoc
class _$StockTransferItemCopyWithImpl<$Res, $Val extends StockTransferItem>
    implements $StockTransferItemCopyWith<$Res> {
  _$StockTransferItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StockTransferItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? stockTransferId = null,
    Object? productId = null,
    Object? requestedQuantity = null,
    Object? approvedQuantity = freezed,
    Object? shippedQuantity = freezed,
    Object? receivedQuantity = freezed,
    Object? batchId = freezed,
    Object? serialNumber = freezed,
    Object? discrepancyReason = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      stockTransferId: null == stockTransferId
          ? _value.stockTransferId
          : stockTransferId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      requestedQuantity: null == requestedQuantity
          ? _value.requestedQuantity
          : requestedQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      approvedQuantity: freezed == approvedQuantity
          ? _value.approvedQuantity
          : approvedQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      shippedQuantity: freezed == shippedQuantity
          ? _value.shippedQuantity
          : shippedQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      receivedQuantity: freezed == receivedQuantity
          ? _value.receivedQuantity
          : receivedQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      batchId: freezed == batchId
          ? _value.batchId
          : batchId // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      discrepancyReason: freezed == discrepancyReason
          ? _value.discrepancyReason
          : discrepancyReason // ignore: cast_nullable_to_non_nullable
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
abstract class _$$StockTransferItemImplCopyWith<$Res>
    implements $StockTransferItemCopyWith<$Res> {
  factory _$$StockTransferItemImplCopyWith(_$StockTransferItemImpl value,
          $Res Function(_$StockTransferItemImpl) then) =
      __$$StockTransferItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String stockTransferId,
      String productId,
      double requestedQuantity,
      double? approvedQuantity,
      double? shippedQuantity,
      double? receivedQuantity,
      String? batchId,
      String? serialNumber,
      String? discrepancyReason,
      String? notes,
      DateTime createdAt});
}

/// @nodoc
class __$$StockTransferItemImplCopyWithImpl<$Res>
    extends _$StockTransferItemCopyWithImpl<$Res, _$StockTransferItemImpl>
    implements _$$StockTransferItemImplCopyWith<$Res> {
  __$$StockTransferItemImplCopyWithImpl(_$StockTransferItemImpl _value,
      $Res Function(_$StockTransferItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of StockTransferItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? stockTransferId = null,
    Object? productId = null,
    Object? requestedQuantity = null,
    Object? approvedQuantity = freezed,
    Object? shippedQuantity = freezed,
    Object? receivedQuantity = freezed,
    Object? batchId = freezed,
    Object? serialNumber = freezed,
    Object? discrepancyReason = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$StockTransferItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      stockTransferId: null == stockTransferId
          ? _value.stockTransferId
          : stockTransferId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      requestedQuantity: null == requestedQuantity
          ? _value.requestedQuantity
          : requestedQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      approvedQuantity: freezed == approvedQuantity
          ? _value.approvedQuantity
          : approvedQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      shippedQuantity: freezed == shippedQuantity
          ? _value.shippedQuantity
          : shippedQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      receivedQuantity: freezed == receivedQuantity
          ? _value.receivedQuantity
          : receivedQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      batchId: freezed == batchId
          ? _value.batchId
          : batchId // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      discrepancyReason: freezed == discrepancyReason
          ? _value.discrepancyReason
          : discrepancyReason // ignore: cast_nullable_to_non_nullable
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
class _$StockTransferItemImpl implements _StockTransferItem {
  const _$StockTransferItemImpl(
      {required this.id,
      required this.stockTransferId,
      required this.productId,
      required this.requestedQuantity,
      this.approvedQuantity,
      this.shippedQuantity,
      this.receivedQuantity,
      this.batchId,
      this.serialNumber,
      this.discrepancyReason,
      this.notes,
      required this.createdAt});

  factory _$StockTransferItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$StockTransferItemImplFromJson(json);

  @override
  final String id;
  @override
  final String stockTransferId;
  @override
  final String productId;
  @override
  final double requestedQuantity;
  @override
  final double? approvedQuantity;
  @override
  final double? shippedQuantity;
  @override
  final double? receivedQuantity;
  @override
  final String? batchId;
  @override
  final String? serialNumber;
  @override
  final String? discrepancyReason;
  @override
  final String? notes;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'StockTransferItem(id: $id, stockTransferId: $stockTransferId, productId: $productId, requestedQuantity: $requestedQuantity, approvedQuantity: $approvedQuantity, shippedQuantity: $shippedQuantity, receivedQuantity: $receivedQuantity, batchId: $batchId, serialNumber: $serialNumber, discrepancyReason: $discrepancyReason, notes: $notes, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockTransferItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.stockTransferId, stockTransferId) ||
                other.stockTransferId == stockTransferId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.requestedQuantity, requestedQuantity) ||
                other.requestedQuantity == requestedQuantity) &&
            (identical(other.approvedQuantity, approvedQuantity) ||
                other.approvedQuantity == approvedQuantity) &&
            (identical(other.shippedQuantity, shippedQuantity) ||
                other.shippedQuantity == shippedQuantity) &&
            (identical(other.receivedQuantity, receivedQuantity) ||
                other.receivedQuantity == receivedQuantity) &&
            (identical(other.batchId, batchId) || other.batchId == batchId) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.discrepancyReason, discrepancyReason) ||
                other.discrepancyReason == discrepancyReason) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      stockTransferId,
      productId,
      requestedQuantity,
      approvedQuantity,
      shippedQuantity,
      receivedQuantity,
      batchId,
      serialNumber,
      discrepancyReason,
      notes,
      createdAt);

  /// Create a copy of StockTransferItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StockTransferItemImplCopyWith<_$StockTransferItemImpl> get copyWith =>
      __$$StockTransferItemImplCopyWithImpl<_$StockTransferItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StockTransferItemImplToJson(
      this,
    );
  }
}

abstract class _StockTransferItem implements StockTransferItem {
  const factory _StockTransferItem(
      {required final String id,
      required final String stockTransferId,
      required final String productId,
      required final double requestedQuantity,
      final double? approvedQuantity,
      final double? shippedQuantity,
      final double? receivedQuantity,
      final String? batchId,
      final String? serialNumber,
      final String? discrepancyReason,
      final String? notes,
      required final DateTime createdAt}) = _$StockTransferItemImpl;

  factory _StockTransferItem.fromJson(Map<String, dynamic> json) =
      _$StockTransferItemImpl.fromJson;

  @override
  String get id;
  @override
  String get stockTransferId;
  @override
  String get productId;
  @override
  double get requestedQuantity;
  @override
  double? get approvedQuantity;
  @override
  double? get shippedQuantity;
  @override
  double? get receivedQuantity;
  @override
  String? get batchId;
  @override
  String? get serialNumber;
  @override
  String? get discrepancyReason;
  @override
  String? get notes;
  @override
  DateTime get createdAt;

  /// Create a copy of StockTransferItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StockTransferItemImplCopyWith<_$StockTransferItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
