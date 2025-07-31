// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pos_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$POSSettingsImpl _$$POSSettingsImplFromJson(Map<String, dynamic> json) =>
    _$POSSettingsImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      defaultRegisterId: json['defaultRegisterId'] as String?,
      defaultBranchId: json['defaultBranchId'] as String?,
      receiptTemplate: json['receiptTemplate'] as String? ?? 'default',
      taxInclusive: json['taxInclusive'] as bool? ?? false,
      enableCustomerDisplay: json['enableCustomerDisplay'] as bool? ?? true,
      enableQuickKeys: json['enableQuickKeys'] as bool? ?? true,
      quickKeys: (json['quickKeys'] as List<dynamic>?)
              ?.map((e) => QuickKey.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      paymentMethods: (json['paymentMethods'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const ['cash', 'card', 'upi'],
      printReceiptDefault: json['printReceiptDefault'] as bool? ?? true,
      emailReceiptDefault: json['emailReceiptDefault'] as bool? ?? false,
      smsReceiptDefault: json['smsReceiptDefault'] as bool? ?? false,
      barcodeScanningEnabled: json['barcodeScanningEnabled'] as bool? ?? true,
      offlineModeEnabled: json['offlineModeEnabled'] as bool? ?? true,
      syncInterval: (json['syncInterval'] as num?)?.toInt() ?? 30,
      currency: json['currency'] as String? ?? 'USD',
      decimalPlaces: (json['decimalPlaces'] as num?)?.toInt() ?? 2,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      requireCustomerForCredit:
          json['requireCustomerForCredit'] as bool? ?? true,
      allowNegativeStock: json['allowNegativeStock'] as bool? ?? false,
      soundEnabled: json['soundEnabled'] as bool? ?? true,
      autoLogoutEnabled: json['autoLogoutEnabled'] as bool? ?? false,
      autoLogoutMinutes: (json['autoLogoutMinutes'] as num?)?.toInt() ?? 30,
      showStockInPos: json['showStockInPos'] as bool? ?? true,
      allowPriceEdit: json['allowPriceEdit'] as bool? ?? false,
      allowDiscountEdit: json['allowDiscountEdit'] as bool? ?? false,
      allowQuantityEdit: json['allowQuantityEdit'] as bool? ?? false,
      confirmBeforeDelete: json['confirmBeforeDelete'] as bool? ?? true,
      defaultTaxRateId: json['defaultTaxRateId'] as String?,
      receiptSettings:
          json['receiptSettings'] as Map<String, dynamic>? ?? const {},
      printerSettings:
          json['printerSettings'] as Map<String, dynamic>? ?? const {},
      displaySettings:
          json['displaySettings'] as Map<String, dynamic>? ?? const {},
      shortcuts: json['shortcuts'] as Map<String, dynamic>? ?? const {},
      enableLoyaltyProgram: json['enableLoyaltyProgram'] as bool? ?? true,
      loyaltyPointsPerCurrency:
          (json['loyaltyPointsPerCurrency'] as num?)?.toDouble() ?? 1.0,
      minimumRedeemPoints:
          (json['minimumRedeemPoints'] as num?)?.toDouble() ?? 100,
      pointValue: (json['pointValue'] as num?)?.toDouble() ?? 0.01,
    );

Map<String, dynamic> _$$POSSettingsImplToJson(_$POSSettingsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'defaultRegisterId': instance.defaultRegisterId,
      'defaultBranchId': instance.defaultBranchId,
      'receiptTemplate': instance.receiptTemplate,
      'taxInclusive': instance.taxInclusive,
      'enableCustomerDisplay': instance.enableCustomerDisplay,
      'enableQuickKeys': instance.enableQuickKeys,
      'quickKeys': instance.quickKeys,
      'paymentMethods': instance.paymentMethods,
      'printReceiptDefault': instance.printReceiptDefault,
      'emailReceiptDefault': instance.emailReceiptDefault,
      'smsReceiptDefault': instance.smsReceiptDefault,
      'barcodeScanningEnabled': instance.barcodeScanningEnabled,
      'offlineModeEnabled': instance.offlineModeEnabled,
      'syncInterval': instance.syncInterval,
      'currency': instance.currency,
      'decimalPlaces': instance.decimalPlaces,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'requireCustomerForCredit': instance.requireCustomerForCredit,
      'allowNegativeStock': instance.allowNegativeStock,
      'soundEnabled': instance.soundEnabled,
      'autoLogoutEnabled': instance.autoLogoutEnabled,
      'autoLogoutMinutes': instance.autoLogoutMinutes,
      'showStockInPos': instance.showStockInPos,
      'allowPriceEdit': instance.allowPriceEdit,
      'allowDiscountEdit': instance.allowDiscountEdit,
      'allowQuantityEdit': instance.allowQuantityEdit,
      'confirmBeforeDelete': instance.confirmBeforeDelete,
      'defaultTaxRateId': instance.defaultTaxRateId,
      'receiptSettings': instance.receiptSettings,
      'printerSettings': instance.printerSettings,
      'displaySettings': instance.displaySettings,
      'shortcuts': instance.shortcuts,
      'enableLoyaltyProgram': instance.enableLoyaltyProgram,
      'loyaltyPointsPerCurrency': instance.loyaltyPointsPerCurrency,
      'minimumRedeemPoints': instance.minimumRedeemPoints,
      'pointValue': instance.pointValue,
    };

_$QuickKeyImpl _$$QuickKeyImplFromJson(Map<String, dynamic> json) =>
    _$QuickKeyImpl(
      id: json['id'] as String,
      productId: json['productId'] as String,
      label: json['label'] as String,
      color: json['color'] as String?,
      icon: json['icon'] as String?,
      position: (json['position'] as num).toInt(),
      isActive: json['isActive'] as bool? ?? true,
      category: json['category'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$QuickKeyImplToJson(_$QuickKeyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'label': instance.label,
      'color': instance.color,
      'icon': instance.icon,
      'position': instance.position,
      'isActive': instance.isActive,
      'category': instance.category,
      'metadata': instance.metadata,
    };
