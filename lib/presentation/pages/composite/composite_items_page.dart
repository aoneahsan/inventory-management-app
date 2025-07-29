import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/composite_item.dart';
import '../../../services/inventory/composite_item_service.dart';
import '../../providers/organization_provider.dart';

final compositeItemsProvider = FutureProvider.autoDispose<List<CompositeItem>>((ref) async {
  final organizationId = ref.watch(currentOrganizationIdProvider);
  if (organizationId == null) return [];
  
  final service = CompositeItemService();
  return service.getCompositeItems(organizationId);
});

class CompositeItemsPage extends ConsumerWidget {
  const CompositeItemsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final compositeItemsAsync = ref.watch(compositeItemsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Composite Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/composite-items/new'),
          ),
        ],
      ),
      body: compositeItemsAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.widgets,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No composite items',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create bundles and kits from multiple products',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => context.push('/composite-items/new'),
                    icon: const Icon(Icons.add),
                    label: const Text('Create Composite Item'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ExpansionTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    child: Icon(
                      Icons.widgets,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  title: Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${item.components?.length ?? 0} components'),
                      Text(
                        'Price: ₹${item.sellingPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (item.canBeSoldSeparately)
                        Chip(
                          label: const Text('Sell Separately'),
                          labelStyle: const TextStyle(fontSize: 11),
                          padding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                        ),
                      const SizedBox(width: 8),
                      Switch(
                        value: item.isActive,
                        onChanged: null,
                      ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Components:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          ...(item.components ?? []).map((component) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 8,
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '${component.quantity}x ${component.productId}',
                                  ),
                                ),
                                if (component.costPrice != null)
                                  Text(
                                    '₹${component.costPrice!.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.outline,
                                    ),
                                  ),
                              ],
                            ),
                          )),
                          const Divider(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total Cost:'),
                              Text(
                                '₹${item.totalCost.toStringAsFixed(2)}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          ...[
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Selling Price:'),
                                Text(
                                  '₹${item.sellingPrice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Margin:'),
                                Text(
                                  '${((item.sellingPrice - item.totalCost) / item.totalCost * 100).toStringAsFixed(1)}%',
                                  style: TextStyle(
                                    color: item.sellingPrice > item.totalCost
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  // TODO: Implement assembly
                                },
                                icon: const Icon(Icons.build),
                                label: const Text('Assemble'),
                              ),
                              const SizedBox(width: 8),
                              TextButton.icon(
                                onPressed: () {
                                  // TODO: Implement disassembly
                                },
                                icon: const Icon(Icons.layers_clear),
                                label: const Text('Disassemble'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
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
}