// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PurchaseOrder _$PurchaseOrderFromJson(Map<String, dynamic> json) {
  return _PurchaseOrder.fromJson(json);
}

/// @nodoc
mixin _$PurchaseOrder {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get supplierId => throw _privateConstructorUsedError;
  String get poNumber => throw _privateConstructorUsedError;
  DateTime get orderDate => throw _privateConstructorUsedError;
  DateTime? get expectedDate => throw _privateConstructorUsedError;
  PurchaseOrderStatus get status => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  double get taxAmount => throw _privateConstructorUsedError;
  double get discountAmount => throw _privateConstructorUsedError;
  double get shippingAmount => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  List<PurchaseOrderItem> get items => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional fields
  String? get branchId => throw _privateConstructorUsedError;
  String? get warehouseId => throw _privateConstructorUsedError;
  String? get paymentTerms => throw _privateConstructorUsedError;
  String? get shippingAddress => throw _privateConstructorUsedError;
  String? get billingAddress => throw _privateConstructorUsedError;
  String? get approvedBy => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  String? get receivedBy => throw _privateConstructorUsedError;
  DateTime? get receivedAt => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  Map<String, dynamic> get customFields => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  double? get exchangeRate => throw _privateConstructorUsedError;

  /// Serializes this PurchaseOrder to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PurchaseOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchaseOrderCopyWith<PurchaseOrder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseOrderCopyWith<$Res> {
  factory $PurchaseOrderCopyWith(
          PurchaseOrder value, $Res Function(PurchaseOrder) then) =
      _$PurchaseOrderCopyWithImpl<$Res, PurchaseOrder>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String supplierId,
      String poNumber,
      DateTime orderDate,
      DateTime? expectedDate,
      PurchaseOrderStatus status,
      double totalAmount,
      double taxAmount,
      double discountAmount,
      double shippingAmount,
      String? notes,
      DateTime createdAt,
      DateTime updatedAt,
      String createdBy,
      List<PurchaseOrderItem> items,
      DateTime? syncedAt,
      String? branchId,
      String? warehouseId,
      String? paymentTerms,
      String? shippingAddress,
      String? billingAddress,
      String? approvedBy,
      DateTime? approvedAt,
      String? receivedBy,
      DateTime? receivedAt,
      Map<String, dynamic> metadata,
      Map<String, dynamic> customFields,
      String? currency,
      double? exchangeRate});
}

/// @nodoc
class _$PurchaseOrderCopyWithImpl<$Res, $Val extends PurchaseOrder>
    implements $PurchaseOrderCopyWith<$Res> {
  _$PurchaseOrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchaseOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? supplierId = null,
    Object? poNumber = null,
    Object? orderDate = null,
    Object? expectedDate = freezed,
    Object? status = null,
    Object? totalAmount = null,
    Object? taxAmount = null,
    Object? discountAmount = null,
    Object? shippingAmount = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? createdBy = null,
    Object? items = null,
    Object? syncedAt = freezed,
    Object? branchId = freezed,
    Object? warehouseId = freezed,
    Object? paymentTerms = freezed,
    Object? shippingAddress = freezed,
    Object? billingAddress = freezed,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
    Object? receivedBy = freezed,
    Object? receivedAt = freezed,
    Object? metadata = null,
    Object? customFields = null,
    Object? currency = freezed,
    Object? exchangeRate = freezed,
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
      supplierId: null == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as String,
      poNumber: null == poNumber
          ? _value.poNumber
          : poNumber // ignore: cast_nullable_to_non_nullable
              as String,
      orderDate: null == orderDate
          ? _value.orderDate
          : orderDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expectedDate: freezed == expectedDate
          ? _value.expectedDate
          : expectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PurchaseOrderStatus,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      taxAmount: null == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double,
      shippingAmount: null == shippingAmount
          ? _value.shippingAmount
          : shippingAmount // ignore: cast_nullable_to_non_nullable
              as double,
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
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PurchaseOrderItem>,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      branchId: freezed == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as String?,
      warehouseId: freezed == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentTerms: freezed == paymentTerms
          ? _value.paymentTerms
          : paymentTerms // ignore: cast_nullable_to_non_nullable
              as String?,
      shippingAddress: freezed == shippingAddress
          ? _value.shippingAddress
          : shippingAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      billingAddress: freezed == billingAddress
          ? _value.billingAddress
          : billingAddress // ignore: cast_nullable_to_non_nullable
              as String?,
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
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      customFields: null == customFields
          ? _value.customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      exchangeRate: freezed == exchangeRate
          ? _value.exchangeRate
          : exchangeRate // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PurchaseOrderImplCopyWith<$Res>
    implements $PurchaseOrderCopyWith<$Res> {
  factory _$$PurchaseOrderImplCopyWith(
          _$PurchaseOrderImpl value, $Res Function(_$PurchaseOrderImpl) then) =
      __$$PurchaseOrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String supplierId,
      String poNumber,
      DateTime orderDate,
      DateTime? expectedDate,
      PurchaseOrderStatus status,
      double totalAmount,
      double taxAmount,
      double discountAmount,
      double shippingAmount,
      String? notes,
      DateTime createdAt,
      DateTime updatedAt,
      String createdBy,
      List<PurchaseOrderItem> items,
      DateTime? syncedAt,
      String? branchId,
      String? warehouseId,
      String? paymentTerms,
      String? shippingAddress,
      String? billingAddress,
      String? approvedBy,
      DateTime? approvedAt,
      String? receivedBy,
      DateTime? receivedAt,
      Map<String, dynamic> metadata,
      Map<String, dynamic> customFields,
      String? currency,
      double? exchangeRate});
}

/// @nodoc
class __$$PurchaseOrderImplCopyWithImpl<$Res>
    extends _$PurchaseOrderCopyWithImpl<$Res, _$PurchaseOrderImpl>
    implements _$$PurchaseOrderImplCopyWith<$Res> {
  __$$PurchaseOrderImplCopyWithImpl(
      _$PurchaseOrderImpl _value, $Res Function(_$PurchaseOrderImpl) _then)
      : super(_value, _then);

  /// Create a copy of PurchaseOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? supplierId = null,
    Object? poNumber = null,
    Object? orderDate = null,
    Object? expectedDate = freezed,
    Object? status = null,
    Object? totalAmount = null,
    Object? taxAmount = null,
    Object? discountAmount = null,
    Object? shippingAmount = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? createdBy = null,
    Object? items = null,
    Object? syncedAt = freezed,
    Object? branchId = freezed,
    Object? warehouseId = freezed,
    Object? paymentTerms = freezed,
    Object? shippingAddress = freezed,
    Object? billingAddress = freezed,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
    Object? receivedBy = freezed,
    Object? receivedAt = freezed,
    Object? metadata = null,
    Object? customFields = null,
    Object? currency = freezed,
    Object? exchangeRate = freezed,
  }) {
    return _then(_$PurchaseOrderImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      supplierId: null == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as String,
      poNumber: null == poNumber
          ? _value.poNumber
          : poNumber // ignore: cast_nullable_to_non_nullable
              as String,
      orderDate: null == orderDate
          ? _value.orderDate
          : orderDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expectedDate: freezed == expectedDate
          ? _value.expectedDate
          : expectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PurchaseOrderStatus,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      taxAmount: null == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double,
      shippingAmount: null == shippingAmount
          ? _value.shippingAmount
          : shippingAmount // ignore: cast_nullable_to_non_nullable
              as double,
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
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PurchaseOrderItem>,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      branchId: freezed == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as String?,
      warehouseId: freezed == warehouseId
          ? _value.warehouseId
          : warehouseId // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentTerms: freezed == paymentTerms
          ? _value.paymentTerms
          : paymentTerms // ignore: cast_nullable_to_non_nullable
              as String?,
      shippingAddress: freezed == shippingAddress
          ? _value.shippingAddress
          : shippingAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      billingAddress: freezed == billingAddress
          ? _value.billingAddress
          : billingAddress // ignore: cast_nullable_to_non_nullable
              as String?,
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
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      customFields: null == customFields
          ? _value._customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      exchangeRate: freezed == exchangeRate
          ? _value.exchangeRate
          : exchangeRate // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchaseOrderImpl extends _PurchaseOrder {
  const _$PurchaseOrderImpl(
      {required this.id,
      required this.organizationId,
      required this.supplierId,
      required this.poNumber,
      required this.orderDate,
      this.expectedDate,
      required this.status,
      this.totalAmount = 0,
      this.taxAmount = 0,
      this.discountAmount = 0,
      this.shippingAmount = 0,
      this.notes,
      required this.createdAt,
      required this.updatedAt,
      required this.createdBy,
      final List<PurchaseOrderItem> items = const [],
      this.syncedAt,
      this.branchId,
      this.warehouseId,
      this.paymentTerms,
      this.shippingAddress,
      this.billingAddress,
      this.approvedBy,
      this.approvedAt,
      this.receivedBy,
      this.receivedAt,
      final Map<String, dynamic> metadata = const {},
      final Map<String, dynamic> customFields = const {},
      this.currency,
      this.exchangeRate})
      : _items = items,
        _metadata = metadata,
        _customFields = customFields,
        super._();

  factory _$PurchaseOrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseOrderImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String supplierId;
  @override
  final String poNumber;
  @override
  final DateTime orderDate;
  @override
  final DateTime? expectedDate;
  @override
  final PurchaseOrderStatus status;
  @override
  @JsonKey()
  final double totalAmount;
  @override
  @JsonKey()
  final double taxAmount;
  @override
  @JsonKey()
  final double discountAmount;
  @override
  @JsonKey()
  final double shippingAmount;
  @override
  final String? notes;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String createdBy;
  final List<PurchaseOrderItem> _items;
  @override
  @JsonKey()
  List<PurchaseOrderItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final DateTime? syncedAt;
// Additional fields
  @override
  final String? branchId;
  @override
  final String? warehouseId;
  @override
  final String? paymentTerms;
  @override
  final String? shippingAddress;
  @override
  final String? billingAddress;
  @override
  final String? approvedBy;
  @override
  final DateTime? approvedAt;
  @override
  final String? receivedBy;
  @override
  final DateTime? receivedAt;
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
  final String? currency;
  @override
  final double? exchangeRate;

  @override
  String toString() {
    return 'PurchaseOrder(id: $id, organizationId: $organizationId, supplierId: $supplierId, poNumber: $poNumber, orderDate: $orderDate, expectedDate: $expectedDate, status: $status, totalAmount: $totalAmount, taxAmount: $taxAmount, discountAmount: $discountAmount, shippingAmount: $shippingAmount, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, items: $items, syncedAt: $syncedAt, branchId: $branchId, warehouseId: $warehouseId, paymentTerms: $paymentTerms, shippingAddress: $shippingAddress, billingAddress: $billingAddress, approvedBy: $approvedBy, approvedAt: $approvedAt, receivedBy: $receivedBy, receivedAt: $receivedAt, metadata: $metadata, customFields: $customFields, currency: $currency, exchangeRate: $exchangeRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseOrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.supplierId, supplierId) ||
                other.supplierId == supplierId) &&
            (identical(other.poNumber, poNumber) ||
                other.poNumber == poNumber) &&
            (identical(other.orderDate, orderDate) ||
                other.orderDate == orderDate) &&
            (identical(other.expectedDate, expectedDate) ||
                other.expectedDate == expectedDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.taxAmount, taxAmount) ||
                other.taxAmount == taxAmount) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.shippingAmount, shippingAmount) ||
                other.shippingAmount == shippingAmount) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.branchId, branchId) ||
                other.branchId == branchId) &&
            (identical(other.warehouseId, warehouseId) ||
                other.warehouseId == warehouseId) &&
            (identical(other.paymentTerms, paymentTerms) ||
                other.paymentTerms == paymentTerms) &&
            (identical(other.shippingAddress, shippingAddress) ||
                other.shippingAddress == shippingAddress) &&
            (identical(other.billingAddress, billingAddress) ||
                other.billingAddress == billingAddress) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.receivedBy, receivedBy) ||
                other.receivedBy == receivedBy) &&
            (identical(other.receivedAt, receivedAt) ||
                other.receivedAt == receivedAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            const DeepCollectionEquality()
                .equals(other._customFields, _customFields) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.exchangeRate, exchangeRate) ||
                other.exchangeRate == exchangeRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        organizationId,
        supplierId,
        poNumber,
        orderDate,
        expectedDate,
        status,
        totalAmount,
        taxAmount,
        discountAmount,
        shippingAmount,
        notes,
        createdAt,
        updatedAt,
        createdBy,
        const DeepCollectionEquality().hash(_items),
        syncedAt,
        branchId,
        warehouseId,
        paymentTerms,
        shippingAddress,
        billingAddress,
        approvedBy,
        approvedAt,
        receivedBy,
        receivedAt,
        const DeepCollectionEquality().hash(_metadata),
        const DeepCollectionEquality().hash(_customFields),
        currency,
        exchangeRate
      ]);

  /// Create a copy of PurchaseOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseOrderImplCopyWith<_$PurchaseOrderImpl> get copyWith =>
      __$$PurchaseOrderImplCopyWithImpl<_$PurchaseOrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchaseOrderImplToJson(
      this,
    );
  }
}

abstract class _PurchaseOrder extends PurchaseOrder {
  const factory _PurchaseOrder(
      {required final String id,
      required final String organizationId,
      required final String supplierId,
      required final String poNumber,
      required final DateTime orderDate,
      final DateTime? expectedDate,
      required final PurchaseOrderStatus status,
      final double totalAmount,
      final double taxAmount,
      final double discountAmount,
      final double shippingAmount,
      final String? notes,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final String createdBy,
      final List<PurchaseOrderItem> items,
      final DateTime? syncedAt,
      final String? branchId,
      final String? warehouseId,
      final String? paymentTerms,
      final String? shippingAddress,
      final String? billingAddress,
      final String? approvedBy,
      final DateTime? approvedAt,
      final String? receivedBy,
      final DateTime? receivedAt,
      final Map<String, dynamic> metadata,
      final Map<String, dynamic> customFields,
      final String? currency,
      final double? exchangeRate}) = _$PurchaseOrderImpl;
  const _PurchaseOrder._() : super._();

  factory _PurchaseOrder.fromJson(Map<String, dynamic> json) =
      _$PurchaseOrderImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String get supplierId;
  @override
  String get poNumber;
  @override
  DateTime get orderDate;
  @override
  DateTime? get expectedDate;
  @override
  PurchaseOrderStatus get status;
  @override
  double get totalAmount;
  @override
  double get taxAmount;
  @override
  double get discountAmount;
  @override
  double get shippingAmount;
  @override
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  String get createdBy;
  @override
  List<PurchaseOrderItem> get items;
  @override
  DateTime? get syncedAt; // Additional fields
  @override
  String? get branchId;
  @override
  String? get warehouseId;
  @override
  String? get paymentTerms;
  @override
  String? get shippingAddress;
  @override
  String? get billingAddress;
  @override
  String? get approvedBy;
  @override
  DateTime? get approvedAt;
  @override
  String? get receivedBy;
  @override
  DateTime? get receivedAt;
  @override
  Map<String, dynamic> get metadata;
  @override
  Map<String, dynamic> get customFields;
  @override
  String? get currency;
  @override
  double? get exchangeRate;

  /// Create a copy of PurchaseOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseOrderImplCopyWith<_$PurchaseOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PurchaseOrderItem _$PurchaseOrderItemFromJson(Map<String, dynamic> json) {
  return _PurchaseOrderItem.fromJson(json);
}

/// @nodoc
mixin _$PurchaseOrderItem {
  String get id => throw _privateConstructorUsedError;
  String get purchaseOrderId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  double get receivedQuantity => throw _privateConstructorUsedError;
  double get unitPrice => throw _privateConstructorUsedError;
  double get taxRate => throw _privateConstructorUsedError;
  double get discountRate => throw _privateConstructorUsedError;
  double get discountAmount => throw _privateConstructorUsedError;
  DateTime get createdAt =>
      throw _privateConstructorUsedError; // Additional fields
  String? get productName => throw _privateConstructorUsedError;
  String? get productSku => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  String? get batchNumber => throw _privateConstructorUsedError;
  DateTime? get expiryDate => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this PurchaseOrderItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PurchaseOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchaseOrderItemCopyWith<PurchaseOrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseOrderItemCopyWith<$Res> {
  factory $PurchaseOrderItemCopyWith(
          PurchaseOrderItem value, $Res Function(PurchaseOrderItem) then) =
      _$PurchaseOrderItemCopyWithImpl<$Res, PurchaseOrderItem>;
  @useResult
  $Res call(
      {String id,
      String purchaseOrderId,
      String productId,
      double quantity,
      double receivedQuantity,
      double unitPrice,
      double taxRate,
      double discountRate,
      double discountAmount,
      DateTime createdAt,
      String? productName,
      String? productSku,
      String? unit,
      String? notes,
      String? batchNumber,
      DateTime? expiryDate,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$PurchaseOrderItemCopyWithImpl<$Res, $Val extends PurchaseOrderItem>
    implements $PurchaseOrderItemCopyWith<$Res> {
  _$PurchaseOrderItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchaseOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? purchaseOrderId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? receivedQuantity = null,
    Object? unitPrice = null,
    Object? taxRate = null,
    Object? discountRate = null,
    Object? discountAmount = null,
    Object? createdAt = null,
    Object? productName = freezed,
    Object? productSku = freezed,
    Object? unit = freezed,
    Object? notes = freezed,
    Object? batchNumber = freezed,
    Object? expiryDate = freezed,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseOrderId: null == purchaseOrderId
          ? _value.purchaseOrderId
          : purchaseOrderId // ignore: cast_nullable_to_non_nullable
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
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      taxRate: null == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double,
      discountRate: null == discountRate
          ? _value.discountRate
          : discountRate // ignore: cast_nullable_to_non_nullable
              as double,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
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
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      batchNumber: freezed == batchNumber
          ? _value.batchNumber
          : batchNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PurchaseOrderItemImplCopyWith<$Res>
    implements $PurchaseOrderItemCopyWith<$Res> {
  factory _$$PurchaseOrderItemImplCopyWith(_$PurchaseOrderItemImpl value,
          $Res Function(_$PurchaseOrderItemImpl) then) =
      __$$PurchaseOrderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String purchaseOrderId,
      String productId,
      double quantity,
      double receivedQuantity,
      double unitPrice,
      double taxRate,
      double discountRate,
      double discountAmount,
      DateTime createdAt,
      String? productName,
      String? productSku,
      String? unit,
      String? notes,
      String? batchNumber,
      DateTime? expiryDate,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$$PurchaseOrderItemImplCopyWithImpl<$Res>
    extends _$PurchaseOrderItemCopyWithImpl<$Res, _$PurchaseOrderItemImpl>
    implements _$$PurchaseOrderItemImplCopyWith<$Res> {
  __$$PurchaseOrderItemImplCopyWithImpl(_$PurchaseOrderItemImpl _value,
      $Res Function(_$PurchaseOrderItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of PurchaseOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? purchaseOrderId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? receivedQuantity = null,
    Object? unitPrice = null,
    Object? taxRate = null,
    Object? discountRate = null,
    Object? discountAmount = null,
    Object? createdAt = null,
    Object? productName = freezed,
    Object? productSku = freezed,
    Object? unit = freezed,
    Object? notes = freezed,
    Object? batchNumber = freezed,
    Object? expiryDate = freezed,
    Object? metadata = null,
  }) {
    return _then(_$PurchaseOrderItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseOrderId: null == purchaseOrderId
          ? _value.purchaseOrderId
          : purchaseOrderId // ignore: cast_nullable_to_non_nullable
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
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      taxRate: null == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double,
      discountRate: null == discountRate
          ? _value.discountRate
          : discountRate // ignore: cast_nullable_to_non_nullable
              as double,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
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
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      batchNumber: freezed == batchNumber
          ? _value.batchNumber
          : batchNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      expiryDate: freezed == expiryDate
          ? _value.expiryDate
          : expiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchaseOrderItemImpl extends _PurchaseOrderItem {
  const _$PurchaseOrderItemImpl(
      {required this.id,
      required this.purchaseOrderId,
      required this.productId,
      required this.quantity,
      this.receivedQuantity = 0,
      required this.unitPrice,
      this.taxRate = 0,
      this.discountRate = 0,
      this.discountAmount = 0,
      required this.createdAt,
      this.productName,
      this.productSku,
      this.unit,
      this.notes,
      this.batchNumber,
      this.expiryDate,
      final Map<String, dynamic> metadata = const {}})
      : _metadata = metadata,
        super._();

  factory _$PurchaseOrderItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseOrderItemImplFromJson(json);

  @override
  final String id;
  @override
  final String purchaseOrderId;
  @override
  final String productId;
  @override
  final double quantity;
  @override
  @JsonKey()
  final double receivedQuantity;
  @override
  final double unitPrice;
  @override
  @JsonKey()
  final double taxRate;
  @override
  @JsonKey()
  final double discountRate;
  @override
  @JsonKey()
  final double discountAmount;
  @override
  final DateTime createdAt;
// Additional fields
  @override
  final String? productName;
  @override
  final String? productSku;
  @override
  final String? unit;
  @override
  final String? notes;
  @override
  final String? batchNumber;
  @override
  final DateTime? expiryDate;
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
    return 'PurchaseOrderItem(id: $id, purchaseOrderId: $purchaseOrderId, productId: $productId, quantity: $quantity, receivedQuantity: $receivedQuantity, unitPrice: $unitPrice, taxRate: $taxRate, discountRate: $discountRate, discountAmount: $discountAmount, createdAt: $createdAt, productName: $productName, productSku: $productSku, unit: $unit, notes: $notes, batchNumber: $batchNumber, expiryDate: $expiryDate, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseOrderItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.purchaseOrderId, purchaseOrderId) ||
                other.purchaseOrderId == purchaseOrderId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.receivedQuantity, receivedQuantity) ||
                other.receivedQuantity == receivedQuantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.taxRate, taxRate) || other.taxRate == taxRate) &&
            (identical(other.discountRate, discountRate) ||
                other.discountRate == discountRate) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.productSku, productSku) ||
                other.productSku == productSku) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.batchNumber, batchNumber) ||
                other.batchNumber == batchNumber) &&
            (identical(other.expiryDate, expiryDate) ||
                other.expiryDate == expiryDate) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      purchaseOrderId,
      productId,
      quantity,
      receivedQuantity,
      unitPrice,
      taxRate,
      discountRate,
      discountAmount,
      createdAt,
      productName,
      productSku,
      unit,
      notes,
      batchNumber,
      expiryDate,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of PurchaseOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseOrderItemImplCopyWith<_$PurchaseOrderItemImpl> get copyWith =>
      __$$PurchaseOrderItemImplCopyWithImpl<_$PurchaseOrderItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchaseOrderItemImplToJson(
      this,
    );
  }
}

abstract class _PurchaseOrderItem extends PurchaseOrderItem {
  const factory _PurchaseOrderItem(
      {required final String id,
      required final String purchaseOrderId,
      required final String productId,
      required final double quantity,
      final double receivedQuantity,
      required final double unitPrice,
      final double taxRate,
      final double discountRate,
      final double discountAmount,
      required final DateTime createdAt,
      final String? productName,
      final String? productSku,
      final String? unit,
      final String? notes,
      final String? batchNumber,
      final DateTime? expiryDate,
      final Map<String, dynamic> metadata}) = _$PurchaseOrderItemImpl;
  const _PurchaseOrderItem._() : super._();

  factory _PurchaseOrderItem.fromJson(Map<String, dynamic> json) =
      _$PurchaseOrderItemImpl.fromJson;

  @override
  String get id;
  @override
  String get purchaseOrderId;
  @override
  String get productId;
  @override
  double get quantity;
  @override
  double get receivedQuantity;
  @override
  double get unitPrice;
  @override
  double get taxRate;
  @override
  double get discountRate;
  @override
  double get discountAmount;
  @override
  DateTime get createdAt; // Additional fields
  @override
  String? get productName;
  @override
  String? get productSku;
  @override
  String? get unit;
  @override
  String? get notes;
  @override
  String? get batchNumber;
  @override
  DateTime? get expiryDate;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of PurchaseOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseOrderItemImplCopyWith<_$PurchaseOrderItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
