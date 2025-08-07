import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/stock_transfer.dart';
import '../../../domain/entities/branch.dart';
import '../../../domain/entities/product.dart';
import '../../../services/transfer/stock_transfer_service.dart';
import '../../../services/branch/branch_service.dart';
import '../../providers/organization_provider.dart';
import '../../providers/auth_provider.dart';
import '../inventory/products_page.dart';

class StockTransferFormPage extends ConsumerStatefulWidget {
  const StockTransferFormPage({super.key});

  @override
  ConsumerState<StockTransferFormPage> createState() => _StockTransferFormPageState();
}

class _StockTransferFormPageState extends ConsumerState<StockTransferFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _service = StockTransferService();
  final _branchService = BranchService();
  
  Branch? _fromBranch;
  Branch? _toBranch;
  final Map<String, double> _selectedProducts = {};
  final Map<String, TextEditingController> _quantityControllers = {};
  final _notesController = TextEditingController();
  
  List<Branch> _branches = [];
  List<Product> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _notesController.dispose();
    for (final controller in _quantityControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _loadData() async {
    final organizationId = ref.read(currentOrganizationIdProvider);
    if (organizationId == null) return;

    try {
      final branches = await _branchService.getBranches(organizationId);
      final productService = ref.read(productServiceProvider);
      final products = await productService.getProducts(organizationId);
      
      setState(() {
        _branches = branches;
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading data: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Stock Transfer'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Transfer Details',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<Branch>(
                      value: _fromBranch,
                      decoration: const InputDecoration(
                        labelText: 'From Branch*',
                        prefixIcon: Icon(Icons.store),
                      ),
                      items: _branches.map((branch) {
                        return DropdownMenuItem(
                          value: branch,
                          child: Text('${branch.name} (${branch.type.displayName})'),
                        );
                      }).toList(),
                      onChanged: (branch) {
                        setState(() {
                          _fromBranch = branch;
                          _selectedProducts.clear();
                          _quantityControllers.clear();
                        });
                      },
                      validator: (value) {
                        if (value == null) return 'Please select source branch';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<Branch>(
                      value: _toBranch,
                      decoration: const InputDecoration(
                        labelText: 'To Branch*',
                        prefixIcon: Icon(Icons.store),
                      ),
                      items: _branches
                          .where((b) => b.id != _fromBranch?.id)
                          .map((branch) {
                        return DropdownMenuItem(
                          value: branch,
                          child: Text('${branch.name} (${branch.type.displayName})'),
                        );
                      }).toList(),
                      onChanged: (branch) {
                        setState(() => _toBranch = branch);
                      },
                      validator: (value) {
                        if (value == null) return 'Please select destination branch';
                        if (value.id == _fromBranch?.id) {
                          return 'Cannot transfer to same branch';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _notesController,
                      decoration: const InputDecoration(
                        labelText: 'Notes',
                        prefixIcon: Icon(Icons.note),
                      ),
                      maxLines: 3,
                    ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Products',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: _fromBranch == null
                              ? null
                              : () => _showProductSelection(),
                          icon: const Icon(Icons.add),
                          label: const Text('Add Product'),
                        ),
                      ],
                    ),
                    if (_selectedProducts.isEmpty) ...[
                      const SizedBox(height: 32),
                      Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.inventory_2,
                              size: 48,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'No products selected',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                    ] else ...[
                      const SizedBox(height: 16),
                      ..._selectedProducts.entries.map((entry) {
                        final product = _products.firstWhere((p) => p.id == entry.key);
                        final controller = _quantityControllers[entry.key]!;
                        
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text(product.name[0].toUpperCase()),
                          ),
                          title: Text(product.name),
                          subtitle: Text('SKU: ${product.sku}'),
                          trailing: SizedBox(
                            width: 120,
                            child: TextFormField(
                              controller: controller,
                              decoration: const InputDecoration(
                                labelText: 'Quantity',
                                suffixText: 'units',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required';
                                }
                                final qty = double.tryParse(value);
                                if (qty == null || qty <= 0) {
                                  return 'Invalid';
                                }
                                // TODO: Check available stock
                                return null;
                              },
                              onChanged: (value) {
                                final qty = double.tryParse(value);
                                if (qty != null && qty > 0) {
                                  setState(() {
                                    _selectedProducts[entry.key] = qty;
                                  });
                                }
                              },
                            ),
                          ),
                          onTap: () => _removeProduct(entry.key),
                        );
                      }).toList(),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            onPressed: _selectedProducts.isEmpty ? null : _submitTransfer,
            child: const Text('Create Transfer'),
          ),
        ),
      ),
    );
  }

  void _showProductSelection() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Products',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  final isSelected = _selectedProducts.containsKey(product.id);
                  
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : null,
                      child: Text(
                        product.name[0].toUpperCase(),
                        style: TextStyle(
                          color: isSelected ? Colors.white : null,
                        ),
                      ),
                    ),
                    title: Text(product.name),
                    subtitle: Text('SKU: ${product.sku} | Stock: ${product.currentStock}'),
                    trailing: isSelected
                        ? Icon(
                            Icons.check_circle,
                            color: Theme.of(context).colorScheme.primary,
                          )
                        : null,
                    onTap: () {
                      if (!isSelected) {
                        setState(() {
                          _selectedProducts[product.id] = 1;
                          _quantityControllers[product.id] = 
                              TextEditingController(text: '1');
                        });
                      }
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _removeProduct(String productId) {
    setState(() {
      _selectedProducts.remove(productId);
      _quantityControllers[productId]?.dispose();
      _quantityControllers.remove(productId);
    });
  }

  Future<void> _submitTransfer() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedProducts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one product')),
      );
      return;
    }

    final organizationId = ref.read(currentOrganizationIdProvider);
    if (organizationId == null) return;

    try {
      // Create transfer items
      final items = _selectedProducts.entries.map((entry) {
        return StockTransferItem(
          id: '',
          transferId: '',
          productId: entry.key,
          quantity: entry.value,
          receivedQuantity: 0,
          status: TransferItemStatus.pending,
          notes: null,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
      }).toList();

      // Create transfer
      final transfer = StockTransfer(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        organizationId: organizationId,
        fromBranchId: _fromBranch!.id,
        toBranchId: _toBranch!.id,
        transferNumber: 'TR-${DateTime.now().millisecondsSinceEpoch}',
        items: items,
        status: TransferStatus.pending,
        notes: _notesController.text.trim().isEmpty 
            ? null 
            : _notesController.text.trim(),
        createdBy: ref.read(currentUserProvider)?.id ?? 'unknown',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _service.createTransfer(transfer);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transfer created successfully')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating transfer: $e')),
        );
      }
    }
  }
}