import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import '../../core/errors/exceptions.dart';

enum AppThemeMode {
  light,
  dark,
  system,
}

class ThemeService {
  static AppThemeMode _currentThemeMode = AppThemeMode.system;
  static Color _primaryColor = Colors.blue;
  static String _fontFamily = 'Roboto';

  static AppThemeMode get currentThemeMode => _currentThemeMode;
  static Color get primaryColor => _primaryColor;
  static String get fontFamily => _fontFamily;

  // Available color schemes
  static final Map<String, Color> colorSchemes = {
    'blue': Colors.blue,
    'green': Colors.green,
    'purple': Colors.purple,
    'orange': Colors.orange,
    'red': Colors.red,
    'teal': Colors.teal,
    'indigo': Colors.indigo,
    'pink': Colors.pink,
  };

  // Available fonts
  static final List<String> availableFonts = [
    'Roboto',
    'Open Sans',
    'Lato',
    'Montserrat',
    'Source Sans Pro',
  ];

  static Future<void> setThemeMode(BuildContext context, AppThemeMode mode) async {
    try {
      _currentThemeMode = mode;
      
      switch (mode) {
        case AppThemeMode.light:
          AdaptiveTheme.of(context).setLight();
          break;
        case AppThemeMode.dark:
          AdaptiveTheme.of(context).setDark();
          break;
        case AppThemeMode.system:
          AdaptiveTheme.of(context).setSystem();
          break;
      }
      
      // Save to preferences
      await _saveThemePreferences();
    } catch (e) {
      throw BusinessException(message: 'Failed to set theme mode: $e');
    }
  }

  static Future<void> setPrimaryColor(BuildContext context, Color color) async {
    try {
      _primaryColor = color;
      
      // Update the theme with new color
      final lightTheme = _buildLightTheme(color);
      final darkTheme = _buildDarkTheme(color);
      
      AdaptiveTheme.of(context).setTheme(
        light: lightTheme,
        dark: darkTheme,
      );
      
      await _saveThemePreferences();
    } catch (e) {
      throw BusinessException(message: 'Failed to set primary color: $e');
    }
  }

  static Future<void> setFontFamily(BuildContext context, String fontFamily) async {
    try {
      if (!availableFonts.contains(fontFamily)) {
        throw BusinessException(message: 'Font family not available: $fontFamily');
      }
      
      _fontFamily = fontFamily;
      
      // Update theme with new font
      final lightTheme = _buildLightTheme(_primaryColor);
      final darkTheme = _buildDarkTheme(_primaryColor);
      
      AdaptiveTheme.of(context).setTheme(
        light: lightTheme,
        dark: darkTheme,
      );
      
      await _saveThemePreferences();
    } catch (e) {
      throw BusinessException(message: 'Failed to set font family: $e');
    }
  }

  static ThemeData _buildLightTheme(Color primaryColor) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
      ),
      fontFamily: _fontFamily,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: primaryColor.withValues(alpha: 0.1),
        labelStyle: TextStyle(color: primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  static ThemeData _buildDarkTheme(Color primaryColor) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
      ),
      fontFamily: _fontFamily,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: primaryColor.withValues(alpha: 0.2),
        labelStyle: TextStyle(color: primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  static ThemeData getLightTheme() => _buildLightTheme(_primaryColor);
  static ThemeData getDarkTheme() => _buildDarkTheme(_primaryColor);

  static Future<void> _saveThemePreferences() async {
    // Here you would save to SharedPreferences
    // For now, we'll just print a message
    debugPrint('Theme preferences saved: ${_currentThemeMode.name}, 0x${((_primaryColor.a * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0')}${((_primaryColor.r * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0')}${((_primaryColor.g * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0')}${((_primaryColor.b * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0')}, $_fontFamily');
  }

  static Future<void> loadThemePreferences() async {
    // Here you would load from SharedPreferences
    // For now, we'll use defaults
    _currentThemeMode = AppThemeMode.system;
    _primaryColor = Colors.blue;
    _fontFamily = 'Roboto';
  }

  static Map<String, dynamic> getThemeInfo() {
    return {
      'theme_mode': _currentThemeMode.name,
      'primary_color': (((_primaryColor.a * 255.0).round() & 0xff) << 24) | (((_primaryColor.r * 255.0).round() & 0xff) << 16) | (((_primaryColor.g * 255.0).round() & 0xff) << 8) | ((_primaryColor.b * 255.0).round() & 0xff),
      'font_family': _fontFamily,
      'available_colors': colorSchemes.keys.toList(),
      'available_fonts': availableFonts,
    };
  }

  static String getColorName(Color color) {
    for (final entry in colorSchemes.entries) {
      if (entry.value.a == color.a && entry.value.r == color.r && entry.value.g == color.g && entry.value.b == color.b) {
        return entry.key;
      }
    }
    return 'custom';
  }
}