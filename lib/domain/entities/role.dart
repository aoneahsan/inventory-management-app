import 'package:equatable/equatable.dart';

class Role extends Equatable {
  final String id;
  final String name;
  final String description;
  final String? organizationId; // null for system roles
  final bool isSystemRole;
  final bool isCustomRole;
  final List<String> permissions;
  final int sortOrder;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Role({
    required this.id,
    required this.name,
    required this.description,
    this.organizationId,
    this.isSystemRole = false,
    this.isCustomRole = false,
    this.permissions = const [],
    this.sortOrder = 0,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        organizationId,
        isSystemRole,
        isCustomRole,
        permissions,
        sortOrder,
        isActive,
        createdAt,
        updatedAt,
      ];

  bool get isOrganizationRole => organizationId != null;

  Role copyWith({
    String? id,
    String? name,
    String? description,
    String? organizationId,
    bool? isSystemRole,
    bool? isCustomRole,
    List<String>? permissions,
    int? sortOrder,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Role(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      organizationId: organizationId ?? this.organizationId,
      isSystemRole: isSystemRole ?? this.isSystemRole,
      isCustomRole: isCustomRole ?? this.isCustomRole,
      permissions: permissions ?? this.permissions,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'organization_id': organizationId,
      'is_system_role': isSystemRole,
      'is_custom_role': isCustomRole,
      'permissions': permissions,
      'sort_order': sortOrder,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      organizationId: json['organization_id'] as String?,
      isSystemRole: json['is_system_role'] == true || json['is_system_role'] == 1,
      isCustomRole: json['is_custom_role'] == true || json['is_custom_role'] == 1,
      permissions: List<String>.from(json['permissions'] ?? []),
      sortOrder: json['sort_order'] as int? ?? 0,
      isActive: json['is_active'] == true || json['is_active'] == 1,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}

// Predefined system roles
class SystemRoles {
  static const String systemAdmin = 'system_admin';
  static const String organizationOwner = 'organization_owner';
  static const String admin = 'admin';
  static const String manager = 'manager';
  static const String staff = 'staff';
  static const String viewer = 'viewer';

  static List<Role> getDefaultRoles() {
    final now = DateTime.now();
    
    return [
      // System Admin - Full system access
      Role(
        id: systemAdmin,
        name: 'System Administrator',
        description: 'Full system access with all permissions',
        isSystemRole: true,
        permissions: [
          'system_admin',
          'manage_users',
          'manage_organizations',
          'view_system_logs',
        ],
        sortOrder: 0,
        createdAt: now,
        updatedAt: now,
      ),
      
      // Organization Owner - Full organization access
      Role(
        id: organizationOwner,
        name: 'Organization Owner',
        description: 'Full access to organization and all features',
        isSystemRole: true,
        permissions: [
          'manage_organization',
          'manage_members',
          'manage_roles',
          'manage_subscription',
          'view_organization_stats',
          'manage_products',
          'view_products',
          'manage_categories',
          'view_categories',
          'manage_stock',
          'view_stock',
          'adjust_stock',
          'view_inventory_movements',
          'manage_user_roles',
          'view_users',
          'invite_users',
          'remove_users',
          'view_reports',
          'generate_reports',
          'export_reports',
          'view_analytics',
          'manage_settings',
          'view_settings',
          'manage_integrations',
        ],
        sortOrder: 1,
        createdAt: now,
        updatedAt: now,
      ),
      
      // Admin - Administrative access without billing
      Role(
        id: admin,
        name: 'Administrator',
        description: 'Administrative access to most features',
        isSystemRole: true,
        permissions: [
          'manage_members',
          'view_organization_stats',
          'manage_products',
          'view_products',
          'manage_categories',
          'view_categories',
          'manage_stock',
          'view_stock',
          'adjust_stock',
          'view_inventory_movements',
          'manage_user_roles',
          'view_users',
          'invite_users',
          'view_reports',
          'generate_reports',
          'export_reports',
          'view_analytics',
          'view_settings',
        ],
        sortOrder: 2,
        createdAt: now,
        updatedAt: now,
      ),
      
      // Manager - Inventory management and team oversight
      Role(
        id: manager,
        name: 'Manager',
        description: 'Inventory management and basic user oversight',
        isSystemRole: true,
        permissions: [
          'view_organization_stats',
          'manage_products',
          'view_products',
          'manage_categories',
          'view_categories',
          'manage_stock',
          'view_stock',
          'adjust_stock',
          'view_inventory_movements',
          'view_users',
          'view_reports',
          'generate_reports',
          'view_analytics',
          'view_settings',
        ],
        sortOrder: 3,
        createdAt: now,
        updatedAt: now,
      ),
      
      // Staff - Basic inventory operations
      Role(
        id: staff,
        name: 'Staff',
        description: 'Basic inventory operations and stock management',
        isSystemRole: true,
        permissions: [
          'view_products',
          'view_categories',
          'manage_stock',
          'view_stock',
          'view_inventory_movements',
          'view_reports',
        ],
        sortOrder: 4,
        createdAt: now,
        updatedAt: now,
      ),
      
      // Viewer - Read-only access
      Role(
        id: viewer,
        name: 'Viewer',
        description: 'Read-only access to inventory information',
        isSystemRole: true,
        permissions: [
          'view_products',
          'view_categories',
          'view_stock',
          'view_inventory_movements',
          'view_reports',
        ],
        sortOrder: 5,
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }
}

// Role templates for easy role creation
class RoleTemplate {
  final String name;
  final String description;
  final List<String> permissions;

  const RoleTemplate({
    required this.name,
    required this.description,
    required this.permissions,
  });

  Role toRole({
    required String id,
    required String organizationId,
  }) {
    final now = DateTime.now();
    return Role(
      id: id,
      name: name,
      description: description,
      organizationId: organizationId,
      isCustomRole: true,
      permissions: permissions,
      createdAt: now,
      updatedAt: now,
    );
  }
}

class RoleTemplates {
  static const List<RoleTemplate> templates = [
    RoleTemplate(
      name: 'Inventory Specialist',
      description: 'Full inventory management without user administration',
      permissions: [
        'manage_products',
        'view_products',
        'manage_categories',
        'view_categories',
        'manage_stock',
        'view_stock',
        'adjust_stock',
        'view_inventory_movements',
        'view_reports',
        'generate_reports',
      ],
    ),
    RoleTemplate(
      name: 'Sales Representative',
      description: 'Product viewing and basic stock operations',
      permissions: [
        'view_products',
        'view_categories',
        'view_stock',
        'view_inventory_movements',
        'view_reports',
      ],
    ),
    RoleTemplate(
      name: 'Warehouse Manager',
      description: 'Stock management and movement tracking',
      permissions: [
        'view_products',
        'view_categories',
        'manage_stock',
        'view_stock',
        'adjust_stock',
        'view_inventory_movements',
        'view_reports',
        'generate_reports',
      ],
    ),
    RoleTemplate(
      name: 'Accountant',
      description: 'Financial reports and analytics access',
      permissions: [
        'view_products',
        'view_stock',
        'view_inventory_movements',
        'view_reports',
        'generate_reports',
        'export_reports',
        'view_analytics',
      ],
    ),
  ];
}