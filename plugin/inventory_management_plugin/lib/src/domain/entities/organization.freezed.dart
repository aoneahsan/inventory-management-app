// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organization.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Organization _$OrganizationFromJson(Map<String, dynamic> json) {
  return _Organization.fromJson(json);
}

/// @nodoc
mixin _$Organization {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  SubscriptionTier get subscriptionTier => throw _privateConstructorUsedError;
  SubscriptionStatus get subscriptionStatus =>
      throw _privateConstructorUsedError;
  int get maxUsers => throw _privateConstructorUsedError;
  int get maxProducts => throw _privateConstructorUsedError;
  int get maxLocations => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Business details
  String? get logoUrl => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get taxNumber => throw _privateConstructorUsedError;
  String? get registrationNumber =>
      throw _privateConstructorUsedError; // Address
  String? get address => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get postalCode => throw _privateConstructorUsedError; // Settings
  OrganizationSettings? get settings =>
      throw _privateConstructorUsedError; // Subscription details
  DateTime? get subscriptionStartDate => throw _privateConstructorUsedError;
  DateTime? get subscriptionEndDate => throw _privateConstructorUsedError;
  DateTime? get trialEndDate => throw _privateConstructorUsedError;
  double get monthlyRevenue => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this Organization to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Organization
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrganizationCopyWith<Organization> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationCopyWith<$Res> {
  factory $OrganizationCopyWith(
          Organization value, $Res Function(Organization) then) =
      _$OrganizationCopyWithImpl<$Res, Organization>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? code,
      SubscriptionTier subscriptionTier,
      SubscriptionStatus subscriptionStatus,
      int maxUsers,
      int maxProducts,
      int maxLocations,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? logoUrl,
      String? website,
      String? email,
      String? phone,
      String? taxNumber,
      String? registrationNumber,
      String? address,
      String? city,
      String? state,
      String? country,
      String? postalCode,
      OrganizationSettings? settings,
      DateTime? subscriptionStartDate,
      DateTime? subscriptionEndDate,
      DateTime? trialEndDate,
      double monthlyRevenue,
      Map<String, dynamic> metadata});

  $OrganizationSettingsCopyWith<$Res>? get settings;
}

/// @nodoc
class _$OrganizationCopyWithImpl<$Res, $Val extends Organization>
    implements $OrganizationCopyWith<$Res> {
  _$OrganizationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Organization
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = freezed,
    Object? subscriptionTier = null,
    Object? subscriptionStatus = null,
    Object? maxUsers = null,
    Object? maxProducts = null,
    Object? maxLocations = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? logoUrl = freezed,
    Object? website = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? taxNumber = freezed,
    Object? registrationNumber = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = freezed,
    Object? postalCode = freezed,
    Object? settings = freezed,
    Object? subscriptionStartDate = freezed,
    Object? subscriptionEndDate = freezed,
    Object? trialEndDate = freezed,
    Object? monthlyRevenue = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionTier: null == subscriptionTier
          ? _value.subscriptionTier
          : subscriptionTier // ignore: cast_nullable_to_non_nullable
              as SubscriptionTier,
      subscriptionStatus: null == subscriptionStatus
          ? _value.subscriptionStatus
          : subscriptionStatus // ignore: cast_nullable_to_non_nullable
              as SubscriptionStatus,
      maxUsers: null == maxUsers
          ? _value.maxUsers
          : maxUsers // ignore: cast_nullable_to_non_nullable
              as int,
      maxProducts: null == maxProducts
          ? _value.maxProducts
          : maxProducts // ignore: cast_nullable_to_non_nullable
              as int,
      maxLocations: null == maxLocations
          ? _value.maxLocations
          : maxLocations // ignore: cast_nullable_to_non_nullable
              as int,
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
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      taxNumber: freezed == taxNumber
          ? _value.taxNumber
          : taxNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      registrationNumber: freezed == registrationNumber
          ? _value.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
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
      settings: freezed == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as OrganizationSettings?,
      subscriptionStartDate: freezed == subscriptionStartDate
          ? _value.subscriptionStartDate
          : subscriptionStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      subscriptionEndDate: freezed == subscriptionEndDate
          ? _value.subscriptionEndDate
          : subscriptionEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      trialEndDate: freezed == trialEndDate
          ? _value.trialEndDate
          : trialEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      monthlyRevenue: null == monthlyRevenue
          ? _value.monthlyRevenue
          : monthlyRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }

  /// Create a copy of Organization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrganizationSettingsCopyWith<$Res>? get settings {
    if (_value.settings == null) {
      return null;
    }

    return $OrganizationSettingsCopyWith<$Res>(_value.settings!, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrganizationImplCopyWith<$Res>
    implements $OrganizationCopyWith<$Res> {
  factory _$$OrganizationImplCopyWith(
          _$OrganizationImpl value, $Res Function(_$OrganizationImpl) then) =
      __$$OrganizationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? code,
      SubscriptionTier subscriptionTier,
      SubscriptionStatus subscriptionStatus,
      int maxUsers,
      int maxProducts,
      int maxLocations,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? logoUrl,
      String? website,
      String? email,
      String? phone,
      String? taxNumber,
      String? registrationNumber,
      String? address,
      String? city,
      String? state,
      String? country,
      String? postalCode,
      OrganizationSettings? settings,
      DateTime? subscriptionStartDate,
      DateTime? subscriptionEndDate,
      DateTime? trialEndDate,
      double monthlyRevenue,
      Map<String, dynamic> metadata});

  @override
  $OrganizationSettingsCopyWith<$Res>? get settings;
}

/// @nodoc
class __$$OrganizationImplCopyWithImpl<$Res>
    extends _$OrganizationCopyWithImpl<$Res, _$OrganizationImpl>
    implements _$$OrganizationImplCopyWith<$Res> {
  __$$OrganizationImplCopyWithImpl(
      _$OrganizationImpl _value, $Res Function(_$OrganizationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Organization
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = freezed,
    Object? subscriptionTier = null,
    Object? subscriptionStatus = null,
    Object? maxUsers = null,
    Object? maxProducts = null,
    Object? maxLocations = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? logoUrl = freezed,
    Object? website = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? taxNumber = freezed,
    Object? registrationNumber = freezed,
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = freezed,
    Object? postalCode = freezed,
    Object? settings = freezed,
    Object? subscriptionStartDate = freezed,
    Object? subscriptionEndDate = freezed,
    Object? trialEndDate = freezed,
    Object? monthlyRevenue = null,
    Object? metadata = null,
  }) {
    return _then(_$OrganizationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionTier: null == subscriptionTier
          ? _value.subscriptionTier
          : subscriptionTier // ignore: cast_nullable_to_non_nullable
              as SubscriptionTier,
      subscriptionStatus: null == subscriptionStatus
          ? _value.subscriptionStatus
          : subscriptionStatus // ignore: cast_nullable_to_non_nullable
              as SubscriptionStatus,
      maxUsers: null == maxUsers
          ? _value.maxUsers
          : maxUsers // ignore: cast_nullable_to_non_nullable
              as int,
      maxProducts: null == maxProducts
          ? _value.maxProducts
          : maxProducts // ignore: cast_nullable_to_non_nullable
              as int,
      maxLocations: null == maxLocations
          ? _value.maxLocations
          : maxLocations // ignore: cast_nullable_to_non_nullable
              as int,
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
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      taxNumber: freezed == taxNumber
          ? _value.taxNumber
          : taxNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      registrationNumber: freezed == registrationNumber
          ? _value.registrationNumber
          : registrationNumber // ignore: cast_nullable_to_non_nullable
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
      settings: freezed == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as OrganizationSettings?,
      subscriptionStartDate: freezed == subscriptionStartDate
          ? _value.subscriptionStartDate
          : subscriptionStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      subscriptionEndDate: freezed == subscriptionEndDate
          ? _value.subscriptionEndDate
          : subscriptionEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      trialEndDate: freezed == trialEndDate
          ? _value.trialEndDate
          : trialEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      monthlyRevenue: null == monthlyRevenue
          ? _value.monthlyRevenue
          : monthlyRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrganizationImpl extends _Organization {
  const _$OrganizationImpl(
      {required this.id,
      required this.name,
      this.code,
      this.subscriptionTier = 'free',
      this.subscriptionStatus = 'active',
      this.maxUsers = 1,
      this.maxProducts = 100,
      this.maxLocations = 1,
      required this.createdAt,
      required this.updatedAt,
      this.syncedAt,
      this.logoUrl,
      this.website,
      this.email,
      this.phone,
      this.taxNumber,
      this.registrationNumber,
      this.address,
      this.city,
      this.state,
      this.country,
      this.postalCode,
      this.settings,
      this.subscriptionStartDate,
      this.subscriptionEndDate,
      this.trialEndDate,
      this.monthlyRevenue = 0,
      final Map<String, dynamic> metadata = const {}})
      : _metadata = metadata,
        super._();

  factory _$OrganizationImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrganizationImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? code;
  @override
  @JsonKey()
  final SubscriptionTier subscriptionTier;
  @override
  @JsonKey()
  final SubscriptionStatus subscriptionStatus;
  @override
  @JsonKey()
  final int maxUsers;
  @override
  @JsonKey()
  final int maxProducts;
  @override
  @JsonKey()
  final int maxLocations;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? syncedAt;
// Business details
  @override
  final String? logoUrl;
  @override
  final String? website;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? taxNumber;
  @override
  final String? registrationNumber;
// Address
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
// Settings
  @override
  final OrganizationSettings? settings;
// Subscription details
  @override
  final DateTime? subscriptionStartDate;
  @override
  final DateTime? subscriptionEndDate;
  @override
  final DateTime? trialEndDate;
  @override
  @JsonKey()
  final double monthlyRevenue;
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
    return 'Organization(id: $id, name: $name, code: $code, subscriptionTier: $subscriptionTier, subscriptionStatus: $subscriptionStatus, maxUsers: $maxUsers, maxProducts: $maxProducts, maxLocations: $maxLocations, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt, logoUrl: $logoUrl, website: $website, email: $email, phone: $phone, taxNumber: $taxNumber, registrationNumber: $registrationNumber, address: $address, city: $city, state: $state, country: $country, postalCode: $postalCode, settings: $settings, subscriptionStartDate: $subscriptionStartDate, subscriptionEndDate: $subscriptionEndDate, trialEndDate: $trialEndDate, monthlyRevenue: $monthlyRevenue, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganizationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.subscriptionTier, subscriptionTier) ||
                other.subscriptionTier == subscriptionTier) &&
            (identical(other.subscriptionStatus, subscriptionStatus) ||
                other.subscriptionStatus == subscriptionStatus) &&
            (identical(other.maxUsers, maxUsers) ||
                other.maxUsers == maxUsers) &&
            (identical(other.maxProducts, maxProducts) ||
                other.maxProducts == maxProducts) &&
            (identical(other.maxLocations, maxLocations) ||
                other.maxLocations == maxLocations) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.taxNumber, taxNumber) ||
                other.taxNumber == taxNumber) &&
            (identical(other.registrationNumber, registrationNumber) ||
                other.registrationNumber == registrationNumber) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            (identical(other.subscriptionStartDate, subscriptionStartDate) ||
                other.subscriptionStartDate == subscriptionStartDate) &&
            (identical(other.subscriptionEndDate, subscriptionEndDate) ||
                other.subscriptionEndDate == subscriptionEndDate) &&
            (identical(other.trialEndDate, trialEndDate) ||
                other.trialEndDate == trialEndDate) &&
            (identical(other.monthlyRevenue, monthlyRevenue) ||
                other.monthlyRevenue == monthlyRevenue) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        code,
        subscriptionTier,
        subscriptionStatus,
        maxUsers,
        maxProducts,
        maxLocations,
        createdAt,
        updatedAt,
        syncedAt,
        logoUrl,
        website,
        email,
        phone,
        taxNumber,
        registrationNumber,
        address,
        city,
        state,
        country,
        postalCode,
        settings,
        subscriptionStartDate,
        subscriptionEndDate,
        trialEndDate,
        monthlyRevenue,
        const DeepCollectionEquality().hash(_metadata)
      ]);

  /// Create a copy of Organization
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationImplCopyWith<_$OrganizationImpl> get copyWith =>
      __$$OrganizationImplCopyWithImpl<_$OrganizationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganizationImplToJson(
      this,
    );
  }
}

abstract class _Organization extends Organization {
  const factory _Organization(
      {required final String id,
      required final String name,
      final String? code,
      final SubscriptionTier subscriptionTier,
      final SubscriptionStatus subscriptionStatus,
      final int maxUsers,
      final int maxProducts,
      final int maxLocations,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final DateTime? syncedAt,
      final String? logoUrl,
      final String? website,
      final String? email,
      final String? phone,
      final String? taxNumber,
      final String? registrationNumber,
      final String? address,
      final String? city,
      final String? state,
      final String? country,
      final String? postalCode,
      final OrganizationSettings? settings,
      final DateTime? subscriptionStartDate,
      final DateTime? subscriptionEndDate,
      final DateTime? trialEndDate,
      final double monthlyRevenue,
      final Map<String, dynamic> metadata}) = _$OrganizationImpl;
  const _Organization._() : super._();

  factory _Organization.fromJson(Map<String, dynamic> json) =
      _$OrganizationImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get code;
  @override
  SubscriptionTier get subscriptionTier;
  @override
  SubscriptionStatus get subscriptionStatus;
  @override
  int get maxUsers;
  @override
  int get maxProducts;
  @override
  int get maxLocations;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get syncedAt; // Business details
  @override
  String? get logoUrl;
  @override
  String? get website;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  String? get taxNumber;
  @override
  String? get registrationNumber; // Address
  @override
  String? get address;
  @override
  String? get city;
  @override
  String? get state;
  @override
  String? get country;
  @override
  String? get postalCode; // Settings
  @override
  OrganizationSettings? get settings; // Subscription details
  @override
  DateTime? get subscriptionStartDate;
  @override
  DateTime? get subscriptionEndDate;
  @override
  DateTime? get trialEndDate;
  @override
  double get monthlyRevenue;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of Organization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrganizationImplCopyWith<_$OrganizationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrganizationSettings _$OrganizationSettingsFromJson(Map<String, dynamic> json) {
  return _OrganizationSettings.fromJson(json);
}

/// @nodoc
mixin _$OrganizationSettings {
// Business settings
  String get currency => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  String get timezone => throw _privateConstructorUsedError;
  String get dateFormat => throw _privateConstructorUsedError;
  String get timeFormat => throw _privateConstructorUsedError;
  int get decimalPlaces =>
      throw _privateConstructorUsedError; // Inventory settings
  bool get trackInventory => throw _privateConstructorUsedError;
  bool get allowNegativeStock => throw _privateConstructorUsedError;
  bool get enableLowStockAlerts => throw _privateConstructorUsedError;
  int get lowStockThreshold => throw _privateConstructorUsedError;
  bool get enableExpiryAlerts => throw _privateConstructorUsedError;
  int get expiryAlertDays =>
      throw _privateConstructorUsedError; // Sales settings
  bool get enablePOS => throw _privateConstructorUsedError;
  bool get enableQuotes => throw _privateConstructorUsedError;
  bool get enableInvoices => throw _privateConstructorUsedError;
  bool get enableReceipts => throw _privateConstructorUsedError;
  bool get requireCustomerForSale => throw _privateConstructorUsedError;
  bool get enableLayaway => throw _privateConstructorUsedError;
  int get defaultPaymentTerms =>
      throw _privateConstructorUsedError; // Tax settings
  bool get enableTax => throw _privateConstructorUsedError;
  String get taxType =>
      throw _privateConstructorUsedError; // inclusive or exclusive
  double get defaultTaxRate => throw _privateConstructorUsedError;
  bool get enableCompoundTax =>
      throw _privateConstructorUsedError; // Barcode settings
  bool get enableBarcodeScanning => throw _privateConstructorUsedError;
  String get defaultBarcodeFormat => throw _privateConstructorUsedError;
  bool get autogenerateBarcodes => throw _privateConstructorUsedError;
  String? get barcodePrefix =>
      throw _privateConstructorUsedError; // Notification settings
  bool get emailNotifications => throw _privateConstructorUsedError;
  bool get smsNotifications => throw _privateConstructorUsedError;
  bool get pushNotifications => throw _privateConstructorUsedError;
  List<String> get notificationEmails =>
      throw _privateConstructorUsedError; // Print settings
  String get paperSize => throw _privateConstructorUsedError;
  bool get printLogo => throw _privateConstructorUsedError;
  bool get printAddress => throw _privateConstructorUsedError;
  bool get printTaxNumber => throw _privateConstructorUsedError;
  String? get printHeader => throw _privateConstructorUsedError;
  String? get printFooter =>
      throw _privateConstructorUsedError; // Custom fields
  Map<String, dynamic> get customFields => throw _privateConstructorUsedError;

  /// Serializes this OrganizationSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrganizationSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrganizationSettingsCopyWith<OrganizationSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationSettingsCopyWith<$Res> {
  factory $OrganizationSettingsCopyWith(OrganizationSettings value,
          $Res Function(OrganizationSettings) then) =
      _$OrganizationSettingsCopyWithImpl<$Res, OrganizationSettings>;
  @useResult
  $Res call(
      {String currency,
      String language,
      String timezone,
      String dateFormat,
      String timeFormat,
      int decimalPlaces,
      bool trackInventory,
      bool allowNegativeStock,
      bool enableLowStockAlerts,
      int lowStockThreshold,
      bool enableExpiryAlerts,
      int expiryAlertDays,
      bool enablePOS,
      bool enableQuotes,
      bool enableInvoices,
      bool enableReceipts,
      bool requireCustomerForSale,
      bool enableLayaway,
      int defaultPaymentTerms,
      bool enableTax,
      String taxType,
      double defaultTaxRate,
      bool enableCompoundTax,
      bool enableBarcodeScanning,
      String defaultBarcodeFormat,
      bool autogenerateBarcodes,
      String? barcodePrefix,
      bool emailNotifications,
      bool smsNotifications,
      bool pushNotifications,
      List<String> notificationEmails,
      String paperSize,
      bool printLogo,
      bool printAddress,
      bool printTaxNumber,
      String? printHeader,
      String? printFooter,
      Map<String, dynamic> customFields});
}

/// @nodoc
class _$OrganizationSettingsCopyWithImpl<$Res,
        $Val extends OrganizationSettings>
    implements $OrganizationSettingsCopyWith<$Res> {
  _$OrganizationSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrganizationSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currency = null,
    Object? language = null,
    Object? timezone = null,
    Object? dateFormat = null,
    Object? timeFormat = null,
    Object? decimalPlaces = null,
    Object? trackInventory = null,
    Object? allowNegativeStock = null,
    Object? enableLowStockAlerts = null,
    Object? lowStockThreshold = null,
    Object? enableExpiryAlerts = null,
    Object? expiryAlertDays = null,
    Object? enablePOS = null,
    Object? enableQuotes = null,
    Object? enableInvoices = null,
    Object? enableReceipts = null,
    Object? requireCustomerForSale = null,
    Object? enableLayaway = null,
    Object? defaultPaymentTerms = null,
    Object? enableTax = null,
    Object? taxType = null,
    Object? defaultTaxRate = null,
    Object? enableCompoundTax = null,
    Object? enableBarcodeScanning = null,
    Object? defaultBarcodeFormat = null,
    Object? autogenerateBarcodes = null,
    Object? barcodePrefix = freezed,
    Object? emailNotifications = null,
    Object? smsNotifications = null,
    Object? pushNotifications = null,
    Object? notificationEmails = null,
    Object? paperSize = null,
    Object? printLogo = null,
    Object? printAddress = null,
    Object? printTaxNumber = null,
    Object? printHeader = freezed,
    Object? printFooter = freezed,
    Object? customFields = null,
  }) {
    return _then(_value.copyWith(
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      timezone: null == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String,
      dateFormat: null == dateFormat
          ? _value.dateFormat
          : dateFormat // ignore: cast_nullable_to_non_nullable
              as String,
      timeFormat: null == timeFormat
          ? _value.timeFormat
          : timeFormat // ignore: cast_nullable_to_non_nullable
              as String,
      decimalPlaces: null == decimalPlaces
          ? _value.decimalPlaces
          : decimalPlaces // ignore: cast_nullable_to_non_nullable
              as int,
      trackInventory: null == trackInventory
          ? _value.trackInventory
          : trackInventory // ignore: cast_nullable_to_non_nullable
              as bool,
      allowNegativeStock: null == allowNegativeStock
          ? _value.allowNegativeStock
          : allowNegativeStock // ignore: cast_nullable_to_non_nullable
              as bool,
      enableLowStockAlerts: null == enableLowStockAlerts
          ? _value.enableLowStockAlerts
          : enableLowStockAlerts // ignore: cast_nullable_to_non_nullable
              as bool,
      lowStockThreshold: null == lowStockThreshold
          ? _value.lowStockThreshold
          : lowStockThreshold // ignore: cast_nullable_to_non_nullable
              as int,
      enableExpiryAlerts: null == enableExpiryAlerts
          ? _value.enableExpiryAlerts
          : enableExpiryAlerts // ignore: cast_nullable_to_non_nullable
              as bool,
      expiryAlertDays: null == expiryAlertDays
          ? _value.expiryAlertDays
          : expiryAlertDays // ignore: cast_nullable_to_non_nullable
              as int,
      enablePOS: null == enablePOS
          ? _value.enablePOS
          : enablePOS // ignore: cast_nullable_to_non_nullable
              as bool,
      enableQuotes: null == enableQuotes
          ? _value.enableQuotes
          : enableQuotes // ignore: cast_nullable_to_non_nullable
              as bool,
      enableInvoices: null == enableInvoices
          ? _value.enableInvoices
          : enableInvoices // ignore: cast_nullable_to_non_nullable
              as bool,
      enableReceipts: null == enableReceipts
          ? _value.enableReceipts
          : enableReceipts // ignore: cast_nullable_to_non_nullable
              as bool,
      requireCustomerForSale: null == requireCustomerForSale
          ? _value.requireCustomerForSale
          : requireCustomerForSale // ignore: cast_nullable_to_non_nullable
              as bool,
      enableLayaway: null == enableLayaway
          ? _value.enableLayaway
          : enableLayaway // ignore: cast_nullable_to_non_nullable
              as bool,
      defaultPaymentTerms: null == defaultPaymentTerms
          ? _value.defaultPaymentTerms
          : defaultPaymentTerms // ignore: cast_nullable_to_non_nullable
              as int,
      enableTax: null == enableTax
          ? _value.enableTax
          : enableTax // ignore: cast_nullable_to_non_nullable
              as bool,
      taxType: null == taxType
          ? _value.taxType
          : taxType // ignore: cast_nullable_to_non_nullable
              as String,
      defaultTaxRate: null == defaultTaxRate
          ? _value.defaultTaxRate
          : defaultTaxRate // ignore: cast_nullable_to_non_nullable
              as double,
      enableCompoundTax: null == enableCompoundTax
          ? _value.enableCompoundTax
          : enableCompoundTax // ignore: cast_nullable_to_non_nullable
              as bool,
      enableBarcodeScanning: null == enableBarcodeScanning
          ? _value.enableBarcodeScanning
          : enableBarcodeScanning // ignore: cast_nullable_to_non_nullable
              as bool,
      defaultBarcodeFormat: null == defaultBarcodeFormat
          ? _value.defaultBarcodeFormat
          : defaultBarcodeFormat // ignore: cast_nullable_to_non_nullable
              as String,
      autogenerateBarcodes: null == autogenerateBarcodes
          ? _value.autogenerateBarcodes
          : autogenerateBarcodes // ignore: cast_nullable_to_non_nullable
              as bool,
      barcodePrefix: freezed == barcodePrefix
          ? _value.barcodePrefix
          : barcodePrefix // ignore: cast_nullable_to_non_nullable
              as String?,
      emailNotifications: null == emailNotifications
          ? _value.emailNotifications
          : emailNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      smsNotifications: null == smsNotifications
          ? _value.smsNotifications
          : smsNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      pushNotifications: null == pushNotifications
          ? _value.pushNotifications
          : pushNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      notificationEmails: null == notificationEmails
          ? _value.notificationEmails
          : notificationEmails // ignore: cast_nullable_to_non_nullable
              as List<String>,
      paperSize: null == paperSize
          ? _value.paperSize
          : paperSize // ignore: cast_nullable_to_non_nullable
              as String,
      printLogo: null == printLogo
          ? _value.printLogo
          : printLogo // ignore: cast_nullable_to_non_nullable
              as bool,
      printAddress: null == printAddress
          ? _value.printAddress
          : printAddress // ignore: cast_nullable_to_non_nullable
              as bool,
      printTaxNumber: null == printTaxNumber
          ? _value.printTaxNumber
          : printTaxNumber // ignore: cast_nullable_to_non_nullable
              as bool,
      printHeader: freezed == printHeader
          ? _value.printHeader
          : printHeader // ignore: cast_nullable_to_non_nullable
              as String?,
      printFooter: freezed == printFooter
          ? _value.printFooter
          : printFooter // ignore: cast_nullable_to_non_nullable
              as String?,
      customFields: null == customFields
          ? _value.customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrganizationSettingsImplCopyWith<$Res>
    implements $OrganizationSettingsCopyWith<$Res> {
  factory _$$OrganizationSettingsImplCopyWith(_$OrganizationSettingsImpl value,
          $Res Function(_$OrganizationSettingsImpl) then) =
      __$$OrganizationSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String currency,
      String language,
      String timezone,
      String dateFormat,
      String timeFormat,
      int decimalPlaces,
      bool trackInventory,
      bool allowNegativeStock,
      bool enableLowStockAlerts,
      int lowStockThreshold,
      bool enableExpiryAlerts,
      int expiryAlertDays,
      bool enablePOS,
      bool enableQuotes,
      bool enableInvoices,
      bool enableReceipts,
      bool requireCustomerForSale,
      bool enableLayaway,
      int defaultPaymentTerms,
      bool enableTax,
      String taxType,
      double defaultTaxRate,
      bool enableCompoundTax,
      bool enableBarcodeScanning,
      String defaultBarcodeFormat,
      bool autogenerateBarcodes,
      String? barcodePrefix,
      bool emailNotifications,
      bool smsNotifications,
      bool pushNotifications,
      List<String> notificationEmails,
      String paperSize,
      bool printLogo,
      bool printAddress,
      bool printTaxNumber,
      String? printHeader,
      String? printFooter,
      Map<String, dynamic> customFields});
}

/// @nodoc
class __$$OrganizationSettingsImplCopyWithImpl<$Res>
    extends _$OrganizationSettingsCopyWithImpl<$Res, _$OrganizationSettingsImpl>
    implements _$$OrganizationSettingsImplCopyWith<$Res> {
  __$$OrganizationSettingsImplCopyWithImpl(_$OrganizationSettingsImpl _value,
      $Res Function(_$OrganizationSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrganizationSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currency = null,
    Object? language = null,
    Object? timezone = null,
    Object? dateFormat = null,
    Object? timeFormat = null,
    Object? decimalPlaces = null,
    Object? trackInventory = null,
    Object? allowNegativeStock = null,
    Object? enableLowStockAlerts = null,
    Object? lowStockThreshold = null,
    Object? enableExpiryAlerts = null,
    Object? expiryAlertDays = null,
    Object? enablePOS = null,
    Object? enableQuotes = null,
    Object? enableInvoices = null,
    Object? enableReceipts = null,
    Object? requireCustomerForSale = null,
    Object? enableLayaway = null,
    Object? defaultPaymentTerms = null,
    Object? enableTax = null,
    Object? taxType = null,
    Object? defaultTaxRate = null,
    Object? enableCompoundTax = null,
    Object? enableBarcodeScanning = null,
    Object? defaultBarcodeFormat = null,
    Object? autogenerateBarcodes = null,
    Object? barcodePrefix = freezed,
    Object? emailNotifications = null,
    Object? smsNotifications = null,
    Object? pushNotifications = null,
    Object? notificationEmails = null,
    Object? paperSize = null,
    Object? printLogo = null,
    Object? printAddress = null,
    Object? printTaxNumber = null,
    Object? printHeader = freezed,
    Object? printFooter = freezed,
    Object? customFields = null,
  }) {
    return _then(_$OrganizationSettingsImpl(
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      timezone: null == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String,
      dateFormat: null == dateFormat
          ? _value.dateFormat
          : dateFormat // ignore: cast_nullable_to_non_nullable
              as String,
      timeFormat: null == timeFormat
          ? _value.timeFormat
          : timeFormat // ignore: cast_nullable_to_non_nullable
              as String,
      decimalPlaces: null == decimalPlaces
          ? _value.decimalPlaces
          : decimalPlaces // ignore: cast_nullable_to_non_nullable
              as int,
      trackInventory: null == trackInventory
          ? _value.trackInventory
          : trackInventory // ignore: cast_nullable_to_non_nullable
              as bool,
      allowNegativeStock: null == allowNegativeStock
          ? _value.allowNegativeStock
          : allowNegativeStock // ignore: cast_nullable_to_non_nullable
              as bool,
      enableLowStockAlerts: null == enableLowStockAlerts
          ? _value.enableLowStockAlerts
          : enableLowStockAlerts // ignore: cast_nullable_to_non_nullable
              as bool,
      lowStockThreshold: null == lowStockThreshold
          ? _value.lowStockThreshold
          : lowStockThreshold // ignore: cast_nullable_to_non_nullable
              as int,
      enableExpiryAlerts: null == enableExpiryAlerts
          ? _value.enableExpiryAlerts
          : enableExpiryAlerts // ignore: cast_nullable_to_non_nullable
              as bool,
      expiryAlertDays: null == expiryAlertDays
          ? _value.expiryAlertDays
          : expiryAlertDays // ignore: cast_nullable_to_non_nullable
              as int,
      enablePOS: null == enablePOS
          ? _value.enablePOS
          : enablePOS // ignore: cast_nullable_to_non_nullable
              as bool,
      enableQuotes: null == enableQuotes
          ? _value.enableQuotes
          : enableQuotes // ignore: cast_nullable_to_non_nullable
              as bool,
      enableInvoices: null == enableInvoices
          ? _value.enableInvoices
          : enableInvoices // ignore: cast_nullable_to_non_nullable
              as bool,
      enableReceipts: null == enableReceipts
          ? _value.enableReceipts
          : enableReceipts // ignore: cast_nullable_to_non_nullable
              as bool,
      requireCustomerForSale: null == requireCustomerForSale
          ? _value.requireCustomerForSale
          : requireCustomerForSale // ignore: cast_nullable_to_non_nullable
              as bool,
      enableLayaway: null == enableLayaway
          ? _value.enableLayaway
          : enableLayaway // ignore: cast_nullable_to_non_nullable
              as bool,
      defaultPaymentTerms: null == defaultPaymentTerms
          ? _value.defaultPaymentTerms
          : defaultPaymentTerms // ignore: cast_nullable_to_non_nullable
              as int,
      enableTax: null == enableTax
          ? _value.enableTax
          : enableTax // ignore: cast_nullable_to_non_nullable
              as bool,
      taxType: null == taxType
          ? _value.taxType
          : taxType // ignore: cast_nullable_to_non_nullable
              as String,
      defaultTaxRate: null == defaultTaxRate
          ? _value.defaultTaxRate
          : defaultTaxRate // ignore: cast_nullable_to_non_nullable
              as double,
      enableCompoundTax: null == enableCompoundTax
          ? _value.enableCompoundTax
          : enableCompoundTax // ignore: cast_nullable_to_non_nullable
              as bool,
      enableBarcodeScanning: null == enableBarcodeScanning
          ? _value.enableBarcodeScanning
          : enableBarcodeScanning // ignore: cast_nullable_to_non_nullable
              as bool,
      defaultBarcodeFormat: null == defaultBarcodeFormat
          ? _value.defaultBarcodeFormat
          : defaultBarcodeFormat // ignore: cast_nullable_to_non_nullable
              as String,
      autogenerateBarcodes: null == autogenerateBarcodes
          ? _value.autogenerateBarcodes
          : autogenerateBarcodes // ignore: cast_nullable_to_non_nullable
              as bool,
      barcodePrefix: freezed == barcodePrefix
          ? _value.barcodePrefix
          : barcodePrefix // ignore: cast_nullable_to_non_nullable
              as String?,
      emailNotifications: null == emailNotifications
          ? _value.emailNotifications
          : emailNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      smsNotifications: null == smsNotifications
          ? _value.smsNotifications
          : smsNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      pushNotifications: null == pushNotifications
          ? _value.pushNotifications
          : pushNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      notificationEmails: null == notificationEmails
          ? _value._notificationEmails
          : notificationEmails // ignore: cast_nullable_to_non_nullable
              as List<String>,
      paperSize: null == paperSize
          ? _value.paperSize
          : paperSize // ignore: cast_nullable_to_non_nullable
              as String,
      printLogo: null == printLogo
          ? _value.printLogo
          : printLogo // ignore: cast_nullable_to_non_nullable
              as bool,
      printAddress: null == printAddress
          ? _value.printAddress
          : printAddress // ignore: cast_nullable_to_non_nullable
              as bool,
      printTaxNumber: null == printTaxNumber
          ? _value.printTaxNumber
          : printTaxNumber // ignore: cast_nullable_to_non_nullable
              as bool,
      printHeader: freezed == printHeader
          ? _value.printHeader
          : printHeader // ignore: cast_nullable_to_non_nullable
              as String?,
      printFooter: freezed == printFooter
          ? _value.printFooter
          : printFooter // ignore: cast_nullable_to_non_nullable
              as String?,
      customFields: null == customFields
          ? _value._customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrganizationSettingsImpl implements _OrganizationSettings {
  const _$OrganizationSettingsImpl(
      {this.currency = 'USD',
      this.language = 'en',
      this.timezone = 'UTC',
      this.dateFormat = 'YYYY-MM-DD',
      this.timeFormat = '24h',
      this.decimalPlaces = 2,
      this.trackInventory = true,
      this.allowNegativeStock = true,
      this.enableLowStockAlerts = true,
      this.lowStockThreshold = 10,
      this.enableExpiryAlerts = true,
      this.expiryAlertDays = 30,
      this.enablePOS = true,
      this.enableQuotes = true,
      this.enableInvoices = true,
      this.enableReceipts = true,
      this.requireCustomerForSale = true,
      this.enableLayaway = false,
      this.defaultPaymentTerms = 30,
      this.enableTax = true,
      this.taxType = 'exclusive',
      this.defaultTaxRate = 0,
      this.enableCompoundTax = false,
      this.enableBarcodeScanning = true,
      this.defaultBarcodeFormat = 'CODE128',
      this.autogenerateBarcodes = true,
      this.barcodePrefix,
      this.emailNotifications = true,
      this.smsNotifications = true,
      this.pushNotifications = true,
      final List<String> notificationEmails = const [],
      this.paperSize = 'A4',
      this.printLogo = true,
      this.printAddress = true,
      this.printTaxNumber = true,
      this.printHeader,
      this.printFooter,
      final Map<String, dynamic> customFields = const {}})
      : _notificationEmails = notificationEmails,
        _customFields = customFields;

  factory _$OrganizationSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrganizationSettingsImplFromJson(json);

// Business settings
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey()
  final String language;
  @override
  @JsonKey()
  final String timezone;
  @override
  @JsonKey()
  final String dateFormat;
  @override
  @JsonKey()
  final String timeFormat;
  @override
  @JsonKey()
  final int decimalPlaces;
// Inventory settings
  @override
  @JsonKey()
  final bool trackInventory;
  @override
  @JsonKey()
  final bool allowNegativeStock;
  @override
  @JsonKey()
  final bool enableLowStockAlerts;
  @override
  @JsonKey()
  final int lowStockThreshold;
  @override
  @JsonKey()
  final bool enableExpiryAlerts;
  @override
  @JsonKey()
  final int expiryAlertDays;
// Sales settings
  @override
  @JsonKey()
  final bool enablePOS;
  @override
  @JsonKey()
  final bool enableQuotes;
  @override
  @JsonKey()
  final bool enableInvoices;
  @override
  @JsonKey()
  final bool enableReceipts;
  @override
  @JsonKey()
  final bool requireCustomerForSale;
  @override
  @JsonKey()
  final bool enableLayaway;
  @override
  @JsonKey()
  final int defaultPaymentTerms;
// Tax settings
  @override
  @JsonKey()
  final bool enableTax;
  @override
  @JsonKey()
  final String taxType;
// inclusive or exclusive
  @override
  @JsonKey()
  final double defaultTaxRate;
  @override
  @JsonKey()
  final bool enableCompoundTax;
// Barcode settings
  @override
  @JsonKey()
  final bool enableBarcodeScanning;
  @override
  @JsonKey()
  final String defaultBarcodeFormat;
  @override
  @JsonKey()
  final bool autogenerateBarcodes;
  @override
  final String? barcodePrefix;
// Notification settings
  @override
  @JsonKey()
  final bool emailNotifications;
  @override
  @JsonKey()
  final bool smsNotifications;
  @override
  @JsonKey()
  final bool pushNotifications;
  final List<String> _notificationEmails;
  @override
  @JsonKey()
  List<String> get notificationEmails {
    if (_notificationEmails is EqualUnmodifiableListView)
      return _notificationEmails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notificationEmails);
  }

// Print settings
  @override
  @JsonKey()
  final String paperSize;
  @override
  @JsonKey()
  final bool printLogo;
  @override
  @JsonKey()
  final bool printAddress;
  @override
  @JsonKey()
  final bool printTaxNumber;
  @override
  final String? printHeader;
  @override
  final String? printFooter;
// Custom fields
  final Map<String, dynamic> _customFields;
// Custom fields
  @override
  @JsonKey()
  Map<String, dynamic> get customFields {
    if (_customFields is EqualUnmodifiableMapView) return _customFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_customFields);
  }

  @override
  String toString() {
    return 'OrganizationSettings(currency: $currency, language: $language, timezone: $timezone, dateFormat: $dateFormat, timeFormat: $timeFormat, decimalPlaces: $decimalPlaces, trackInventory: $trackInventory, allowNegativeStock: $allowNegativeStock, enableLowStockAlerts: $enableLowStockAlerts, lowStockThreshold: $lowStockThreshold, enableExpiryAlerts: $enableExpiryAlerts, expiryAlertDays: $expiryAlertDays, enablePOS: $enablePOS, enableQuotes: $enableQuotes, enableInvoices: $enableInvoices, enableReceipts: $enableReceipts, requireCustomerForSale: $requireCustomerForSale, enableLayaway: $enableLayaway, defaultPaymentTerms: $defaultPaymentTerms, enableTax: $enableTax, taxType: $taxType, defaultTaxRate: $defaultTaxRate, enableCompoundTax: $enableCompoundTax, enableBarcodeScanning: $enableBarcodeScanning, defaultBarcodeFormat: $defaultBarcodeFormat, autogenerateBarcodes: $autogenerateBarcodes, barcodePrefix: $barcodePrefix, emailNotifications: $emailNotifications, smsNotifications: $smsNotifications, pushNotifications: $pushNotifications, notificationEmails: $notificationEmails, paperSize: $paperSize, printLogo: $printLogo, printAddress: $printAddress, printTaxNumber: $printTaxNumber, printHeader: $printHeader, printFooter: $printFooter, customFields: $customFields)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganizationSettingsImpl &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.dateFormat, dateFormat) ||
                other.dateFormat == dateFormat) &&
            (identical(other.timeFormat, timeFormat) ||
                other.timeFormat == timeFormat) &&
            (identical(other.decimalPlaces, decimalPlaces) ||
                other.decimalPlaces == decimalPlaces) &&
            (identical(other.trackInventory, trackInventory) ||
                other.trackInventory == trackInventory) &&
            (identical(other.allowNegativeStock, allowNegativeStock) ||
                other.allowNegativeStock == allowNegativeStock) &&
            (identical(other.enableLowStockAlerts, enableLowStockAlerts) ||
                other.enableLowStockAlerts == enableLowStockAlerts) &&
            (identical(other.lowStockThreshold, lowStockThreshold) ||
                other.lowStockThreshold == lowStockThreshold) &&
            (identical(other.enableExpiryAlerts, enableExpiryAlerts) ||
                other.enableExpiryAlerts == enableExpiryAlerts) &&
            (identical(other.expiryAlertDays, expiryAlertDays) ||
                other.expiryAlertDays == expiryAlertDays) &&
            (identical(other.enablePOS, enablePOS) ||
                other.enablePOS == enablePOS) &&
            (identical(other.enableQuotes, enableQuotes) ||
                other.enableQuotes == enableQuotes) &&
            (identical(other.enableInvoices, enableInvoices) ||
                other.enableInvoices == enableInvoices) &&
            (identical(other.enableReceipts, enableReceipts) ||
                other.enableReceipts == enableReceipts) &&
            (identical(other.requireCustomerForSale, requireCustomerForSale) ||
                other.requireCustomerForSale == requireCustomerForSale) &&
            (identical(other.enableLayaway, enableLayaway) ||
                other.enableLayaway == enableLayaway) &&
            (identical(other.defaultPaymentTerms, defaultPaymentTerms) ||
                other.defaultPaymentTerms == defaultPaymentTerms) &&
            (identical(other.enableTax, enableTax) ||
                other.enableTax == enableTax) &&
            (identical(other.taxType, taxType) || other.taxType == taxType) &&
            (identical(other.defaultTaxRate, defaultTaxRate) ||
                other.defaultTaxRate == defaultTaxRate) &&
            (identical(other.enableCompoundTax, enableCompoundTax) ||
                other.enableCompoundTax == enableCompoundTax) &&
            (identical(other.enableBarcodeScanning, enableBarcodeScanning) ||
                other.enableBarcodeScanning == enableBarcodeScanning) &&
            (identical(other.defaultBarcodeFormat, defaultBarcodeFormat) ||
                other.defaultBarcodeFormat == defaultBarcodeFormat) &&
            (identical(other.autogenerateBarcodes, autogenerateBarcodes) ||
                other.autogenerateBarcodes == autogenerateBarcodes) &&
            (identical(other.barcodePrefix, barcodePrefix) ||
                other.barcodePrefix == barcodePrefix) &&
            (identical(other.emailNotifications, emailNotifications) ||
                other.emailNotifications == emailNotifications) &&
            (identical(other.smsNotifications, smsNotifications) ||
                other.smsNotifications == smsNotifications) &&
            (identical(other.pushNotifications, pushNotifications) ||
                other.pushNotifications == pushNotifications) &&
            const DeepCollectionEquality()
                .equals(other._notificationEmails, _notificationEmails) &&
            (identical(other.paperSize, paperSize) ||
                other.paperSize == paperSize) &&
            (identical(other.printLogo, printLogo) ||
                other.printLogo == printLogo) &&
            (identical(other.printAddress, printAddress) ||
                other.printAddress == printAddress) &&
            (identical(other.printTaxNumber, printTaxNumber) ||
                other.printTaxNumber == printTaxNumber) &&
            (identical(other.printHeader, printHeader) ||
                other.printHeader == printHeader) &&
            (identical(other.printFooter, printFooter) ||
                other.printFooter == printFooter) &&
            const DeepCollectionEquality()
                .equals(other._customFields, _customFields));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        currency,
        language,
        timezone,
        dateFormat,
        timeFormat,
        decimalPlaces,
        trackInventory,
        allowNegativeStock,
        enableLowStockAlerts,
        lowStockThreshold,
        enableExpiryAlerts,
        expiryAlertDays,
        enablePOS,
        enableQuotes,
        enableInvoices,
        enableReceipts,
        requireCustomerForSale,
        enableLayaway,
        defaultPaymentTerms,
        enableTax,
        taxType,
        defaultTaxRate,
        enableCompoundTax,
        enableBarcodeScanning,
        defaultBarcodeFormat,
        autogenerateBarcodes,
        barcodePrefix,
        emailNotifications,
        smsNotifications,
        pushNotifications,
        const DeepCollectionEquality().hash(_notificationEmails),
        paperSize,
        printLogo,
        printAddress,
        printTaxNumber,
        printHeader,
        printFooter,
        const DeepCollectionEquality().hash(_customFields)
      ]);

  /// Create a copy of OrganizationSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationSettingsImplCopyWith<_$OrganizationSettingsImpl>
      get copyWith =>
          __$$OrganizationSettingsImplCopyWithImpl<_$OrganizationSettingsImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganizationSettingsImplToJson(
      this,
    );
  }
}

abstract class _OrganizationSettings implements OrganizationSettings {
  const factory _OrganizationSettings(
      {final String currency,
      final String language,
      final String timezone,
      final String dateFormat,
      final String timeFormat,
      final int decimalPlaces,
      final bool trackInventory,
      final bool allowNegativeStock,
      final bool enableLowStockAlerts,
      final int lowStockThreshold,
      final bool enableExpiryAlerts,
      final int expiryAlertDays,
      final bool enablePOS,
      final bool enableQuotes,
      final bool enableInvoices,
      final bool enableReceipts,
      final bool requireCustomerForSale,
      final bool enableLayaway,
      final int defaultPaymentTerms,
      final bool enableTax,
      final String taxType,
      final double defaultTaxRate,
      final bool enableCompoundTax,
      final bool enableBarcodeScanning,
      final String defaultBarcodeFormat,
      final bool autogenerateBarcodes,
      final String? barcodePrefix,
      final bool emailNotifications,
      final bool smsNotifications,
      final bool pushNotifications,
      final List<String> notificationEmails,
      final String paperSize,
      final bool printLogo,
      final bool printAddress,
      final bool printTaxNumber,
      final String? printHeader,
      final String? printFooter,
      final Map<String, dynamic> customFields}) = _$OrganizationSettingsImpl;

  factory _OrganizationSettings.fromJson(Map<String, dynamic> json) =
      _$OrganizationSettingsImpl.fromJson;

// Business settings
  @override
  String get currency;
  @override
  String get language;
  @override
  String get timezone;
  @override
  String get dateFormat;
  @override
  String get timeFormat;
  @override
  int get decimalPlaces; // Inventory settings
  @override
  bool get trackInventory;
  @override
  bool get allowNegativeStock;
  @override
  bool get enableLowStockAlerts;
  @override
  int get lowStockThreshold;
  @override
  bool get enableExpiryAlerts;
  @override
  int get expiryAlertDays; // Sales settings
  @override
  bool get enablePOS;
  @override
  bool get enableQuotes;
  @override
  bool get enableInvoices;
  @override
  bool get enableReceipts;
  @override
  bool get requireCustomerForSale;
  @override
  bool get enableLayaway;
  @override
  int get defaultPaymentTerms; // Tax settings
  @override
  bool get enableTax;
  @override
  String get taxType; // inclusive or exclusive
  @override
  double get defaultTaxRate;
  @override
  bool get enableCompoundTax; // Barcode settings
  @override
  bool get enableBarcodeScanning;
  @override
  String get defaultBarcodeFormat;
  @override
  bool get autogenerateBarcodes;
  @override
  String? get barcodePrefix; // Notification settings
  @override
  bool get emailNotifications;
  @override
  bool get smsNotifications;
  @override
  bool get pushNotifications;
  @override
  List<String> get notificationEmails; // Print settings
  @override
  String get paperSize;
  @override
  bool get printLogo;
  @override
  bool get printAddress;
  @override
  bool get printTaxNumber;
  @override
  String? get printHeader;
  @override
  String? get printFooter; // Custom fields
  @override
  Map<String, dynamic> get customFields;

  /// Create a copy of OrganizationSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrganizationSettingsImplCopyWith<_$OrganizationSettingsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
