import '../../domain/entities/branch.dart';
import '../../domain/entities/branch_inventory.dart';
import '../database/database.dart';

class BranchService {
  final AppDatabase _database = AppDatabase.instance;

  Future<List<Branch>> getBranches(String organizationId) async {
    final db = await _database.database;
    final results = await db.query(
      'branches',
      where: 'organization_id = ?',
      whereArgs: [organizationId],
      orderBy: 'name ASC',
    );

    return results.map((map) => Branch.fromMap(map)).toList();
  }

  Future<Branch?> getBranch(String branchId) async {
    final db = await _database.database;
    final results = await db.query(
      'branches',
      where: 'id = ?',
      whereArgs: [branchId],
    );

    if (results.isEmpty) return null;
    return Branch.fromMap(results.first);
  }

  Future<List<Branch>> getBranchesByType(
    String organizationId,
    BranchType type,
  ) async {
    final db = await _database.database;
    final results = await db.query(
      'branches',
      where: 'organization_id = ? AND type = ?',
      whereArgs: [organizationId, type.value],
      orderBy: 'name ASC',
    );

    return results.map((map) => Branch.fromMap(map)).toList();
  }

  Future<String> createBranch(Branch branch) async {
    final db = await _database.database;
    final id = branch.id.isEmpty
        ? DateTime.now().millisecondsSinceEpoch.toString()
        : branch.id;

    await db.insert(
      'branches',
      branch.copyWith(id: id).toMap(),
    );

    return id;
  }

  Future<void> updateBranch(String branchId, Branch branch) async {
    final db = await _database.database;
    await db.update(
      'branches',
      branch.copyWith(
        updatedAt: DateTime.now(),
      ).toMap(),
      where: 'id = ?',
      whereArgs: [branchId],
    );
  }

  Future<void> deleteBranch(String branchId) async {
    final db = await _database.database;
    await db.delete(
      'branches',
      where: 'id = ?',
      whereArgs: [branchId],
    );
  }

  // Branch Inventory Management
  Future<BranchInventory?> getBranchInventory(
    String branchId,
    String productId,
  ) async {
    final db = await _database.database;
    final results = await db.query(
      'branch_inventory',
      where: 'branch_id = ? AND product_id = ?',
      whereArgs: [branchId, productId],
    );

    if (results.isEmpty) return null;
    return BranchInventory.fromMap(results.first);
  }

  Future<List<BranchInventory>> getBranchInventories(String branchId) async {
    final db = await _database.database;
    final results = await db.query(
      'branch_inventory',
      where: 'branch_id = ?',
      whereArgs: [branchId],
    );

    return results.map((map) => BranchInventory.fromMap(map)).toList();
  }

  Future<List<BranchInventory>> getProductInventoryAcrossBranches(
    String organizationId,
    String productId,
  ) async {
    final db = await _database.database;
    final results = await db.rawQuery('''
      SELECT bi.*
      FROM branch_inventory bi
      JOIN branches b ON bi.branch_id = b.id
      WHERE b.organization_id = ? AND bi.product_id = ?
    ''', [organizationId, productId]);

    return results.map((map) => BranchInventory.fromMap(map)).toList();
  }

  Future<void> updateBranchInventory(
    String branchId,
    String productId,
    double quantity, {
    bool isAbsolute = false,
  }) async {
    final db = await _database.database;
    final existing = await getBranchInventory(branchId, productId);

    if (existing == null) {
      // Create new inventory record
      await db.insert('branch_inventory', {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'branch_id': branchId,
        'product_id': productId,
        'current_stock': isAbsolute ? quantity : quantity,
        'reserved_stock': 0,
        'available_stock': isAbsolute ? quantity : quantity,
        'min_stock': 0,
        'last_updated': DateTime.now().millisecondsSinceEpoch,
      });
    } else {
      // Update existing inventory
      final newStock = isAbsolute
          ? quantity
          : existing.currentStock + quantity;
      
      await db.update(
        'branch_inventory',
        {
          'current_stock': newStock,
          'available_stock': newStock - existing.reservedStock,
          'last_updated': DateTime.now().millisecondsSinceEpoch,
        },
        where: 'id = ?',
        whereArgs: [existing.id],
      );
    }
  }

  Future<void> reserveStock(
    String branchId,
    String productId,
    double quantity,
  ) async {
    final db = await _database.database;
    final inventory = await getBranchInventory(branchId, productId);
    
    if (inventory == null) {
      throw Exception('Product not found in branch inventory');
    }

    if (inventory.availableStock < quantity) {
      throw Exception('Insufficient stock available');
    }

    await db.update(
      'branch_inventory',
      {
        'reserved_stock': inventory.reservedStock + quantity,
        'available_stock': inventory.availableStock - quantity,
        'last_updated': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [inventory.id],
    );
  }

  Future<void> releaseReservedStock(
    String branchId,
    String productId,
    double quantity,
  ) async {
    final db = await _database.database;
    final inventory = await getBranchInventory(branchId, productId);
    
    if (inventory == null) {
      throw Exception('Product not found in branch inventory');
    }

    final newReserved = (inventory.reservedStock - quantity).clamp(0, double.infinity);
    
    await db.update(
      'branch_inventory',
      {
        'reserved_stock': newReserved,
        'available_stock': inventory.currentStock - newReserved,
        'last_updated': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [inventory.id],
    );
  }

  Future<List<BranchInventory>> getLowStockItems(String branchId) async {
    final db = await _database.database;
    final results = await db.query(
      'branch_inventory',
      where: 'branch_id = ? AND current_stock <= min_stock',
      whereArgs: [branchId],
    );

    return results.map((map) => BranchInventory.fromMap(map)).toList();
  }

  Future<Map<String, dynamic>> getBranchStats(String branchId) async {
    final db = await _database.database;
    
    final totalProducts = await db.rawQuery(
      'SELECT COUNT(*) as count FROM branch_inventory WHERE branch_id = ?',
      [branchId],
    );

    final lowStock = await db.rawQuery(
      'SELECT COUNT(*) as count FROM branch_inventory WHERE branch_id = ? AND current_stock <= min_stock',
      [branchId],
    );

    final totalValue = await db.rawQuery('''
      SELECT SUM(bi.current_stock * p.cost_price) as total
      FROM branch_inventory bi
      JOIN products p ON bi.product_id = p.id
      WHERE bi.branch_id = ?
    ''', [branchId]);

    return {
      'total_products': totalProducts.first['count'] ?? 0,
      'low_stock_items': lowStock.first['count'] ?? 0,
      'total_inventory_value': totalValue.first['total'] ?? 0.0,
    };
  }
}