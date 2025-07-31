import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String name,
    String? photoUrl,
    required UserRole role,
    String? organizationId,
    @Default(true) bool isActive,
    DateTime? lastLoginAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
    
    // Additional fields
    @Default([]) List<String> permissions,
    @Default({}) Map<String, dynamic> metadata,
    String? phoneNumber,
    String? address,
    UserPreferences? preferences,
  }) = _User;
  
  const User._();
  
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  
  // Helper methods
  bool hasPermission(String permission) {
    // Check role-based permissions
    final rolePermissions = role.permissions;
    if (rolePermissions.contains(permission) || rolePermissions.contains('*')) {
      return true;
    }
    
    // Check user-specific permissions
    return permissions.contains(permission) || permissions.contains('*');
  }
  
  bool get isAdmin => role == UserRole.admin || role == UserRole.owner;
  bool get canManageInventory => hasPermission('inventory.manage');
  bool get canManageSales => hasPermission('sales.manage');
  bool get canManageReports => hasPermission('reports.view');
  bool get canManageUsers => hasPermission('users.manage');
}

@freezed
class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    @Default('en') String language,
    @Default('USD') String currency,
    @Default('MM/DD/YYYY') String dateFormat,
    @Default('12h') String timeFormat,
    @Default(true) bool emailNotifications,
    @Default(true) bool pushNotifications,
    @Default(false) bool smsNotifications,
    @Default('system') String theme,
    @Default({}) Map<String, dynamic> customSettings,
  }) = _UserPreferences;
  
  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
}

enum UserRole {
  owner,
  admin,
  manager,
  cashier,
  viewer;
  
  List<String> get permissions {
    switch (this) {
      case UserRole.owner:
        return ['*']; // All permissions
      case UserRole.admin:
        return [
          'inventory.*',
          'sales.*',
          'purchases.*',
          'reports.*',
          'users.manage',
          'settings.*',
        ];
      case UserRole.manager:
        return [
          'inventory.manage',
          'sales.manage',
          'purchases.manage',
          'reports.view',
          'users.view',
        ];
      case UserRole.cashier:
        return [
          'inventory.view',
          'sales.create',
          'sales.view',
          'customers.manage',
        ];
      case UserRole.viewer:
        return [
          'inventory.view',
          'sales.view',
          'reports.view',
        ];
    }
  }
  
  String get displayName {
    switch (this) {
      case UserRole.owner:
        return 'Owner';
      case UserRole.admin:
        return 'Administrator';
      case UserRole.manager:
        return 'Manager';
      case UserRole.cashier:
        return 'Cashier';
      case UserRole.viewer:
        return 'Viewer';
    }
  }
}

extension UserRoleExtension on String {
  UserRole toUserRole() {
    return UserRole.values.firstWhere(
      (role) => role.name == this,
      orElse: () => UserRole.viewer,
    );
  }
}