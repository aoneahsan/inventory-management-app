// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_transfer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StockTransfer _$StockTransferFromJson(Map<String, dynamic> json) {
  return _StockTransfer.fromJson(json);
}

/// @nodoc
mixin _$StockTransfer {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get transferNumber => throw _privateConstructorUsedError;
  String get fromBranchId => throw _privateConstructorUsedError;
  String get toBranchId => throw _privateConstructorUsedError;
  TransferStatus get status => throw _privateConstructorUsedError;
  DateTime get transferDate => throw _privateConstructorUsedError;
  DateTime? get expectedDate => throw _privateConstructorUsedError;
  DateTime? get completedDate => throw _privateConstructorUsedError;
  int get totalItems => throw _privateConstructorUsedError;
  double get totalQuantity => throw _privateConstructorUsedError;
  double get totalValue => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  String? get approvedBy => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  String? get receivedBy => throw _privateConstructorUsedError;
  DateTime? get receivedAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  List<StockTransferItem> get items => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional fields
  String? get transportMode => throw _privateConstructorUsedError;
  String? get transporterName => throw _privateConstructorUsedError;
  String? get trackingNumber => throw _privateConstructorUsedError;
  String? get vehicleNumber => throw _privateConstructorUsedError;
  String? get driverName => throw _privateConstructorUsedError;
  String? get driverContact => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  Map<String, dynamic> get customFields => throw _privateConstructorUsedError;
  String? get rejectionReason => throw _privateConstructorUsedError;
  DateTime? get rejectedAt => throw _privateConstructorUsedError;
  String? get rejectedBy => throw _privateConstructorUsedError;

  /// Serializes this StockTransfer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StockTransfer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StockTransferCopyWith<StockTransfer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockTransferCopyWith<$Res> {
  factory $StockTransferCopyWith(
          StockTransfer value, $Res Function(StockTransfer) then) =
      _$StockTransferCopyWithImpl<$Res, StockTransfer>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String transferNumber,
      String fromBranchId,
      String toBranchId,
      TransferStatus status,
      DateTime transferDate,
      DateTime? expectedDate,
      DateTime? completedDate,
      int totalItems,
      double totalQuantity,
      double totalValue,
      String? notes,
      String createdBy,
      String? approvedBy,
      DateTime? approvedAt,
      String? receivedBy,
      DateTime? receivedAt,
      DateTime createdAt,
      DateTime updatedAt,
      List<StockTransferItem> items,
      DateTime? syncedAt,
      String? transportMode,
      String? transporterName,
      String? trackingNumber,
      String? vehicleNumber,
      String? driverName,
      String? driverContact,
      Map<String, dynamic> metadata,
      Map<String, dynamic> customFields,
      String? rejectionReason,
      DateTime? rejectedAt,
      String? rejectedBy});
}

/// @nodoc
class _$StockTransferCopyWithImpl<$Res, $Val extends StockTransfer>
    implements $StockTransferCopyWith<$Res> {
  _$StockTransferCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StockTransfer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? transferNumber = null,
    Object? fromBranchId = null,
    Object? toBranchId = null,
    Object? status = null,
    Object? transferDate = null,
    Object? expectedDate = freezed,
    Object? completedDate = freezed,
    Object? totalItems = null,
    Object? totalQuantity = null,
    Object? totalValue = null,
    Object? notes = freezed,
    Object? createdBy = null,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
    Object? receivedBy = freezed,
    Object? receivedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? items = null,
    Object? syncedAt = freezed,
    Object? transportMode = freezed,
    Object? transporterName = freezed,
    Object? trackingNumber = freezed,
    Object? vehicleNumber = freezed,
    Object? driverName = freezed,
    Object? driverContact = freezed,
    Object? metadata = null,
    Object? customFields = null,
    Object? rejectionReason = freezed,
    Object? rejectedAt = freezed,
    Object? rejectedBy = freezed,
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
      transferNumber: null == transferNumber
          ? _value.transferNumber
          : transferNumber // ignore: cast_nullable_to_non_nullable
              as String,
      fromBranchId: null == fromBranchId
          ? _value.fromBranchId
          : fromBranchId // ignore: cast_nullable_to_non_nullable
              as String,
      toBranchId: null == toBranchId
          ? _value.toBranchId
          : toBranchId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TransferStatus,
      transferDate: null == transferDate
          ? _value.transferDate
          : transferDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expectedDate: freezed == expectedDate
          ? _value.expectedDate
          : expectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedDate: freezed == completedDate
          ? _value.completedDate
          : completedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      totalQuantity: null == totalQuantity
          ? _value.totalQuantity
          : totalQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      totalValue: null == totalValue
          ? _value.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as double,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      receivedBy: freezed == receivedBy
          ? _value.receivedBy
          : receivedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      receivedAt: freezed == receivedAt
          ? _value.receivedAt
          : receivedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<StockTransferItem>,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      transportMode: freezed == transportMode
          ? _value.transportMode
          : transportMode // ignore: cast_nullable_to_non_nullable
              as String?,
      transporterName: freezed == transporterName
          ? _value.transporterName
          : transporterName // ignore: cast_nullable_to_non_nullable
              as String?,
      trackingNumber: freezed == trackingNumber
          ? _value.trackingNumber
          : trackingNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      vehicleNumber: freezed == vehicleNumber
          ? _value.vehicleNumber
          : vehicleNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      driverName: freezed == driverName
          ? _value.driverName
          : driverName // ignore: cast_nullable_to_non_nullable
              as String?,
      driverContact: freezed == driverContact
          ? _value.driverContact
          : driverContact // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      customFields: null == customFields
          ? _value.customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectedAt: freezed == rejectedAt
          ? _value.rejectedAt
          : rejectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rejectedBy: freezed == rejectedBy
          ? _value.rejectedBy
          : rejectedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StockTransferImplCopyWith<$Res>
    implements $StockTransferCopyWith<$Res> {
  factory _$$StockTransferImplCopyWith(
          _$StockTransferImpl value, $Res Function(_$StockTransferImpl) then) =
      __$$StockTransferImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String transferNumber,
      String fromBranchId,
      String toBranchId,
      TransferStatus status,
      DateTime transferDate,
      DateTime? expectedDate,
      DateTime? completedDate,
      int totalItems,
      double totalQuantity,
      double totalValue,
      String? notes,
      String createdBy,
      String? approvedBy,
      DateTime? approvedAt,
      String? receivedBy,
      DateTime? receivedAt,
      DateTime createdAt,
      DateTime updatedAt,
      List<StockTransferItem> items,
      DateTime? syncedAt,
      String? transportMode,
      String? transporterName,
      String? trackingNumber,
      String? vehicleNumber,
      String? driverName,
      String? driverContact,
      Map<String, dynamic> metadata,
      Map<String, dynamic> customFields,
      String? rejectionReason,
      DateTime? rejectedAt,
      String? rejectedBy});
}

/// @nodoc
class __$$StockTransferImplCopyWithImpl<$Res>
    extends _$StockTransferCopyWithImpl<$Res, _$StockTransferImpl>
    implements _$$StockTransferImplCopyWith<$Res> {
  __$$StockTransferImplCopyWithImpl(
      _$StockTransferImpl _value, $Res Function(_$StockTransferImpl) _then)
      : super(_value, _then);

  /// Create a copy of StockTransfer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? transferNumber = null,
    Object? fromBranchId = null,
    Object? toBranchId = null,
    Object? status = null,
    Object? transferDate = null,
    Object? expectedDate = freezed,
    Object? completedDate = freezed,
    Object? totalItems = null,
    Object? totalQuantity = null,
    Object? totalValue = null,
    Object? notes = freezed,
    Object? createdBy = null,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
    Object? receivedBy = freezed,
    Object? receivedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? items = null,
    Object? syncedAt = freezed,
    Object? transportMode = freezed,
    Object? transporterName = freezed,
    Object? trackingNumber = freezed,
    Object? vehicleNumber = freezed,
    Object? driverName = freezed,
    Object? driverContact = freezed,
    Object? metadata = null,
    Object? customFields = null,
    Object? rejectionReason = freezed,
    Object? rejectedAt = freezed,
    Object? rejectedBy = freezed,
  }) {
    return _then(_$StockTransferImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      transferNumber: null == transferNumber
          ? _value.transferNumber
          : transferNumber // ignore: cast_nullable_to_non_nullable
              as String,
      fromBranchId: null == fromBranchId
          ? _value.fromBranchId
          : fromBranchId // ignore: cast_nullable_to_non_nullable
              as String,
      toBranchId: null == toBranchId
          ? _value.toBranchId
          : toBranchId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TransferStatus,
      transferDate: null == transferDate
          ? _value.transferDate
          : transferDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expectedDate: freezed == expectedDate
          ? _value.expectedDate
          : expectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedDate: freezed == completedDate
          ? _value.completedDate
          : completedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      totalQuantity: null == totalQuantity
          ? _value.totalQuantity
          : totalQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      totalValue: null == totalValue
          ? _value.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as double,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      receivedBy: freezed == receivedBy
          ? _value.receivedBy
          : receivedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      receivedAt: freezed == receivedAt
          ? _value.receivedAt
          : receivedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<StockTransferItem>,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      transportMode: freezed == transportMode
          ? _value.transportMode
          : transportMode // ignore: cast_nullable_to_non_nullable
              as String?,
      transporterName: freezed == transporterName
          ? _value.transporterName
          : transporterName // ignore: cast_nullable_to_non_nullable
              as String?,
      trackingNumber: freezed == trackingNumber
          ? _value.trackingNumber
          : trackingNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      vehicleNumber: freezed == vehicleNumber
          ? _value.vehicleNumber
          : vehicleNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      driverName: freezed == driverName
          ? _value.driverName
          : driverName // ignore: cast_nullable_to_non_nullable
              as String?,
      driverContact: freezed == driverContact
          ? _value.driverContact
          : driverContact // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      customFields: null == customFields
          ? _value._customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      rejectionReason: freezed == rejectionReason
          ? _value.rejectionReason
          : rejectionReason // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectedAt: freezed == rejectedAt
          ? _value.rejectedAt
          : rejectedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rejectedBy: freezed == rejectedBy
          ? _value.rejectedBy
          : rejectedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StockTransferImpl extends _StockTransfer {
  const _$StockTransferImpl(
      {required this.id,
      required this.organizationId,
      required this.transferNumber,
      required this.fromBranchId,
      required this.toBranchId,
      required this.status,
      required this.transferDate,
      this.expectedDate,
      this.completedDate,
      this.totalItems = 0,
      this.totalQuantity = 0,
      this.totalValue = 0,
      this.notes,
      required this.createdBy,
      this.approvedBy,
      this.approvedAt,
      this.receivedBy,
      this.receivedAt,
      required this.createdAt,
      required this.updatedAt,
      final List<StockTransferItem> items = const [],
      this.syncedAt,
      this.transportMode,
      this.transporterName,
      this.trackingNumber,
      this.vehicleNumber,
      this.driverName,
      this.driverContact,
      final Map<String, dynamic> metadata = const {},
      final Map<String, dynamic> customFields = const {},
      this.rejectionReason,
      this.rejectedAt,
      this.rejectedBy})
      : _items = items,
        _metadata = metadata,
        _customFields = customFields,
        super._();

  factory _$StockTransferImpl.fromJson(Map<String, dynamic> json) =>
      _$$StockTransferImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String transferNumber;
  @override
  final String fromBranchId;
  @override
  final String toBranchId;
  @override
  final TransferStatus status;
  @override
  final DateTime transferDate;
  @override
  final DateTime? expectedDate;
  @override
  final DateTime? completedDate;
  @override
  @JsonKey()
  final int totalItems;
  @override
  @JsonKey()
  final double totalQuantity;
  @override
  @JsonKey()
  final double totalValue;
  @override
  final String? notes;
  @override
  final String createdBy;
  @override
  final String? approvedBy;
  @override
  final DateTime? approvedAt;
  @override
  final String? receivedBy;
  @override
  final DateTime? receivedAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  final List<StockTransferItem> _items;
  @override
  @JsonKey()
  List<StockTransferItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final DateTime? syncedAt;
// Additional fields
  @override
  final String? transportMode;
  @override
  final String? transporterName;
  @override
  final String? trackingNumber;
  @override
  final String? vehicleNumber;
  @override
  final String? driverName;
  @override
  final String? driverContact;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  final Map<String, dynamic> _customFields;
  @override
  @JsonKey()
  Map<String, dynamic> get customFields {
    if (_customFields is EqualUnmodifiableMapView) return _customFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_customFields);
  }

  @override
  final String? rejectionReason;
  @override
  final DateTime? rejectedAt;
  @override
  final String? rejectedBy;

  @override
  String toString() {
    return 'StockTransfer(id: $id, organizationId: $organizationId, transferNumber: $transferNumber, fromBranchId: $fromBranchId, toBranchId: $toBranchId, status: $status, transferDate: $transferDate, expectedDate: $expectedDate, completedDate: $completedDate, totalItems: $totalItems, totalQuantity: $totalQuantity, totalValue: $totalValue, notes: $notes, createdBy: $createdBy, approvedBy: $approvedBy, approvedAt: $approvedAt, receivedBy: $receivedBy, receivedAt: $receivedAt, createdAt: $createdAt, updatedAt: $updatedAt, items: $items, syncedAt: $syncedAt, transportMode: $transportMode, transporterName: $transporterName, trackingNumber: $trackingNumber, vehicleNumber: $vehicleNumber, driverName: $driverName, driverContact: $driverContact, metadata: $metadata, customFields: $customFields, rejectionReason: $rejectionReason, rejectedAt: $rejectedAt, rejectedBy: $rejectedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockTransferImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.transferNumber, transferNumber) ||
                other.transferNumber == transferNumber) &&
            (identical(other.fromBranchId, fromBranchId) ||
                other.fromBranchId == fromBranchId) &&
            (identical(other.toBranchId, toBranchId) ||
                other.toBranchId == toBranchId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.transferDate, transferDate) ||
                other.transferDate == transferDate) &&
            (identical(other.expectedDate, expectedDate) ||
                other.expectedDate == expectedDate) &&
            (identical(other.completedDate, completedDate) ||
                other.completedDate == completedDate) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.totalQuantity, totalQuantity) ||
                other.totalQuantity == totalQuantity) &&
            (identical(other.totalValue, totalValue) ||
                other.totalValue == totalValue) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.receivedBy, receivedBy) ||
                other.receivedBy == receivedBy) &&
            (identical(other.receivedAt, receivedAt) ||
                other.receivedAt == receivedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.transportMode, transportMode) ||
                other.transportMode == transportMode) &&
            (identical(other.transporterName, transporterName) ||
                other.transporterName == transporterName) &&
            (identical(other.trackingNumber, trackingNumber) ||
                other.trackingNumber == trackingNumber) &&
            (identical(other.vehicleNumber, vehicleNumber) ||
                other.vehicleNumber == vehicleNumber) &&
            (identical(other.driverName, driverName) ||
                other.driverName == driverName) &&
            (identical(other.driverContact, driverContact) ||
                other.driverContact == driverContact) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            const DeepCollectionEquality()
                .equals(other._customFields, _customFields) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason) &&
            (identical(other.rejectedAt, rejectedAt) ||
                other.rejectedAt == rejectedAt) &&
            (identical(other.rejectedBy, rejectedBy) ||
                other.rejectedBy == rejectedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        organizationId,
        transferNumber,
        fromBranchId,
        toBranchId,
        status,
        transferDate,
        expectedDate,
        completedDate,
        totalItems,
        totalQuantity,
        totalValue,
        notes,
        createdBy,
        approvedBy,
        approvedAt,
        receivedBy,
        receivedAt,
        createdAt,
        updatedAt,
        const DeepCollectionEquality().hash(_items),
        syncedAt,
        transportMode,
        transporterName,
        trackingNumber,
        vehicleNumber,
        driverName,
        driverContact,
        const DeepCollectionEquality().hash(_metadata),
        const DeepCollectionEquality().hash(_customFields),
        rejectionReason,
        rejectedAt,
        rejectedBy
      ]);

  /// Create a copy of StockTransfer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StockTransferImplCopyWith<_$StockTransferImpl> get copyWith =>
      __$$StockTransferImplCopyWithImpl<_$StockTransferImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StockTransferImplToJson(
      this,
    );
  }
}

abstract class _StockTransfer extends StockTransfer {
  const factory _StockTransfer(
      {required final String id,
      required final String organizationId,
      required final String transferNumber,
      required final String fromBranchId,
      required final String toBranchId,
      required final TransferStatus status,
      required final DateTime transferDate,
      final DateTime? expectedDate,
      final DateTime? completedDate,
      final int totalItems,
      final double totalQuantity,
      final double totalValue,
      final String? notes,
      required final String createdBy,
      final String? approvedBy,
      final DateTime? approvedAt,
      final String? receivedBy,
      final DateTime? receivedAt,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final List<StockTransferItem> items,
      final DateTime? syncedAt,
      final String? transportMode,
      final String? transporterName,
      final String? trackingNumber,
      final String? vehicleNumber,
      final String? driverName,
      final String? driverContact,
      final Map<String, dynamic> metadata,
      final Map<String, dynamic> customFields,
      final String? rejectionReason,
      final DateTime? rejectedAt,
      final String? rejectedBy}) = _$StockTransferImpl;
  const _StockTransfer._() : super._();

  factory _StockTransfer.fromJson(Map<String, dynamic> json) =
      _$StockTransferImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String get transferNumber;
  @override
  String get fromBranchId;
  @override
  String get toBranchId;
  @override
  TransferStatus get status;
  @override
  DateTime get transferDate;
  @override
  DateTime? get expectedDate;
  @override
  DateTime? get completedDate;
  @override
  int get totalItems;
  @override
  double get totalQuantity;
  @override
  double get totalValue;
  @override
  String? get notes;
  @override
  String get createdBy;
  @override
  String? get approvedBy;
  @override
  DateTime? get approvedAt;
  @override
  String? get receivedBy;
  @override
  DateTime? get receivedAt;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  List<StockTransferItem> get items;
  @override
  DateTime? get syncedAt; // Additional fields
  @override
  String? get transportMode;
  @override
  String? get transporterName;
  @override
  String? get trackingNumber;
  @override
  String? get vehicleNumber;
  @override
  String? get driverName;
  @override
  String? get driverContact;
  @override
  Map<String, dynamic> get metadata;
  @override
  Map<String, dynamic> get customFields;
  @override
  String? get rejectionReason;
  @override
  DateTime? get rejectedAt;
  @override
  String? get rejectedBy;

  /// Create a copy of StockTransfer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StockTransferImplCopyWith<_$StockTransferImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StockTransferItem _$StockTransferItemFromJson(Map<String, dynamic> json) {
  return _StockTransferItem.fromJson(json);
}

/// @nodoc
mixin _$StockTransferItem {
  String get id => throw _privateConstructorUsedError;
  String get transferId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  double get receivedQuantity => throw _privateConstructorUsedError;
  double get damagedQuantity => throw _privateConstructorUsedError;
  double get lostQuantity => throw _privateConstructorUsedError;
  double? get unitCost => throw _privateConstructorUsedError;
  TransferItemStatus get status => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt =>
      throw _privateConstructorUsedError; // Additional fields
  String? get productName => throw _privateConstructorUsedError;
  String? get productSku => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;
  String? get batchId => throw _privateConstructorUsedError;
  String? get batchNumber => throw _privateConstructorUsedError;
  List<String>? get serialNumbers => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  String? get receivedNotes => throw _privateConstructorUsedError;
  DateTime? get receivedAt => throw _privateConstructorUsedError;
  String? get receivedBy => throw _privateConstructorUsedError;

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
      String transferId,
      String productId,
      double quantity,
      double receivedQuantity,
      double damagedQuantity,
      double lostQuantity,
      double? unitCost,
      TransferItemStatus status,
      String? notes,
      DateTime createdAt,
      DateTime updatedAt,
      String? productName,
      String? productSku,
      String? unit,
      String? batchId,
      String? batchNumber,
      List<String>? serialNumbers,
      Map<String, dynamic> metadata,
      String? receivedNotes,
      DateTime? receivedAt,
      String? receivedBy});
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
    Object? transferId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? receivedQuantity = null,
    Object? damagedQuantity = null,
    Object? lostQuantity = null,
    Object? unitCost = freezed,
    Object? status = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? productName = freezed,
    Object? productSku = freezed,
    Object? unit = freezed,
    Object? batchId = freezed,
    Object? batchNumber = freezed,
    Object? serialNumbers = freezed,
    Object? metadata = null,
    Object? receivedNotes = freezed,
    Object? receivedAt = freezed,
    Object? receivedBy = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      transferId: null == transferId
          ? _value.transferId
          : transferId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      receivedQuantity: null == receivedQuantity
          ? _value.receivedQuantity
          : receivedQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      damagedQuantity: null == damagedQuantity
          ? _value.damagedQuantity
          : damagedQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      lostQuantity: null == lostQuantity
          ? _value.lostQuantity
          : lostQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitCost: freezed == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TransferItemStatus,
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
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      productSku: freezed == productSku
          ? _value.productSku
          : productSku // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      batchId: freezed == batchId
          ? _value.batchId
          : batchId // ignore: cast_nullable_to_non_nullable
              as String?,
      batchNumber: freezed == batchNumber
          ? _value.batchNumber
          : batchNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNumbers: freezed == serialNumbers
          ? _value.serialNumbers
          : serialNumbers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      receivedNotes: freezed == receivedNotes
          ? _value.receivedNotes
          : receivedNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      receivedAt: freezed == receivedAt
          ? _value.receivedAt
          : receivedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      receivedBy: freezed == receivedBy
          ? _value.receivedBy
          : receivedBy // ignore: cast_nullable_to_non_nullable
              as String?,
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
      String transferId,
      String productId,
      double quantity,
      double receivedQuantity,
      double damagedQuantity,
      double lostQuantity,
      double? unitCost,
      TransferItemStatus status,
      String? notes,
      DateTime createdAt,
      DateTime updatedAt,
      String? productName,
      String? productSku,
      String? unit,
      String? batchId,
      String? batchNumber,
      List<String>? serialNumbers,
      Map<String, dynamic> metadata,
      String? receivedNotes,
      DateTime? receivedAt,
      String? receivedBy});
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
    Object? transferId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? receivedQuantity = null,
    Object? damagedQuantity = null,
    Object? lostQuantity = null,
    Object? unitCost = freezed,
    Object? status = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? productName = freezed,
    Object? productSku = freezed,
    Object? unit = freezed,
    Object? batchId = freezed,
    Object? batchNumber = freezed,
    Object? serialNumbers = freezed,
    Object? metadata = null,
    Object? receivedNotes = freezed,
    Object? receivedAt = freezed,
    Object? receivedBy = freezed,
  }) {
    return _then(_$StockTransferItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      transferId: null == transferId
          ? _value.transferId
          : transferId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      receivedQuantity: null == receivedQuantity
          ? _value.receivedQuantity
          : receivedQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      damagedQuantity: null == damagedQuantity
          ? _value.damagedQuantity
          : damagedQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      lostQuantity: null == lostQuantity
          ? _value.lostQuantity
          : lostQuantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitCost: freezed == unitCost
          ? _value.unitCost
          : unitCost // ignore: cast_nullable_to_non_nullable
              as double?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TransferItemStatus,
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
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      productSku: freezed == productSku
          ? _value.productSku
          : productSku // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      batchId: freezed == batchId
          ? _value.batchId
          : batchId // ignore: cast_nullable_to_non_nullable
              as String?,
      batchNumber: freezed == batchNumber
          ? _value.batchNumber
          : batchNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNumbers: freezed == serialNumbers
          ? _value._serialNumbers
          : serialNumbers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      receivedNotes: freezed == receivedNotes
          ? _value.receivedNotes
          : receivedNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      receivedAt: freezed == receivedAt
          ? _value.receivedAt
          : receivedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      receivedBy: freezed == receivedBy
          ? _value.receivedBy
          : receivedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StockTransferItemImpl extends _StockTransferItem {
  const _$StockTransferItemImpl(
      {required this.id,
      required this.transferId,
      required this.productId,
      required this.quantity,
      this.receivedQuantity = 0,
      this.damagedQuantity = 0,
      this.lostQuantity = 0,
      this.unitCost,
      required this.status,
      this.notes,
      required this.createdAt,
      required this.updatedAt,
      this.productName,
      this.productSku,
      this.unit,
      this.batchId,
      this.batchNumber,
      final List<String>? serialNumbers,
      final Map<String, dynamic> metadata = const {},
      this.receivedNotes,
      this.receivedAt,
      this.receivedBy})
      : _serialNumbers = serialNumbers,
        _metadata = metadata,
        super._();

  factory _$StockTransferItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$StockTransferItemImplFromJson(json);

  @override
  final String id;
  @override
  final String transferId;
  @override
  final String productId;
  @override
  final double quantity;
  @override
  @JsonKey()
  final double receivedQuantity;
  @override
  @JsonKey()
  final double damagedQuantity;
  @override
  @JsonKey()
  final double lostQuantity;
  @override
  final double? unitCost;
  @override
  final TransferItemStatus status;
  @override
  final String? notes;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
// Additional fields
  @override
  final String? productName;
  @override
  final String? productSku;
  @override
  final String? unit;
  @override
  final String? batchId;
  @override
  final String? batchNumber;
  final List<String>? _serialNumbers;
  @override
  List<String>? get serialNumbers {
    final value = _serialNumbers;
    if (value == null) return null;
    if (_serialNumbers is EqualUnmodifiableListView) return _serialNumbers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
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
  final String? receivedNotes;
  @override
  final DateTime? receivedAt;
  @override
  final String? receivedBy;

  @override
  String toString() {
    return 'StockTransferItem(id: $id, transferId: $transferId, productId: $productId, quantity: $quantity, receivedQuantity: $receivedQuantity, damagedQuantity: $damagedQuantity, lostQuantity: $lostQuantity, unitCost: $unitCost, status: $status, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, productName: $productName, productSku: $productSku, unit: $unit, batchId: $batchId, batchNumber: $batchNumber, serialNumbers: $serialNumbers, metadata: $metadata, receivedNotes: $receivedNotes, receivedAt: $receivedAt, receivedBy: $receivedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockTransferItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.transferId, transferId) ||
                other.transferId == transferId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.receivedQuantity, receivedQuantity) ||
                other.receivedQuantity == receivedQuantity) &&
            (identical(other.damagedQuantity, damagedQuantity) ||
                other.damagedQuantity == damagedQuantity) &&
            (identical(other.lostQuantity, lostQuantity) ||
                other.lostQuantity == lostQuantity) &&
            (identical(other.unitCost, unitCost) ||
                other.unitCost == unitCost) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.productSku, productSku) ||
                other.productSku == productSku) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.batchId, batchId) || other.batchId == batchId) &&
            (identical(other.batchNumber, batchNumber) ||
                other.batchNumber == batchNumber) &&
            const DeepCollectionEquality()
                .equals(other._serialNumbers, _serialNumbers) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.receivedNotes, receivedNotes) ||
                other.receivedNotes == receivedNotes) &&
            (identical(other.receivedAt, receivedAt) ||
                other.receivedAt == receivedAt) &&
            (identical(other.receivedBy, receivedBy) ||
                other.receivedBy == receivedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        transferId,
        productId,
        quantity,
        receivedQuantity,
        damagedQuantity,
        lostQuantity,
        unitCost,
        status,
        notes,
        createdAt,
        updatedAt,
        productName,
        productSku,
        unit,
        batchId,
        batchNumber,
        const DeepCollectionEquality().hash(_serialNumbers),
        const DeepCollectionEquality().hash(_metadata),
        receivedNotes,
        receivedAt,
        receivedBy
      ]);

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

abstract class _StockTransferItem extends StockTransferItem {
  const factory _StockTransferItem(
      {required final String id,
      required final String transferId,
      required final String productId,
      required final double quantity,
      final double receivedQuantity,
      final double damagedQuantity,
      final double lostQuantity,
      final double? unitCost,
      required final TransferItemStatus status,
      final String? notes,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final String? productName,
      final String? productSku,
      final String? unit,
      final String? batchId,
      final String? batchNumber,
      final List<String>? serialNumbers,
      final Map<String, dynamic> metadata,
      final String? receivedNotes,
      final DateTime? receivedAt,
      final String? receivedBy}) = _$StockTransferItemImpl;
  const _StockTransferItem._() : super._();

  factory _StockTransferItem.fromJson(Map<String, dynamic> json) =
      _$StockTransferItemImpl.fromJson;

  @override
  String get id;
  @override
  String get transferId;
  @override
  String get productId;
  @override
  double get quantity;
  @override
  double get receivedQuantity;
  @override
  double get damagedQuantity;
  @override
  double get lostQuantity;
  @override
  double? get unitCost;
  @override
  TransferItemStatus get status;
  @override
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt; // Additional fields
  @override
  String? get productName;
  @override
  String? get productSku;
  @override
  String? get unit;
  @override
  String? get batchId;
  @override
  String? get batchNumber;
  @override
  List<String>? get serialNumbers;
  @override
  Map<String, dynamic> get metadata;
  @override
  String? get receivedNotes;
  @override
  DateTime? get receivedAt;
  @override
  String? get receivedBy;

  /// Create a copy of StockTransferItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StockTransferItemImplCopyWith<_$StockTransferItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
