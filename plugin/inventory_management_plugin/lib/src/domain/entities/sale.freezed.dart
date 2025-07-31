// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Sale _$SaleFromJson(Map<String, dynamic> json) {
  return _Sale.fromJson(json);
}

/// @nodoc
mixin _$Sale {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String? get branchId => throw _privateConstructorUsedError;
  String? get registerId => throw _privateConstructorUsedError;
  String get saleNumber => throw _privateConstructorUsedError;
  String? get customerId => throw _privateConstructorUsedError;
  DateTime get saleDate => throw _privateConstructorUsedError;
  double get subtotal => throw _privateConstructorUsedError;
  double get taxAmount => throw _privateConstructorUsedError;
  double get discountAmount => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  double get paidAmount => throw _privateConstructorUsedError;
  double get changeAmount => throw _privateConstructorUsedError;
  String get paymentStatus => throw _privateConstructorUsedError;
  Map<String, double>? get paymentMethods =>
      throw _privateConstructorUsedError; // {"cash": 50, "card": 30}
  String? get notes => throw _privateConstructorUsedError;
  String get cashierId => throw _privateConstructorUsedError;
  bool get voided => throw _privateConstructorUsedError;
  String? get voidedBy => throw _privateConstructorUsedError;
  DateTime? get voidedAt => throw _privateConstructorUsedError;
  String? get voidReason => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional fields for plugin
  List<SaleItem> get items => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get invoiceNumber => throw _privateConstructorUsedError;
  String? get referenceNumber => throw _privateConstructorUsedError;
  bool get isReturn => throw _privateConstructorUsedError;
  String? get originalSaleId => throw _privateConstructorUsedError;
  bool get isOffline => throw _privateConstructorUsedError;
  String? get shippingAddress => throw _privateConstructorUsedError;
  double get shippingCost => throw _privateConstructorUsedError;
  String? get couponCode => throw _privateConstructorUsedError;
  double get couponDiscount => throw _privateConstructorUsedError;
  int get loyaltyPointsEarned => throw _privateConstructorUsedError;
  int get loyaltyPointsRedeemed => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  String? get salesPersonId => throw _privateConstructorUsedError;
  double get tipAmount => throw _privateConstructorUsedError;
  double get serviceCharge => throw _privateConstructorUsedError;

  /// Serializes this Sale to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleCopyWith<Sale> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleCopyWith<$Res> {
  factory $SaleCopyWith(Sale value, $Res Function(Sale) then) =
      _$SaleCopyWithImpl<$Res, Sale>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String? branchId,
      String? registerId,
      String saleNumber,
      String? customerId,
      DateTime saleDate,
      double subtotal,
      double taxAmount,
      double discountAmount,
      double totalAmount,
      double paidAmount,
      double changeAmount,
      String paymentStatus,
      Map<String, double>? paymentMethods,
      String? notes,
      String cashierId,
      bool voided,
      String? voidedBy,
      DateTime? voidedAt,
      String? voidReason,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      List<SaleItem> items,
      String status,
      String? invoiceNumber,
      String? referenceNumber,
      bool isReturn,
      String? originalSaleId,
      bool isOffline,
      String? shippingAddress,
      double shippingCost,
      String? couponCode,
      double couponDiscount,
      int loyaltyPointsEarned,
      int loyaltyPointsRedeemed,
      Map<String, dynamic> metadata,
      String? salesPersonId,
      double tipAmount,
      double serviceCharge});
}

/// @nodoc
class _$SaleCopyWithImpl<$Res, $Val extends Sale>
    implements $SaleCopyWith<$Res> {
  _$SaleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? branchId = freezed,
    Object? registerId = freezed,
    Object? saleNumber = null,
    Object? customerId = freezed,
    Object? saleDate = null,
    Object? subtotal = null,
    Object? taxAmount = null,
    Object? discountAmount = null,
    Object? totalAmount = null,
    Object? paidAmount = null,
    Object? changeAmount = null,
    Object? paymentStatus = null,
    Object? paymentMethods = freezed,
    Object? notes = freezed,
    Object? cashierId = null,
    Object? voided = null,
    Object? voidedBy = freezed,
    Object? voidedAt = freezed,
    Object? voidReason = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? items = null,
    Object? status = null,
    Object? invoiceNumber = freezed,
    Object? referenceNumber = freezed,
    Object? isReturn = null,
    Object? originalSaleId = freezed,
    Object? isOffline = null,
    Object? shippingAddress = freezed,
    Object? shippingCost = null,
    Object? couponCode = freezed,
    Object? couponDiscount = null,
    Object? loyaltyPointsEarned = null,
    Object? loyaltyPointsRedeemed = null,
    Object? metadata = null,
    Object? salesPersonId = freezed,
    Object? tipAmount = null,
    Object? serviceCharge = null,
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
      branchId: freezed == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as String?,
      registerId: freezed == registerId
          ? _value.registerId
          : registerId // ignore: cast_nullable_to_non_nullable
              as String?,
      saleNumber: null == saleNumber
          ? _value.saleNumber
          : saleNumber // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String?,
      saleDate: null == saleDate
          ? _value.saleDate
          : saleDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
      taxAmount: null == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      paidAmount: null == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as double,
      changeAmount: null == changeAmount
          ? _value.changeAmount
          : changeAmount // ignore: cast_nullable_to_non_nullable
              as double,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethods: freezed == paymentMethods
          ? _value.paymentMethods
          : paymentMethods // ignore: cast_nullable_to_non_nullable
              as Map<String, double>?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      cashierId: null == cashierId
          ? _value.cashierId
          : cashierId // ignore: cast_nullable_to_non_nullable
              as String,
      voided: null == voided
          ? _value.voided
          : voided // ignore: cast_nullable_to_non_nullable
              as bool,
      voidedBy: freezed == voidedBy
          ? _value.voidedBy
          : voidedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      voidedAt: freezed == voidedAt
          ? _value.voidedAt
          : voidedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      voidReason: freezed == voidReason
          ? _value.voidReason
          : voidReason // ignore: cast_nullable_to_non_nullable
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
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SaleItem>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceNumber: freezed == invoiceNumber
          ? _value.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceNumber: freezed == referenceNumber
          ? _value.referenceNumber
          : referenceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      isReturn: null == isReturn
          ? _value.isReturn
          : isReturn // ignore: cast_nullable_to_non_nullable
              as bool,
      originalSaleId: freezed == originalSaleId
          ? _value.originalSaleId
          : originalSaleId // ignore: cast_nullable_to_non_nullable
              as String?,
      isOffline: null == isOffline
          ? _value.isOffline
          : isOffline // ignore: cast_nullable_to_non_nullable
              as bool,
      shippingAddress: freezed == shippingAddress
          ? _value.shippingAddress
          : shippingAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      shippingCost: null == shippingCost
          ? _value.shippingCost
          : shippingCost // ignore: cast_nullable_to_non_nullable
              as double,
      couponCode: freezed == couponCode
          ? _value.couponCode
          : couponCode // ignore: cast_nullable_to_non_nullable
              as String?,
      couponDiscount: null == couponDiscount
          ? _value.couponDiscount
          : couponDiscount // ignore: cast_nullable_to_non_nullable
              as double,
      loyaltyPointsEarned: null == loyaltyPointsEarned
          ? _value.loyaltyPointsEarned
          : loyaltyPointsEarned // ignore: cast_nullable_to_non_nullable
              as int,
      loyaltyPointsRedeemed: null == loyaltyPointsRedeemed
          ? _value.loyaltyPointsRedeemed
          : loyaltyPointsRedeemed // ignore: cast_nullable_to_non_nullable
              as int,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      salesPersonId: freezed == salesPersonId
          ? _value.salesPersonId
          : salesPersonId // ignore: cast_nullable_to_non_nullable
              as String?,
      tipAmount: null == tipAmount
          ? _value.tipAmount
          : tipAmount // ignore: cast_nullable_to_non_nullable
              as double,
      serviceCharge: null == serviceCharge
          ? _value.serviceCharge
          : serviceCharge // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SaleImplCopyWith<$Res> implements $SaleCopyWith<$Res> {
  factory _$$SaleImplCopyWith(
          _$SaleImpl value, $Res Function(_$SaleImpl) then) =
      __$$SaleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String? branchId,
      String? registerId,
      String saleNumber,
      String? customerId,
      DateTime saleDate,
      double subtotal,
      double taxAmount,
      double discountAmount,
      double totalAmount,
      double paidAmount,
      double changeAmount,
      String paymentStatus,
      Map<String, double>? paymentMethods,
      String? notes,
      String cashierId,
      bool voided,
      String? voidedBy,
      DateTime? voidedAt,
      String? voidReason,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      List<SaleItem> items,
      String status,
      String? invoiceNumber,
      String? referenceNumber,
      bool isReturn,
      String? originalSaleId,
      bool isOffline,
      String? shippingAddress,
      double shippingCost,
      String? couponCode,
      double couponDiscount,
      int loyaltyPointsEarned,
      int loyaltyPointsRedeemed,
      Map<String, dynamic> metadata,
      String? salesPersonId,
      double tipAmount,
      double serviceCharge});
}

/// @nodoc
class __$$SaleImplCopyWithImpl<$Res>
    extends _$SaleCopyWithImpl<$Res, _$SaleImpl>
    implements _$$SaleImplCopyWith<$Res> {
  __$$SaleImplCopyWithImpl(_$SaleImpl _value, $Res Function(_$SaleImpl) _then)
      : super(_value, _then);

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? branchId = freezed,
    Object? registerId = freezed,
    Object? saleNumber = null,
    Object? customerId = freezed,
    Object? saleDate = null,
    Object? subtotal = null,
    Object? taxAmount = null,
    Object? discountAmount = null,
    Object? totalAmount = null,
    Object? paidAmount = null,
    Object? changeAmount = null,
    Object? paymentStatus = null,
    Object? paymentMethods = freezed,
    Object? notes = freezed,
    Object? cashierId = null,
    Object? voided = null,
    Object? voidedBy = freezed,
    Object? voidedAt = freezed,
    Object? voidReason = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? items = null,
    Object? status = null,
    Object? invoiceNumber = freezed,
    Object? referenceNumber = freezed,
    Object? isReturn = null,
    Object? originalSaleId = freezed,
    Object? isOffline = null,
    Object? shippingAddress = freezed,
    Object? shippingCost = null,
    Object? couponCode = freezed,
    Object? couponDiscount = null,
    Object? loyaltyPointsEarned = null,
    Object? loyaltyPointsRedeemed = null,
    Object? metadata = null,
    Object? salesPersonId = freezed,
    Object? tipAmount = null,
    Object? serviceCharge = null,
  }) {
    return _then(_$SaleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      branchId: freezed == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as String?,
      registerId: freezed == registerId
          ? _value.registerId
          : registerId // ignore: cast_nullable_to_non_nullable
              as String?,
      saleNumber: null == saleNumber
          ? _value.saleNumber
          : saleNumber // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String?,
      saleDate: null == saleDate
          ? _value.saleDate
          : saleDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
      taxAmount: null == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      paidAmount: null == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as double,
      changeAmount: null == changeAmount
          ? _value.changeAmount
          : changeAmount // ignore: cast_nullable_to_non_nullable
              as double,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethods: freezed == paymentMethods
          ? _value._paymentMethods
          : paymentMethods // ignore: cast_nullable_to_non_nullable
              as Map<String, double>?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      cashierId: null == cashierId
          ? _value.cashierId
          : cashierId // ignore: cast_nullable_to_non_nullable
              as String,
      voided: null == voided
          ? _value.voided
          : voided // ignore: cast_nullable_to_non_nullable
              as bool,
      voidedBy: freezed == voidedBy
          ? _value.voidedBy
          : voidedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      voidedAt: freezed == voidedAt
          ? _value.voidedAt
          : voidedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      voidReason: freezed == voidReason
          ? _value.voidReason
          : voidReason // ignore: cast_nullable_to_non_nullable
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
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SaleItem>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceNumber: freezed == invoiceNumber
          ? _value.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceNumber: freezed == referenceNumber
          ? _value.referenceNumber
          : referenceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      isReturn: null == isReturn
          ? _value.isReturn
          : isReturn // ignore: cast_nullable_to_non_nullable
              as bool,
      originalSaleId: freezed == originalSaleId
          ? _value.originalSaleId
          : originalSaleId // ignore: cast_nullable_to_non_nullable
              as String?,
      isOffline: null == isOffline
          ? _value.isOffline
          : isOffline // ignore: cast_nullable_to_non_nullable
              as bool,
      shippingAddress: freezed == shippingAddress
          ? _value.shippingAddress
          : shippingAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      shippingCost: null == shippingCost
          ? _value.shippingCost
          : shippingCost // ignore: cast_nullable_to_non_nullable
              as double,
      couponCode: freezed == couponCode
          ? _value.couponCode
          : couponCode // ignore: cast_nullable_to_non_nullable
              as String?,
      couponDiscount: null == couponDiscount
          ? _value.couponDiscount
          : couponDiscount // ignore: cast_nullable_to_non_nullable
              as double,
      loyaltyPointsEarned: null == loyaltyPointsEarned
          ? _value.loyaltyPointsEarned
          : loyaltyPointsEarned // ignore: cast_nullable_to_non_nullable
              as int,
      loyaltyPointsRedeemed: null == loyaltyPointsRedeemed
          ? _value.loyaltyPointsRedeemed
          : loyaltyPointsRedeemed // ignore: cast_nullable_to_non_nullable
              as int,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      salesPersonId: freezed == salesPersonId
          ? _value.salesPersonId
          : salesPersonId // ignore: cast_nullable_to_non_nullable
              as String?,
      tipAmount: null == tipAmount
          ? _value.tipAmount
          : tipAmount // ignore: cast_nullable_to_non_nullable
              as double,
      serviceCharge: null == serviceCharge
          ? _value.serviceCharge
          : serviceCharge // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleImpl extends _Sale {
  const _$SaleImpl(
      {required this.id,
      required this.organizationId,
      this.branchId,
      this.registerId,
      required this.saleNumber,
      this.customerId,
      required this.saleDate,
      required this.subtotal,
      this.taxAmount = 0,
      this.discountAmount = 0,
      required this.totalAmount,
      this.paidAmount = 0,
      this.changeAmount = 0,
      this.paymentStatus = 'pending',
      final Map<String, double>? paymentMethods,
      this.notes,
      required this.cashierId,
      this.voided = false,
      this.voidedBy,
      this.voidedAt,
      this.voidReason,
      required this.createdAt,
      required this.updatedAt,
      this.syncedAt,
      final List<SaleItem> items = const [],
      this.status = 'completed',
      this.invoiceNumber,
      this.referenceNumber,
      this.isReturn = false,
      this.originalSaleId,
      this.isOffline = false,
      this.shippingAddress,
      this.shippingCost = 0,
      this.couponCode,
      this.couponDiscount = 0,
      this.loyaltyPointsEarned = 0,
      this.loyaltyPointsRedeemed = 0,
      final Map<String, dynamic> metadata = const {},
      this.salesPersonId,
      this.tipAmount = 0,
      this.serviceCharge = 0})
      : _paymentMethods = paymentMethods,
        _items = items,
        _metadata = metadata,
        super._();

  factory _$SaleImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String? branchId;
  @override
  final String? registerId;
  @override
  final String saleNumber;
  @override
  final String? customerId;
  @override
  final DateTime saleDate;
  @override
  final double subtotal;
  @override
  @JsonKey()
  final double taxAmount;
  @override
  @JsonKey()
  final double discountAmount;
  @override
  final double totalAmount;
  @override
  @JsonKey()
  final double paidAmount;
  @override
  @JsonKey()
  final double changeAmount;
  @override
  @JsonKey()
  final String paymentStatus;
  final Map<String, double>? _paymentMethods;
  @override
  Map<String, double>? get paymentMethods {
    final value = _paymentMethods;
    if (value == null) return null;
    if (_paymentMethods is EqualUnmodifiableMapView) return _paymentMethods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

// {"cash": 50, "card": 30}
  @override
  final String? notes;
  @override
  final String cashierId;
  @override
  @JsonKey()
  final bool voided;
  @override
  final String? voidedBy;
  @override
  final DateTime? voidedAt;
  @override
  final String? voidReason;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? syncedAt;
// Additional fields for plugin
  final List<SaleItem> _items;
// Additional fields for plugin
  @override
  @JsonKey()
  List<SaleItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final String status;
  @override
  final String? invoiceNumber;
  @override
  final String? referenceNumber;
  @override
  @JsonKey()
  final bool isReturn;
  @override
  final String? originalSaleId;
  @override
  @JsonKey()
  final bool isOffline;
  @override
  final String? shippingAddress;
  @override
  @JsonKey()
  final double shippingCost;
  @override
  final String? couponCode;
  @override
  @JsonKey()
  final double couponDiscount;
  @override
  @JsonKey()
  final int loyaltyPointsEarned;
  @override
  @JsonKey()
  final int loyaltyPointsRedeemed;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  final String? salesPersonId;
  @override
  @JsonKey()
  final double tipAmount;
  @override
  @JsonKey()
  final double serviceCharge;

  @override
  String toString() {
    return 'Sale(id: $id, organizationId: $organizationId, branchId: $branchId, registerId: $registerId, saleNumber: $saleNumber, customerId: $customerId, saleDate: $saleDate, subtotal: $subtotal, taxAmount: $taxAmount, discountAmount: $discountAmount, totalAmount: $totalAmount, paidAmount: $paidAmount, changeAmount: $changeAmount, paymentStatus: $paymentStatus, paymentMethods: $paymentMethods, notes: $notes, cashierId: $cashierId, voided: $voided, voidedBy: $voidedBy, voidedAt: $voidedAt, voidReason: $voidReason, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt, items: $items, status: $status, invoiceNumber: $invoiceNumber, referenceNumber: $referenceNumber, isReturn: $isReturn, originalSaleId: $originalSaleId, isOffline: $isOffline, shippingAddress: $shippingAddress, shippingCost: $shippingCost, couponCode: $couponCode, couponDiscount: $couponDiscount, loyaltyPointsEarned: $loyaltyPointsEarned, loyaltyPointsRedeemed: $loyaltyPointsRedeemed, metadata: $metadata, salesPersonId: $salesPersonId, tipAmount: $tipAmount, serviceCharge: $serviceCharge)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.branchId, branchId) ||
                other.branchId == branchId) &&
            (identical(other.registerId, registerId) ||
                other.registerId == registerId) &&
            (identical(other.saleNumber, saleNumber) ||
                other.saleNumber == saleNumber) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.saleDate, saleDate) ||
                other.saleDate == saleDate) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.taxAmount, taxAmount) ||
                other.taxAmount == taxAmount) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.changeAmount, changeAmount) ||
                other.changeAmount == changeAmount) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            const DeepCollectionEquality()
                .equals(other._paymentMethods, _paymentMethods) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.cashierId, cashierId) ||
                other.cashierId == cashierId) &&
            (identical(other.voided, voided) || other.voided == voided) &&
            (identical(other.voidedBy, voidedBy) ||
                other.voidedBy == voidedBy) &&
            (identical(other.voidedAt, voidedAt) ||
                other.voidedAt == voidedAt) &&
            (identical(other.voidReason, voidReason) ||
                other.voidReason == voidReason) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.invoiceNumber, invoiceNumber) ||
                other.invoiceNumber == invoiceNumber) &&
            (identical(other.referenceNumber, referenceNumber) ||
                other.referenceNumber == referenceNumber) &&
            (identical(other.isReturn, isReturn) ||
                other.isReturn == isReturn) &&
            (identical(other.originalSaleId, originalSaleId) ||
                other.originalSaleId == originalSaleId) &&
            (identical(other.isOffline, isOffline) ||
                other.isOffline == isOffline) &&
            (identical(other.shippingAddress, shippingAddress) ||
                other.shippingAddress == shippingAddress) &&
            (identical(other.shippingCost, shippingCost) ||
                other.shippingCost == shippingCost) &&
            (identical(other.couponCode, couponCode) ||
                other.couponCode == couponCode) &&
            (identical(other.couponDiscount, couponDiscount) ||
                other.couponDiscount == couponDiscount) &&
            (identical(other.loyaltyPointsEarned, loyaltyPointsEarned) ||
                other.loyaltyPointsEarned == loyaltyPointsEarned) &&
            (identical(other.loyaltyPointsRedeemed, loyaltyPointsRedeemed) ||
                other.loyaltyPointsRedeemed == loyaltyPointsRedeemed) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.salesPersonId, salesPersonId) ||
                other.salesPersonId == salesPersonId) &&
            (identical(other.tipAmount, tipAmount) ||
                other.tipAmount == tipAmount) &&
            (identical(other.serviceCharge, serviceCharge) ||
                other.serviceCharge == serviceCharge));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        organizationId,
        branchId,
        registerId,
        saleNumber,
        customerId,
        saleDate,
        subtotal,
        taxAmount,
        discountAmount,
        totalAmount,
        paidAmount,
        changeAmount,
        paymentStatus,
        const DeepCollectionEquality().hash(_paymentMethods),
        notes,
        cashierId,
        voided,
        voidedBy,
        voidedAt,
        voidReason,
        createdAt,
        updatedAt,
        syncedAt,
        const DeepCollectionEquality().hash(_items),
        status,
        invoiceNumber,
        referenceNumber,
        isReturn,
        originalSaleId,
        isOffline,
        shippingAddress,
        shippingCost,
        couponCode,
        couponDiscount,
        loyaltyPointsEarned,
        loyaltyPointsRedeemed,
        const DeepCollectionEquality().hash(_metadata),
        salesPersonId,
        tipAmount,
        serviceCharge
      ]);

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleImplCopyWith<_$SaleImpl> get copyWith =>
      __$$SaleImplCopyWithImpl<_$SaleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleImplToJson(
      this,
    );
  }
}

abstract class _Sale extends Sale {
  const factory _Sale(
      {required final String id,
      required final String organizationId,
      final String? branchId,
      final String? registerId,
      required final String saleNumber,
      final String? customerId,
      required final DateTime saleDate,
      required final double subtotal,
      final double taxAmount,
      final double discountAmount,
      required final double totalAmount,
      final double paidAmount,
      final double changeAmount,
      final String paymentStatus,
      final Map<String, double>? paymentMethods,
      final String? notes,
      required final String cashierId,
      final bool voided,
      final String? voidedBy,
      final DateTime? voidedAt,
      final String? voidReason,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final DateTime? syncedAt,
      final List<SaleItem> items,
      final String status,
      final String? invoiceNumber,
      final String? referenceNumber,
      final bool isReturn,
      final String? originalSaleId,
      final bool isOffline,
      final String? shippingAddress,
      final double shippingCost,
      final String? couponCode,
      final double couponDiscount,
      final int loyaltyPointsEarned,
      final int loyaltyPointsRedeemed,
      final Map<String, dynamic> metadata,
      final String? salesPersonId,
      final double tipAmount,
      final double serviceCharge}) = _$SaleImpl;
  const _Sale._() : super._();

  factory _Sale.fromJson(Map<String, dynamic> json) = _$SaleImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String? get branchId;
  @override
  String? get registerId;
  @override
  String get saleNumber;
  @override
  String? get customerId;
  @override
  DateTime get saleDate;
  @override
  double get subtotal;
  @override
  double get taxAmount;
  @override
  double get discountAmount;
  @override
  double get totalAmount;
  @override
  double get paidAmount;
  @override
  double get changeAmount;
  @override
  String get paymentStatus;
  @override
  Map<String, double>? get paymentMethods; // {"cash": 50, "card": 30}
  @override
  String? get notes;
  @override
  String get cashierId;
  @override
  bool get voided;
  @override
  String? get voidedBy;
  @override
  DateTime? get voidedAt;
  @override
  String? get voidReason;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get syncedAt; // Additional fields for plugin
  @override
  List<SaleItem> get items;
  @override
  String get status;
  @override
  String? get invoiceNumber;
  @override
  String? get referenceNumber;
  @override
  bool get isReturn;
  @override
  String? get originalSaleId;
  @override
  bool get isOffline;
  @override
  String? get shippingAddress;
  @override
  double get shippingCost;
  @override
  String? get couponCode;
  @override
  double get couponDiscount;
  @override
  int get loyaltyPointsEarned;
  @override
  int get loyaltyPointsRedeemed;
  @override
  Map<String, dynamic> get metadata;
  @override
  String? get salesPersonId;
  @override
  double get tipAmount;
  @override
  double get serviceCharge;

  /// Create a copy of Sale
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleImplCopyWith<_$SaleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SaleItem _$SaleItemFromJson(Map<String, dynamic> json) {
  return _SaleItem.fromJson(json);
}

/// @nodoc
mixin _$SaleItem {
  String get id => throw _privateConstructorUsedError;
  String get saleId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  double get quantity => throw _privateConstructorUsedError;
  double get unitPrice => throw _privateConstructorUsedError;
  double? get costPrice => throw _privateConstructorUsedError;
  double get discountRate => throw _privateConstructorUsedError;
  double get discountAmount => throw _privateConstructorUsedError;
  double get taxRate => throw _privateConstructorUsedError;
  double get taxAmount => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional fields for plugin
  String get productName => throw _privateConstructorUsedError;
  String? get productSku => throw _privateConstructorUsedError;
  String? get productBarcode => throw _privateConstructorUsedError;
  String? get variantId => throw _privateConstructorUsedError;
  String? get variantName => throw _privateConstructorUsedError;
  String? get unitOfMeasure => throw _privateConstructorUsedError;
  String? get serialNumber => throw _privateConstructorUsedError;
  String? get batchNumber => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  bool get isReturn => throw _privateConstructorUsedError;
  double? get returnQuantity => throw _privateConstructorUsedError;
  String? get returnReason => throw _privateConstructorUsedError;

  /// Serializes this SaleItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleItemCopyWith<SaleItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleItemCopyWith<$Res> {
  factory $SaleItemCopyWith(SaleItem value, $Res Function(SaleItem) then) =
      _$SaleItemCopyWithImpl<$Res, SaleItem>;
  @useResult
  $Res call(
      {String id,
      String saleId,
      String productId,
      double quantity,
      double unitPrice,
      double? costPrice,
      double discountRate,
      double discountAmount,
      double taxRate,
      double taxAmount,
      double totalAmount,
      String? notes,
      DateTime createdAt,
      DateTime? syncedAt,
      String productName,
      String? productSku,
      String? productBarcode,
      String? variantId,
      String? variantName,
      String? unitOfMeasure,
      String? serialNumber,
      String? batchNumber,
      Map<String, dynamic> metadata,
      bool isReturn,
      double? returnQuantity,
      String? returnReason});
}

/// @nodoc
class _$SaleItemCopyWithImpl<$Res, $Val extends SaleItem>
    implements $SaleItemCopyWith<$Res> {
  _$SaleItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? saleId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? costPrice = freezed,
    Object? discountRate = null,
    Object? discountAmount = null,
    Object? taxRate = null,
    Object? taxAmount = null,
    Object? totalAmount = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? syncedAt = freezed,
    Object? productName = null,
    Object? productSku = freezed,
    Object? productBarcode = freezed,
    Object? variantId = freezed,
    Object? variantName = freezed,
    Object? unitOfMeasure = freezed,
    Object? serialNumber = freezed,
    Object? batchNumber = freezed,
    Object? metadata = null,
    Object? isReturn = null,
    Object? returnQuantity = freezed,
    Object? returnReason = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      saleId: null == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      costPrice: freezed == costPrice
          ? _value.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      discountRate: null == discountRate
          ? _value.discountRate
          : discountRate // ignore: cast_nullable_to_non_nullable
              as double,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double,
      taxRate: null == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double,
      taxAmount: null == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
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
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      productSku: freezed == productSku
          ? _value.productSku
          : productSku // ignore: cast_nullable_to_non_nullable
              as String?,
      productBarcode: freezed == productBarcode
          ? _value.productBarcode
          : productBarcode // ignore: cast_nullable_to_non_nullable
              as String?,
      variantId: freezed == variantId
          ? _value.variantId
          : variantId // ignore: cast_nullable_to_non_nullable
              as String?,
      variantName: freezed == variantName
          ? _value.variantName
          : variantName // ignore: cast_nullable_to_non_nullable
              as String?,
      unitOfMeasure: freezed == unitOfMeasure
          ? _value.unitOfMeasure
          : unitOfMeasure // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      batchNumber: freezed == batchNumber
          ? _value.batchNumber
          : batchNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isReturn: null == isReturn
          ? _value.isReturn
          : isReturn // ignore: cast_nullable_to_non_nullable
              as bool,
      returnQuantity: freezed == returnQuantity
          ? _value.returnQuantity
          : returnQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      returnReason: freezed == returnReason
          ? _value.returnReason
          : returnReason // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SaleItemImplCopyWith<$Res>
    implements $SaleItemCopyWith<$Res> {
  factory _$$SaleItemImplCopyWith(
          _$SaleItemImpl value, $Res Function(_$SaleItemImpl) then) =
      __$$SaleItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String saleId,
      String productId,
      double quantity,
      double unitPrice,
      double? costPrice,
      double discountRate,
      double discountAmount,
      double taxRate,
      double taxAmount,
      double totalAmount,
      String? notes,
      DateTime createdAt,
      DateTime? syncedAt,
      String productName,
      String? productSku,
      String? productBarcode,
      String? variantId,
      String? variantName,
      String? unitOfMeasure,
      String? serialNumber,
      String? batchNumber,
      Map<String, dynamic> metadata,
      bool isReturn,
      double? returnQuantity,
      String? returnReason});
}

/// @nodoc
class __$$SaleItemImplCopyWithImpl<$Res>
    extends _$SaleItemCopyWithImpl<$Res, _$SaleItemImpl>
    implements _$$SaleItemImplCopyWith<$Res> {
  __$$SaleItemImplCopyWithImpl(
      _$SaleItemImpl _value, $Res Function(_$SaleItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of SaleItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? saleId = null,
    Object? productId = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? costPrice = freezed,
    Object? discountRate = null,
    Object? discountAmount = null,
    Object? taxRate = null,
    Object? taxAmount = null,
    Object? totalAmount = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? syncedAt = freezed,
    Object? productName = null,
    Object? productSku = freezed,
    Object? productBarcode = freezed,
    Object? variantId = freezed,
    Object? variantName = freezed,
    Object? unitOfMeasure = freezed,
    Object? serialNumber = freezed,
    Object? batchNumber = freezed,
    Object? metadata = null,
    Object? isReturn = null,
    Object? returnQuantity = freezed,
    Object? returnReason = freezed,
  }) {
    return _then(_$SaleItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      saleId: null == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      costPrice: freezed == costPrice
          ? _value.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      discountRate: null == discountRate
          ? _value.discountRate
          : discountRate // ignore: cast_nullable_to_non_nullable
              as double,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double,
      taxRate: null == taxRate
          ? _value.taxRate
          : taxRate // ignore: cast_nullable_to_non_nullable
              as double,
      taxAmount: null == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
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
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      productSku: freezed == productSku
          ? _value.productSku
          : productSku // ignore: cast_nullable_to_non_nullable
              as String?,
      productBarcode: freezed == productBarcode
          ? _value.productBarcode
          : productBarcode // ignore: cast_nullable_to_non_nullable
              as String?,
      variantId: freezed == variantId
          ? _value.variantId
          : variantId // ignore: cast_nullable_to_non_nullable
              as String?,
      variantName: freezed == variantName
          ? _value.variantName
          : variantName // ignore: cast_nullable_to_non_nullable
              as String?,
      unitOfMeasure: freezed == unitOfMeasure
          ? _value.unitOfMeasure
          : unitOfMeasure // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      batchNumber: freezed == batchNumber
          ? _value.batchNumber
          : batchNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      isReturn: null == isReturn
          ? _value.isReturn
          : isReturn // ignore: cast_nullable_to_non_nullable
              as bool,
      returnQuantity: freezed == returnQuantity
          ? _value.returnQuantity
          : returnQuantity // ignore: cast_nullable_to_non_nullable
              as double?,
      returnReason: freezed == returnReason
          ? _value.returnReason
          : returnReason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleItemImpl extends _SaleItem {
  const _$SaleItemImpl(
      {required this.id,
      required this.saleId,
      required this.productId,
      required this.quantity,
      required this.unitPrice,
      this.costPrice,
      this.discountRate = 0,
      this.discountAmount = 0,
      this.taxRate = 0,
      this.taxAmount = 0,
      required this.totalAmount,
      this.notes,
      required this.createdAt,
      this.syncedAt,
      required this.productName,
      this.productSku,
      this.productBarcode,
      this.variantId,
      this.variantName,
      this.unitOfMeasure,
      this.serialNumber,
      this.batchNumber,
      final Map<String, dynamic> metadata = const {},
      this.isReturn = false,
      this.returnQuantity,
      this.returnReason})
      : _metadata = metadata,
        super._();

  factory _$SaleItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleItemImplFromJson(json);

  @override
  final String id;
  @override
  final String saleId;
  @override
  final String productId;
  @override
  final double quantity;
  @override
  final double unitPrice;
  @override
  final double? costPrice;
  @override
  @JsonKey()
  final double discountRate;
  @override
  @JsonKey()
  final double discountAmount;
  @override
  @JsonKey()
  final double taxRate;
  @override
  @JsonKey()
  final double taxAmount;
  @override
  final double totalAmount;
  @override
  final String? notes;
  @override
  final DateTime createdAt;
  @override
  final DateTime? syncedAt;
// Additional fields for plugin
  @override
  final String productName;
  @override
  final String? productSku;
  @override
  final String? productBarcode;
  @override
  final String? variantId;
  @override
  final String? variantName;
  @override
  final String? unitOfMeasure;
  @override
  final String? serialNumber;
  @override
  final String? batchNumber;
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
  final bool isReturn;
  @override
  final double? returnQuantity;
  @override
  final String? returnReason;

  @override
  String toString() {
    return 'SaleItem(id: $id, saleId: $saleId, productId: $productId, quantity: $quantity, unitPrice: $unitPrice, costPrice: $costPrice, discountRate: $discountRate, discountAmount: $discountAmount, taxRate: $taxRate, taxAmount: $taxAmount, totalAmount: $totalAmount, notes: $notes, createdAt: $createdAt, syncedAt: $syncedAt, productName: $productName, productSku: $productSku, productBarcode: $productBarcode, variantId: $variantId, variantName: $variantName, unitOfMeasure: $unitOfMeasure, serialNumber: $serialNumber, batchNumber: $batchNumber, metadata: $metadata, isReturn: $isReturn, returnQuantity: $returnQuantity, returnReason: $returnReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.saleId, saleId) || other.saleId == saleId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.costPrice, costPrice) ||
                other.costPrice == costPrice) &&
            (identical(other.discountRate, discountRate) ||
                other.discountRate == discountRate) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.taxRate, taxRate) || other.taxRate == taxRate) &&
            (identical(other.taxAmount, taxAmount) ||
                other.taxAmount == taxAmount) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.productSku, productSku) ||
                other.productSku == productSku) &&
            (identical(other.productBarcode, productBarcode) ||
                other.productBarcode == productBarcode) &&
            (identical(other.variantId, variantId) ||
                other.variantId == variantId) &&
            (identical(other.variantName, variantName) ||
                other.variantName == variantName) &&
            (identical(other.unitOfMeasure, unitOfMeasure) ||
                other.unitOfMeasure == unitOfMeasure) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.batchNumber, batchNumber) ||
                other.batchNumber == batchNumber) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.isReturn, isReturn) ||
                other.isReturn == isReturn) &&
            (identical(other.returnQuantity, returnQuantity) ||
                other.returnQuantity == returnQuantity) &&
            (identical(other.returnReason, returnReason) ||
                other.returnReason == returnReason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        saleId,
        productId,
        quantity,
        unitPrice,
        costPrice,
        discountRate,
        discountAmount,
        taxRate,
        taxAmount,
        totalAmount,
        notes,
        createdAt,
        syncedAt,
        productName,
        productSku,
        productBarcode,
        variantId,
        variantName,
        unitOfMeasure,
        serialNumber,
        batchNumber,
        const DeepCollectionEquality().hash(_metadata),
        isReturn,
        returnQuantity,
        returnReason
      ]);

  /// Create a copy of SaleItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleItemImplCopyWith<_$SaleItemImpl> get copyWith =>
      __$$SaleItemImplCopyWithImpl<_$SaleItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleItemImplToJson(
      this,
    );
  }
}

abstract class _SaleItem extends SaleItem {
  const factory _SaleItem(
      {required final String id,
      required final String saleId,
      required final String productId,
      required final double quantity,
      required final double unitPrice,
      final double? costPrice,
      final double discountRate,
      final double discountAmount,
      final double taxRate,
      final double taxAmount,
      required final double totalAmount,
      final String? notes,
      required final DateTime createdAt,
      final DateTime? syncedAt,
      required final String productName,
      final String? productSku,
      final String? productBarcode,
      final String? variantId,
      final String? variantName,
      final String? unitOfMeasure,
      final String? serialNumber,
      final String? batchNumber,
      final Map<String, dynamic> metadata,
      final bool isReturn,
      final double? returnQuantity,
      final String? returnReason}) = _$SaleItemImpl;
  const _SaleItem._() : super._();

  factory _SaleItem.fromJson(Map<String, dynamic> json) =
      _$SaleItemImpl.fromJson;

  @override
  String get id;
  @override
  String get saleId;
  @override
  String get productId;
  @override
  double get quantity;
  @override
  double get unitPrice;
  @override
  double? get costPrice;
  @override
  double get discountRate;
  @override
  double get discountAmount;
  @override
  double get taxRate;
  @override
  double get taxAmount;
  @override
  double get totalAmount;
  @override
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  DateTime? get syncedAt; // Additional fields for plugin
  @override
  String get productName;
  @override
  String? get productSku;
  @override
  String? get productBarcode;
  @override
  String? get variantId;
  @override
  String? get variantName;
  @override
  String? get unitOfMeasure;
  @override
  String? get serialNumber;
  @override
  String? get batchNumber;
  @override
  Map<String, dynamic> get metadata;
  @override
  bool get isReturn;
  @override
  double? get returnQuantity;
  @override
  String? get returnReason;

  /// Create a copy of SaleItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleItemImplCopyWith<_$SaleItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
