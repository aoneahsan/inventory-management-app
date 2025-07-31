import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';

class PurchaseOrderFormPage extends ConsumerStatefulWidget {
  final String? purchaseOrderId;

  const PurchaseOrderFormPage({
    super.key,
    this.purchaseOrderId,
  });

  @override
  ConsumerState<PurchaseOrderFormPage> createState() => _PurchaseOrderFormPageState();
}

class _PurchaseOrderFormPageState extends ConsumerState<PurchaseOrderFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  
  String? _selectedSupplierId;
  DateTime _orderDate = DateTime.now();
  DateTime? _expectedDate;
  final List<_OrderItem> _items = [];
  
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.purchaseOrderId != null) {
      _loadPurchaseOrder();
    }
  }

  Future<void> _loadPurchaseOrder() async {
    // TODO: Load existing purchase order
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    if (user == null) return const SizedBox();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.purchaseOrderId == null ? 'New Purchase Order' : 'Edit Purchase Order'),
        actions: [
          if (widget.purchaseOrderId == null)
            TextButton(
              onPressed: _isLoading ? null : _saveDraft,
              child: const Text('Save Draft'),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Supplier Selection
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Supplier Information',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 16),
                            DropdownButtonFormField<String>(
                              value: _selectedSupplierId,
                              decoration: const InputDecoration(
                                labelText: 'Select Supplier',
                                border: OutlineInputBorder(),
                              ),
                              items: const [], // TODO: Load suppliers
                              onChanged: (value) {
                                setState(() {
                                  _selectedSupplierId = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a supplier';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Dates
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order Details',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: _DateField(
                                    label: 'Order Date',
                                    date: _orderDate,
                                    onChanged: (date) {
                                      setState(() {
                                        _orderDate = date;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _DateField(
                                    label: 'Expected Date',
                                    date: _expectedDate,
                                    onChanged: (date) {
                                      setState(() {
                                        _expectedDate = date;
                                      });
                                    },
                                    isOptional: true,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Items
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
                                  'Order Items',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                IconButton(
                                  onPressed: _addItem,
                                  icon: const Icon(Icons.add),
                                  tooltip: 'Add Item',
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            if (_items.isEmpty)
                              const Center(
                                child: Text('No items added yet'),
                              )
                            else
                              ..._items.map((item) => _buildItemRow(item)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Notes
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextFormField(
                          controller: _notesController,
                          decoration: const InputDecoration(
                            labelText: 'Notes',
                            border: OutlineInputBorder(),
                            alignLabelWithHint: true,
                          ),
                          maxLines: 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Total Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total:'),
                      Text(
                        '\$${_calculateTotal().toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _isLoading ? null : _createOrder,
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Create Order'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRow(_OrderItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Text(item.productName),
            ),
            Text('${item.quantity} x \$${item.unitPrice.toStringAsFixed(2)}'),
            const SizedBox(width: 8),
            Text(
              '\$${(item.quantity * item.unitPrice).toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.delete, size: 20),
              onPressed: () {
                setState(() {
                  _items.remove(item);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  double _calculateTotal() {
    return _items.fold(0, (sum, item) => sum + (item.quantity * item.unitPrice));
  }

  void _addItem() {
    // TODO: Show item selection dialog
  }

  Future<void> _saveDraft() async {
    // TODO: Save as draft
  }

  Future<void> _createOrder() async {
    if (!_formKey.currentState!.validate()) return;
    if (_items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one item')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // TODO: Create purchase order
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Purchase order created successfully')),
        );
        context.go('/purchase-orders');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final DateTime? date;
  final ValueChanged<DateTime> onChanged;
  final bool isOptional;

  const _DateField({
    required this.label,
    required this.date,
    required this.onChanged,
    this.isOptional = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: date ?? DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        if (picked != null) {
          onChanged(picked);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        child: Text(
          date != null
              ? '${date!.day}/${date!.month}/${date!.year}'
              : isOptional
                  ? 'Not set'
                  : 'Select date',
        ),
      ),
    );
  }
}

class _OrderItem {
  final String productId;
  final String productName;
  final double quantity;
  final double unitPrice;

  _OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
  });
}