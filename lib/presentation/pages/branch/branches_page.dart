import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/branch.dart';
import '../../../services/branch/branch_service.dart';
import '../../widgets/app_drawer.dart';

final branchesProvider = FutureProvider.autoDispose<List<Branch>>((ref) async {
  final organizationId = ref.watch(currentOrganizationIdProvider);
  if (organizationId == null) return [];
  
  final branchService = BranchService();
  return branchService.getBranches(organizationId);
});

class BranchesPage extends ConsumerStatefulWidget {
  const BranchesPage({super.key});

  @override
  ConsumerState<BranchesPage> createState() => _BranchesPageState();
}

class _BranchesPageState extends ConsumerState<BranchesPage> {
  @override
  Widget build(BuildContext context) {
    final branchesAsync = ref.watch(branchesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Branches & Warehouses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/branches/new'),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: branchesAsync.when(
        data: (branches) {
          if (branches.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.store_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No branches or warehouses',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add your first location to manage inventory',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => context.push('/branches/new'),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Location'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: branches.length,
            itemBuilder: (context, index) {
              final branch = branches[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getTypeColor(branch.type),
                    child: Icon(
                      _getTypeIcon(branch.type),
                      color: Colors.white,
                    ),
                  ),
                  title: Text(branch.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(branch.type.displayName),
                      if (branch.address != null)
                        Text(
                          branch.address!,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (branch.isDefault)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Default',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      const SizedBox(width: 8),
                      Switch(
                        value: branch.isActive,
                        onChanged: (value) => _toggleBranchStatus(branch),
                      ),
                    ],
                  ),
                  onTap: () => context.push('/branches/${branch.id}'),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }

  Color _getTypeColor(BranchType type) {
    switch (type) {
      case BranchType.store:
        return Colors.blue;
      case BranchType.warehouse:
        return Colors.orange;
      case BranchType.both:
        return Colors.green;
    }
  }

  IconData _getTypeIcon(BranchType type) {
    switch (type) {
      case BranchType.store:
        return Icons.store;
      case BranchType.warehouse:
        return Icons.warehouse;
      case BranchType.both:
        return Icons.business;
    }
  }

  Future<void> _toggleBranchStatus(Branch branch) async {
    try {
      final branchService = BranchService();
      await branchService.updateBranch(
        branch.id,
        branch.copyWith(isActive: !branch.isActive),
      );
      ref.invalidate(branchesProvider);
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              branch.isActive ? 'Branch deactivated' : 'Branch activated',
            ),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
}