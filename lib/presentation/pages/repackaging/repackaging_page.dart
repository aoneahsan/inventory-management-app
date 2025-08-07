import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/repackaging_rule.dart';
import '../../../domain/entities/product.dart';
import '../../../services/inventory/repackaging_service.dart';
import '../../../services/inventory/product_service.dart';
import '../../../services/branch/branch_service.dart';
import '../../providers/organization_provider.dart';
import '../../providers/auth_provider.dart';
import '../inventory/products_page.dart';

final repackagingRulesProvider = FutureProvider.autoDispose<List<RepackagingRule>>((ref) async {
  final organizationId = ref.watch(currentOrganizationIdProvider);
  if (organizationId == null) return [];
  
  final service = RepackagingService();
  return service.getRepackagingRules(organizationId);
});

class RepackagingPage extends ConsumerWidget {
  const RepackagingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rulesAsync = ref.watch(repackagingRulesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Repackaging Rules'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showRepackagingDialog(context, ref),
          ),
        ],
      ),
      body: rulesAsync.when(
        data: (rules) {
          if (rules.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.transform,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No repackaging rules',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Convert bulk items into smaller units',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => _showRepackagingDialog(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text('Create Rule'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: rules.length,
            itemBuilder: (context, index) {
              final rule = rules[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: rule.isActive
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Colors.grey.shade200,
                    child: Icon(
                      Icons.transform,
                      color: rule.isActive
                          ? Theme.of(context).colorScheme.onPrimaryContainer
                          : Colors.grey,
                    ),
                  ),
                  title: Text(
                    rule.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('From: ${rule.fromProductId}'),
                      Text('To: ${rule.toProductId}'),
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '1 unit → ${rule.conversionFactor} units',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Switch(
                        value: rule.isActive,
                        onChanged: (value) async {
                          try {
                            final service = RepackagingService();
                            final organizationId = ref.read(currentOrganizationIdProvider);
                            if (organizationId == null) return;
                            
                            await service.updateRepackagingRule(
                              rule.id,
                              rule.copyWith(isActive: value),
                            );
                            
                            ref.invalidate(repackagingRulesProvider);
                            
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Rule ${value ? 'activated' : 'deactivated'}',
                                  ),
                                ),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error updating rule: $e'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                      ),
                      Text(
                        rule.requiresApproval ? 'Approval Required' : 'Auto',
                        style: TextStyle(
                          fontSize: 11,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                  onTap: () => _showExecuteDialog(context, ref, rule),
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

  void _showRepackagingDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => const _RepackagingRuleDialog(),
    );
  }

  void _showExecuteDialog(BuildContext context, WidgetRef ref, RepackagingRule rule) {
    showDialog(
      context: context,
      builder: (context) => _ExecuteRepackagingDialog(rule: rule),
    );
  }
}

class _RepackagingRuleDialog extends StatefulWidget {
  const _RepackagingRuleDialog();

  @override
  State<_RepackagingRuleDialog> createState() => _RepackagingRuleDialogState();
}

class _RepackagingRuleDialogState extends State<_RepackagingRuleDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _conversionFactorController = TextEditingController();
  bool _requiresApproval = false;
  Product? _fromProduct;
  Product? _toProduct;
  List<Product> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _conversionFactorController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    try {
      final container = ProviderScope.containerOf(context);
      final organizationId = container.read(currentOrganizationIdProvider);
      if (organizationId == null) return;

      final productService = container.read(productServiceProvider);
      final products = await productService.getProducts(organizationId);
      
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const AlertDialog(
        content: SizedBox(
          height: 100,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return AlertDialog(
      title: const Text('New Repackaging Rule'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Rule Name*',
                  hintText: 'e.g., Box to Units',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter rule name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<Product>(
                value: _fromProduct,
                decoration: const InputDecoration(
                  labelText: 'From Product*',
                  hintText: 'Select bulk product',
                ),
                items: _products.map((product) {
                  return DropdownMenuItem(
                    value: product,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(product.name),
                        Text(
                          'SKU: ${product.sku} | Stock: ${product.currentStock}',
                          style: const TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _fromProduct = value);
                },
                validator: (value) {
                  if (value == null) return 'Please select from product';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<Product>(
                value: _toProduct,
                decoration: const InputDecoration(
                  labelText: 'To Product*',
                  hintText: 'Select unit product',
                ),
                items: _products
                    .where((p) => p.id != _fromProduct?.id)
                    .map((product) {
                  return DropdownMenuItem(
                    value: product,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(product.name),
                        Text(
                          'SKU: ${product.sku} | Stock: ${product.currentStock}',
                          style: const TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _toProduct = value);
                },
                validator: (value) {
                  if (value == null) return 'Please select to product';
                  if (value.id == _fromProduct?.id) {
                    return 'Cannot be same as from product';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _conversionFactorController,
                decoration: const InputDecoration(
                  labelText: 'Conversion Factor*',
                  hintText: 'e.g., 24',
                  helperText: '1 bulk unit = X smaller units',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter conversion factor';
                  }
                  final factor = double.tryParse(value);
                  if (factor == null || factor <= 0) {
                    return 'Invalid conversion factor';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Requires Approval'),
                value: _requiresApproval,
                onChanged: (value) {
                  setState(() => _requiresApproval = value ?? false);
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await _createRepackagingRule(context);
            }
          },
          child: const Text('Create'),
        ),
      ],
    );
  }

  Future<void> _createRepackagingRule(BuildContext context) async {
    try {
      final container = ProviderScope.containerOf(context);
      final organizationId = container.read(currentOrganizationIdProvider);
      if (organizationId == null) {
        throw Exception('No organization selected');
      }

      final conversionFactor = double.parse(_conversionFactorController.text);

      final rule = RepackagingRule(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        organizationId: organizationId,
        name: _nameController.text.trim(),
        fromProductId: _fromProduct!.id,
        toProductId: _toProduct!.id,
        conversionFactor: conversionFactor,
        requiresApproval: _requiresApproval,
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final service = RepackagingService();
      await service.createRepackagingRule(rule);

      if (context.mounted) {
        container.invalidate(repackagingRulesProvider);
        
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Repackaging rule created successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating rule: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

class _ExecuteRepackagingDialog extends StatefulWidget {
  final RepackagingRule rule;

  const _ExecuteRepackagingDialog({required this.rule});

  @override
  State<_ExecuteRepackagingDialog> createState() => _ExecuteRepackagingDialogState();
}

class _ExecuteRepackagingDialogState extends State<_ExecuteRepackagingDialog> {
  final _quantityController = TextEditingController(text: '1');

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final outputQuantity = int.tryParse(_quantityController.text) ?? 0;
    final resultQuantity = outputQuantity * widget.rule.conversionFactor;

    return AlertDialog(
      title: Text('Execute: ${widget.rule.name}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _quantityController,
            decoration: const InputDecoration(
              labelText: 'Quantity to Repackage',
              suffixText: 'units',
            ),
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('From:'),
                    Text(
                      '$outputQuantity units',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Icon(
                  Icons.arrow_downward,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('To:'),
                    Text(
                      '${resultQuantity.toStringAsFixed(0)} units',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (widget.rule.requiresApproval) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.orange.shade700,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'This repackaging requires approval',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: outputQuantity > 0
              ? () async {
                  await _executeRepackaging(context);
                }
              : null,
          child: const Text('Execute'),
        ),
      ],
    );
  }

  Future<void> _executeRepackaging(BuildContext context) async {
    try {
      final quantity = int.tryParse(_quantityController.text) ?? 0;
      if (quantity <= 0) return;

      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text('Executing repackaging...'),
            ],
          ),
        ),
      );

      final container = ProviderScope.containerOf(context);
      final organizationId = container.read(currentOrganizationIdProvider);
      if (organizationId == null) {
        Navigator.of(context).pop(); // Close loading dialog
        throw Exception('No organization selected');
      }

      final service = RepackagingService();
      final user = container.read(currentUserProvider);
      if (user == null) {
        throw Exception('User not found');
      }

      // Get the first available branch for the organization
      final branchService = BranchService();
      final branches = await branchService.getBranches(organizationId);
      if (branches.isEmpty) {
        throw Exception('No branches found for organization');
      }
      
      final branchId = branches.first.id;

      await service.executeRepackaging(
        widget.rule.id,
        branchId,
        quantity.toDouble(),
        user.id,
        null,
      );

      if (context.mounted) {
        Navigator.of(context).pop(); // Close loading dialog
        Navigator.of(context).pop(); // Close execute dialog

        // Refresh the rules list
        container.invalidate(repackagingRulesProvider);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Successfully repackaged $quantity units into ${(quantity * widget.rule.conversionFactor).toStringAsFixed(0)} units',
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop(); // Close loading dialog if still open
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error executing repackaging: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}