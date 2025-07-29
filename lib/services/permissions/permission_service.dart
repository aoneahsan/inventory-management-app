import '../../domain/entities/permission.dart';
import '../../domain/entities/role.dart';
import '../../core/errors/exceptions.dart';
import '../database/database.dart';

class PermissionService {
  final AppDatabase _database;

  PermissionService({AppDatabase? database})
      : _database = database ?? AppDatabase.instance;

  // Initialize default permissions and roles
  Future<void> initializeDefaultPermissions() async {
    try {
      // Check if permissions are already initialized
      final existingPermissions = await _database.getPermissions();
      if (existingPermissions.isNotEmpty) {
        return; // Already initialized
      }

      // Insert default permissions
      final defaultPermissions = AppPermissions.getDefaultPermissions();
      for (final permission in defaultPermissions) {
        await _database.createPermission(permission.toJson());
      }

      // Insert default roles
      final defaultRoles = SystemRoles.getDefaultRoles();
      for (final role in defaultRoles) {
        await _database.createRole(role.toJson());
      }
    } catch (e) {
      throw BusinessException(message: 'Failed to initialize permissions: $e');
    }
  }

  // Permission management
  Future<List<Permission>> getAllPermissions() async {
    try {
      final permissions = await _database.getPermissions();
      return permissions.map((p) => Permission.fromJson(p)).toList();
    } catch (e) {
      throw BusinessException(message: 'Failed to load permissions: $e');
    }
  }

  Future<List<Permission>> getPermissionsByCategory(PermissionCategory category) async {
    try {
      final allPermissions = await getAllPermissions();
      return allPermissions.where((p) => p.category == category).toList();
    } catch (e) {
      throw BusinessException(message: 'Failed to load permissions by category: $e');
    }
  }

  Future<Permission> createCustomPermission({
    required String organizationId,
    required String name,
    required String description,
    required PermissionCategory category,
    List<String> dependencies = const [],
  }) async {
    try {
      // Check for duplicate name
      final existing = await getAllPermissions();
      if (existing.any((p) => p.name.toLowerCase() == name.toLowerCase())) {
        throw BusinessException(message: 'Permission with name "$name" already exists');
      }

      final now = DateTime.now();
      final permission = Permission(
        id: '${organizationId}_${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        description: description,
        category: category,
        dependencies: dependencies,
        createdAt: now,
        updatedAt: now,
      );

      await _database.createPermission(permission.toJson());
      return permission;
    } catch (e) {
      if (e is BusinessException) rethrow;
      throw BusinessException(message: 'Failed to create permission: $e');
    }
  }

  // Role management
  Future<List<Role>> getAllRoles() async {
    try {
      final roles = await _database.getRoles();
      return roles.map((r) => Role.fromJson(r)).toList();
    } catch (e) {
      throw BusinessException(message: 'Failed to load roles: $e');
    }
  }

  Future<List<Role>> getSystemRoles() async {
    try {
      final allRoles = await getAllRoles();
      return allRoles.where((r) => r.isSystemRole).toList();
    } catch (e) {
      throw BusinessException(message: 'Failed to load system roles: $e');
    }
  }

  Future<List<Role>> getOrganizationRoles(String organizationId) async {
    try {
      final allRoles = await getAllRoles();
      return allRoles.where((r) => 
        !r.isSystemRole && r.organizationId == organizationId
      ).toList();
    } catch (e) {
      throw BusinessException(message: 'Failed to load organization roles: $e');
    }
  }

  Future<Role?> getRoleById(String roleId) async {
    try {
      final role = await _database.getRoleById(roleId);
      return role != null ? Role.fromJson(role) : null;
    } catch (e) {
      throw BusinessException(message: 'Failed to load role: $e');
    }
  }

  Future<Role> createCustomRole({
    required String organizationId,
    required String name,
    required String description,
    required List<String> permissions,
  }) async {
    try {
      // Check for duplicate name within organization
      final existingRoles = await getOrganizationRoles(organizationId);
      if (existingRoles.any((r) => r.name.toLowerCase() == name.toLowerCase())) {
        throw BusinessException(message: 'Role with name "$name" already exists in this organization');
      }

      // Validate permissions exist
      final allPermissions = await getAllPermissions();
      final permissionIds = allPermissions.map((p) => p.id).toSet();
      for (final permission in permissions) {
        if (!permissionIds.contains(permission)) {
          throw BusinessException(message: 'Permission "$permission" does not exist');
        }
      }

      final now = DateTime.now();
      final role = Role(
        id: '${organizationId}_${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        description: description,
        organizationId: organizationId,
        isCustomRole: true,
        permissions: permissions,
        createdAt: now,
        updatedAt: now,
      );

      await _database.createRole(role.toJson());
      return role;
    } catch (e) {
      if (e is BusinessException) rethrow;
      throw BusinessException(message: 'Failed to create role: $e');
    }
  }

  Future<Role> createRoleFromTemplate({
    required String organizationId,
    required RoleTemplate template,
  }) async {
    return createCustomRole(
      organizationId: organizationId,
      name: template.name,
      description: template.description,
      permissions: template.permissions,
    );
  }

  Future<void> updateRole(String roleId, Map<String, dynamic> updates) async {
    try {
      final role = await getRoleById(roleId);
      if (role == null) {
        throw BusinessException(message: 'Role not found');
      }

      if (role.isSystemRole && updates.containsKey('permissions')) {
        throw BusinessException(message: 'Cannot modify permissions of system roles');
      }

      // Validate permissions if being updated
      if (updates.containsKey('permissions')) {
        final allPermissions = await getAllPermissions();
        final permissionIds = allPermissions.map((p) => p.id).toSet();
        final newPermissions = List<String>.from(updates['permissions']);
        
        for (final permission in newPermissions) {
          if (!permissionIds.contains(permission)) {
            throw BusinessException(message: 'Permission "$permission" does not exist');
          }
        }
      }

      updates['updated_at'] = DateTime.now().toIso8601String();
      await _database.updateRole(roleId, updates);
    } catch (e) {
      if (e is BusinessException) rethrow;
      throw BusinessException(message: 'Failed to update role: $e');
    }
  }

  Future<void> deleteRole(String roleId) async {
    try {
      final role = await getRoleById(roleId);
      if (role == null) {
        throw BusinessException(message: 'Role not found');
      }

      if (role.isSystemRole) {
        throw BusinessException(message: 'Cannot delete system roles');
      }

      // Check if role is assigned to any users
      final usersWithRole = await _database.getUsersWithRole(roleId);
      if (usersWithRole.isNotEmpty) {
        throw BusinessException(message: 'Cannot delete role that is assigned to users');
      }

      await _database.deleteRole(roleId);
    } catch (e) {
      if (e is BusinessException) rethrow;
      throw BusinessException(message: 'Failed to delete role: $e');
    }
  }

  // User permission checking
  Future<bool> userHasPermission(String userId, String permission) async {
    try {
      final user = await _database.getUserById(userId);
      if (user == null) return false;

      final userRole = user['role'] as String?;
      if (userRole == null) return false;

      final role = await getRoleById(userRole);
      if (role == null) return false;

      // System admin has all permissions
      if (role.permissions.contains('system_admin')) return true;

      // Check if role has the specific permission
      return role.permissions.contains(permission);
    } catch (e) {
      return false;
    }
  }

  Future<List<String>> getUserPermissions(String userId) async {
    try {
      final user = await _database.getUserById(userId);
      if (user == null) return [];

      final userRole = user['role'] as String?;
      if (userRole == null) return [];

      final role = await getRoleById(userRole);
      if (role == null) return [];

      return role.permissions;
    } catch (e) {
      return [];
    }
  }

  // Role assignment
  Future<void> assignRoleToUser(String userId, String roleId) async {
    try {
      final role = await getRoleById(roleId);
      if (role == null) {
        throw BusinessException(message: 'Role not found');
      }

      await _database.updateUser(userId, {
        'role': roleId,
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      if (e is BusinessException) rethrow;
      throw BusinessException(message: 'Failed to assign role to user: $e');
    }
  }

  // Bulk operations
  Future<void> bulkAssignRole(List<String> userIds, String roleId) async {
    try {
      final role = await getRoleById(roleId);
      if (role == null) {
        throw BusinessException(message: 'Role not found');
      }

      for (final userId in userIds) {
        await assignRoleToUser(userId, roleId);
      }
    } catch (e) {
      if (e is BusinessException) rethrow;
      throw BusinessException(message: 'Failed to bulk assign roles: $e');
    }
  }

  // Permission validation
  Future<List<String>> validatePermissionDependencies(List<String> permissions) async {
    try {
      final allPermissions = await getAllPermissions();
      final permissionMap = {for (var p in allPermissions) p.id: p};
      final errors = <String>[];

      for (final permissionId in permissions) {
        final permission = permissionMap[permissionId];
        if (permission == null) {
          errors.add('Permission "$permissionId" does not exist');
          continue;
        }

        // Check dependencies
        for (final dependency in permission.dependencies) {
          if (!permissions.contains(dependency)) {
            errors.add('Permission "${permission.name}" requires "${permissionMap[dependency]?.name ?? dependency}"');
          }
        }
      }

      return errors;
    } catch (e) {
      throw BusinessException(message: 'Failed to validate permission dependencies: $e');
    }
  }

  // Analytics
  Future<Map<String, dynamic>> getPermissionAnalytics(String organizationId) async {
    try {
      final users = await _database.getUsers(organizationId);
      final roles = await getOrganizationRoles(organizationId);
      final systemRoles = await getSystemRoles();
      
      final roleUsage = <String, int>{};
      final permissionUsage = <String, int>{};

      for (final user in users) {
        final roleId = user['role'] as String?;
        if (roleId != null) {
          roleUsage[roleId] = (roleUsage[roleId] ?? 0) + 1;
          
          final role = [...roles, ...systemRoles].firstWhere(
            (r) => r.id == roleId,
            orElse: () => Role(
              id: '',
              name: '',
              description: '',
              permissions: [],
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );
          
          for (final permission in role.permissions) {
            permissionUsage[permission] = (permissionUsage[permission] ?? 0) + 1;
          }
        }
      }

      return {
        'total_users': users.length,
        'total_roles': roles.length + systemRoles.length,
        'custom_roles': roles.length,
        'role_usage': roleUsage,
        'permission_usage': permissionUsage,
      };
    } catch (e) {
      throw BusinessException(message: 'Failed to get permission analytics: $e');
    }
  }
}