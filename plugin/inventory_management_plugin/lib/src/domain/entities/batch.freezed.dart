// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'batch.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Batch _$BatchFromJson(Map<String, dynamic> json) {
  return _Batch.fromJson(json);
}

/// @nodoc
mixin _$Batch {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  String get batchNumber => throw _privateConstructorUsedError;
  DateTime? get manufacturingDate => throw _privateConstructorUsedError;
  DateTime? get expiryDate => throw _privateConstructorUsedError;
  String? get supplierId => throw _privateConstructorUsedError;
  double? get costPrice => throw _privateConstructorUsedError;
  double get currentQuantity => throw _privateConstructorUsedError;
  double get initialQuantity => throw _privateConstructorUsedError;
  String? get branchId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional fields for enhanced tracking
  String? get purchaseOrderId => throw _privateConstructorUsedError;
  String? get warehouseLocation => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  double? get sellingPrice => throw _privateConstructorUsedError;
  String? get qualityStatus =>
      throw _privateConstructorUsedError; // passed, rejected, pending
  Map<String, dynamic>? get testResults => throw _privateConstructorUsedError;

  /// Serializes this Batch to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Batch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BatchCopyWith<Batch> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BatchCopyWith<$Res> {
  factory $BatchCopyWith(Batch value, $Res Function(Batch) then) =
      _$BatchCopyWithImpl<$Res, Batch>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String productId,
      String batchNumber,
      DateTime? manufacturingDate,
      DateTime? expiryDate,
      String? supplierId,
      double? costPrice,
      double currentQuantity,
      double initialQuantity,
      String? branchId,
      String status,
      String? notes,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? purchaseOrderId,
      String? warehouseLocation,
      Map<String, dynamic> metadata,
      List<String> tags,
      double? sellingPrice,
      String? qualityStatus,
      Map<String, dynamic>? testResults});
}

/// @nodoc
class _$BatchCopyWithImpl<$Res, $Val extends Batch>
    implements $BatchCopyWith<$Res> {
  _$BatchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Batch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? productId = null,
    Object? batchNumber = null,
    Object? manufacturingDate = freezed,
    Object? expiryDate = freezed,
    Object? supplierId = freezed,
    Object? costPrice = freezed,
    Object? currentQuantity = null,
    Object? initialQuantity = null,
    Object? branchId = freezed,
    Object? status = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? purchaseOrderId = freezed,
    Object? warehouseLocation = freezed,
    Object? metadata = null,
    Object? tags = null,
    Object? sellingPrice = freezed,
    Object? qualityStatus = freezed,
    Object? testResults = freezed,
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
      batchNumber: null == batchNumber
          ? _value.batchNumber
          : batchNumber // ignore: cast_nullable_to_non_nullable
              as String,
      manufacturingDate: freezed == manufacturingDate
          ? _value.manufacturingDate
          : manufacturingDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      supplierId: freezed == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as String?,
      costPrice: freezed == costPrice
          ? _value.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      currentQuantity: null == currentQuantity
          ? _value.currentQuantity
          : currentQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      initialQuantity: null == initialQuantity
          ? _value.initialQuantity
          : initialQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      branchId: freezed == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
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
      purchaseOrderId: freezed == purchaseOrderId
          ? _value.purchaseOrderId
          : purchaseOrderId // ignore: cast_nullable_to_non_nullable
              as String?,
      warehouseLocation: freezed == warehouseLocation
          ? _value.warehouseLocation
          : warehouseLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sellingPrice: freezed == sellingPrice
          ? _value.sellingPrice
          : sellingPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      qualityStatus: freezed == qualityStatus
          ? _value.qualityStatus
          : qualityStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      testResults: freezed == testResults
          ? _value.testResults
          : testResults // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BatchImplCopyWith<$Res> implements $BatchCopyWith<$Res> {
  factory _$$BatchImplCopyWith(
          _$BatchImpl value, $Res Function(_$BatchImpl) then) =
      __$$BatchImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String productId,
      String batchNumber,
      DateTime? manufacturingDate,
      DateTime? expiryDate,
      String? supplierId,
      double? costPrice,
      double currentQuantity,
      double initialQuantity,
      String? branchId,
      String status,
      String? notes,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? purchaseOrderId,
      String? warehouseLocation,
      Map<String, dynamic> metadata,
      List<String> tags,
      double? sellingPrice,
      String? qualityStatus,
      Map<String, dynamic>? testResults});
}

/// @nodoc
class __$$BatchImplCopyWithImpl<$Res>
    extends _$BatchCopyWithImpl<$Res, _$BatchImpl>
    implements _$$BatchImplCopyWith<$Res> {
  __$$BatchImplCopyWithImpl(
      _$BatchImpl _value, $Res Function(_$BatchImpl) _then)
      : super(_value, _then);

  /// Create a copy of Batch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? productId = null,
    Object? batchNumber = null,
    Object? manufacturingDate = freezed,
    Object? expiryDate = freezed,
    Object? supplierId = freezed,
    Object? costPrice = freezed,
    Object? currentQuantity = null,
    Object? initialQuantity = null,
    Object? branchId = freezed,
    Object? status = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? purchaseOrderId = freezed,
    Object? warehouseLocation = freezed,
    Object? metadata = null,
    Object? tags = null,
    Object? sellingPrice = freezed,
    Object? qualityStatus = freezed,
    Object? testResults = freezed,
  }) {
    return _then(_$BatchImpl(
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
      batchNumber: null == batchNumber
          ? _value.batchNumber
          : batchNumber // ignore: cast_nullable_to_non_nullable
              as String,
      manufacturingDate: freezed == manufacturingDate
          ? _value.manufacturingDate
          : manufacturingDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      supplierId: freezed == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as String?,
      costPrice: freezed == costPrice
          ? _value.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      currentQuantity: null == currentQuantity
          ? _value.currentQuantity
          : currentQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      initialQuantity: null == initialQuantity
          ? _value.initialQuantity
          : initialQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      branchId: freezed == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
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
      purchaseOrderId: freezed == purchaseOrderId
          ? _value.purchaseOrderId
          : purchaseOrderId // ignore: cast_nullable_to_non_nullable
              as String?,
      warehouseLocation: freezed == warehouseLocation
          ? _value.warehouseLocation
          : warehouseLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sellingPrice: freezed == sellingPrice
          ? _value.sellingPrice
          : sellingPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      qualityStatus: freezed == qualityStatus
          ? _value.qualityStatus
          : qualityStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      testResults: freezed == testResults
          ? _value._testResults
          : testResults // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BatchImpl extends _Batch {
  const _$BatchImpl(
      {required this.id,
      required this.organizationId,
      required this.productId,
      required this.batchNumber,
      this.manufacturingDate,
      this.expiryDate,
      this.supplierId,
      this.costPrice,
      this.currentQuantity = 0,
      this.initialQuantity = 0,
      this.branchId,
      this.status = 'active',
      this.notes,
      required this.createdAt,
      required this.updatedAt,
      this.syncedAt,
      this.purchaseOrderId,
      this.warehouseLocation,
      final Map<String, dynamic> metadata = const {},
      final List<String> tags = const [],
      this.sellingPrice,
      this.qualityStatus,
      final Map<String, dynamic>? testResults})
      : _metadata = metadata,
        _tags = tags,
        _testResults = testResults,
        super._();

  factory _$BatchImpl.fromJson(Map<String, dynamic> json) =>
      _$$BatchImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String productId;
  @override
  final String batchNumber;
  @override
  final DateTime? manufacturingDate;
  @override
  final DateTime? expiryDate;
  @override
  final String? supplierId;
  @override
  final double? costPrice;
  @override
  @JsonKey()
  final double currentQuantity;
  @override
  @JsonKey()
  final double initialQuantity;
  @override
  final String? branchId;
  @override
  @JsonKey()
  final String status;
  @override
  final String? notes;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? syncedAt;
// Additional fields for enhanced tracking
  @override
  final String? purchaseOrderId;
  @override
  final String? warehouseLocation;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final double? sellingPrice;
  @override
  final String? qualityStatus;
// passed, rejected, pending
  final Map<String, dynamic>? _testResults;
// passed, rejected, pending
  @override
  Map<String, dynamic>? get testResults {
    final value = _testResults;
    if (value == null) return null;
    if (_testResults is EqualUnmodifiableMapView) return _testResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Batch(id: $id, organizationId: $organizationId, productId: $productId, batchNumber: $batchNumber, manufacturingDate: $manufacturingDate, expiryDate: $expiryDate, supplierId: $supplierId, costPrice: $costPrice, currentQuantity: $currentQuantity, initialQuantity: $initialQuantity, branchId: $branchId, status: $status, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt, purchaseOrderId: $purchaseOrderId, warehouseLocation: $warehouseLocation, metadata: $metadata, tags: $tags, sellingPrice: $sellingPrice, qualityStatus: $qualityStatus, testResults: $testResults)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BatchImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.batchNumber, batchNumber) ||
                other.batchNumber == batchNumber) &&
            (identical(other.manufacturingDate, manufacturingDate) ||
                other.manufacturingDate == manufacturingDate) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            (identical(other.supplierId, supplierId) ||
                other.supplierId == supplierId) &&
            (identical(other.costPrice, costPrice) ||
                other.costPrice == costPrice) &&
            (identical(other.currentQuantity, currentQuantity) ||
                other.currentQuantity == currentQuantity) &&
            (identical(other.initialQuantity, initialQuantity) ||
                other.initialQuantity == initialQuantity) &&
            (identical(other.branchId, branchId) ||
                other.branchId == branchId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.purchaseOrderId, purchaseOrderId) ||
                other.purchaseOrderId == purchaseOrderId) &&
            (identical(other.warehouseLocation, warehouseLocation) ||
                other.warehouseLocation == warehouseLocation) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.sellingPrice, sellingPrice) ||
                other.sellingPrice == sellingPrice) &&
            (identical(other.qualityStatus, qualityStatus) ||
                other.qualityStatus == qualityStatus) &&
            const DeepCollectionEquality()
                .equals(other._testResults, _testResults));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        organizationId,
        productId,
        batchNumber,
        manufacturingDate,
        expiryDate,
        supplierId,
        costPrice,
        currentQuantity,
        initialQuantity,
        branchId,
        status,
        notes,
        createdAt,
        updatedAt,
        syncedAt,
        purchaseOrderId,
        warehouseLocation,
        const DeepCollectionEquality().hash(_metadata),
        const DeepCollectionEquality().hash(_tags),
        sellingPrice,
        qualityStatus,
        const DeepCollectionEquality().hash(_testResults)
      ]);

  /// Create a copy of Batch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BatchImplCopyWith<_$BatchImpl> get copyWith =>
      __$$BatchImplCopyWithImpl<_$BatchImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BatchImplToJson(
      this,
    );
  }
}

abstract class _Batch extends Batch {
  const factory _Batch(
      {required final String id,
      required final String organizationId,
      required final String productId,
      required final String batchNumber,
      final DateTime? manufacturingDate,
      final DateTime? expiryDate,
      final String? supplierId,
      final double? costPrice,
      final double currentQuantity,
      final double initialQuantity,
      final String? branchId,
      final String status,
      final String? notes,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final DateTime? syncedAt,
      final String? purchaseOrderId,
      final String? warehouseLocation,
      final Map<String, dynamic> metadata,
      final List<String> tags,
      final double? sellingPrice,
      final String? qualityStatus,
      final Map<String, dynamic>? testResults}) = _$BatchImpl;
  const _Batch._() : super._();

  factory _Batch.fromJson(Map<String, dynamic> json) = _$BatchImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String get productId;
  @override
  String get batchNumber;
  @override
  DateTime? get manufacturingDate;
  @override
  DateTime? get expiryDate;
  @override
  String? get supplierId;
  @override
  double? get costPrice;
  @override
  double get currentQuantity;
  @override
  double get initialQuantity;
  @override
  String? get branchId;
  @override
  String get status;
  @override
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get syncedAt; // Additional fields for enhanced tracking
  @override
  String? get purchaseOrderId;
  @override
  String? get warehouseLocation;
  @override
  Map<String, dynamic> get metadata;
  @override
  List<String> get tags;
  @override
  double? get sellingPrice;
  @override
  String? get qualityStatus; // passed, rejected, pending
  @override
  Map<String, dynamic>? get testResults;

  /// Create a copy of Batch
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BatchImplCopyWith<_$BatchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
