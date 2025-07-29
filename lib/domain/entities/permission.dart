import 'package:equatable/equatable.dart';

enum PermissionCategory {
  system,
  organization,
  inventory,
  users,
  reports,
  settings,
}

class Permission extends Equatable {
  final String id;
  final String name;
  final String description;
  final PermissionCategory category;
  final bool isSystemPermission;
  final List<String> dependencies;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Permission({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    this.isSystemPermission = false,
    this.dependencies = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        category,
        isSystemPermission,
        dependencies,
        createdAt,
        updatedAt,
      ];

  Permission copyWith({
    String? id,
    String? name,
    String? description,
    PermissionCategory? category,
    bool? isSystemPermission,
    List<String>? dependencies,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Permission(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      isSystemPermission: isSystemPermission ?? this.isSystemPermission,
      dependencies: dependencies ?? this.dependencies,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category.name,
      'is_system_permission': isSystemPermission,
      'dependencies': dependencies,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      category: PermissionCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => PermissionCategory.system,
      ),
      isSystemPermission: json['is_system_permission'] == true || json['is_system_permission'] == 1,
      dependencies: List<String>.from(json['dependencies'] ?? []),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}

class RolePermission extends Equatable {
  final String roleId;
  final String permissionId;
  final bool granted;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RolePermission({
    required this.roleId,
    required this.permissionId,
    required this.granted,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        roleId,
        permissionId,
        granted,
        createdAt,
        updatedAt,
      ];

  Map<String, dynamic> toJson() {
    return {
      'role_id': roleId,
      'permission_id': permissionId,
      'granted': granted,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory RolePermission.fromJson(Map<String, dynamic> json) {
    return RolePermission(
      roleId: json['role_id'] as String,
      permissionId: json['permission_id'] as String,
      granted: json['granted'] == true || json['granted'] == 1,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}

// Predefined permissions
class AppPermissions {
  // System permissions
  static const String systemAdmin = 'system_admin';
  static const String manageUsers = 'manage_users';
  static const String manageOrganizations = 'manage_organizations';
  static const String viewSystemLogs = 'view_system_logs';
  
  // Organization permissions
  static const String manageOrganization = 'manage_organization';
  static const String manageMembers = 'manage_members';
  static const String manageRoles = 'manage_roles';
  static const String manageSubscription = 'manage_subscription';
  static const String viewOrganizationStats = 'view_organization_stats';
  
  // Inventory permissions
  static const String manageProducts = 'manage_products';
  static const String viewProducts = 'view_products';
  static const String manageCategories = 'manage_categories';
  static const String viewCategories = 'view_categories';
  static const String manageStock = 'manage_stock';
  static const String viewStock = 'view_stock';
  static const String adjustStock = 'adjust_stock';
  static const String viewInventoryMovements = 'view_inventory_movements';
  
  // User permissions
  static const String manageUserRoles = 'manage_user_roles';
  static const String viewUsers = 'view_users';
  static const String inviteUsers = 'invite_users';
  static const String removeUsers = 'remove_users';
  
  // Reports permissions
  static const String viewReports = 'view_reports';
  static const String generateReports = 'generate_reports';
  static const String exportReports = 'export_reports';
  static const String viewAnalytics = 'view_analytics';
  
  // Settings permissions
  static const String manageSettings = 'manage_settings';
  static const String viewSettings = 'view_settings';
  static const String manageIntegrations = 'manage_integrations';
  
  static List<Permission> getDefaultPermissions() {
    final now = DateTime.now();
    
    return [
      // System permissions
      Permission(
        id: systemAdmin,
        name: 'System Administrator',
        description: 'Full system access and control',
        category: PermissionCategory.system,
        isSystemPermission: true,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: manageUsers,
        name: 'Manage Users',
        description: 'Create, edit, and delete users',
        category: PermissionCategory.system,
        isSystemPermission: true,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: manageOrganizations,
        name: 'Manage Organizations',
        description: 'Create, edit, and delete organizations',
        category: PermissionCategory.system,
        isSystemPermission: true,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: viewSystemLogs,
        name: 'View System Logs',
        description: 'Access system logs and audit trails',
        category: PermissionCategory.system,
        isSystemPermission: true,
        createdAt: now,
        updatedAt: now,
      ),
      
      // Organization permissions
      Permission(
        id: manageOrganization,
        name: 'Manage Organization',
        description: 'Edit organization settings and configuration',
        category: PermissionCategory.organization,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: manageMembers,
        name: 'Manage Members',
        description: 'Invite, edit, and remove organization members',
        category: PermissionCategory.organization,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: manageRoles,
        name: 'Manage Roles',
        description: 'Create and edit custom roles and permissions',
        category: PermissionCategory.organization,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: manageSubscription,
        name: 'Manage Subscription',
        description: 'Manage billing and subscription settings',
        category: PermissionCategory.organization,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: viewOrganizationStats,
        name: 'View Organization Stats',
        description: 'Access organization statistics and metrics',
        category: PermissionCategory.organization,
        createdAt: now,
        updatedAt: now,
      ),
      
      // Inventory permissions
      Permission(
        id: manageProducts,
        name: 'Manage Products',
        description: 'Create, edit, and delete products',
        category: PermissionCategory.inventory,
        dependencies: [viewProducts],
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: viewProducts,
        name: 'View Products',
        description: 'View product information and details',
        category: PermissionCategory.inventory,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: manageCategories,
        name: 'Manage Categories',
        description: 'Create, edit, and delete product categories',
        category: PermissionCategory.inventory,
        dependencies: [viewCategories],
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: viewCategories,
        name: 'View Categories',
        description: 'View product categories',
        category: PermissionCategory.inventory,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: manageStock,
        name: 'Manage Stock',
        description: 'Add and remove stock quantities',
        category: PermissionCategory.inventory,
        dependencies: [viewStock],
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: viewStock,
        name: 'View Stock',
        description: 'View current stock levels',
        category: PermissionCategory.inventory,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: adjustStock,
        name: 'Adjust Stock',
        description: 'Make manual stock adjustments',
        category: PermissionCategory.inventory,
        dependencies: [manageStock],
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: viewInventoryMovements,
        name: 'View Inventory Movements',
        description: 'View inventory movement history',
        category: PermissionCategory.inventory,
        createdAt: now,
        updatedAt: now,
      ),
      
      // User permissions
      Permission(
        id: manageUserRoles,
        name: 'Manage User Roles',
        description: 'Assign and modify user roles',
        category: PermissionCategory.users,
        dependencies: [viewUsers],
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: viewUsers,
        name: 'View Users',
        description: 'View user information',
        category: PermissionCategory.users,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: inviteUsers,
        name: 'Invite Users',
        description: 'Send invitations to new users',
        category: PermissionCategory.users,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: removeUsers,
        name: 'Remove Users',
        description: 'Remove users from the organization',
        category: PermissionCategory.users,
        dependencies: [manageUserRoles],
        createdAt: now,
        updatedAt: now,
      ),
      
      // Reports permissions
      Permission(
        id: viewReports,
        name: 'View Reports',
        description: 'Access and view reports',
        category: PermissionCategory.reports,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: generateReports,
        name: 'Generate Reports',
        description: 'Create and generate custom reports',
        category: PermissionCategory.reports,
        dependencies: [viewReports],
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: exportReports,
        name: 'Export Reports',
        description: 'Export reports in various formats',
        category: PermissionCategory.reports,
        dependencies: [viewReports],
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: viewAnalytics,
        name: 'View Analytics',
        description: 'Access analytics dashboard',
        category: PermissionCategory.reports,
        createdAt: now,
        updatedAt: now,
      ),
      
      // Settings permissions
      Permission(
        id: manageSettings,
        name: 'Manage Settings',
        description: 'Modify application settings',
        category: PermissionCategory.settings,
        dependencies: [viewSettings],
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: viewSettings,
        name: 'View Settings',
        description: 'View application settings',
        category: PermissionCategory.settings,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: manageIntegrations,
        name: 'Manage Integrations',
        description: 'Configure third-party integrations',
        category: PermissionCategory.settings,
        dependencies: [manageSettings],
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }
}