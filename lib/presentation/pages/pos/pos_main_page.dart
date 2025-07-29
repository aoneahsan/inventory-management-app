import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/product.dart';
import '../../../services/pos/pos_service.dart';
import '../../../services/inventory/product_service.dart';
import '../../../services/database/database.dart';
import '../../../services/sync/sync_service.dart';
import '../../providers/auth_provider.dart';
import '../../../services/barcode/barcode_scanner_service.dart';
import '../../widgets/barcode_input_dialog.dart';
import '../../widgets/barcode_keyboard_listener.dart';
import '../../widgets/offline_sync_indicator.dart';

final posServiceProvider = Provider<POSService>((ref) {
  return POSService(
    database: AppDatabase.instance,
    productService: ref.watch(productServiceProvider),
    syncService: ref.watch(syncServiceProvider),
  );
});

final productServiceProvider = Provider<ProductService>((ref) {
  return ProductService(
    database: AppDatabase.instance,
  );
});

final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(database: AppDatabase.instance);
});

final barcodeScannerProvider = Provider<BarcodeScannerService>((ref) {
  return BarcodeScannerServiceFactory.create();
});

class POSMainPage extends ConsumerStatefulWidget {
  const POSMainPage({super.key});

  @override
  ConsumerState<POSMainPage> createState() => _POSMainPageState();
}

class _POSMainPageState extends ConsumerState<POSMainPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  String? _selectedCategory;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final currentOrg = ref.read(currentOrganizationProvider);
    if (currentOrg == null) return;

    try {
      final productService = ref.read(productServiceProvider);
      final products = await productService.getProducts(
        currentOrg.id,
      );
      
      setState(() {
        _products = products;
        _filteredProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading products: $e')),
        );
      }
    }
  }

  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty && _selectedCategory == null) {
        _filteredProducts = _products;
      } else {
        _filteredProducts = _products.where((product) {
          final matchesSearch = query.isEmpty ||
              product.name.toLowerCase().contains(query.toLowerCase()) ||
              product.sku.toLowerCase().contains(query.toLowerCase()) ||
              (product.barcode?.toLowerCase().contains(query.toLowerCase()) ?? false);
          
          final matchesCategory = _selectedCategory == null ||
              product.categoryId == _selectedCategory;
          
          return matchesSearch && matchesCategory;
        }).toList();
      }
    });
  }

  Future<void> _scanBarcode() async {
    try {
      final barcodeScanner = ref.read(barcodeScannerProvider);
      String? barcode;

      if (barcodeScanner.isSupported) {
        // Use native barcode scanner on mobile
        barcode = await barcodeScanner.scanBarcode();
      } else {
        // Show manual input dialog on web
        barcode = await showBarcodeInputDialog(context);
      }

      if (barcode != null && barcode.isNotEmpty) {
        // Update search field with barcode
        _searchController.text = barcode;
        _filterProducts(barcode);

        // Search for product with this barcode
        final product = _products.firstWhere(
          (p) => p.barcode == barcode,
          orElse: () => throw Exception('Product not found'),
        );

        // Add to cart
        final posService = ref.read(posServiceProvider);
        posService.addToCart(product);
        setState(() {});

        // Clear search after adding to cart
        _searchController.clear();
        _filterProducts('');

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Added ${product.name} to cart'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().contains('not found') 
                ? 'Product with this barcode not found' 
                : 'Error scanning barcode: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _handleBarcodeFromKeyboard(String barcode) {
    // Check if the search field is not focused
    if (!FocusScope.of(context).hasFocus) {
      _processBarcode(barcode);
    }
  }

  void _processBarcode(String barcode) {
    try {
      // Search for product with this barcode
      final product = _products.firstWhere(
        (p) => p.barcode == barcode,
        orElse: () => throw Exception('Product not found'),
      );

      // Add to cart
      final posService = ref.read(posServiceProvider);
      posService.addToCart(product);
      setState(() {});

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Added ${product.name} to cart'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product with barcode $barcode not found'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final posService = ref.watch(posServiceProvider);
    final cartItems = posService.cartItems;

    return BarcodeKeyboardListener(
      onBarcodeScanned: _handleBarcodeFromKeyboard,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Point of Sale'),
          actions: [
            IconButton(
              icon: const Icon(Icons.analytics),
              onPressed: () {
                Navigator.pushNamed(context, '/pos/reports');
              },
              tooltip: 'POS Reports',
            ),
            OfflineSyncIndicator(posService: posService),
            const SizedBox(width: 16),
          ],
        ),
        body: Row(
        children: [
          // Product Grid
          Expanded(
            flex: 2,
            child: Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.qr_code_scanner),
                        onPressed: () async {
                          await _scanBarcode();
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: _filterProducts,
                  ),
                ),
                
                // Product Grid
                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : GridView.builder(
                          padding: const EdgeInsets.all(8),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: _filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = _filteredProducts[index];
                            return Card(
                              child: InkWell(
                                onTap: () {
                                  posService.addToCart(product);
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        product.name,
                                        style: Theme.of(context).textTheme.titleMedium,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '\$${(product.sellingPrice ?? 0).toStringAsFixed(2)}',
                                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Stock: ${product.currentStock.toInt()}',
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
          
          // Cart Section
          Container(
            width: 400,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(-2, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                // Cart Header
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cart',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextButton(
                        onPressed: cartItems.isEmpty
                            ? null
                            : () {
                                posService.clearCart();
                                setState(() {});
                              },
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                ),
                
                // Cart Items
                Expanded(
                  child: cartItems.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                size: 64,
                                color: Theme.of(context).disabledColor,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Cart is empty',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).disabledColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final item = cartItems[index];
                            return ListTile(
                              title: Text(item.productName),
                              subtitle: Text(
                                '\$${item.unitPrice.toStringAsFixed(2)} x ${item.quantity}',
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '\$${item.totalAmount.toStringAsFixed(2)}',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      posService.updateQuantity(item.productId, 0);
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
                
                // Cart Summary
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildSummaryRow('Subtotal', posService.subtotal),
                      if (posService.discountTotal > 0)
                        _buildSummaryRow('Discount', -posService.discountTotal),
                      if (posService.taxTotal > 0)
                        _buildSummaryRow('Tax', posService.taxTotal),
                      const Divider(),
                      _buildSummaryRow(
                        'Total',
                        posService.total,
                        isTotal: true,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: cartItems.isEmpty
                              ? null
                              : () {
                                  // Navigate to checkout
                                  Navigator.pushNamed(
                                    context,
                                    '/pos/checkout',
                                  );
                                },
                          child: const Text('Checkout'),
                        ),
                      ),
                    ],
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

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    )
                : Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: isTotal
                ? Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    )
                : Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}