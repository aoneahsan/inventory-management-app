// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrganizationImpl _$$OrganizationImplFromJson(Map<String, dynamic> json) =>
    _$OrganizationImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String?,
      subscriptionTier: $enumDecodeNullable(
              _$SubscriptionTierEnumMap, json['subscriptionTier']) ??
          'free',
      subscriptionStatus: $enumDecodeNullable(
              _$SubscriptionStatusEnumMap, json['subscriptionStatus']) ??
          'active',
      maxUsers: (json['maxUsers'] as num?)?.toInt() ?? 1,
      maxProducts: (json['maxProducts'] as num?)?.toInt() ?? 100,
      maxLocations: (json['maxLocations'] as num?)?.toInt() ?? 1,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      logoUrl: json['logoUrl'] as String?,
      website: json['website'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      taxNumber: json['taxNumber'] as String?,
      registrationNumber: json['registrationNumber'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      postalCode: json['postalCode'] as String?,
      settings: json['settings'] == null
          ? null
          : OrganizationSettings.fromJson(
              json['settings'] as Map<String, dynamic>),
      subscriptionStartDate: json['subscriptionStartDate'] == null
          ? null
          : DateTime.parse(json['subscriptionStartDate'] as String),
      subscriptionEndDate: json['subscriptionEndDate'] == null
          ? null
          : DateTime.parse(json['subscriptionEndDate'] as String),
      trialEndDate: json['trialEndDate'] == null
          ? null
          : DateTime.parse(json['trialEndDate'] as String),
      monthlyRevenue: (json['monthlyRevenue'] as num?)?.toDouble() ?? 0,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$OrganizationImplToJson(_$OrganizationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'subscriptionTier': _$SubscriptionTierEnumMap[instance.subscriptionTier]!,
      'subscriptionStatus':
          _$SubscriptionStatusEnumMap[instance.subscriptionStatus]!,
      'maxUsers': instance.maxUsers,
      'maxProducts': instance.maxProducts,
      'maxLocations': instance.maxLocations,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'logoUrl': instance.logoUrl,
      'website': instance.website,
      'email': instance.email,
      'phone': instance.phone,
      'taxNumber': instance.taxNumber,
      'registrationNumber': instance.registrationNumber,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'postalCode': instance.postalCode,
      'settings': instance.settings,
      'subscriptionStartDate':
          instance.subscriptionStartDate?.toIso8601String(),
      'subscriptionEndDate': instance.subscriptionEndDate?.toIso8601String(),
      'trialEndDate': instance.trialEndDate?.toIso8601String(),
      'monthlyRevenue': instance.monthlyRevenue,
      'metadata': instance.metadata,
    };

const _$SubscriptionTierEnumMap = {
  SubscriptionTier.free: 'free',
  SubscriptionTier.starter: 'starter',
  SubscriptionTier.professional: 'professional',
  SubscriptionTier.enterprise: 'enterprise',
  SubscriptionTier.custom: 'custom',
};

const _$SubscriptionStatusEnumMap = {
  SubscriptionStatus.active: 'active',
  SubscriptionStatus.trialing: 'trialing',
  SubscriptionStatus.pastDue: 'pastDue',
  SubscriptionStatus.canceled: 'canceled',
  SubscriptionStatus.suspended: 'suspended',
};

_$OrganizationSettingsImpl _$$OrganizationSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$OrganizationSettingsImpl(
      currency: json['currency'] as String? ?? 'USD',
      language: json['language'] as String? ?? 'en',
      timezone: json['timezone'] as String? ?? 'UTC',
      dateFormat: json['dateFormat'] as String? ?? 'YYYY-MM-DD',
      timeFormat: json['timeFormat'] as String? ?? '24h',
      decimalPlaces: (json['decimalPlaces'] as num?)?.toInt() ?? 2,
      trackInventory: json['trackInventory'] as bool? ?? true,
      allowNegativeStock: json['allowNegativeStock'] as bool? ?? true,
      enableLowStockAlerts: json['enableLowStockAlerts'] as bool? ?? true,
      lowStockThreshold: (json['lowStockThreshold'] as num?)?.toInt() ?? 10,
      enableExpiryAlerts: json['enableExpiryAlerts'] as bool? ?? true,
      expiryAlertDays: (json['expiryAlertDays'] as num?)?.toInt() ?? 30,
      enablePOS: json['enablePOS'] as bool? ?? true,
      enableQuotes: json['enableQuotes'] as bool? ?? true,
      enableInvoices: json['enableInvoices'] as bool? ?? true,
      enableReceipts: json['enableReceipts'] as bool? ?? true,
      requireCustomerForSale: json['requireCustomerForSale'] as bool? ?? true,
      enableLayaway: json['enableLayaway'] as bool? ?? false,
      defaultPaymentTerms: (json['defaultPaymentTerms'] as num?)?.toInt() ?? 30,
      enableTax: json['enableTax'] as bool? ?? true,
      taxType: json['taxType'] as String? ?? 'exclusive',
      defaultTaxRate: (json['defaultTaxRate'] as num?)?.toDouble() ?? 0,
      enableCompoundTax: json['enableCompoundTax'] as bool? ?? false,
      enableBarcodeScanning: json['enableBarcodeScanning'] as bool? ?? true,
      defaultBarcodeFormat:
          json['defaultBarcodeFormat'] as String? ?? 'CODE128',
      autogenerateBarcodes: json['autogenerateBarcodes'] as bool? ?? true,
      barcodePrefix: json['barcodePrefix'] as String?,
      emailNotifications: json['emailNotifications'] as bool? ?? true,
      smsNotifications: json['smsNotifications'] as bool? ?? true,
      pushNotifications: json['pushNotifications'] as bool? ?? true,
      notificationEmails: (json['notificationEmails'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      paperSize: json['paperSize'] as String? ?? 'A4',
      printLogo: json['printLogo'] as bool? ?? true,
      printAddress: json['printAddress'] as bool? ?? true,
      printTaxNumber: json['printTaxNumber'] as bool? ?? true,
      printHeader: json['printHeader'] as String?,
      printFooter: json['printFooter'] as String?,
      customFields: json['customFields'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$OrganizationSettingsImplToJson(
        _$OrganizationSettingsImpl instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'language': instance.language,
      'timezone': instance.timezone,
      'dateFormat': instance.dateFormat,
      'timeFormat': instance.timeFormat,
      'decimalPlaces': instance.decimalPlaces,
      'trackInventory': instance.trackInventory,
      'allowNegativeStock': instance.allowNegativeStock,
      'enableLowStockAlerts': instance.enableLowStockAlerts,
      'lowStockThreshold': instance.lowStockThreshold,
      'enableExpiryAlerts': instance.enableExpiryAlerts,
      'expiryAlertDays': instance.expiryAlertDays,
      'enablePOS': instance.enablePOS,
      'enableQuotes': instance.enableQuotes,
      'enableInvoices': instance.enableInvoices,
      'enableReceipts': instance.enableReceipts,
      'requireCustomerForSale': instance.requireCustomerForSale,
      'enableLayaway': instance.enableLayaway,
      'defaultPaymentTerms': instance.defaultPaymentTerms,
      'enableTax': instance.enableTax,
      'taxType': instance.taxType,
      'defaultTaxRate': instance.defaultTaxRate,
      'enableCompoundTax': instance.enableCompoundTax,
      'enableBarcodeScanning': instance.enableBarcodeScanning,
      'defaultBarcodeFormat': instance.defaultBarcodeFormat,
      'autogenerateBarcodes': instance.autogenerateBarcodes,
      'barcodePrefix': instance.barcodePrefix,
      'emailNotifications': instance.emailNotifications,
      'smsNotifications': instance.smsNotifications,
      'pushNotifications': instance.pushNotifications,
      'notificationEmails': instance.notificationEmails,
      'paperSize': instance.paperSize,
      'printLogo': instance.printLogo,
      'printAddress': instance.printAddress,
      'printTaxNumber': instance.printTaxNumber,
      'printHeader': instance.printHeader,
      'printFooter': instance.printFooter,
      'customFields': instance.customFields,
    };
