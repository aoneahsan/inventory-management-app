import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/supplier.dart';
import '../../../services/purchase/supplier_service.dart';
import '../../../services/database/database.dart';
import '../../../core/theme/app_theme.dart';
// Removed non-existent search_bar import
import '../../providers/auth_provider.dart';

final supplierServiceProvider = Provider<SupplierService>((ref) {
  return SupplierService(database: AppDatabase.instance);
});

final suppliersProvider = FutureProvider.family<List<Supplier>, String>(
  (ref, organizationId) async {
    final supplierService = ref.watch(supplierServiceProvider);
    return await supplierService.getSuppliers(organizationId);
  },
);

final supplierSearchQueryProvider = StateProvider<String>((ref) => '');

final filteredSuppliersProvider = Provider.family<List<Supplier>, String>(
  (ref, organizationId) {
    final suppliers = ref.watch(suppliersProvider(organizationId));
    final searchQuery = ref.watch(supplierSearchQueryProvider);

    return suppliers.when(
      data: (supplierList) {
        if (searchQuery.isEmpty) return supplierList;
        
        final query = searchQuery.toLowerCase();
        return supplierList.where((supplier) {
          return supplier.name.toLowerCase().contains(query) ||
              (supplier.code?.toLowerCase().contains(query) ?? false) ||
              (supplier.email?.toLowerCase().contains(query) ?? false) ||
              (supplier.phone?.contains(query) ?? false);
        }).toList();
      },
      loading: () => [],
      error: (_, __) => [],
    );
  },
);

class SuppliersPage extends ConsumerWidget {
  const SuppliersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    if (user == null) return const SizedBox();

    final organizationId = user.organizationId!;
    final suppliers = ref.watch(filteredSuppliersProvider(organizationId));
    final suppliersAsync = ref.watch(suppliersProvider(organizationId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Suppliers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(suppliersProvider(organizationId));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: SearchBar(
                    hintText: 'Search suppliers...',
                    onChanged: (value) {
                      ref.read(supplierSearchQueryProvider.notifier).state = value;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                FilledButton.icon(
                  onPressed: () {
                    context.push('/suppliers/new');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Supplier'),
                ),
              ],
            ),
          ),
          Expanded(
            child: suppliersAsync.when(
              data: (_) {
                if (suppliers.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.business,
                          size: 64,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No suppliers found',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        const Text('Add your first supplier to get started'),
                        const SizedBox(height: 24),
                        FilledButton.icon(
                          onPressed: () {
                            context.push('/suppliers/new');
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Add Supplier'),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: suppliers.length,
                  itemBuilder: (context, index) {
                    final supplier = suppliers[index];
                    return _SupplierCard(
                      supplier: supplier,
                      onTap: () {
                        context.push('/suppliers/${supplier.id}');
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text('Error: ${error.toString()}'),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {
                        ref.invalidate(suppliersProvider(organizationId));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SupplierCard extends StatelessWidget {
  final Supplier supplier;
  final VoidCallback onTap;

  const _SupplierCard({
    required this.supplier,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Text(
                  supplier.name.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            supplier.displayName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (!supplier.isActive)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Inactive',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (supplier.email != null) ...[
                          Icon(
                            Icons.email_outlined,
                            size: 16,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            supplier.email!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 16),
                        ],
                        if (supplier.phone != null) ...[
                          Icon(
                            Icons.phone_outlined,
                            size: 16,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            supplier.phone!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Payment Terms: ${supplier.paymentTerms} days',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 14,
                          ),
                        ),
                        if (supplier.currentBalance > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.errorContainer,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Outstanding: \$${supplier.currentBalance.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: theme.colorScheme.onErrorContainer,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}