// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return _Customer.fromJson(json);
}

/// @nodoc
mixin _$Customer {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get mobile => throw _privateConstructorUsedError;
  String? get taxNumber => throw _privateConstructorUsedError;
  String get customerType => throw _privateConstructorUsedError;
  String? get priceListId => throw _privateConstructorUsedError;
  double get creditLimit => throw _privateConstructorUsedError;
  double get currentBalance => throw _privateConstructorUsedError;
  int get loyaltyPoints => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get shippingAddress => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional fields for plugin
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get postalCode => throw _privateConstructorUsedError;
  DateTime? get dateOfBirth => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  double get totalPurchases => throw _privateConstructorUsedError;
  int get totalOrders => throw _privateConstructorUsedError;
  DateTime? get lastPurchaseDate => throw _privateConstructorUsedError;
  List<String> get favoriteProductIds => throw _privateConstructorUsedError;
  String? get referredBy => throw _privateConstructorUsedError;
  int get referralCount => throw _privateConstructorUsedError;
  CustomerPreferences? get preferences => throw _privateConstructorUsedError;
  Map<String, String> get customFields => throw _privateConstructorUsedError;
  bool get isVip => throw _privateConstructorUsedError;
  String? get membershipTier => throw _privateConstructorUsedError;
  DateTime? get membershipExpiryDate => throw _privateConstructorUsedError;

  /// Serializes this Customer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerCopyWith<Customer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerCopyWith<$Res> {
  factory $CustomerCopyWith(Customer value, $Res Function(Customer) then) =
      _$CustomerCopyWithImpl<$Res, Customer>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String name,
      String? code,
      String? email,
      String? phone,
      String? mobile,
      String? taxNumber,
      String customerType,
      String? priceListId,
      double creditLimit,
      double currentBalance,
      int loyaltyPoints,
      String? address,
      String? shippingAddress,
      String status,
      String? notes,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? city,
      String? state,
      String? country,
      String? postalCode,
      DateTime? dateOfBirth,
      String? gender,
      Map<String, dynamic> metadata,
      double totalPurchases,
      int totalOrders,
      DateTime? lastPurchaseDate,
      List<String> favoriteProductIds,
      String? referredBy,
      int referralCount,
      CustomerPreferences? preferences,
      Map<String, String> customFields,
      bool isVip,
      String? membershipTier,
      DateTime? membershipExpiryDate});

  $CustomerPreferencesCopyWith<$Res>? get preferences;
}

/// @nodoc
class _$CustomerCopyWithImpl<$Res, $Val extends Customer>
    implements $CustomerCopyWith<$Res> {
  _$CustomerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Customer
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
    Object? taxNumber = freezed,
    Object? customerType = null,
    Object? priceListId = freezed,
    Object? creditLimit = null,
    Object? currentBalance = null,
    Object? loyaltyPoints = null,
    Object? address = freezed,
    Object? shippingAddress = freezed,
    Object? status = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = freezed,
    Object? postalCode = freezed,
    Object? dateOfBirth = freezed,
    Object? gender = freezed,
    Object? metadata = null,
    Object? totalPurchases = null,
    Object? totalOrders = null,
    Object? lastPurchaseDate = freezed,
    Object? favoriteProductIds = null,
    Object? referredBy = freezed,
    Object? referralCount = null,
    Object? preferences = freezed,
    Object? customFields = null,
    Object? isVip = null,
    Object? membershipTier = freezed,
    Object? membershipExpiryDate = freezed,
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
      taxNumber: freezed == taxNumber
          ? _value.taxNumber
          : taxNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      customerType: null == customerType
          ? _value.customerType
          : customerType // ignore: cast_nullable_to_non_nullable
              as String,
      priceListId: freezed == priceListId
          ? _value.priceListId
          : priceListId // ignore: cast_nullable_to_non_nullable
              as String?,
      creditLimit: null == creditLimit
          ? _value.creditLimit
          : creditLimit // ignore: cast_nullable_to_non_nullable
              as double,
      currentBalance: null == currentBalance
          ? _value.currentBalance
          : currentBalance // ignore: cast_nullable_to_non_nullable
              as double,
      loyaltyPoints: null == loyaltyPoints
          ? _value.loyaltyPoints
          : loyaltyPoints // ignore: cast_nullable_to_non_nullable
              as int,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      shippingAddress: freezed == shippingAddress
          ? _value.shippingAddress
          : shippingAddress // ignore: cast_nullable_to_non_nullable
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
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      totalPurchases: null == totalPurchases
          ? _value.totalPurchases
          : totalPurchases // ignore: cast_nullable_to_non_nullable
              as double,
      totalOrders: null == totalOrders
          ? _value.totalOrders
          : totalOrders // ignore: cast_nullable_to_non_nullable
              as int,
      lastPurchaseDate: freezed == lastPurchaseDate
          ? _value.lastPurchaseDate
          : lastPurchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      favoriteProductIds: null == favoriteProductIds
          ? _value.favoriteProductIds
          : favoriteProductIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      referredBy: freezed == referredBy
          ? _value.referredBy
          : referredBy // ignore: cast_nullable_to_non_nullable
              as String?,
      referralCount: null == referralCount
          ? _value.referralCount
          : referralCount // ignore: cast_nullable_to_non_nullable
              as int,
      preferences: freezed == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as CustomerPreferences?,
      customFields: null == customFields
          ? _value.customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      isVip: null == isVip
          ? _value.isVip
          : isVip // ignore: cast_nullable_to_non_nullable
              as bool,
      membershipTier: freezed == membershipTier
          ? _value.membershipTier
          : membershipTier // ignore: cast_nullable_to_non_nullable
              as String?,
      membershipExpiryDate: freezed == membershipExpiryDate
          ? _value.membershipExpiryDate
          : membershipExpiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomerPreferencesCopyWith<$Res>? get preferences {
    if (_value.preferences == null) {
      return null;
    }

    return $CustomerPreferencesCopyWith<$Res>(_value.preferences!, (value) {
      return _then(_value.copyWith(preferences: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CustomerImplCopyWith<$Res>
    implements $CustomerCopyWith<$Res> {
  factory _$$CustomerImplCopyWith(
          _$CustomerImpl value, $Res Function(_$CustomerImpl) then) =
      __$$CustomerImplCopyWithImpl<$Res>;
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
      String? taxNumber,
      String customerType,
      String? priceListId,
      double creditLimit,
      double currentBalance,
      int loyaltyPoints,
      String? address,
      String? shippingAddress,
      String status,
      String? notes,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? city,
      String? state,
      String? country,
      String? postalCode,
      DateTime? dateOfBirth,
      String? gender,
      Map<String, dynamic> metadata,
      double totalPurchases,
      int totalOrders,
      DateTime? lastPurchaseDate,
      List<String> favoriteProductIds,
      String? referredBy,
      int referralCount,
      CustomerPreferences? preferences,
      Map<String, String> customFields,
      bool isVip,
      String? membershipTier,
      DateTime? membershipExpiryDate});

  @override
  $CustomerPreferencesCopyWith<$Res>? get preferences;
}

/// @nodoc
class __$$CustomerImplCopyWithImpl<$Res>
    extends _$CustomerCopyWithImpl<$Res, _$CustomerImpl>
    implements _$$CustomerImplCopyWith<$Res> {
  __$$CustomerImplCopyWithImpl(
      _$CustomerImpl _value, $Res Function(_$CustomerImpl) _then)
      : super(_value, _then);

  /// Create a copy of Customer
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
    Object? taxNumber = freezed,
    Object? customerType = null,
    Object? priceListId = freezed,
    Object? creditLimit = null,
    Object? currentBalance = null,
    Object? loyaltyPoints = null,
    Object? address = freezed,
    Object? shippingAddress = freezed,
    Object? status = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = freezed,
    Object? postalCode = freezed,
    Object? dateOfBirth = freezed,
    Object? gender = freezed,
    Object? metadata = null,
    Object? totalPurchases = null,
    Object? totalOrders = null,
    Object? lastPurchaseDate = freezed,
    Object? favoriteProductIds = null,
    Object? referredBy = freezed,
    Object? referralCount = null,
    Object? preferences = freezed,
    Object? customFields = null,
    Object? isVip = null,
    Object? membershipTier = freezed,
    Object? membershipExpiryDate = freezed,
  }) {
    return _then(_$CustomerImpl(
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
      taxNumber: freezed == taxNumber
          ? _value.taxNumber
          : taxNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      customerType: null == customerType
          ? _value.customerType
          : customerType // ignore: cast_nullable_to_non_nullable
              as String,
      priceListId: freezed == priceListId
          ? _value.priceListId
          : priceListId // ignore: cast_nullable_to_non_nullable
              as String?,
      creditLimit: null == creditLimit
          ? _value.creditLimit
          : creditLimit // ignore: cast_nullable_to_non_nullable
              as double,
      currentBalance: null == currentBalance
          ? _value.currentBalance
          : currentBalance // ignore: cast_nullable_to_non_nullable
              as double,
      loyaltyPoints: null == loyaltyPoints
          ? _value.loyaltyPoints
          : loyaltyPoints // ignore: cast_nullable_to_non_nullable
              as int,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      shippingAddress: freezed == shippingAddress
          ? _value.shippingAddress
          : shippingAddress // ignore: cast_nullable_to_non_nullable
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
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      totalPurchases: null == totalPurchases
          ? _value.totalPurchases
          : totalPurchases // ignore: cast_nullable_to_non_nullable
              as double,
      totalOrders: null == totalOrders
          ? _value.totalOrders
          : totalOrders // ignore: cast_nullable_to_non_nullable
              as int,
      lastPurchaseDate: freezed == lastPurchaseDate
          ? _value.lastPurchaseDate
          : lastPurchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      favoriteProductIds: null == favoriteProductIds
          ? _value._favoriteProductIds
          : favoriteProductIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      referredBy: freezed == referredBy
          ? _value.referredBy
          : referredBy // ignore: cast_nullable_to_non_nullable
              as String?,
      referralCount: null == referralCount
          ? _value.referralCount
          : referralCount // ignore: cast_nullable_to_non_nullable
              as int,
      preferences: freezed == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as CustomerPreferences?,
      customFields: null == customFields
          ? _value._customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      isVip: null == isVip
          ? _value.isVip
          : isVip // ignore: cast_nullable_to_non_nullable
              as bool,
      membershipTier: freezed == membershipTier
          ? _value.membershipTier
          : membershipTier // ignore: cast_nullable_to_non_nullable
              as String?,
      membershipExpiryDate: freezed == membershipExpiryDate
          ? _value.membershipExpiryDate
          : membershipExpiryDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerImpl extends _Customer {
  const _$CustomerImpl(
      {required this.id,
      required this.organizationId,
      required this.name,
      this.code,
      this.email,
      this.phone,
      this.mobile,
      this.taxNumber,
      this.customerType = 'retail',
      this.priceListId,
      this.creditLimit = 0,
      this.currentBalance = 0,
      this.loyaltyPoints = 0,
      this.address,
      this.shippingAddress,
      this.status = 'active',
      this.notes,
      required this.createdAt,
      required this.updatedAt,
      this.syncedAt,
      this.city,
      this.state,
      this.country,
      this.postalCode,
      this.dateOfBirth,
      this.gender,
      final Map<String, dynamic> metadata = const {},
      this.totalPurchases = 0,
      this.totalOrders = 0,
      this.lastPurchaseDate,
      final List<String> favoriteProductIds = const [],
      this.referredBy,
      this.referralCount = 0,
      this.preferences,
      final Map<String, String> customFields = const {},
      this.isVip = false,
      this.membershipTier,
      this.membershipExpiryDate})
      : _metadata = metadata,
        _favoriteProductIds = favoriteProductIds,
        _customFields = customFields,
        super._();

  factory _$CustomerImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerImplFromJson(json);

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
  final String? taxNumber;
  @override
  @JsonKey()
  final String customerType;
  @override
  final String? priceListId;
  @override
  @JsonKey()
  final double creditLimit;
  @override
  @JsonKey()
  final double currentBalance;
  @override
  @JsonKey()
  final int loyaltyPoints;
  @override
  final String? address;
  @override
  final String? shippingAddress;
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
  final String? city;
  @override
  final String? state;
  @override
  final String? country;
  @override
  final String? postalCode;
  @override
  final DateTime? dateOfBirth;
  @override
  final String? gender;
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
  final double totalPurchases;
  @override
  @JsonKey()
  final int totalOrders;
  @override
  final DateTime? lastPurchaseDate;
  final List<String> _favoriteProductIds;
  @override
  @JsonKey()
  List<String> get favoriteProductIds {
    if (_favoriteProductIds is EqualUnmodifiableListView)
      return _favoriteProductIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favoriteProductIds);
  }

  @override
  final String? referredBy;
  @override
  @JsonKey()
  final int referralCount;
  @override
  final CustomerPreferences? preferences;
  final Map<String, String> _customFields;
  @override
  @JsonKey()
  Map<String, String> get customFields {
    if (_customFields is EqualUnmodifiableMapView) return _customFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_customFields);
  }

  @override
  @JsonKey()
  final bool isVip;
  @override
  final String? membershipTier;
  @override
  final DateTime? membershipExpiryDate;

  @override
  String toString() {
    return 'Customer(id: $id, organizationId: $organizationId, name: $name, code: $code, email: $email, phone: $phone, mobile: $mobile, taxNumber: $taxNumber, customerType: $customerType, priceListId: $priceListId, creditLimit: $creditLimit, currentBalance: $currentBalance, loyaltyPoints: $loyaltyPoints, address: $address, shippingAddress: $shippingAddress, status: $status, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt, city: $city, state: $state, country: $country, postalCode: $postalCode, dateOfBirth: $dateOfBirth, gender: $gender, metadata: $metadata, totalPurchases: $totalPurchases, totalOrders: $totalOrders, lastPurchaseDate: $lastPurchaseDate, favoriteProductIds: $favoriteProductIds, referredBy: $referredBy, referralCount: $referralCount, preferences: $preferences, customFields: $customFields, isVip: $isVip, membershipTier: $membershipTier, membershipExpiryDate: $membershipExpiryDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.mobile, mobile) || other.mobile == mobile) &&
            (identical(other.taxNumber, taxNumber) ||
                other.taxNumber == taxNumber) &&
            (identical(other.customerType, customerType) ||
                other.customerType == customerType) &&
            (identical(other.priceListId, priceListId) ||
                other.priceListId == priceListId) &&
            (identical(other.creditLimit, creditLimit) ||
                other.creditLimit == creditLimit) &&
            (identical(other.currentBalance, currentBalance) ||
                other.currentBalance == currentBalance) &&
            (identical(other.loyaltyPoints, loyaltyPoints) ||
                other.loyaltyPoints == loyaltyPoints) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.shippingAddress, shippingAddress) ||
                other.shippingAddress == shippingAddress) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.totalPurchases, totalPurchases) ||
                other.totalPurchases == totalPurchases) &&
            (identical(other.totalOrders, totalOrders) ||
                other.totalOrders == totalOrders) &&
            (identical(other.lastPurchaseDate, lastPurchaseDate) ||
                other.lastPurchaseDate == lastPurchaseDate) &&
            const DeepCollectionEquality()
                .equals(other._favoriteProductIds, _favoriteProductIds) &&
            (identical(other.referredBy, referredBy) ||
                other.referredBy == referredBy) &&
            (identical(other.referralCount, referralCount) ||
                other.referralCount == referralCount) &&
            (identical(other.preferences, preferences) ||
                other.preferences == preferences) &&
            const DeepCollectionEquality()
                .equals(other._customFields, _customFields) &&
            (identical(other.isVip, isVip) || other.isVip == isVip) &&
            (identical(other.membershipTier, membershipTier) ||
                other.membershipTier == membershipTier) &&
            (identical(other.membershipExpiryDate, membershipExpiryDate) ||
                other.membershipExpiryDate == membershipExpiryDate));
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
        taxNumber,
        customerType,
        priceListId,
        creditLimit,
        currentBalance,
        loyaltyPoints,
        address,
        shippingAddress,
        status,
        notes,
        createdAt,
        updatedAt,
        syncedAt,
        city,
        state,
        country,
        postalCode,
        dateOfBirth,
        gender,
        const DeepCollectionEquality().hash(_metadata),
        totalPurchases,
        totalOrders,
        lastPurchaseDate,
        const DeepCollectionEquality().hash(_favoriteProductIds),
        referredBy,
        referralCount,
        preferences,
        const DeepCollectionEquality().hash(_customFields),
        isVip,
        membershipTier,
        membershipExpiryDate
      ]);

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerImplCopyWith<_$CustomerImpl> get copyWith =>
      __$$CustomerImplCopyWithImpl<_$CustomerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerImplToJson(
      this,
    );
  }
}

abstract class _Customer extends Customer {
  const factory _Customer(
      {required final String id,
      required final String organizationId,
      required final String name,
      final String? code,
      final String? email,
      final String? phone,
      final String? mobile,
      final String? taxNumber,
      final String customerType,
      final String? priceListId,
      final double creditLimit,
      final double currentBalance,
      final int loyaltyPoints,
      final String? address,
      final String? shippingAddress,
      final String status,
      final String? notes,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final DateTime? syncedAt,
      final String? city,
      final String? state,
      final String? country,
      final String? postalCode,
      final DateTime? dateOfBirth,
      final String? gender,
      final Map<String, dynamic> metadata,
      final double totalPurchases,
      final int totalOrders,
      final DateTime? lastPurchaseDate,
      final List<String> favoriteProductIds,
      final String? referredBy,
      final int referralCount,
      final CustomerPreferences? preferences,
      final Map<String, String> customFields,
      final bool isVip,
      final String? membershipTier,
      final DateTime? membershipExpiryDate}) = _$CustomerImpl;
  const _Customer._() : super._();

  factory _Customer.fromJson(Map<String, dynamic> json) =
      _$CustomerImpl.fromJson;

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
  String? get taxNumber;
  @override
  String get customerType;
  @override
  String? get priceListId;
  @override
  double get creditLimit;
  @override
  double get currentBalance;
  @override
  int get loyaltyPoints;
  @override
  String? get address;
  @override
  String? get shippingAddress;
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
  String? get city;
  @override
  String? get state;
  @override
  String? get country;
  @override
  String? get postalCode;
  @override
  DateTime? get dateOfBirth;
  @override
  String? get gender;
  @override
  Map<String, dynamic> get metadata;
  @override
  double get totalPurchases;
  @override
  int get totalOrders;
  @override
  DateTime? get lastPurchaseDate;
  @override
  List<String> get favoriteProductIds;
  @override
  String? get referredBy;
  @override
  int get referralCount;
  @override
  CustomerPreferences? get preferences;
  @override
  Map<String, String> get customFields;
  @override
  bool get isVip;
  @override
  String? get membershipTier;
  @override
  DateTime? get membershipExpiryDate;

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerImplCopyWith<_$CustomerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CustomerPreferences _$CustomerPreferencesFromJson(Map<String, dynamic> json) {
  return _CustomerPreferences.fromJson(json);
}

/// @nodoc
mixin _$CustomerPreferences {
  bool get emailNotifications => throw _privateConstructorUsedError;
  bool get smsNotifications => throw _privateConstructorUsedError;
  bool get whatsappNotifications => throw _privateConstructorUsedError;
  String get preferredContactMethod => throw _privateConstructorUsedError;
  String? get preferredLanguage => throw _privateConstructorUsedError;
  List<String> get productCategories => throw _privateConstructorUsedError;
  Map<String, dynamic> get customPreferences =>
      throw _privateConstructorUsedError;

  /// Serializes this CustomerPreferences to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomerPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerPreferencesCopyWith<CustomerPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerPreferencesCopyWith<$Res> {
  factory $CustomerPreferencesCopyWith(
          CustomerPreferences value, $Res Function(CustomerPreferences) then) =
      _$CustomerPreferencesCopyWithImpl<$Res, CustomerPreferences>;
  @useResult
  $Res call(
      {bool emailNotifications,
      bool smsNotifications,
      bool whatsappNotifications,
      String preferredContactMethod,
      String? preferredLanguage,
      List<String> productCategories,
      Map<String, dynamic> customPreferences});
}

/// @nodoc
class _$CustomerPreferencesCopyWithImpl<$Res, $Val extends CustomerPreferences>
    implements $CustomerPreferencesCopyWith<$Res> {
  _$CustomerPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomerPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailNotifications = null,
    Object? smsNotifications = null,
    Object? whatsappNotifications = null,
    Object? preferredContactMethod = null,
    Object? preferredLanguage = freezed,
    Object? productCategories = null,
    Object? customPreferences = null,
  }) {
    return _then(_value.copyWith(
      emailNotifications: null == emailNotifications
          ? _value.emailNotifications
          : emailNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      smsNotifications: null == smsNotifications
          ? _value.smsNotifications
          : smsNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      whatsappNotifications: null == whatsappNotifications
          ? _value.whatsappNotifications
          : whatsappNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      preferredContactMethod: null == preferredContactMethod
          ? _value.preferredContactMethod
          : preferredContactMethod // ignore: cast_nullable_to_non_nullable
              as String,
      preferredLanguage: freezed == preferredLanguage
          ? _value.preferredLanguage
          : preferredLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      productCategories: null == productCategories
          ? _value.productCategories
          : productCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      customPreferences: null == customPreferences
          ? _value.customPreferences
          : customPreferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomerPreferencesImplCopyWith<$Res>
    implements $CustomerPreferencesCopyWith<$Res> {
  factory _$$CustomerPreferencesImplCopyWith(_$CustomerPreferencesImpl value,
          $Res Function(_$CustomerPreferencesImpl) then) =
      __$$CustomerPreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool emailNotifications,
      bool smsNotifications,
      bool whatsappNotifications,
      String preferredContactMethod,
      String? preferredLanguage,
      List<String> productCategories,
      Map<String, dynamic> customPreferences});
}

/// @nodoc
class __$$CustomerPreferencesImplCopyWithImpl<$Res>
    extends _$CustomerPreferencesCopyWithImpl<$Res, _$CustomerPreferencesImpl>
    implements _$$CustomerPreferencesImplCopyWith<$Res> {
  __$$CustomerPreferencesImplCopyWithImpl(_$CustomerPreferencesImpl _value,
      $Res Function(_$CustomerPreferencesImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomerPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailNotifications = null,
    Object? smsNotifications = null,
    Object? whatsappNotifications = null,
    Object? preferredContactMethod = null,
    Object? preferredLanguage = freezed,
    Object? productCategories = null,
    Object? customPreferences = null,
  }) {
    return _then(_$CustomerPreferencesImpl(
      emailNotifications: null == emailNotifications
          ? _value.emailNotifications
          : emailNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      smsNotifications: null == smsNotifications
          ? _value.smsNotifications
          : smsNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      whatsappNotifications: null == whatsappNotifications
          ? _value.whatsappNotifications
          : whatsappNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      preferredContactMethod: null == preferredContactMethod
          ? _value.preferredContactMethod
          : preferredContactMethod // ignore: cast_nullable_to_non_nullable
              as String,
      preferredLanguage: freezed == preferredLanguage
          ? _value.preferredLanguage
          : preferredLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      productCategories: null == productCategories
          ? _value._productCategories
          : productCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      customPreferences: null == customPreferences
          ? _value._customPreferences
          : customPreferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerPreferencesImpl implements _CustomerPreferences {
  const _$CustomerPreferencesImpl(
      {this.emailNotifications = true,
      this.smsNotifications = true,
      this.whatsappNotifications = false,
      this.preferredContactMethod = 'email',
      this.preferredLanguage,
      final List<String> productCategories = const [],
      final Map<String, dynamic> customPreferences = const {}})
      : _productCategories = productCategories,
        _customPreferences = customPreferences;

  factory _$CustomerPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerPreferencesImplFromJson(json);

  @override
  @JsonKey()
  final bool emailNotifications;
  @override
  @JsonKey()
  final bool smsNotifications;
  @override
  @JsonKey()
  final bool whatsappNotifications;
  @override
  @JsonKey()
  final String preferredContactMethod;
  @override
  final String? preferredLanguage;
  final List<String> _productCategories;
  @override
  @JsonKey()
  List<String> get productCategories {
    if (_productCategories is EqualUnmodifiableListView)
      return _productCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productCategories);
  }

  final Map<String, dynamic> _customPreferences;
  @override
  @JsonKey()
  Map<String, dynamic> get customPreferences {
    if (_customPreferences is EqualUnmodifiableMapView)
      return _customPreferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_customPreferences);
  }

  @override
  String toString() {
    return 'CustomerPreferences(emailNotifications: $emailNotifications, smsNotifications: $smsNotifications, whatsappNotifications: $whatsappNotifications, preferredContactMethod: $preferredContactMethod, preferredLanguage: $preferredLanguage, productCategories: $productCategories, customPreferences: $customPreferences)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerPreferencesImpl &&
            (identical(other.emailNotifications, emailNotifications) ||
                other.emailNotifications == emailNotifications) &&
            (identical(other.smsNotifications, smsNotifications) ||
                other.smsNotifications == smsNotifications) &&
            (identical(other.whatsappNotifications, whatsappNotifications) ||
                other.whatsappNotifications == whatsappNotifications) &&
            (identical(other.preferredContactMethod, preferredContactMethod) ||
                other.preferredContactMethod == preferredContactMethod) &&
            (identical(other.preferredLanguage, preferredLanguage) ||
                other.preferredLanguage == preferredLanguage) &&
            const DeepCollectionEquality()
                .equals(other._productCategories, _productCategories) &&
            const DeepCollectionEquality()
                .equals(other._customPreferences, _customPreferences));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      emailNotifications,
      smsNotifications,
      whatsappNotifications,
      preferredContactMethod,
      preferredLanguage,
      const DeepCollectionEquality().hash(_productCategories),
      const DeepCollectionEquality().hash(_customPreferences));

  /// Create a copy of CustomerPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerPreferencesImplCopyWith<_$CustomerPreferencesImpl> get copyWith =>
      __$$CustomerPreferencesImplCopyWithImpl<_$CustomerPreferencesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerPreferencesImplToJson(
      this,
    );
  }
}

abstract class _CustomerPreferences implements CustomerPreferences {
  const factory _CustomerPreferences(
          {final bool emailNotifications,
          final bool smsNotifications,
          final bool whatsappNotifications,
          final String preferredContactMethod,
          final String? preferredLanguage,
          final List<String> productCategories,
          final Map<String, dynamic> customPreferences}) =
      _$CustomerPreferencesImpl;

  factory _CustomerPreferences.fromJson(Map<String, dynamic> json) =
      _$CustomerPreferencesImpl.fromJson;

  @override
  bool get emailNotifications;
  @override
  bool get smsNotifications;
  @override
  bool get whatsappNotifications;
  @override
  String get preferredContactMethod;
  @override
  String? get preferredLanguage;
  @override
  List<String> get productCategories;
  @override
  Map<String, dynamic> get customPreferences;

  /// Create a copy of CustomerPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerPreferencesImplCopyWith<_$CustomerPreferencesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
