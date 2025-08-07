import '../../domain/entities/composite_item.dart';
import '../database/database.dart';
import '../branch/branch_service.dart';
import '../sync/sync_service.dart';
import 'product_service.dart';

class CompositeItemService {
  final AppDatabase _database = AppDatabase.instance;
  final BranchService _branchService = BranchService();
  final ProductService _productService;
  final SyncService _syncService = SyncService();
  
  CompositeItemService({ProductService? productService}) 
    : _productService = productService ?? ProductService();

  Future<List<CompositeItem>> getCompositeItems(
    String organizationId, {
    bool? activeOnly,
    String? searchQuery,
  }) async {
    final db = await _database.database;
    String query = 'SELECT * FROM composite_items WHERE organization_id = ?';
    List<dynamic> args = [organizationId];

    if (activeOnly == true) {
      query += ' AND is_active = 1';
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query += ' AND (name LIKE ? OR code LIKE ?)';
      final pattern = '%$searchQuery%';
      args.addAll([pattern, pattern]);
    }

    query += ' ORDER BY name ASC';

    final results = await db.rawQuery(query, args);
    final items = results.map((map) => CompositeItem.fromMap(map)).toList();

    // Load components for each item
    for (int i = 0; i < items.length; i++) {
      final components = await getComponents(items[i].id);
      items[i] = items[i].copyWith(components: components);
    }

    return items;
  }

  Future<CompositeItem?> getCompositeItem(String itemId) async {
    final db = await _database.database;
    final results = await db.query(
      'composite_items',
      where: 'id = ?',
      whereArgs: [itemId],
    );

    if (results.isEmpty) return null;
    
    final item = CompositeItem.fromMap(results.first);
    final components = await getComponents(itemId);
    return item.copyWith(components: components);
  }

  Future<List<CompositeItemComponent>> getComponents(String compositeItemId) async {
    final db = await _database.database;
    final results = await db.query(
      'composite_item_components',
      where: 'composite_item_id = ?',
      whereArgs: [compositeItemId],
    );

    return results.map((map) => CompositeItemComponent.fromMap(map)).toList();
  }

  Future<String> createCompositeItem(
    CompositeItem item,
    List<CompositeItemComponent> components,
  ) async {
    final db = await _database.database;
    final id = item.id.isEmpty
        ? DateTime.now().millisecondsSinceEpoch.toString()
        : item.id;

    await db.transaction((txn) async {
      // Create composite item
      await txn.insert(
        'composite_items',
        item.copyWith(id: id).toMap(),
      );

      // Create components
      for (final component in components) {
        await txn.insert(
          'composite_item_components',
          component.copyWith(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            compositeItemId: id,
          ).toMap(),
        );
      }

      // Add to sync queue
      await _syncService.addToQueue(
        'composite_items',
        id,
        'create',
        item.toMap(),
      );
    });

    return id;
  }

  Future<void> updateCompositeItem(
    String itemId,
    CompositeItem item,
    List<CompositeItemComponent>? components,
  ) async {
    final db = await _database.database;
    
    await db.transaction((txn) async {
      // Update composite item
      await txn.update(
        'composite_items',
        item.copyWith(
          updatedAt: DateTime.now(),
        ).toMap(),
        where: 'id = ?',
        whereArgs: [itemId],
      );

      // Update components if provided
      if (components != null) {
        // Delete existing components
        await txn.delete(
          'composite_item_components',
          where: 'composite_item_id = ?',
          whereArgs: [itemId],
        );

        // Insert new components
        for (final component in components) {
          await txn.insert(
            'composite_item_components',
            component.copyWith(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              compositeItemId: itemId,
            ).toMap(),
          );
        }
      }

      // Add to sync queue
      await _syncService.addToQueue(
        'composite_items',
        itemId,
        'update',
        item.toMap(),
      );
    });
  }

  Future<void> deleteCompositeItem(String itemId) async {
    final db = await _database.database;
    
    await db.transaction((txn) async {
      // Delete components first
      await txn.delete(
        'composite_item_components',
        where: 'composite_item_id = ?',
        whereArgs: [itemId],
      );

      // Delete composite item
      await txn.delete(
        'composite_items',
        where: 'id = ?',
        whereArgs: [itemId],
      );

      // Add to sync queue
      await _syncService.addToQueue(
        'composite_items',
        itemId,
        'delete',
        {},
      );
    });
  }

  // Stock availability check
  Future<Map<String, dynamic>> checkComponentAvailability(
    String compositeItemId,
    String branchId,
    double quantity,
  ) async {
    final item = await getCompositeItem(compositeItemId);
    if (item == null || item.components == null) {
      throw Exception('Composite item not found');
    }

    final availability = <String, dynamic>{
      'canAssemble': true,
      'components': [],
    };

    for (final component in item.components!) {
      final inventory = await _branchService.getBranchInventory(
        branchId,
        component.productId,
      );

      final product = await _productService.getProduct(component.productId);
      final requiredQuantity = component.quantity * quantity;
      final availableQuantity = inventory?.availableStock ?? 0;
      final isAvailable = availableQuantity >= requiredQuantity;

      if (!isAvailable) {
        availability['canAssemble'] = false;
      }

      availability['components'].add({
        'productId': component.productId,
        'productName': product?.name ?? 'Unknown',
        'requiredQuantity': requiredQuantity,
        'availableQuantity': availableQuantity,
        'isAvailable': isAvailable,
      });
    }

    return availability;
  }

  // Assemble composite item
  Future<void> assembleCompositeItem(
    String compositeItemId,
    String branchId,
    double quantity,
    String performedBy,
  ) async {
    final item = await getCompositeItem(compositeItemId);
    if (item == null || item.components == null) {
      throw Exception('Composite item not found');
    }

    // Check availability first
    final availability = await checkComponentAvailability(
      compositeItemId,
      branchId,
      quantity,
    );

    if (!availability['canAssemble']) {
      throw Exception('Insufficient component stock');
    }

    final db = await _database.database;
    
    await db.transaction((txn) async {
      // Deduct component stock
      for (final component in item.components!) {
        final requiredQuantity = component.quantity * quantity;
        await _branchService.updateBranchInventory(
          branchId,
          component.productId,
          -requiredQuantity,
        );

        // Create inventory movement
        await txn.insert('inventory_movements', {
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'organization_id': item.organizationId,
          'product_id': component.productId,
          'type': 'out',
          'quantity': requiredQuantity,
          'reason': 'Assembled into ${item.name}',
          'reference_id': compositeItemId,
          'reference_type': 'composite_assembly',
          'performed_by': performedBy,
          'created_at': DateTime.now().millisecondsSinceEpoch,
        });
      }

      // TODO: Add assembled composite item to inventory if tracked as a product
    });
  }

  // Disassemble composite item
  Future<void> disassembleCompositeItem(
    String compositeItemId,
    String branchId,
    double quantity,
    String performedBy,
  ) async {
    final item = await getCompositeItem(compositeItemId);
    if (item == null || item.components == null) {
      throw Exception('Composite item not found');
    }

    final db = await _database.database;
    
    await db.transaction((txn) async {
      // Add component stock back
      for (final component in item.components!) {
        final returnQuantity = component.quantity * quantity;
        await _branchService.updateBranchInventory(
          branchId,
          component.productId,
          returnQuantity,
        );

        // Create inventory movement
        await txn.insert('inventory_movements', {
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'organization_id': item.organizationId,
          'product_id': component.productId,
          'type': 'in',
          'quantity': returnQuantity,
          'reason': 'Disassembled from ${item.name}',
          'reference_id': compositeItemId,
          'reference_type': 'composite_disassembly',
          'performed_by': performedBy,
          'created_at': DateTime.now().millisecondsSinceEpoch,
        });
      }
    });
  }

  // Calculate cost price based on components
  Future<double> calculateCostPrice(String compositeItemId) async {
    final item = await getCompositeItem(compositeItemId);
    if (item == null || item.components == null) {
      return 0.0;
    }

    double totalCost = 0.0;

    for (final component in item.components!) {
      final product = await _productService.getProduct(component.productId);
      if (product != null && product.costPrice != null) {
        totalCost += product.costPrice! * component.quantity;
      }
    }

    return totalCost;
  }
}