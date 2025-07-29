import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/category.dart';
import '../../../services/inventory/category_service.dart';
import '../../providers/auth_provider.dart';

final categoryServiceProvider = Provider<CategoryService>((ref) {
  return CategoryService();
});

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final org = ref.watch(currentOrganizationProvider);
  if (org == null) throw Exception('No organization');
  
  final categoryService = ref.watch(categoryServiceProvider);
  return categoryService.getCategories(org.id);
});

final categoryProductCountsProvider = FutureProvider<Map<String, int>>((ref) async {
  final org = ref.watch(currentOrganizationProvider);
  if (org == null) throw Exception('No organization');
  
  final categoryService = ref.watch(categoryServiceProvider);
  return categoryService.getCategoryProductCounts(org.id);
});

class CategoriesPage extends ConsumerStatefulWidget {
  const CategoriesPage({super.key});

  @override
  ConsumerState<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends ConsumerState<CategoriesPage> {
  final _searchController = TextEditingController();
  bool _showSubcategories = true;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final productCountsAsync = ref.watch(categoryProductCountsProvider);
    final user = ref.watch(currentUserProvider);
    
    final canManageCategories = user?.hasPermission('manage_categories') ?? false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          IconButton(
            icon: Icon(_showSubcategories ? Icons.view_list : Icons.view_module),
            tooltip: _showSubcategories ? 'Hide Hierarchy' : 'Show Hierarchy',
            onPressed: () {
              setState(() {
                _showSubcategories = !_showSubcategories;
              });
            },
          ),
          if (canManageCategories)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showCreateCategoryDialog(),
            ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search categories...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          
          // Categories list
          Expanded(
            child: categoriesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
              data: (categories) {
                if (categories.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.category_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No categories yet',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        if (canManageCategories) ...[
                          const SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: () => _showCreateCategoryDialog(),
                            icon: const Icon(Icons.add),
                            label: const Text('Create First Category'),
                          ),
                        ],
                      ],
                    ),
                  );
                }

                final filteredCategories = _filterCategories(categories);
                
                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(categoriesProvider);
                    ref.invalidate(categoryProductCountsProvider);
                  },
                  child: _showSubcategories
                      ? _buildHierarchicalView(filteredCategories, productCountsAsync.value ?? {}, canManageCategories)
                      : _buildFlatView(filteredCategories, productCountsAsync.value ?? {}, canManageCategories),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Category> _filterCategories(List<Category> categories) {
    if (_searchController.text.isEmpty) return categories;
    
    final query = _searchController.text.toLowerCase();
    return categories.where((category) =>
        category.name.toLowerCase().contains(query) ||
        (category.description?.toLowerCase().contains(query) ?? false)
    ).toList();
  }

  Widget _buildHierarchicalView(List<Category> categories, Map<String, int> productCounts, bool canManage) {
    final rootCategories = categories.where((c) => c.isRootCategory).toList();
    rootCategories.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: rootCategories.length,
      itemBuilder: (context, index) {
        final category = rootCategories[index];
        return _buildCategoryTile(category, categories, productCounts, canManage, 0);
      },
    );
  }

  Widget _buildFlatView(List<Category> categories, Map<String, int> productCounts, bool canManage) {
    categories.sort((a, b) => a.name.compareTo(b.name));
    
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return _buildCategoryCard(category, productCounts, canManage);
      },
    );
  }

  Widget _buildCategoryTile(Category category, List<Category> allCategories, Map<String, int> productCounts, bool canManage, int depth) {
    final subcategories = allCategories.where((c) => c.parentId == category.id).toList();
    subcategories.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    
    final productCount = productCounts[category.id] ?? 0;
    
    return Column(
      children: [
        Card(
          margin: EdgeInsets.only(
            left: 16 + (depth * 20.0),
            right: 16,
            top: 4,
            bottom: 4,
          ),
          child: ListTile(
            leading: _buildCategoryIcon(category),
            title: Text(
              category.name,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: depth > 0 ? Colors.grey[700] : null,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (category.description != null)
                  Text(category.description!),
                Text('$productCount products'),
              ],
            ),
            trailing: canManage
                ? PopupMenuButton<String>(
                    onSelected: (value) => _handleCategoryAction(value, category),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: ListTile(
                          leading: Icon(Icons.edit, size: 16),
                          title: Text('Edit'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'add_subcategory',
                        child: ListTile(
                          leading: Icon(Icons.add, size: 16),
                          title: Text('Add Subcategory'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      if (productCount == 0 && subcategories.isEmpty)
                        const PopupMenuItem(
                          value: 'delete',
                          child: ListTile(
                            leading: Icon(Icons.delete, size: 16, color: Colors.red),
                            title: Text('Delete', style: TextStyle(color: Colors.red)),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                    ],
                  )
                : null,
          ),
        ),
        ...subcategories.map((subcategory) =>
            _buildCategoryTile(subcategory, allCategories, productCounts, canManage, depth + 1)),
      ],
    );
  }

  Widget _buildCategoryCard(Category category, Map<String, int> productCounts, bool canManage) {
    final productCount = productCounts[category.id] ?? 0;
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: _buildCategoryIcon(category),
        title: Text(
          category.name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (category.description != null)
              Text(category.description!),
            Text('$productCount products'),
          ],
        ),
        trailing: canManage
            ? PopupMenuButton<String>(
                onSelected: (value) => _handleCategoryAction(value, category),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: ListTile(
                      leading: Icon(Icons.edit, size: 16),
                      title: Text('Edit'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'add_subcategory',
                    child: ListTile(
                      leading: Icon(Icons.add, size: 16),
                      title: Text('Add Subcategory'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  if (productCount == 0)
                    const PopupMenuItem(
                      value: 'delete',
                      child: ListTile(
                        leading: Icon(Icons.delete, size: 16, color: Colors.red),
                        title: Text('Delete', style: TextStyle(color: Colors.red)),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                ],
              )
            : null,
      ),
    );
  }

  Widget _buildCategoryIcon(Category category) {
    if (category.icon != null) {
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: category.color != null 
              ? Color(int.parse(category.color!.substring(1, 7), radix: 16) + 0xFF000000)
              : Colors.blue[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          IconData(int.parse(category.icon!), fontFamily: 'MaterialIcons'),
          color: category.color != null 
              ? Colors.white
              : Colors.blue[700],
        ),
      );
    }
    
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.category, color: Colors.grey),
    );
  }

  void _handleCategoryAction(String action, Category category) {
    switch (action) {
      case 'edit':
        _showEditCategoryDialog(category);
        break;
      case 'add_subcategory':
        _showCreateCategoryDialog(parentCategory: category);
        break;
      case 'delete':
        _showDeleteConfirmation(category);
        break;
    }
  }

  Future<void> _showCreateCategoryDialog({Category? parentCategory}) async {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    Color selectedColor = Colors.blue;
    IconData selectedIcon = Icons.category;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(parentCategory != null ? 'Add Subcategory' : 'Create Category'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (Optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              if (parentCategory != null) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.folder),
                    const SizedBox(width: 8),
                    Text('Parent: ${parentCategory.name}'),
                  ],
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Create'),
          ),
        ],
      ),
    );

    if (result == true && nameController.text.isNotEmpty) {
      try {
        final org = ref.read(currentOrganizationProvider)!;
        final categoryService = ref.read(categoryServiceProvider);
        
        await categoryService.createCategory(
          organizationId: org.id,
          name: nameController.text.trim(),
          description: descriptionController.text.trim().isEmpty 
              ? null 
              : descriptionController.text.trim(),
          parentId: parentCategory?.id,
          color: '#${((selectedColor.a * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0')}${((selectedColor.r * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0')}${((selectedColor.g * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0')}${((selectedColor.b * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0')}',
          icon: selectedIcon.codePoint.toString(),
        );

        ref.invalidate(categoriesProvider);
        ref.invalidate(categoryProductCountsProvider);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Category created successfully')),
          );
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
      }
    }
  }

  Future<void> _showEditCategoryDialog(Category category) async {
    final nameController = TextEditingController(text: category.name);
    final descriptionController = TextEditingController(text: category.description ?? '');

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (Optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Update'),
          ),
        ],
      ),
    );

    if (result == true) {
      try {
        final categoryService = ref.read(categoryServiceProvider);
        
        await categoryService.updateCategory(category.id, {
          'name': nameController.text.trim(),
          'description': descriptionController.text.trim().isEmpty 
              ? null 
              : descriptionController.text.trim(),
        });

        ref.invalidate(categoriesProvider);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Category updated successfully')),
          );
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
      }
    }
  }

  Future<void> _showDeleteConfirmation(Category category) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Category'),
        content: Text('Are you sure you want to delete "${category.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final org = ref.read(currentOrganizationProvider)!;
        final categoryService = ref.read(categoryServiceProvider);
        
        await categoryService.deleteCategory(category.id, org.id);

        ref.invalidate(categoriesProvider);
        ref.invalidate(categoryProductCountsProvider);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Category deleted successfully')),
          );
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
      }
    }
  }
}