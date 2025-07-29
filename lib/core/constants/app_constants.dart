import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Inventory Management';
  static const String appTagline = 'Smart Inventory Management by Zaions';
  static const String companyName = 'Zaions';
  static const String copyrightText = '© 2024 Zaions. All rights reserved.';

  // Navigation
  static const int bottomNavItemCount = 5;
  static const Duration pageTransitionDuration = Duration(milliseconds: 300);
  static const Curve pageTransitionCurve = Curves.easeInOut;

  // Animation Durations
  static const Duration fastAnimationDuration = Duration(milliseconds: 200);
  static const Duration normalAnimationDuration = Duration(milliseconds: 300);
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);
  static const Duration splashScreenDuration = Duration(seconds: 2);

  // Sizes
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double extraLargePadding = 32.0;
  
  static const double defaultBorderRadius = 12.0;
  static const double smallBorderRadius = 8.0;
  static const double largeBorderRadius = 16.0;
  static const double circularBorderRadius = 100.0;
  
  static const double defaultElevation = 4.0;
  static const double smallElevation = 2.0;
  static const double largeElevation = 8.0;
  
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  static const double iconSizeExtraLarge = 48.0;
  
  static const double avatarSizeSmall = 32.0;
  static const double avatarSizeMedium = 48.0;
  static const double avatarSizeLarge = 64.0;
  static const double avatarSizeExtraLarge = 96.0;

  // Grid
  static const int gridCrossAxisCountMobile = 2;
  static const int gridCrossAxisCountTablet = 3;
  static const int gridCrossAxisCountDesktop = 4;
  static const double gridSpacing = 16.0;
  static const double gridChildAspectRatio = 0.75;

  // Form
  static const int maxNameLength = 100;
  static const int maxDescriptionLength = 500;
  static const int maxNotesLength = 1000;
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int otpLength = 6;
  static const int phoneNumberLength = 10;
  static const int zipCodeLength = 5;

  // Inventory
  static const double lowStockThreshold = 0.2; // 20% of reorder point
  static const double criticalStockThreshold = 0.1; // 10% of reorder point
  static const int defaultReorderPoint = 10;
  static const int defaultReorderQuantity = 50;
  static const int maxQuantityPerOrder = 10000;
  static const int maxProductsPerCategory = 1000;
  static const int barcodeLength = 13; // EAN-13
  static const int skuLength = 10;

  // Pricing
  static const double minPrice = 0.01;
  static const double maxPrice = 999999.99;
  static const double maxDiscountPercentage = 100.0;
  static const int priceDecimalPlaces = 2;
  static const String defaultCurrency = 'USD';
  static const List<String> supportedCurrencies = ['USD', 'EUR', 'GBP', 'CAD', 'AUD'];

  // Date & Time
  static const String dateFormat = 'yyyy-MM-dd';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm';
  static const String displayDateFormat = 'MMM dd, yyyy';
  static const String displayTimeFormat = 'hh:mm a';
  static const String displayDateTimeFormat = 'MMM dd, yyyy hh:mm a';
  static const int daysInWeek = 7;
  static const int daysInMonth = 30;
  static const int daysInYear = 365;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  static const int minPageSize = 5;
  static const List<int> pageSizeOptions = [10, 20, 50, 100];

  // Search
  static const int minSearchLength = 2;
  static const Duration searchDebounceDelay = Duration(milliseconds: 500);
  static const int maxSearchResults = 50;
  static const int recentSearchLimit = 10;

  // File Upload
  static const int maxFileSizeMB = 10;
  static const int maxImageSizeMB = 5;
  static const int maxDocumentSizeMB = 10;
  static const List<String> allowedImageFormats = ['jpg', 'jpeg', 'png', 'webp'];
  static const List<String> allowedDocumentFormats = ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'csv'];
  static const int maxImagesPerProduct = 10;
  static const int imageQuality = 85;
  static const double imageMaxWidth = 1920;
  static const double imageMaxHeight = 1080;
  static const double thumbnailSize = 150;

  // Cache
  static const Duration cacheValidDuration = Duration(hours: 24);
  static const Duration shortCacheDuration = Duration(minutes: 5);
  static const Duration mediumCacheDuration = Duration(minutes: 30);
  static const Duration longCacheDuration = Duration(hours: 24);
  static const int maxCacheSize = 100; // MB

  // Network
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 2);
  static const List<int> retryStatusCodes = [408, 429, 500, 502, 503, 504];

  // Security
  static const int sessionTimeoutMinutes = 60;
  static const int maxLoginAttempts = 5;
  static const Duration lockoutDuration = Duration(minutes: 15);
  static const int tokenRefreshThreshold = 300; // 5 minutes before expiry
  static const List<String> sensitiveFields = ['password', 'token', 'secret', 'key'];

  // Notifications
  static const int maxNotificationTitleLength = 50;
  static const int maxNotificationBodyLength = 200;
  static const Duration notificationDisplayDuration = Duration(seconds: 5);
  static const int maxNotificationsToShow = 100;
  static const List<String> notificationChannels = ['general', 'inventory', 'orders', 'alerts'];

  // Reports
  static const List<String> reportTypes = ['inventory', 'sales', 'purchases', 'suppliers', 'customers'];
  static const List<String> reportFormats = ['pdf', 'excel', 'csv'];
  static const int maxReportDays = 365;
  static const int defaultReportDays = 30;

  // Barcode
  static const List<String> supportedBarcodeFormats = ['EAN13', 'EAN8', 'UPC', 'CODE128', 'QR'];
  static const double barcodeScannerAspectRatio = 1.5;
  static const Duration barcodeScanTimeout = Duration(seconds: 30);

  // Order Status
  static const List<String> orderStatuses = ['pending', 'processing', 'shipped', 'delivered', 'cancelled'];
  static const List<String> paymentStatuses = ['pending', 'paid', 'partial', 'refunded', 'failed'];
  static const List<String> shippingMethods = ['standard', 'express', 'overnight', 'pickup'];

  // User Roles
  static const List<String> userRoles = ['admin', 'manager', 'staff', 'viewer'];
  static const Map<String, List<String>> rolePermissions = {
    'admin': ['all'],
    'manager': ['read', 'write', 'delete'],
    'staff': ['read', 'write'],
    'viewer': ['read'],
  };

  // Regex Patterns
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  static final RegExp phoneRegex = RegExp(
    r'^\+?[1-9]\d{1,14}$',
  );
  static final RegExp urlRegex = RegExp(
    r'^(http|https)://([\w\-]+\.)+[\w\-]+(/[\w\-._~:/?#\[\]@!$&' r"'" r'()*+,;=]*)?$',
  );
  static final RegExp passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );
  static final RegExp alphanumericRegex = RegExp(r'^[a-zA-Z0-9]+$');
  static final RegExp numericRegex = RegExp(r'^\d+$');
  static final RegExp decimalRegex = RegExp(r'^\d+(\.\d{1,2})?$');

  // Error Messages
  static const String genericErrorMessage = 'Something went wrong. Please try again.';
  static const String networkErrorMessage = 'Please check your internet connection.';
  static const String serverErrorMessage = 'Server error. Please try again later.';
  static const String validationErrorMessage = 'Please check your input and try again.';
  static const String unauthorizedErrorMessage = 'You are not authorized to perform this action.';
  static const String sessionExpiredMessage = 'Your session has expired. Please login again.';

  // Success Messages
  static const String genericSuccessMessage = 'Operation completed successfully.';
  static const String saveSuccessMessage = 'Saved successfully.';
  static const String updateSuccessMessage = 'Updated successfully.';
  static const String deleteSuccessMessage = 'Deleted successfully.';
  static const String syncSuccessMessage = 'Synced successfully.';

  // Empty States
  static const String emptyInventoryMessage = 'No products in inventory';
  static const String emptySearchMessage = 'No results found';
  static const String emptyOrdersMessage = 'No orders yet';
  static const String emptyNotificationsMessage = 'No notifications';
  static const String emptyCategoriesMessage = 'No categories created';

  // Loading Messages
  static const String loadingMessage = 'Loading...';
  static const String savingMessage = 'Saving...';
  static const String deletingMessage = 'Deleting...';
  static const String syncingMessage = 'Syncing...';
  static const String processingMessage = 'Processing...';

  // Confirmation Messages
  static const String deleteConfirmationMessage = 'Are you sure you want to delete this item?';
  static const String logoutConfirmationMessage = 'Are you sure you want to logout?';
  static const String discardChangesMessage = 'Discard unsaved changes?';
  static const String resetConfirmationMessage = 'Are you sure you want to reset?';
}