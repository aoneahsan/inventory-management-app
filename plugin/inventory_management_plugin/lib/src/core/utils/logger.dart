import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;

class Logger {
  static LogLevel _level = LogLevel.debug;
  static bool _enableConsoleOutput = true;
  static final List<LogEntry> _logs = [];
  static const int _maxLogEntries = 1000;
  
  static void setLevel(LogLevel level) {
    _level = level;
  }
  
  static void enableConsoleOutput(bool enable) {
    _enableConsoleOutput = enable;
  }
  
  static List<LogEntry> get logs => List.unmodifiable(_logs);
  
  static void debug(String message, {dynamic data, StackTrace? stackTrace}) {
    _log(LogLevel.debug, message, data: data, stackTrace: stackTrace);
  }
  
  static void info(String message, {dynamic data}) {
    _log(LogLevel.info, message, data: data);
  }
  
  static void warning(String message, {dynamic data, StackTrace? stackTrace}) {
    _log(LogLevel.warning, message, data: data, stackTrace: stackTrace);
  }
  
  static void error(String message, {dynamic error, StackTrace? stackTrace}) {
    _log(LogLevel.error, message, data: error, stackTrace: stackTrace);
  }
  
  static void _log(
    LogLevel level,
    String message, {
    dynamic data,
    StackTrace? stackTrace,
  }) {
    if (level.index < _level.index) return;
    
    final entry = LogEntry(
      level: level,
      message: message,
      data: data,
      stackTrace: stackTrace,
      timestamp: DateTime.now(),
    );
    
    // Add to log history
    _logs.add(entry);
    if (_logs.length > _maxLogEntries) {
      _logs.removeAt(0);
    }
    
    // Console output
    if (_enableConsoleOutput) {
      final output = _formatLogEntry(entry);
      
      if (kDebugMode) {
        // Use developer.log in debug mode for better formatting
        developer.log(
          output,
          name: 'InventoryPlugin',
          level: _levelToInt(level),
          error: data,
          stackTrace: stackTrace,
        );
      } else {
        // Use debugPrint in release mode
        debugPrint(output);
      }
    }
  }
  
  static String _formatLogEntry(LogEntry entry) {
    final time = entry.timestamp.toIso8601String();
    final levelStr = entry.level.name.toUpperCase().padRight(7);
    var output = '[$time] $levelStr: ${entry.message}';
    
    if (entry.data != null) {
      output += '\nData: ${entry.data}';
    }
    
    if (entry.stackTrace != null && entry.level == LogLevel.error) {
      output += '\nStackTrace: ${entry.stackTrace}';
    }
    
    return output;
  }
  
  static int _levelToInt(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 500;
      case LogLevel.info:
        return 800;
      case LogLevel.warning:
        return 900;
      case LogLevel.error:
        return 1000;
    }
  }
  
  static void clearLogs() {
    _logs.clear();
  }
  
  static Future<String> exportLogs() async {
    final buffer = StringBuffer();
    
    buffer.writeln('Inventory Management Plugin Logs');
    buffer.writeln('Generated: ${DateTime.now().toIso8601String()}');
    buffer.writeln('Total Entries: ${_logs.length}');
    buffer.writeln('-' * 80);
    
    for (final entry in _logs) {
      buffer.writeln(_formatLogEntry(entry));
      buffer.writeln('-' * 40);
    }
    
    return buffer.toString();
  }
  
  static Map<LogLevel, int> getLogCounts() {
    final counts = <LogLevel, int>{};
    
    for (final level in LogLevel.values) {
      counts[level] = _logs.where((log) => log.level == level).length;
    }
    
    return counts;
  }
}

enum LogLevel {
  debug,
  info,
  warning,
  error;
  
  bool operator >=(LogLevel other) => index >= other.index;
  bool operator <=(LogLevel other) => index <= other.index;
}

class LogEntry {
  final LogLevel level;
  final String message;
  final dynamic data;
  final StackTrace? stackTrace;
  final DateTime timestamp;
  
  LogEntry({
    required this.level,
    required this.message,
    this.data,
    this.stackTrace,
    required this.timestamp,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'level': level.name,
      'message': message,
      'data': data?.toString(),
      'stackTrace': stackTrace?.toString(),
      'timestamp': timestamp.toIso8601String(),
    };
  }
}