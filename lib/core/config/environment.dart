class Environment {
  static const String env = String.fromEnvironment('ENV', defaultValue: 'dev');
  
  static bool get isDevelopment => env == 'dev';
  static bool get isStaging => env == 'staging';
  static bool get isProduction => env == 'prod';
  
  // App URLs
  static String get appUrl {
    switch (env) {
      case 'prod':
        return 'https://inventory.yourdomain.com';
      case 'staging':
        return 'https://staging.inventory.yourdomain.com';
      default:
        return 'http://localhost:3000';
    }
  }
  
  // Stripe Configuration
  static String get stripePublishableKey {
    switch (env) {
      case 'prod':
        return const String.fromEnvironment(
          'STRIPE_PUBLISHABLE_KEY',
          defaultValue: 'pk_live_YOUR_LIVE_KEY',
        );
      default:
        return const String.fromEnvironment(
          'STRIPE_PUBLISHABLE_KEY',
          defaultValue: 'pk_test_YOUR_TEST_KEY',
        );
    }
  }
  
  // Stripe Price IDs
  static String get stripeBasicPriceId {
    switch (env) {
      case 'prod':
        return 'price_live_basic_monthly';
      default:
        return 'price_test_basic_monthly';
    }
  }
  
  static String get stripeProfessionalPriceId {
    switch (env) {
      case 'prod':
        return 'price_live_professional_monthly';
      default:
        return 'price_test_professional_monthly';
    }
  }
  
  static String get stripeEnterprisePriceId {
    switch (env) {
      case 'prod':
        return 'price_live_enterprise_monthly';
      default:
        return 'price_test_enterprise_monthly';
    }
  }
  
  // Firebase Configuration
  static String get firebaseProjectId {
    switch (env) {
      case 'prod':
        return 'inventory-prod';
      case 'staging':
        return 'inventory-staging';
      default:
        return 'inventory-dev';
    }
  }
  
  // Feature Flags
  static bool get enableAnalytics => isProduction;
  static bool get enableCrashlytics => !isDevelopment;
  static bool get enablePerformanceMonitoring => !isDevelopment;
  static bool get enableDebugMode => isDevelopment;
  
  // API Configuration
  static Duration get apiTimeout => const Duration(seconds: 30);
  static int get maxRetries => 3;
  
  // Cache Configuration
  static Duration get cacheExpiration => const Duration(hours: 1);
  static int get maxCacheSize => 50 * 1024 * 1024; // 50MB
}