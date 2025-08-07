import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/purchase_order.dart';
import '../../../services/purchase/purchase_order_service.dart';
import '../../../services/purchase/supplier_service.dart';
import '../../../services/database/database.dart';
// Removed non-existent search_bar import
import '../../providers/auth_provider.dart';

final purchaseOrderServiceProvider = Provider<PurchaseOrderService>((ref) {
  final supplierService = ref.watch(supplierServiceProvider);
  return PurchaseOrderService(
    database: AppDatabase.instance,
    supplierService: supplierService,
  );
});

final supplierServiceProvider = Provider<SupplierService>((ref) {
  return SupplierService(database: AppDatabase.instance);
});

final purchaseOrdersProvider = FutureProvider.family<List<PurchaseOrder>, String>(
  (ref, organizationId) async {
    final service = ref.watch(purchaseOrderServiceProvider);
    return await service.getPurchaseOrders(organizationId);
  },
);

final purchaseOrderSearchQueryProvider = StateProvider<String>((ref) => '');
final purchaseOrderStatusFilterProvider = StateProvider<String?>((ref) => null);

final filteredPurchaseOrdersProvider = Provider.family<List<PurchaseOrder>, String>(
  (ref, organizationId) {
    final orders = ref.watch(purchaseOrdersProvider(organizationId));
    final searchQuery = ref.watch(purchaseOrderSearchQueryProvider);
    final statusFilter = ref.watch(purchaseOrderStatusFilterProvider);

    return orders.when(
      data: (orderList) {
        var filtered = orderList;
        
        if (statusFilter != null) {
          filtered = filtered.where((order) => order.status == statusFilter).toList();
        }
        
        if (searchQuery.isNotEmpty) {
          final query = searchQuery.toLowerCase();
          filtered = filtered.where((order) {
            return order.poNumber.toLowerCase().contains(query) ||
                (order.notes?.toLowerCase().contains(query) ?? false);
          }).toList();
        }
        
        return filtered;
      },
      loading: () => [],
      error: (_, _) => [],
    );
  },
);

class PurchaseOrdersPage extends ConsumerWidget {
  const PurchaseOrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final currentOrg = ref.watch(currentOrganizationProvider);
    if (user == null || currentOrg == null) return const SizedBox();

    final organizationId = currentOrg.id;
    final orders = ref.watch(filteredPurchaseOrdersProvider(organizationId));
    final ordersAsync = ref.watch(purchaseOrdersProvider(organizationId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase Orders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(purchaseOrdersProvider(organizationId));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search purchase orders...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        onChanged: (value) {
                          ref.read(purchaseOrderSearchQueryProvider.notifier).state = value;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    FilledButton.icon(
                      onPressed: () {
                        context.push('/purchase-orders/new');
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('New PO'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _StatusFilterChip(
                        label: 'All',
                        value: null,
                        selectedValue: ref.watch(purchaseOrderStatusFilterProvider),
                        onSelected: () {
                          ref.read(purchaseOrderStatusFilterProvider.notifier).state = null;
                        },
                      ),
                      const SizedBox(width: 8),
                      _StatusFilterChip(
                        label: 'Draft',
                        value: 'draft',
                        selectedValue: ref.watch(purchaseOrderStatusFilterProvider),
                        onSelected: () {
                          ref.read(purchaseOrderStatusFilterProvider.notifier).state = 'draft';
                        },
                      ),
                      const SizedBox(width: 8),
                      _StatusFilterChip(
                        label: 'Sent',
                        value: 'sent',
                        selectedValue: ref.watch(purchaseOrderStatusFilterProvider),
                        onSelected: () {
                          ref.read(purchaseOrderStatusFilterProvider.notifier).state = 'sent';
                        },
                      ),
                      const SizedBox(width: 8),
                      _StatusFilterChip(
                        label: 'Partial',
                        value: 'partial',
                        selectedValue: ref.watch(purchaseOrderStatusFilterProvider),
                        onSelected: () {
                          ref.read(purchaseOrderStatusFilterProvider.notifier).state = 'partial';
                        },
                      ),
                      const SizedBox(width: 8),
                      _StatusFilterChip(
                        label: 'Received',
                        value: 'received',
                        selectedValue: ref.watch(purchaseOrderStatusFilterProvider),
                        onSelected: () {
                          ref.read(purchaseOrderStatusFilterProvider.notifier).state = 'received';
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ordersAsync.when(
              data: (_) {
                if (orders.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long,
                          size: 64,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No purchase orders found',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        const Text('Create your first purchase order'),
                        const SizedBox(height: 24),
                        FilledButton.icon(
                          onPressed: () {
                            context.push('/purchase-orders/new');
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('New Purchase Order'),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return _PurchaseOrderCard(
                      order: order,
                      onTap: () {
                        context.push('/purchase-orders/${order.id}');
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
                        ref.invalidate(purchaseOrdersProvider(organizationId));
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

class _StatusFilterChip extends StatelessWidget {
  final String label;
  final String? value;
  final String? selectedValue;
  final VoidCallback onSelected;

  const _StatusFilterChip({
    required this.label,
    required this.value,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == selectedValue;
    
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      backgroundColor: isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
      selectedColor: Theme.of(context).colorScheme.primaryContainer,
    );
  }
}

class _PurchaseOrderCard extends StatelessWidget {
  final PurchaseOrder order;
  final VoidCallback onTap;

  const _PurchaseOrderCard({
    required this.order,
    required this.onTap,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'draft':
        return Colors.grey;
      case 'sent':
        return Colors.blue;
      case 'partial':
        return Colors.orange;
      case 'received':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'draft':
        return 'Draft';
      case 'sent':
        return 'Sent';
      case 'partial':
        return 'Partially Received';
      case 'received':
        return 'Received';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status;
    }
  }

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order.poNumber,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(order.status).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getStatusLabel(order.status),
                      style: TextStyle(
                        color: _getStatusColor(order.status),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Order Date: ${_formatDate(order.orderDate)}',
                    style: TextStyle(
                      color: theme.textTheme.bodySmall?.color,
                      fontSize: 14,
                    ),
                  ),
                  if (order.expectedDate != null) ...[
                    const SizedBox(width: 16),
                    Icon(
                      Icons.local_shipping,
                      size: 16,
                      color: theme.textTheme.bodySmall?.color,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Expected: ${_formatDate(order.expectedDate!)}',
                      style: TextStyle(
                        color: theme.textTheme.bodySmall?.color,
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
                    '${order.items.length} items',
                    style: TextStyle(
                      color: theme.textTheme.bodySmall?.color,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '\$${order.totalAmount.toStringAsFixed(2)}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              if (order.receivePercentage > 0 && order.receivePercentage < 100) ...[
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: order.receivePercentage / 100,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${order.receivePercentage.toStringAsFixed(0)}% received',
                  style: TextStyle(
                    color: theme.textTheme.bodySmall?.color,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}