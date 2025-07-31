// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'branch.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Branch _$BranchFromJson(Map<String, dynamic> json) {
  return _Branch.fromJson(json);
}

/// @nodoc
mixin _$Branch {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String get branchType => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get postalCode => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get managerId => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  Map<String, dynamic>? get settings => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional fields for plugin
  bool get isDefault => throw _privateConstructorUsedError;
  bool get isWarehouse => throw _privateConstructorUsedError;
  String? get timezone => throw _privateConstructorUsedError;
  Map<String, String> get operatingHours =>
      throw _privateConstructorUsedError; // {"monday": "9:00-18:00"}
  List<String> get staffIds => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  bool get allowPOS => throw _privateConstructorUsedError;
  bool get allowOnlineOrders => throw _privateConstructorUsedError;
  bool get allowPickup => throw _privateConstructorUsedError;
  bool get allowDelivery => throw _privateConstructorUsedError;
  double get deliveryRadius => throw _privateConstructorUsedError; // in km
  double get minimumOrderAmount => throw _privateConstructorUsedError;
  double get deliveryFee => throw _privateConstructorUsedError;
  String? get taxRegistrationNumber => throw _privateConstructorUsedError;
  List<String> get paymentMethods => throw _privateConstructorUsedError;
  Map<String, bool> get features => throw _privateConstructorUsedError;

  /// Serializes this Branch to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Branch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BranchCopyWith<Branch> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BranchCopyWith<$Res> {
  factory $BranchCopyWith(Branch value, $Res Function(Branch) then) =
      _$BranchCopyWithImpl<$Res, Branch>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String name,
      String? code,
      String branchType,
      String? address,
      String? city,
      String? state,
      String? country,
      String? postalCode,
      String? phone,
      String? email,
      String? managerId,
      bool isActive,
      Map<String, dynamic>? settings,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      bool isDefault,
      bool isWarehouse,
      String? timezone,
      Map<String, String> operatingHours,
      List<String> staffIds,
      double latitude,
      double longitude,
      String? imageUrl,
      Map<String, dynamic> metadata,
      bool allowPOS,
      bool allowOnlineOrders,
      bool allowPickup,
      bool allowDelivery,
      double deliveryRadius,
      double minimumOrderAmount,
      double deliveryFee,
      String? taxRegistrationNumber,
      List<String> paymentMethods,
      Map<String, bool> features});
}

/// @nodoc
class _$BranchCopyWithImpl<$Res, $Val extends Branch>
    implements $BranchCopyWith<$Res> {
  _$BranchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Branch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? name = null,
    Object? code = freezed,
    Object? branchType = null,
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = freezed,
    Object? postalCode = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? managerId = freezed,
    Object? isActive = null,
    Object? settings = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? isDefault = null,
    Object? isWarehouse = null,
    Object? timezone = freezed,
    Object? operatingHours = null,
    Object? staffIds = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? imageUrl = freezed,
    Object? metadata = null,
    Object? allowPOS = null,
    Object? allowOnlineOrders = null,
    Object? allowPickup = null,
    Object? allowDelivery = null,
    Object? deliveryRadius = null,
    Object? minimumOrderAmount = null,
    Object? deliveryFee = null,
    Object? taxRegistrationNumber = freezed,
    Object? paymentMethods = null,
    Object? features = null,
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
      branchType: null == branchType
          ? _value.branchType
          : branchType // ignore: cast_nullable_to_non_nullable
              as String,
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
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      managerId: freezed == managerId
          ? _value.managerId
          : managerId // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      settings: freezed == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
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
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      isWarehouse: null == isWarehouse
          ? _value.isWarehouse
          : isWarehouse // ignore: cast_nullable_to_non_nullable
              as bool,
      timezone: freezed == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String?,
      operatingHours: null == operatingHours
          ? _value.operatingHours
          : operatingHours // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      staffIds: null == staffIds
          ? _value.staffIds
          : staffIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      allowPOS: null == allowPOS
          ? _value.allowPOS
          : allowPOS // ignore: cast_nullable_to_non_nullable
              as bool,
      allowOnlineOrders: null == allowOnlineOrders
          ? _value.allowOnlineOrders
          : allowOnlineOrders // ignore: cast_nullable_to_non_nullable
              as bool,
      allowPickup: null == allowPickup
          ? _value.allowPickup
          : allowPickup // ignore: cast_nullable_to_non_nullable
              as bool,
      allowDelivery: null == allowDelivery
          ? _value.allowDelivery
          : allowDelivery // ignore: cast_nullable_to_non_nullable
              as bool,
      deliveryRadius: null == deliveryRadius
          ? _value.deliveryRadius
          : deliveryRadius // ignore: cast_nullable_to_non_nullable
              as double,
      minimumOrderAmount: null == minimumOrderAmount
          ? _value.minimumOrderAmount
          : minimumOrderAmount // ignore: cast_nullable_to_non_nullable
              as double,
      deliveryFee: null == deliveryFee
          ? _value.deliveryFee
          : deliveryFee // ignore: cast_nullable_to_non_nullable
              as double,
      taxRegistrationNumber: freezed == taxRegistrationNumber
          ? _value.taxRegistrationNumber
          : taxRegistrationNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentMethods: null == paymentMethods
          ? _value.paymentMethods
          : paymentMethods // ignore: cast_nullable_to_non_nullable
              as List<String>,
      features: null == features
          ? _value.features
          : features // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BranchImplCopyWith<$Res> implements $BranchCopyWith<$Res> {
  factory _$$BranchImplCopyWith(
          _$BranchImpl value, $Res Function(_$BranchImpl) then) =
      __$$BranchImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String name,
      String? code,
      String branchType,
      String? address,
      String? city,
      String? state,
      String? country,
      String? postalCode,
      String? phone,
      String? email,
      String? managerId,
      bool isActive,
      Map<String, dynamic>? settings,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      bool isDefault,
      bool isWarehouse,
      String? timezone,
      Map<String, String> operatingHours,
      List<String> staffIds,
      double latitude,
      double longitude,
      String? imageUrl,
      Map<String, dynamic> metadata,
      bool allowPOS,
      bool allowOnlineOrders,
      bool allowPickup,
      bool allowDelivery,
      double deliveryRadius,
      double minimumOrderAmount,
      double deliveryFee,
      String? taxRegistrationNumber,
      List<String> paymentMethods,
      Map<String, bool> features});
}

/// @nodoc
class __$$BranchImplCopyWithImpl<$Res>
    extends _$BranchCopyWithImpl<$Res, _$BranchImpl>
    implements _$$BranchImplCopyWith<$Res> {
  __$$BranchImplCopyWithImpl(
      _$BranchImpl _value, $Res Function(_$BranchImpl) _then)
      : super(_value, _then);

  /// Create a copy of Branch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? name = null,
    Object? code = freezed,
    Object? branchType = null,
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = freezed,
    Object? postalCode = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? managerId = freezed,
    Object? isActive = null,
    Object? settings = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? isDefault = null,
    Object? isWarehouse = null,
    Object? timezone = freezed,
    Object? operatingHours = null,
    Object? staffIds = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? imageUrl = freezed,
    Object? metadata = null,
    Object? allowPOS = null,
    Object? allowOnlineOrders = null,
    Object? allowPickup = null,
    Object? allowDelivery = null,
    Object? deliveryRadius = null,
    Object? minimumOrderAmount = null,
    Object? deliveryFee = null,
    Object? taxRegistrationNumber = freezed,
    Object? paymentMethods = null,
    Object? features = null,
  }) {
    return _then(_$BranchImpl(
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
      branchType: null == branchType
          ? _value.branchType
          : branchType // ignore: cast_nullable_to_non_nullable
              as String,
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
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      managerId: freezed == managerId
          ? _value.managerId
          : managerId // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      settings: freezed == settings
          ? _value._settings
          : settings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
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
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      isWarehouse: null == isWarehouse
          ? _value.isWarehouse
          : isWarehouse // ignore: cast_nullable_to_non_nullable
              as bool,
      timezone: freezed == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String?,
      operatingHours: null == operatingHours
          ? _value._operatingHours
          : operatingHours // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      staffIds: null == staffIds
          ? _value._staffIds
          : staffIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      allowPOS: null == allowPOS
          ? _value.allowPOS
          : allowPOS // ignore: cast_nullable_to_non_nullable
              as bool,
      allowOnlineOrders: null == allowOnlineOrders
          ? _value.allowOnlineOrders
          : allowOnlineOrders // ignore: cast_nullable_to_non_nullable
              as bool,
      allowPickup: null == allowPickup
          ? _value.allowPickup
          : allowPickup // ignore: cast_nullable_to_non_nullable
              as bool,
      allowDelivery: null == allowDelivery
          ? _value.allowDelivery
          : allowDelivery // ignore: cast_nullable_to_non_nullable
              as bool,
      deliveryRadius: null == deliveryRadius
          ? _value.deliveryRadius
          : deliveryRadius // ignore: cast_nullable_to_non_nullable
              as double,
      minimumOrderAmount: null == minimumOrderAmount
          ? _value.minimumOrderAmount
          : minimumOrderAmount // ignore: cast_nullable_to_non_nullable
              as double,
      deliveryFee: null == deliveryFee
          ? _value.deliveryFee
          : deliveryFee // ignore: cast_nullable_to_non_nullable
              as double,
      taxRegistrationNumber: freezed == taxRegistrationNumber
          ? _value.taxRegistrationNumber
          : taxRegistrationNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentMethods: null == paymentMethods
          ? _value._paymentMethods
          : paymentMethods // ignore: cast_nullable_to_non_nullable
              as List<String>,
      features: null == features
          ? _value._features
          : features // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BranchImpl extends _Branch {
  const _$BranchImpl(
      {required this.id,
      required this.organizationId,
      required this.name,
      this.code,
      this.branchType = 'store',
      this.address,
      this.city,
      this.state,
      this.country,
      this.postalCode,
      this.phone,
      this.email,
      this.managerId,
      this.isActive = true,
      final Map<String, dynamic>? settings,
      required this.createdAt,
      required this.updatedAt,
      this.syncedAt,
      this.isDefault = false,
      this.isWarehouse = false,
      this.timezone,
      final Map<String, String> operatingHours = const {},
      final List<String> staffIds = const [],
      this.latitude = 0,
      this.longitude = 0,
      this.imageUrl,
      final Map<String, dynamic> metadata = const {},
      this.allowPOS = true,
      this.allowOnlineOrders = true,
      this.allowPickup = true,
      this.allowDelivery = true,
      this.deliveryRadius = 0,
      this.minimumOrderAmount = 0,
      this.deliveryFee = 0,
      this.taxRegistrationNumber,
      final List<String> paymentMethods = const [],
      final Map<String, bool> features = const {}})
      : _settings = settings,
        _operatingHours = operatingHours,
        _staffIds = staffIds,
        _metadata = metadata,
        _paymentMethods = paymentMethods,
        _features = features,
        super._();

  factory _$BranchImpl.fromJson(Map<String, dynamic> json) =>
      _$$BranchImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String name;
  @override
  final String? code;
  @override
  @JsonKey()
  final String branchType;
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
  final String? phone;
  @override
  final String? email;
  @override
  final String? managerId;
  @override
  @JsonKey()
  final bool isActive;
  final Map<String, dynamic>? _settings;
  @override
  Map<String, dynamic>? get settings {
    final value = _settings;
    if (value == null) return null;
    if (_settings is EqualUnmodifiableMapView) return _settings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? syncedAt;
// Additional fields for plugin
  @override
  @JsonKey()
  final bool isDefault;
  @override
  @JsonKey()
  final bool isWarehouse;
  @override
  final String? timezone;
  final Map<String, String> _operatingHours;
  @override
  @JsonKey()
  Map<String, String> get operatingHours {
    if (_operatingHours is EqualUnmodifiableMapView) return _operatingHours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_operatingHours);
  }

// {"monday": "9:00-18:00"}
  final List<String> _staffIds;
// {"monday": "9:00-18:00"}
  @override
  @JsonKey()
  List<String> get staffIds {
    if (_staffIds is EqualUnmodifiableListView) return _staffIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_staffIds);
  }

  @override
  @JsonKey()
  final double latitude;
  @override
  @JsonKey()
  final double longitude;
  @override
  final String? imageUrl;
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
  final bool allowPOS;
  @override
  @JsonKey()
  final bool allowOnlineOrders;
  @override
  @JsonKey()
  final bool allowPickup;
  @override
  @JsonKey()
  final bool allowDelivery;
  @override
  @JsonKey()
  final double deliveryRadius;
// in km
  @override
  @JsonKey()
  final double minimumOrderAmount;
  @override
  @JsonKey()
  final double deliveryFee;
  @override
  final String? taxRegistrationNumber;
  final List<String> _paymentMethods;
  @override
  @JsonKey()
  List<String> get paymentMethods {
    if (_paymentMethods is EqualUnmodifiableListView) return _paymentMethods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentMethods);
  }

  final Map<String, bool> _features;
  @override
  @JsonKey()
  Map<String, bool> get features {
    if (_features is EqualUnmodifiableMapView) return _features;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_features);
  }

  @override
  String toString() {
    return 'Branch(id: $id, organizationId: $organizationId, name: $name, code: $code, branchType: $branchType, address: $address, city: $city, state: $state, country: $country, postalCode: $postalCode, phone: $phone, email: $email, managerId: $managerId, isActive: $isActive, settings: $settings, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt, isDefault: $isDefault, isWarehouse: $isWarehouse, timezone: $timezone, operatingHours: $operatingHours, staffIds: $staffIds, latitude: $latitude, longitude: $longitude, imageUrl: $imageUrl, metadata: $metadata, allowPOS: $allowPOS, allowOnlineOrders: $allowOnlineOrders, allowPickup: $allowPickup, allowDelivery: $allowDelivery, deliveryRadius: $deliveryRadius, minimumOrderAmount: $minimumOrderAmount, deliveryFee: $deliveryFee, taxRegistrationNumber: $taxRegistrationNumber, paymentMethods: $paymentMethods, features: $features)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BranchImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.branchType, branchType) ||
                other.branchType == branchType) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.managerId, managerId) ||
                other.managerId == managerId) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality().equals(other._settings, _settings) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.isWarehouse, isWarehouse) ||
                other.isWarehouse == isWarehouse) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            const DeepCollectionEquality()
                .equals(other._operatingHours, _operatingHours) &&
            const DeepCollectionEquality().equals(other._staffIds, _staffIds) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.allowPOS, allowPOS) ||
                other.allowPOS == allowPOS) &&
            (identical(other.allowOnlineOrders, allowOnlineOrders) ||
                other.allowOnlineOrders == allowOnlineOrders) &&
            (identical(other.allowPickup, allowPickup) ||
                other.allowPickup == allowPickup) &&
            (identical(other.allowDelivery, allowDelivery) ||
                other.allowDelivery == allowDelivery) &&
            (identical(other.deliveryRadius, deliveryRadius) ||
                other.deliveryRadius == deliveryRadius) &&
            (identical(other.minimumOrderAmount, minimumOrderAmount) ||
                other.minimumOrderAmount == minimumOrderAmount) &&
            (identical(other.deliveryFee, deliveryFee) ||
                other.deliveryFee == deliveryFee) &&
            (identical(other.taxRegistrationNumber, taxRegistrationNumber) ||
                other.taxRegistrationNumber == taxRegistrationNumber) &&
            const DeepCollectionEquality()
                .equals(other._paymentMethods, _paymentMethods) &&
            const DeepCollectionEquality().equals(other._features, _features));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        organizationId,
        name,
        code,
        branchType,
        address,
        city,
        state,
        country,
        postalCode,
        phone,
        email,
        managerId,
        isActive,
        const DeepCollectionEquality().hash(_settings),
        createdAt,
        updatedAt,
        syncedAt,
        isDefault,
        isWarehouse,
        timezone,
        const DeepCollectionEquality().hash(_operatingHours),
        const DeepCollectionEquality().hash(_staffIds),
        latitude,
        longitude,
        imageUrl,
        const DeepCollectionEquality().hash(_metadata),
        allowPOS,
        allowOnlineOrders,
        allowPickup,
        allowDelivery,
        deliveryRadius,
        minimumOrderAmount,
        deliveryFee,
        taxRegistrationNumber,
        const DeepCollectionEquality().hash(_paymentMethods),
        const DeepCollectionEquality().hash(_features)
      ]);

  /// Create a copy of Branch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BranchImplCopyWith<_$BranchImpl> get copyWith =>
      __$$BranchImplCopyWithImpl<_$BranchImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BranchImplToJson(
      this,
    );
  }
}

abstract class _Branch extends Branch {
  const factory _Branch(
      {required final String id,
      required final String organizationId,
      required final String name,
      final String? code,
      final String branchType,
      final String? address,
      final String? city,
      final String? state,
      final String? country,
      final String? postalCode,
      final String? phone,
      final String? email,
      final String? managerId,
      final bool isActive,
      final Map<String, dynamic>? settings,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final DateTime? syncedAt,
      final bool isDefault,
      final bool isWarehouse,
      final String? timezone,
      final Map<String, String> operatingHours,
      final List<String> staffIds,
      final double latitude,
      final double longitude,
      final String? imageUrl,
      final Map<String, dynamic> metadata,
      final bool allowPOS,
      final bool allowOnlineOrders,
      final bool allowPickup,
      final bool allowDelivery,
      final double deliveryRadius,
      final double minimumOrderAmount,
      final double deliveryFee,
      final String? taxRegistrationNumber,
      final List<String> paymentMethods,
      final Map<String, bool> features}) = _$BranchImpl;
  const _Branch._() : super._();

  factory _Branch.fromJson(Map<String, dynamic> json) = _$BranchImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String get name;
  @override
  String? get code;
  @override
  String get branchType;
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
  String? get phone;
  @override
  String? get email;
  @override
  String? get managerId;
  @override
  bool get isActive;
  @override
  Map<String, dynamic>? get settings;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get syncedAt; // Additional fields for plugin
  @override
  bool get isDefault;
  @override
  bool get isWarehouse;
  @override
  String? get timezone;
  @override
  Map<String, String> get operatingHours; // {"monday": "9:00-18:00"}
  @override
  List<String> get staffIds;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String? get imageUrl;
  @override
  Map<String, dynamic> get metadata;
  @override
  bool get allowPOS;
  @override
  bool get allowOnlineOrders;
  @override
  bool get allowPickup;
  @override
  bool get allowDelivery;
  @override
  double get deliveryRadius; // in km
  @override
  double get minimumOrderAmount;
  @override
  double get deliveryFee;
  @override
  String? get taxRegistrationNumber;
  @override
  List<String> get paymentMethods;
  @override
  Map<String, bool> get features;

  /// Create a copy of Branch
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BranchImplCopyWith<_$BranchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
