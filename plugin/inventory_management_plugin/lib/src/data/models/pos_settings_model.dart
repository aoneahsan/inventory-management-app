import 'dart:convert';

import '../../domain/entities/pos_settings.dart';
import '../database/database_schema.dart';
import 'base_model.dart';

/// Database model for POSSettings entity
class POSSettingsModel extends BaseModel {
  final POSSettings posSettings;
  
  POSSettingsModel(this.posSettings);
  
  @override
  String get tableName => DatabaseSchema.posSettingsTable;
  
  @override
  Map<String, dynamic> toDatabase() {
    return {
      DatabaseSchema.id: posSettings.id,
      DatabaseSchema.organizationId: posSettings.organizationId,
      'branch_id': posSettings.branchId,
      'enable_quick_keys': boolToInt(posSettings.enableQuickKeys),
      'enable_barcode_scanning': boolToInt(posSettings.enableBarcodeScanning),
      'enable_customer_display': boolToInt(posSettings.enableCustomerDisplay),
      'enable_cash_drawer': boolToInt(posSettings.enableCashDrawer),
      'enable_receipt_printer': boolToInt(posSettings.enableReceiptPrinter),
      'enable_kitchen_printer': boolToInt(posSettings.enableKitchenPrinter),
      'enable_table_management': boolToInt(posSettings.enableTableManagement),
      'enable_offline_mode': boolToInt(posSettings.enableOfflineMode),
      'offline_sync_interval': posSettings.offlineSyncInterval,
      'default_payment_method': posSettings.defaultPaymentMethod?.name,
      'auto_print_receipt': boolToInt(posSettings.autoPrintReceipt),
      'show_tax_inclusive': boolToInt(posSettings.showTaxInclusive),
      'enable_discount': boolToInt(posSettings.enableDiscount),
      'max_discount_percentage': posSettings.maxDiscountPercentage,
      'require_discount_approval': boolToInt(posSettings.requireDiscountApproval),
      'enable_loyalty_points': boolToInt(posSettings.enableLoyaltyPoints),
      'points_earning_rate': posSettings.pointsEarningRate,
      'points_redemption_rate': posSettings.pointsRedemptionRate,
      'min_points_redemption': posSettings.minPointsRedemption,
      'enable_split_payment': boolToInt(posSettings.enableSplitPayment),
      'enable_partial_payment': boolToInt(posSettings.enablePartialPayment),
      'enable_credit_sales': boolToInt(posSettings.enableCreditSales),
      'receipt_header': posSettings.receiptHeader,
      'receipt_footer': posSettings.receiptFooter,
      'receipt_logo_url': posSettings.receiptLogoUrl,
      'currency_symbol': posSettings.currencySymbol,
      'decimal_places': posSettings.decimalPlaces,
      'date_format': posSettings.dateFormat,
      'time_format': posSettings.timeFormat,
      'enable_sound_effects': boolToInt(posSettings.enableSoundEffects),
      'theme': posSettings.theme,
      'language': posSettings.language,
      DatabaseSchema.metadata: encodeMetadata(posSettings.metadata),
      DatabaseSchema.createdAt: dateTimeToMillis(posSettings.createdAt),
      DatabaseSchema.updatedAt: dateTimeToMillis(posSettings.updatedAt),
      DatabaseSchema.syncedAt: dateTimeToMillis(posSettings.syncedAt),
    };
  }
  
  /// Create POSSettings from database map
  factory POSSettingsModel.fromDatabase(Map<String, dynamic> map) {
    final posSettings = _fromMap(map);
    return POSSettingsModel(posSettings);
  }
  
  static POSSettings _fromMap(Map<String, dynamic> map) {
    return POSSettings(
      id: map[DatabaseSchema.id] as String,
      organizationId: map[DatabaseSchema.organizationId] as String,
      branchId: map['branch_id'] as String,
      enableQuickKeys: map['enable_quick_keys'] == 1,
      enableBarcodeScanning: map['enable_barcode_scanning'] == 1,
      enableCustomerDisplay: map['enable_customer_display'] == 1,
      enableCashDrawer: map['enable_cash_drawer'] == 1,
      enableReceiptPrinter: map['enable_receipt_printer'] == 1,
      enableKitchenPrinter: map['enable_kitchen_printer'] == 1,
      enableTableManagement: map['enable_table_management'] == 1,
      enableOfflineMode: map['enable_offline_mode'] == 1,
      offlineSyncInterval: map['offline_sync_interval'] as int? ?? 30,
      defaultPaymentMethod: _parsePaymentMethod(map['default_payment_method'] as String?),
      autoPrintReceipt: map['auto_print_receipt'] == 1,
      showTaxInclusive: map['show_tax_inclusive'] == 1,
      enableDiscount: map['enable_discount'] == 1,
      maxDiscountPercentage: (map['max_discount_percentage'] as num?)?.toDouble() ?? 100,
      requireDiscountApproval: map['require_discount_approval'] == 1,
      enableLoyaltyPoints: map['enable_loyalty_points'] == 1,
      pointsEarningRate: (map['points_earning_rate'] as num?)?.toDouble() ?? 1,
      pointsRedemptionRate: (map['points_redemption_rate'] as num?)?.toDouble() ?? 0.01,
      minPointsRedemption: map['min_points_redemption'] as int? ?? 100,
      enableSplitPayment: map['enable_split_payment'] == 1,
      enablePartialPayment: map['enable_partial_payment'] == 1,
      enableCreditSales: map['enable_credit_sales'] == 1,
      receiptHeader: map['receipt_header'] as String?,
      receiptFooter: map['receipt_footer'] as String?,
      receiptLogoUrl: map['receipt_logo_url'] as String?,
      currencySymbol: map['currency_symbol'] as String? ?? '\$',
      decimalPlaces: map['decimal_places'] as int? ?? 2,
      dateFormat: map['date_format'] as String? ?? 'yyyy-MM-dd',
      timeFormat: map['time_format'] as String? ?? 'HH:mm',
      enableSoundEffects: map['enable_sound_effects'] == 1,
      theme: map['theme'] as String? ?? 'light',
      language: map['language'] as String? ?? 'en',
      quickKeys: [], // Quick keys will be loaded separately
      metadata: _decodeMetadata(map[DatabaseSchema.metadata] as String?),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.createdAt] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.updatedAt] as int),
      syncedAt: map[DatabaseSchema.syncedAt] != null
          ? DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.syncedAt] as int)
          : null,
    );
  }
  
  static PaymentMethod? _parsePaymentMethod(String? method) {
    if (method == null) return null;
    try {
      return PaymentMethod.values.firstWhere((e) => e.name == method);
    } catch (_) {
      return PaymentMethod.cash;
    }
  }
  
  static Map<String, dynamic> _decodeMetadata(String? metadata) {
    if (metadata == null || metadata.isEmpty) return {};
    try {
      return Map<String, dynamic>.from(json.decode(metadata));
    } catch (_) {
      return {};
    }
  }
}