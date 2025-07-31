// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase_bill.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PurchaseBill _$PurchaseBillFromJson(Map<String, dynamic> json) {
  return _PurchaseBill.fromJson(json);
}

/// @nodoc
mixin _$PurchaseBill {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get supplierId => throw _privateConstructorUsedError;
  String? get purchaseOrderId => throw _privateConstructorUsedError;
  String get billNumber => throw _privateConstructorUsedError;
  DateTime get billDate => throw _privateConstructorUsedError;
  DateTime? get dueDate => throw _privateConstructorUsedError;
  PurchaseBillStatus get status => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  double get paidAmount => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional fields
  String? get supplierBillNumber => throw _privateConstructorUsedError;
  String? get referenceNumber => throw _privateConstructorUsedError;
  List<PurchaseBillItem> get items => throw _privateConstructorUsedError;
  double? get subtotal => throw _privateConstructorUsedError;
  double? get taxAmount => throw _privateConstructorUsedError;
  double? get discountAmount => throw _privateConstructorUsedError;
  String? get discountType =>
      throw _privateConstructorUsedError; // 'percentage' or 'fixed'
  double? get discountValue => throw _privateConstructorUsedError;
  double? get shippingAmount => throw _privateConstructorUsedError;
  double? get otherCharges => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  double? get exchangeRate => throw _privateConstructorUsedError;
  PaymentTerm get paymentTerm => throw _privateConstructorUsedError;
  int? get customPaymentDays => throw _privateConstructorUsedError;
  String? get billingAddress => throw _privateConstructorUsedError;
  String? get shippingAddress => throw _privateConstructorUsedError;
  List<String> get attachmentUrls => throw _privateConstructorUsedError;
  String? get approvedBy => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  String? get cancelledBy => throw _privateConstructorUsedError;
  DateTime? get cancelledAt => throw _privateConstructorUsedError;
  String? get cancellationReason => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  List<PurchaseBillPayment> get payments => throw _privateConstructorUsedError;
  String? get lastPaymentId => throw _privateConstructorUsedError;
  DateTime? get lastPaymentDate => throw _privateConstructorUsedError;

  /// Serializes this PurchaseBill to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PurchaseBill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchaseBillCopyWith<PurchaseBill> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseBillCopyWith<$Res> {
  factory $PurchaseBillCopyWith(
          PurchaseBill value, $Res Function(PurchaseBill) then) =
      _$PurchaseBillCopyWithImpl<$Res, PurchaseBill>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String supplierId,
      String? purchaseOrderId,
      String billNumber,
      DateTime billDate,
      DateTime? dueDate,
      PurchaseBillStatus status,
      double totalAmount,
      double paidAmount,
      String? notes,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? supplierBillNumber,
      String? referenceNumber,
      List<PurchaseBillItem> items,
      double? subtotal,
      double? taxAmount,
      double? discountAmount,
      String? discountType,
      double? discountValue,
      double? shippingAmount,
      double? otherCharges,
      String? currency,
      double? exchangeRate,
      PaymentTerm paymentTerm,
      int? customPaymentDays,
      String? billingAddress,
      String? shippingAddress,
      List<String> attachmentUrls,
      String? approvedBy,
      DateTime? approvedAt,
      String? cancelledBy,
      DateTime? cancelledAt,
      String? cancellationReason,
      Map<String, dynamic> metadata,
      List<PurchaseBillPayment> payments,
      String? lastPaymentId,
      DateTime? lastPaymentDate});
}

/// @nodoc
class _$PurchaseBillCopyWithImpl<$Res, $Val extends PurchaseBill>
    implements $PurchaseBillCopyWith<$Res> {
  _$PurchaseBillCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchaseBill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? supplierId = null,
    Object? purchaseOrderId = freezed,
    Object? billNumber = null,
    Object? billDate = null,
    Object? dueDate = freezed,
    Object? status = null,
    Object? totalAmount = null,
    Object? paidAmount = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? supplierBillNumber = freezed,
    Object? referenceNumber = freezed,
    Object? items = null,
    Object? subtotal = freezed,
    Object? taxAmount = freezed,
    Object? discountAmount = freezed,
    Object? discountType = freezed,
    Object? discountValue = freezed,
    Object? shippingAmount = freezed,
    Object? otherCharges = freezed,
    Object? currency = freezed,
    Object? exchangeRate = freezed,
    Object? paymentTerm = null,
    Object? customPaymentDays = freezed,
    Object? billingAddress = freezed,
    Object? shippingAddress = freezed,
    Object? attachmentUrls = null,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
    Object? cancelledBy = freezed,
    Object? cancelledAt = freezed,
    Object? cancellationReason = freezed,
    Object? metadata = null,
    Object? payments = null,
    Object? lastPaymentId = freezed,
    Object? lastPaymentDate = freezed,
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
      purchaseOrderId: freezed == purchaseOrderId
          ? _value.purchaseOrderId
          : purchaseOrderId // ignore: cast_nullable_to_non_nullable
              as String?,
      billNumber: null == billNumber
          ? _value.billNumber
          : billNumber // ignore: cast_nullable_to_non_nullable
              as String,
      billDate: null == billDate
          ? _value.billDate
          : billDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PurchaseBillStatus,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      paidAmount: null == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
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
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      supplierBillNumber: freezed == supplierBillNumber
          ? _value.supplierBillNumber
          : supplierBillNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceNumber: freezed == referenceNumber
          ? _value.referenceNumber
          : referenceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PurchaseBillItem>,
      subtotal: freezed == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double?,
      taxAmount: freezed == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      discountType: freezed == discountType
          ? _value.discountType
          : discountType // ignore: cast_nullable_to_non_nullable
              as String?,
      discountValue: freezed == discountValue
          ? _value.discountValue
          : discountValue // ignore: cast_nullable_to_non_nullable
              as double?,
      shippingAmount: freezed == shippingAmount
          ? _value.shippingAmount
          : shippingAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      otherCharges: freezed == otherCharges
          ? _value.otherCharges
          : otherCharges // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      exchangeRate: freezed == exchangeRate
          ? _value.exchangeRate
          : exchangeRate // ignore: cast_nullable_to_non_nullable
              as double?,
      paymentTerm: null == paymentTerm
          ? _value.paymentTerm
          : paymentTerm // ignore: cast_nullable_to_non_nullable
              as PaymentTerm,
      customPaymentDays: freezed == customPaymentDays
          ? _value.customPaymentDays
          : customPaymentDays // ignore: cast_nullable_to_non_nullable
              as int?,
      billingAddress: freezed == billingAddress
          ? _value.billingAddress
          : billingAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      shippingAddress: freezed == shippingAddress
          ? _value.shippingAddress
          : shippingAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      attachmentUrls: null == attachmentUrls
          ? _value.attachmentUrls
          : attachmentUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledBy: freezed == cancelledBy
          ? _value.cancelledBy
          : cancelledBy // ignore: cast_nullable_to_non_nullable
              as String?,
      cancelledAt: freezed == cancelledAt
          ? _value.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancellationReason: freezed == cancellationReason
          ? _value.cancellationReason
          : cancellationReason // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      payments: null == payments
          ? _value.payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<PurchaseBillPayment>,
      lastPaymentId: freezed == lastPaymentId
          ? _value.lastPaymentId
          : lastPaymentId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastPaymentDate: freezed == lastPaymentDate
          ? _value.lastPaymentDate
          : lastPaymentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PurchaseBillImplCopyWith<$Res>
    implements $PurchaseBillCopyWith<$Res> {
  factory _$$PurchaseBillImplCopyWith(
          _$PurchaseBillImpl value, $Res Function(_$PurchaseBillImpl) then) =
      __$$PurchaseBillImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String supplierId,
      String? purchaseOrderId,
      String billNumber,
      DateTime billDate,
      DateTime? dueDate,
      PurchaseBillStatus status,
      double totalAmount,
      double paidAmount,
      String? notes,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? supplierBillNumber,
      String? referenceNumber,
      List<PurchaseBillItem> items,
      double? subtotal,
      double? taxAmount,
      double? discountAmount,
      String? discountType,
      double? discountValue,
      double? shippingAmount,
      double? otherCharges,
      String? currency,
      double? exchangeRate,
      PaymentTerm paymentTerm,
      int? customPaymentDays,
      String? billingAddress,
      String? shippingAddress,
      List<String> attachmentUrls,
      String? approvedBy,
      DateTime? approvedAt,
      String? cancelledBy,
      DateTime? cancelledAt,
      String? cancellationReason,
      Map<String, dynamic> metadata,
      List<PurchaseBillPayment> payments,
      String? lastPaymentId,
      DateTime? lastPaymentDate});
}

/// @nodoc
class __$$PurchaseBillImplCopyWithImpl<$Res>
    extends _$PurchaseBillCopyWithImpl<$Res, _$PurchaseBillImpl>
    implements _$$PurchaseBillImplCopyWith<$Res> {
  __$$PurchaseBillImplCopyWithImpl(
      _$PurchaseBillImpl _value, $Res Function(_$PurchaseBillImpl) _then)
      : super(_value, _then);

  /// Create a copy of PurchaseBill
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? supplierId = null,
    Object? purchaseOrderId = freezed,
    Object? billNumber = null,
    Object? billDate = null,
    Object? dueDate = freezed,
    Object? status = null,
    Object? totalAmount = null,
    Object? paidAmount = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? supplierBillNumber = freezed,
    Object? referenceNumber = freezed,
    Object? items = null,
    Object? subtotal = freezed,
    Object? taxAmount = freezed,
    Object? discountAmount = freezed,
    Object? discountType = freezed,
    Object? discountValue = freezed,
    Object? shippingAmount = freezed,
    Object? otherCharges = freezed,
    Object? currency = freezed,
    Object? exchangeRate = freezed,
    Object? paymentTerm = null,
    Object? customPaymentDays = freezed,
    Object? billingAddress = freezed,
    Object? shippingAddress = freezed,
    Object? attachmentUrls = null,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
    Object? cancelledBy = freezed,
    Object? cancelledAt = freezed,
    Object? cancellationReason = freezed,
    Object? metadata = null,
    Object? payments = null,
    Object? lastPaymentId = freezed,
    Object? lastPaymentDate = freezed,
  }) {
    return _then(_$PurchaseBillImpl(
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
      purchaseOrderId: freezed == purchaseOrderId
          ? _value.purchaseOrderId
          : purchaseOrderId // ignore: cast_nullable_to_non_nullable
              as String?,
      billNumber: null == billNumber
          ? _value.billNumber
          : billNumber // ignore: cast_nullable_to_non_nullable
              as String,
      billDate: null == billDate
          ? _value.billDate
          : billDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dueDate: freezed == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PurchaseBillStatus,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      paidAmount: null == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
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
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      supplierBillNumber: freezed == supplierBillNumber
          ? _value.supplierBillNumber
          : supplierBillNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceNumber: freezed == referenceNumber
          ? _value.referenceNumber
          : referenceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<PurchaseBillItem>,
      subtotal: freezed == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double?,
      taxAmount: freezed == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      discountType: freezed == discountType
          ? _value.discountType
          : discountType // ignore: cast_nullable_to_non_nullable
              as String?,
      discountValue: freezed == discountValue
          ? _value.discountValue
          : discountValue // ignore: cast_nullable_to_non_nullable
              as double?,
      shippingAmount: freezed == shippingAmount
          ? _value.shippingAmount
          : shippingAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      otherCharges: freezed == otherCharges
          ? _value.otherCharges
          : otherCharges // ignore: cast_nullable_to_non_nullable
              as double?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      exchangeRate: freezed == exchangeRate
          ? _value.exchangeRate
          : exchangeRate // ignore: cast_nullable_to_non_nullable
              as double?,
      paymentTerm: null == paymentTerm
          ? _value.paymentTerm
          : paymentTerm // ignore: cast_nullable_to_non_nullable
              as PaymentTerm,
      customPaymentDays: freezed == customPaymentDays
          ? _value.customPaymentDays
          : customPaymentDays // ignore: cast_nullable_to_non_nullable
              as int?,
      billingAddress: freezed == billingAddress
          ? _value.billingAddress
          : billingAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      shippingAddress: freezed == shippingAddress
          ? _value.shippingAddress
          : shippingAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      attachmentUrls: null == attachmentUrls
          ? _value._attachmentUrls
          : attachmentUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledBy: freezed == cancelledBy
          ? _value.cancelledBy
          : cancelledBy // ignore: cast_nullable_to_non_nullable
              as String?,
      cancelledAt: freezed == cancelledAt
          ? _value.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancellationReason: freezed == cancellationReason
          ? _value.cancellationReason
          : cancellationReason // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      payments: null == payments
          ? _value._payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<PurchaseBillPayment>,
      lastPaymentId: freezed == lastPaymentId
          ? _value.lastPaymentId
          : lastPaymentId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastPaymentDate: freezed == lastPaymentDate
          ? _value.lastPaymentDate
          : lastPaymentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchaseBillImpl extends _PurchaseBill {
  const _$PurchaseBillImpl(
      {required this.id,
      required this.organizationId,
      required this.supplierId,
      this.purchaseOrderId,
      required this.billNumber,
      required this.billDate,
      this.dueDate,
      this.status = PurchaseBillStatus.draft,
      required this.totalAmount,
      this.paidAmount = 0,
      this.notes,
      required this.createdAt,
      required this.updatedAt,
      this.syncedAt,
      this.supplierBillNumber,
      this.referenceNumber,
      final List<PurchaseBillItem> items = const [],
      this.subtotal,
      this.taxAmount,
      this.discountAmount,
      this.discountType,
      this.discountValue,
      this.shippingAmount,
      this.otherCharges,
      this.currency,
      this.exchangeRate,
      this.paymentTerm = PaymentTerm.net30,
      this.customPaymentDays,
      this.billingAddress,
      this.shippingAddress,
      final List<String> attachmentUrls = const [],
      this.approvedBy,
      this.approvedAt,
      this.cancelledBy,
      this.cancelledAt,
      this.cancellationReason,
      final Map<String, dynamic> metadata = const {},
      final List<PurchaseBillPayment> payments = const [],
      this.lastPaymentId,
      this.lastPaymentDate})
      : _items = items,
        _attachmentUrls = attachmentUrls,
        _metadata = metadata,
        _payments = payments,
        super._();

  factory _$PurchaseBillImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseBillImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String supplierId;
  @override
  final String? purchaseOrderId;
  @override
  final String billNumber;
  @override
  final DateTime billDate;
  @override
  final DateTime? dueDate;
  @override
  @JsonKey()
  final PurchaseBillStatus status;
  @override
  final double totalAmount;
  @override
  @JsonKey()
  final double paidAmount;
  @override
  final String? notes;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? syncedAt;
// Additional fields
  @override
  final String? supplierBillNumber;
  @override
  final String? referenceNumber;
  final List<PurchaseBillItem> _items;
  @override
  @JsonKey()
  List<PurchaseBillItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final double? subtotal;
  @override
  final double? taxAmount;
  @override
  final double? discountAmount;
  @override
  final String? discountType;
// 'percentage' or 'fixed'
  @override
  final double? discountValue;
  @override
  final double? shippingAmount;
  @override
  final double? otherCharges;
  @override
  final String? currency;
  @override
  final double? exchangeRate;
  @override
  @JsonKey()
  final PaymentTerm paymentTerm;
  @override
  final int? customPaymentDays;
  @override
  final String? billingAddress;
  @override
  final String? shippingAddress;
  final List<String> _attachmentUrls;
  @override
  @JsonKey()
  List<String> get attachmentUrls {
    if (_attachmentUrls is EqualUnmodifiableListView) return _attachmentUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachmentUrls);
  }

  @override
  final String? approvedBy;
  @override
  final DateTime? approvedAt;
  @override
  final String? cancelledBy;
  @override
  final DateTime? cancelledAt;
  @override
  final String? cancellationReason;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  final List<PurchaseBillPayment> _payments;
  @override
  @JsonKey()
  List<PurchaseBillPayment> get payments {
    if (_payments is EqualUnmodifiableListView) return _payments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payments);
  }

  @override
  final String? lastPaymentId;
  @override
  final DateTime? lastPaymentDate;

  @override
  String toString() {
    return 'PurchaseBill(id: $id, organizationId: $organizationId, supplierId: $supplierId, purchaseOrderId: $purchaseOrderId, billNumber: $billNumber, billDate: $billDate, dueDate: $dueDate, status: $status, totalAmount: $totalAmount, paidAmount: $paidAmount, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt, supplierBillNumber: $supplierBillNumber, referenceNumber: $referenceNumber, items: $items, subtotal: $subtotal, taxAmount: $taxAmount, discountAmount: $discountAmount, discountType: $discountType, discountValue: $discountValue, shippingAmount: $shippingAmount, otherCharges: $otherCharges, currency: $currency, exchangeRate: $exchangeRate, paymentTerm: $paymentTerm, customPaymentDays: $customPaymentDays, billingAddress: $billingAddress, shippingAddress: $shippingAddress, attachmentUrls: $attachmentUrls, approvedBy: $approvedBy, approvedAt: $approvedAt, cancelledBy: $cancelledBy, cancelledAt: $cancelledAt, cancellationReason: $cancellationReason, metadata: $metadata, payments: $payments, lastPaymentId: $lastPaymentId, lastPaymentDate: $lastPaymentDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseBillImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.supplierId, supplierId) ||
                other.supplierId == supplierId) &&
            (identical(other.purchaseOrderId, purchaseOrderId) ||
                other.purchaseOrderId == purchaseOrderId) &&
            (identical(other.billNumber, billNumber) ||
                other.billNumber == billNumber) &&
            (identical(other.billDate, billDate) ||
                other.billDate == billDate) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.supplierBillNumber, supplierBillNumber) ||
                other.supplierBillNumber == supplierBillNumber) &&
            (identical(other.referenceNumber, referenceNumber) ||
                other.referenceNumber == referenceNumber) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.taxAmount, taxAmount) ||
                other.taxAmount == taxAmount) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.discountType, discountType) ||
                other.discountType == discountType) &&
            (identical(other.discountValue, discountValue) ||
                other.discountValue == discountValue) &&
            (identical(other.shippingAmount, shippingAmount) ||
                other.shippingAmount == shippingAmount) &&
            (identical(other.otherCharges, otherCharges) ||
                other.otherCharges == otherCharges) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.exchangeRate, exchangeRate) ||
                other.exchangeRate == exchangeRate) &&
            (identical(other.paymentTerm, paymentTerm) ||
                other.paymentTerm == paymentTerm) &&
            (identical(other.customPaymentDays, customPaymentDays) ||
                other.customPaymentDays == customPaymentDays) &&
            (identical(other.billingAddress, billingAddress) ||
                other.billingAddress == billingAddress) &&
            (identical(other.shippingAddress, shippingAddress) ||
                other.shippingAddress == shippingAddress) &&
            const DeepCollectionEquality()
                .equals(other._attachmentUrls, _attachmentUrls) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.cancelledBy, cancelledBy) ||
                other.cancelledBy == cancelledBy) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.cancellationReason, cancellationReason) ||
                other.cancellationReason == cancellationReason) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            const DeepCollectionEquality().equals(other._payments, _payments) &&
            (identical(other.lastPaymentId, lastPaymentId) ||
                other.lastPaymentId == lastPaymentId) &&
            (identical(other.lastPaymentDate, lastPaymentDate) ||
                other.lastPaymentDate == lastPaymentDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        organizationId,
        supplierId,
        purchaseOrderId,
        billNumber,
        billDate,
        dueDate,
        status,
        totalAmount,
        paidAmount,
        notes,
        createdAt,
        updatedAt,
        syncedAt,
        supplierBillNumber,
        referenceNumber,
        const DeepCollectionEquality().hash(_items),
        subtotal,
        taxAmount,
        discountAmount,
        discountType,
        discountValue,
        shippingAmount,
        otherCharges,
        currency,
        exchangeRate,
        paymentTerm,
        customPaymentDays,
        billingAddress,
        shippingAddress,
        const DeepCollectionEquality().hash(_attachmentUrls),
        approvedBy,
        approvedAt,
        cancelledBy,
        cancelledAt,
        cancellationReason,
        const DeepCollectionEquality().hash(_metadata),
        const DeepCollectionEquality().hash(_payments),
        lastPaymentId,
        lastPaymentDate
      ]);

  /// Create a copy of PurchaseBill
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseBillImplCopyWith<_$PurchaseBillImpl> get copyWith =>
      __$$PurchaseBillImplCopyWithImpl<_$PurchaseBillImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchaseBillImplToJson(
      this,
    );
  }
}

abstract class _PurchaseBill extends PurchaseBill {
  const factory _PurchaseBill(
      {required final String id,
      required final String organizationId,
      required final String supplierId,
      final String? purchaseOrderId,
      required final String billNumber,
      required final DateTime billDate,
      final DateTime? dueDate,
      final PurchaseBillStatus status,
      required final double totalAmount,
      final double paidAmount,
      final String? notes,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final DateTime? syncedAt,
      final String? supplierBillNumber,
      final String? referenceNumber,
      final List<PurchaseBillItem> items,
      final double? subtotal,
      final double? taxAmount,
      final double? discountAmount,
      final String? discountType,
      final double? discountValue,
      final double? shippingAmount,
      final double? otherCharges,
      final String? currency,
      final double? exchangeRate,
      final PaymentTerm paymentTerm,
      final int? customPaymentDays,
      final String? billingAddress,
      final String? shippingAddress,
      final List<String> attachmentUrls,
      final String? approvedBy,
      final DateTime? approvedAt,
      final String? cancelledBy,
      final DateTime? cancelledAt,
      final String? cancellationReason,
      final Map<String, dynamic> metadata,
      final List<PurchaseBillPayment> payments,
      final String? lastPaymentId,
      final DateTime? lastPaymentDate}) = _$PurchaseBillImpl;
  const _PurchaseBill._() : super._();

  factory _PurchaseBill.fromJson(Map<String, dynamic> json) =
      _$PurchaseBillImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String get supplierId;
  @override
  String? get purchaseOrderId;
  @override
  String get billNumber;
  @override
  DateTime get billDate;
  @override
  DateTime? get dueDate;
  @override
  PurchaseBillStatus get status;
  @override
  double get totalAmount;
  @override
  double get paidAmount;
  @override
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get syncedAt; // Additional fields
  @override
  String? get supplierBillNumber;
  @override
  String? get referenceNumber;
  @override
  List<PurchaseBillItem> get items;
  @override
  double? get subtotal;
  @override
  double? get taxAmount;
  @override
  double? get discountAmount;
  @override
  String? get discountType; // 'percentage' or 'fixed'
  @override
  double? get discountValue;
  @override
  double? get shippingAmount;
  @override
  double? get otherCharges;
  @override
  String? get currency;
  @override
  double? get exchangeRate;
  @override
  PaymentTerm get paymentTerm;
  @override
  int? get customPaymentDays;
  @override
  String? get billingAddress;
  @override
  String? get shippingAddress;
  @override
  List<String> get attachmentUrls;
  @override
  String? get approvedBy;
  @override
  DateTime? get approvedAt;
  @override
  String? get cancelledBy;
  @override
  DateTime? get cancelledAt;
  @override
  String? get cancellationReason;
  @override
  Map<String, dynamic> get metadata;
  @override
  List<PurchaseBillPayment> get payments;
  @override
  String? get lastPaymentId;
  @override
  DateTime? get lastPaymentDate;

  /// Create a copy of PurchaseBill
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseBillImplCopyWith<_$PurchaseBillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PurchaseBillItem _$PurchaseBillItemFromJson(Map<String, dynamic> json) {
  return _PurchaseBillItem.fromJson(json);
}

/// @nodoc
mixin _$PurchaseBillItem {
  String get id => throw _privateConstructorUsedError;
  String get billId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  String? get productName => throw _privateConstructorUsedError;
  String? get productSku => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  double get unitPrice => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double? get taxRate => throw _privateConstructorUsedError;
  double? get taxAmount => throw _privateConstructorUsedError;
  double? get discountAmount => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this PurchaseBillItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PurchaseBillItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchaseBillItemCopyWith<PurchaseBillItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseBillItemCopyWith<$Res> {
  factory $PurchaseBillItemCopyWith(
          PurchaseBillItem value, $Res Function(PurchaseBillItem) then) =
      _$PurchaseBillItemCopyWithImpl<$Res, PurchaseBillItem>;
  @useResult
  $Res call(
      {String id,
      String billId,
      String productId,
      String? productName,
      String? productSku,
      double quantity,
      double unitPrice,
      double totalAmount,
      String? description,
      double? taxRate,
      double? taxAmount,
      double? discountAmount,
      String? unit,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$PurchaseBillItemCopyWithImpl<$Res, $Val extends PurchaseBillItem>
    implements $PurchaseBillItemCopyWith<$Res> {
  _$PurchaseBillItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchaseBillItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? billId = null,
    Object? productId = null,
    Object? productName = freezed,
    Object? productSku = freezed,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? totalAmount = null,
    Object? description = freezed,
    Object? taxRate = freezed,
    Object? taxAmount = freezed,
    Object? discountAmount = freezed,
    Object? unit = freezed,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      billId: null == billId
          ? _value.billId
          : billId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      productSku: freezed == productSku
          ? _value.productSku
          : productSku // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      taxRate: freezed == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double?,
      taxAmount: freezed == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PurchaseBillItemImplCopyWith<$Res>
    implements $PurchaseBillItemCopyWith<$Res> {
  factory _$$PurchaseBillItemImplCopyWith(_$PurchaseBillItemImpl value,
          $Res Function(_$PurchaseBillItemImpl) then) =
      __$$PurchaseBillItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String billId,
      String productId,
      String? productName,
      String? productSku,
      double quantity,
      double unitPrice,
      double totalAmount,
      String? description,
      double? taxRate,
      double? taxAmount,
      double? discountAmount,
      String? unit,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$$PurchaseBillItemImplCopyWithImpl<$Res>
    extends _$PurchaseBillItemCopyWithImpl<$Res, _$PurchaseBillItemImpl>
    implements _$$PurchaseBillItemImplCopyWith<$Res> {
  __$$PurchaseBillItemImplCopyWithImpl(_$PurchaseBillItemImpl _value,
      $Res Function(_$PurchaseBillItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of PurchaseBillItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? billId = null,
    Object? productId = null,
    Object? productName = freezed,
    Object? productSku = freezed,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? totalAmount = null,
    Object? description = freezed,
    Object? taxRate = freezed,
    Object? taxAmount = freezed,
    Object? discountAmount = freezed,
    Object? unit = freezed,
    Object? metadata = null,
  }) {
    return _then(_$PurchaseBillItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      billId: null == billId
          ? _value.billId
          : billId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      productSku: freezed == productSku
          ? _value.productSku
          : productSku // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      taxRate: freezed == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double?,
      taxAmount: freezed == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
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
class _$PurchaseBillItemImpl extends _PurchaseBillItem {
  const _$PurchaseBillItemImpl(
      {required this.id,
      required this.billId,
      required this.productId,
      this.productName,
      this.productSku,
      required this.quantity,
      required this.unitPrice,
      required this.totalAmount,
      this.description,
      this.taxRate,
      this.taxAmount,
      this.discountAmount,
      this.unit,
      final Map<String, dynamic> metadata = const {}})
      : _metadata = metadata,
        super._();

  factory _$PurchaseBillItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseBillItemImplFromJson(json);

  @override
  final String id;
  @override
  final String billId;
  @override
  final String productId;
  @override
  final String? productName;
  @override
  final String? productSku;
  @override
  final double quantity;
  @override
  final double unitPrice;
  @override
  final double totalAmount;
  @override
  final String? description;
  @override
  final double? taxRate;
  @override
  final double? taxAmount;
  @override
  final double? discountAmount;
  @override
  final String? unit;
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
    return 'PurchaseBillItem(id: $id, billId: $billId, productId: $productId, productName: $productName, productSku: $productSku, quantity: $quantity, unitPrice: $unitPrice, totalAmount: $totalAmount, description: $description, taxRate: $taxRate, taxAmount: $taxAmount, discountAmount: $discountAmount, unit: $unit, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseBillItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.billId, billId) || other.billId == billId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.productSku, productSku) ||
                other.productSku == productSku) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.taxRate, taxRate) || other.taxRate == taxRate) &&
            (identical(other.taxAmount, taxAmount) ||
                other.taxAmount == taxAmount) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      billId,
      productId,
      productName,
      productSku,
      quantity,
      unitPrice,
      totalAmount,
      description,
      taxRate,
      taxAmount,
      discountAmount,
      unit,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of PurchaseBillItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseBillItemImplCopyWith<_$PurchaseBillItemImpl> get copyWith =>
      __$$PurchaseBillItemImplCopyWithImpl<_$PurchaseBillItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchaseBillItemImplToJson(
      this,
    );
  }
}

abstract class _PurchaseBillItem extends PurchaseBillItem {
  const factory _PurchaseBillItem(
      {required final String id,
      required final String billId,
      required final String productId,
      final String? productName,
      final String? productSku,
      required final double quantity,
      required final double unitPrice,
      required final double totalAmount,
      final String? description,
      final double? taxRate,
      final double? taxAmount,
      final double? discountAmount,
      final String? unit,
      final Map<String, dynamic> metadata}) = _$PurchaseBillItemImpl;
  const _PurchaseBillItem._() : super._();

  factory _PurchaseBillItem.fromJson(Map<String, dynamic> json) =
      _$PurchaseBillItemImpl.fromJson;

  @override
  String get id;
  @override
  String get billId;
  @override
  String get productId;
  @override
  String? get productName;
  @override
  String? get productSku;
  @override
  double get quantity;
  @override
  double get unitPrice;
  @override
  double get totalAmount;
  @override
  String? get description;
  @override
  double? get taxRate;
  @override
  double? get taxAmount;
  @override
  double? get discountAmount;
  @override
  String? get unit;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of PurchaseBillItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseBillItemImplCopyWith<_$PurchaseBillItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PurchaseBillPayment _$PurchaseBillPaymentFromJson(Map<String, dynamic> json) {
  return _PurchaseBillPayment.fromJson(json);
}

/// @nodoc
mixin _$PurchaseBillPayment {
  String get id => throw _privateConstructorUsedError;
  String get billId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  DateTime get paymentDate => throw _privateConstructorUsedError;
  String get paymentMethod => throw _privateConstructorUsedError;
  String? get referenceNumber => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;

  /// Serializes this PurchaseBillPayment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PurchaseBillPayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchaseBillPaymentCopyWith<PurchaseBillPayment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseBillPaymentCopyWith<$Res> {
  factory $PurchaseBillPaymentCopyWith(
          PurchaseBillPayment value, $Res Function(PurchaseBillPayment) then) =
      _$PurchaseBillPaymentCopyWithImpl<$Res, PurchaseBillPayment>;
  @useResult
  $Res call(
      {String id,
      String billId,
      double amount,
      DateTime paymentDate,
      String paymentMethod,
      String? referenceNumber,
      String? notes,
      DateTime createdAt,
      String? createdBy});
}

/// @nodoc
class _$PurchaseBillPaymentCopyWithImpl<$Res, $Val extends PurchaseBillPayment>
    implements $PurchaseBillPaymentCopyWith<$Res> {
  _$PurchaseBillPaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchaseBillPayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? billId = null,
    Object? amount = null,
    Object? paymentDate = null,
    Object? paymentMethod = null,
    Object? referenceNumber = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? createdBy = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      billId: null == billId
          ? _value.billId
          : billId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      paymentDate: null == paymentDate
          ? _value.paymentDate
          : paymentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      referenceNumber: freezed == referenceNumber
          ? _value.referenceNumber
          : referenceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PurchaseBillPaymentImplCopyWith<$Res>
    implements $PurchaseBillPaymentCopyWith<$Res> {
  factory _$$PurchaseBillPaymentImplCopyWith(_$PurchaseBillPaymentImpl value,
          $Res Function(_$PurchaseBillPaymentImpl) then) =
      __$$PurchaseBillPaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String billId,
      double amount,
      DateTime paymentDate,
      String paymentMethod,
      String? referenceNumber,
      String? notes,
      DateTime createdAt,
      String? createdBy});
}

/// @nodoc
class __$$PurchaseBillPaymentImplCopyWithImpl<$Res>
    extends _$PurchaseBillPaymentCopyWithImpl<$Res, _$PurchaseBillPaymentImpl>
    implements _$$PurchaseBillPaymentImplCopyWith<$Res> {
  __$$PurchaseBillPaymentImplCopyWithImpl(_$PurchaseBillPaymentImpl _value,
      $Res Function(_$PurchaseBillPaymentImpl) _then)
      : super(_value, _then);

  /// Create a copy of PurchaseBillPayment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? billId = null,
    Object? amount = null,
    Object? paymentDate = null,
    Object? paymentMethod = null,
    Object? referenceNumber = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? createdBy = freezed,
  }) {
    return _then(_$PurchaseBillPaymentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      billId: null == billId
          ? _value.billId
          : billId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      paymentDate: null == paymentDate
          ? _value.paymentDate
          : paymentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      referenceNumber: freezed == referenceNumber
          ? _value.referenceNumber
          : referenceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchaseBillPaymentImpl implements _PurchaseBillPayment {
  const _$PurchaseBillPaymentImpl(
      {required this.id,
      required this.billId,
      required this.amount,
      required this.paymentDate,
      required this.paymentMethod,
      this.referenceNumber,
      this.notes,
      required this.createdAt,
      this.createdBy});

  factory _$PurchaseBillPaymentImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseBillPaymentImplFromJson(json);

  @override
  final String id;
  @override
  final String billId;
  @override
  final double amount;
  @override
  final DateTime paymentDate;
  @override
  final String paymentMethod;
  @override
  final String? referenceNumber;
  @override
  final String? notes;
  @override
  final DateTime createdAt;
  @override
  final String? createdBy;

  @override
  String toString() {
    return 'PurchaseBillPayment(id: $id, billId: $billId, amount: $amount, paymentDate: $paymentDate, paymentMethod: $paymentMethod, referenceNumber: $referenceNumber, notes: $notes, createdAt: $createdAt, createdBy: $createdBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseBillPaymentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.billId, billId) || other.billId == billId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.paymentDate, paymentDate) ||
                other.paymentDate == paymentDate) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.referenceNumber, referenceNumber) ||
                other.referenceNumber == referenceNumber) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, billId, amount, paymentDate,
      paymentMethod, referenceNumber, notes, createdAt, createdBy);

  /// Create a copy of PurchaseBillPayment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseBillPaymentImplCopyWith<_$PurchaseBillPaymentImpl> get copyWith =>
      __$$PurchaseBillPaymentImplCopyWithImpl<_$PurchaseBillPaymentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchaseBillPaymentImplToJson(
      this,
    );
  }
}

abstract class _PurchaseBillPayment implements PurchaseBillPayment {
  const factory _PurchaseBillPayment(
      {required final String id,
      required final String billId,
      required final double amount,
      required final DateTime paymentDate,
      required final String paymentMethod,
      final String? referenceNumber,
      final String? notes,
      required final DateTime createdAt,
      final String? createdBy}) = _$PurchaseBillPaymentImpl;

  factory _PurchaseBillPayment.fromJson(Map<String, dynamic> json) =
      _$PurchaseBillPaymentImpl.fromJson;

  @override
  String get id;
  @override
  String get billId;
  @override
  double get amount;
  @override
  DateTime get paymentDate;
  @override
  String get paymentMethod;
  @override
  String? get referenceNumber;
  @override
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  String? get createdBy;

  /// Create a copy of PurchaseBillPayment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseBillPaymentImplCopyWith<_$PurchaseBillPaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
