import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/entities/category.dart';
import '../../../services/inventory/product_service.dart';
import '../../../services/inventory/category_service.dart';
import '../../providers/auth_provider.dart';

final productServiceProvider = Provider<ProductService>((ref) {
  return ProductService();
});

final categoryServiceProvider = Provider<CategoryService>((ref) {
  return CategoryService();
});

final productsProvider = FutureProvider.family<List<Product>, Map<String, dynamic>>((ref, filters) async {
  final org = ref.watch(currentOrganizationProvider);
  if (org == null) throw Exception('No organization');
  
  final productService = ref.watch(productServiceProvider);
  return productService.getProducts(
    org.id,
    categoryId: filters['categoryId'] as String?,
    searchQuery: filters['searchQuery'] as String?,
    lowStockOnly: filters['lowStockOnly'] as bool?,
  );
});

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final org = ref.watch(currentOrganizationProvider);
  if (org == null) throw Exception('No organization');
  
  final categoryService = ref.watch(categoryServiceProvider);
  return categoryService.getCategories(org.id);
});

class ProductsPage extends ConsumerStatefulWidget {
  const ProductsPage({super.key});

  @override
  ConsumerState<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends ConsumerState<ProductsPage> {
  final _searchController = TextEditingController();
  String? _selectedCategoryId;
  bool _showLowStockOnly = false;
  final _selectedProducts = <String>{};
  bool _isSelectionMode = false;

  Map<String, dynamic> get _filters => {
    'categoryId': _selectedCategoryId,
    'searchQuery': _searchController.text,
    'lowStockOnly': _showLowStockOnly,
  };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productsProvider(_filters));
    final categoriesAsync = ref.watch(categoriesProvider);
    final user = ref.watch(currentUserProvider);
    
    final canManageProducts = user?.hasPermission('manage_products') ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isSelectionMode 
            ? '${_selectedProducts.length} selected' 
            : 'Products'),
        leading: _isSelectionMode
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _isSelectionMode = false;
                    _selectedProducts.clear();
                  });
                },
              )
            : null,
        actions: [
          if (_isSelectionMode) ...[
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _selectedProducts.isEmpty 
                  ? null 
                  : () => _bulkDelete(),
            ),
            PopupMenuButton<String>(
              onSelected: (value) => _handleBulkAction(value),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'activate',
                  child: Text('Activate'),
                ),
                const PopupMenuItem(
                  value: 'deactivate',
                  child: Text('Deactivate'),
                ),
              ],
            ),
          ] else ...[
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () => _showFilterDialog(),
            ),
            if (canManageProducts)
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => context.push('/products/new'),
              ),
          ],
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name, SKU, or barcode...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          
          // Category filter chips
          if (categoriesAsync.hasValue && categoriesAsync.value!.isNotEmpty)
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  FilterChip(
                    label: const Text('All'),
                    selected: _selectedCategoryId == null,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategoryId = null;
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  ...categoriesAsync.value!.map((category) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(category.name),
                          selected: _selectedCategoryId == category.id,
                          onSelected: (selected) {
                            setState(() {
                              _selectedCategoryId = selected ? category.id : null;
                            });
                          },
                        ),
                      )),
                ],
              ),
            ),
          
          const SizedBox(height: 8),
          
          // Products list
          Expanded(
            child: productsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
              data: (products) {
                if (products.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _searchController.text.isNotEmpty
                              ? 'No products found'
                              : 'No products yet',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        if (canManageProducts && _searchController.text.isEmpty) ...[
                          const SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: () => context.push('/products/new'),
                            icon: const Icon(Icons.add),
                            label: const Text('Add First Product'),
                          ),
                        ],
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(productsProvider(_filters));
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return _buildProductCard(product, canManageProducts);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _showLowStockOnly
          ? FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  _showLowStockOnly = false;
                });
              },
              icon: const Icon(Icons.clear),
              label: const Text('Clear Filter'),
              backgroundColor: Theme.of(context).colorScheme.secondary,
            )
          : null,
    );
  }

  Widget _buildProductCard(Product product, bool canManage) {
    final isSelected = _selectedProducts.contains(product.id);
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: _isSelectionMode
            ? () {
                setState(() {
                  if (isSelected) {
                    _selectedProducts.remove(product.id);
                  } else {
                    _selectedProducts.add(product.id);
                  }
                });
              }
            : () => context.push('/products/${product.id}'),
        onLongPress: canManage
            ? () {
                setState(() {
                  _isSelectionMode = true;
                  _selectedProducts.add(product.id);
                });
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              if (_isSelectionMode)
                Checkbox(
                  value: isSelected,
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        _selectedProducts.add(product.id);
                      } else {
                        _selectedProducts.remove(product.id);
                      }
                    });
                  },
                ),
              
              // Product image
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: product.imageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported),
                        ),
                      )
                    : const Icon(Icons.inventory_2, size: 30),
              ),
              const SizedBox(width: 12),
              
              // Product details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'SKU: ${product.sku}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        if (product.barcode != null) ...[
                          const SizedBox(width: 8),
                          Icon(Icons.qr_code, size: 14, color: Colors.grey[600]),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _buildStockChip(product),
                        const SizedBox(width: 8),
                        if (product.sellingPrice != null)
                          Text(
                            '\$${product.sellingPrice!.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Actions
              if (!_isSelectionMode) ...[
                if (product.isLowStock)
                  Icon(
                    Icons.warning,
                    color: Colors.orange[700],
                    size: 20,
                  ),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStockChip(Product product) {
    Color backgroundColor;
    Color textColor;
    String label;
    
    if (product.isOutOfStock) {
      backgroundColor = Colors.red[100]!;
      textColor = Colors.red[900]!;
      label = 'Out of Stock';
    } else if (product.isLowStock) {
      backgroundColor = Colors.orange[100]!;
      textColor = Colors.orange[900]!;
      label = '${product.currentStock.toStringAsFixed(0)} ${product.unit}';
    } else {
      backgroundColor = Colors.green[100]!;
      textColor = Colors.green[900]!;
      label = '${product.currentStock.toStringAsFixed(0)} ${product.unit}';
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter Products',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Low Stock Only'),
                subtitle: const Text('Show only products with low stock'),
                value: _showLowStockOnly,
                onChanged: (value) {
                  setModalState(() {
                    _showLowStockOnly = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setModalState(() {
                        _showLowStockOnly = false;
                        _selectedCategoryId = null;
                      });
                    },
                    child: const Text('Reset'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: const Text('Apply'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _bulkDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Products'),
        content: Text('Are you sure you want to delete ${_selectedProducts.length} products?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      try {
        final productService = ref.read(productServiceProvider);
        await productService.bulkDeleteProducts(_selectedProducts.toList());
        
        setState(() {
          _isSelectionMode = false;
          _selectedProducts.clear();
        });
        
        ref.invalidate(productsProvider(_filters));
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Products deleted successfully')),
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

  Future<void> _handleBulkAction(String action) async {
    try {
      final productService = ref.read(productServiceProvider);
      final updates = <String, dynamic>{};
      
      switch (action) {
        case 'activate':
          updates['is_active'] = true;
          break;
        case 'deactivate':
          updates['is_active'] = false;
          break;
      }
      
      await productService.bulkUpdateProducts(_selectedProducts.toList(), updates);
      
      setState(() {
        _isSelectionMode = false;
        _selectedProducts.clear();
      });
      
      ref.invalidate(productsProvider(_filters));
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Products ${action}d successfully')),
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