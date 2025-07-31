import '../entities/product.dart';
import 'base_repository.dart';

/// Repository interface for Product entity
abstract class ProductRepository extends BaseRepository<Product> {
  /// Get products by category
  Future<List<Product>> getByCategory(String categoryId, {String? organizationId});
  
  /// Get products by brand
  Future<List<Product>> getByBrand(String brand, {String? organizationId});
  
  /// Get products by barcode
  Future<Product?> getByBarcode(String barcode, {String? organizationId});
  
  /// Get products by SKU
  Future<Product?> getBySku(String sku, {String? organizationId});
  
  /// Get active products
  Future<List<Product>> getActiveProducts({String? organizationId});
  
  /// Get products with low stock
  Future<List<Product>> getLowStockProducts({String? organizationId, double? threshold});
  
  /// Get products that need reorder
  Future<List<Product>> getReorderProducts({String? organizationId});
  
  /// Update product stock
  Future<void> updateStock(String productId, double quantity, {String? branchId});
  
  /// Get product stock across all branches
  Future<Map<String, double>> getStockByBranches(String productId);
  
  /// Search products by name or SKU
  Future<List<Product>> searchProducts(String query, {String? organizationId});
  
  /// Get products with price range
  Future<List<Product>> getByPriceRange({
    double? minPrice,
    double? maxPrice,
    String? organizationId,
  });
  
  /// Get products by supplier
  Future<List<Product>> getBySupplier(String supplierId, {String? organizationId});
  
  /// Update product prices
  Future<void> updatePrices(List<ProductPriceUpdate> updates);
  
  /// Get product movement history
  Future<List<ProductMovement>> getMovementHistory(
    String productId, {
    DateTime? startDate,
    DateTime? endDate,
    String? branchId,
  });
  
  /// Get product sales statistics
  Future<ProductStatistics> getStatistics(
    String productId, {
    DateTime? startDate,
    DateTime? endDate,
  });
}