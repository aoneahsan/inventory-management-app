import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite_common/sqflite.dart';
import 'firebase_options.dart';
import 'core/config/app_config.dart';
import 'services/permissions/permission_service.dart';
import 'presentation/app.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  
  // Keep splash screen on until app is ready
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  
  try {
    // Initialize database factory for web first
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }
    
    // Initialize environment configuration
    final envString = const String.fromEnvironment('ENV', defaultValue: 'dev');
    final environment = Environment.values.firstWhere(
      (e) => e.name == envString,
      orElse: () => Environment.development,
    );
    
    // Initialize app configuration
    AppConfig.initialize(env: environment);
    
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    
    // Initialize permissions system
    try {
      final permissionService = PermissionService();
      await permissionService.initializeDefaultPermissions();
    } catch (e) {
      debugPrint('Warning: Failed to initialize permissions: $e');
    }
    
    // Initialize date formatting
    await initializeDateFormatting();
    
    // Get saved theme mode if any
    final savedThemeMode = await AdaptiveTheme.getThemeMode();
    
    // Remove splash screen
    FlutterNativeSplash.remove();
    
    // Run the app
    runApp(
      ProviderScope(
        child: InventoryApp(savedThemeMode: savedThemeMode),
      ),
    );
  } catch (error, stackTrace) {
    // Log error for debugging
    debugPrint('Error during app initialization: $error');
    debugPrint('Stack trace: $stackTrace');
    
    // Remove splash screen even on error
    FlutterNativeSplash.remove();
    
    // Show error app
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 64,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Failed to initialize app',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}