import 'dart:async';
import '../../domain/entities/category.dart';
import '../../core/utils/logger.dart';
import '../database/database_service.dart';
import '../sync/sync_service.dart';

class CategoryService {
  final DatabaseService _databaseService;
  final SyncService? _syncService;
  final _categoryStreamController = StreamController<List<Category>>.broadcast();
  
  CategoryService({
    required DatabaseService databaseService,
    SyncService? syncService,
  })  : _databaseService = databaseService,
        _syncService = syncService;
  
  Stream<List<Category>> get categoriesStream => _categoryStreamController.stream;
  
  // Create a new category
  Future<Category> createCategory(Category category) async {
    try {
      final now = DateTime.now();
      final newCategory = category.copyWith(
        id: _generateCategoryId(),
        createdAt: now,
        updatedAt: now,
      );
      
      // Save to local database
      await _databaseService.insert('categories', newCategory.toJson());
      
      // Update parent category if exists
      if (newCategory.parentId != null) {
        await _addChildToParent(newCategory.parentId!, newCategory.id);
      }
      
      // Add to sync queue
      if (_syncService != null) {
        await _syncService.addToSyncQueue(
          tableName: 'categories',
          operation: 'create',
          recordId: newCategory.id,
          data: newCategory.toJson(),
        );
      }
      
      Logger.info('Category created: ${newCategory.id}');
      await _refreshCategoryStream();
      
      return newCategory;
    } catch (e) {
      Logger.error('Failed to create category', error: e);
      rethrow;
    }
  }
  
  // Update an existing category
  Future<Category> updateCategory(Category category) async {
    try {
      final oldCategory = await getCategoryById(category.id);
      if (oldCategory == null) {
        throw Exception('Category not found');
      }
      
      final updatedCategory = category.copyWith(
        updatedAt: DateTime.now(),
      );
      
      await _databaseService.transaction((txn) async {
        // Update category
        await txn.update(
          'categories',
          updatedCategory.toJson(),
          where: 'id = ?',
          whereArgs: [category.id],
        );
        
        // Handle parent change
        if (oldCategory.parentId != updatedCategory.parentId) {
          // Remove from old parent
          if (oldCategory.parentId != null) {
            await _removeChildFromParent(oldCategory.parentId!, category.id);
          }
          
          // Add to new parent
          if (updatedCategory.parentId != null) {
            await _addChildToParent(updatedCategory.parentId!, category.id);
          }
        }
      });
      
      // Add to sync queue
      if (_syncService != null) {
        await _syncService.addToSyncQueue(
          tableName: 'categories',
          operation: 'update',
          recordId: updatedCategory.id,
          data: updatedCategory.toJson(),
        );
      }
      
      Logger.info('Category updated: ${updatedCategory.id}');
      await _refreshCategoryStream();
      
      return updatedCategory;
    } catch (e) {
      Logger.error('Failed to update category', error: e);
      rethrow;
    }
  }
  
  // Delete a category
  Future<void> deleteCategory(String categoryId) async {
    try {
      final category = await getCategoryById(categoryId);
      if (category == null) {
        throw Exception('Category not found');
      }
      
      // Check if category has children
      if (category.hasChildren) {
        throw Exception('Cannot delete category with subcategories');
      }
      
      // Check if category has products
      final productCount = await _databaseService.count(
        'products',
        where: 'category_id = ?',
        whereArgs: [categoryId],
      );
      
      if (productCount > 0) {
        throw Exception('Cannot delete category with products');
      }
      
      await _databaseService.transaction((txn) async {
        // Remove from parent if exists
        if (category.parentId != null) {
          await _removeChildFromParent(category.parentId!, categoryId);
        }
        
        // Delete category
        await txn.delete(
          'categories',
          where: 'id = ?',
          whereArgs: [categoryId],
        );
      });
      
      // Add to sync queue
      if (_syncService != null) {
        await _syncService.addToSyncQueue(
          tableName: 'categories',
          operation: 'delete',
          recordId: categoryId,
          data: {'id': categoryId},
        );
      }
      
      Logger.info('Category deleted: $categoryId');
      await _refreshCategoryStream();
    } catch (e) {
      Logger.error('Failed to delete category', error: e);
      rethrow;
    }
  }
  
  // Get a single category by ID
  Future<Category?> getCategoryById(String categoryId) async {
    try {
      final result = await _databaseService.findById('categories', categoryId);
      if (result == null) return null;
      
      return Category.fromJson(result);
    } catch (e) {
      Logger.error('Failed to get category by ID', error: e);
      rethrow;
    }
  }
  
  // Get all categories for an organization
  Future<List<Category>> getCategories({
    required String organizationId,
    String? parentId,
    bool? isActive,
    String? sortBy,
    bool ascending = true,
  }) async {
    try {
      final whereConditions = <String>['organization_id = ?'];
      final whereArgs = <dynamic>[organizationId];
      
      if (parentId != null) {
        whereConditions.add('parent_id = ?');
        whereArgs.add(parentId);
      } else {
        whereConditions.add('parent_id IS NULL');
      }
      
      if (isActive != null) {
        whereConditions.add('is_active = ?');
        whereArgs.add(isActive ? 1 : 0);
      }
      
      String orderBy = sortBy ?? 'sort_order';
      orderBy += ascending ? ' ASC' : ' DESC';
      
      final results = await _databaseService.query(
        'categories',
        where: whereConditions.join(' AND '),
        whereArgs: whereArgs,
        orderBy: orderBy,
      );
      
      return results.map((json) => Category.fromJson(json)).toList();
    } catch (e) {
      Logger.error('Failed to get categories', error: e);
      rethrow;
    }
  }
  
  // Get category tree
  Future<List<Category>> getCategoryTree(String organizationId) async {
    try {
      // Get all categories
      final allCategories = await getCategories(
        organizationId: organizationId,
        sortBy: 'sort_order',
      );
      
      // Build tree structure
      final Map<String, List<Category>> childrenMap = {};
      final List<Category> rootCategories = [];
      
      for (final category in allCategories) {
        if (category.parentId == null) {
          rootCategories.add(category);
        } else {
          childrenMap.putIfAbsent(category.parentId!, () => []);
          childrenMap[category.parentId!]!.add(category);
        }
      }
      
      // Recursively build tree
      List<Category> buildTree(List<Category> categories, int level) {
        final tree = <Category>[];
        
        for (final category in categories) {
          tree.add(category);
          
          final children = childrenMap[category.id] ?? [];
          if (children.isNotEmpty) {
            tree.addAll(buildTree(children, level + 1));
          }
        }
        
        return tree;
      }
      
      return buildTree(rootCategories, 0);
    } catch (e) {
      Logger.error('Failed to get category tree', error: e);
      rethrow;
    }
  }
  
  // Get category path
  Future<List<Category>> getCategoryPath(String categoryId) async {
    try {
      final path = <Category>[];
      String? currentId = categoryId;
      
      while (currentId != null) {
        final category = await getCategoryById(currentId);
        if (category == null) break;
        
        path.insert(0, category);
        currentId = category.parentId;
      }
      
      return path;
    } catch (e) {
      Logger.error('Failed to get category path', error: e);
      rethrow;
    }
  }
  
  // Search categories
  Future<List<Category>> searchCategories(
    String query,
    String organizationId, {
    int limit = 20,
  }) async {
    try {
      final searchPattern = '%$query%';
      final results = await _databaseService.query(
        'categories',
        where: 'organization_id = ? AND (name LIKE ? OR description LIKE ?)',
        whereArgs: [organizationId, searchPattern, searchPattern],
        limit: limit,
      );
      
      return results.map((json) => Category.fromJson(json)).toList();
    } catch (e) {
      Logger.error('Failed to search categories', error: e);
      rethrow;
    }
  }
  
  // Move category to new parent
  Future<Category> moveCategory(
    String categoryId,
    String? newParentId,
  ) async {
    try {
      final category = await getCategoryById(categoryId);
      if (category == null) {
        throw Exception('Category not found');
      }
      
      // Check for circular reference
      if (newParentId != null) {
        await _checkCircularReference(categoryId, newParentId);
      }
      
      // Update category
      return await updateCategory(
        category.copyWith(parentId: newParentId),
      );
    } catch (e) {
      Logger.error('Failed to move category', error: e);
      rethrow;
    }
  }
  
  // Reorder categories
  Future<void> reorderCategories(
    List<String> categoryIds,
    String organizationId,
  ) async {
    try {
      await _databaseService.transaction((txn) async {
        for (int i = 0; i < categoryIds.length; i++) {
          await txn.update(
            'categories',
            {
              'sort_order': i,
              'updated_at': DateTime.now().millisecondsSinceEpoch,
            },
            where: 'id = ? AND organization_id = ?',
            whereArgs: [categoryIds[i], organizationId],
          );
        }
      });
      
      Logger.info('Categories reordered');
      await _refreshCategoryStream();
    } catch (e) {
      Logger.error('Failed to reorder categories', error: e);
      rethrow;
    }
  }
  
  // Private helper methods
  String _generateCategoryId() {
    return 'cat_${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}';
  }
  
  Future<void> _addChildToParent(String parentId, String childId) async {
    final parent = await getCategoryById(parentId);
    if (parent == null) return;
    
    final updatedChildren = List<String>.from(parent.childrenIds)..add(childId);
    
    await _databaseService.update(
      'categories',
      {
        'children_ids': updatedChildren,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [parentId],
    );
  }
  
  Future<void> _removeChildFromParent(String parentId, String childId) async {
    final parent = await getCategoryById(parentId);
    if (parent == null) return;
    
    final updatedChildren = List<String>.from(parent.childrenIds)
      ..remove(childId);
    
    await _databaseService.update(
      'categories',
      {
        'children_ids': updatedChildren,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [parentId],
    );
  }
  
  Future<void> _checkCircularReference(String categoryId, String newParentId) async {
    String? currentId = newParentId;
    final visited = <String>{};
    
    while (currentId != null) {
      if (visited.contains(currentId)) {
        throw Exception('Circular reference detected');
      }
      
      if (currentId == categoryId) {
        throw Exception('Cannot set category as its own descendant');
      }
      
      visited.add(currentId);
      
      final category = await getCategoryById(currentId);
      currentId = category?.parentId;
    }
  }
  
  Future<void> _refreshCategoryStream() async {
    // This would typically emit the current category list to the stream
    // Implementation depends on current context/organization
  }
  
  void dispose() {
    _categoryStreamController.close();
  }
}