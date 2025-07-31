// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inventory_movement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InventoryMovement _$InventoryMovementFromJson(Map<String, dynamic> json) {
  return _InventoryMovement.fromJson(json);
}

/// @nodoc
mixin _$InventoryMovement {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  MovementType get type => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  double? get unitCost => throw _privateConstructorUsedError;
  double? get totalCost => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  String? get referenceNumber => throw _privateConstructorUsedError;
  String? get referenceId => throw _privateConstructorUsedError;
  String? get referenceType => throw _privateConstructorUsedError;
  String? get fromBranchId => throw _privateConstructorUsedError;
  String? get toBranchId => throw _privateConstructorUsedError;
  String? get fromLocation => throw _privateConstructorUsedError;
  String? get toLocation => throw _privateConstructorUsedError;
  String get performedBy => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional tracking fields
  String? get batchId => throw _privateConstructorUsedError;
  String? get serialNumber => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get approvedBy => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  double? get stockBefore => throw _privateConstructorUsedError;
  double? get stockAfter => throw _privateConstructorUsedError;
  String? get supplierId => throw _privateConstructorUsedError;
  String? get customerId => throw _privateConstructorUsedError;

  /// Serializes this InventoryMovement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InventoryMovement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InventoryMovementCopyWith<InventoryMovement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryMovementCopyWith<$Res> {
  factory $InventoryMovementCopyWith(
          InventoryMovement value, $Res Function(InventoryMovement) then) =
      _$InventoryMovementCopyWithImpl<$Res, InventoryMovement>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String productId,
      MovementType type,
      double quantity,
      double? unitCost,
      double? totalCost,
      String? reason,
      String? referenceNumber,
      String? referenceId,
      String? referenceType,
      String? fromBranchId,
      String? toBranchId,
      String? fromLocation,
      String? toLocation,
      String performedBy,
      String? notes,
      DateTime createdAt,
      DateTime? syncedAt,
      String? batchId,
      String? serialNumber,
      String status,
      String? approvedBy,
      DateTime? approvedAt,
      Map<String, dynamic> metadata,
      double? stockBefore,
      double? stockAfter,
      String? supplierId,
      String? customerId});
}

/// @nodoc
class _$InventoryMovementCopyWithImpl<$Res, $Val extends InventoryMovement>
    implements $InventoryMovementCopyWith<$Res> {
  _$InventoryMovementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InventoryMovement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? productId = null,
    Object? type = null,
    Object? quantity = null,
    Object? unitCost = freezed,
    Object? totalCost = freezed,
    Object? reason = freezed,
    Object? referenceNumber = freezed,
    Object? referenceId = freezed,
    Object? referenceType = freezed,
    Object? fromBranchId = freezed,
    Object? toBranchId = freezed,
    Object? fromLocation = freezed,
    Object? toLocation = freezed,
    Object? performedBy = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? syncedAt = freezed,
    Object? batchId = freezed,
    Object? serialNumber = freezed,
    Object? status = null,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
    Object? metadata = null,
    Object? stockBefore = freezed,
    Object? stockAfter = freezed,
    Object? supplierId = freezed,
    Object? customerId = freezed,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MovementType,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitCost: freezed == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double?,
      totalCost: freezed == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double?,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceNumber: freezed == referenceNumber
          ? _value.referenceNumber
          : referenceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceId: freezed == referenceId
          ? _value.referenceId
          : referenceId // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceType: freezed == referenceType
          ? _value.referenceType
          : referenceType // ignore: cast_nullable_to_non_nullable
              as String?,
      fromBranchId: freezed == fromBranchId
          ? _value.fromBranchId
          : fromBranchId // ignore: cast_nullable_to_non_nullable
              as String?,
      toBranchId: freezed == toBranchId
          ? _value.toBranchId
          : toBranchId // ignore: cast_nullable_to_non_nullable
              as String?,
      fromLocation: freezed == fromLocation
          ? _value.fromLocation
          : fromLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      toLocation: freezed == toLocation
          ? _value.toLocation
          : toLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      performedBy: null == performedBy
          ? _value.performedBy
          : performedBy // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      batchId: freezed == batchId
          ? _value.batchId
          : batchId // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      stockBefore: freezed == stockBefore
          ? _value.stockBefore
          : stockBefore // ignore: cast_nullable_to_non_nullable
              as double?,
      stockAfter: freezed == stockAfter
          ? _value.stockAfter
          : stockAfter // ignore: cast_nullable_to_non_nullable
              as double?,
      supplierId: freezed == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InventoryMovementImplCopyWith<$Res>
    implements $InventoryMovementCopyWith<$Res> {
  factory _$$InventoryMovementImplCopyWith(_$InventoryMovementImpl value,
          $Res Function(_$InventoryMovementImpl) then) =
      __$$InventoryMovementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String productId,
      MovementType type,
      double quantity,
      double? unitCost,
      double? totalCost,
      String? reason,
      String? referenceNumber,
      String? referenceId,
      String? referenceType,
      String? fromBranchId,
      String? toBranchId,
      String? fromLocation,
      String? toLocation,
      String performedBy,
      String? notes,
      DateTime createdAt,
      DateTime? syncedAt,
      String? batchId,
      String? serialNumber,
      String status,
      String? approvedBy,
      DateTime? approvedAt,
      Map<String, dynamic> metadata,
      double? stockBefore,
      double? stockAfter,
      String? supplierId,
      String? customerId});
}

/// @nodoc
class __$$InventoryMovementImplCopyWithImpl<$Res>
    extends _$InventoryMovementCopyWithImpl<$Res, _$InventoryMovementImpl>
    implements _$$InventoryMovementImplCopyWith<$Res> {
  __$$InventoryMovementImplCopyWithImpl(_$InventoryMovementImpl _value,
      $Res Function(_$InventoryMovementImpl) _then)
      : super(_value, _then);

  /// Create a copy of InventoryMovement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? productId = null,
    Object? type = null,
    Object? quantity = null,
    Object? unitCost = freezed,
    Object? totalCost = freezed,
    Object? reason = freezed,
    Object? referenceNumber = freezed,
    Object? referenceId = freezed,
    Object? referenceType = freezed,
    Object? fromBranchId = freezed,
    Object? toBranchId = freezed,
    Object? fromLocation = freezed,
    Object? toLocation = freezed,
    Object? performedBy = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? syncedAt = freezed,
    Object? batchId = freezed,
    Object? serialNumber = freezed,
    Object? status = null,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
    Object? metadata = null,
    Object? stockBefore = freezed,
    Object? stockAfter = freezed,
    Object? supplierId = freezed,
    Object? customerId = freezed,
  }) {
    return _then(_$InventoryMovementImpl(
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MovementType,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitCost: freezed == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double?,
      totalCost: freezed == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double?,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceNumber: freezed == referenceNumber
          ? _value.referenceNumber
          : referenceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceId: freezed == referenceId
          ? _value.referenceId
          : referenceId // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceType: freezed == referenceType
          ? _value.referenceType
          : referenceType // ignore: cast_nullable_to_non_nullable
              as String?,
      fromBranchId: freezed == fromBranchId
          ? _value.fromBranchId
          : fromBranchId // ignore: cast_nullable_to_non_nullable
              as String?,
      toBranchId: freezed == toBranchId
          ? _value.toBranchId
          : toBranchId // ignore: cast_nullable_to_non_nullable
              as String?,
      fromLocation: freezed == fromLocation
          ? _value.fromLocation
          : fromLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      toLocation: freezed == toLocation
          ? _value.toLocation
          : toLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      performedBy: null == performedBy
          ? _value.performedBy
          : performedBy // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      batchId: freezed == batchId
          ? _value.batchId
          : batchId // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      stockBefore: freezed == stockBefore
          ? _value.stockBefore
          : stockBefore // ignore: cast_nullable_to_non_nullable
              as double?,
      stockAfter: freezed == stockAfter
          ? _value.stockAfter
          : stockAfter // ignore: cast_nullable_to_non_nullable
              as double?,
      supplierId: freezed == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InventoryMovementImpl extends _InventoryMovement {
  const _$InventoryMovementImpl(
      {required this.id,
      required this.organizationId,
      required this.productId,
      required this.type,
      required this.quantity,
      this.unitCost,
      this.totalCost,
      this.reason,
      this.referenceNumber,
      this.referenceId,
      this.referenceType,
      this.fromBranchId,
      this.toBranchId,
      this.fromLocation,
      this.toLocation,
      required this.performedBy,
      this.notes,
      required this.createdAt,
      this.syncedAt,
      this.batchId,
      this.serialNumber,
      this.status = 'pending',
      this.approvedBy,
      this.approvedAt,
      final Map<String, dynamic> metadata = const {},
      this.stockBefore,
      this.stockAfter,
      this.supplierId,
      this.customerId})
      : _metadata = metadata,
        super._();

  factory _$InventoryMovementImpl.fromJson(Map<String, dynamic> json) =>
      _$$InventoryMovementImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String productId;
  @override
  final MovementType type;
  @override
  final double quantity;
  @override
  final double? unitCost;
  @override
  final double? totalCost;
  @override
  final String? reason;
  @override
  final String? referenceNumber;
  @override
  final String? referenceId;
  @override
  final String? referenceType;
  @override
  final String? fromBranchId;
  @override
  final String? toBranchId;
  @override
  final String? fromLocation;
  @override
  final String? toLocation;
  @override
  final String performedBy;
  @override
  final String? notes;
  @override
  final DateTime createdAt;
  @override
  final DateTime? syncedAt;
// Additional tracking fields
  @override
  final String? batchId;
  @override
  final String? serialNumber;
  @override
  @JsonKey()
  final String status;
  @override
  final String? approvedBy;
  @override
  final DateTime? approvedAt;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  final double? stockBefore;
  @override
  final double? stockAfter;
  @override
  final String? supplierId;
  @override
  final String? customerId;

  @override
  String toString() {
    return 'InventoryMovement(id: $id, organizationId: $organizationId, productId: $productId, type: $type, quantity: $quantity, unitCost: $unitCost, totalCost: $totalCost, reason: $reason, referenceNumber: $referenceNumber, referenceId: $referenceId, referenceType: $referenceType, fromBranchId: $fromBranchId, toBranchId: $toBranchId, fromLocation: $fromLocation, toLocation: $toLocation, performedBy: $performedBy, notes: $notes, createdAt: $createdAt, syncedAt: $syncedAt, batchId: $batchId, serialNumber: $serialNumber, status: $status, approvedBy: $approvedBy, approvedAt: $approvedAt, metadata: $metadata, stockBefore: $stockBefore, stockAfter: $stockAfter, supplierId: $supplierId, customerId: $customerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InventoryMovementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitCost, unitCost) ||
                other.unitCost == unitCost) &&
            (identical(other.totalCost, totalCost) ||
                other.totalCost == totalCost) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.referenceNumber, referenceNumber) ||
                other.referenceNumber == referenceNumber) &&
            (identical(other.referenceId, referenceId) ||
                other.referenceId == referenceId) &&
            (identical(other.referenceType, referenceType) ||
                other.referenceType == referenceType) &&
            (identical(other.fromBranchId, fromBranchId) ||
                other.fromBranchId == fromBranchId) &&
            (identical(other.toBranchId, toBranchId) ||
                other.toBranchId == toBranchId) &&
            (identical(other.fromLocation, fromLocation) ||
                other.fromLocation == fromLocation) &&
            (identical(other.toLocation, toLocation) ||
                other.toLocation == toLocation) &&
            (identical(other.performedBy, performedBy) ||
                other.performedBy == performedBy) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.batchId, batchId) || other.batchId == batchId) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.stockBefore, stockBefore) ||
                other.stockBefore == stockBefore) &&
            (identical(other.stockAfter, stockAfter) ||
                other.stockAfter == stockAfter) &&
            (identical(other.supplierId, supplierId) ||
                other.supplierId == supplierId) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        organizationId,
        productId,
        type,
        quantity,
        unitCost,
        totalCost,
        reason,
        referenceNumber,
        referenceId,
        referenceType,
        fromBranchId,
        toBranchId,
        fromLocation,
        toLocation,
        performedBy,
        notes,
        createdAt,
        syncedAt,
        batchId,
        serialNumber,
        status,
        approvedBy,
        approvedAt,
        const DeepCollectionEquality().hash(_metadata),
        stockBefore,
        stockAfter,
        supplierId,
        customerId
      ]);

  /// Create a copy of InventoryMovement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InventoryMovementImplCopyWith<_$InventoryMovementImpl> get copyWith =>
      __$$InventoryMovementImplCopyWithImpl<_$InventoryMovementImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InventoryMovementImplToJson(
      this,
    );
  }
}

abstract class _InventoryMovement extends InventoryMovement {
  const factory _InventoryMovement(
      {required final String id,
      required final String organizationId,
      required final String productId,
      required final MovementType type,
      required final double quantity,
      final double? unitCost,
      final double? totalCost,
      final String? reason,
      final String? referenceNumber,
      final String? referenceId,
      final String? referenceType,
      final String? fromBranchId,
      final String? toBranchId,
      final String? fromLocation,
      final String? toLocation,
      required final String performedBy,
      final String? notes,
      required final DateTime createdAt,
      final DateTime? syncedAt,
      final String? batchId,
      final String? serialNumber,
      final String status,
      final String? approvedBy,
      final DateTime? approvedAt,
      final Map<String, dynamic> metadata,
      final double? stockBefore,
      final double? stockAfter,
      final String? supplierId,
      final String? customerId}) = _$InventoryMovementImpl;
  const _InventoryMovement._() : super._();

  factory _InventoryMovement.fromJson(Map<String, dynamic> json) =
      _$InventoryMovementImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String get productId;
  @override
  MovementType get type;
  @override
  double get quantity;
  @override
  double? get unitCost;
  @override
  double? get totalCost;
  @override
  String? get reason;
  @override
  String? get referenceNumber;
  @override
  String? get referenceId;
  @override
  String? get referenceType;
  @override
  String? get fromBranchId;
  @override
  String? get toBranchId;
  @override
  String? get fromLocation;
  @override
  String? get toLocation;
  @override
  String get performedBy;
  @override
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  DateTime? get syncedAt; // Additional tracking fields
  @override
  String? get batchId;
  @override
  String? get serialNumber;
  @override
  String get status;
  @override
  String? get approvedBy;
  @override
  DateTime? get approvedAt;
  @override
  Map<String, dynamic> get metadata;
  @override
  double? get stockBefore;
  @override
  double? get stockAfter;
  @override
  String? get supplierId;
  @override
  String? get customerId;

  /// Create a copy of InventoryMovement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InventoryMovementImplCopyWith<_$InventoryMovementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
