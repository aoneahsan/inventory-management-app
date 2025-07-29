class EnvConfig {
  // Environment
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );

  // API Base URLs
  static const String devApiBaseUrl = String.fromEnvironment(
    'DEV_API_BASE_URL',
    defaultValue: 'http://localhost:3000/api/v1',
  );

  static const String stagingApiBaseUrl = String.fromEnvironment(
    'STAGING_API_BASE_URL',
    defaultValue: 'https://staging-api.inventory.zaions.com/api/v1',
  );

  static const String prodApiBaseUrl = String.fromEnvironment(
    'PROD_API_BASE_URL',
    defaultValue: 'https://api.inventory.zaions.com/api/v1',
  );

  // API Keys
  static const String googleMapsApiKey = String.fromEnvironment(
    'GOOGLE_MAPS_API_KEY',
    defaultValue: '',
  );

  static const String stripePublishableKey = String.fromEnvironment(
    'STRIPE_PUBLISHABLE_KEY',
    defaultValue: '',
  );

  static const String firebaseApiKey = String.fromEnvironment(
    'FIREBASE_API_KEY',
    defaultValue: '',
  );

  static const String firebaseProjectId = String.fromEnvironment(
    'FIREBASE_PROJECT_ID',
    defaultValue: '',
  );

  static const String firebaseMessagingSenderId = String.fromEnvironment(
    'FIREBASE_MESSAGING_SENDER_ID',
    defaultValue: '',
  );

  static const String firebaseAppId = String.fromEnvironment(
    'FIREBASE_APP_ID',
    defaultValue: '',
  );

  // Analytics
  static const String sentryDsn = String.fromEnvironment(
    'SENTRY_DSN',
    defaultValue: '',
  );

  static const String mixpanelToken = String.fromEnvironment(
    'MIXPANEL_TOKEN',
    defaultValue: '',
  );

  static const String amplitudeApiKey = String.fromEnvironment(
    'AMPLITUDE_API_KEY',
    defaultValue: '',
  );

  // Storage
  static const String awsAccessKeyId = String.fromEnvironment(
    'AWS_ACCESS_KEY_ID',
    defaultValue: '',
  );

  static const String awsSecretAccessKey = String.fromEnvironment(
    'AWS_SECRET_ACCESS_KEY',
    defaultValue: '',
  );

  static const String awsS3Bucket = String.fromEnvironment(
    'AWS_S3_BUCKET',
    defaultValue: 'inventory-zaions-uploads',
  );

  static const String awsRegion = String.fromEnvironment(
    'AWS_REGION',
    defaultValue: 'us-east-1',
  );

  // Push Notifications
  static const String oneSignalAppId = String.fromEnvironment(
    'ONESIGNAL_APP_ID',
    defaultValue: '',
  );

  static const String fcmServerKey = String.fromEnvironment(
    'FCM_SERVER_KEY',
    defaultValue: '',
  );

  // OAuth
  static const String googleClientId = String.fromEnvironment(
    'GOOGLE_CLIENT_ID',
    defaultValue: '',
  );

  static const String googleClientSecret = String.fromEnvironment(
    'GOOGLE_CLIENT_SECRET',
    defaultValue: '',
  );

  static const String microsoftClientId = String.fromEnvironment(
    'MICROSOFT_CLIENT_ID',
    defaultValue: '',
  );

  static const String microsoftClientSecret = String.fromEnvironment(
    'MICROSOFT_CLIENT_SECRET',
    defaultValue: '',
  );

  // Feature Flags
  static const bool enableBarcodeScanning = bool.fromEnvironment(
    'ENABLE_BARCODE_SCANNING',
    defaultValue: true,
  );

  static const bool enableOfflineMode = bool.fromEnvironment(
    'ENABLE_OFFLINE_MODE',
    defaultValue: true,
  );

  static const bool enableMultiWarehouse = bool.fromEnvironment(
    'ENABLE_MULTI_WAREHOUSE',
    defaultValue: true,
  );

  static const bool enableAdvancedReports = bool.fromEnvironment(
    'ENABLE_ADVANCED_REPORTS',
    defaultValue: true,
  );

  static const bool enableAiPredictions = bool.fromEnvironment(
    'ENABLE_AI_PREDICTIONS',
    defaultValue: false,
  );

  // App Store
  static const String appStoreId = String.fromEnvironment(
    'APP_STORE_ID',
    defaultValue: '',
  );

  static const String playStoreId = String.fromEnvironment(
    'PLAY_STORE_ID',
    defaultValue: 'com.aoneahsan.inventory',
  );

  // Support
  static const String supportEmail = String.fromEnvironment(
    'SUPPORT_EMAIL',
    defaultValue: 'support@inventory.zaions.com',
  );

  static const String supportPhone = String.fromEnvironment(
    'SUPPORT_PHONE',
    defaultValue: '+1-800-123-4567',
  );

  static const String helpCenterUrl = String.fromEnvironment(
    'HELP_CENTER_URL',
    defaultValue: 'https://help.inventory.zaions.com',
  );

  // Legal
  static const String termsOfServiceUrl = String.fromEnvironment(
    'TERMS_OF_SERVICE_URL',
    defaultValue: 'https://inventory.zaions.com/terms',
  );

  static const String privacyPolicyUrl = String.fromEnvironment(
    'PRIVACY_POLICY_URL',
    defaultValue: 'https://inventory.zaions.com/privacy',
  );

  // Social Media
  static const String facebookUrl = String.fromEnvironment(
    'FACEBOOK_URL',
    defaultValue: 'https://facebook.com/zaionsinventory',
  );

  static const String twitterUrl = String.fromEnvironment(
    'TWITTER_URL',
    defaultValue: 'https://twitter.com/zaionsinventory',
  );

  static const String linkedInUrl = String.fromEnvironment(
    'LINKEDIN_URL',
    defaultValue: 'https://linkedin.com/company/zaions',
  );

  static const String youtubeUrl = String.fromEnvironment(
    'YOUTUBE_URL',
    defaultValue: 'https://youtube.com/zaions',
  );

  // Development Tools
  static const bool enableFlipperKit = bool.fromEnvironment(
    'ENABLE_FLIPPER_KIT',
    defaultValue: false,
  );

  static const bool enableProxyMan = bool.fromEnvironment(
    'ENABLE_PROXY_MAN',
    defaultValue: false,
  );

  static const String proxyUrl = String.fromEnvironment(
    'PROXY_URL',
    defaultValue: '',
  );

  // Database
  static const String databaseName = String.fromEnvironment(
    'DATABASE_NAME',
    defaultValue: 'inventory_zaions.db',
  );

  static const int databaseVersion = int.fromEnvironment(
    'DATABASE_VERSION',
    defaultValue: 1,
  );

  // Encryption
  static const String encryptionKey = String.fromEnvironment(
    'ENCRYPTION_KEY',
    defaultValue: 'default_encryption_key_change_in_production',
  );

  static const String encryptionSalt = String.fromEnvironment(
    'ENCRYPTION_SALT',
    defaultValue: 'default_salt_change_in_production',
  );
}