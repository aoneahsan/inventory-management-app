import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../router/app_router.dart';

class MobileNavigationDrawer extends ConsumerWidget {
  const MobileNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final organization = ref.watch(currentOrganizationProvider);

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user?.name ?? 'User'),
            accountEmail: Text(user?.email ?? ''),
            currentAccountPicture: CircleAvatar(
              backgroundImage: user?.photoUrl != null
                  ? NetworkImage(user!.photoUrl!)
                  : null,
              child: user?.photoUrl == null
                  ? Text(
                      user?.name[0].toUpperCase() ?? 'U',
                      style: const TextStyle(fontSize: 24),
                    )
                  : null,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _DrawerItem(
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(AppRouter.home);
                  },
                ),
                _DrawerItem(
                  icon: Icons.inventory_2,
                  title: 'Products',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/products');
                  },
                ),
                _DrawerItem(
                  icon: Icons.category,
                  title: 'Categories',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/categories');
                  },
                ),
                _DrawerItem(
                  icon: Icons.point_of_sale,
                  title: 'Point of Sale',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(AppRouter.pos);
                  },
                ),
                const Divider(),
                _DrawerSection(title: 'Inventory'),
                _DrawerItem(
                  icon: Icons.store,
                  title: 'Branches',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(AppRouter.branches);
                  },
                ),
                _DrawerItem(
                  icon: Icons.swap_horiz,
                  title: 'Stock Transfers',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(AppRouter.transfers);
                  },
                ),
                _DrawerItem(
                  icon: Icons.business,
                  title: 'Suppliers',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(AppRouter.suppliers);
                  },
                ),
                _DrawerItem(
                  icon: Icons.receipt_long,
                  title: 'Purchase Orders',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(AppRouter.purchaseOrders);
                  },
                ),
                const Divider(),
                _DrawerSection(title: 'Analytics & Reports'),
                _DrawerItem(
                  icon: Icons.analytics,
                  title: 'Analytics',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/analytics');
                  },
                ),
                _DrawerItem(
                  icon: Icons.bar_chart,
                  title: 'Charts',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(AppRouter.analyticsCharts);
                  },
                ),
                _DrawerItem(
                  icon: Icons.assessment,
                  title: 'Custom Reports',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/reports/custom');
                  },
                ),
                const Divider(),
                _DrawerSection(title: 'Advanced'),
                _DrawerItem(
                  icon: Icons.settings_applications,
                  title: 'Advanced Features',
                  onTap: () {
                    Navigator.pop(context);
                    context.go(AppRouter.advancedFeatures);
                  },
                ),
                if (organization != null) ...[
                  const Divider(),
                  _DrawerSection(title: 'Organization'),
                  _DrawerItem(
                    icon: Icons.business_center,
                    title: 'Organization Settings',
                    onTap: () {
                      Navigator.pop(context);
                      context.push('/organization/settings');
                    },
                  ),
                ],
              ],
            ),
          ),
          const Divider(),
          _DrawerItem(
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {
              Navigator.pop(context);
              context.push('/settings');
            },
          ),
          _DrawerItem(
            icon: Icons.logout,
            title: 'Logout',
            textColor: Colors.red,
            onTap: () async {
              Navigator.pop(context);
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
          ),
        ],
      ),
    );
  }
}

class _DrawerSection extends StatelessWidget {
  final String title;

  const _DrawerSection({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? textColor;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: textColor),
      title: Text(
        title,
        style: textColor != null ? TextStyle(color: textColor) : null,
      ),
      onTap: onTap,
    );
  }
}