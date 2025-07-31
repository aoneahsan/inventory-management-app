import 'dart:async';
import '../../domain/entities/product.dart';
import '../../core/utils/logger.dart';
import '../database/database_service.dart';
import '../sync/sync_service.dart';

class ProductService {
  final DatabaseService _databaseService;
  final SyncService? _syncService;
  final _productStreamController = StreamController<List<Product>>.broadcast();
  
  ProductService({
    required DatabaseService databaseService,
    SyncService? syncService,
  })  : _databaseService = databaseService,
        _syncService = syncService;
  
  Stream<List<Product>> get productsStream => _productStreamController.stream;
  
  // Create a new product
  Future<Product> createProduct(Product product) async {
    try {
      final now = DateTime.now();
      final newProduct = product.copyWith(
        id: _generateProductId(),
        createdAt: now,
        updatedAt: now,
      );
      
      // Save to local database
      await _databaseService.insert('products', newProduct.toJson());
      
      // Add to sync queue if sync is enabled
      if (_syncService != null) {
        await _syncService.addToSyncQueue(
          tableName: 'products',
          operation: 'create',
          recordId: newProduct.id,
          data: newProduct.toJson(),
        );
      }
      
      Logger.info('Product created: ${newProduct.id}');
      await _refreshProductStream();
      
      return newProduct;
    } catch (e) {
      Logger.error('Failed to create product', error: e);
      rethrow;
    }
  }
  
  // Update an existing product
  Future<Product> updateProduct(Product product) async {
    try {
      final updatedProduct = product.copyWith(
        updatedAt: DateTime.now(),
      );
      
      await _databaseService.update(
        'products',
        updatedProduct.toJson(),
        where: 'id = ?',
        whereArgs: [product.id],
      );
      
      // Add to sync queue
      if (_syncService != null) {
        await _syncService.addToSyncQueue(
          tableName: 'products',
          operation: 'update',
          recordId: updatedProduct.id,
          data: updatedProduct.toJson(),
        );
      }
      
      Logger.info('Product updated: ${updatedProduct.id}');
      await _refreshProductStream();
      
      return updatedProduct;
    } catch (e) {
      Logger.error('Failed to update product', error: e);
      rethrow;
    }
  }
  
  // Delete a product
  Future<void> deleteProduct(String productId) async {
    try {
      // Check if product is used in any transactions
      final canDelete = await _canDeleteProduct(productId);
      if (!canDelete) {
        throw Exception('Product cannot be deleted as it has associated transactions');
      }
      
      await _databaseService.delete(
        'products',
        where: 'id = ?',
        whereArgs: [productId],
      );
      
      // Add to sync queue
      if (_syncService != null) {
        await _syncService.addToSyncQueue(
          tableName: 'products',
          operation: 'delete',
          recordId: productId,
          data: {'id': productId},
        );
      }
      
      Logger.info('Product deleted: $productId');
      await _refreshProductStream();
    } catch (e) {
      Logger.error('Failed to delete product', error: e);
      rethrow;
    }
  }
  
  // Get a single product by ID
  Future<Product?> getProductById(String productId) async {
    try {
      final result = await _databaseService.findById('products', productId);
      if (result == null) return null;
      
      return Product.fromJson(result);
    } catch (e) {
      Logger.error('Failed to get product by ID', error: e);
      rethrow;
    }
  }
  
  // Get product by SKU
  Future<Product?> getProductBySku(String sku, String organizationId) async {
    try {
      final results = await _databaseService.query(
        'products',
        where: 'sku = ? AND organization_id = ?',
        whereArgs: [sku, organizationId],
        limit: 1,
      );
      
      if (results.isEmpty) return null;
      return Product.fromJson(results.first);
    } catch (e) {
      Logger.error('Failed to get product by SKU', error: e);
      rethrow;
    }
  }
  
  // Get product by barcode
  Future<Product?> getProductByBarcode(String barcode) async {
    try {
      final results = await _databaseService.query(
        'products',
        where: 'barcode = ?',
        whereArgs: [barcode],
        limit: 1,
      );
      
      if (results.isEmpty) return null;
      return Product.fromJson(results.first);
    } catch (e) {
      Logger.error('Failed to get product by barcode', error: e);
      rethrow;
    }
  }
  
  // Get all products for an organization
  Future<List<Product>> getProducts({
    required String organizationId,
    String? categoryId,
    String? supplierId,
    bool? isActive,
    String? searchQuery,
    String? sortBy,
    bool ascending = true,
    int? limit,
    int? offset,
  }) async {
    try {
      final whereConditions = <String>['organization_id = ?'];
      final whereArgs = <dynamic>[organizationId];
      
      if (categoryId != null) {
        whereConditions.add('category_id = ?');
        whereArgs.add(categoryId);
      }
      
      if (supplierId != null) {
        whereConditions.add('supplier_id = ?');
        whereArgs.add(supplierId);
      }
      
      if (isActive != null) {
        whereConditions.add('is_active = ?');
        whereArgs.add(isActive ? 1 : 0);
      }
      
      if (searchQuery != null && searchQuery.isNotEmpty) {
        whereConditions.add(
          '(name LIKE ? OR sku LIKE ? OR barcode LIKE ? OR description LIKE ?)'
        );
        final searchPattern = '%$searchQuery%';
        whereArgs.addAll([searchPattern, searchPattern, searchPattern, searchPattern]);
      }
      
      String? orderBy;
      if (sortBy != null) {
        orderBy = '$sortBy ${ascending ? 'ASC' : 'DESC'}';
      }
      
      final results = await _databaseService.query(
        'products',
        where: whereConditions.join(' AND '),
        whereArgs: whereArgs,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
      
      return results.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      Logger.error('Failed to get products', error: e);
      rethrow;
    }
  }
  
  // Get low stock products
  Future<List<Product>> getLowStockProducts(String organizationId) async {
    try {
      final results = await _databaseService.query(
        'products',
        where: 'organization_id = ? AND stock_quantity <= reorder_point AND track_inventory = 1',
        whereArgs: [organizationId],
        orderBy: 'stock_quantity ASC',
      );
      
      return results.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      Logger.error('Failed to get low stock products', error: e);
      rethrow;
    }
  }
  
  // Get out of stock products
  Future<List<Product>> getOutOfStockProducts(String organizationId) async {
    try {
      final results = await _databaseService.query(
        'products',
        where: 'organization_id = ? AND stock_quantity <= 0 AND track_inventory = 1',
        whereArgs: [organizationId],
        orderBy: 'name ASC',
      );
      
      return results.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      Logger.error('Failed to get out of stock products', error: e);
      rethrow;
    }
  }
  
  // Update product stock
  Future<void> updateProductStock(
    String productId,
    double newQuantity, {
    String? reason,
    String? referenceId,
  }) async {
    try {
      await _databaseService.transaction((txn) async {
        // Get current product
        final product = await getProductById(productId);
        if (product == null) {
          throw Exception('Product not found');
        }
        
        final oldQuantity = product.stockQuantity;
        final difference = newQuantity - oldQuantity;
        
        // Update product stock
        await txn.update(
          'products',
          {
            'stock_quantity': newQuantity,
            'updated_at': DateTime.now().millisecondsSinceEpoch,
          },
          where: 'id = ?',
          whereArgs: [productId],
        );
        
        // Create inventory movement record
        await txn.insert('inventory_movements', {
          'id': _generateMovementId(),
          'organization_id': product.organizationId,
          'product_id': productId,
          'movement_type': difference > 0 ? 'stock_in' : 'stock_out',
          'quantity': difference.abs(),
          'reference_type': 'manual_adjustment',
          'reference_id': referenceId,
          'reason': reason,
          'performed_by': 'system', // Should be current user ID
          'performed_at': DateTime.now().millisecondsSinceEpoch,
          'created_at': DateTime.now().millisecondsSinceEpoch,
        });
      });
      
      // Add to sync queue
      if (_syncService != null) {
        await _syncService.addToSyncQueue(
          tableName: 'products',
          operation: 'stock_update',
          recordId: productId,
          data: {
            'product_id': productId,
            'new_quantity': newQuantity,
            'reason': reason,
          },
        );
      }
      
      Logger.info('Product stock updated: $productId');
      await _refreshProductStream();
    } catch (e) {
      Logger.error('Failed to update product stock', error: e);
      rethrow;
    }
  }
  
  // Bulk import products
  Future<List<Product>> bulkImportProducts(
    List<Product> products,
    String organizationId,
  ) async {
    try {
      final importedProducts = <Product>[];
      
      await _databaseService.transaction((txn) async {
        for (final product in products) {
          final now = DateTime.now();
          final newProduct = product.copyWith(
            id: _generateProductId(),
            organizationId: organizationId,
            createdAt: now,
            updatedAt: now,
          );
          
          await txn.insert('products', newProduct.toJson());
          importedProducts.add(newProduct);
        }
      });
      
      // Add to sync queue
      if (_syncService != null) {
        for (final product in importedProducts) {
          await _syncService.addToSyncQueue(
            tableName: 'products',
            operation: 'create',
            recordId: product.id,
            data: product.toJson(),
          );
        }
      }
      
      Logger.info('Bulk imported ${importedProducts.length} products');
      await _refreshProductStream();
      
      return importedProducts;
    } catch (e) {
      Logger.error('Failed to bulk import products', error: e);
      rethrow;
    }
  }
  
  // Search products
  Future<List<Product>> searchProducts(
    String query,
    String organizationId, {
    int limit = 20,
  }) async {
    try {
      final searchPattern = '%$query%';
      final results = await _databaseService.query(
        'products',
        where: 'organization_id = ? AND (name LIKE ? OR sku LIKE ? OR barcode LIKE ?)',
        whereArgs: [organizationId, searchPattern, searchPattern, searchPattern],
        limit: limit,
      );
      
      return results.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      Logger.error('Failed to search products', error: e);
      rethrow;
    }
  }
  
  // Get product count
  Future<int> getProductCount(String organizationId) async {
    try {
      return await _databaseService.count(
        'products',
        where: 'organization_id = ?',
        whereArgs: [organizationId],
      );
    } catch (e) {
      Logger.error('Failed to get product count', error: e);
      rethrow;
    }
  }
  
  // Private helper methods
  String _generateProductId() {
    return 'prod_${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}';
  }
  
  String _generateMovementId() {
    return 'mov_${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}';
  }
  
  Future<bool> _canDeleteProduct(String productId) async {
    // Check if product is used in sales
    final salesCount = await _databaseService.count(
      'sale_items',
      where: 'product_id = ?',
      whereArgs: [productId],
    );
    
    // Check if product is used in purchase orders
    final purchaseCount = await _databaseService.count(
      'purchase_order_items',
      where: 'product_id = ?',
      whereArgs: [productId],
    );
    
    return salesCount == 0 && purchaseCount == 0;
  }
  
  Future<void> _refreshProductStream() async {
    // This would typically emit the current product list to the stream
    // Implementation depends on current context/organization
  }
  
  void dispose() {
    _productStreamController.close();
  }
}