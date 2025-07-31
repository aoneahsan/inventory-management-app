import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/value_objects/repository_types.dart';
import '../database/database_helper.dart';
import '../database/database_schema.dart';
import '../models/category_model.dart';
import 'base_repository_impl.dart';

/// Implementation of CategoryRepository
class CategoryRepositoryImpl extends BaseRepositoryImpl<Category, CategoryModel>
    implements CategoryRepository {
  
  @override
  String get tableName => DatabaseSchema.categoriesTable;
  
  @override
  CategoryModel toModel(Category entity) => CategoryModel(entity);
  
  @override
  Category fromModel(CategoryModel model) => model.category;
  
  @override
  CategoryModel fromDatabase(Map<String, dynamic> map) => 
      CategoryModel.fromDatabase(map);
  
  @override
  Future<List<Category>> getRootCategories({String? organizationId}) async {
    final results = await DatabaseHelper().query(
      tableName,
      where: organizationId != null
          ? 'parent_id IS NULL AND organization_id = ?'
          : 'parent_id IS NULL',
      whereArgs: organizationId != null ? [organizationId] : null,
      orderBy: 'sort_order ASC, name ASC',
    );
    
    return results.map((map) => fromModel(fromDatabase(map))).toList();
  }
  
  @override
  Future<List<Category>> getSubcategories(String parentId) async {
    final results = await DatabaseHelper().query(
      tableName,
      where: 'parent_id = ?',
      whereArgs: [parentId],
      orderBy: 'sort_order ASC, name ASC',
    );
    
    return results.map((map) => fromModel(fromDatabase(map))).toList();
  }
  
  @override
  Future<List<CategoryNode>> getCategoryTree({String? organizationId}) async {
    // Get all categories
    final categories = organizationId != null
        ? await getByOrganizationId(organizationId)
        : await getAll();
    
    // Build tree structure
    final Map<String?, List<Category>> childrenMap = {};
    for (final category in categories) {
      childrenMap.putIfAbsent(category.parentId, () => []).add(category);
    }
    
    // Build nodes recursively
    List<CategoryNode> buildNodes(String? parentId) {
      final children = childrenMap[parentId] ?? [];
      return children.map((category) => CategoryNode(
        id: category.id,
        name: category.name,
        parentId: category.parentId,
        children: buildNodes(category.id),
        productCount: 0, // Would need to join with products table
      )).toList();
    }
    
    return buildNodes(null);
  }
  
  @override
  Future<Category?> getCategoryWithChildren(String categoryId) async {
    final category = await getById(categoryId);
    if (category == null) return null;
    
    // For now, return category without loading children
    // In a real implementation, would load children recursively
    return category;
  }
  
  @override
  Future<bool> moveCategory(String categoryId, String? newParentId) async {
    if (newParentId != null) {
      // Check for circular reference
      String? currentId = newParentId;
      while (currentId != null) {
        if (currentId == categoryId) {
          return false; // Circular reference detected
        }
        final parent = await getById(currentId);
        currentId = parent?.parentId;
      }
    }
    
    final count = await DatabaseHelper().update(
      tableName,
      {
        'parent_id': newParentId,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [categoryId],
    );
    
    return count > 0;
  }
  
  @override
  Future<List<Category>> getCategoryPath(String categoryId) async {
    final path = <Category>[];
    String? currentId = categoryId;
    
    while (currentId != null) {
      final category = await getById(currentId);
      if (category == null) break;
      
      path.insert(0, category);
      currentId = category.parentId;
    }
    
    return path;
  }
  
  @override
  Future<bool> hasProducts(String categoryId) async {
    final count = await DatabaseHelper().count(
      DatabaseSchema.productsTable,
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );
    
    return count > 0;
  }
  
  @override
  Future<bool> hasSubcategories(String categoryId) async {
    final count = await DatabaseHelper().count(
      tableName,
      where: 'parent_id = ?',
      whereArgs: [categoryId],
    );
    
    return count > 0;
  }
  
  @override
  Future<int> getProductCount(String categoryId, {bool includeSubcategories = false}) async {
    if (!includeSubcategories) {
      return await DatabaseHelper().count(
        DatabaseSchema.productsTable,
        where: 'category_id = ?',
        whereArgs: [categoryId],
      );
    }
    
    // Get all subcategory IDs recursively
    final allCategoryIds = <String>[categoryId];
    final queue = <String>[categoryId];
    
    while (queue.isNotEmpty) {
      final currentId = queue.removeAt(0);
      final subcategories = await getSubcategories(currentId);
      
      for (final subcategory in subcategories) {
        allCategoryIds.add(subcategory.id);
        queue.add(subcategory.id);
      }
    }
    
    // Count products in all categories
    final placeholders = List.filled(allCategoryIds.length, '?').join(',');
    final results = await DatabaseHelper().rawQuery(
      'SELECT COUNT(*) as count FROM ${DatabaseSchema.productsTable} WHERE category_id IN ($placeholders)',
      allCategoryIds,
    );
    
    return results.first['count'] as int? ?? 0;
  }
  
  @override
  Future<void> reorderCategories(List<CategoryOrder> orders) async {
    await DatabaseHelper().transaction((txn) async {
      for (final order in orders) {
        await txn.update(
          tableName,
          {
            'sort_order': order.sortOrder,
            'updated_at': DateTime.now().millisecondsSinceEpoch,
          },
          where: 'id = ?',
          whereArgs: [order.categoryId],
        );
      }
    });
  }
}