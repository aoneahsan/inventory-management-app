import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/entities/organization.dart';
import '../../../services/auth/auth_service.dart';
import '../../../services/organization/organization_service.dart';
import '../../providers/auth_provider.dart';

final allOrganizationsProvider = FutureProvider<List<Organization>>((ref) async {
  final orgService = OrganizationService();
  return orgService.getAllOrganizations();
});

final allUsersProvider = FutureProvider<List<User>>((ref) async {
  final authService = AuthService();
  return authService.getAllUsers();
});

final systemStatsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final orgService = OrganizationService();
  return orgService.getSystemStats();
});

class SystemAdminPanel extends ConsumerStatefulWidget {
  const SystemAdminPanel({super.key});

  @override
  ConsumerState<SystemAdminPanel> createState() => _SystemAdminPanelState();
}

class _SystemAdminPanelState extends ConsumerState<SystemAdminPanel>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final isSystemAdmin = user?.hasPermission('system_admin') ?? false;

    if (!isSystemAdmin) {
      return Scaffold(
        appBar: AppBar(title: const Text('Access Denied')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.admin_panel_settings, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text(
                'System Administrator Access Required',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'You don\'t have permission to access the system admin panel',
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
        title: const Text('System Administration'),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Dashboard', icon: Icon(Icons.dashboard)),
            Tab(text: 'Organizations', icon: Icon(Icons.business)),
            Tab(text: 'Users', icon: Icon(Icons.people)),
            Tab(text: 'System', icon: Icon(Icons.settings)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboardTab(),
          _buildOrganizationsTab(),
          _buildUsersTab(),
          _buildSystemTab(),
        ],
      ),
    );
  }

  Widget _buildDashboardTab() {
    return Consumer(
      builder: (context, ref, child) {
        final statsAsync = ref.watch(systemStatsProvider);

        return statsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
          data: (stats) {
            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(systemStatsProvider);
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    'System Overview',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Overview Cards
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.5,
                    children: [
                      _buildStatCard(
                        'Total Organizations',
                        '${stats['total_organizations'] ?? 0}',
                        Icons.business,
                        Colors.blue,
                      ),
                      _buildStatCard(
                        'Total Users',
                        '${stats['total_users'] ?? 0}',
                        Icons.people,
                        Colors.green,
                      ),
                      _buildStatCard(
                        'Active Organizations',
                        '${stats['active_organizations'] ?? 0}',
                        Icons.check_circle,
                        Colors.orange,
                      ),
                      _buildStatCard(
                        'Total Products',
                        '${stats['total_products'] ?? 0}',
                        Icons.inventory,
                        Colors.purple,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Recent Activities
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recent System Activities',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 16),
                          ...((stats['recent_activities'] as List?)?.map((activity) =>
                              _buildActivityTile(activity)) ?? []),
                          if ((stats['recent_activities'] as List?)?.isEmpty == true)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(32),
                                child: Text('No recent activities'),
                              ),
                            ),
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

  Widget _buildOrganizationsTab() {
    return Consumer(
      builder: (context, ref, child) {
        final organizationsAsync = ref.watch(allOrganizationsProvider);

        return organizationsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
          data: (organizations) {
            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(allOrganizationsProvider);
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Organizations (${organizations.length})',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _showCreateOrganizationDialog(),
                        icon: const Icon(Icons.add),
                        label: const Text('Create Organization'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...organizations.map((org) => _buildOrganizationCard(org)),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildUsersTab() {
    return Consumer(
      builder: (context, ref, child) {
        final usersAsync = ref.watch(allUsersProvider);

        return usersAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
          data: (users) {
            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(allUsersProvider);
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'System Users (${users.length})',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _showCreateUserDialog(),
                        icon: const Icon(Icons.person_add),
                        label: const Text('Create User'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...users.map((user) => _buildUserCard(user)),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSystemTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'System Configuration',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        
        // System Settings Card
        Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.storage),
                title: const Text('Database Management'),
                subtitle: const Text('Backup, restore, and maintenance'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _showDatabaseManagementDialog(),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.security),
                title: const Text('Security Settings'),
                subtitle: const Text('Manage system security configuration'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _showSecuritySettingsDialog(),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.update),
                title: const Text('System Updates'),
                subtitle: const Text('Check for and install updates'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _showSystemUpdatesDialog(),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.bug_report),
                title: const Text('System Logs'),
                subtitle: const Text('View system logs and error reports'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => _showSystemLogsDialog(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        
        // Maintenance Actions
        Card(
          child: Column(
            children: [
              const ListTile(
                title: Text(
                  'Maintenance Actions',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(height: 1),
              ListTile(
                leading: Icon(Icons.cleaning_services, color: Colors.orange[700]),
                title: const Text('Clear System Cache'),
                subtitle: const Text('Clear all cached data'),
                trailing: ElevatedButton(
                  onPressed: () => _clearSystemCache(),
                  child: const Text('Clear'),
                ),
              ),
              const Divider(height: 1),
              ListTile(
                leading: Icon(Icons.refresh, color: Colors.blue[700]),
                title: const Text('Rebuild Indexes'),
                subtitle: const Text('Rebuild database indexes'),
                trailing: ElevatedButton(
                  onPressed: () => _rebuildIndexes(),
                  child: const Text('Rebuild'),
                ),
              ),
              const Divider(height: 1),
              ListTile(
                leading: Icon(Icons.warning, color: Colors.red[700]),
                title: const Text('Reset System'),
                subtitle: const Text('Reset all system data (DANGER)'),
                trailing: ElevatedButton(
                  onPressed: () => _showResetSystemDialog(),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Reset'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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

  Widget _buildActivityTile(Map<String, dynamic> activity) {
    return ListTile(
      leading: Icon(
        _getActivityIcon(activity['type']),
        color: _getActivityColor(activity['type']),
      ),
      title: Text(activity['description'] ?? 'Unknown activity'),
      subtitle: Text(activity['timestamp'] ?? ''),
      trailing: Chip(
        label: Text(activity['type'] ?? 'Unknown'),
        backgroundColor: _getActivityColor(activity['type']).withValues(alpha: 0.1),
      ),
    );
  }

  Widget _buildOrganizationCard(Organization org) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: org.isActive ? Colors.green[100] : Colors.red[100],
          child: Icon(
            Icons.business,
            color: org.isActive ? Colors.green[700] : Colors.red[700],
          ),
        ),
        title: Text(org.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${org.memberCount} members'),
            Text('Plan: ${org.tier.name}'),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (action) => _handleOrganizationAction(action, org),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'view',
              child: ListTile(
                leading: Icon(Icons.visibility, size: 16),
                title: Text('View Details'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuItem(
              value: 'edit',
              child: ListTile(
                leading: Icon(Icons.edit, size: 16),
                title: Text('Edit'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            if (org.isActive)
              const PopupMenuItem(
                value: 'suspend',
                child: ListTile(
                  leading: Icon(Icons.pause, size: 16),
                  title: Text('Suspend'),
                  contentPadding: EdgeInsets.zero,
                ),
              )
            else
              const PopupMenuItem(
                value: 'activate',
                child: ListTile(
                  leading: Icon(Icons.play_arrow, size: 16),
                  title: Text('Activate'),
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
        ),
      ),
    );
  }

  Widget _buildUserCard(User user) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
          child: user.photoUrl == null ? Text(user.name[0].toUpperCase()) : null,
        ),
        title: Text(user.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.email),
            Text('Role: ${_getRoleDisplayName(user.role)}'),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (action) => _handleUserAction(action, user),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'view',
              child: ListTile(
                leading: Icon(Icons.visibility, size: 16),
                title: Text('View Profile'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuItem(
              value: 'edit',
              child: ListTile(
                leading: Icon(Icons.edit, size: 16),
                title: Text('Edit'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuItem(
              value: 'reset_password',
              child: ListTile(
                leading: Icon(Icons.lock_reset, size: 16),
                title: Text('Reset Password'),
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
        ),
      ),
    );
  }

  IconData _getActivityIcon(String? type) {
    switch (type) {
      case 'organization_created':
        return Icons.business;
      case 'user_created':
        return Icons.person_add;
      case 'user_deleted':
        return Icons.person_remove;
      case 'system_update':
        return Icons.update;
      default:
        return Icons.info;
    }
  }

  Color _getActivityColor(String? type) {
    switch (type) {
      case 'organization_created':
        return Colors.green;
      case 'user_created':
        return Colors.blue;
      case 'user_deleted':
        return Colors.red;
      case 'system_update':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getRoleDisplayName(UserRole role) {
    switch (role) {
      case UserRole.systemAdmin:
        return 'System Admin';
      case UserRole.organizationOwner:
        return 'Organization Owner';
      case UserRole.admin:
        return 'Admin';
      case UserRole.manager:
        return 'Manager';
      case UserRole.staff:
        return 'Staff';
      case UserRole.viewer:
        return 'Viewer';
    }
  }

  void _handleOrganizationAction(String action, Organization org) {
    switch (action) {
      case 'view':
        _showOrganizationDetailsDialog(org);
        break;
      case 'edit':
        _showEditOrganizationDialog(org);
        break;
      case 'suspend':
      case 'activate':
        _toggleOrganizationStatus(org);
        break;
      case 'delete':
        _showDeleteOrganizationDialog(org);
        break;
    }
  }

  void _handleUserAction(String action, User user) {
    switch (action) {
      case 'view':
        _showUserDetailsDialog(user);
        break;
      case 'edit':
        _showEditUserDialog(user);
        break;
      case 'reset_password':
        _showResetPasswordDialog(user);
        break;
      case 'delete':
        _showDeleteUserDialog(user);
        break;
    }
  }

  // Dialog methods
  void _showCreateOrganizationDialog() {
    showDialog(
      context: context,
      builder: (context) => _CreateOrganizationDialog(
        onCreated: () {
          ref.invalidate(allOrganizationsProvider);
          ref.invalidate(systemStatsProvider);
        },
      ),
    );
  }

  void _showCreateUserDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Create User feature coming soon')),
    );
  }

  void _showOrganizationDetailsDialog(Organization org) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Viewing details for ${org.name}')),
    );
  }

  void _showEditOrganizationDialog(Organization org) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Editing ${org.name}')),
    );
  }

  void _toggleOrganizationStatus(Organization org) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${org.isActive ? 'Suspending' : 'Activating'} ${org.name}')),
    );
  }

  void _showDeleteOrganizationDialog(Organization org) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Organization'),
        content: Text('Are you sure you want to delete "${org.name}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Deleting ${org.name}')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showUserDetailsDialog(User user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Viewing details for ${user.name}')),
    );
  }

  void _showEditUserDialog(User user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Editing ${user.name}')),
    );
  }

  void _showResetPasswordDialog(User user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Resetting password for ${user.name}')),
    );
  }

  void _showDeleteUserDialog(User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: Text('Are you sure you want to delete "${user.name}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Deleting ${user.name}')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showDatabaseManagementDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Database Management'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.backup, color: Colors.blue),
              title: Text('Backup Database'),
              subtitle: Text('Create a backup of all data'),
            ),
            ListTile(
              leading: Icon(Icons.restore, color: Colors.green),
              title: Text('Restore Database'),
              subtitle: Text('Restore from a previous backup'),
            ),
            ListTile(
              leading: Icon(Icons.cleaning_services, color: Colors.orange),
              title: Text('Database Maintenance'),
              subtitle: Text('Optimize database performance'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showSecuritySettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Security Settings'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              value: true,
              onChanged: null,
              title: Text('Two-Factor Authentication'),
              subtitle: Text('Require 2FA for all users'),
            ),
            SwitchListTile(
              value: false,
              onChanged: null,
              title: Text('IP Whitelisting'),
              subtitle: Text('Restrict access to specific IPs'),
            ),
            ListTile(
              title: Text('Password Policy'),
              subtitle: Text('Minimum 8 characters, complexity required'),
              trailing: Icon(Icons.edit),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showSystemUpdatesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('System Updates'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Version: 1.0.0',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('Latest Version: 1.0.0'),
                    SizedBox(height: 8),
                    Text(
                      'System is up to date',
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Checking for updates...')),
                );
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Check for Updates'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showSystemLogsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('System Logs'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: Column(
            children: [
              // Filter chips
              Wrap(
                spacing: 8,
                children: [
                  FilterChip(
                    label: const Text('All'),
                    selected: true,
                    onSelected: (_) {},
                  ),
                  FilterChip(
                    label: const Text('Errors'),
                    selected: false,
                    onSelected: (_) {},
                  ),
                  FilterChip(
                    label: const Text('Warnings'),
                    selected: false,
                    onSelected: (_) {},
                  ),
                  FilterChip(
                    label: const Text('Info'),
                    selected: false,
                    onSelected: (_) {},
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Sample logs
              Expanded(
                child: ListView(
                  children: [
                    _buildLogEntry('INFO', 'System started successfully', DateTime.now()),
                    _buildLogEntry('INFO', 'User login: admin@example.com', DateTime.now().subtract(const Duration(minutes: 5))),
                    _buildLogEntry('WARNING', 'High memory usage detected', DateTime.now().subtract(const Duration(minutes: 10))),
                    _buildLogEntry('ERROR', 'Failed to send email notification', DateTime.now().subtract(const Duration(minutes: 15))),
                    _buildLogEntry('INFO', 'Database backup completed', DateTime.now().subtract(const Duration(hours: 1))),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Export Logs'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildLogEntry(String level, String message, DateTime timestamp) {
    Color levelColor;
    IconData levelIcon;
    
    switch (level) {
      case 'ERROR':
        levelColor = Colors.red;
        levelIcon = Icons.error;
        break;
      case 'WARNING':
        levelColor = Colors.orange;
        levelIcon = Icons.warning;
        break;
      default:
        levelColor = Colors.blue;
        levelIcon = Icons.info;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(levelIcon, color: levelColor, size: 20),
        title: Text(message),
        subtitle: Text(
          '${timestamp.toString().split('.')[0]} - $level',
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  void _clearSystemCache() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('System cache cleared')),
    );
  }

  void _rebuildIndexes() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Database indexes rebuilt')),
    );
  }

  void _showResetSystemDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset System'),
        content: const Text(
          'WARNING: This will delete ALL data in the system including all organizations, users, and products. This action cannot be undone.\n\nAre you absolutely sure?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('System reset cancelled - feature not implemented')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('RESET SYSTEM'),
          ),
        ],
      ),
    );
  }
}

// Dialog Widgets
class _CreateOrganizationDialog extends ConsumerStatefulWidget {
  final VoidCallback onCreated;

  const _CreateOrganizationDialog({required this.onCreated});

  @override
  ConsumerState<_CreateOrganizationDialog> createState() => _CreateOrganizationDialogState();
}

class _CreateOrganizationDialogState extends ConsumerState<_CreateOrganizationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedOwnerId;
  bool _isLoading = false;
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadUsers() async {
    try {
      final authService = AuthService();
      final users = await authService.getAllUsers();
      setState(() {
        _users = users;
      });
    } catch (e) {
      debugPrint('Error loading users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Organization'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Organization Name*',
                  hintText: 'Enter organization name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter organization name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter organization description (optional)',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedOwnerId,
                decoration: const InputDecoration(
                  labelText: 'Organization Owner*',
                  hintText: 'Select organization owner',
                ),
                items: _users.map((user) {
                  return DropdownMenuItem(
                    value: user.id,
                    child: Text('${user.name} (${user.email})'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedOwnerId = value);
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select an owner';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _isLoading ? null : _createOrganization,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Create'),
        ),
      ],
    );
  }

  Future<void> _createOrganization() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final orgService = OrganizationService();
      await orgService.createSystemOrganization(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        ownerId: _selectedOwnerId!,
      );

      if (mounted) {
        widget.onCreated();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Organization created successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating organization: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}

class _CreateUserDialog extends ConsumerStatefulWidget {
  final VoidCallback onCreated;

  const _CreateUserDialog({required this.onCreated});

  @override
  ConsumerState<_CreateUserDialog> createState() => _CreateUserDialogState();
}

class _CreateUserDialogState extends ConsumerState<_CreateUserDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  UserRole _selectedRole = UserRole.viewer;
  String? _selectedOrganizationId;
  bool _isLoading = false;
  List<Organization> _organizations = [];

  @override
  void initState() {
    super.initState();
    _loadOrganizations();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _loadOrganizations() async {
    try {
      final orgService = OrganizationService();
      final organizations = await orgService.getAllOrganizations();
      setState(() {
        _organizations = organizations;
      });
    } catch (e) {
      debugPrint('Error loading organizations: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create User'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name*',
                  hintText: 'Enter user\'s full name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter user\'s name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email*',
                  hintText: 'Enter user\'s email',
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<UserRole>(
                value: _selectedRole,
                decoration: const InputDecoration(
                  labelText: 'Role*',
                  hintText: 'Select user role',
                ),
                items: UserRole.values.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(_getRoleDisplayName(role)),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedRole = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedOrganizationId,
                decoration: const InputDecoration(
                  labelText: 'Organization',
                  hintText: 'Select organization (optional)',
                ),
                items: [
                  const DropdownMenuItem(
                    value: null,
                    child: Text('No Organization'),
                  ),
                  ..._organizations.map((org) {
                    return DropdownMenuItem(
                      value: org.id,
                      child: Text(org.name),
                    );
                  }),
                ],
                onChanged: (value) {
                  setState(() => _selectedOrganizationId = value);
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _isLoading ? null : _createUser,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Create'),
        ),
      ],
    );
  }

  Future<void> _createUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authService = AuthService();
      await authService.createSystemUser(
        email: _emailController.text.trim(),
        name: _nameController.text.trim(),
        role: _selectedRole,
        organizationId: _selectedOrganizationId,
      );

      if (mounted) {
        widget.onCreated();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User created successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating user: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String _getRoleDisplayName(UserRole role) {
    switch (role) {
      case UserRole.systemAdmin:
        return 'System Admin';
      case UserRole.organizationOwner:
        return 'Organization Owner';
      case UserRole.admin:
        return 'Admin';
      case UserRole.manager:
        return 'Manager';
      case UserRole.staff:
        return 'Staff';
      case UserRole.viewer:
        return 'Viewer';
    }
  }
}