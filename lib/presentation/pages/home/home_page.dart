import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../services/organization/organization_service.dart';
import '../../../domain/entities/user.dart';
import '../../providers/auth_provider.dart';
import '../../router/app_router.dart';
import '../inventory/products_page.dart';
import '../inventory/categories_page.dart';
import '../analytics/analytics_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;

  late final List<_NavigationItem> _navigationItems;

  @override
  void initState() {
    super.initState();
    _navigationItems = [
      _NavigationItem(
        icon: Icons.dashboard,
        label: 'Dashboard',
        body: const _DashboardView(),
      ),
      _NavigationItem(
        icon: Icons.inventory_2,
        label: 'Products',
        body: const ProductsPage(),
      ),
      _NavigationItem(
        icon: Icons.category,
        label: 'Categories',
        body: const CategoriesPage(),
      ),
      _NavigationItem(
        icon: Icons.analytics,
        label: 'Analytics',
        body: const AnalyticsPage(),
      ),
      _NavigationItem(
        icon: Icons.business,
        label: 'Suppliers',
        onTap: () => context.go(AppRouter.suppliers),
      ),
      _NavigationItem(
        icon: Icons.receipt_long,
        label: 'Purchase Orders',
        onTap: () => context.go(AppRouter.purchaseOrders),
      ),
      _NavigationItem(
        icon: Icons.store,
        label: 'Branches',
        onTap: () => context.go(AppRouter.branches),
      ),
      _NavigationItem(
        icon: Icons.swap_horiz,
        label: 'Transfers',
        onTap: () => context.go(AppRouter.transfers),
      ),
      _NavigationItem(
        icon: Icons.settings_applications,
        label: 'Advanced',
        onTap: () => context.go(AppRouter.advancedFeatures),
      ),
      _NavigationItem(
        icon: Icons.point_of_sale,
        label: 'POS',
        onTap: () => context.go(AppRouter.pos),
      ),
      _NavigationItem(
        icon: Icons.person,
        label: 'Profile',
        body: const _ProfileView(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final organization = ref.watch(currentOrganizationProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_navigationItems[_selectedIndex].label),
        actions: [
          if (organization != null)
            IconButton(
              icon: const Icon(Icons.business),
              tooltip: 'Organization Settings',
              onPressed: () {
                context.push('/organization/settings');
              },
            ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Implement notifications
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) async {
              switch (value) {
                case 'settings':
                  context.push('/settings');
                  break;
                case 'logout':
                  await ref.read(authNotifierProvider.notifier).signOut();
                  if (context.mounted) {
                    context.go(AppRouter.login);
                  }
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'settings',
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text('Logout', style: TextStyle(color: Colors.red)),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _navigationItems.map((item) => item.body ?? Container()).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          final item = _navigationItems[index];
          if (item.onTap != null) {
            item.onTap!();
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
        type: BottomNavigationBarType.fixed,
        items: _navigationItems
            .map((item) => BottomNavigationBarItem(
                  icon: Icon(item.icon),
                  label: item.label,
                ))
            .toList(),
      ),
    );
  }
}

class _NavigationItem {
  final IconData icon;
  final String label;
  final Widget? body;
  final VoidCallback? onTap;

  _NavigationItem({
    required this.icon,
    required this.label,
    this.body,
    this.onTap,
  }) : assert(body != null || onTap != null, 'Either body or onTap must be provided');
}

class _DashboardView extends ConsumerWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final organization = ref.watch(currentOrganizationProvider);

    if (organization == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.business_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('No organization found'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => context.go('/organization/setup'),
              child: const Text('Set up Organization'),
            ),
          ],
        ),
      );
    }

    return FutureBuilder<Map<String, dynamic>>(
      future: OrganizationService().getOrganizationStats(organization.id),
      builder: (context, snapshot) {
        final stats = snapshot.data ?? {};
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back, ${user?.name ?? 'User'}!',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                organization.name,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _DashboardCard(
                    title: 'Total Products',
                    value: '${stats['total_products'] ?? 0}',
                    icon: Icons.inventory_2,
                    color: Colors.blue,
                  ),
                  _DashboardCard(
                    title: 'Low Stock',
                    value: '${stats['low_stock_count'] ?? 0}',
                    icon: Icons.warning,
                    color: Colors.orange,
                  ),
                  _DashboardCard(
                    title: 'Team Members',
                    value: '${stats['member_count'] ?? organization.memberCount}',
                    icon: Icons.people,
                    color: Colors.green,
                  ),
                  _DashboardCard(
                    title: 'Inventory Value',
                    value: '\$${stats['inventory_value'] ?? 0}',
                    icon: Icons.attach_money,
                    color: Colors.purple,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Recent Activities',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Card(
                child: stats['recent_movements'] == null || 
                       (stats['recent_movements'] as List).isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Center(
                          child: Text('No recent activities'),
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: (stats['recent_movements'] as List).length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final movement = (stats['recent_movements'] as List)[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: movement['type'] == 'IN' 
                                  ? Colors.green 
                                  : Colors.red,
                              child: Icon(
                                movement['type'] == 'IN' 
                                    ? Icons.add 
                                    : Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                            title: Text('${movement['type']} - ${movement['quantity']} units'),
                            subtitle: Text(movement['reason'] ?? 'No reason provided'),
                            trailing: Text(
                              _formatDate(movement['created_at']),
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDate(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _DashboardCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}



class _ProfileView extends ConsumerWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final organization = ref.watch(currentOrganizationProvider);

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: user.photoUrl != null 
                ? NetworkImage(user.photoUrl!) 
                : null,
            child: user.photoUrl == null 
                ? Text(
                    user.name[0].toUpperCase(),
                    style: const TextStyle(fontSize: 40),
                  )
                : null,
          ),
          const SizedBox(height: 16),
          Text(
            user.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            user.email,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          if (organization != null) ...[
            const SizedBox(height: 8),
            Chip(
              label: Text(_getRoleDisplayName(user.role)),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
          ],
          const SizedBox(height: 32),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: const Text('Edit Profile'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    context.push('/profile/edit');
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.lock_outline),
                  title: const Text('Change Password'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    context.push('/profile/change-password');
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.notifications_outlined),
                  title: const Text('Notifications'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    context.push('/settings/notifications');
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: const Text('Help & Support'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    context.push('/help');
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.tour),
                  title: const Text('Feature Tour'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    context.push('/feature-tour');
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('About'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    context.push('/about');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
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
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                );

                if (confirmed == true) {
                  await ref.read(authNotifierProvider.notifier).signOut();
                  if (context.mounted) {
                    context.go(AppRouter.login);
                  }
                }
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Logout'),
            ),
          ),
        ],
      ),
    );
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
}