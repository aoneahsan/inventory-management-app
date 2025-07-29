import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String organizationId;
  final String name;
  final String? description;
  final String? parentId;
  final String? color;
  final String? icon;
  final int sortOrder;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Category({
    required this.id,
    required this.organizationId,
    required this.name,
    this.description,
    this.parentId,
    this.color,
    this.icon,
    this.sortOrder = 0,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isRootCategory => parentId == null;

  Category copyWith({
    String? id,
    String? organizationId,
    String? name,
    String? description,
    String? parentId,
    String? color,
    String? icon,
    int? sortOrder,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Category(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      name: name ?? this.name,
      description: description ?? this.description,
      parentId: parentId ?? this.parentId,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organization_id': organizationId,
      'name': name,
      'description': description,
      'parent_id': parentId,
      'color': color,
      'icon': icon,
      'sort_order': sortOrder,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      organizationId: json['organization_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      parentId: json['parent_id'] as String?,
      color: json['color'] as String?,
      icon: json['icon'] as String?,
      sortOrder: json['sort_order'] as int? ?? 0,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  @override
  List<Object?> get props => [
        id,
        organizationId,
        name,
        description,
        parentId,
        color,
        icon,
        sortOrder,
        isActive,
        createdAt,
        updatedAt,
      ];
}