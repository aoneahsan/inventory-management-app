import '../../domain/entities/branch.dart';
import '../../domain/entities/branch_inventory.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/branch_repository.dart';
import '../../domain/value_objects/repository_types.dart';
import '../database/database_helper.dart';
import '../database/database_schema.dart';
import '../models/branch_model.dart';
import 'base_repository_impl.dart';

/// Implementation of BranchRepository
class BranchRepositoryImpl extends BaseRepositoryImpl<Branch, BranchModel>
    implements BranchRepository {
  
  @override
  String get tableName => DatabaseSchema.branchesTable;
  
  @override
  BranchModel toModel(Branch entity) => BranchModel(entity);
  
  @override
  Branch fromModel(BranchModel model) => model.branch;
  
  @override
  BranchModel fromDatabase(Map<String, dynamic> map) => 
      BranchModel.fromDatabase(map);
  
  @override
  Future<Branch?> getByCode(String code, {String? organizationId}) async {
    final results = await DatabaseHelper().query(
      tableName,
      where: organizationId != null
          ? 'code = ? AND organization_id = ?'
          : 'code = ?',
      whereArgs: organizationId != null
          ? [code, organizationId]
          : [code],
      limit: 1,
    );
    
    if (results.isEmpty) return null;
    return fromModel(fromDatabase(results.first));
  }
  
  @override
  Future<List<Branch>> getByType(BranchType type, {String? organizationId}) async {
    final results = await DatabaseHelper().query(
      tableName,
      where: organizationId != null
          ? 'type = ? AND organization_id = ?'
          : 'type = ?',
      whereArgs: organizationId != null
          ? [type.name, organizationId]
          : [type.name],
    );
    
    return results.map((map) => fromModel(fromDatabase(map))).toList();
  }
  
  @override
  Future<List<Branch>> getWarehouses({String? organizationId}) async {
    final results = await DatabaseHelper().query(
      tableName,
      where: organizationId != null
          ? 'is_warehouse = 1 AND organization_id = ?'
          : 'is_warehouse = 1',
      whereArgs: organizationId != null ? [organizationId] : null,
    );
    
    return results.map((map) => fromModel(fromDatabase(map))).toList();
  }
  
  @override
  Future<List<Branch>> getStores({String? organizationId}) async {
    final results = await DatabaseHelper().query(
      tableName,
      where: organizationId != null
          ? 'is_warehouse = 0 AND organization_id = ?'
          : 'is_warehouse = 0',
      whereArgs: organizationId != null ? [organizationId] : null,
    );
    
    return results.map((map) => fromModel(fromDatabase(map))).toList();
  }
  
  @override
  Future<List<Branch>> getSellableBranches({String? organizationId}) async {
    final results = await DatabaseHelper().query(
      tableName,
      where: organizationId != null
          ? 'can_sell = 1 AND is_active = 1 AND organization_id = ?'
          : 'can_sell = 1 AND is_active = 1',
      whereArgs: organizationId != null ? [organizationId] : null,
    );
    
    return results.map((map) => fromModel(fromDatabase(map))).toList();
  }
  
  @override
  Future<List<BranchInventory>> getInventory(String branchId, {
    String? productId,
    bool lowStockOnly = false,
  }) async {
    // Query branch inventory table
    String where = 'branch_id = ?';
    List<dynamic> whereArgs = [branchId];
    
    if (productId != null) {
      where += ' AND product_id = ?';
      whereArgs.add(productId);
    }
    
    if (lowStockOnly) {
      // Would need to join with products to check reorder levels
      where += ' AND quantity < reorder_point';
    }
    
    final results = await DatabaseHelper().query(
      DatabaseSchema.branchInventoryTable,
      where: where,
      whereArgs: whereArgs,
    );
    
    // Convert to BranchInventory entities
    return [];
  }
  
  @override
  Future<List<User>> getBranchUsers(String branchId) async {
    // Query users table
    final results = await DatabaseHelper().query(
      DatabaseSchema.usersTable,
      where: 'branch_id = ?',
      whereArgs: [branchId],
    );
    
    // Convert to User entities
    return [];
  }
  
  @override
  Future<User?> getBranchManager(String branchId) async {
    final branch = await getById(branchId);
    if (branch == null || branch.managerId == null) return null;
    
    // Query user by manager ID
    final results = await DatabaseHelper().query(
      DatabaseSchema.usersTable,
      where: 'id = ?',
      whereArgs: [branch.managerId],
      limit: 1,
    );
    
    if (results.isEmpty) return null;
    
    // Convert to User entity
    return null;
  }
  
  @override
  Future<void> assignManager(String branchId, String userId) async {
    await DatabaseHelper().update(
      tableName,
      {
        'manager_id': userId,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [branchId],
    );
  }
  
  @override
  Future<String> transferInventory({
    required String fromBranchId,
    required String toBranchId,
    required List<TransferItem> items,
    String? notes,
  }) async {
    // Create stock transfer record
    final transferId = DateTime.now().millisecondsSinceEpoch.toString();
    
    await DatabaseHelper().transaction((txn) async {
      // Create transfer
      await txn.insert(DatabaseSchema.stockTransfersTable, {
        'id': transferId,
        'from_branch_id': fromBranchId,
        'to_branch_id': toBranchId,
        'transfer_date': DateTime.now().millisecondsSinceEpoch,
        'status': 'pending',
        'notes': notes,
        'created_at': DateTime.now().millisecondsSinceEpoch,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      });
      
      // Create transfer items
      for (final item in items) {
        await txn.insert(DatabaseSchema.stockTransferItemsTable, {
          'id': '${transferId}_${item.productId}',
          'stock_transfer_id': transferId,
          'product_id': item.productId,
          'requested_quantity': item.quantity,
          'batch_id': item.batchId,
          'serial_number': item.serialNumber,
          'created_at': DateTime.now().millisecondsSinceEpoch,
        });
      }
    });
    
    return transferId;
  }
  
  @override
  Future<BranchStatistics> getStatistics(
    String branchId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    // Would query multiple tables for comprehensive statistics
    return BranchStatistics(
      totalSales: 0,
      transactionCount: 0,
      averageTransactionValue: 0,
      activeProducts: 0,
      inventoryValue: 0,
      activeCustomers: 0,
    );
  }
  
  @override
  Future<BranchPerformance> getPerformance(
    String branchId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    // Would calculate various performance metrics
    return BranchPerformance(
      salesGrowth: 0,
      profitMargin: 0,
      inventoryTurnover: 0,
      customerRetention: 0,
      employeeProductivity: 0,
      stockouts: 0,
    );
  }
  
  @override
  Future<List<Branch>> searchBranches(String query, {String? organizationId}) async {
    final results = await DatabaseHelper().query(
      tableName,
      where: organizationId != null
          ? 'organization_id = ? AND (name LIKE ? OR code LIKE ? OR phone LIKE ?)'
          : '(name LIKE ? OR code LIKE ? OR phone LIKE ?)',
      whereArgs: organizationId != null
          ? [organizationId, '%$query%', '%$query%', '%$query%']
          : ['%$query%', '%$query%', '%$query%'],
    );
    
    return results.map((map) => fromModel(fromDatabase(map))).toList();
  }
  
  @override
  Future<List<Branch>> getByCity(String city, {String? organizationId}) async {
    final results = await DatabaseHelper().query(
      tableName,
      where: organizationId != null
          ? 'city = ? AND organization_id = ?'
          : 'city = ?',
      whereArgs: organizationId != null
          ? [city, organizationId]
          : [city],
    );
    
    return results.map((map) => fromModel(fromDatabase(map))).toList();
  }
  
  @override
  Future<List<Branch>> getByState(String state, {String? organizationId}) async {
    final results = await DatabaseHelper().query(
      tableName,
      where: organizationId != null
          ? 'state = ? AND organization_id = ?'
          : 'state = ?',
      whereArgs: organizationId != null
          ? [state, organizationId]
          : [state],
    );
    
    return results.map((map) => fromModel(fromDatabase(map))).toList();
  }
  
  @override
  Future<List<BranchStock>> checkProductAvailability(
    String productId, {
    String? organizationId,
  }) async {
    String joinCondition = 'bi.branch_id = b.id';
    String where = 'bi.product_id = ?';
    List<dynamic> whereArgs = [productId];
    
    if (organizationId != null) {
      where += ' AND b.organization_id = ?';
      whereArgs.add(organizationId);
    }
    
    final query = '''
      SELECT 
        b.id as branch_id,
        b.name as branch_name,
        bi.quantity as available_quantity,
        bi.reserved_quantity,
        bi.updated_at
      FROM ${DatabaseSchema.branchInventoryTable} bi
      INNER JOIN ${DatabaseSchema.branchesTable} b ON $joinCondition
      WHERE $where
    ''';
    
    final results = await DatabaseHelper().rawQuery(query, whereArgs);
    
    return results.map((row) => BranchStock(
      branchId: row['branch_id'] as String,
      branchName: row['branch_name'] as String,
      availableQuantity: (row['available_quantity'] as num?)?.toDouble() ?? 0,
      reservedQuantity: (row['reserved_quantity'] as num?)?.toDouble() ?? 0,
      lastUpdated: row['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(row['updated_at'] as int)
          : null,
    )).toList();
  }
}