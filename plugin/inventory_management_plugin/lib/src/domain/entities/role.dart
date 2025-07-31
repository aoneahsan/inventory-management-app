import 'package:freezed_annotation/freezed_annotation.dart';

part 'role.freezed.dart';
part 'role.g.dart';

@freezed
class Role with _$Role {
  const factory Role({
    required String id,
    required String name,
    required String description,
    String? organizationId,
    @Default(false) bool isSystemRole,
    @Default(false) bool isCustomRole,
    @Default([]) List<String> permissions,
    @Default(0) int sortOrder,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
    
    // Additional fields
    String? color,
    String? icon,
    @Default({}) Map<String, dynamic> metadata,
    @Default(false) bool isDefault,
    int? maxUsers,
    @Default([]) List<String> inheritedRoles,
    String? createdBy,
    String? parentRoleId,
  }) = _Role;
  
  const Role._();
  
  factory Role.fromJson(Map<String, dynamic> json) => 
      _$RoleFromJson(json);
  
  // Helper methods
  bool get isOrganizationRole => organizationId != null;
  bool get canEdit => !isSystemRole && isCustomRole;
  bool get canDelete => !isSystemRole && !isDefault && isCustomRole;
  
  bool hasPermission(String permission) {
    return permissions.contains(permission);
  }
  
  bool hasAnyPermission(List<String> checkPermissions) {
    return checkPermissions.any((p) => permissions.contains(p));
  }
  
  bool hasAllPermissions(List<String> checkPermissions) {
    return checkPermissions.every((p) => permissions.contains(p));
  }
  
  int get effectivePermissionCount {
    final Set<String> allPermissions = {...permissions};
    // TODO: Add inherited permissions from inheritedRoles
    return allPermissions.length;
  }
}

// Predefined system roles
class SystemRoles {
  static const String systemAdmin = 'system_admin';
  static const String organizationOwner = 'organization_owner';
  static const String admin = 'admin';
  static const String manager = 'manager';
  static const String supervisor = 'supervisor';
  static const String cashier = 'cashier';
  static const String inventoryClerk = 'inventory_clerk';
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
        permissions: ['system_admin'],
        sortOrder: 0,
        color: '#FF0000',
        icon: 'admin_panel_settings',
        createdAt: now,
        updatedAt: now,
      ),
      
      // Organization Owner - Full organization access
      Role(
        id: organizationOwner,
        name: 'Organization Owner',
        description: 'Full access to organization and all features',
        isSystemRole: true,
        isDefault: true,
        permissions: [
          'manage_organization',
          'manage_members',
          'manage_roles',
          'manage_subscription',
          'view_organization_stats',
          'manage_branches',
          'manage_products',
          'manage_categories',
          'manage_stock',
          'manage_customers',
          'manage_suppliers',
          'create_purchase_orders',
          'approve_purchase_orders',
          'access_pos',
          'view_financial_reports',
          'manage_tax_rates',
          'view_reports',
          'generate_reports',
          'export_reports',
          'manage_settings',
          'manage_integrations',
        ],
        sortOrder: 1,
        color: '#9C27B0',
        icon: 'business',
        createdAt: now,
        updatedAt: now,
      ),
      
      // Admin - Administrative access
      Role(
        id: admin,
        name: 'Administrator',
        description: 'Administrative access to most features',
        isSystemRole: true,
        permissions: [
          'manage_members',
          'manage_branches',
          'manage_products',
          'manage_categories',
          'manage_stock',
          'manage_customers',
          'manage_suppliers',
          'create_purchase_orders',
          'access_pos',
          'view_reports',
          'generate_reports',
          'manage_settings',
        ],
        sortOrder: 2,
        color: '#3F51B5',
        icon: 'admin_panel_settings',
        createdAt: now,
        updatedAt: now,
      ),
      
      // Manager - Store/Branch management
      Role(
        id: manager,
        name: 'Manager',
        description: 'Store and inventory management',
        isSystemRole: true,
        permissions: [
          'view_organization_stats',
          'manage_products',
          'manage_stock',
          'manage_customers',
          'create_sales',
          'process_refunds',
          'create_purchase_orders',
          'access_pos',
          'open_register',
          'close_register',
          'view_reports',
          'generate_reports',
        ],
        sortOrder: 3,
        color: '#2196F3',
        icon: 'supervisor_account',
        createdAt: now,
        updatedAt: now,
      ),
      
      // Supervisor - Team supervision
      Role(
        id: supervisor,
        name: 'Supervisor',
        description: 'Team supervision and oversight',
        isSystemRole: true,
        permissions: [
          'view_products',
          'manage_stock',
          'view_customers',
          'create_sales',
          'access_pos',
          'void_transactions',
          'view_reports',
        ],
        sortOrder: 4,
        color: '#00BCD4',
        icon: 'people',
        createdAt: now,
        updatedAt: now,
      ),
      
      // Cashier - POS operations
      Role(
        id: cashier,
        name: 'Cashier',
        description: 'Point of sale operations',
        isSystemRole: true,
        permissions: [
          'access_pos',
          'create_sales',
          'view_products',
          'view_customers',
          'open_register',
          'reprint_receipts',
        ],
        sortOrder: 5,
        color: '#4CAF50',
        icon: 'point_of_sale',
        createdAt: now,
        updatedAt: now,
      ),
      
      // Inventory Clerk - Stock management
      Role(
        id: inventoryClerk,
        name: 'Inventory Clerk',
        description: 'Stock and inventory management',
        isSystemRole: true,
        permissions: [
          'view_products',
          'manage_stock',
          'adjust_stock',
          'view_inventory_movements',
          'receive_purchase_orders',
          'view_suppliers',
        ],
        sortOrder: 6,
        color: '#FF9800',
        icon: 'inventory',
        createdAt: now,
        updatedAt: now,
      ),
      
      // Staff - Basic operations
      Role(
        id: staff,
        name: 'Staff',
        description: 'Basic operations and viewing',
        isSystemRole: true,
        permissions: [
          'view_products',
          'view_categories',
          'view_stock',
          'view_customers',
        ],
        sortOrder: 7,
        color: '#607D8B',
        icon: 'person',
        createdAt: now,
        updatedAt: now,
      ),
      
      // Viewer - Read-only access
      Role(
        id: viewer,
        name: 'Viewer',
        description: 'Read-only access',
        isSystemRole: true,
        permissions: [
          'view_products',
          'view_categories',
          'view_stock',
          'view_reports',
        ],
        sortOrder: 8,
        color: '#9E9E9E',
        icon: 'visibility',
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }
}

@freezed
class RoleTemplate with _$RoleTemplate {
  const factory RoleTemplate({
    required String name,
    required String description,
    required List<String> permissions,
    String? color,
    String? icon,
    @Default({}) Map<String, dynamic> metadata,
  }) = _RoleTemplate;
  
  const RoleTemplate._();
  
  factory RoleTemplate.fromJson(Map<String, dynamic> json) => 
      _$RoleTemplateFromJson(json);
  
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
      color: color,
      icon: icon,
      metadata: metadata,
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
        'manage_categories',
        'manage_stock',
        'adjust_stock',
        'view_inventory_movements',
        'manage_batches',
        'manage_serial_numbers',
        'view_reports',
        'generate_reports',
      ],
      color: '#FF5722',
      icon: 'inventory_2',
    ),
    RoleTemplate(
      name: 'Sales Representative',
      description: 'Sales focused role with customer management',
      permissions: [
        'view_products',
        'create_sales',
        'view_customers',
        'manage_customers',
        'apply_discounts',
        'access_pos',
        'view_reports',
      ],
      color: '#8BC34A',
      icon: 'shopping_cart',
    ),
    RoleTemplate(
      name: 'Warehouse Manager',
      description: 'Complete warehouse and stock control',
      permissions: [
        'manage_products',
        'manage_stock',
        'adjust_stock',
        'view_inventory_movements',
        'create_purchase_orders',
        'receive_purchase_orders',
        'manage_suppliers',
        'manage_batches',
        'manage_serial_numbers',
        'view_reports',
        'generate_reports',
      ],
      color: '#795548',
      icon: 'warehouse',
    ),
    RoleTemplate(
      name: 'Accountant',
      description: 'Financial reports and analytics access',
      permissions: [
        'view_products',
        'view_stock',
        'view_inventory_movements',
        'view_financial_reports',
        'view_profit_margins',
        'export_financial_data',
        'view_reports',
        'generate_reports',
        'export_reports',
        'view_analytics',
      ],
      color: '#3F51B5',
      icon: 'calculate',
    ),
    RoleTemplate(
      name: 'Purchasing Agent',
      description: 'Manage suppliers and purchase orders',
      permissions: [
        'view_products',
        'create_purchase_orders',
        'view_purchase_orders',
        'manage_suppliers',
        'view_suppliers',
        'view_inventory_movements',
        'view_reports',
      ],
      color: '#009688',
      icon: 'shopping_basket',
    ),
  ];
}