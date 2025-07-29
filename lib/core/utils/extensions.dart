import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// String Extensions
extension StringExtension on String {
  // Validation
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  bool get isValidUrl {
    final urlRegex = RegExp(
      r'^(http|https)://([\w\-]+\.)+[\w\-]+(/[\w\-._~:/?#\[\]@!$&' r"'" r'()*+,;=]*)?$',
    );
    return urlRegex.hasMatch(this);
  }

  bool get isValidPhone {
    final phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');
    return phoneRegex.hasMatch(replaceAll(RegExp(r'\D'), ''));
  }

  bool get isNumeric => double.tryParse(this) != null;
  bool get isAlphanumeric => RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);
  bool get hasUpperCase => contains(RegExp(r'[A-Z]'));
  bool get hasLowerCase => contains(RegExp(r'[a-z]'));
  bool get hasDigit => contains(RegExp(r'[0-9]'));
  bool get hasSpecialCharacter => contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  // Formatting
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String get capitalizeWords {
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  String get initials {
    if (isEmpty) return '';
    final words = split(' ').where((word) => word.isNotEmpty).toList();
    if (words.isEmpty) return '';
    if (words.length == 1) return words[0][0].toUpperCase();
    return '${words.first[0]}${words.last[0]}'.toUpperCase();
  }

  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - ellipsis.length)}$ellipsis';
  }

  String removeAllWhitespace() => replaceAll(RegExp(r'\s+'), '');

  String toSnakeCase() {
    return replaceAllMapped(
      RegExp(r'[A-Z]'),
      (Match match) => '_${match[0]!.toLowerCase()}',
    ).replaceAll(RegExp(r'^_'), '');
  }

  String toCamelCase() {
    final words = split(RegExp(r'[_\s]+'));
    if (words.isEmpty) return this;
    return words.first.toLowerCase() +
        words.skip(1).map((word) => word.capitalize).join();
  }

  // Parsing
  int? toIntOrNull() => int.tryParse(this);
  double? toDoubleOrNull() => double.tryParse(this);
  bool toBool() => toLowerCase() == 'true' || this == '1';

  // Security
  String mask({int visibleStart = 0, int visibleEnd = 0, String maskChar = '*'}) {
    if (length <= visibleStart + visibleEnd) return this;
    final start = substring(0, visibleStart);
    final end = substring(length - visibleEnd);
    final masked = maskChar * (length - visibleStart - visibleEnd);
    return '$start$masked$end';
  }

  String maskEmail() {
    final parts = split('@');
    if (parts.length != 2) return this;
    final username = parts[0];
    final domain = parts[1];
    if (username.length <= 3) return this;
    return '${username.substring(0, 2)}${username.substring(2).replaceAll(RegExp(r'.'), '*')}@$domain';
  }
}

// String? Extensions
extension NullableStringExtension on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
  String orEmpty() => this ?? '';
  String or(String defaultValue) => this ?? defaultValue;
}

// DateTime Extensions
extension DateTimeExtension on DateTime {
  // Formatting
  String get formatDate => DateFormat('yyyy-MM-dd').format(this);
  String get formatTime => DateFormat('HH:mm').format(this);
  String get formatDateTime => DateFormat('yyyy-MM-dd HH:mm').format(this);
  String get formatDateDisplay => DateFormat('MMM dd, yyyy').format(this);
  String get formatTimeDisplay => DateFormat('hh:mm a').format(this);
  String get formatDateTimeDisplay => DateFormat('MMM dd, yyyy hh:mm a').format(this);
  String get formatMonthYear => DateFormat('MMMM yyyy').format(this);
  String get formatDayMonth => DateFormat('dd MMM').format(this);
  String get dayOfWeek => DateFormat('EEEE').format(this);
  String get monthName => DateFormat('MMMM').format(this);

  // Time ago
  String timeAgo({bool numericDates = true}) {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return years == 1 ? '1 year ago' : '$years years ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? '1 month ago' : '$months months ago';
    } else if (difference.inDays > 7) {
      final weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
    } else if (difference.inDays > 0) {
      return difference.inDays == 1
          ? numericDates ? '1 day ago' : 'Yesterday'
          : '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return difference.inHours == 1 ? '1 hour ago' : '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return difference.inMinutes == 1
          ? '1 minute ago'
          : '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  // Comparisons
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year && month == tomorrow.month && day == tomorrow.day;
  }

  bool get isThisWeek {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 7));
    return isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
           isBefore(endOfWeek);
  }

  bool get isThisMonth {
    final now = DateTime.now();
    return year == now.year && month == now.month;
  }

  bool get isThisYear => year == DateTime.now().year;
  bool get isPast => isBefore(DateTime.now());
  bool get isFuture => isAfter(DateTime.now());

  // Date operations
  DateTime get startOfDay => DateTime(year, month, day);
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);
  DateTime get startOfMonth => DateTime(year, month);
  DateTime get endOfMonth => DateTime(year, month + 1, 0, 23, 59, 59, 999);
  DateTime get startOfYear => DateTime(year);
  DateTime get endOfYear => DateTime(year, 12, 31, 23, 59, 59, 999);

  DateTime addBusinessDays(int days) {
    var date = this;
    var daysToAdd = days;
    while (daysToAdd > 0) {
      date = date.add(const Duration(days: 1));
      if (date.weekday != DateTime.saturday && date.weekday != DateTime.sunday) {
        daysToAdd--;
      }
    }
    return date;
  }

  int get daysInMonth => DateTime(year, month + 1, 0).day;
  int get weekOfMonth => ((day - 1 + DateTime(year, month, 1).weekday - 1) / 7).floor() + 1;
  int get quarter => ((month - 1) / 3).floor() + 1;
}

// Numeric Extensions
extension NumExtension on num {
  // Formatting
  String get formatCurrency {
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    return formatter.format(this);
  }

  String formatCurrencyCustom({String symbol = '\$', int decimalDigits = 2}) {
    final formatter = NumberFormat.currency(symbol: symbol, decimalDigits: decimalDigits);
    return formatter.format(this);
  }

  String get formatCompact => NumberFormat.compact().format(this);
  String get formatDecimal => NumberFormat.decimalPattern().format(this);
  
  String formatPercent({int decimalDigits = 0}) {
    return '${(this * 100).toStringAsFixed(decimalDigits)}%';
  }

  // File size formatting
  String get formatBytes {
    const units = ['B', 'KB', 'MB', 'GB', 'TB'];
    var size = toDouble();
    var unitIndex = 0;
    
    while (size >= 1024 && unitIndex < units.length - 1) {
      size /= 1024;
      unitIndex++;
    }
    
    return '${size.toStringAsFixed(unitIndex == 0 ? 0 : 2)} ${units[unitIndex]}';
  }

  // Duration formatting
  String get formatDuration {
    final duration = Duration(seconds: toInt());
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    
    if (hours > 0) {
      return '${hours}h ${minutes}m ${seconds}s';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  // Range checking
  bool isBetween(num min, num max) => this >= min && this <= max;
  num clamp(num min, num max) => this < min ? min : (this > max ? max : this);
}

// List Extensions
extension ListExtension<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
  T? get lastOrNull => isEmpty ? null : last;
  
  T? firstWhereOrNull(bool Function(T) test) {
    try {
      return firstWhere(test);
    } catch (_) {
      return null;
    }
  }

  T? lastWhereOrNull(bool Function(T) test) {
    try {
      return lastWhere(test);
    } catch (_) {
      return null;
    }
  }

  List<T> unique() => toSet().toList();
  
  List<List<T>> chunk(int size) {
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, (i + size > length) ? length : i + size));
    }
    return chunks;
  }

  T? random() => isEmpty ? null : this[DateTime.now().millisecond % length];
}

// Map Extensions
extension MapExtension<K, V> on Map<K, V> {
  Map<K, V> filter(bool Function(K key, V value) test) {
    final filtered = <K, V>{};
    forEach((key, value) {
      if (test(key, value)) {
        filtered[key] = value;
      }
    });
    return filtered;
  }

  V? getOrNull(K key) => containsKey(key) ? this[key] : null;
  V getOrDefault(K key, V defaultValue) => this[key] ?? defaultValue;
  
  Map<V, K> invert() {
    final inverted = <V, K>{};
    forEach((key, value) {
      inverted[value] = key;
    });
    return inverted;
  }
}

// Context Extensions
extension ContextExtension on BuildContext {
  // Theme
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  
  // MediaQuery
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get padding => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  EdgeInsets get viewPadding => mediaQuery.viewPadding;
  double get devicePixelRatio => mediaQuery.devicePixelRatio;
  
  // Device type
  bool get isPhone => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 900;
  bool get isDesktop => screenWidth >= 900;
  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;
  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;
  
  // Navigation
  NavigatorState get navigator => Navigator.of(this);
  
  void pop<T>([T? result]) => navigator.pop(result);
  
  Future<T?> push<T>(Widget page) => navigator.push<T>(
    MaterialPageRoute(builder: (_) => page),
  );
  
  Future<T?> pushReplacement<T>(Widget page) => navigator.pushReplacement<T, T>(
    MaterialPageRoute(builder: (_) => page),
  );
  
  Future<T?> pushAndRemoveUntil<T>(Widget page, {bool removeAll = true}) =>
      navigator.pushAndRemoveUntil<T>(
        MaterialPageRoute(builder: (_) => page),
        removeAll ? (_) => false : (route) => route.isFirst,
      );
  
  // SnackBar
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    Color? backgroundColor,
    Color? textColor,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: textColor)),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
      ),
    );
  }
  
  void showErrorSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: colorScheme.error,
      textColor: colorScheme.onError,
    );
  }
  
  void showSuccessSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }
  
  // Dialog
  Future<T?> showCustomDialog<T>({
    required Widget child,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      builder: (_) => child,
    );
  }
  
  // Bottom Sheet
  Future<T?> showBottomSheet<T>({
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = false,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: isScrollControlled,
      builder: (_) => child,
    );
  }
  
  // Focus
  void unfocus() => FocusScope.of(this).unfocus();
  void requestFocus(FocusNode node) => FocusScope.of(this).requestFocus(node);
}

// Duration Extensions
extension DurationExtension on Duration {
  String format({bool showHours = true, bool showMinutes = true, bool showSeconds = true}) {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);
    
    final parts = <String>[];
    
    if (showHours && hours > 0) {
      parts.add('${hours}h');
    }
    if (showMinutes && (minutes > 0 || hours > 0)) {
      parts.add('${minutes}m');
    }
    if (showSeconds) {
      parts.add('${seconds}s');
    }
    
    return parts.join(' ');
  }
  
  String get formatCompact {
    if (inDays > 0) return '${inDays}d';
    if (inHours > 0) return '${inHours}h';
    if (inMinutes > 0) return '${inMinutes}m';
    return '${inSeconds}s';
  }
}

// Color Extensions
extension ColorExtension on Color {
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }

  Color withOpacityPercent(int percent) {
    assert(percent >= 0 && percent <= 100);
    return withValues(alpha: percent / 100);
  }

  String toHex({bool includeHash = true}) {
    return '${includeHash ? '#' : ''}'
        '${((a * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0')}'
        '${((r * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0')}'
        '${((g * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0')}'
        '${((b * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0')}';
  }
}