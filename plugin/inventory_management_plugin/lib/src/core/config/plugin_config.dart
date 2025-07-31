import 'package:flutter/foundation.dart';
import '../interfaces/database_adapter.dart';
import '../interfaces/simple_auth_adapter.dart';
import '../interfaces/storage_adapter.dart';

class InventoryPluginConfig {
  // Database configuration
  final DatabaseAdapter databaseAdapter;
  final String databaseName;
  final int databaseVersion;
  
  // Authentication configuration
  final AuthAdapter? authAdapter;
  final bool requireAuthentication;
  
  // Storage configuration
  final StorageAdapter storageAdapter;
  
  // API configuration
  final String? apiBaseUrl;
  final Map<String, String>? apiHeaders;
  final Duration apiTimeout;
  
  // Sync configuration
  final bool enableOfflineSync;
  final Duration syncInterval;
  final int maxSyncRetries;
  
  // Feature flags
  final FeatureFlags features;
  
  // Theme configuration
  final ThemeConfig? themeConfig;
  
  // Localization
  final List<String> supportedLanguages;
  final String defaultLanguage;
  
  // Organization configuration
  final bool enableMultiTenancy;
  final String? defaultOrganizationId;
  
  // Plugin metadata
  final String appName;
  final String appVersion;
  final String? appLogo;
  
  const InventoryPluginConfig({
    required this.databaseAdapter,
    this.databaseName = 'inventory_management',
    this.databaseVersion = 1,
    this.authAdapter,
    this.requireAuthentication = true,
    required this.storageAdapter,
    this.apiBaseUrl,
    this.apiHeaders,
    this.apiTimeout = const Duration(seconds: 30),
    this.enableOfflineSync = true,
    this.syncInterval = const Duration(minutes: 5),
    this.maxSyncRetries = 3,
    this.features = const FeatureFlags(),
    this.themeConfig,
    this.supportedLanguages = const ['en', 'es', 'fr'],
    this.defaultLanguage = 'en',
    this.enableMultiTenancy = true,
    this.defaultOrganizationId,
    this.appName = 'Inventory Management',
    this.appVersion = '1.0.0',
    this.appLogo,
  });

  InventoryPluginConfig copyWith({
    DatabaseAdapter? databaseAdapter,
    String? databaseName,
    int? databaseVersion,
    AuthAdapter? authAdapter,
    bool? requireAuthentication,
    StorageAdapter? storageAdapter,
    String? apiBaseUrl,
    Map<String, String>? apiHeaders,
    Duration? apiTimeout,
    bool? enableOfflineSync,
    Duration? syncInterval,
    int? maxSyncRetries,
    FeatureFlags? features,
    ThemeConfig? themeConfig,
    List<String>? supportedLanguages,
    String? defaultLanguage,
    bool? enableMultiTenancy,
    String? defaultOrganizationId,
    String? appName,
    String? appVersion,
    String? appLogo,
  }) {
    return InventoryPluginConfig(
      databaseAdapter: databaseAdapter ?? this.databaseAdapter,
      databaseName: databaseName ?? this.databaseName,
      databaseVersion: databaseVersion ?? this.databaseVersion,
      authAdapter: authAdapter ?? this.authAdapter,
      requireAuthentication: requireAuthentication ?? this.requireAuthentication,
      storageAdapter: storageAdapter ?? this.storageAdapter,
      apiBaseUrl: apiBaseUrl ?? this.apiBaseUrl,
      apiHeaders: apiHeaders ?? this.apiHeaders,
      apiTimeout: apiTimeout ?? this.apiTimeout,
      enableOfflineSync: enableOfflineSync ?? this.enableOfflineSync,
      syncInterval: syncInterval ?? this.syncInterval,
      maxSyncRetries: maxSyncRetries ?? this.maxSyncRetries,
      features: features ?? this.features,
      themeConfig: themeConfig ?? this.themeConfig,
      supportedLanguages: supportedLanguages ?? this.supportedLanguages,
      defaultLanguage: defaultLanguage ?? this.defaultLanguage,
      enableMultiTenancy: enableMultiTenancy ?? this.enableMultiTenancy,
      defaultOrganizationId: defaultOrganizationId ?? this.defaultOrganizationId,
      appName: appName ?? this.appName,
      appVersion: appVersion ?? this.appVersion,
      appLogo: appLogo ?? this.appLogo,
    );
  }
}

@immutable
class FeatureFlags {
  // Core features
  final bool enableProducts;
  final bool enableCategories;
  final bool enableInventoryTracking;
  
  // Advanced inventory features
  final bool enableBarcodeScanning;
  final bool enableSerialNumbers;
  final bool enableBatchTracking;
  final bool enableCompositeItems;
  final bool enableRepackaging;
  
  // Multi-location features
  final bool enableMultiLocation;
  final bool enableStockTransfers;
  
  // Purchase management
  final bool enableSuppliers;
  final bool enablePurchaseOrders;
  final bool enablePurchaseBills;
  
  // Customer management
  final bool enableCustomers;
  final bool enableCustomerCredit;
  final bool enableLoyaltyPoints;
  
  // POS features
  final bool enablePOS;
  final bool enableOfflinePOS;
  final bool enableCashDrawer;
  final bool enableReceipts;
  
  // Tax features
  final bool enableTaxManagement;
  final bool enableGST;
  
  // Communication features
  final bool enableEmailTemplates;
  final bool enableSMSTemplates;
  final bool enableWhatsAppTemplates;
  
  // Reporting features
  final bool enableReports;
  final bool enableScheduledReports;
  final bool enableCustomReports;
  
  // Export features
  final bool enablePDFExport;
  final bool enableExcelExport;
  final bool enableCSVExport;

  const FeatureFlags({
    this.enableProducts = true,
    this.enableCategories = true,
    this.enableInventoryTracking = true,
    this.enableBarcodeScanning = true,
    this.enableSerialNumbers = true,
    this.enableBatchTracking = true,
    this.enableCompositeItems = true,
    this.enableRepackaging = true,
    this.enableMultiLocation = true,
    this.enableStockTransfers = true,
    this.enableSuppliers = true,
    this.enablePurchaseOrders = true,
    this.enablePurchaseBills = true,
    this.enableCustomers = true,
    this.enableCustomerCredit = true,
    this.enableLoyaltyPoints = true,
    this.enablePOS = true,
    this.enableOfflinePOS = true,
    this.enableCashDrawer = true,
    this.enableReceipts = true,
    this.enableTaxManagement = true,
    this.enableGST = true,
    this.enableEmailTemplates = true,
    this.enableSMSTemplates = true,
    this.enableWhatsAppTemplates = true,
    this.enableReports = true,
    this.enableScheduledReports = true,
    this.enableCustomReports = true,
    this.enablePDFExport = true,
    this.enableExcelExport = true,
    this.enableCSVExport = true,
  });

  FeatureFlags copyWith({
    bool? enableProducts,
    bool? enableCategories,
    bool? enableInventoryTracking,
    bool? enableBarcodeScanning,
    bool? enableSerialNumbers,
    bool? enableBatchTracking,
    bool? enableCompositeItems,
    bool? enableRepackaging,
    bool? enableMultiLocation,
    bool? enableStockTransfers,
    bool? enableSuppliers,
    bool? enablePurchaseOrders,
    bool? enablePurchaseBills,
    bool? enableCustomers,
    bool? enableCustomerCredit,
    bool? enableLoyaltyPoints,
    bool? enablePOS,
    bool? enableOfflinePOS,
    bool? enableCashDrawer,
    bool? enableReceipts,
    bool? enableTaxManagement,
    bool? enableGST,
    bool? enableEmailTemplates,
    bool? enableSMSTemplates,
    bool? enableWhatsAppTemplates,
    bool? enableReports,
    bool? enableScheduledReports,
    bool? enableCustomReports,
    bool? enablePDFExport,
    bool? enableExcelExport,
    bool? enableCSVExport,
  }) {
    return FeatureFlags(
      enableProducts: enableProducts ?? this.enableProducts,
      enableCategories: enableCategories ?? this.enableCategories,
      enableInventoryTracking: enableInventoryTracking ?? this.enableInventoryTracking,
      enableBarcodeScanning: enableBarcodeScanning ?? this.enableBarcodeScanning,
      enableSerialNumbers: enableSerialNumbers ?? this.enableSerialNumbers,
      enableBatchTracking: enableBatchTracking ?? this.enableBatchTracking,
      enableCompositeItems: enableCompositeItems ?? this.enableCompositeItems,
      enableRepackaging: enableRepackaging ?? this.enableRepackaging,
      enableMultiLocation: enableMultiLocation ?? this.enableMultiLocation,
      enableStockTransfers: enableStockTransfers ?? this.enableStockTransfers,
      enableSuppliers: enableSuppliers ?? this.enableSuppliers,
      enablePurchaseOrders: enablePurchaseOrders ?? this.enablePurchaseOrders,
      enablePurchaseBills: enablePurchaseBills ?? this.enablePurchaseBills,
      enableCustomers: enableCustomers ?? this.enableCustomers,
      enableCustomerCredit: enableCustomerCredit ?? this.enableCustomerCredit,
      enableLoyaltyPoints: enableLoyaltyPoints ?? this.enableLoyaltyPoints,
      enablePOS: enablePOS ?? this.enablePOS,
      enableOfflinePOS: enableOfflinePOS ?? this.enableOfflinePOS,
      enableCashDrawer: enableCashDrawer ?? this.enableCashDrawer,
      enableReceipts: enableReceipts ?? this.enableReceipts,
      enableTaxManagement: enableTaxManagement ?? this.enableTaxManagement,
      enableGST: enableGST ?? this.enableGST,
      enableEmailTemplates: enableEmailTemplates ?? this.enableEmailTemplates,
      enableSMSTemplates: enableSMSTemplates ?? this.enableSMSTemplates,
      enableWhatsAppTemplates: enableWhatsAppTemplates ?? this.enableWhatsAppTemplates,
      enableReports: enableReports ?? this.enableReports,
      enableScheduledReports: enableScheduledReports ?? this.enableScheduledReports,
      enableCustomReports: enableCustomReports ?? this.enableCustomReports,
      enablePDFExport: enablePDFExport ?? this.enablePDFExport,
      enableExcelExport: enableExcelExport ?? this.enableExcelExport,
      enableCSVExport: enableCSVExport ?? this.enableCSVExport,
    );
  }
}

@immutable
class ThemeConfig {
  final String primaryColor;
  final String secondaryColor;
  final String errorColor;
  final String successColor;
  final String warningColor;
  final String infoColor;
  final String fontFamily;
  final bool useMaterial3;
  final bool enableDarkMode;
  final Map<String, dynamic>? customThemeData;

  const ThemeConfig({
    this.primaryColor = '#2196F3',
    this.secondaryColor = '#FF9800',
    this.errorColor = '#F44336',
    this.successColor = '#4CAF50',
    this.warningColor = '#FF9800',
    this.infoColor = '#2196F3',
    this.fontFamily = 'Roboto',
    this.useMaterial3 = true,
    this.enableDarkMode = true,
    this.customThemeData,
  });
}