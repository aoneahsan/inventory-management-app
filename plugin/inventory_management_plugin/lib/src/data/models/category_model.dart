import 'dart:convert';

import '../../domain/entities/category.dart';
import '../database/database_schema.dart';
import 'base_model.dart';

/// Database model for Category entity
class CategoryModel extends BaseModel {
  final Category category;
  
  CategoryModel(this.category);
  
  @override
  String get tableName => DatabaseSchema.categoriesTable;
  
  @override
  Map<String, dynamic> toDatabase() {
    return {
      DatabaseSchema.id: category.id,
      DatabaseSchema.organizationId: category.organizationId,
      'name': category.name,
      'description': category.description,
      'parent_id': category.parentId,
      'color': category.color,
      'icon': category.icon,
      'sort_order': category.sortOrder,
      DatabaseSchema.isActive: boolToInt(category.isActive),
      DatabaseSchema.metadata: encodeMetadata(category.metadata),
      DatabaseSchema.createdAt: dateTimeToMillis(category.createdAt),
      DatabaseSchema.updatedAt: dateTimeToMillis(category.updatedAt),
      DatabaseSchema.syncedAt: dateTimeToMillis(category.syncedAt),
    };
  }
  
  /// Create Category from database map
  factory CategoryModel.fromDatabase(Map<String, dynamic> map) {
    final category = _fromMap(map);
    return CategoryModel(category);
  }
  
  static Category _fromMap(Map<String, dynamic> map) {
    return Category(
      id: map[DatabaseSchema.id] as String,
      organizationId: map[DatabaseSchema.organizationId] as String,
      name: map['name'] as String,
      description: map['description'] as String?,
      parentId: map['parent_id'] as String?,
      color: map['color'] as String?,
      icon: map['icon'] as String?,
      sortOrder: map['sort_order'] as int? ?? 0,
      isActive: map[DatabaseSchema.isActive] == 1,
      metadata: _decodeMetadata(map[DatabaseSchema.metadata] as String?),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.createdAt] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.updatedAt] as int),
      syncedAt: map[DatabaseSchema.syncedAt] != null
          ? DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.syncedAt] as int)
          : null,
    );
  }
  
  static Map<String, dynamic> _decodeMetadata(String? metadata) {
    if (metadata == null || metadata.isEmpty) return {};
    try {
      return Map<String, dynamic>.from(json.decode(metadata));
    } catch (_) {
      return {};
    }
  }
}