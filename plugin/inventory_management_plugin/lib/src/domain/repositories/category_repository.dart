import '../entities/category.dart';
import 'base_repository.dart';

/// Repository interface for Category entity
abstract class CategoryRepository extends BaseRepository<Category> {
  /// Get root categories (no parent)
  Future<List<Category>> getRootCategories({String? organizationId});
  
  /// Get subcategories of a parent category
  Future<List<Category>> getSubcategories(String parentId);
  
  /// Get category hierarchy tree
  Future<List<CategoryNode>> getCategoryTree({String? organizationId});
  
  /// Get category with its subcategories
  Future<Category?> getCategoryWithChildren(String categoryId);
  
  /// Move category to new parent
  Future<bool> moveCategory(String categoryId, String? newParentId);
  
  /// Get category path (breadcrumb)
  Future<List<Category>> getCategoryPath(String categoryId);
  
  /// Check if category has products
  Future<bool> hasProducts(String categoryId);
  
  /// Check if category has subcategories
  Future<bool> hasSubcategories(String categoryId);
  
  /// Get product count for category
  Future<int> getProductCount(String categoryId, {bool includeSubcategories = false});
  
  /// Reorder categories
  Future<void> reorderCategories(List<CategoryOrder> orders);
}