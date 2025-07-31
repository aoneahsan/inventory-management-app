import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
class Category with _$Category {
  const factory Category({
    required String id,
    required String organizationId,
    required String name,
    String? description,
    String? parentId,
    String? color,
    String? icon,
    @Default(0) int sortOrder,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
    
    // Additional fields for plugin
    String? imageUrl,
    @Default(0) int productCount,
    @Default([]) List<String> childrenIds,
    @Default({}) Map<String, dynamic> metadata,
    String? taxRateId,
    @Default(true) bool applyToSubcategories,
  }) = _Category;
  
  const Category._();
  
  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  
  // Helper methods
  bool get isRootCategory => parentId == null;
  bool get hasChildren => childrenIds.isNotEmpty;
  
  String get displayPath {
    // This would be populated with full path in service layer
    return name;
  }
  
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    // Convert DateTime to Firestore Timestamp format
    json['created_at'] = createdAt.millisecondsSinceEpoch;
    json['updated_at'] = updatedAt.millisecondsSinceEpoch;
    if (syncedAt != null) {
      json['synced_at'] = syncedAt!.millisecondsSinceEpoch;
    }
    return json;
  }
  
  factory Category.fromFirestore(Map<String, dynamic> json) {
    // Convert Firestore Timestamp to DateTime
    if (json['created_at'] is int) {
      json['created_at'] = DateTime.fromMillisecondsSinceEpoch(json['created_at']).toIso8601String();
    }
    if (json['updated_at'] is int) {
      json['updated_at'] = DateTime.fromMillisecondsSinceEpoch(json['updated_at']).toIso8601String();
    }
    if (json['synced_at'] is int) {
      json['synced_at'] = DateTime.fromMillisecondsSinceEpoch(json['synced_at']).toIso8601String();
    }
    return Category.fromJson(json);
  }
}