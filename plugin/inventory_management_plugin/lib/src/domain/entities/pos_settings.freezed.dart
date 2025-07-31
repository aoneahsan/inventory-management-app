// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pos_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

POSSettings _$POSSettingsFromJson(Map<String, dynamic> json) {
  return _POSSettings.fromJson(json);
}

/// @nodoc
mixin _$POSSettings {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String? get defaultRegisterId => throw _privateConstructorUsedError;
  String? get defaultBranchId => throw _privateConstructorUsedError;
  String get receiptTemplate => throw _privateConstructorUsedError;
  bool get taxInclusive => throw _privateConstructorUsedError;
  bool get enableCustomerDisplay => throw _privateConstructorUsedError;
  bool get enableQuickKeys => throw _privateConstructorUsedError;
  List<QuickKey> get quickKeys => throw _privateConstructorUsedError;
  List<String> get paymentMethods => throw _privateConstructorUsedError;
  bool get printReceiptDefault => throw _privateConstructorUsedError;
  bool get emailReceiptDefault => throw _privateConstructorUsedError;
  bool get smsReceiptDefault => throw _privateConstructorUsedError;
  bool get barcodeScanningEnabled => throw _privateConstructorUsedError;
  bool get offlineModeEnabled => throw _privateConstructorUsedError;
  int get syncInterval => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  int get decimalPlaces => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional POS settings
  bool get requireCustomerForCredit => throw _privateConstructorUsedError;
  bool get allowNegativeStock => throw _privateConstructorUsedError;
  bool get soundEnabled => throw _privateConstructorUsedError;
  bool get autoLogoutEnabled => throw _privateConstructorUsedError;
  int get autoLogoutMinutes => throw _privateConstructorUsedError;
  bool get showStockInPos => throw _privateConstructorUsedError;
  bool get allowPriceEdit => throw _privateConstructorUsedError;
  bool get allowDiscountEdit => throw _privateConstructorUsedError;
  bool get allowQuantityEdit => throw _privateConstructorUsedError;
  bool get confirmBeforeDelete => throw _privateConstructorUsedError;
  String? get defaultTaxRateId => throw _privateConstructorUsedError;
  Map<String, dynamic> get receiptSettings =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> get printerSettings =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> get displaySettings =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> get shortcuts => throw _privateConstructorUsedError;
  bool get enableLoyaltyProgram => throw _privateConstructorUsedError;
  double get loyaltyPointsPerCurrency => throw _privateConstructorUsedError;
  double get minimumRedeemPoints => throw _privateConstructorUsedError;
  double get pointValue => throw _privateConstructorUsedError;

  /// Serializes this POSSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of POSSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $POSSettingsCopyWith<POSSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $POSSettingsCopyWith<$Res> {
  factory $POSSettingsCopyWith(
          POSSettings value, $Res Function(POSSettings) then) =
      _$POSSettingsCopyWithImpl<$Res, POSSettings>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String? defaultRegisterId,
      String? defaultBranchId,
      String receiptTemplate,
      bool taxInclusive,
      bool enableCustomerDisplay,
      bool enableQuickKeys,
      List<QuickKey> quickKeys,
      List<String> paymentMethods,
      bool printReceiptDefault,
      bool emailReceiptDefault,
      bool smsReceiptDefault,
      bool barcodeScanningEnabled,
      bool offlineModeEnabled,
      int syncInterval,
      String currency,
      int decimalPlaces,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      bool requireCustomerForCredit,
      bool allowNegativeStock,
      bool soundEnabled,
      bool autoLogoutEnabled,
      int autoLogoutMinutes,
      bool showStockInPos,
      bool allowPriceEdit,
      bool allowDiscountEdit,
      bool allowQuantityEdit,
      bool confirmBeforeDelete,
      String? defaultTaxRateId,
      Map<String, dynamic> receiptSettings,
      Map<String, dynamic> printerSettings,
      Map<String, dynamic> displaySettings,
      Map<String, dynamic> shortcuts,
      bool enableLoyaltyProgram,
      double loyaltyPointsPerCurrency,
      double minimumRedeemPoints,
      double pointValue});
}

/// @nodoc
class _$POSSettingsCopyWithImpl<$Res, $Val extends POSSettings>
    implements $POSSettingsCopyWith<$Res> {
  _$POSSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of POSSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? defaultRegisterId = freezed,
    Object? defaultBranchId = freezed,
    Object? receiptTemplate = null,
    Object? taxInclusive = null,
    Object? enableCustomerDisplay = null,
    Object? enableQuickKeys = null,
    Object? quickKeys = null,
    Object? paymentMethods = null,
    Object? printReceiptDefault = null,
    Object? emailReceiptDefault = null,
    Object? smsReceiptDefault = null,
    Object? barcodeScanningEnabled = null,
    Object? offlineModeEnabled = null,
    Object? syncInterval = null,
    Object? currency = null,
    Object? decimalPlaces = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? requireCustomerForCredit = null,
    Object? allowNegativeStock = null,
    Object? soundEnabled = null,
    Object? autoLogoutEnabled = null,
    Object? autoLogoutMinutes = null,
    Object? showStockInPos = null,
    Object? allowPriceEdit = null,
    Object? allowDiscountEdit = null,
    Object? allowQuantityEdit = null,
    Object? confirmBeforeDelete = null,
    Object? defaultTaxRateId = freezed,
    Object? receiptSettings = null,
    Object? printerSettings = null,
    Object? displaySettings = null,
    Object? shortcuts = null,
    Object? enableLoyaltyProgram = null,
    Object? loyaltyPointsPerCurrency = null,
    Object? minimumRedeemPoints = null,
    Object? pointValue = null,
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
      defaultRegisterId: freezed == defaultRegisterId
          ? _value.defaultRegisterId
          : defaultRegisterId // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultBranchId: freezed == defaultBranchId
          ? _value.defaultBranchId
          : defaultBranchId // ignore: cast_nullable_to_non_nullable
              as String?,
      receiptTemplate: null == receiptTemplate
          ? _value.receiptTemplate
          : receiptTemplate // ignore: cast_nullable_to_non_nullable
              as String,
      taxInclusive: null == taxInclusive
          ? _value.taxInclusive
          : taxInclusive // ignore: cast_nullable_to_non_nullable
              as bool,
      enableCustomerDisplay: null == enableCustomerDisplay
          ? _value.enableCustomerDisplay
          : enableCustomerDisplay // ignore: cast_nullable_to_non_nullable
              as bool,
      enableQuickKeys: null == enableQuickKeys
          ? _value.enableQuickKeys
          : enableQuickKeys // ignore: cast_nullable_to_non_nullable
              as bool,
      quickKeys: null == quickKeys
          ? _value.quickKeys
          : quickKeys // ignore: cast_nullable_to_non_nullable
              as List<QuickKey>,
      paymentMethods: null == paymentMethods
          ? _value.paymentMethods
          : paymentMethods // ignore: cast_nullable_to_non_nullable
              as List<String>,
      printReceiptDefault: null == printReceiptDefault
          ? _value.printReceiptDefault
          : printReceiptDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      emailReceiptDefault: null == emailReceiptDefault
          ? _value.emailReceiptDefault
          : emailReceiptDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      smsReceiptDefault: null == smsReceiptDefault
          ? _value.smsReceiptDefault
          : smsReceiptDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      barcodeScanningEnabled: null == barcodeScanningEnabled
          ? _value.barcodeScanningEnabled
          : barcodeScanningEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      offlineModeEnabled: null == offlineModeEnabled
          ? _value.offlineModeEnabled
          : offlineModeEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      syncInterval: null == syncInterval
          ? _value.syncInterval
          : syncInterval // ignore: cast_nullable_to_non_nullable
              as int,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      decimalPlaces: null == decimalPlaces
          ? _value.decimalPlaces
          : decimalPlaces // ignore: cast_nullable_to_non_nullable
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
      requireCustomerForCredit: null == requireCustomerForCredit
          ? _value.requireCustomerForCredit
          : requireCustomerForCredit // ignore: cast_nullable_to_non_nullable
              as bool,
      allowNegativeStock: null == allowNegativeStock
          ? _value.allowNegativeStock
          : allowNegativeStock // ignore: cast_nullable_to_non_nullable
              as bool,
      soundEnabled: null == soundEnabled
          ? _value.soundEnabled
          : soundEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      autoLogoutEnabled: null == autoLogoutEnabled
          ? _value.autoLogoutEnabled
          : autoLogoutEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      autoLogoutMinutes: null == autoLogoutMinutes
          ? _value.autoLogoutMinutes
          : autoLogoutMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      showStockInPos: null == showStockInPos
          ? _value.showStockInPos
          : showStockInPos // ignore: cast_nullable_to_non_nullable
              as bool,
      allowPriceEdit: null == allowPriceEdit
          ? _value.allowPriceEdit
          : allowPriceEdit // ignore: cast_nullable_to_non_nullable
              as bool,
      allowDiscountEdit: null == allowDiscountEdit
          ? _value.allowDiscountEdit
          : allowDiscountEdit // ignore: cast_nullable_to_non_nullable
              as bool,
      allowQuantityEdit: null == allowQuantityEdit
          ? _value.allowQuantityEdit
          : allowQuantityEdit // ignore: cast_nullable_to_non_nullable
              as bool,
      confirmBeforeDelete: null == confirmBeforeDelete
          ? _value.confirmBeforeDelete
          : confirmBeforeDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      defaultTaxRateId: freezed == defaultTaxRateId
          ? _value.defaultTaxRateId
          : defaultTaxRateId // ignore: cast_nullable_to_non_nullable
              as String?,
      receiptSettings: null == receiptSettings
          ? _value.receiptSettings
          : receiptSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      printerSettings: null == printerSettings
          ? _value.printerSettings
          : printerSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      displaySettings: null == displaySettings
          ? _value.displaySettings
          : displaySettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      shortcuts: null == shortcuts
          ? _value.shortcuts
          : shortcuts // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      enableLoyaltyProgram: null == enableLoyaltyProgram
          ? _value.enableLoyaltyProgram
          : enableLoyaltyProgram // ignore: cast_nullable_to_non_nullable
              as bool,
      loyaltyPointsPerCurrency: null == loyaltyPointsPerCurrency
          ? _value.loyaltyPointsPerCurrency
          : loyaltyPointsPerCurrency // ignore: cast_nullable_to_non_nullable
              as double,
      minimumRedeemPoints: null == minimumRedeemPoints
          ? _value.minimumRedeemPoints
          : minimumRedeemPoints // ignore: cast_nullable_to_non_nullable
              as double,
      pointValue: null == pointValue
          ? _value.pointValue
          : pointValue // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$POSSettingsImplCopyWith<$Res>
    implements $POSSettingsCopyWith<$Res> {
  factory _$$POSSettingsImplCopyWith(
          _$POSSettingsImpl value, $Res Function(_$POSSettingsImpl) then) =
      __$$POSSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String? defaultRegisterId,
      String? defaultBranchId,
      String receiptTemplate,
      bool taxInclusive,
      bool enableCustomerDisplay,
      bool enableQuickKeys,
      List<QuickKey> quickKeys,
      List<String> paymentMethods,
      bool printReceiptDefault,
      bool emailReceiptDefault,
      bool smsReceiptDefault,
      bool barcodeScanningEnabled,
      bool offlineModeEnabled,
      int syncInterval,
      String currency,
      int decimalPlaces,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      bool requireCustomerForCredit,
      bool allowNegativeStock,
      bool soundEnabled,
      bool autoLogoutEnabled,
      int autoLogoutMinutes,
      bool showStockInPos,
      bool allowPriceEdit,
      bool allowDiscountEdit,
      bool allowQuantityEdit,
      bool confirmBeforeDelete,
      String? defaultTaxRateId,
      Map<String, dynamic> receiptSettings,
      Map<String, dynamic> printerSettings,
      Map<String, dynamic> displaySettings,
      Map<String, dynamic> shortcuts,
      bool enableLoyaltyProgram,
      double loyaltyPointsPerCurrency,
      double minimumRedeemPoints,
      double pointValue});
}

/// @nodoc
class __$$POSSettingsImplCopyWithImpl<$Res>
    extends _$POSSettingsCopyWithImpl<$Res, _$POSSettingsImpl>
    implements _$$POSSettingsImplCopyWith<$Res> {
  __$$POSSettingsImplCopyWithImpl(
      _$POSSettingsImpl _value, $Res Function(_$POSSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of POSSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? defaultRegisterId = freezed,
    Object? defaultBranchId = freezed,
    Object? receiptTemplate = null,
    Object? taxInclusive = null,
    Object? enableCustomerDisplay = null,
    Object? enableQuickKeys = null,
    Object? quickKeys = null,
    Object? paymentMethods = null,
    Object? printReceiptDefault = null,
    Object? emailReceiptDefault = null,
    Object? smsReceiptDefault = null,
    Object? barcodeScanningEnabled = null,
    Object? offlineModeEnabled = null,
    Object? syncInterval = null,
    Object? currency = null,
    Object? decimalPlaces = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? requireCustomerForCredit = null,
    Object? allowNegativeStock = null,
    Object? soundEnabled = null,
    Object? autoLogoutEnabled = null,
    Object? autoLogoutMinutes = null,
    Object? showStockInPos = null,
    Object? allowPriceEdit = null,
    Object? allowDiscountEdit = null,
    Object? allowQuantityEdit = null,
    Object? confirmBeforeDelete = null,
    Object? defaultTaxRateId = freezed,
    Object? receiptSettings = null,
    Object? printerSettings = null,
    Object? displaySettings = null,
    Object? shortcuts = null,
    Object? enableLoyaltyProgram = null,
    Object? loyaltyPointsPerCurrency = null,
    Object? minimumRedeemPoints = null,
    Object? pointValue = null,
  }) {
    return _then(_$POSSettingsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      defaultRegisterId: freezed == defaultRegisterId
          ? _value.defaultRegisterId
          : defaultRegisterId // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultBranchId: freezed == defaultBranchId
          ? _value.defaultBranchId
          : defaultBranchId // ignore: cast_nullable_to_non_nullable
              as String?,
      receiptTemplate: null == receiptTemplate
          ? _value.receiptTemplate
          : receiptTemplate // ignore: cast_nullable_to_non_nullable
              as String,
      taxInclusive: null == taxInclusive
          ? _value.taxInclusive
          : taxInclusive // ignore: cast_nullable_to_non_nullable
              as bool,
      enableCustomerDisplay: null == enableCustomerDisplay
          ? _value.enableCustomerDisplay
          : enableCustomerDisplay // ignore: cast_nullable_to_non_nullable
              as bool,
      enableQuickKeys: null == enableQuickKeys
          ? _value.enableQuickKeys
          : enableQuickKeys // ignore: cast_nullable_to_non_nullable
              as bool,
      quickKeys: null == quickKeys
          ? _value._quickKeys
          : quickKeys // ignore: cast_nullable_to_non_nullable
              as List<QuickKey>,
      paymentMethods: null == paymentMethods
          ? _value._paymentMethods
          : paymentMethods // ignore: cast_nullable_to_non_nullable
              as List<String>,
      printReceiptDefault: null == printReceiptDefault
          ? _value.printReceiptDefault
          : printReceiptDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      emailReceiptDefault: null == emailReceiptDefault
          ? _value.emailReceiptDefault
          : emailReceiptDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      smsReceiptDefault: null == smsReceiptDefault
          ? _value.smsReceiptDefault
          : smsReceiptDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      barcodeScanningEnabled: null == barcodeScanningEnabled
          ? _value.barcodeScanningEnabled
          : barcodeScanningEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      offlineModeEnabled: null == offlineModeEnabled
          ? _value.offlineModeEnabled
          : offlineModeEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      syncInterval: null == syncInterval
          ? _value.syncInterval
          : syncInterval // ignore: cast_nullable_to_non_nullable
              as int,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      decimalPlaces: null == decimalPlaces
          ? _value.decimalPlaces
          : decimalPlaces // ignore: cast_nullable_to_non_nullable
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
      requireCustomerForCredit: null == requireCustomerForCredit
          ? _value.requireCustomerForCredit
          : requireCustomerForCredit // ignore: cast_nullable_to_non_nullable
              as bool,
      allowNegativeStock: null == allowNegativeStock
          ? _value.allowNegativeStock
          : allowNegativeStock // ignore: cast_nullable_to_non_nullable
              as bool,
      soundEnabled: null == soundEnabled
          ? _value.soundEnabled
          : soundEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      autoLogoutEnabled: null == autoLogoutEnabled
          ? _value.autoLogoutEnabled
          : autoLogoutEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      autoLogoutMinutes: null == autoLogoutMinutes
          ? _value.autoLogoutMinutes
          : autoLogoutMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      showStockInPos: null == showStockInPos
          ? _value.showStockInPos
          : showStockInPos // ignore: cast_nullable_to_non_nullable
              as bool,
      allowPriceEdit: null == allowPriceEdit
          ? _value.allowPriceEdit
          : allowPriceEdit // ignore: cast_nullable_to_non_nullable
              as bool,
      allowDiscountEdit: null == allowDiscountEdit
          ? _value.allowDiscountEdit
          : allowDiscountEdit // ignore: cast_nullable_to_non_nullable
              as bool,
      allowQuantityEdit: null == allowQuantityEdit
          ? _value.allowQuantityEdit
          : allowQuantityEdit // ignore: cast_nullable_to_non_nullable
              as bool,
      confirmBeforeDelete: null == confirmBeforeDelete
          ? _value.confirmBeforeDelete
          : confirmBeforeDelete // ignore: cast_nullable_to_non_nullable
              as bool,
      defaultTaxRateId: freezed == defaultTaxRateId
          ? _value.defaultTaxRateId
          : defaultTaxRateId // ignore: cast_nullable_to_non_nullable
              as String?,
      receiptSettings: null == receiptSettings
          ? _value._receiptSettings
          : receiptSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      printerSettings: null == printerSettings
          ? _value._printerSettings
          : printerSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      displaySettings: null == displaySettings
          ? _value._displaySettings
          : displaySettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      shortcuts: null == shortcuts
          ? _value._shortcuts
          : shortcuts // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      enableLoyaltyProgram: null == enableLoyaltyProgram
          ? _value.enableLoyaltyProgram
          : enableLoyaltyProgram // ignore: cast_nullable_to_non_nullable
              as bool,
      loyaltyPointsPerCurrency: null == loyaltyPointsPerCurrency
          ? _value.loyaltyPointsPerCurrency
          : loyaltyPointsPerCurrency // ignore: cast_nullable_to_non_nullable
              as double,
      minimumRedeemPoints: null == minimumRedeemPoints
          ? _value.minimumRedeemPoints
          : minimumRedeemPoints // ignore: cast_nullable_to_non_nullable
              as double,
      pointValue: null == pointValue
          ? _value.pointValue
          : pointValue // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$POSSettingsImpl extends _POSSettings {
  const _$POSSettingsImpl(
      {required this.id,
      required this.organizationId,
      this.defaultRegisterId,
      this.defaultBranchId,
      this.receiptTemplate = 'default',
      this.taxInclusive = false,
      this.enableCustomerDisplay = true,
      this.enableQuickKeys = true,
      final List<QuickKey> quickKeys = const [],
      final List<String> paymentMethods = const ['cash', 'card', 'upi'],
      this.printReceiptDefault = true,
      this.emailReceiptDefault = false,
      this.smsReceiptDefault = false,
      this.barcodeScanningEnabled = true,
      this.offlineModeEnabled = true,
      this.syncInterval = 30,
      this.currency = 'USD',
      this.decimalPlaces = 2,
      required this.createdAt,
      required this.updatedAt,
      this.syncedAt,
      this.requireCustomerForCredit = true,
      this.allowNegativeStock = false,
      this.soundEnabled = true,
      this.autoLogoutEnabled = false,
      this.autoLogoutMinutes = 30,
      this.showStockInPos = true,
      this.allowPriceEdit = false,
      this.allowDiscountEdit = false,
      this.allowQuantityEdit = false,
      this.confirmBeforeDelete = true,
      this.defaultTaxRateId,
      final Map<String, dynamic> receiptSettings = const {},
      final Map<String, dynamic> printerSettings = const {},
      final Map<String, dynamic> displaySettings = const {},
      final Map<String, dynamic> shortcuts = const {},
      this.enableLoyaltyProgram = true,
      this.loyaltyPointsPerCurrency = 1.0,
      this.minimumRedeemPoints = 100,
      this.pointValue = 0.01})
      : _quickKeys = quickKeys,
        _paymentMethods = paymentMethods,
        _receiptSettings = receiptSettings,
        _printerSettings = printerSettings,
        _displaySettings = displaySettings,
        _shortcuts = shortcuts,
        super._();

  factory _$POSSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$POSSettingsImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String? defaultRegisterId;
  @override
  final String? defaultBranchId;
  @override
  @JsonKey()
  final String receiptTemplate;
  @override
  @JsonKey()
  final bool taxInclusive;
  @override
  @JsonKey()
  final bool enableCustomerDisplay;
  @override
  @JsonKey()
  final bool enableQuickKeys;
  final List<QuickKey> _quickKeys;
  @override
  @JsonKey()
  List<QuickKey> get quickKeys {
    if (_quickKeys is EqualUnmodifiableListView) return _quickKeys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_quickKeys);
  }

  final List<String> _paymentMethods;
  @override
  @JsonKey()
  List<String> get paymentMethods {
    if (_paymentMethods is EqualUnmodifiableListView) return _paymentMethods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentMethods);
  }

  @override
  @JsonKey()
  final bool printReceiptDefault;
  @override
  @JsonKey()
  final bool emailReceiptDefault;
  @override
  @JsonKey()
  final bool smsReceiptDefault;
  @override
  @JsonKey()
  final bool barcodeScanningEnabled;
  @override
  @JsonKey()
  final bool offlineModeEnabled;
  @override
  @JsonKey()
  final int syncInterval;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey()
  final int decimalPlaces;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? syncedAt;
// Additional POS settings
  @override
  @JsonKey()
  final bool requireCustomerForCredit;
  @override
  @JsonKey()
  final bool allowNegativeStock;
  @override
  @JsonKey()
  final bool soundEnabled;
  @override
  @JsonKey()
  final bool autoLogoutEnabled;
  @override
  @JsonKey()
  final int autoLogoutMinutes;
  @override
  @JsonKey()
  final bool showStockInPos;
  @override
  @JsonKey()
  final bool allowPriceEdit;
  @override
  @JsonKey()
  final bool allowDiscountEdit;
  @override
  @JsonKey()
  final bool allowQuantityEdit;
  @override
  @JsonKey()
  final bool confirmBeforeDelete;
  @override
  final String? defaultTaxRateId;
  final Map<String, dynamic> _receiptSettings;
  @override
  @JsonKey()
  Map<String, dynamic> get receiptSettings {
    if (_receiptSettings is EqualUnmodifiableMapView) return _receiptSettings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_receiptSettings);
  }

  final Map<String, dynamic> _printerSettings;
  @override
  @JsonKey()
  Map<String, dynamic> get printerSettings {
    if (_printerSettings is EqualUnmodifiableMapView) return _printerSettings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_printerSettings);
  }

  final Map<String, dynamic> _displaySettings;
  @override
  @JsonKey()
  Map<String, dynamic> get displaySettings {
    if (_displaySettings is EqualUnmodifiableMapView) return _displaySettings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_displaySettings);
  }

  final Map<String, dynamic> _shortcuts;
  @override
  @JsonKey()
  Map<String, dynamic> get shortcuts {
    if (_shortcuts is EqualUnmodifiableMapView) return _shortcuts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_shortcuts);
  }

  @override
  @JsonKey()
  final bool enableLoyaltyProgram;
  @override
  @JsonKey()
  final double loyaltyPointsPerCurrency;
  @override
  @JsonKey()
  final double minimumRedeemPoints;
  @override
  @JsonKey()
  final double pointValue;

  @override
  String toString() {
    return 'POSSettings(id: $id, organizationId: $organizationId, defaultRegisterId: $defaultRegisterId, defaultBranchId: $defaultBranchId, receiptTemplate: $receiptTemplate, taxInclusive: $taxInclusive, enableCustomerDisplay: $enableCustomerDisplay, enableQuickKeys: $enableQuickKeys, quickKeys: $quickKeys, paymentMethods: $paymentMethods, printReceiptDefault: $printReceiptDefault, emailReceiptDefault: $emailReceiptDefault, smsReceiptDefault: $smsReceiptDefault, barcodeScanningEnabled: $barcodeScanningEnabled, offlineModeEnabled: $offlineModeEnabled, syncInterval: $syncInterval, currency: $currency, decimalPlaces: $decimalPlaces, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt, requireCustomerForCredit: $requireCustomerForCredit, allowNegativeStock: $allowNegativeStock, soundEnabled: $soundEnabled, autoLogoutEnabled: $autoLogoutEnabled, autoLogoutMinutes: $autoLogoutMinutes, showStockInPos: $showStockInPos, allowPriceEdit: $allowPriceEdit, allowDiscountEdit: $allowDiscountEdit, allowQuantityEdit: $allowQuantityEdit, confirmBeforeDelete: $confirmBeforeDelete, defaultTaxRateId: $defaultTaxRateId, receiptSettings: $receiptSettings, printerSettings: $printerSettings, displaySettings: $displaySettings, shortcuts: $shortcuts, enableLoyaltyProgram: $enableLoyaltyProgram, loyaltyPointsPerCurrency: $loyaltyPointsPerCurrency, minimumRedeemPoints: $minimumRedeemPoints, pointValue: $pointValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$POSSettingsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.defaultRegisterId, defaultRegisterId) ||
                other.defaultRegisterId == defaultRegisterId) &&
            (identical(other.defaultBranchId, defaultBranchId) ||
                other.defaultBranchId == defaultBranchId) &&
            (identical(other.receiptTemplate, receiptTemplate) ||
                other.receiptTemplate == receiptTemplate) &&
            (identical(other.taxInclusive, taxInclusive) ||
                other.taxInclusive == taxInclusive) &&
            (identical(other.enableCustomerDisplay, enableCustomerDisplay) ||
                other.enableCustomerDisplay == enableCustomerDisplay) &&
            (identical(other.enableQuickKeys, enableQuickKeys) ||
                other.enableQuickKeys == enableQuickKeys) &&
            const DeepCollectionEquality()
                .equals(other._quickKeys, _quickKeys) &&
            const DeepCollectionEquality()
                .equals(other._paymentMethods, _paymentMethods) &&
            (identical(other.printReceiptDefault, printReceiptDefault) ||
                other.printReceiptDefault == printReceiptDefault) &&
            (identical(other.emailReceiptDefault, emailReceiptDefault) ||
                other.emailReceiptDefault == emailReceiptDefault) &&
            (identical(other.smsReceiptDefault, smsReceiptDefault) ||
                other.smsReceiptDefault == smsReceiptDefault) &&
            (identical(other.barcodeScanningEnabled, barcodeScanningEnabled) ||
                other.barcodeScanningEnabled == barcodeScanningEnabled) &&
            (identical(other.offlineModeEnabled, offlineModeEnabled) ||
                other.offlineModeEnabled == offlineModeEnabled) &&
            (identical(other.syncInterval, syncInterval) ||
                other.syncInterval == syncInterval) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.decimalPlaces, decimalPlaces) ||
                other.decimalPlaces == decimalPlaces) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.requireCustomerForCredit, requireCustomerForCredit) ||
                other.requireCustomerForCredit == requireCustomerForCredit) &&
            (identical(other.allowNegativeStock, allowNegativeStock) ||
                other.allowNegativeStock == allowNegativeStock) &&
            (identical(other.soundEnabled, soundEnabled) ||
                other.soundEnabled == soundEnabled) &&
            (identical(other.autoLogoutEnabled, autoLogoutEnabled) ||
                other.autoLogoutEnabled == autoLogoutEnabled) &&
            (identical(other.autoLogoutMinutes, autoLogoutMinutes) ||
                other.autoLogoutMinutes == autoLogoutMinutes) &&
            (identical(other.showStockInPos, showStockInPos) ||
                other.showStockInPos == showStockInPos) &&
            (identical(other.allowPriceEdit, allowPriceEdit) ||
                other.allowPriceEdit == allowPriceEdit) &&
            (identical(other.allowDiscountEdit, allowDiscountEdit) ||
                other.allowDiscountEdit == allowDiscountEdit) &&
            (identical(other.allowQuantityEdit, allowQuantityEdit) ||
                other.allowQuantityEdit == allowQuantityEdit) &&
            (identical(other.confirmBeforeDelete, confirmBeforeDelete) ||
                other.confirmBeforeDelete == confirmBeforeDelete) &&
            (identical(other.defaultTaxRateId, defaultTaxRateId) ||
                other.defaultTaxRateId == defaultTaxRateId) &&
            const DeepCollectionEquality()
                .equals(other._receiptSettings, _receiptSettings) &&
            const DeepCollectionEquality()
                .equals(other._printerSettings, _printerSettings) &&
            const DeepCollectionEquality()
                .equals(other._displaySettings, _displaySettings) &&
            const DeepCollectionEquality()
                .equals(other._shortcuts, _shortcuts) &&
            (identical(other.enableLoyaltyProgram, enableLoyaltyProgram) ||
                other.enableLoyaltyProgram == enableLoyaltyProgram) &&
            (identical(other.loyaltyPointsPerCurrency, loyaltyPointsPerCurrency) ||
                other.loyaltyPointsPerCurrency == loyaltyPointsPerCurrency) &&
            (identical(other.minimumRedeemPoints, minimumRedeemPoints) ||
                other.minimumRedeemPoints == minimumRedeemPoints) &&
            (identical(other.pointValue, pointValue) ||
                other.pointValue == pointValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        organizationId,
        defaultRegisterId,
        defaultBranchId,
        receiptTemplate,
        taxInclusive,
        enableCustomerDisplay,
        enableQuickKeys,
        const DeepCollectionEquality().hash(_quickKeys),
        const DeepCollectionEquality().hash(_paymentMethods),
        printReceiptDefault,
        emailReceiptDefault,
        smsReceiptDefault,
        barcodeScanningEnabled,
        offlineModeEnabled,
        syncInterval,
        currency,
        decimalPlaces,
        createdAt,
        updatedAt,
        syncedAt,
        requireCustomerForCredit,
        allowNegativeStock,
        soundEnabled,
        autoLogoutEnabled,
        autoLogoutMinutes,
        showStockInPos,
        allowPriceEdit,
        allowDiscountEdit,
        allowQuantityEdit,
        confirmBeforeDelete,
        defaultTaxRateId,
        const DeepCollectionEquality().hash(_receiptSettings),
        const DeepCollectionEquality().hash(_printerSettings),
        const DeepCollectionEquality().hash(_displaySettings),
        const DeepCollectionEquality().hash(_shortcuts),
        enableLoyaltyProgram,
        loyaltyPointsPerCurrency,
        minimumRedeemPoints,
        pointValue
      ]);

  /// Create a copy of POSSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$POSSettingsImplCopyWith<_$POSSettingsImpl> get copyWith =>
      __$$POSSettingsImplCopyWithImpl<_$POSSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$POSSettingsImplToJson(
      this,
    );
  }
}

abstract class _POSSettings extends POSSettings {
  const factory _POSSettings(
      {required final String id,
      required final String organizationId,
      final String? defaultRegisterId,
      final String? defaultBranchId,
      final String receiptTemplate,
      final bool taxInclusive,
      final bool enableCustomerDisplay,
      final bool enableQuickKeys,
      final List<QuickKey> quickKeys,
      final List<String> paymentMethods,
      final bool printReceiptDefault,
      final bool emailReceiptDefault,
      final bool smsReceiptDefault,
      final bool barcodeScanningEnabled,
      final bool offlineModeEnabled,
      final int syncInterval,
      final String currency,
      final int decimalPlaces,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final DateTime? syncedAt,
      final bool requireCustomerForCredit,
      final bool allowNegativeStock,
      final bool soundEnabled,
      final bool autoLogoutEnabled,
      final int autoLogoutMinutes,
      final bool showStockInPos,
      final bool allowPriceEdit,
      final bool allowDiscountEdit,
      final bool allowQuantityEdit,
      final bool confirmBeforeDelete,
      final String? defaultTaxRateId,
      final Map<String, dynamic> receiptSettings,
      final Map<String, dynamic> printerSettings,
      final Map<String, dynamic> displaySettings,
      final Map<String, dynamic> shortcuts,
      final bool enableLoyaltyProgram,
      final double loyaltyPointsPerCurrency,
      final double minimumRedeemPoints,
      final double pointValue}) = _$POSSettingsImpl;
  const _POSSettings._() : super._();

  factory _POSSettings.fromJson(Map<String, dynamic> json) =
      _$POSSettingsImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String? get defaultRegisterId;
  @override
  String? get defaultBranchId;
  @override
  String get receiptTemplate;
  @override
  bool get taxInclusive;
  @override
  bool get enableCustomerDisplay;
  @override
  bool get enableQuickKeys;
  @override
  List<QuickKey> get quickKeys;
  @override
  List<String> get paymentMethods;
  @override
  bool get printReceiptDefault;
  @override
  bool get emailReceiptDefault;
  @override
  bool get smsReceiptDefault;
  @override
  bool get barcodeScanningEnabled;
  @override
  bool get offlineModeEnabled;
  @override
  int get syncInterval;
  @override
  String get currency;
  @override
  int get decimalPlaces;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get syncedAt; // Additional POS settings
  @override
  bool get requireCustomerForCredit;
  @override
  bool get allowNegativeStock;
  @override
  bool get soundEnabled;
  @override
  bool get autoLogoutEnabled;
  @override
  int get autoLogoutMinutes;
  @override
  bool get showStockInPos;
  @override
  bool get allowPriceEdit;
  @override
  bool get allowDiscountEdit;
  @override
  bool get allowQuantityEdit;
  @override
  bool get confirmBeforeDelete;
  @override
  String? get defaultTaxRateId;
  @override
  Map<String, dynamic> get receiptSettings;
  @override
  Map<String, dynamic> get printerSettings;
  @override
  Map<String, dynamic> get displaySettings;
  @override
  Map<String, dynamic> get shortcuts;
  @override
  bool get enableLoyaltyProgram;
  @override
  double get loyaltyPointsPerCurrency;
  @override
  double get minimumRedeemPoints;
  @override
  double get pointValue;

  /// Create a copy of POSSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$POSSettingsImplCopyWith<_$POSSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuickKey _$QuickKeyFromJson(Map<String, dynamic> json) {
  return _QuickKey.fromJson(json);
}

/// @nodoc
mixin _$QuickKey {
  String get id => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this QuickKey to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuickKey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuickKeyCopyWith<QuickKey> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuickKeyCopyWith<$Res> {
  factory $QuickKeyCopyWith(QuickKey value, $Res Function(QuickKey) then) =
      _$QuickKeyCopyWithImpl<$Res, QuickKey>;
  @useResult
  $Res call(
      {String id,
      String productId,
      String label,
      String? color,
      String? icon,
      int position,
      bool isActive,
      String? category,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$QuickKeyCopyWithImpl<$Res, $Val extends QuickKey>
    implements $QuickKeyCopyWith<$Res> {
  _$QuickKeyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuickKey
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? label = null,
    Object? color = freezed,
    Object? icon = freezed,
    Object? position = null,
    Object? isActive = null,
    Object? category = freezed,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuickKeyImplCopyWith<$Res>
    implements $QuickKeyCopyWith<$Res> {
  factory _$$QuickKeyImplCopyWith(
          _$QuickKeyImpl value, $Res Function(_$QuickKeyImpl) then) =
      __$$QuickKeyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String productId,
      String label,
      String? color,
      String? icon,
      int position,
      bool isActive,
      String? category,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$$QuickKeyImplCopyWithImpl<$Res>
    extends _$QuickKeyCopyWithImpl<$Res, _$QuickKeyImpl>
    implements _$$QuickKeyImplCopyWith<$Res> {
  __$$QuickKeyImplCopyWithImpl(
      _$QuickKeyImpl _value, $Res Function(_$QuickKeyImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuickKey
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? label = null,
    Object? color = freezed,
    Object? icon = freezed,
    Object? position = null,
    Object? isActive = null,
    Object? category = freezed,
    Object? metadata = null,
  }) {
    return _then(_$QuickKeyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
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
class _$QuickKeyImpl implements _QuickKey {
  const _$QuickKeyImpl(
      {required this.id,
      required this.productId,
      required this.label,
      this.color,
      this.icon,
      required this.position,
      this.isActive = true,
      this.category,
      final Map<String, dynamic> metadata = const {}})
      : _metadata = metadata;

  factory _$QuickKeyImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuickKeyImplFromJson(json);

  @override
  final String id;
  @override
  final String productId;
  @override
  final String label;
  @override
  final String? color;
  @override
  final String? icon;
  @override
  final int position;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final String? category;
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
    return 'QuickKey(id: $id, productId: $productId, label: $label, color: $color, icon: $icon, position: $position, isActive: $isActive, category: $category, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuickKeyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      productId,
      label,
      color,
      icon,
      position,
      isActive,
      category,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of QuickKey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuickKeyImplCopyWith<_$QuickKeyImpl> get copyWith =>
      __$$QuickKeyImplCopyWithImpl<_$QuickKeyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuickKeyImplToJson(
      this,
    );
  }
}

abstract class _QuickKey implements QuickKey {
  const factory _QuickKey(
      {required final String id,
      required final String productId,
      required final String label,
      final String? color,
      final String? icon,
      required final int position,
      final bool isActive,
      final String? category,
      final Map<String, dynamic> metadata}) = _$QuickKeyImpl;

  factory _QuickKey.fromJson(Map<String, dynamic> json) =
      _$QuickKeyImpl.fromJson;

  @override
  String get id;
  @override
  String get productId;
  @override
  String get label;
  @override
  String? get color;
  @override
  String? get icon;
  @override
  int get position;
  @override
  bool get isActive;
  @override
  String? get category;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of QuickKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuickKeyImplCopyWith<_$QuickKeyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
