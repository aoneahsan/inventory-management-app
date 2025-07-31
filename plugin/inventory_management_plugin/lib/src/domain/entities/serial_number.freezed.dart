// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'serial_number.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SerialNumber _$SerialNumberFromJson(Map<String, dynamic> json) {
  return _SerialNumber.fromJson(json);
}

/// @nodoc
mixin _$SerialNumber {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  String get serialNumber => throw _privateConstructorUsedError;
  String? get batchId => throw _privateConstructorUsedError;
  SerialStatus get status => throw _privateConstructorUsedError;
  String? get branchId => throw _privateConstructorUsedError;
  DateTime? get purchaseDate => throw _privateConstructorUsedError;
  double? get purchasePrice => throw _privateConstructorUsedError;
  String? get purchaseOrderId => throw _privateConstructorUsedError;
  String? get supplierId => throw _privateConstructorUsedError;
  String? get saleId => throw _privateConstructorUsedError;
  String? get customerId => throw _privateConstructorUsedError;
  DateTime? get saleDate => throw _privateConstructorUsedError;
  double? get salePrice => throw _privateConstructorUsedError;
  DateTime? get warrantyEndDate => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional tracking fields
  String? get currentLocation => throw _privateConstructorUsedError;
  List<SerialMovement> get movements => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  String? get lastScannedBy => throw _privateConstructorUsedError;
  DateTime? get lastScannedAt => throw _privateConstructorUsedError;
  Map<String, dynamic> get customFields => throw _privateConstructorUsedError;
  String? get returnReason => throw _privateConstructorUsedError;
  DateTime? get returnDate => throw _privateConstructorUsedError;
  String? get repairNotes => throw _privateConstructorUsedError;
  double? get repairCost => throw _privateConstructorUsedError;

  /// Serializes this SerialNumber to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SerialNumber
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SerialNumberCopyWith<SerialNumber> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SerialNumberCopyWith<$Res> {
  factory $SerialNumberCopyWith(
          SerialNumber value, $Res Function(SerialNumber) then) =
      _$SerialNumberCopyWithImpl<$Res, SerialNumber>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String productId,
      String serialNumber,
      String? batchId,
      SerialStatus status,
      String? branchId,
      DateTime? purchaseDate,
      double? purchasePrice,
      String? purchaseOrderId,
      String? supplierId,
      String? saleId,
      String? customerId,
      DateTime? saleDate,
      double? salePrice,
      DateTime? warrantyEndDate,
      String? notes,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? currentLocation,
      List<SerialMovement> movements,
      Map<String, dynamic> metadata,
      String? lastScannedBy,
      DateTime? lastScannedAt,
      Map<String, dynamic> customFields,
      String? returnReason,
      DateTime? returnDate,
      String? repairNotes,
      double? repairCost});
}

/// @nodoc
class _$SerialNumberCopyWithImpl<$Res, $Val extends SerialNumber>
    implements $SerialNumberCopyWith<$Res> {
  _$SerialNumberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SerialNumber
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? productId = null,
    Object? serialNumber = null,
    Object? batchId = freezed,
    Object? status = null,
    Object? branchId = freezed,
    Object? purchaseDate = freezed,
    Object? purchasePrice = freezed,
    Object? purchaseOrderId = freezed,
    Object? supplierId = freezed,
    Object? saleId = freezed,
    Object? customerId = freezed,
    Object? saleDate = freezed,
    Object? salePrice = freezed,
    Object? warrantyEndDate = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? currentLocation = freezed,
    Object? movements = null,
    Object? metadata = null,
    Object? lastScannedBy = freezed,
    Object? lastScannedAt = freezed,
    Object? customFields = null,
    Object? returnReason = freezed,
    Object? returnDate = freezed,
    Object? repairNotes = freezed,
    Object? repairCost = freezed,
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
      serialNumber: null == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String,
      batchId: freezed == batchId
          ? _value.batchId
          : batchId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SerialStatus,
      branchId: freezed == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as String?,
      purchaseDate: freezed == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      purchasePrice: freezed == purchasePrice
          ? _value.purchasePrice
          : purchasePrice // ignore: cast_nullable_to_non_nullable
              as double?,
      purchaseOrderId: freezed == purchaseOrderId
          ? _value.purchaseOrderId
          : purchaseOrderId // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierId: freezed == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as String?,
      saleId: freezed == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String?,
      saleDate: freezed == saleDate
          ? _value.saleDate
          : saleDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      salePrice: freezed == salePrice
          ? _value.salePrice
          : salePrice // ignore: cast_nullable_to_non_nullable
              as double?,
      warrantyEndDate: freezed == warrantyEndDate
          ? _value.warrantyEndDate
          : warrantyEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
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
      currentLocation: freezed == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      movements: null == movements
          ? _value.movements
          : movements // ignore: cast_nullable_to_non_nullable
              as List<SerialMovement>,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      lastScannedBy: freezed == lastScannedBy
          ? _value.lastScannedBy
          : lastScannedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      lastScannedAt: freezed == lastScannedAt
          ? _value.lastScannedAt
          : lastScannedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      customFields: null == customFields
          ? _value.customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      returnReason: freezed == returnReason
          ? _value.returnReason
          : returnReason // ignore: cast_nullable_to_non_nullable
              as String?,
      returnDate: freezed == returnDate
          ? _value.returnDate
          : returnDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      repairNotes: freezed == repairNotes
          ? _value.repairNotes
          : repairNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      repairCost: freezed == repairCost
          ? _value.repairCost
          : repairCost // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SerialNumberImplCopyWith<$Res>
    implements $SerialNumberCopyWith<$Res> {
  factory _$$SerialNumberImplCopyWith(
          _$SerialNumberImpl value, $Res Function(_$SerialNumberImpl) then) =
      __$$SerialNumberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String productId,
      String serialNumber,
      String? batchId,
      SerialStatus status,
      String? branchId,
      DateTime? purchaseDate,
      double? purchasePrice,
      String? purchaseOrderId,
      String? supplierId,
      String? saleId,
      String? customerId,
      DateTime? saleDate,
      double? salePrice,
      DateTime? warrantyEndDate,
      String? notes,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? currentLocation,
      List<SerialMovement> movements,
      Map<String, dynamic> metadata,
      String? lastScannedBy,
      DateTime? lastScannedAt,
      Map<String, dynamic> customFields,
      String? returnReason,
      DateTime? returnDate,
      String? repairNotes,
      double? repairCost});
}

/// @nodoc
class __$$SerialNumberImplCopyWithImpl<$Res>
    extends _$SerialNumberCopyWithImpl<$Res, _$SerialNumberImpl>
    implements _$$SerialNumberImplCopyWith<$Res> {
  __$$SerialNumberImplCopyWithImpl(
      _$SerialNumberImpl _value, $Res Function(_$SerialNumberImpl) _then)
      : super(_value, _then);

  /// Create a copy of SerialNumber
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? productId = null,
    Object? serialNumber = null,
    Object? batchId = freezed,
    Object? status = null,
    Object? branchId = freezed,
    Object? purchaseDate = freezed,
    Object? purchasePrice = freezed,
    Object? purchaseOrderId = freezed,
    Object? supplierId = freezed,
    Object? saleId = freezed,
    Object? customerId = freezed,
    Object? saleDate = freezed,
    Object? salePrice = freezed,
    Object? warrantyEndDate = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? currentLocation = freezed,
    Object? movements = null,
    Object? metadata = null,
    Object? lastScannedBy = freezed,
    Object? lastScannedAt = freezed,
    Object? customFields = null,
    Object? returnReason = freezed,
    Object? returnDate = freezed,
    Object? repairNotes = freezed,
    Object? repairCost = freezed,
  }) {
    return _then(_$SerialNumberImpl(
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
      serialNumber: null == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String,
      batchId: freezed == batchId
          ? _value.batchId
          : batchId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SerialStatus,
      branchId: freezed == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as String?,
      purchaseDate: freezed == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      purchasePrice: freezed == purchasePrice
          ? _value.purchasePrice
          : purchasePrice // ignore: cast_nullable_to_non_nullable
              as double?,
      purchaseOrderId: freezed == purchaseOrderId
          ? _value.purchaseOrderId
          : purchaseOrderId // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierId: freezed == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as String?,
      saleId: freezed == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String?,
      saleDate: freezed == saleDate
          ? _value.saleDate
          : saleDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      salePrice: freezed == salePrice
          ? _value.salePrice
          : salePrice // ignore: cast_nullable_to_non_nullable
              as double?,
      warrantyEndDate: freezed == warrantyEndDate
          ? _value.warrantyEndDate
          : warrantyEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
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
      currentLocation: freezed == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      movements: null == movements
          ? _value._movements
          : movements // ignore: cast_nullable_to_non_nullable
              as List<SerialMovement>,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      lastScannedBy: freezed == lastScannedBy
          ? _value.lastScannedBy
          : lastScannedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      lastScannedAt: freezed == lastScannedAt
          ? _value.lastScannedAt
          : lastScannedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      customFields: null == customFields
          ? _value._customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      returnReason: freezed == returnReason
          ? _value.returnReason
          : returnReason // ignore: cast_nullable_to_non_nullable
              as String?,
      returnDate: freezed == returnDate
          ? _value.returnDate
          : returnDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      repairNotes: freezed == repairNotes
          ? _value.repairNotes
          : repairNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      repairCost: freezed == repairCost
          ? _value.repairCost
          : repairCost // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SerialNumberImpl extends _SerialNumber {
  const _$SerialNumberImpl(
      {required this.id,
      required this.organizationId,
      required this.productId,
      required this.serialNumber,
      this.batchId,
      required this.status,
      this.branchId,
      this.purchaseDate,
      this.purchasePrice,
      this.purchaseOrderId,
      this.supplierId,
      this.saleId,
      this.customerId,
      this.saleDate,
      this.salePrice,
      this.warrantyEndDate,
      this.notes,
      required this.createdAt,
      required this.updatedAt,
      this.syncedAt,
      this.currentLocation,
      final List<SerialMovement> movements = const [],
      final Map<String, dynamic> metadata = const {},
      this.lastScannedBy,
      this.lastScannedAt,
      final Map<String, dynamic> customFields = const {},
      this.returnReason,
      this.returnDate,
      this.repairNotes,
      this.repairCost})
      : _movements = movements,
        _metadata = metadata,
        _customFields = customFields,
        super._();

  factory _$SerialNumberImpl.fromJson(Map<String, dynamic> json) =>
      _$$SerialNumberImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String productId;
  @override
  final String serialNumber;
  @override
  final String? batchId;
  @override
  final SerialStatus status;
  @override
  final String? branchId;
  @override
  final DateTime? purchaseDate;
  @override
  final double? purchasePrice;
  @override
  final String? purchaseOrderId;
  @override
  final String? supplierId;
  @override
  final String? saleId;
  @override
  final String? customerId;
  @override
  final DateTime? saleDate;
  @override
  final double? salePrice;
  @override
  final DateTime? warrantyEndDate;
  @override
  final String? notes;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? syncedAt;
// Additional tracking fields
  @override
  final String? currentLocation;
  final List<SerialMovement> _movements;
  @override
  @JsonKey()
  List<SerialMovement> get movements {
    if (_movements is EqualUnmodifiableListView) return _movements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_movements);
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
  final String? lastScannedBy;
  @override
  final DateTime? lastScannedAt;
  final Map<String, dynamic> _customFields;
  @override
  @JsonKey()
  Map<String, dynamic> get customFields {
    if (_customFields is EqualUnmodifiableMapView) return _customFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_customFields);
  }

  @override
  final String? returnReason;
  @override
  final DateTime? returnDate;
  @override
  final String? repairNotes;
  @override
  final double? repairCost;

  @override
  String toString() {
    return 'SerialNumber(id: $id, organizationId: $organizationId, productId: $productId, serialNumber: $serialNumber, batchId: $batchId, status: $status, branchId: $branchId, purchaseDate: $purchaseDate, purchasePrice: $purchasePrice, purchaseOrderId: $purchaseOrderId, supplierId: $supplierId, saleId: $saleId, customerId: $customerId, saleDate: $saleDate, salePrice: $salePrice, warrantyEndDate: $warrantyEndDate, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt, currentLocation: $currentLocation, movements: $movements, metadata: $metadata, lastScannedBy: $lastScannedBy, lastScannedAt: $lastScannedAt, customFields: $customFields, returnReason: $returnReason, returnDate: $returnDate, repairNotes: $repairNotes, repairCost: $repairCost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SerialNumberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.batchId, batchId) || other.batchId == batchId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.branchId, branchId) ||
                other.branchId == branchId) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate) &&
            (identical(other.purchasePrice, purchasePrice) ||
                other.purchasePrice == purchasePrice) &&
            (identical(other.purchaseOrderId, purchaseOrderId) ||
                other.purchaseOrderId == purchaseOrderId) &&
            (identical(other.supplierId, supplierId) ||
                other.supplierId == supplierId) &&
            (identical(other.saleId, saleId) || other.saleId == saleId) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.saleDate, saleDate) ||
                other.saleDate == saleDate) &&
            (identical(other.salePrice, salePrice) ||
                other.salePrice == salePrice) &&
            (identical(other.warrantyEndDate, warrantyEndDate) ||
                other.warrantyEndDate == warrantyEndDate) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.currentLocation, currentLocation) ||
                other.currentLocation == currentLocation) &&
            const DeepCollectionEquality()
                .equals(other._movements, _movements) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.lastScannedBy, lastScannedBy) ||
                other.lastScannedBy == lastScannedBy) &&
            (identical(other.lastScannedAt, lastScannedAt) ||
                other.lastScannedAt == lastScannedAt) &&
            const DeepCollectionEquality()
                .equals(other._customFields, _customFields) &&
            (identical(other.returnReason, returnReason) ||
                other.returnReason == returnReason) &&
            (identical(other.returnDate, returnDate) ||
                other.returnDate == returnDate) &&
            (identical(other.repairNotes, repairNotes) ||
                other.repairNotes == repairNotes) &&
            (identical(other.repairCost, repairCost) ||
                other.repairCost == repairCost));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        organizationId,
        productId,
        serialNumber,
        batchId,
        status,
        branchId,
        purchaseDate,
        purchasePrice,
        purchaseOrderId,
        supplierId,
        saleId,
        customerId,
        saleDate,
        salePrice,
        warrantyEndDate,
        notes,
        createdAt,
        updatedAt,
        syncedAt,
        currentLocation,
        const DeepCollectionEquality().hash(_movements),
        const DeepCollectionEquality().hash(_metadata),
        lastScannedBy,
        lastScannedAt,
        const DeepCollectionEquality().hash(_customFields),
        returnReason,
        returnDate,
        repairNotes,
        repairCost
      ]);

  /// Create a copy of SerialNumber
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SerialNumberImplCopyWith<_$SerialNumberImpl> get copyWith =>
      __$$SerialNumberImplCopyWithImpl<_$SerialNumberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SerialNumberImplToJson(
      this,
    );
  }
}

abstract class _SerialNumber extends SerialNumber {
  const factory _SerialNumber(
      {required final String id,
      required final String organizationId,
      required final String productId,
      required final String serialNumber,
      final String? batchId,
      required final SerialStatus status,
      final String? branchId,
      final DateTime? purchaseDate,
      final double? purchasePrice,
      final String? purchaseOrderId,
      final String? supplierId,
      final String? saleId,
      final String? customerId,
      final DateTime? saleDate,
      final double? salePrice,
      final DateTime? warrantyEndDate,
      final String? notes,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final DateTime? syncedAt,
      final String? currentLocation,
      final List<SerialMovement> movements,
      final Map<String, dynamic> metadata,
      final String? lastScannedBy,
      final DateTime? lastScannedAt,
      final Map<String, dynamic> customFields,
      final String? returnReason,
      final DateTime? returnDate,
      final String? repairNotes,
      final double? repairCost}) = _$SerialNumberImpl;
  const _SerialNumber._() : super._();

  factory _SerialNumber.fromJson(Map<String, dynamic> json) =
      _$SerialNumberImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String get productId;
  @override
  String get serialNumber;
  @override
  String? get batchId;
  @override
  SerialStatus get status;
  @override
  String? get branchId;
  @override
  DateTime? get purchaseDate;
  @override
  double? get purchasePrice;
  @override
  String? get purchaseOrderId;
  @override
  String? get supplierId;
  @override
  String? get saleId;
  @override
  String? get customerId;
  @override
  DateTime? get saleDate;
  @override
  double? get salePrice;
  @override
  DateTime? get warrantyEndDate;
  @override
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get syncedAt; // Additional tracking fields
  @override
  String? get currentLocation;
  @override
  List<SerialMovement> get movements;
  @override
  Map<String, dynamic> get metadata;
  @override
  String? get lastScannedBy;
  @override
  DateTime? get lastScannedAt;
  @override
  Map<String, dynamic> get customFields;
  @override
  String? get returnReason;
  @override
  DateTime? get returnDate;
  @override
  String? get repairNotes;
  @override
  double? get repairCost;

  /// Create a copy of SerialNumber
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SerialNumberImplCopyWith<_$SerialNumberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SerialMovement _$SerialMovementFromJson(Map<String, dynamic> json) {
  return _SerialMovement.fromJson(json);
}

/// @nodoc
mixin _$SerialMovement {
  String get id => throw _privateConstructorUsedError;
  String get serialNumberId => throw _privateConstructorUsedError;
  String get movementType => throw _privateConstructorUsedError;
  String? get fromLocation => throw _privateConstructorUsedError;
  String? get toLocation => throw _privateConstructorUsedError;
  String? get fromBranchId => throw _privateConstructorUsedError;
  String? get toBranchId => throw _privateConstructorUsedError;
  String get performedBy => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this SerialMovement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SerialMovement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SerialMovementCopyWith<SerialMovement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SerialMovementCopyWith<$Res> {
  factory $SerialMovementCopyWith(
          SerialMovement value, $Res Function(SerialMovement) then) =
      _$SerialMovementCopyWithImpl<$Res, SerialMovement>;
  @useResult
  $Res call(
      {String id,
      String serialNumberId,
      String movementType,
      String? fromLocation,
      String? toLocation,
      String? fromBranchId,
      String? toBranchId,
      String performedBy,
      String? notes,
      DateTime timestamp,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$SerialMovementCopyWithImpl<$Res, $Val extends SerialMovement>
    implements $SerialMovementCopyWith<$Res> {
  _$SerialMovementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SerialMovement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? serialNumberId = null,
    Object? movementType = null,
    Object? fromLocation = freezed,
    Object? toLocation = freezed,
    Object? fromBranchId = freezed,
    Object? toBranchId = freezed,
    Object? performedBy = null,
    Object? notes = freezed,
    Object? timestamp = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      serialNumberId: null == serialNumberId
          ? _value.serialNumberId
          : serialNumberId // ignore: cast_nullable_to_non_nullable
              as String,
      movementType: null == movementType
          ? _value.movementType
          : movementType // ignore: cast_nullable_to_non_nullable
              as String,
      fromLocation: freezed == fromLocation
          ? _value.fromLocation
          : fromLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      toLocation: freezed == toLocation
          ? _value.toLocation
          : toLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      fromBranchId: freezed == fromBranchId
          ? _value.fromBranchId
          : fromBranchId // ignore: cast_nullable_to_non_nullable
              as String?,
      toBranchId: freezed == toBranchId
          ? _value.toBranchId
          : toBranchId // ignore: cast_nullable_to_non_nullable
              as String?,
      performedBy: null == performedBy
          ? _value.performedBy
          : performedBy // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SerialMovementImplCopyWith<$Res>
    implements $SerialMovementCopyWith<$Res> {
  factory _$$SerialMovementImplCopyWith(_$SerialMovementImpl value,
          $Res Function(_$SerialMovementImpl) then) =
      __$$SerialMovementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String serialNumberId,
      String movementType,
      String? fromLocation,
      String? toLocation,
      String? fromBranchId,
      String? toBranchId,
      String performedBy,
      String? notes,
      DateTime timestamp,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$$SerialMovementImplCopyWithImpl<$Res>
    extends _$SerialMovementCopyWithImpl<$Res, _$SerialMovementImpl>
    implements _$$SerialMovementImplCopyWith<$Res> {
  __$$SerialMovementImplCopyWithImpl(
      _$SerialMovementImpl _value, $Res Function(_$SerialMovementImpl) _then)
      : super(_value, _then);

  /// Create a copy of SerialMovement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? serialNumberId = null,
    Object? movementType = null,
    Object? fromLocation = freezed,
    Object? toLocation = freezed,
    Object? fromBranchId = freezed,
    Object? toBranchId = freezed,
    Object? performedBy = null,
    Object? notes = freezed,
    Object? timestamp = null,
    Object? metadata = null,
  }) {
    return _then(_$SerialMovementImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      serialNumberId: null == serialNumberId
          ? _value.serialNumberId
          : serialNumberId // ignore: cast_nullable_to_non_nullable
              as String,
      movementType: null == movementType
          ? _value.movementType
          : movementType // ignore: cast_nullable_to_non_nullable
              as String,
      fromLocation: freezed == fromLocation
          ? _value.fromLocation
          : fromLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      toLocation: freezed == toLocation
          ? _value.toLocation
          : toLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      fromBranchId: freezed == fromBranchId
          ? _value.fromBranchId
          : fromBranchId // ignore: cast_nullable_to_non_nullable
              as String?,
      toBranchId: freezed == toBranchId
          ? _value.toBranchId
          : toBranchId // ignore: cast_nullable_to_non_nullable
              as String?,
      performedBy: null == performedBy
          ? _value.performedBy
          : performedBy // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SerialMovementImpl implements _SerialMovement {
  const _$SerialMovementImpl(
      {required this.id,
      required this.serialNumberId,
      required this.movementType,
      this.fromLocation,
      this.toLocation,
      this.fromBranchId,
      this.toBranchId,
      required this.performedBy,
      this.notes,
      required this.timestamp,
      final Map<String, dynamic> metadata = const {}})
      : _metadata = metadata;

  factory _$SerialMovementImpl.fromJson(Map<String, dynamic> json) =>
      _$$SerialMovementImplFromJson(json);

  @override
  final String id;
  @override
  final String serialNumberId;
  @override
  final String movementType;
  @override
  final String? fromLocation;
  @override
  final String? toLocation;
  @override
  final String? fromBranchId;
  @override
  final String? toBranchId;
  @override
  final String performedBy;
  @override
  final String? notes;
  @override
  final DateTime timestamp;
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
    return 'SerialMovement(id: $id, serialNumberId: $serialNumberId, movementType: $movementType, fromLocation: $fromLocation, toLocation: $toLocation, fromBranchId: $fromBranchId, toBranchId: $toBranchId, performedBy: $performedBy, notes: $notes, timestamp: $timestamp, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SerialMovementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.serialNumberId, serialNumberId) ||
                other.serialNumberId == serialNumberId) &&
            (identical(other.movementType, movementType) ||
                other.movementType == movementType) &&
            (identical(other.fromLocation, fromLocation) ||
                other.fromLocation == fromLocation) &&
            (identical(other.toLocation, toLocation) ||
                other.toLocation == toLocation) &&
            (identical(other.fromBranchId, fromBranchId) ||
                other.fromBranchId == fromBranchId) &&
            (identical(other.toBranchId, toBranchId) ||
                other.toBranchId == toBranchId) &&
            (identical(other.performedBy, performedBy) ||
                other.performedBy == performedBy) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      serialNumberId,
      movementType,
      fromLocation,
      toLocation,
      fromBranchId,
      toBranchId,
      performedBy,
      notes,
      timestamp,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of SerialMovement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SerialMovementImplCopyWith<_$SerialMovementImpl> get copyWith =>
      __$$SerialMovementImplCopyWithImpl<_$SerialMovementImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SerialMovementImplToJson(
      this,
    );
  }
}

abstract class _SerialMovement implements SerialMovement {
  const factory _SerialMovement(
      {required final String id,
      required final String serialNumberId,
      required final String movementType,
      final String? fromLocation,
      final String? toLocation,
      final String? fromBranchId,
      final String? toBranchId,
      required final String performedBy,
      final String? notes,
      required final DateTime timestamp,
      final Map<String, dynamic> metadata}) = _$SerialMovementImpl;

  factory _SerialMovement.fromJson(Map<String, dynamic> json) =
      _$SerialMovementImpl.fromJson;

  @override
  String get id;
  @override
  String get serialNumberId;
  @override
  String get movementType;
  @override
  String? get fromLocation;
  @override
  String? get toLocation;
  @override
  String? get fromBranchId;
  @override
  String? get toBranchId;
  @override
  String get performedBy;
  @override
  String? get notes;
  @override
  DateTime get timestamp;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of SerialMovement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SerialMovementImplCopyWith<_$SerialMovementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
