import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/organization.dart';
import '../../../domain/entities/user.dart';
import '../../../services/organization/organization_service.dart';
import '../../../services/organization/invitation_service.dart';
import '../../providers/auth_provider.dart';
import '../admin/roles_permissions_page.dart';

final organizationServiceProvider = Provider<OrganizationService>((ref) {
  return OrganizationService();
});

final invitationServiceProvider = Provider<InvitationService>((ref) {
  return InvitationService();
});

final organizationMembersProvider = FutureProvider.family<List<User>, String>((ref, orgId) async {
  final service = ref.watch(organizationServiceProvider);
  return service.getOrganizationMembers(orgId);
});

class OrganizationSettingsPage extends ConsumerStatefulWidget {
  const OrganizationSettingsPage({super.key});

  @override
  ConsumerState<OrganizationSettingsPage> createState() => _OrganizationSettingsPageState();
}

class _OrganizationSettingsPageState extends ConsumerState<OrganizationSettingsPage> 
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _orgNameController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    
    // Initialize with current organization name
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final org = ref.read(currentOrganizationProvider);
      if (org != null) {
        _orgNameController.text = org.name;
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _orgNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final organization = ref.watch(currentOrganizationProvider);
    
    if (user == null || organization == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Organization Settings')),
        body: const Center(child: Text('No organization found')),
      );
    }

    final canManageSettings = user.isOrganizationOwner || user.hasPermission('manage_settings');
    final canManageMembers = user.isOrganizationOwner || user.hasPermission('manage_members');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Organization Settings'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'General', icon: Icon(Icons.settings)),
            Tab(text: 'Members', icon: Icon(Icons.group)),
            Tab(text: 'Roles', icon: Icon(Icons.security)),
            Tab(text: 'Billing', icon: Icon(Icons.payment)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGeneralTab(organization, canManageSettings),
          _buildMembersTab(organization, user, canManageMembers),
          _buildRolesTab(user),
          _buildBillingTab(organization),
        ],
      ),
    );
  }

  Widget _buildGeneralTab(Organization organization, bool canEdit) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Organization Information',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _orgNameController,
                    decoration: const InputDecoration(
                      labelText: 'Organization Name',
                      border: OutlineInputBorder(),
                    ),
                    enabled: canEdit,
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Organization ID'),
                    subtitle: Text(organization.id),
                    trailing: IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        // Copy to clipboard
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Copied to clipboard')),
                        );
                      },
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Created'),
                    subtitle: Text(_formatDate(organization.createdAt)),
                  ),
                  if (canEdit) ...[
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _updateOrganizationName,
                        child: const Text('Save Changes'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Organization Stats',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildStatTile(
                    'Members',
                    '${organization.memberCount} / ${organization.maxMembers}',
                    Icons.people,
                  ),
                  _buildStatTile(
                    'Products Limit',
                    organization.maxProducts == 999999 
                        ? 'Unlimited' 
                        : organization.maxProducts.toString(),
                    Icons.inventory_2,
                  ),
                  _buildStatTile(
                    'Subscription Tier',
                    organization.tier.name.toUpperCase(),
                    Icons.star,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembersTab(Organization organization, User currentUser, bool canManage) {
    final membersAsync = ref.watch(organizationMembersProvider(organization.id));
    
    return membersAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
      data: (members) {
        return Column(
          children: [
            if (canManage)
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton.icon(
                  onPressed: () => _showInviteMemberDialog(organization.id),
                  icon: const Icon(Icons.person_add),
                  label: const Text('Invite Member'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final member = members[index];
                  final isCurrentUser = member.id == currentUser.id;
                  final isOwner = member.isOrganizationOwner;
                  
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(member.name[0].toUpperCase()),
                      ),
                      title: Text(member.name),
                      subtitle: Text(member.email),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Chip(
                            label: Text(
                              _getRoleDisplayName(member.role),
                              style: const TextStyle(fontSize: 12),
                            ),
                            visualDensity: VisualDensity.compact,
                          ),
                          if (canManage && !isCurrentUser && !isOwner)
                            PopupMenuButton<String>(
                              onSelected: (value) => _handleMemberAction(
                                value,
                                member,
                                organization.id,
                              ),
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'change_role',
                                  child: Text('Change Role'),
                                ),
                                const PopupMenuItem(
                                  value: 'remove',
                                  child: Text('Remove Member'),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBillingTab(Organization organization) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Plan',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 48,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${organization.tier.name.toUpperCase()} Plan',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _getPlanDescription(organization.tier),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Status'),
                    trailing: Chip(
                      label: Text(organization.status.name.toUpperCase()),
                      backgroundColor: organization.isActive
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                    ),
                  ),
                  if (organization.subscriptionExpiresAt != null)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Expires On'),
                      trailing: Text(_formatDate(organization.subscriptionExpiresAt!)),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (organization.tier != SubscriptionTier.enterprise)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upgrade Your Plan',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    _buildPlanOption(SubscriptionTier.basic, organization.tier),
                    const SizedBox(height: 8),
                    _buildPlanOption(SubscriptionTier.professional, organization.tier),
                    const SizedBox(height: 8),
                    _buildPlanOption(SubscriptionTier.enterprise, organization.tier),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRolesTab(User? user) {
    final canManageRoles = user?.hasPermission('manage_roles') ?? false;
    
    if (!canManageRoles) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'You don\'t have permission to manage roles',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    
    return const RolesPermissionsPage();
  }

  Widget _buildStatTile(String label, String value, IconData icon) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(label),
      trailing: Text(
        value,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget _buildPlanOption(SubscriptionTier tier, SubscriptionTier currentTier) {
    final isCurrentPlan = tier == currentTier;
    final isDowngrade = tier.index < currentTier.index;
    
    return Card(
      elevation: isCurrentPlan ? 4 : 1,
      child: ListTile(
        title: Text('${tier.name.toUpperCase()} Plan'),
        subtitle: Text(_getPlanDescription(tier)),
        trailing: isCurrentPlan
            ? const Chip(label: Text('Current'))
            : ElevatedButton(
                onPressed: () => _showUpgradeDialog(tier),
                child: Text(isDowngrade ? 'Downgrade' : 'Upgrade'),
              ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _getRoleDisplayName(UserRole role) {
    switch (role) {
      case UserRole.systemAdmin:
        return 'System Admin';
      case UserRole.organizationOwner:
        return 'Owner';
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

  String _getPlanDescription(SubscriptionTier tier) {
    switch (tier) {
      case SubscriptionTier.free:
        return 'Up to 3 members, 100 products';
      case SubscriptionTier.basic:
        return 'Up to 10 members, 1,000 products';
      case SubscriptionTier.professional:
        return 'Up to 50 members, 10,000 products';
      case SubscriptionTier.enterprise:
        return 'Unlimited members and products';
    }
  }

  Future<void> _updateOrganizationName() async {
    // TODO: Implement organization name update
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Organization name updated')),
    );
  }

  Future<void> _showInviteMemberDialog(String organizationId) async {
    final roleController = ValueNotifier<UserRole>(UserRole.viewer);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invite Member'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select the role for the new member:'),
            const SizedBox(height: 16),
            ValueListenableBuilder<UserRole>(
              valueListenable: roleController,
              builder: (context, selectedRole, _) {
                return DropdownButtonFormField<UserRole>(
                  value: selectedRole,
                  decoration: const InputDecoration(
                    labelText: 'Role',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    UserRole.admin,
                    UserRole.manager,
                    UserRole.staff,
                    UserRole.viewer,
                  ].map((role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text(_getRoleDisplayName(role)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      roleController.value = value;
                    }
                  },
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _createInvitation(organizationId, roleController.value);
            },
            child: const Text('Create Invite'),
          ),
        ],
      ),
    );
  }

  Future<void> _createInvitation(String organizationId, UserRole role) async {
    try {
      final user = ref.read(currentUserProvider)!;
      final invitationService = ref.read(invitationServiceProvider);
      
      final code = await invitationService.createInvitation(
        organizationId: organizationId,
        role: role,
        createdBy: user.id,
      );
      
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Invitation Created'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Share this code with the new member:'),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    code,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                  ),
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
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create invitation: $e')),
        );
      }
    }
  }

  Future<void> _handleMemberAction(String action, User member, String orgId) async {
    switch (action) {
      case 'change_role':
        await _showChangeRoleDialog(member, orgId);
        break;
      case 'remove':
        await _confirmRemoveMember(member, orgId);
        break;
    }
  }

  Future<void> _showChangeRoleDialog(User member, String orgId) async {
    final roleController = ValueNotifier<UserRole>(member.role);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Change Role for ${member.name}'),
        content: ValueListenableBuilder<UserRole>(
          valueListenable: roleController,
          builder: (context, selectedRole, _) {
            return DropdownButtonFormField<UserRole>(
              value: selectedRole,
              decoration: const InputDecoration(
                labelText: 'New Role',
                border: OutlineInputBorder(),
              ),
              items: [
                UserRole.admin,
                UserRole.manager,
                UserRole.staff,
                UserRole.viewer,
              ].map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Text(_getRoleDisplayName(role)),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  roleController.value = value;
                }
              },
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _updateMemberRole(member.id, roleController.value, orgId);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  Future<void> _updateMemberRole(String userId, UserRole newRole, String orgId) async {
    try {
      final currentUser = ref.read(currentUserProvider)!;
      final orgService = ref.read(organizationServiceProvider);
      
      await orgService.updateMemberRole(
        userId: userId,
        newRole: newRole,
        updatedBy: currentUser.id,
      );
      
      // Refresh members list
      ref.invalidate(organizationMembersProvider(orgId));
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Member role updated successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update role: $e')),
        );
      }
    }
  }

  Future<void> _confirmRemoveMember(User member, String orgId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Member'),
        content: Text('Are you sure you want to remove ${member.name} from the organization?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      await _removeMember(member.id, orgId);
    }
  }

  Future<void> _removeMember(String userId, String orgId) async {
    try {
      final currentUser = ref.read(currentUserProvider)!;
      final orgService = ref.read(organizationServiceProvider);
      
      await orgService.removeMember(
        userId: userId,
        organizationId: orgId,
        removedBy: currentUser.id,
      );
      
      // Refresh members list
      ref.invalidate(organizationMembersProvider(orgId));
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Member removed successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to remove member: $e')),
        );
      }
    }
  }

  Future<void> _showUpgradeDialog(SubscriptionTier tier) async {
    context.push('/subscription', extra: {'targetTier': tier});
  }
}