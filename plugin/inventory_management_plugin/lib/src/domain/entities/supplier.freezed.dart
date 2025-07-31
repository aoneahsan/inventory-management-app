// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'supplier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Supplier _$SupplierFromJson(Map<String, dynamic> json) {
  return _Supplier.fromJson(json);
}

/// @nodoc
mixin _$Supplier {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get mobile => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  String? get taxNumber => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get postalCode => throw _privateConstructorUsedError;
  int get paymentTerms => throw _privateConstructorUsedError;
  double get creditLimit => throw _privateConstructorUsedError;
  double get currentBalance => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional fields for plugin
  String? get contactPerson => throw _privateConstructorUsedError;
  String? get contactPersonPhone => throw _privateConstructorUsedError;
  String? get contactPersonEmail => throw _privateConstructorUsedError;
  String? get bankName => throw _privateConstructorUsedError;
  String? get bankAccountNumber => throw _privateConstructorUsedError;
  String? get bankRoutingNumber => throw _privateConstructorUsedError;
  List<String> get productIds => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  String? get preferredPaymentMethod => throw _privateConstructorUsedError;
  double get totalPurchases => throw _privateConstructorUsedError;
  DateTime? get lastPurchaseDate => throw _privateConstructorUsedError;
  int get totalOrders => throw _privateConstructorUsedError;
  double get averageDeliveryTime =>
      throw _privateConstructorUsedError; // in days
  double get qualityRating => throw _privateConstructorUsedError; // 0-5
  bool get isPreferred => throw _privateConstructorUsedError;

  /// Serializes this Supplier to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Supplier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SupplierCopyWith<Supplier> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupplierCopyWith<$Res> {
  factory $SupplierCopyWith(Supplier value, $Res Function(Supplier) then) =
      _$SupplierCopyWithImpl<$Res, Supplier>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String name,
      String? code,
      String? email,
      String? phone,
      String? mobile,
      String? website,
      String? taxNumber,
      String? address,
      String? city,
      String? state,
      String? country,
      String? postalCode,
      int paymentTerms,
      double creditLimit,
      double currentBalance,
      String status,
      String? notes,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? contactPerson,
      String? contactPersonPhone,
      String? contactPersonEmail,
      String? bankName,
      String? bankAccountNumber,
      String? bankRoutingNumber,
      List<String> productIds,
      Map<String, dynamic> metadata,
      String? preferredPaymentMethod,
      double totalPurchases,
      DateTime? lastPurchaseDate,
      int totalOrders,
      double averageDeliveryTime,
      double qualityRating,
      bool isPreferred});
}

/// @nodoc
class _$SupplierCopyWithImpl<$Res, $Val extends Supplier>
    implements $SupplierCopyWith<$Res> {
  _$SupplierCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Supplier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? name = null,
    Object? code = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? mobile = freezed,
    Object? website = freezed,
    Object? taxNumber = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = freezed,
    Object? postalCode = freezed,
    Object? paymentTerms = null,
    Object? creditLimit = null,
    Object? currentBalance = null,
    Object? status = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? contactPerson = freezed,
    Object? contactPersonPhone = freezed,
    Object? contactPersonEmail = freezed,
    Object? bankName = freezed,
    Object? bankAccountNumber = freezed,
    Object? bankRoutingNumber = freezed,
    Object? productIds = null,
    Object? metadata = null,
    Object? preferredPaymentMethod = freezed,
    Object? totalPurchases = null,
    Object? lastPurchaseDate = freezed,
    Object? totalOrders = null,
    Object? averageDeliveryTime = null,
    Object? qualityRating = null,
    Object? isPreferred = null,
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
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      mobile: freezed == mobile
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      taxNumber: freezed == taxNumber
          ? _value.taxNumber
          : taxNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      postalCode: freezed == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentTerms: null == paymentTerms
          ? _value.paymentTerms
          : paymentTerms // ignore: cast_nullable_to_non_nullable
              as int,
      creditLimit: null == creditLimit
          ? _value.creditLimit
          : creditLimit // ignore: cast_nullable_to_non_nullable
              as double,
      currentBalance: null == currentBalance
          ? _value.currentBalance
          : currentBalance // ignore: cast_nullable_to_non_nullable
              as double,
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
      contactPerson: freezed == contactPerson
          ? _value.contactPerson
          : contactPerson // ignore: cast_nullable_to_non_nullable
              as String?,
      contactPersonPhone: freezed == contactPersonPhone
          ? _value.contactPersonPhone
          : contactPersonPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      contactPersonEmail: freezed == contactPersonEmail
          ? _value.contactPersonEmail
          : contactPersonEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      bankAccountNumber: freezed == bankAccountNumber
          ? _value.bankAccountNumber
          : bankAccountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      bankRoutingNumber: freezed == bankRoutingNumber
          ? _value.bankRoutingNumber
          : bankRoutingNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      productIds: null == productIds
          ? _value.productIds
          : productIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      preferredPaymentMethod: freezed == preferredPaymentMethod
          ? _value.preferredPaymentMethod
          : preferredPaymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPurchases: null == totalPurchases
          ? _value.totalPurchases
          : totalPurchases // ignore: cast_nullable_to_non_nullable
              as double,
      lastPurchaseDate: freezed == lastPurchaseDate
          ? _value.lastPurchaseDate
          : lastPurchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      totalOrders: null == totalOrders
          ? _value.totalOrders
          : totalOrders // ignore: cast_nullable_to_non_nullable
              as int,
      averageDeliveryTime: null == averageDeliveryTime
          ? _value.averageDeliveryTime
          : averageDeliveryTime // ignore: cast_nullable_to_non_nullable
              as double,
      qualityRating: null == qualityRating
          ? _value.qualityRating
          : qualityRating // ignore: cast_nullable_to_non_nullable
              as double,
      isPreferred: null == isPreferred
          ? _value.isPreferred
          : isPreferred // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SupplierImplCopyWith<$Res>
    implements $SupplierCopyWith<$Res> {
  factory _$$SupplierImplCopyWith(
          _$SupplierImpl value, $Res Function(_$SupplierImpl) then) =
      __$$SupplierImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String name,
      String? code,
      String? email,
      String? phone,
      String? mobile,
      String? website,
      String? taxNumber,
      String? address,
      String? city,
      String? state,
      String? country,
      String? postalCode,
      int paymentTerms,
      double creditLimit,
      double currentBalance,
      String status,
      String? notes,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? contactPerson,
      String? contactPersonPhone,
      String? contactPersonEmail,
      String? bankName,
      String? bankAccountNumber,
      String? bankRoutingNumber,
      List<String> productIds,
      Map<String, dynamic> metadata,
      String? preferredPaymentMethod,
      double totalPurchases,
      DateTime? lastPurchaseDate,
      int totalOrders,
      double averageDeliveryTime,
      double qualityRating,
      bool isPreferred});
}

/// @nodoc
class __$$SupplierImplCopyWithImpl<$Res>
    extends _$SupplierCopyWithImpl<$Res, _$SupplierImpl>
    implements _$$SupplierImplCopyWith<$Res> {
  __$$SupplierImplCopyWithImpl(
      _$SupplierImpl _value, $Res Function(_$SupplierImpl) _then)
      : super(_value, _then);

  /// Create a copy of Supplier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? name = null,
    Object? code = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? mobile = freezed,
    Object? website = freezed,
    Object? taxNumber = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = freezed,
    Object? postalCode = freezed,
    Object? paymentTerms = null,
    Object? creditLimit = null,
    Object? currentBalance = null,
    Object? status = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? contactPerson = freezed,
    Object? contactPersonPhone = freezed,
    Object? contactPersonEmail = freezed,
    Object? bankName = freezed,
    Object? bankAccountNumber = freezed,
    Object? bankRoutingNumber = freezed,
    Object? productIds = null,
    Object? metadata = null,
    Object? preferredPaymentMethod = freezed,
    Object? totalPurchases = null,
    Object? lastPurchaseDate = freezed,
    Object? totalOrders = null,
    Object? averageDeliveryTime = null,
    Object? qualityRating = null,
    Object? isPreferred = null,
  }) {
    return _then(_$SupplierImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      mobile: freezed == mobile
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      taxNumber: freezed == taxNumber
          ? _value.taxNumber
          : taxNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      postalCode: freezed == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentTerms: null == paymentTerms
          ? _value.paymentTerms
          : paymentTerms // ignore: cast_nullable_to_non_nullable
              as int,
      creditLimit: null == creditLimit
          ? _value.creditLimit
          : creditLimit // ignore: cast_nullable_to_non_nullable
              as double,
      currentBalance: null == currentBalance
          ? _value.currentBalance
          : currentBalance // ignore: cast_nullable_to_non_nullable
              as double,
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
      contactPerson: freezed == contactPerson
          ? _value.contactPerson
          : contactPerson // ignore: cast_nullable_to_non_nullable
              as String?,
      contactPersonPhone: freezed == contactPersonPhone
          ? _value.contactPersonPhone
          : contactPersonPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      contactPersonEmail: freezed == contactPersonEmail
          ? _value.contactPersonEmail
          : contactPersonEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      bankAccountNumber: freezed == bankAccountNumber
          ? _value.bankAccountNumber
          : bankAccountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      bankRoutingNumber: freezed == bankRoutingNumber
          ? _value.bankRoutingNumber
          : bankRoutingNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      productIds: null == productIds
          ? _value._productIds
          : productIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      preferredPaymentMethod: freezed == preferredPaymentMethod
          ? _value.preferredPaymentMethod
          : preferredPaymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPurchases: null == totalPurchases
          ? _value.totalPurchases
          : totalPurchases // ignore: cast_nullable_to_non_nullable
              as double,
      lastPurchaseDate: freezed == lastPurchaseDate
          ? _value.lastPurchaseDate
          : lastPurchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      totalOrders: null == totalOrders
          ? _value.totalOrders
          : totalOrders // ignore: cast_nullable_to_non_nullable
              as int,
      averageDeliveryTime: null == averageDeliveryTime
          ? _value.averageDeliveryTime
          : averageDeliveryTime // ignore: cast_nullable_to_non_nullable
              as double,
      qualityRating: null == qualityRating
          ? _value.qualityRating
          : qualityRating // ignore: cast_nullable_to_non_nullable
              as double,
      isPreferred: null == isPreferred
          ? _value.isPreferred
          : isPreferred // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SupplierImpl extends _Supplier {
  const _$SupplierImpl(
      {required this.id,
      required this.organizationId,
      required this.name,
      this.code,
      this.email,
      this.phone,
      this.mobile,
      this.website,
      this.taxNumber,
      this.address,
      this.city,
      this.state,
      this.country,
      this.postalCode,
      this.paymentTerms = 30,
      this.creditLimit = 0,
      this.currentBalance = 0,
      this.status = 'active',
      this.notes,
      required this.createdAt,
      required this.updatedAt,
      this.syncedAt,
      this.contactPerson,
      this.contactPersonPhone,
      this.contactPersonEmail,
      this.bankName,
      this.bankAccountNumber,
      this.bankRoutingNumber,
      final List<String> productIds = const [],
      final Map<String, dynamic> metadata = const {},
      this.preferredPaymentMethod,
      this.totalPurchases = 0,
      this.lastPurchaseDate,
      this.totalOrders = 0,
      this.averageDeliveryTime = 0.0,
      this.qualityRating = 0.0,
      this.isPreferred = true})
      : _productIds = productIds,
        _metadata = metadata,
        super._();

  factory _$SupplierImpl.fromJson(Map<String, dynamic> json) =>
      _$$SupplierImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String name;
  @override
  final String? code;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? mobile;
  @override
  final String? website;
  @override
  final String? taxNumber;
  @override
  final String? address;
  @override
  final String? city;
  @override
  final String? state;
  @override
  final String? country;
  @override
  final String? postalCode;
  @override
  @JsonKey()
  final int paymentTerms;
  @override
  @JsonKey()
  final double creditLimit;
  @override
  @JsonKey()
  final double currentBalance;
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
// Additional fields for plugin
  @override
  final String? contactPerson;
  @override
  final String? contactPersonPhone;
  @override
  final String? contactPersonEmail;
  @override
  final String? bankName;
  @override
  final String? bankAccountNumber;
  @override
  final String? bankRoutingNumber;
  final List<String> _productIds;
  @override
  @JsonKey()
  List<String> get productIds {
    if (_productIds is EqualUnmodifiableListView) return _productIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productIds);
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
  final String? preferredPaymentMethod;
  @override
  @JsonKey()
  final double totalPurchases;
  @override
  final DateTime? lastPurchaseDate;
  @override
  @JsonKey()
  final int totalOrders;
  @override
  @JsonKey()
  final double averageDeliveryTime;
// in days
  @override
  @JsonKey()
  final double qualityRating;
// 0-5
  @override
  @JsonKey()
  final bool isPreferred;

  @override
  String toString() {
    return 'Supplier(id: $id, organizationId: $organizationId, name: $name, code: $code, email: $email, phone: $phone, mobile: $mobile, website: $website, taxNumber: $taxNumber, address: $address, city: $city, state: $state, country: $country, postalCode: $postalCode, paymentTerms: $paymentTerms, creditLimit: $creditLimit, currentBalance: $currentBalance, status: $status, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt, contactPerson: $contactPerson, contactPersonPhone: $contactPersonPhone, contactPersonEmail: $contactPersonEmail, bankName: $bankName, bankAccountNumber: $bankAccountNumber, bankRoutingNumber: $bankRoutingNumber, productIds: $productIds, metadata: $metadata, preferredPaymentMethod: $preferredPaymentMethod, totalPurchases: $totalPurchases, lastPurchaseDate: $lastPurchaseDate, totalOrders: $totalOrders, averageDeliveryTime: $averageDeliveryTime, qualityRating: $qualityRating, isPreferred: $isPreferred)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupplierImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.mobile, mobile) || other.mobile == mobile) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.taxNumber, taxNumber) ||
                other.taxNumber == taxNumber) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.paymentTerms, paymentTerms) ||
                other.paymentTerms == paymentTerms) &&
            (identical(other.creditLimit, creditLimit) ||
                other.creditLimit == creditLimit) &&
            (identical(other.currentBalance, currentBalance) ||
                other.currentBalance == currentBalance) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.contactPerson, contactPerson) ||
                other.contactPerson == contactPerson) &&
            (identical(other.contactPersonPhone, contactPersonPhone) ||
                other.contactPersonPhone == contactPersonPhone) &&
            (identical(other.contactPersonEmail, contactPersonEmail) ||
                other.contactPersonEmail == contactPersonEmail) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.bankAccountNumber, bankAccountNumber) ||
                other.bankAccountNumber == bankAccountNumber) &&
            (identical(other.bankRoutingNumber, bankRoutingNumber) ||
                other.bankRoutingNumber == bankRoutingNumber) &&
            const DeepCollectionEquality()
                .equals(other._productIds, _productIds) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.preferredPaymentMethod, preferredPaymentMethod) ||
                other.preferredPaymentMethod == preferredPaymentMethod) &&
            (identical(other.totalPurchases, totalPurchases) ||
                other.totalPurchases == totalPurchases) &&
            (identical(other.lastPurchaseDate, lastPurchaseDate) ||
                other.lastPurchaseDate == lastPurchaseDate) &&
            (identical(other.totalOrders, totalOrders) ||
                other.totalOrders == totalOrders) &&
            (identical(other.averageDeliveryTime, averageDeliveryTime) ||
                other.averageDeliveryTime == averageDeliveryTime) &&
            (identical(other.qualityRating, qualityRating) ||
                other.qualityRating == qualityRating) &&
            (identical(other.isPreferred, isPreferred) ||
                other.isPreferred == isPreferred));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        organizationId,
        name,
        code,
        email,
        phone,
        mobile,
        website,
        taxNumber,
        address,
        city,
        state,
        country,
        postalCode,
        paymentTerms,
        creditLimit,
        currentBalance,
        status,
        notes,
        createdAt,
        updatedAt,
        syncedAt,
        contactPerson,
        contactPersonPhone,
        contactPersonEmail,
        bankName,
        bankAccountNumber,
        bankRoutingNumber,
        const DeepCollectionEquality().hash(_productIds),
        const DeepCollectionEquality().hash(_metadata),
        preferredPaymentMethod,
        totalPurchases,
        lastPurchaseDate,
        totalOrders,
        averageDeliveryTime,
        qualityRating,
        isPreferred
      ]);

  /// Create a copy of Supplier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SupplierImplCopyWith<_$SupplierImpl> get copyWith =>
      __$$SupplierImplCopyWithImpl<_$SupplierImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SupplierImplToJson(
      this,
    );
  }
}

abstract class _Supplier extends Supplier {
  const factory _Supplier(
      {required final String id,
      required final String organizationId,
      required final String name,
      final String? code,
      final String? email,
      final String? phone,
      final String? mobile,
      final String? website,
      final String? taxNumber,
      final String? address,
      final String? city,
      final String? state,
      final String? country,
      final String? postalCode,
      final int paymentTerms,
      final double creditLimit,
      final double currentBalance,
      final String status,
      final String? notes,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final DateTime? syncedAt,
      final String? contactPerson,
      final String? contactPersonPhone,
      final String? contactPersonEmail,
      final String? bankName,
      final String? bankAccountNumber,
      final String? bankRoutingNumber,
      final List<String> productIds,
      final Map<String, dynamic> metadata,
      final String? preferredPaymentMethod,
      final double totalPurchases,
      final DateTime? lastPurchaseDate,
      final int totalOrders,
      final double averageDeliveryTime,
      final double qualityRating,
      final bool isPreferred}) = _$SupplierImpl;
  const _Supplier._() : super._();

  factory _Supplier.fromJson(Map<String, dynamic> json) =
      _$SupplierImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String get name;
  @override
  String? get code;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  String? get mobile;
  @override
  String? get website;
  @override
  String? get taxNumber;
  @override
  String? get address;
  @override
  String? get city;
  @override
  String? get state;
  @override
  String? get country;
  @override
  String? get postalCode;
  @override
  int get paymentTerms;
  @override
  double get creditLimit;
  @override
  double get currentBalance;
  @override
  String get status;
  @override
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get syncedAt; // Additional fields for plugin
  @override
  String? get contactPerson;
  @override
  String? get contactPersonPhone;
  @override
  String? get contactPersonEmail;
  @override
  String? get bankName;
  @override
  String? get bankAccountNumber;
  @override
  String? get bankRoutingNumber;
  @override
  List<String> get productIds;
  @override
  Map<String, dynamic> get metadata;
  @override
  String? get preferredPaymentMethod;
  @override
  double get totalPurchases;
  @override
  DateTime? get lastPurchaseDate;
  @override
  int get totalOrders;
  @override
  double get averageDeliveryTime; // in days
  @override
  double get qualityRating; // 0-5
  @override
  bool get isPreferred;

  /// Create a copy of Supplier
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SupplierImplCopyWith<_$SupplierImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
