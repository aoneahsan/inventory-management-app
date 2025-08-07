import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/inventory_movement.dart';
import '../../providers/auth_provider.dart';
import '../../providers/barcode_provider.dart';
import '../../widgets/barcode_input_dialog.dart';
import 'products_page.dart';

final editProductProvider = FutureProvider.family<Product?, String>((ref, productId) async {
  if (productId.isEmpty) return null;
  final productService = ref.watch(productServiceProvider);
  return productService.getProduct(productId);
});

class ProductFormPage extends ConsumerStatefulWidget {
  final String? productId;
  
  const ProductFormPage({
    super.key,
    this.productId,
  });

  bool get isEditing => productId != null && productId!.isNotEmpty;

  @override
  ConsumerState<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends ConsumerState<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _skuController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _costPriceController = TextEditingController();
  final _sellingPriceController = TextEditingController();
  final _taxRateController = TextEditingController();
  final _minStockController = TextEditingController();
  final _maxStockController = TextEditingController();
  final _reorderPointController = TextEditingController();
  final _reorderQuantityController = TextEditingController();
  final _warehouseLocationController = TextEditingController();
  final _initialStockController = TextEditingController();
  
  String? _selectedCategoryId;
  String _selectedUnit = 'pcs';
  bool _isActive = true;
  bool _isLoading = false;

  final List<String> _units = [
    'pcs', 'kg', 'g', 'lbs', 'oz', 'l', 'ml', 'gal', 'm', 'cm', 'ft', 'in'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _skuController.dispose();
    _barcodeController.dispose();
    _descriptionController.dispose();
    _costPriceController.dispose();
    _sellingPriceController.dispose();
    _taxRateController.dispose();
    _minStockController.dispose();
    _maxStockController.dispose();
    _reorderPointController.dispose();
    _reorderQuantityController.dispose();
    _warehouseLocationController.dispose();
    _initialStockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final productAsync = widget.isEditing 
        ? ref.watch(editProductProvider(widget.productId!))
        : const AsyncValue.data(null);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Product' : 'Add Product'),
        actions: [
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            TextButton(
              onPressed: _saveProduct,
              child: const Text('Save'),
            ),
        ],
      ),
      body: productAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (product) {
          // Initialize form with product data if editing
          if (widget.isEditing && product != null && _nameController.text.isEmpty) {
            _initializeForm(product);
          }
          
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBasicInfoSection(categoriesAsync),
                  const SizedBox(height: 24),
                  _buildPricingSection(),
                  const SizedBox(height: 24),
                  _buildInventorySection(),
                  const SizedBox(height: 24),
                  _buildLocationSection(),
                  if (!widget.isEditing) ...[
                    const SizedBox(height: 24),
                    _buildInitialStockSection(),
                  ],
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _saveProduct,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : Text(widget.isEditing ? 'Update Product' : 'Create Product'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _initializeForm(Product product) {
    _nameController.text = product.name;
    _skuController.text = product.sku;
    _barcodeController.text = product.barcode ?? '';
    _descriptionController.text = product.description ?? '';
    _costPriceController.text = product.costPrice?.toString() ?? '';
    _sellingPriceController.text = product.sellingPrice?.toString() ?? '';
    _taxRateController.text = product.taxRate.toString();
    _minStockController.text = product.minStock.toString();
    _maxStockController.text = product.maxStock?.toString() ?? '';
    _reorderPointController.text = product.reorderPoint?.toString() ?? '';
    _reorderQuantityController.text = product.reorderQuantity?.toString() ?? '';
    _warehouseLocationController.text = product.warehouseLocation ?? '';
    _selectedCategoryId = product.categoryId;
    _selectedUnit = product.unit;
    _isActive = product.isActive;
  }

  Widget _buildBasicInfoSection(AsyncValue<List<Category>> categoriesAsync) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Information',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Product Name *',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a product name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _skuController,
                    decoration: const InputDecoration(
                      labelText: 'SKU *',
                      border: OutlineInputBorder(),
                      helperText: 'Stock Keeping Unit',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a SKU';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _barcodeController,
                    decoration: InputDecoration(
                      labelText: 'Barcode',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.qr_code_scanner),
                        onPressed: _scanBarcode,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            categoriesAsync.when(
              loading: () => const CircularProgressIndicator(),
              error: (error, _) => Text('Error loading categories: $error'),
              data: (categories) => DropdownButtonFormField<String>(
                value: _selectedCategoryId,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: [
                  const DropdownMenuItem<String>(
                    value: null,
                    child: Text('Select a category'),
                  ),
                  ...categories.map((category) => DropdownMenuItem<String>(
                        value: category.id,
                        child: Text(category.name),
                      )),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCategoryId = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<String>(
                    value: _selectedUnit,
                    decoration: const InputDecoration(
                      labelText: 'Unit *',
                      border: OutlineInputBorder(),
                    ),
                    items: _units.map((unit) => DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit.toUpperCase()),
                        )).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedUnit = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: SwitchListTile(
                    title: const Text('Active'),
                    value: _isActive,
                    onChanged: (value) {
                      setState(() {
                        _isActive = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPricingSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pricing',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _costPriceController,
                    decoration: const InputDecoration(
                      labelText: 'Cost Price',
                      border: OutlineInputBorder(),
                      prefixText: '\$',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _sellingPriceController,
                    decoration: const InputDecoration(
                      labelText: 'Selling Price',
                      border: OutlineInputBorder(),
                      prefixText: '\$',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _taxRateController,
              decoration: const InputDecoration(
                labelText: 'Tax Rate (%)',
                border: OutlineInputBorder(),
                suffixText: '%',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInventorySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Inventory Management',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _minStockController,
                    decoration: InputDecoration(
                      labelText: 'Minimum Stock *',
                      border: const OutlineInputBorder(),
                      suffixText: _selectedUnit.toUpperCase(),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter minimum stock';
                      }
                      final num = double.tryParse(value);
                      if (num == null || num < 0) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _maxStockController,
                    decoration: InputDecoration(
                      labelText: 'Maximum Stock',
                      border: const OutlineInputBorder(),
                      suffixText: _selectedUnit.toUpperCase(),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _reorderPointController,
                    decoration: InputDecoration(
                      labelText: 'Reorder Point',
                      border: const OutlineInputBorder(),
                      suffixText: _selectedUnit.toUpperCase(),
                      helperText: 'Alert when stock reaches this level',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _reorderQuantityController,
                    decoration: InputDecoration(
                      labelText: 'Reorder Quantity',
                      border: const OutlineInputBorder(),
                      suffixText: _selectedUnit.toUpperCase(),
                      helperText: 'Suggested order quantity',
                    ),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _warehouseLocationController,
              decoration: const InputDecoration(
                labelText: 'Warehouse Location',
                border: OutlineInputBorder(),
                helperText: 'e.g., Aisle A, Shelf 3, Bin 2',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialStockSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Initial Stock',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _initialStockController,
              decoration: InputDecoration(
                labelText: 'Starting Quantity',
                border: const OutlineInputBorder(),
                suffixText: _selectedUnit.toUpperCase(),
                helperText: 'Initial stock quantity (optional)',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
      ),
    );
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
        // Update barcode field
        _barcodeController.text = barcode;
        _formKey.currentState?.save();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error scanning barcode: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final org = ref.read(currentOrganizationProvider)!;
      final user = ref.read(currentUserProvider)!;
      final productService = ref.read(productServiceProvider);

      if (widget.isEditing) {
        // Update existing product
        final productData = {
          'name': _nameController.text.trim(),
          'sku': _skuController.text.trim(),
          'barcode': _barcodeController.text.trim().isEmpty ? null : _barcodeController.text.trim(),
          'description': _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim(),
          'category_id': _selectedCategoryId,
          'unit': _selectedUnit,
          'cost_price': _costPriceController.text.isEmpty ? null : double.tryParse(_costPriceController.text),
          'selling_price': _sellingPriceController.text.isEmpty ? null : double.tryParse(_sellingPriceController.text),
          'tax_rate': _taxRateController.text.isEmpty ? 0.0 : double.tryParse(_taxRateController.text) ?? 0.0,
          'min_stock': double.tryParse(_minStockController.text) ?? 0.0,
          'max_stock': _maxStockController.text.isEmpty ? null : double.tryParse(_maxStockController.text),
          'reorder_point': _reorderPointController.text.isEmpty ? null : double.tryParse(_reorderPointController.text),
          'reorder_quantity': _reorderQuantityController.text.isEmpty ? null : double.tryParse(_reorderQuantityController.text),
          'warehouse_location': _warehouseLocationController.text.trim().isEmpty ? null : _warehouseLocationController.text.trim(),
          'is_active': _isActive,
        };
        
        await productService.updateProduct(widget.productId!, productData);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product updated successfully')),
          );
          context.pop();
        }
      } else {
        // Create new product
        final product = await productService.createProduct(
          organizationId: org.id,
          name: _nameController.text.trim(),
          sku: _skuController.text.trim(),
          unit: _selectedUnit,
          barcode: _barcodeController.text.trim().isEmpty ? null : _barcodeController.text.trim(),
          description: _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim(),
          categoryId: _selectedCategoryId,
          initialStock: double.tryParse(_initialStockController.text) ?? 0.0,
          minStock: double.tryParse(_minStockController.text) ?? 0.0,
          maxStock: _maxStockController.text.isEmpty ? null : double.tryParse(_maxStockController.text),
          reorderPoint: _reorderPointController.text.isEmpty ? null : double.tryParse(_reorderPointController.text),
          reorderQuantity: _reorderQuantityController.text.isEmpty ? null : double.tryParse(_reorderQuantityController.text),
          costPrice: _costPriceController.text.isEmpty ? null : double.tryParse(_costPriceController.text),
          sellingPrice: _sellingPriceController.text.isEmpty ? null : double.tryParse(_sellingPriceController.text),
          taxRate: _taxRateController.text.isEmpty ? 0.0 : double.tryParse(_taxRateController.text) ?? 0.0,
          warehouseLocation: _warehouseLocationController.text.trim().isEmpty ? null : _warehouseLocationController.text.trim(),
        );
        
        // Add initial stock if provided
        final initialStock = double.tryParse(_initialStockController.text) ?? 0.0;
        if (initialStock > 0) {
          await productService.recordInventoryMovement(
            productId: product.id,
            type: MovementType.purchase,
            quantity: initialStock,
            reason: 'Initial stock',
            performedBy: user.id,
          );
        }
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product created successfully')),
          );
          context.pop();
        }
      }

      // Invalidate providers to refresh data
      ref.invalidate(productsProvider);
      if (widget.isEditing) {
        ref.invalidate(editProductProvider(widget.productId!));
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
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}