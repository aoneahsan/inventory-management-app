import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization.freezed.dart';
part 'organization.g.dart';

@freezed
class Organization with _$Organization {
  const factory Organization({
    required String id,
    required String name,
    String? code,
    @Default('free') SubscriptionTier subscriptionTier,
    @Default('active') SubscriptionStatus subscriptionStatus,
    @Default(1) int maxUsers,
    @Default(100) int maxProducts,
    @Default(1) int maxLocations,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
    
    // Business details
    String? logoUrl,
    String? website,
    String? email,
    String? phone,
    String? taxNumber,
    String? registrationNumber,
    
    // Address
    String? address,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    
    // Settings
    OrganizationSettings? settings,
    
    // Subscription details
    DateTime? subscriptionStartDate,
    DateTime? subscriptionEndDate,
    DateTime? trialEndDate,
    @Default(0) double monthlyRevenue,
    @Default({}) Map<String, dynamic> metadata,
  }) = _Organization;
  
  const Organization._();
  
  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);
  
  // Helper methods
  bool get isActive => subscriptionStatus == SubscriptionStatus.active;
  bool get isInTrial => trialEndDate != null && DateTime.now().isBefore(trialEndDate!);
  bool get canAddMoreUsers => maxUsers == -1 || maxUsers > 0; // -1 means unlimited
  bool get canAddMoreProducts => maxProducts == -1 || maxProducts > 0;
  bool get canAddMoreLocations => maxLocations == -1 || maxLocations > 0;
  
  String get displayAddress {
    final parts = <String>[];
    if (address != null) parts.add(address!);
    if (city != null) parts.add(city!);
    if (state != null) parts.add(state!);
    if (postalCode != null) parts.add(postalCode!);
    if (country != null) parts.add(country!);
    return parts.join(', ');
  }
}

@freezed
class OrganizationSettings with _$OrganizationSettings {
  const factory OrganizationSettings({
    // Business settings
    @Default('USD') String currency,
    @Default('en') String language,
    @Default('UTC') String timezone,
    @Default('YYYY-MM-DD') String dateFormat,
    @Default('24h') String timeFormat,
    @Default(2) int decimalPlaces,
    
    // Inventory settings
    @Default(true) bool trackInventory,
    @Default(true) bool allowNegativeStock,
    @Default(true) bool enableLowStockAlerts,
    @Default(10) int lowStockThreshold,
    @Default(true) bool enableExpiryAlerts,
    @Default(30) int expiryAlertDays,
    
    // Sales settings
    @Default(true) bool enablePOS,
    @Default(true) bool enableQuotes,
    @Default(true) bool enableInvoices,
    @Default(true) bool enableReceipts,
    @Default(true) bool requireCustomerForSale,
    @Default(false) bool enableLayaway,
    @Default(30) int defaultPaymentTerms,
    
    // Tax settings
    @Default(true) bool enableTax,
    @Default('exclusive') String taxType, // inclusive or exclusive
    @Default(0) double defaultTaxRate,
    @Default(false) bool enableCompoundTax,
    
    // Barcode settings
    @Default(true) bool enableBarcodeScanning,
    @Default('CODE128') String defaultBarcodeFormat,
    @Default(true) bool autogenerateBarcodes,
    String? barcodePrefix,
    
    // Notification settings
    @Default(true) bool emailNotifications,
    @Default(true) bool smsNotifications,
    @Default(true) bool pushNotifications,
    @Default([]) List<String> notificationEmails,
    
    // Print settings
    @Default('A4') String paperSize,
    @Default(true) bool printLogo,
    @Default(true) bool printAddress,
    @Default(true) bool printTaxNumber,
    String? printHeader,
    String? printFooter,
    
    // Custom fields
    @Default({}) Map<String, dynamic> customFields,
  }) = _OrganizationSettings;
  
  factory OrganizationSettings.fromJson(Map<String, dynamic> json) =>
      _$OrganizationSettingsFromJson(json);
}

enum SubscriptionTier {
  free,
  starter,
  professional,
  enterprise,
  custom;
  
  String get displayName {
    switch (this) {
      case SubscriptionTier.free:
        return 'Free';
      case SubscriptionTier.starter:
        return 'Starter';
      case SubscriptionTier.professional:
        return 'Professional';
      case SubscriptionTier.enterprise:
        return 'Enterprise';
      case SubscriptionTier.custom:
        return 'Custom';
    }
  }
  
  Map<String, dynamic> get limits {
    switch (this) {
      case SubscriptionTier.free:
        return {
          'maxUsers': 1,
          'maxProducts': 100,
          'maxLocations': 1,
          'maxSalesPerMonth': 100,
          'features': ['basic_inventory', 'basic_pos'],
        };
      case SubscriptionTier.starter:
        return {
          'maxUsers': 3,
          'maxProducts': 1000,
          'maxLocations': 2,
          'maxSalesPerMonth': 1000,
          'features': [
            'basic_inventory',
            'basic_pos',
            'barcode_scanning',
            'basic_reports',
            'email_support',
          ],
        };
      case SubscriptionTier.professional:
        return {
          'maxUsers': 10,
          'maxProducts': 10000,
          'maxLocations': 5,
          'maxSalesPerMonth': -1, // unlimited
          'features': [
            'advanced_inventory',
            'advanced_pos',
            'barcode_scanning',
            'advanced_reports',
            'multi_location',
            'purchase_orders',
            'customer_management',
            'loyalty_program',
            'api_access',
            'priority_support',
          ],
        };
      case SubscriptionTier.enterprise:
        return {
          'maxUsers': -1, // unlimited
          'maxProducts': -1,
          'maxLocations': -1,
          'maxSalesPerMonth': -1,
          'features': [
            '*', // all features
          ],
        };
      case SubscriptionTier.custom:
        return {
          'maxUsers': -1,
          'maxProducts': -1,
          'maxLocations': -1,
          'maxSalesPerMonth': -1,
          'features': ['*'],
        };
    }
  }
}

enum SubscriptionStatus {
  active,
  trialing,
  pastDue,
  canceled,
  suspended;
  
  String get displayName {
    switch (this) {
      case SubscriptionStatus.active:
        return 'Active';
      case SubscriptionStatus.trialing:
        return 'Trial';
      case SubscriptionStatus.pastDue:
        return 'Past Due';
      case SubscriptionStatus.canceled:
        return 'Canceled';
      case SubscriptionStatus.suspended:
        return 'Suspended';
    }
  }
}

extension SubscriptionTierExtension on String {
  SubscriptionTier toSubscriptionTier() {
    return SubscriptionTier.values.firstWhere(
      (tier) => tier.name == this,
      orElse: () => SubscriptionTier.free,
    );
  }
}

extension SubscriptionStatusExtension on String {
  SubscriptionStatus toSubscriptionStatus() {
    return SubscriptionStatus.values.firstWhere(
      (status) => status.name == this,
      orElse: () => SubscriptionStatus.active,
    );
  }
}