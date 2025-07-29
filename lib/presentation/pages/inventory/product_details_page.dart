import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/entities/inventory_movement.dart';
import '../../providers/auth_provider.dart';
import 'products_page.dart';

final productProvider = FutureProvider.family<Product?, String>((ref, productId) async {
  final productService = ref.watch(productServiceProvider);
  return productService.getProduct(productId);
});

final productMovementsProvider = FutureProvider.family<List<InventoryMovement>, String>((ref, productId) async {
  final org = ref.watch(currentOrganizationProvider);
  if (org == null) throw Exception('No organization');
  
  final productService = ref.watch(productServiceProvider);
  return productService.getInventoryMovements(org.id, productId: productId, limit: 20);
});

class ProductDetailsPage extends ConsumerStatefulWidget {
  final String productId;
  
  const ProductDetailsPage({
    super.key,
    required this.productId,
  });

  @override
  ConsumerState<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends ConsumerState<ProductDetailsPage> 
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productAsync = ref.watch(productProvider(widget.productId));
    final user = ref.watch(currentUserProvider);
    final canEdit = user?.hasPermission('manage_products') ?? false;
    
    return productAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(title: const Text('Product Details')),
        body: Center(child: Text('Error: $error')),
      ),
      data: (product) {
        if (product == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Product Not Found')),
            body: const Center(child: Text('Product not found')),
          );
        }
        
        return Scaffold(
          appBar: AppBar(
            title: Text(product.name),
            actions: [
              if (canEdit)
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => context.push('/products/${product.id}/edit'),
                ),
            ],
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Details'),
                Tab(text: 'Stock'),
                Tab(text: 'History'),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildDetailsTab(product),
              _buildStockTab(product, canEdit),
              _buildHistoryTab(product),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailsTab(Product product) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          if (product.imageUrl != null)
            Center(
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(product.imageUrl!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          else
            Center(
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.inventory_2, size: 80),
              ),
            ),
          const SizedBox(height: 24),
          
          // Basic info
          _buildInfoCard(
            title: 'Basic Information',
            children: [
              _buildInfoRow('SKU', product.sku),
              if (product.barcode != null)
                _buildInfoRow('Barcode', product.barcode!),
              _buildInfoRow('Unit', product.unit),
              if (product.description != null)
                _buildInfoRow('Description', product.description!),
            ],
          ),
          const SizedBox(height: 16),
          
          // Pricing
          _buildInfoCard(
            title: 'Pricing',
            children: [
              if (product.costPrice != null)
                _buildInfoRow('Cost Price', '\$${product.costPrice!.toStringAsFixed(2)}'),
              if (product.sellingPrice != null)
                _buildInfoRow('Selling Price', '\$${product.sellingPrice!.toStringAsFixed(2)}'),
              _buildInfoRow('Tax Rate', '${product.taxRate}%'),
              if (product.costPrice != null && product.sellingPrice != null)
                _buildInfoRow(
                  'Profit Margin', 
                  '${product.profitMargin.toStringAsFixed(1)}%',
                  valueColor: product.profitMargin > 0 ? Colors.green : Colors.red,
                ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Location
          if (product.warehouseLocation != null)
            _buildInfoCard(
              title: 'Location',
              children: [
                _buildInfoRow('Warehouse', product.warehouseLocation!),
              ],
            ),
          const SizedBox(height: 16),
          
          // Status
          _buildInfoCard(
            title: 'Status',
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Active'),
                  Switch(
                    value: product.isActive,
                    onChanged: null, // Read-only in details view
                  ),
                ],
              ),
              _buildInfoRow('Created', _formatDate(product.createdAt)),
              _buildInfoRow('Last Updated', _formatDate(product.updatedAt)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStockTab(Product product, bool canManage) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Current stock card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Current Stock',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${product.currentStock.toStringAsFixed(1)} ${product.unit}',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: product.isOutOfStock
                              ? Colors.red
                              : product.isLowStock
                                  ? Colors.orange
                                  : Colors.green,
                        ),
                  ),
                  if (product.isLowStock)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Chip(
                        label: const Text('Low Stock'),
                        backgroundColor: Colors.orange[100],
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Stock levels
          _buildInfoCard(
            title: 'Stock Levels',
            children: [
              _buildInfoRow('Minimum Stock', '${product.minStock} ${product.unit}'),
              if (product.maxStock != null)
                _buildInfoRow('Maximum Stock', '${product.maxStock} ${product.unit}'),
              if (product.reorderPoint != null)
                _buildInfoRow('Reorder Point', '${product.reorderPoint} ${product.unit}'),
              if (product.reorderQuantity != null)
                _buildInfoRow('Reorder Quantity', '${product.reorderQuantity} ${product.unit}'),
            ],
          ),
          const SizedBox(height: 16),
          
          // Stock value
          _buildInfoCard(
            title: 'Stock Value',
            children: [
              _buildInfoRow('Total Value', '\$${product.stockValue.toStringAsFixed(2)}'),
              _buildInfoRow('Potential Revenue', '\$${product.potentialRevenue.toStringAsFixed(2)}'),
            ],
          ),
          const SizedBox(height: 24),
          
          // Stock actions
          if (canManage) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showStockAdjustmentDialog(product),
                icon: const Icon(Icons.edit),
                label: const Text('Adjust Stock'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showAddStockDialog(product),
                icon: const Icon(Icons.add),
                label: const Text('Add Stock'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHistoryTab(Product product) {
    final movementsAsync = ref.watch(productMovementsProvider(product.id));
    
    return movementsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
      data: (movements) {
        if (movements.isEmpty) {
          return const Center(
            child: Text('No inventory movements yet'),
          );
        }
        
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: movements.length,
          itemBuilder: (context, index) {
            final movement = movements[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: movement.isIncoming
                      ? Colors.green
                      : movement.isOutgoing
                          ? Colors.red
                          : Colors.blue,
                  child: Icon(
                    movement.isIncoming
                        ? Icons.add
                        : movement.isOutgoing
                            ? Icons.remove
                            : Icons.swap_horiz,
                    color: Colors.white,
                  ),
                ),
                title: Text(movement.typeDisplayName),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${movement.quantity} ${product.unit}'),
                    if (movement.reason != null)
                      Text(movement.reason!, style: const TextStyle(fontSize: 12)),
                  ],
                ),
                trailing: Text(
                  _formatDate(movement.createdAt),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInfoCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: valueColor,
                ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _showStockAdjustmentDialog(Product product) async {
    final quantityController = TextEditingController(
      text: product.currentStock.toStringAsFixed(0),
    );
    final reasonController = TextEditingController();
    
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adjust Stock'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: quantityController,
              decoration: InputDecoration(
                labelText: 'New Quantity',
                suffixText: product.unit,
                border: const OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Adjust'),
          ),
        ],
      ),
    );
    
    if (result == true) {
      try {
        final newQuantity = double.tryParse(quantityController.text) ?? 0;
        final user = ref.read(currentUserProvider)!;
        final productService = ref.read(productServiceProvider);
        
        await productService.adjustStock(
          productId: product.id,
          newQuantity: newQuantity,
          reason: reasonController.text.trim(),
          performedBy: user.id,
        );
        
        ref.invalidate(productProvider(product.id));
        ref.invalidate(productMovementsProvider(product.id));
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Stock adjusted successfully')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Future<void> _showAddStockDialog(Product product) async {
    final quantityController = TextEditingController();
    final costController = TextEditingController(
      text: product.costPrice?.toStringAsFixed(2) ?? '',
    );
    final referenceController = TextEditingController();
    
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Stock'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: quantityController,
              decoration: InputDecoration(
                labelText: 'Quantity to Add',
                suffixText: product.unit,
                border: const OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: costController,
              decoration: const InputDecoration(
                labelText: 'Unit Cost',
                prefixText: '\$',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: referenceController,
              decoration: const InputDecoration(
                labelText: 'Reference Number (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Add Stock'),
          ),
        ],
      ),
    );
    
    if (result == true) {
      try {
        final quantity = double.tryParse(quantityController.text) ?? 0;
        final unitCost = double.tryParse(costController.text);
        final user = ref.read(currentUserProvider)!;
        final productService = ref.read(productServiceProvider);
        
        await productService.recordInventoryMovement(
          productId: product.id,
          type: MovementType.purchase,
          quantity: quantity,
          unitCost: unitCost,
          referenceNumber: referenceController.text.trim(),
          performedBy: user.id,
        );
        
        ref.invalidate(productProvider(product.id));
        ref.invalidate(productMovementsProvider(product.id));
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Stock added successfully')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}