import 'package:freezed_annotation/freezed_annotation.dart';

part 'pos_settings.freezed.dart';
part 'pos_settings.g.dart';

@freezed
class POSSettings with _$POSSettings {
  const factory POSSettings({
    required String id,
    required String organizationId,
    String? defaultRegisterId,
    String? defaultBranchId,
    @Default('default') String receiptTemplate,
    @Default(false) bool taxInclusive,
    @Default(true) bool enableCustomerDisplay,
    @Default(true) bool enableQuickKeys,
    @Default([]) List<QuickKey> quickKeys,
    @Default(['cash', 'card', 'upi']) List<String> paymentMethods,
    @Default(true) bool printReceiptDefault,
    @Default(false) bool emailReceiptDefault,
    @Default(false) bool smsReceiptDefault,
    @Default(true) bool barcodeScanningEnabled,
    @Default(true) bool offlineModeEnabled,
    @Default(30) int syncInterval,
    @Default('USD') String currency,
    @Default(2) int decimalPlaces,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
    
    // Additional POS settings
    @Default(true) bool requireCustomerForCredit,
    @Default(false) bool allowNegativeStock,
    @Default(true) bool soundEnabled,
    @Default(false) bool autoLogoutEnabled,
    @Default(30) int autoLogoutMinutes,
    @Default(true) bool showStockInPos,
    @Default(false) bool allowPriceEdit,
    @Default(false) bool allowDiscountEdit,
    @Default(false) bool allowQuantityEdit,
    @Default(true) bool confirmBeforeDelete,
    String? defaultTaxRateId,
    @Default({}) Map<String, dynamic> receiptSettings,
    @Default({}) Map<String, dynamic> printerSettings,
    @Default({}) Map<String, dynamic> displaySettings,
    @Default({}) Map<String, dynamic> shortcuts,
    @Default(true) bool enableLoyaltyProgram,
    @Default(1.0) double loyaltyPointsPerCurrency,
    @Default(100) double minimumRedeemPoints,
    @Default(0.01) double pointValue,
  }) = _POSSettings;
  
  const POSSettings._();
  
  factory POSSettings.fromJson(Map<String, dynamic> json) => 
      _$POSSettingsFromJson(json);
  
  // Helper methods
  factory POSSettings.defaultSettings({
    required String organizationId,
    String? defaultBranchId,
  }) {
    final now = DateTime.now();
    return POSSettings(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      organizationId: organizationId,
      defaultBranchId: defaultBranchId,
      createdAt: now,
      updatedAt: now,
    );
  }
  
  bool isPaymentMethodEnabled(String method) {
    return paymentMethods.contains(method);
  }
  
  double calculateLoyaltyPoints(double amount) {
    if (!enableLoyaltyProgram) return 0;
    return amount * loyaltyPointsPerCurrency;
  }
  
  double calculatePointsValue(double points) {
    if (!enableLoyaltyProgram) return 0;
    return points * pointValue;
  }
  
  bool canRedeemPoints(double points) {
    return enableLoyaltyProgram && points >= minimumRedeemPoints;
  }
}

@freezed
class QuickKey with _$QuickKey {
  const factory QuickKey({
    required String id,
    required String productId,
    required String label,
    String? color,
    String? icon,
    required int position,
    @Default(true) bool isActive,
    String? category,
    @Default({}) Map<String, dynamic> metadata,
  }) = _QuickKey;
  
  factory QuickKey.fromJson(Map<String, dynamic> json) => 
      _$QuickKeyFromJson(json);
}

class PaymentMethod {
  static const String cash = 'cash';
  static const String card = 'card';
  static const String upi = 'upi';
  static const String wallet = 'wallet';
  static const String credit = 'credit';
  static const String split = 'split';
  static const String bankTransfer = 'bank_transfer';
  static const String cheque = 'cheque';
  static const String giftCard = 'gift_card';
  static const String loyaltyPoints = 'loyalty_points';
  
  static String getDisplayName(String method) {
    switch (method) {
      case cash:
        return 'Cash';
      case card:
        return 'Card';
      case upi:
        return 'UPI';
      case wallet:
        return 'Wallet';
      case credit:
        return 'Credit';
      case split:
        return 'Split Payment';
      case bankTransfer:
        return 'Bank Transfer';
      case cheque:
        return 'Cheque';
      case giftCard:
        return 'Gift Card';
      case loyaltyPoints:
        return 'Loyalty Points';
      default:
        return method;
    }
  }
}

class SaleStatus {
  static const String draft = 'draft';
  static const String pending = 'pending';
  static const String completed = 'completed';
  static const String refunded = 'refunded';
  static const String partialRefund = 'partial_refund';
  static const String cancelled = 'cancelled';
  static const String onHold = 'on_hold';
  static const String layaway = 'layaway';
  
  static String getDisplayName(String status) {
    switch (status) {
      case draft:
        return 'Draft';
      case pending:
        return 'Pending';
      case completed:
        return 'Completed';
      case refunded:
        return 'Refunded';
      case partialRefund:
        return 'Partial Refund';
      case cancelled:
        return 'Cancelled';
      case onHold:
        return 'On Hold';
      case layaway:
        return 'Layaway';
      default:
        return status;
    }
  }
}