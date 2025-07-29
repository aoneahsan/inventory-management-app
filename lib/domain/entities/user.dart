import 'package:equatable/equatable.dart';

enum UserRole {
  systemAdmin,
  organizationOwner,
  admin,
  manager,
  staff,
  viewer,
}

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final UserRole role;
  final String? organizationId;
  final List<String> permissions;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.organizationId,
    this.permissions = const [],
    this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isSystemAdmin => role == UserRole.systemAdmin;
  bool get isOrganizationOwner => role == UserRole.organizationOwner;
  bool get hasOrganization => organizationId != null;

  bool hasPermission(String permission) {
    if (isSystemAdmin) return true;
    if (isOrganizationOwner && organizationId != null) return true;
    return permissions.contains(permission);
  }

  User copyWith({
    String? id,
    String? email,
    String? name,
    UserRole? role,
    String? organizationId,
    List<String>? permissions,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      role: role ?? this.role,
      organizationId: organizationId ?? this.organizationId,
      permissions: permissions ?? this.permissions,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role.name,
      'organization_id': organizationId,
      'permissions': permissions,
      'photo_url': photoUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      role: UserRole.values.firstWhere(
        (r) => r.name == json['role'],
        orElse: () => UserRole.viewer,
      ),
      organizationId: json['organization_id'] as String?,
      permissions: (json['permissions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      photoUrl: json['photo_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        role,
        organizationId,
        permissions,
        photoUrl,
        createdAt,
        updatedAt,
      ];
}