import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barcode_widget/barcode_widget.dart';
import '../../../domain/entities/product.dart';
import '../../../services/barcode/barcode_service.dart';
import '../../../services/inventory/product_service.dart';
import '../../../services/database/database.dart';
import '../../providers/organization_provider.dart';

final barcodeServiceProvider = Provider<BarcodeService>((ref) {
  return BarcodeService();
});

final productServiceProvider = Provider<ProductService>((ref) {
  return ProductService(database: AppDatabase.instance);
});

class BarcodeGeneratorPage extends ConsumerStatefulWidget {
  const BarcodeGeneratorPage({super.key});

  @override
  ConsumerState<BarcodeGeneratorPage> createState() => _BarcodeGeneratorPageState();
}

class _BarcodeGeneratorPageState extends ConsumerState<BarcodeGeneratorPage> {
  final Set<String> _selectedProducts = {};
  List<Product> _products = [];
  bool _isLoading = true;
  bool _isGenerating = false;
  String? _searchQuery;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final organization = ref.read(currentOrganizationProvider);
    if (organization == null) return;

    setState(() => _isLoading = true);

    try {
      final productService = ref.read(productServiceProvider);
      final products = await productService.getProducts(
        organization.id,
        searchQuery: _searchQuery,
      );
      
      setState(() {
        _products = products;
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

  Future<void> _generateBarcodes(String type) async {
    if (_selectedProducts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one product')),
      );
      return;
    }

    setState(() => _isGenerating = true);

    try {
      final barcodeService = ref.read(barcodeServiceProvider);
      final selectedProductsList = _products
          .where((p) => _selectedProducts.contains(p.id))
          .toList();

      late final Uint8List pdfData;
      late final String filename;

      switch (type) {
        case 'sheet':
          pdfData = await barcodeService.generateBarcodeSheet(
            products: selectedProductsList,
          );
          filename = 'barcode_sheet_${DateTime.now().millisecondsSinceEpoch}.pdf';
          break;
        case 'tags':
          pdfData = await barcodeService.generatePriceTags(
            products: selectedProductsList,
          );
          filename = 'price_tags_${DateTime.now().millisecondsSinceEpoch}.pdf';
          break;
        case 'single':
          if (selectedProductsList.length != 1) {
            throw Exception('Please select exactly one product for single barcode');
          }
          pdfData = await barcodeService.generateBarcode(
            product: selectedProductsList.first,
          );
          filename = 'barcode_${selectedProductsList.first.sku}.pdf';
          break;
        default:
          throw Exception('Unknown generation type');
      }

      // Show print/share dialog
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Barcode Generated'),
          content: const Text('What would you like to do with the generated barcodes?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await barcodeService.shareBarcode(pdfData, filename: filename);
              },
              child: const Text('Share'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await barcodeService.printBarcode(pdfData, jobName: filename);
              },
              child: const Text('Print'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating barcodes: $e')),
      );
    } finally {
      setState(() => _isGenerating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode Generator'),
        actions: [
          if (_selectedProducts.isNotEmpty)
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _selectedProducts.clear();
                });
              },
              icon: const Icon(Icons.clear),
              label: Text('Clear (${_selectedProducts.length})'),
            ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: _searchQuery != null
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchQuery = null;
                          });
                          _loadProducts();
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.isEmpty ? null : value;
                });
                _loadProducts();
              },
            ),
          ),

          // Action Buttons
          if (_selectedProducts.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isGenerating ? null : () => _generateBarcodes('sheet'),
                      icon: const Icon(Icons.grid_on),
                      label: const Text('Generate Sheet'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isGenerating ? null : () => _generateBarcodes('tags'),
                      icon: const Icon(Icons.label),
                      label: const Text('Price Tags'),
                    ),
                  ),
                ],
              ),
            ),
            if (_selectedProducts.length == 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isGenerating ? null : () => _generateBarcodes('single'),
                    icon: const Icon(Icons.qr_code),
                    label: const Text('Single Barcode'),
                  ),
                ),
              ),
          ],

          // Product List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _products.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.inventory_2, size: 64, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text(
                              'No products found',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _products.length,
                        itemBuilder: (context, index) {
                          final product = _products[index];
                          final isSelected = _selectedProducts.contains(product.id);

                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: ListTile(
                              leading: Checkbox(
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
                              title: Text(product.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('SKU: ${product.sku}'),
                                  if (product.barcode != null)
                                    Text('Barcode: ${product.barcode}'),
                                ],
                              ),
                              trailing: product.barcode != null || product.sku.isNotEmpty
                                  ? SizedBox(
                                      width: 100,
                                      height: 50,
                                      child: BarcodeWidget(
                                        barcode: Barcode.code128(),
                                        data: product.barcode ?? product.sku,
                                        drawText: false,
                                      ),
                                    )
                                  : null,
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    _selectedProducts.remove(product.id);
                                  } else {
                                    _selectedProducts.add(product.id);
                                  }
                                });
                              },
                            ),
                          );
                        },
                      ),
          ),

          // Loading Indicator
          if (_isGenerating)
            Container(
              color: Colors.black54,
              child: const Center(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Generating barcodes...'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}