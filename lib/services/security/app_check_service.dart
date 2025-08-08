import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';

class AppCheckService {
  static final AppCheckService _instance = AppCheckService._internal();
  factory AppCheckService() => _instance;
  AppCheckService._internal();

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    try {
      await FirebaseAppCheck.instance.activate(
        // Use debug provider for debug builds
        webProvider: kDebugMode 
            ? ReCaptchaV3Provider('YOUR_RECAPTCHA_SITE_KEY_DEBUG')
            : ReCaptchaV3Provider('YOUR_RECAPTCHA_SITE_KEY_PROD'),
        
        // Android provider
        androidProvider: kDebugMode 
            ? AndroidProvider.debug 
            : AndroidProvider.safetyNet,
        
        // iOS provider
        appleProvider: kDebugMode
            ? AppleProvider.debug
            : AppleProvider.appAttest,
      );

      // Set token auto-refresh
      await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);

      // Listen to token changes
      FirebaseAppCheck.instance.onTokenChange.listen((token) {
        print('App Check token refreshed');
      });

      _initialized = true;
      print('Firebase App Check initialized successfully');
    } catch (e) {
      print('Failed to initialize Firebase App Check: $e');
      // Don't throw - app should still work without App Check in development
    }
  }

  // Get current App Check token
  Future<String?> getToken() async {
    try {
      final token = await FirebaseAppCheck.instance.getToken();
      return token;
    } catch (e) {
      print('Failed to get App Check token: $e');
      return null;
    }
  }

  // Force token refresh
  Future<void> refreshToken() async {
    try {
      await FirebaseAppCheck.instance.getToken(true);
    } catch (e) {
      print('Failed to refresh App Check token: $e');
    }
  }

  // Check if App Check is supported on current platform
  bool get isSupported {
    // App Check is supported on Web, Android, and iOS
    return kIsWeb || 
           defaultTargetPlatform == TargetPlatform.android ||
           defaultTargetPlatform == TargetPlatform.iOS;
  }
}