import 'dart:convert';

/// Base class for all database models
abstract class BaseModel {
  /// Convert model to database map
  Map<String, dynamic> toDatabase();
  
  /// Get table name for this model
  String get tableName;
  
  /// Get primary key field name
  String get primaryKey => 'id';
  
  /// Convert metadata to JSON string
  String? encodeMetadata(Map<String, dynamic>? metadata) {
    if (metadata == null || metadata.isEmpty) return null;
    return jsonEncode(metadata);
  }
  
  /// Parse metadata from JSON string
  Map<String, dynamic>? decodeMetadata(String? metadata) {
    if (metadata == null || metadata.isEmpty) return null;
    try {
      return jsonDecode(metadata) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }
  
  /// Convert DateTime to milliseconds for database storage
  int? dateTimeToMillis(DateTime? dateTime) {
    return dateTime?.millisecondsSinceEpoch;
  }
  
  /// Convert milliseconds to DateTime
  DateTime? millisToDateTime(int? millis) {
    if (millis == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(millis);
  }
  
  /// Convert boolean to integer for database storage
  int boolToInt(bool value) => value ? 1 : 0;
  
  /// Convert integer to boolean
  bool intToBool(int? value) => value == 1;
  
  /// Convert list to JSON string
  String? encodeList(List<dynamic>? list) {
    if (list == null || list.isEmpty) return null;
    return jsonEncode(list);
  }
  
  /// Parse list from JSON string
  List<T>? decodeList<T>(String? json) {
    if (json == null || json.isEmpty) return null;
    try {
      final decoded = jsonDecode(json) as List;
      return decoded.cast<T>();
    } catch (_) {
      return null;
    }
  }
}