import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/permission.dart';
import '../../../domain/entities/role.dart';
import '../../../services/permissions/permission_service.dart';
import '../../providers/auth_provider.dart';

final permissionServiceProvider = Provider<PermissionService>((ref) {
  return PermissionService();
});

final rolesProvider = FutureProvider<List<Role>>((ref) async {
  final permissionService = ref.watch(permissionServiceProvider);
  return permissionService.getAllRoles();
});

final permissionsProvider = FutureProvider<List<Permission>>((ref) async {
  final permissionService = ref.watch(permissionServiceProvider);
  return permissionService.getAllPermissions();
});

final permissionAnalyticsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final org = ref.watch(currentOrganizationProvider);
  if (org == null) throw Exception('No organization');
  
  final permissionService = ref.watch(permissionServiceProvider);
  return permissionService.getPermissionAnalytics(org.id);
});

class RolesPermissionsPage extends ConsumerStatefulWidget {
  const RolesPermissionsPage({super.key});

  @override
  ConsumerState<RolesPermissionsPage> createState() => _RolesPermissionsPageState();
}

class _RolesPermissionsPageState extends ConsumerState<RolesPermissionsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final canManageRoles = user?.hasPermission('manage_roles') ?? false;

    if (!canManageRoles) {
      return Scaffold(
        appBar: AppBar(title: const Text('Access Denied')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'You don\'t have permission to manage roles and permissions',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Roles & Permissions'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Roles', icon: Icon(Icons.people)),
            Tab(text: 'Permissions', icon: Icon(Icons.security)),
            Tab(text: 'Analytics', icon: Icon(Icons.analytics)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateRoleDialog(),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRolesTab(),
          _buildPermissionsTab(),
          _buildAnalyticsTab(),
        ],
      ),
    );
  }

  Widget _buildRolesTab() {
    return Consumer(
      builder: (context, ref, child) {
        final rolesAsync = ref.watch(rolesProvider);
        final organization = ref.watch(currentOrganizationProvider);

        return rolesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
          data: (roles) {
            final systemRoles = roles.where((r) => r.isSystemRole).toList();
            final customRoles = roles.where((r) => 
              !r.isSystemRole && r.organizationId == organization?.id
            ).toList();

            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(rolesProvider);
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // System Roles Section
                  _buildSectionHeader('System Roles', systemRoles.length),
                  const SizedBox(height: 8),
                  ...systemRoles.map((role) => _buildRoleCard(role, false)),
                  
                  const SizedBox(height: 24),
                  
                  // Custom Roles Section
                  _buildSectionHeader('Custom Roles', customRoles.length),
                  const SizedBox(height: 8),
                  if (customRoles.isEmpty)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: [
                            Icon(Icons.group_add, size: 48, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            const Text(
                              'No custom roles yet',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Create custom roles to fit your organization\'s needs',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: () => _showCreateRoleDialog(),
                              icon: const Icon(Icons.add),
                              label: const Text('Create Custom Role'),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ...customRoles.map((role) => _buildRoleCard(role, true)),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPermissionsTab() {
    return Consumer(
      builder: (context, ref, child) {
        final permissionsAsync = ref.watch(permissionsProvider);

        return permissionsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
          data: (permissions) {
            final groupedPermissions = <PermissionCategory, List<Permission>>{};
            
            for (final permission in permissions) {
              groupedPermissions.putIfAbsent(permission.category, () => []);
              groupedPermissions[permission.category]!.add(permission);
            }

            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(permissionsProvider);
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  for (final category in PermissionCategory.values)
                    if (groupedPermissions[category]?.isNotEmpty == true) ...[
                      _buildPermissionCategoryCard(
                        category,
                        groupedPermissions[category]!,
                      ),
                      const SizedBox(height: 16),
                    ],
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAnalyticsTab() {
    return Consumer(
      builder: (context, ref, child) {
        final analyticsAsync = ref.watch(permissionAnalyticsProvider);

        return analyticsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
          data: (analytics) {
            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(permissionAnalyticsProvider);
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Overview Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildAnalyticsCard(
                          'Total Users',
                          '${analytics['total_users']}',
                          Icons.people,
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildAnalyticsCard(
                          'Total Roles',
                          '${analytics['total_roles']}',
                          Icons.security,
                          Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildAnalyticsCard(
                          'Custom Roles',
                          '${analytics['custom_roles']}',
                          Icons.group_add,
                          Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildAnalyticsCard(
                          'Active Permissions',
                          '${(analytics['permission_usage'] as Map).length}',
                          Icons.verified_user,
                          Colors.purple,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Role Usage Chart
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Role Usage',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 16),
                          ...((analytics['role_usage'] as Map<String, dynamic>).entries.map((entry) =>
                              _buildUsageBar(entry.key, entry.value, analytics['total_users']),
                          )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSectionHeader(String title, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Chip(
          label: Text('$count'),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
      ],
    );
  }

  Widget _buildRoleCard(Role role, bool canEdit) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: role.isSystemRole 
              ? Colors.blue[100] 
              : Colors.green[100],
          child: Icon(
            role.isSystemRole ? Icons.shield : Icons.group,
            color: role.isSystemRole ? Colors.blue[700] : Colors.green[700],
          ),
        ),
        title: Text(
          role.name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(role.description),
        trailing: canEdit
            ? PopupMenuButton<String>(
                onSelected: (action) => _handleRoleAction(action, role),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: ListTile(
                      leading: Icon(Icons.edit, size: 16),
                      title: Text('Edit'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'duplicate',
                    child: ListTile(
                      leading: Icon(Icons.copy, size: 16),
                      title: Text('Duplicate'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: ListTile(
                      leading: Icon(Icons.delete, size: 16, color: Colors.red),
                      title: Text('Delete', style: TextStyle(color: Colors.red)),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              )
            : null,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Permissions (${role.permissions.length})',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: role.permissions.map((permission) => Chip(
                    label: Text(
                      permission.replaceAll('_', ' ').toUpperCase(),
                      style: const TextStyle(fontSize: 10),
                    ),
                    backgroundColor: Colors.blue[50],
                  )).toList(),
                ),
                if (role.isSystemRole) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'System Role - Cannot be modified',
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionCategoryCard(PermissionCategory category, List<Permission> permissions) {
    final categoryName = category.name.replaceAll('_', ' ').toUpperCase();
    final categoryColor = _getCategoryColor(category);

    return Card(
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: categoryColor.withValues(alpha: 0.1),
          child: Icon(_getCategoryIcon(category), color: categoryColor),
        ),
        title: Text(
          categoryName,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text('${permissions.length} permissions'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: permissions.map((permission) => _buildPermissionTile(permission)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionTile(Permission permission) {
    return ListTile(
      dense: true,
      leading: Icon(
        permission.isSystemPermission ? Icons.admin_panel_settings : Icons.security,
        size: 20,
        color: permission.isSystemPermission ? Colors.red : Colors.blue,
      ),
      title: Text(permission.name),
      subtitle: Text(permission.description),
      trailing: permission.isSystemPermission
          ? const Chip(
              label: Text('System', style: TextStyle(fontSize: 10)),
              backgroundColor: Colors.red,
              labelStyle: TextStyle(color: Colors.white),
            )
          : null,
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsageBar(String roleId, int count, int total) {
    final percentage = total > 0 ? (count / total) : 0.0;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              roleId.replaceAll('_', ' '),
              style: const TextStyle(fontSize: 12),
            ),
          ),
          Expanded(
            flex: 3,
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey[300],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$count',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(PermissionCategory category) {
    switch (category) {
      case PermissionCategory.system:
        return Colors.red;
      case PermissionCategory.organization:
        return Colors.blue;
      case PermissionCategory.inventory:
        return Colors.green;
      case PermissionCategory.users:
        return Colors.orange;
      case PermissionCategory.reports:
        return Colors.purple;
      case PermissionCategory.settings:
        return Colors.teal;
    }
  }

  IconData _getCategoryIcon(PermissionCategory category) {
    switch (category) {
      case PermissionCategory.system:
        return Icons.admin_panel_settings;
      case PermissionCategory.organization:
        return Icons.business;
      case PermissionCategory.inventory:
        return Icons.inventory;
      case PermissionCategory.users:
        return Icons.people;
      case PermissionCategory.reports:
        return Icons.assessment;
      case PermissionCategory.settings:
        return Icons.settings;
    }
  }

  void _handleRoleAction(String action, Role role) {
    switch (action) {
      case 'edit':
        _showEditRoleDialog(role);
        break;
      case 'duplicate':
        _showDuplicateRoleDialog(role);
        break;
      case 'delete':
        _showDeleteRoleDialog(role);
        break;
    }
  }

  Future<void> _showCreateRoleDialog() async {
    final organization = ref.read(currentOrganizationProvider);
    if (organization == null) return;

    await showDialog(
      context: context,
      builder: (context) => _RoleFormDialog(
        organizationId: organization.id,
        onRoleCreated: () {
          ref.invalidate(rolesProvider);
          ref.invalidate(permissionAnalyticsProvider);
        },
      ),
    );
  }

  Future<void> _showEditRoleDialog(Role role) async {
    await showDialog(
      context: context,
      builder: (context) => _RoleFormDialog(
        role: role,
        onRoleCreated: () {
          ref.invalidate(rolesProvider);
          ref.invalidate(permissionAnalyticsProvider);
        },
      ),
    );
  }

  Future<void> _showDuplicateRoleDialog(Role role) async {
    final organization = ref.read(currentOrganizationProvider);
    if (organization == null) return;

    await showDialog(
      context: context,
      builder: (context) => _RoleFormDialog(
        organizationId: organization.id,
        templateRole: role,
        onRoleCreated: () {
          ref.invalidate(rolesProvider);
          ref.invalidate(permissionAnalyticsProvider);
        },
      ),
    );
  }

  Future<void> _showDeleteRoleDialog(Role role) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Role'),
        content: Text('Are you sure you want to delete "${role.name}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final permissionService = ref.read(permissionServiceProvider);
        await permissionService.deleteRole(role.id);
        
        ref.invalidate(rolesProvider);
        ref.invalidate(permissionAnalyticsProvider);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Role deleted successfully')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error deleting role: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}

class _RoleFormDialog extends ConsumerStatefulWidget {
  final String? organizationId;
  final Role? role;
  final Role? templateRole;
  final VoidCallback onRoleCreated;

  const _RoleFormDialog({
    this.organizationId,
    this.role,
    this.templateRole,
    required this.onRoleCreated,
  });

  bool get isEditing => role != null;
  bool get isCreating => organizationId != null;

  @override
  ConsumerState<_RoleFormDialog> createState() => _RoleFormDialogState();
}

class _RoleFormDialogState extends ConsumerState<_RoleFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _selectedPermissions = <String>{};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    
    if (widget.isEditing) {
      _nameController.text = widget.role!.name;
      _descriptionController.text = widget.role!.description;
      _selectedPermissions.addAll(widget.role!.permissions);
    } else if (widget.templateRole != null) {
      _nameController.text = '${widget.templateRole!.name} (Copy)';
      _descriptionController.text = widget.templateRole!.description;
      _selectedPermissions.addAll(widget.templateRole!.permissions);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final permissionsAsync = ref.watch(permissionsProvider);

    return AlertDialog(
      title: Text(widget.isEditing ? 'Edit Role' : 'Create Role'),
      content: SizedBox(
        width: double.maxFinite,
        height: 500,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Role Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a role name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: permissionsAsync.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Text('Error: $error'),
                  data: (permissions) {
                    final nonSystemPermissions = permissions.where((p) => !p.isSystemPermission).toList();
                    
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Permissions',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView.builder(
                            itemCount: nonSystemPermissions.length,
                            itemBuilder: (context, index) {
                              final permission = nonSystemPermissions[index];
                              return CheckboxListTile(
                                dense: true,
                                title: Text(permission.name),
                                subtitle: Text(permission.description),
                                value: _selectedPermissions.contains(permission.id),
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      _selectedPermissions.add(permission.id);
                                    } else {
                                      _selectedPermissions.remove(permission.id);
                                    }
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _saveRole,
          child: _isLoading 
              ? const CircularProgressIndicator()
              : Text(widget.isEditing ? 'Update' : 'Create'),
        ),
      ],
    );
  }

  Future<void> _saveRole() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final permissionService = ref.read(permissionServiceProvider);

      if (widget.isEditing) {
        await permissionService.updateRole(widget.role!.id, {
          'name': _nameController.text.trim(),
          'description': _descriptionController.text.trim(),
          'permissions': _selectedPermissions.toList(),
        });
      } else {
        await permissionService.createCustomRole(
          organizationId: widget.organizationId!,
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          permissions: _selectedPermissions.toList(),
        );
      }

      widget.onRoleCreated();
      
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.isEditing ? 'Role updated successfully' : 'Role created successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}