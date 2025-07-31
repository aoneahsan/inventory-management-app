import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_plugin/inventory_management_plugin.dart';
import '../providers/product_providers.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  String _searchQuery = '';
  Map<String, dynamic> _filters = {};
  bool _isGridView = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final products = ref.watch(productsProvider(_searchQuery, _filters));
    final barcodeService = ref.read(barcodeServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
          BarcodeScannerButton(
            barcodeService: barcodeService,
            onScanned: (result) {
              if (result.type == BarcodeType.product && result.product != null) {
                _showProductDetails(result.product!);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Product not found')),
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: InventorySearchBar(
              hintText: 'Search products...',
              onSearch: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
              onFiltersChanged: (filters) {
                setState(() {
                  _filters = filters;
                });
              },
              filters: [
                SearchFilter(
                  key: 'category',
                  label: 'Category',
                  icon: Icons.category,
                  type: FilterType.select,
                  options: [
                    FilterOption(label: 'Electronics', value: 'electronics'),
                    FilterOption(label: 'Clothing', value: 'clothing'),
                    FilterOption(label: 'Food', value: 'food'),
                    FilterOption(label: 'Other', value: 'other'),
                  ],
                ),
                SearchFilter(
                  key: 'stock',
                  label: 'Stock Status',
                  icon: Icons.inventory,
                  type: FilterType.select,
                  options: [
                    FilterOption(label: 'In Stock', value: 'in_stock'),
                    FilterOption(label: 'Low Stock', value: 'low_stock'),
                    FilterOption(label: 'Out of Stock', value: 'out_of_stock'),
                  ],
                ),
                SearchFilter(
                  key: 'price',
                  label: 'Price Range',
                  icon: Icons.attach_money,
                  type: FilterType.range,
                  options: {'min': 0.0, 'max': 1000.0},
                ),
              ],
            ),
          ),
          Expanded(
            child: products.when(
              data: (productList) {
                if (productList.isEmpty) {
                  return _buildEmptyState();
                }
                
                return _isGridView
                    ? _buildGridView(productList)
                    : _buildListView(productList);
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddProductDialog();
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Product'),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 80,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No products found',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first product to get started',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView(List<Product> products) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _ProductGridItem(
          product: product,
          onTap: () => _showProductDetails(product),
          onEdit: () => _showEditProductDialog(product),
          onDelete: () => _confirmDelete(product),
        );
      },
    );
  }

  Widget _buildListView(List<Product> products) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final stockLevel = ref.watch(productStockProvider(product.id));
        
        return stockLevel.when(
          data: (stock) => ProductCard(
            product: product,
            stockLevel: stock,
            showActions: true,
            onTap: () => _showProductDetails(product),
            onEdit: () => _showEditProductDialog(product),
            onDelete: () => _confirmDelete(product),
          ),
          loading: () => const CircularProgressIndicator(),
          error: (_, __) => ProductCard(
            product: product,
            showStock: false,
            showActions: true,
            onTap: () => _showProductDetails(product),
            onEdit: () => _showEditProductDialog(product),
            onDelete: () => _confirmDelete(product),
          ),
        );
      },
    );
  }

  void _showProductDetails(Product product) {
    // Navigate to product details screen
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => _ProductDetailsSheet(
          product: product,
          scrollController: scrollController,
        ),
      ),
    );
  }

  void _showAddProductDialog() {
    // Show add product dialog
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const _AddProductScreen(),
      ),
    );
  }

  void _showEditProductDialog(Product product) {
    // Show edit product dialog
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => _EditProductScreen(product: product),
      ),
    );
  }

  void _confirmDelete(Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: Text('Are you sure you want to delete ${product.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref.read(productServiceProvider).deleteProduct(product.id);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Product deleted')),
                );
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _ProductGridItem extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _ProductGridItem({
    required this.product,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant,
                ),
                child: product.imageUrl != null
                    ? Image.network(
                        product.imageUrl!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(
                          child: Icon(Icons.inventory_2, size: 48),
                        ),
                      )
                    : const Center(
                        child: Icon(Icons.inventory_2, size: 48),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: theme.textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (product.sellingPrice != null)
                    Text(
                      '\$${product.sellingPrice!.toStringAsFixed(2)}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          final stockAsync = ref.watch(
                            productStockProvider(product.id),
                          );
                          
                          return stockAsync.when(
                            data: (stock) => StockLevelBadge(
                              currentStock: stock,
                              reorderLevel: product.reorderLevel,
                              unit: product.unit,
                            ),
                            loading: () => const SizedBox(
                              width: 60,
                              height: 20,
                              child: LinearProgressIndicator(),
                            ),
                            error: (_, __) => const SizedBox.shrink(),
                          );
                        },
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          switch (value) {
                            case 'edit':
                              onEdit();
                              break;
                            case 'delete':
                              onDelete();
                              break;
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder screens - these would be implemented fully in a real app
class _ProductDetailsSheet extends StatelessWidget {
  final Product product;
  final ScrollController scrollController;

  const _ProductDetailsSheet({
    required this.product,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ListView(
        controller: scrollController,
        children: [
          Text(
            product.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          // Add more product details here
          Text('Product details would be shown here...'),
        ],
      ),
    );
  }
}

class _AddProductScreen extends StatelessWidget {
  const _AddProductScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: const Center(
        child: Text('Add product form would be here'),
      ),
    );
  }
}

class _EditProductScreen extends StatelessWidget {
  final Product product;

  const _EditProductScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Center(
        child: Text('Edit product form for ${product.name} would be here'),
      ),
    );
  }
}