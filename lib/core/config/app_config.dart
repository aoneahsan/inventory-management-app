import 'package:flutter/foundation.dart';
import 'env_config.dart';

enum Environment { development, staging, production }

class AppConfig {
  static late AppConfig _instance;
  static AppConfig get instance => _instance;

  final Environment environment;
  final String apiBaseUrl;
  final String appName;
  final String appVersion;
  final bool enableLogging;
  final bool enableCrashlytics;
  final int apiTimeout;
  final int cacheExpiration;
  final String sentryDsn;
  final String mixpanelToken;
  final int maxRetryAttempts;
  final int retryDelay;

  AppConfig._({
    required this.environment,
    required this.apiBaseUrl,
    required this.appName,
    required this.appVersion,
    required this.enableLogging,
    required this.enableCrashlytics,
    required this.apiTimeout,
    required this.cacheExpiration,
    required this.sentryDsn,
    required this.mixpanelToken,
    required this.maxRetryAttempts,
    required this.retryDelay,
  });

  static void initialize({Environment? env}) {
    final environment = env ?? _getEnvironmentFromString(EnvConfig.environment);
    
    switch (environment) {
      case Environment.development:
        _instance = AppConfig._(
          environment: environment,
          apiBaseUrl: EnvConfig.devApiBaseUrl,
          appName: 'Inventory Pro Dev',
          appVersion: '1.0.0-dev',
          enableLogging: true,
          enableCrashlytics: false,
          apiTimeout: 30000, // 30 seconds
          cacheExpiration: 300, // 5 minutes
          sentryDsn: '',
          mixpanelToken: '',
          maxRetryAttempts: 3,
          retryDelay: 1000, // 1 second
        );
        break;
        
      case Environment.staging:
        _instance = AppConfig._(
          environment: environment,
          apiBaseUrl: EnvConfig.stagingApiBaseUrl,
          appName: 'Inventory Pro Staging',
          appVersion: '1.0.0-staging',
          enableLogging: true,
          enableCrashlytics: true,
          apiTimeout: 20000, // 20 seconds
          cacheExpiration: 600, // 10 minutes
          sentryDsn: EnvConfig.sentryDsn,
          mixpanelToken: EnvConfig.mixpanelToken,
          maxRetryAttempts: 3,
          retryDelay: 2000, // 2 seconds
        );
        break;
        
      case Environment.production:
        _instance = AppConfig._(
          environment: environment,
          apiBaseUrl: EnvConfig.prodApiBaseUrl,
          appName: 'Inventory Pro',
          appVersion: '1.0.0',
          enableLogging: false,
          enableCrashlytics: true,
          apiTimeout: 15000, // 15 seconds
          cacheExpiration: 1800, // 30 minutes
          sentryDsn: EnvConfig.sentryDsn,
          mixpanelToken: EnvConfig.mixpanelToken,
          maxRetryAttempts: 5,
          retryDelay: 3000, // 3 seconds
        );
        break;
    }
  }

  static Environment _getEnvironmentFromString(String env) {
    switch (env.toLowerCase()) {
      case 'development':
      case 'dev':
        return Environment.development;
      case 'staging':
      case 'stage':
        return Environment.staging;
      case 'production':
      case 'prod':
        return Environment.production;
      default:
        return kDebugMode ? Environment.development : Environment.production;
    }
  }

  bool get isDevelopment => environment == Environment.development;
  bool get isStaging => environment == Environment.staging;
  bool get isProduction => environment == Environment.production;

  // Feature flags
  bool get enableAnalytics => !isDevelopment;
  bool get enablePerformanceMonitoring => !isDevelopment;
  bool get enableDebugTools => isDevelopment;
  bool get enableMockData => isDevelopment;
  bool get enableNetworkLogging => isDevelopment || isStaging;

  // API endpoints
  String get authEndpoint => '$apiBaseUrl/auth';
  String get inventoryEndpoint => '$apiBaseUrl/inventory';
  String get productsEndpoint => '$apiBaseUrl/products';
  String get categoriesEndpoint => '$apiBaseUrl/categories';
  String get suppliersEndpoint => '$apiBaseUrl/suppliers';
  String get ordersEndpoint => '$apiBaseUrl/orders';
  String get reportsEndpoint => '$apiBaseUrl/reports';
  String get usersEndpoint => '$apiBaseUrl/users';
  String get warehousesEndpoint => '$apiBaseUrl/warehouses';
  String get notificationsEndpoint => '$apiBaseUrl/notifications';

  // WebSocket endpoints
  String get wsBaseUrl => apiBaseUrl.replaceFirst('https://', 'wss://').replaceFirst('http://', 'ws://');
  String get wsInventoryUpdates => '$wsBaseUrl/inventory/updates';
  String get wsNotifications => '$wsBaseUrl/notifications';

  // Storage keys
  String get authTokenKey => 'auth_token';
  String get refreshTokenKey => 'refresh_token';
  String get userDataKey => 'user_data';
  String get themeKey => 'theme_preference';
  String get languageKey => 'language_preference';
  String get onboardingKey => 'onboarding_completed';
  String get biometricKey => 'biometric_enabled';

  // Pagination
  int get defaultPageSize => 20;
  int get maxPageSize => 100;

  // File upload
  int get maxFileSize => 10 * 1024 * 1024; // 10MB
  List<String> get allowedImageExtensions => ['.jpg', '.jpeg', '.png', '.webp'];
  List<String> get allowedDocumentExtensions => ['.pdf', '.doc', '.docx', '.xls', '.xlsx'];

  // Cache durations (in seconds)
  int get shortCacheDuration => 300; // 5 minutes
  int get mediumCacheDuration => 1800; // 30 minutes
  int get longCacheDuration => 86400; // 24 hours

  // Rate limiting
  int get maxRequestsPerMinute => isProduction ? 60 : 120;
  int get maxConcurrentRequests => 5;

  // Security
  int get sessionTimeout => 3600; // 1 hour
  int get maxLoginAttempts => 5;
  int get lockoutDuration => 900; // 15 minutes
  int get minPasswordLength => 8;
  bool get requireBiometricForSensitiveActions => isProduction;

  @override
  String toString() {
    return '''
AppConfig {
  environment: $environment,
  apiBaseUrl: $apiBaseUrl,
  appName: $appName,
  appVersion: $appVersion,
  enableLogging: $enableLogging,
  enableCrashlytics: $enableCrashlytics
}
''';
  }
}