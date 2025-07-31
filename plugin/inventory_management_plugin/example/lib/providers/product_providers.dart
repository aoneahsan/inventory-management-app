import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_plugin/inventory_management_plugin.dart';

// Products list provider with search and filters
final productsProvider = FutureProvider.family<List<Product>, (String, Map<String, dynamic>)>((ref, params) async {
  final (searchQuery, filters) = params;
  final productService = ref.read(productServiceProvider);
  
  // Get all products
  final products = await productService.getProducts();
  
  // Apply search filter
  var filteredProducts = products;
  if (searchQuery.isNotEmpty) {
    filteredProducts = filteredProducts.where((product) {
      return product.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
             (product.sku?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false) ||
             (product.barcode?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false);
    }).toList();
  }
  
  // Apply category filter
  if (filters.containsKey('category') && filters['category'] != null) {
    filteredProducts = filteredProducts.where((product) {
      return product.categoryId == filters['category'];
    }).toList();
  }
  
  // Apply stock status filter
  if (filters.containsKey('stock') && filters['stock'] != null) {
    final stockStatus = filters['stock'] as String;
    final stockLevels = await Future.wait(
      filteredProducts.map((product) => 
        ref.read(productStockProvider(product.id).future)
      ),
    );
    
    final productsWithStock = <Product>[];
    for (int i = 0; i < filteredProducts.length; i++) {
      final product = filteredProducts[i];
      final stock = stockLevels[i];
      
      switch (stockStatus) {
        case 'in_stock':
          if (stock > (product.reorderLevel ?? 0)) {
            productsWithStock.add(product);
          }
          break;
        case 'low_stock':
          if (stock > 0 && stock <= (product.reorderLevel ?? 0)) {
            productsWithStock.add(product);
          }
          break;
        case 'out_of_stock':
          if (stock == 0) {
            productsWithStock.add(product);
          }
          break;
      }
    }
    filteredProducts = productsWithStock;
  }
  
  // Apply price range filter
  if (filters.containsKey('price') && filters['price'] != null) {
    final priceRange = filters['price'] as Map<String, dynamic>;
    final minPrice = priceRange['min'] as double?;
    final maxPrice = priceRange['max'] as double?;
    
    filteredProducts = filteredProducts.where((product) {
      final price = product.sellingPrice ?? 0;
      if (minPrice != null && price < minPrice) return false;
      if (maxPrice != null && price > maxPrice) return false;
      return true;
    }).toList();
  }
  
  return filteredProducts;
});

// Single product stock level provider
final productStockProvider = FutureProvider.family<double, String>((ref, productId) async {
  final inventoryService = ref.read(inventoryServiceProvider);
  
  // Get current branch from auth or settings
  const currentBranchId = 'default_branch'; // This would come from auth/settings
  
  final branchInventory = await inventoryService.getBranchInventory(
    productId: productId,
    branchId: currentBranchId,
  );
  
  return branchInventory?.currentStock ?? 0.0;
});

// Product categories provider
final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final categoryService = ref.read(categoryServiceProvider);
  return categoryService.getCategories();
});

// Selected product provider (for detail views)
final selectedProductProvider = StateProvider<Product?>((ref) => null);

// Product form provider (for add/edit)
final productFormProvider = StateNotifierProvider<ProductFormNotifier, ProductFormState>((ref) {
  return ProductFormNotifier();
});

class ProductFormState {
  final String name;
  final String? sku;
  final String? barcode;
  final String? description;
  final String? categoryId;
  final String? unit;
  final double? purchasePrice;
  final double? sellingPrice;
  final double? reorderLevel;
  final double? reorderQuantity;
  final bool trackStock;
  final bool trackBatches;
  final bool trackSerialNumbers;
  final bool isActive;
  final bool isLoading;
  final String? error;

  ProductFormState({
    this.name = '',
    this.sku,
    this.barcode,
    this.description,
    this.categoryId,
    this.unit,
    this.purchasePrice,
    this.sellingPrice,
    this.reorderLevel,
    this.reorderQuantity,
    this.trackStock = true,
    this.trackBatches = false,
    this.trackSerialNumbers = false,
    this.isActive = true,
    this.isLoading = false,
    this.error,
  });

  ProductFormState copyWith({
    String? name,
    String? sku,
    String? barcode,
    String? description,
    String? categoryId,
    String? unit,
    double? purchasePrice,
    double? sellingPrice,
    double? reorderLevel,
    double? reorderQuantity,
    bool? trackStock,
    bool? trackBatches,
    bool? trackSerialNumbers,
    bool? isActive,
    bool? isLoading,
    String? error,
  }) {
    return ProductFormState(
      name: name ?? this.name,
      sku: sku ?? this.sku,
      barcode: barcode ?? this.barcode,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      unit: unit ?? this.unit,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      reorderLevel: reorderLevel ?? this.reorderLevel,
      reorderQuantity: reorderQuantity ?? this.reorderQuantity,
      trackStock: trackStock ?? this.trackStock,
      trackBatches: trackBatches ?? this.trackBatches,
      trackSerialNumbers: trackSerialNumbers ?? this.trackSerialNumbers,
      isActive: isActive ?? this.isActive,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class ProductFormNotifier extends StateNotifier<ProductFormState> {
  ProductFormNotifier() : super(ProductFormState());

  void updateName(String value) {
    state = state.copyWith(name: value);
  }

  void updateSku(String value) {
    state = state.copyWith(sku: value);
  }

  void updateBarcode(String value) {
    state = state.copyWith(barcode: value);
  }

  void updateDescription(String value) {
    state = state.copyWith(description: value);
  }

  void updateCategory(String? value) {
    state = state.copyWith(categoryId: value);
  }

  void updateUnit(String value) {
    state = state.copyWith(unit: value);
  }

  void updatePurchasePrice(double value) {
    state = state.copyWith(purchasePrice: value);
  }

  void updateSellingPrice(double value) {
    state = state.copyWith(sellingPrice: value);
  }

  void updateReorderLevel(double value) {
    state = state.copyWith(reorderLevel: value);
  }

  void updateReorderQuantity(double value) {
    state = state.copyWith(reorderQuantity: value);
  }

  void toggleTrackStock(bool value) {
    state = state.copyWith(trackStock: value);
  }

  void toggleTrackBatches(bool value) {
    state = state.copyWith(trackBatches: value);
  }

  void toggleTrackSerialNumbers(bool value) {
    state = state.copyWith(trackSerialNumbers: value);
  }

  void toggleActive(bool value) {
    state = state.copyWith(isActive: value);
  }

  void reset() {
    state = ProductFormState();
  }

  void loadProduct(Product product) {
    state = ProductFormState(
      name: product.name,
      sku: product.sku,
      barcode: product.barcode,
      description: product.description,
      categoryId: product.categoryId,
      unit: product.unit,
      purchasePrice: product.purchasePrice,
      sellingPrice: product.sellingPrice,
      reorderLevel: product.reorderLevel,
      reorderQuantity: product.reorderQuantity,
      trackStock: product.trackStock,
      trackBatches: product.trackBatches,
      trackSerialNumbers: product.trackSerialNumbers,
      isActive: product.isActive,
    );
  }

  Future<Product?> save(ProductService productService, {String? productId}) async {
    if (state.name.isEmpty) {
      state = state.copyWith(error: 'Product name is required');
      return null;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final product = Product(
        id: productId ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: state.name,
        sku: state.sku,
        barcode: state.barcode,
        description: state.description,
        categoryId: state.categoryId,
        unit: state.unit,
        purchasePrice: state.purchasePrice,
        sellingPrice: state.sellingPrice,
        reorderLevel: state.reorderLevel,
        reorderQuantity: state.reorderQuantity,
        trackStock: state.trackStock,
        trackBatches: state.trackBatches,
        trackSerialNumbers: state.trackSerialNumbers,
        isActive: state.isActive,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final savedProduct = productId != null
          ? await productService.updateProduct(product)
          : await productService.createProduct(product);

      state = state.copyWith(isLoading: false);
      return savedProduct;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to save product: $e',
      );
      return null;
    }
  }
}