import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/value_objects/repository_types.dart';
import '../database/database_helper.dart';
import '../database/database_schema.dart';
import '../models/product_model.dart';
import 'base_repository_impl.dart';

/// Implementation of ProductRepository
class ProductRepositoryImpl extends BaseRepositoryImpl<Product, ProductModel>
    implements ProductRepository {
  
  @override
  String get tableName => DatabaseSchema.productsTable;
  
  @override
  ProductModel toModel(Product entity) => ProductModel(entity);
  
  @override
  Product fromModel(ProductModel model) => model.product;
  
  @override
  ProductModel fromDatabase(Map<String, dynamic> map) => 
      ProductModel.fromDatabase(map);
  
  @override
  Future<List<Product>> getByCategory(String categoryId, {String? organizationId}) async {
    final results = await DatabaseHelper().query(
      tableName,
      where: organizationId != null
          ? 'category_id = ? AND organization_id = ?'
          : 'category_id = ?',
      whereArgs: organizationId != null
          ? [categoryId, organizationId]
          : [categoryId],
    );
    
    return results.map((map) => fromModel(fromDatabase(map))).toList();
  }
  
  @override
  Future<List<Product>> getByBrand(String brand, {String? organizationId}) async {
    final results = await DatabaseHelper().query(
      tableName,
      where: organizationId != null
          ? 'brand = ? AND organization_id = ?'
          : 'brand = ?',
      whereArgs: organizationId != null
          ? [brand, organizationId]
          : [brand],
    );
    
    return results.map((map) => fromModel(fromDatabase(map))).toList();
  }
  
  @override
  Future<Product?> getByBarcode(String barcode, {String? organizationId}) async {
    final results = await DatabaseHelper().query(
      tableName,
      where: organizationId != null
          ? 'barcode = ? AND organization_id = ?'
          : 'barcode = ?',
      whereArgs: organizationId != null
          ? [barcode, organizationId]
          : [barcode],
      limit: 1,
    );
    
    if (results.isEmpty) return null;
    return fromModel(fromDatabase(results.first));
  }
  
  @override
  Future<Product?> getBySku(String sku, {String? organizationId}) async {
    final results = await DatabaseHelper().query(
      tableName,
      where: organizationId != null
          ? 'sku = ? AND organization_id = ?'
          : 'sku = ?',
      whereArgs: organizationId != null
          ? [sku, organizationId]
          : [sku],
      limit: 1,
    );
    
    if (results.isEmpty) return null;
    return fromModel(fromDatabase(results.first));
  }
  
  @override
  Future<List<Product>> getActiveProducts({String? organizationId}) async {
    final results = await DatabaseHelper().query(
      tableName,
      where: organizationId != null
          ? 'is_active = 1 AND organization_id = ?'
          : 'is_active = 1',
      whereArgs: organizationId != null ? [organizationId] : null,
    );
    
    return results.map((map) => fromModel(fromDatabase(map))).toList();
  }
  
  @override
  Future<List<Product>> getLowStockProducts({String? organizationId, double? threshold}) async {
    // This requires joining with inventory data
    // For now, return products where reorder alert is enabled
    final results = await DatabaseHelper().query(
      tableName,
      where: organizationId != null
          ? 'low_stock_alert = 1 AND organization_id = ?'
          : 'low_stock_alert = 1',
      whereArgs: organizationId != null ? [organizationId] : null,
    );
    
    return results.map((map) => fromModel(fromDatabase(map))).toList();
  }
  
  @override
  Future<List<Product>> getReorderProducts({String? organizationId}) async {
    // This requires joining with inventory data to check actual stock levels
    // For now, return products with reorder point set
    final results = await DatabaseHelper().query(
      tableName,
      where: organizationId != null
          ? 'reorder_point > 0 AND organization_id = ?'
          : 'reorder_point > 0',
      whereArgs: organizationId != null ? [organizationId] : null,
    );
    
    return results.map((map) => fromModel(fromDatabase(map))).toList();
  }
  
  @override
  Future<void> updateStock(String productId, double quantity, {String? branchId}) async {
    // Stock updates should be done through inventory movements
    // This is a placeholder implementation
    throw UnimplementedError('Stock updates should be done through InventoryMovementService');
  }
  
  @override
  Future<Map<String, double>> getStockByBranches(String productId) async {
    // This requires joining with branch inventory table
    final query = '''
      SELECT branch_id, SUM(quantity) as total_quantity
      FROM ${DatabaseSchema.branchInventoryTable}
      WHERE product_id = ?
      GROUP BY branch_id
    ''';
    
    final results = await DatabaseHelper().rawQuery(query, [productId]);
    
    final stockMap = <String, double>{};
    for (final row in results) {
      stockMap[row['branch_id'] as String] = (row['total_quantity'] as num).toDouble();
    }
    
    return stockMap;
  }
  
  @override
  Future<List<Product>> searchProducts(String query, {String? organizationId}) async {
    final results = await DatabaseHelper().query(
      tableName,
      where: organizationId != null
          ? 'organization_id = ? AND (name LIKE ? OR sku LIKE ? OR barcode LIKE ?)'
          : '(name LIKE ? OR sku LIKE ? OR barcode LIKE ?)',
      whereArgs: organizationId != null
          ? [organizationId, '%$query%', '%$query%', '%$query%']
          : ['%$query%', '%$query%', '%$query%'],
    );
    
    return results.map((map) => fromModel(fromDatabase(map))).toList();
  }
  
  @override
  Future<List<Product>> getByPriceRange({
    double? minPrice,
    double? maxPrice,
    String? organizationId,
  }) async {
    String where = '';
    List<dynamic> whereArgs = [];
    
    if (organizationId != null) {
      where = 'organization_id = ?';
      whereArgs.add(organizationId);
    }
    
    if (minPrice != null) {
      where += where.isEmpty ? '' : ' AND ';
      where += 'selling_price >= ?';
      whereArgs.add(minPrice);
    }
    
    if (maxPrice != null) {
      where += where.isEmpty ? '' : ' AND ';
      where += 'selling_price <= ?';
      whereArgs.add(maxPrice);
    }
    
    final results = await DatabaseHelper().query(
      tableName,
      where: where.isEmpty ? null : where,
      whereArgs: whereArgs.isEmpty ? null : whereArgs,
    );
    
    return results.map((map) => fromModel(fromDatabase(map))).toList();
  }
  
  @override
  Future<List<Product>> getBySupplier(String supplierId, {String? organizationId}) async {
    // This requires a many-to-many relationship table or querying through purchase orders
    // For now, return empty list
    return [];
  }
  
  @override
  Future<void> updatePrices(List<ProductPriceUpdate> updates) async {
    await DatabaseHelper().transaction((txn) async {
      for (final update in updates) {
        final values = <String, dynamic>{};
        
        if (update.purchasePrice != null) {
          values['purchase_price'] = update.purchasePrice;
        }
        
        if (update.sellingPrice != null) {
          values['selling_price'] = update.sellingPrice;
        }
        
        values['updated_at'] = DateTime.now().millisecondsSinceEpoch;
        
        await txn.update(
          tableName,
          values,
          where: 'id = ?',
          whereArgs: [update.productId],
        );
      }
    });
  }
  
  @override
  Future<List<ProductMovement>> getMovementHistory(
    String productId, {
    DateTime? startDate,
    DateTime? endDate,
    String? branchId,
  }) async {
    // Query inventory movements table
    String where = 'product_id = ?';
    List<dynamic> whereArgs = [productId];
    
    if (startDate != null) {
      where += ' AND created_at >= ?';
      whereArgs.add(startDate.millisecondsSinceEpoch);
    }
    
    if (endDate != null) {
      where += ' AND created_at <= ?';
      whereArgs.add(endDate.millisecondsSinceEpoch);
    }
    
    if (branchId != null) {
      where += ' AND branch_id = ?';
      whereArgs.add(branchId);
    }
    
    final results = await DatabaseHelper().query(
      DatabaseSchema.inventoryMovementsTable,
      where: where,
      whereArgs: whereArgs,
      orderBy: 'created_at DESC',
    );
    
    return results.map((map) => ProductMovement(
      id: map['id'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      type: map['movement_type'] as String,
      quantity: (map['quantity'] as num).toDouble(),
      reference: map['reference_id'] as String?,
      branchId: map['branch_id'] as String?,
    )).toList();
  }
  
  @override
  Future<ProductStatistics> getStatistics(
    String productId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    // This would require complex queries joining multiple tables
    // For now, return default statistics
    return ProductStatistics(
      totalSold: 0,
      totalRevenue: 0,
      averagePrice: 0,
      profitMargin: 0,
      daysInStock: 0,
      turnoverRate: 0,
    );
  }
}