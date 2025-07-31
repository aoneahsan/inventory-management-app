import 'package:freezed_annotation/freezed_annotation.dart';

part 'permission.freezed.dart';
part 'permission.g.dart';

enum PermissionCategory {
  @JsonValue('system')
  system,
  @JsonValue('organization')
  organization,
  @JsonValue('inventory')
  inventory,
  @JsonValue('sales')
  sales,
  @JsonValue('purchase')
  purchase,
  @JsonValue('users')
  users,
  @JsonValue('reports')
  reports,
  @JsonValue('settings')
  settings,
  @JsonValue('pos')
  pos,
  @JsonValue('finance')
  finance,
}

@freezed
class Permission with _$Permission {
  const factory Permission({
    required String id,
    required String name,
    required String description,
    required PermissionCategory category,
    @Default(false) bool isSystemPermission,
    @Default([]) List<String> dependencies,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
    
    // Additional fields
    String? module,
    @Default(true) bool isActive,
    @Default({}) Map<String, dynamic> metadata,
    @Default(0) int priority,
    String? groupName,
  }) = _Permission;
  
  const Permission._();
  
  factory Permission.fromJson(Map<String, dynamic> json) => 
      _$PermissionFromJson(json);
  
  // Helper methods
  String get categoryDisplayName {
    switch (category) {
      case PermissionCategory.system:
        return 'System';
      case PermissionCategory.organization:
        return 'Organization';
      case PermissionCategory.inventory:
        return 'Inventory';
      case PermissionCategory.sales:
        return 'Sales';
      case PermissionCategory.purchase:
        return 'Purchase';
      case PermissionCategory.users:
        return 'Users';
      case PermissionCategory.reports:
        return 'Reports';
      case PermissionCategory.settings:
        return 'Settings';
      case PermissionCategory.pos:
        return 'Point of Sale';
      case PermissionCategory.finance:
        return 'Finance';
    }
  }
  
  bool hasDependency(String permissionId) {
    return dependencies.contains(permissionId);
  }
}

@freezed
class RolePermission with _$RolePermission {
  const factory RolePermission({
    required String roleId,
    required String permissionId,
    @Default(true) bool granted,
    required DateTime createdAt,
    required DateTime updatedAt,
    
    // Additional fields
    String? grantedBy,
    DateTime? expiresAt,
    @Default({}) Map<String, dynamic> conditions,
  }) = _RolePermission;
  
  const RolePermission._();
  
  factory RolePermission.fromJson(Map<String, dynamic> json) => 
      _$RolePermissionFromJson(json);
  
  bool get isExpired => expiresAt != null && expiresAt!.isBefore(DateTime.now());
  bool get isActive => granted && !isExpired;
}

// Predefined permissions
class AppPermissions {
  // System permissions
  static const String systemAdmin = 'system_admin';
  static const String manageUsers = 'manage_users';
  static const String manageOrganizations = 'manage_organizations';
  static const String viewSystemLogs = 'view_system_logs';
  static const String manageDatabase = 'manage_database';
  
  // Organization permissions
  static const String manageOrganization = 'manage_organization';
  static const String manageMembers = 'manage_members';
  static const String manageRoles = 'manage_roles';
  static const String manageSubscription = 'manage_subscription';
  static const String viewOrganizationStats = 'view_organization_stats';
  static const String manageBranches = 'manage_branches';
  
  // Inventory permissions
  static const String manageProducts = 'manage_products';
  static const String viewProducts = 'view_products';
  static const String manageCategories = 'manage_categories';
  static const String viewCategories = 'view_categories';
  static const String manageStock = 'manage_stock';
  static const String viewStock = 'view_stock';
  static const String adjustStock = 'adjust_stock';
  static const String viewInventoryMovements = 'view_inventory_movements';
  static const String manageBatches = 'manage_batches';
  static const String manageSerialNumbers = 'manage_serial_numbers';
  static const String manageCompositeItems = 'manage_composite_items';
  static const String manageRepackaging = 'manage_repackaging';
  
  // Sales permissions
  static const String createSales = 'create_sales';
  static const String viewSales = 'view_sales';
  static const String editSales = 'edit_sales';
  static const String deleteSales = 'delete_sales';
  static const String processRefunds = 'process_refunds';
  static const String applyDiscounts = 'apply_discounts';
  static const String overridePrice = 'override_price';
  static const String manageCustomers = 'manage_customers';
  static const String viewCustomers = 'view_customers';
  
  // Purchase permissions
  static const String createPurchaseOrders = 'create_purchase_orders';
  static const String viewPurchaseOrders = 'view_purchase_orders';
  static const String approvePurchaseOrders = 'approve_purchase_orders';
  static const String receivePurchaseOrders = 'receive_purchase_orders';
  static const String manageSuppliers = 'manage_suppliers';
  static const String viewSuppliers = 'view_suppliers';
  
  // POS permissions
  static const String accessPos = 'access_pos';
  static const String openRegister = 'open_register';
  static const String closeRegister = 'close_register';
  static const String voidTransactions = 'void_transactions';
  static const String reprintReceipts = 'reprint_receipts';
  static const String modifyCart = 'modify_cart';
  
  // Finance permissions
  static const String viewFinancialReports = 'view_financial_reports';
  static const String manageTaxRates = 'manage_tax_rates';
  static const String viewProfitMargins = 'view_profit_margins';
  static const String exportFinancialData = 'export_financial_data';
  
  // User permissions
  static const String manageUserRoles = 'manage_user_roles';
  static const String viewUsers = 'view_users';
  static const String inviteUsers = 'invite_users';
  static const String removeUsers = 'remove_users';
  static const String resetPasswords = 'reset_passwords';
  
  // Reports permissions
  static const String viewReports = 'view_reports';
  static const String generateReports = 'generate_reports';
  static const String exportReports = 'export_reports';
  static const String viewAnalytics = 'view_analytics';
  static const String scheduleReports = 'schedule_reports';
  
  // Settings permissions
  static const String manageSettings = 'manage_settings';
  static const String viewSettings = 'view_settings';
  static const String manageIntegrations = 'manage_integrations';
  static const String managePosSettings = 'manage_pos_settings';
  static const String manageNotifications = 'manage_notifications';
  
  static List<Permission> getDefaultPermissions() {
    final now = DateTime.now();
    final permissions = <Permission>[];
    
    // System permissions
    permissions.addAll([
      Permission(
        id: systemAdmin,
        name: 'System Administrator',
        description: 'Full system access and control',
        category: PermissionCategory.system,
        isSystemPermission: true,
        priority: 1000,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: manageUsers,
        name: 'Manage Users',
        description: 'Create, edit, and delete users',
        category: PermissionCategory.system,
        isSystemPermission: true,
        priority: 900,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: manageOrganizations,
        name: 'Manage Organizations',
        description: 'Create, edit, and delete organizations',
        category: PermissionCategory.system,
        isSystemPermission: true,
        priority: 890,
        createdAt: now,
        updatedAt: now,
      ),
    ]);
    
    // Organization permissions
    permissions.addAll([
      Permission(
        id: manageOrganization,
        name: 'Manage Organization',
        description: 'Edit organization settings and configuration',
        category: PermissionCategory.organization,
        priority: 800,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: manageMembers,
        name: 'Manage Members',
        description: 'Invite, edit, and remove organization members',
        category: PermissionCategory.organization,
        priority: 790,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: manageBranches,
        name: 'Manage Branches',
        description: 'Create and manage branch locations',
        category: PermissionCategory.organization,
        priority: 780,
        createdAt: now,
        updatedAt: now,
      ),
    ]);
    
    // Inventory permissions
    permissions.addAll([
      Permission(
        id: manageProducts,
        name: 'Manage Products',
        description: 'Create, edit, and delete products',
        category: PermissionCategory.inventory,
        dependencies: [viewProducts],
        priority: 700,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: viewProducts,
        name: 'View Products',
        description: 'View product information and details',
        category: PermissionCategory.inventory,
        priority: 690,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: manageStock,
        name: 'Manage Stock',
        description: 'Add and remove stock quantities',
        category: PermissionCategory.inventory,
        dependencies: [viewStock],
        priority: 680,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: adjustStock,
        name: 'Adjust Stock',
        description: 'Make manual stock adjustments',
        category: PermissionCategory.inventory,
        dependencies: [manageStock],
        priority: 670,
        createdAt: now,
        updatedAt: now,
      ),
    ]);
    
    // Sales permissions
    permissions.addAll([
      Permission(
        id: createSales,
        name: 'Create Sales',
        description: 'Process new sales transactions',
        category: PermissionCategory.sales,
        priority: 600,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: processRefunds,
        name: 'Process Refunds',
        description: 'Handle returns and refunds',
        category: PermissionCategory.sales,
        dependencies: [viewSales],
        priority: 590,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: applyDiscounts,
        name: 'Apply Discounts',
        description: 'Apply discounts to sales',
        category: PermissionCategory.sales,
        priority: 580,
        createdAt: now,
        updatedAt: now,
      ),
    ]);
    
    // POS permissions
    permissions.addAll([
      Permission(
        id: accessPos,
        name: 'Access POS',
        description: 'Access the point of sale system',
        category: PermissionCategory.pos,
        priority: 500,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: openRegister,
        name: 'Open Register',
        description: 'Open cash registers',
        category: PermissionCategory.pos,
        dependencies: [accessPos],
        priority: 490,
        createdAt: now,
        updatedAt: now,
      ),
      Permission(
        id: closeRegister,
        name: 'Close Register',
        description: 'Close and reconcile cash registers',
        category: PermissionCategory.pos,
        dependencies: [accessPos],
        priority: 480,
        createdAt: now,
        updatedAt: now,
      ),
    ]);
    
    return permissions;
  }
  
  static Map<String, List<String>> getRolePermissionTemplates() {
    return {
      'admin': [
        manageOrganization,
        manageMembers,
        manageRoles,
        manageBranches,
        manageProducts,
        manageCategories,
        manageStock,
        manageCustomers,
        manageSuppliers,
        viewReports,
        generateReports,
        manageSettings,
      ],
      'manager': [
        viewOrganizationStats,
        manageProducts,
        manageStock,
        createSales,
        processRefunds,
        manageCustomers,
        viewReports,
        generateReports,
      ],
      'cashier': [
        accessPos,
        createSales,
        viewProducts,
        viewCustomers,
        openRegister,
        closeRegister,
      ],
      'inventory_clerk': [
        viewProducts,
        manageStock,
        adjustStock,
        viewInventoryMovements,
        receivePurchaseOrders,
      ],
      'viewer': [
        viewProducts,
        viewCategories,
        viewStock,
        viewCustomers,
        viewSuppliers,
        viewReports,
      ],
    };
  }
}