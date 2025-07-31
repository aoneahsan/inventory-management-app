
library inventory_management_plugin;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/core/config/plugin_config.dart';
import 'src/core/interfaces/database_adapter.dart';
import 'src/core/interfaces/simple_auth_adapter.dart';
import 'src/core/interfaces/storage_adapter.dart';
import 'src/data/datasources/shared_preferences_adapter.dart';
import 'src/services/database/database_service.dart';
import 'src/services/auth/auth_service.dart';
import 'src/services/sync/sync_service.dart';

// Export core configurations
export 'src/core/config/plugin_config.dart';
export 'src/core/interfaces/database_adapter.dart';
export 'src/core/interfaces/simple_auth_adapter.dart';
export 'src/core/interfaces/storage_adapter.dart';

// Export adapters
export 'src/data/datasources/sqflite_adapter.dart';
export 'src/data/datasources/shared_preferences_adapter.dart';

// Export entities
export 'src/domain/entities/user.dart';
export 'src/domain/entities/organization.dart';
export 'src/domain/entities/product.dart';
export 'src/domain/entities/category.dart';
export 'src/domain/entities/supplier.dart';
export 'src/domain/entities/customer.dart';
export 'src/domain/entities/sale.dart';
export 'src/domain/entities/branch.dart';

// Export services
export 'src/services/product/product_service.dart';
export 'src/services/category/category_service.dart';
export 'src/services/customer/customer_service.dart';
export 'src/services/supplier/supplier_service.dart';
export 'src/services/branch/branch_service.dart';

// Export UI components (will be added)
// export 'src/ui/widgets/product_grid.dart';
// export 'src/ui/widgets/barcode_scanner.dart';
// ... etc

// Plugin version
const String kPluginVersion = '1.0.0';

/// Main plugin class for Inventory Management
class InventoryManagementPlugin {
  static InventoryManagementPlugin? _instance;
  static InventoryPluginConfig? _config;
  static late ProviderContainer _container;
  
  // Private constructor
  InventoryManagementPlugin._();
  
  /// Get singleton instance
  static InventoryManagementPlugin get instance {
    _instance ??= InventoryManagementPlugin._();
    return _instance!;
  }
  
  /// Get current configuration
  static InventoryPluginConfig get config {
    if (_config == null) {
      throw Exception('Plugin not initialized. Call initialize() first.');
    }
    return _config!;
  }
  
  /// Get provider container for state management
  static ProviderContainer get container => _container;
  
  /// Initialize the plugin with configuration
  static Future<void> initialize(InventoryPluginConfig config) async {
    if (_config != null) {
      throw Exception('Plugin already initialized');
    }
    
    _config = config;
    _container = ProviderContainer();
    
    // Initialize services
    await _initializeServices();
    
    debugPrint('InventoryManagementPlugin initialized with version $kPluginVersion');
  }
  
  /// Initialize all services
  static Future<void> _initializeServices() async {
    // Initialize storage
    if (config.storageAdapter is SharedPreferencesAdapter) {
      await (config.storageAdapter as SharedPreferencesAdapter).initialize();
    }
    
    // Initialize database
    final databaseService = DatabaseService(
      adapter: config.databaseAdapter,
      databaseName: config.databaseName,
      version: config.databaseVersion,
    );
    await databaseService.initialize();
    
    // Initialize auth if enabled
    if (config.requireAuthentication && config.authAdapter != null) {
      final authService = AuthService(adapter: config.authAdapter!);
      await authService.initialize();
    }
    
    // Initialize sync service if enabled
    if (config.enableOfflineSync) {
      final syncService = SyncService(
        databaseService: databaseService,
        syncInterval: config.syncInterval,
        maxRetries: config.maxSyncRetries,
      );
      await syncService.initialize();
    }
  }
  
  /// Dispose of plugin resources
  static Future<void> dispose() async {
    await config.databaseAdapter.close();
    _container.dispose();
    _config = null;
    _instance = null;
  }
  
  /// Create a Flutter app with the plugin
  static Widget createApp({
    required Widget home,
    String? title,
    ThemeData? theme,
    ThemeData? darkTheme,
    ThemeMode? themeMode,
    Locale? locale,
    Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates,
    Iterable<Locale>? supportedLocales,
    GlobalKey<NavigatorState>? navigatorKey,
    List<NavigatorObserver>? navigatorObservers,
    Widget Function(BuildContext, Widget?)? builder,
    String? initialRoute,
    Map<String, WidgetBuilder>? routes,
    Route<dynamic>? Function(RouteSettings)? onGenerateRoute,
    Route<dynamic>? Function(RouteSettings)? onUnknownRoute,
  }) {
    return UncontrolledProviderScope(
      container: _container,
      child: MaterialApp(
        title: title ?? config.appName,
        theme: theme ?? _buildTheme(config.themeConfig, Brightness.light),
        darkTheme: darkTheme ?? _buildTheme(config.themeConfig, Brightness.dark),
        themeMode: themeMode ?? (config.themeConfig?.enableDarkMode ?? true 
            ? ThemeMode.system 
            : ThemeMode.light),
        locale: locale,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales ?? 
            config.supportedLanguages.map((lang) => Locale(lang)),
        home: home,
        navigatorKey: navigatorKey,
        navigatorObservers: navigatorObservers ?? const [],
        builder: builder,
        initialRoute: initialRoute,
        routes: routes ?? const {},
        onGenerateRoute: onGenerateRoute,
        onUnknownRoute: onUnknownRoute,
      ),
    );
  }
  
  /// Build theme from configuration
  static ThemeData _buildTheme(ThemeConfig? themeConfig, Brightness brightness) {
    if (themeConfig == null) {
      return brightness == Brightness.light
          ? ThemeData.light(useMaterial3: true)
          : ThemeData.dark(useMaterial3: true);
    }
    
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Color(int.parse(themeConfig.primaryColor.replaceFirst('#', '0xFF'))),
      brightness: brightness,
    );
    
    return ThemeData(
      useMaterial3: themeConfig.useMaterial3,
      colorScheme: colorScheme,
      fontFamily: themeConfig.fontFamily,
    );
  }
  
  /// Check if a feature is enabled
  static bool isFeatureEnabled(String featureName) {
    final features = config.features;
    switch (featureName) {
      case 'products':
        return features.enableProducts;
      case 'categories':
        return features.enableCategories;
      case 'inventory':
        return features.enableInventoryTracking;
      case 'barcode':
        return features.enableBarcodeScanning;
      case 'pos':
        return features.enablePOS;
      case 'suppliers':
        return features.enableSuppliers;
      case 'customers':
        return features.enableCustomers;
      case 'reports':
        return features.enableReports;
      // Add more feature checks as needed
      default:
        return false;
    }
  }
}
