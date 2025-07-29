import '../../domain/entities/category.dart';
import '../../core/errors/exceptions.dart';
import '../database/database.dart';

class CategoryService {
  final AppDatabase _database;

  CategoryService({
    AppDatabase? database,
  })  : _database = database ?? AppDatabase.instance;

  Future<List<Category>> getCategories(String organizationId) async {
    try {
      final categories = await _database.getCategories(organizationId);
      return categories.map((c) => Category.fromJson(c)).toList();
    } catch (e) {
      throw BusinessException(message: 'Failed to load categories: $e');
    }
  }

  Future<Category> createCategory({
    required String organizationId,
    required String name,
    String? description,
    String? parentId,
    String? color,
    String? icon,
    int sortOrder = 0,
  }) async {
    try {
      // Check for duplicate name at same level
      final existing = await getCategories(organizationId);
      final duplicates = existing.where((c) => 
        c.name.toLowerCase() == name.toLowerCase() && 
        c.parentId == parentId
      );
      
      if (duplicates.isNotEmpty) {
        throw BusinessException(message: 'Category "$name" already exists at this level');
      }

      // Validate parent exists if provided
      if (parentId != null) {
        existing.firstWhere(
          (c) => c.id == parentId,
          orElse: () => throw BusinessException(message: 'Parent category not found'),
        );
      }

      final now = DateTime.now();
      final category = Category(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        organizationId: organizationId,
        name: name,
        description: description,
        parentId: parentId,
        color: color,
        icon: icon,
        sortOrder: sortOrder,
        createdAt: now,
        updatedAt: now,
      );

      final categoryId = await _database.createCategory(category.toJson());
      
      // Add to sync queue
      await _database.addToSyncQueue(
        'categories',
        'create',
        categoryId,
        category.toJson(),
      );

      return category.copyWith(id: categoryId);
    } catch (e) {
      if (e is BusinessException) rethrow;
      throw BusinessException(message: 'Failed to create category: $e');
    }
  }

  Future<void> updateCategory(
    String categoryId,
    Map<String, dynamic> updates,
  ) async {
    try {
      updates['updated_at'] = DateTime.now().toIso8601String();
      
      // If updating parent, validate it exists and prevent circular reference
      if (updates.containsKey('parent_id') && updates['parent_id'] != null) {
        await _validateParentChange(categoryId, updates['parent_id']);
      }
      
      // Update in database
      await _database.updateCategory(categoryId, updates);
      
      // Add to sync queue
      await _database.addToSyncQueue(
        'categories',
        'update',
        categoryId,
        updates,
      );
    } catch (e) {
      if (e is BusinessException) rethrow;
      throw BusinessException(message: 'Failed to update category: $e');
    }
  }

  Future<void> deleteCategory(String categoryId, String organizationId) async {
    try {
      // Check if category has products
      final products = await _database.getProducts(
        organizationId,
        categoryId: categoryId,
      );
      
      if (products.isNotEmpty) {
        throw BusinessException(message: 'Cannot delete category with products. Please reassign products first.');
      }

      // Check if category has subcategories
      final categories = await getCategories(organizationId);
      final hasChildren = categories.any((c) => c.parentId == categoryId);
      
      if (hasChildren) {
        throw BusinessException(message: 'Cannot delete category with subcategories. Please delete subcategories first.');
      }

      // Soft delete
      await updateCategory(categoryId, {'is_active': false});
    } catch (e) {
      if (e is BusinessException) rethrow;
      throw BusinessException(message: 'Failed to delete category: $e');
    }
  }

  Future<void> reorderCategories(
    List<String> categoryIds,
    String organizationId,
  ) async {
    try {
      for (int i = 0; i < categoryIds.length; i++) {
        await updateCategory(categoryIds[i], {'sort_order': i});
      }
    } catch (e) {
      throw BusinessException(message: 'Failed to reorder categories: $e');
    }
  }

  Future<List<Category>> getCategoryHierarchy(String organizationId) async {
    try {
      final allCategories = await getCategories(organizationId);
      
      // Build hierarchy
      final rootCategories = allCategories.where((c) => c.isRootCategory).toList();
      rootCategories.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
      
      return rootCategories;
    } catch (e) {
      throw BusinessException(message: 'Failed to get category hierarchy: $e');
    }
  }

  Future<List<Category>> getCategoryPath(String categoryId, String organizationId) async {
    try {
      final categories = await getCategories(organizationId);
      final path = <Category>[];
      
      Category? current = categories.firstWhere(
        (c) => c.id == categoryId,
        orElse: () => throw BusinessException(message: 'Category not found'),
      );
      
      while (current != null) {
        path.insert(0, current);
        if (current.parentId != null) {
          current = categories.firstWhere(
            (c) => c.id == current!.parentId,
            orElse: () => throw BusinessException(message: 'Parent category not found'),
          );
        } else {
          current = null;
        }
      }
      
      return path;
    } catch (e) {
      if (e is BusinessException) rethrow;
      throw BusinessException(message: 'Failed to get category path: $e');
    }
  }

  Future<void> _validateParentChange(String categoryId, String newParentId) async {
    // Prevent setting self as parent
    if (categoryId == newParentId) {
      throw BusinessException(message: 'Category cannot be its own parent');
    }
    
    // Prevent circular references
    final categories = await _database.getCategories(''); // Get all categories
    final visited = <String>{};
    String? currentId = newParentId;
    
    while (currentId != null) {
      if (visited.contains(currentId)) {
        throw BusinessException(message: 'Circular reference detected');
      }
      if (currentId == categoryId) {
        throw BusinessException(message: 'Cannot set descendant as parent');
      }
      
      visited.add(currentId);
      
      final current = categories.firstWhere(
        (c) => c['id'] == currentId,
        orElse: () => <String, dynamic>{},
      );
      
      currentId = current['parent_id'] as String?;
    }
  }

  Future<Map<String, int>> getCategoryProductCounts(String organizationId) async {
    try {
      final products = await _database.getProducts(organizationId);
      final counts = <String, int>{};
      
      for (final product in products) {
        final categoryId = product['category_id'] as String?;
        if (categoryId != null) {
          counts[categoryId] = (counts[categoryId] ?? 0) + 1;
        }
      }
      
      return counts;
    } catch (e) {
      throw BusinessException(message: 'Failed to get category product counts: $e');
    }
  }
}