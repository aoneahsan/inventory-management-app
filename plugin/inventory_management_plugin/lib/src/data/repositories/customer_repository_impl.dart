import '../../domain/entities/customer.dart';
import '../../domain/entities/sale.dart';
import '../../domain/repositories/customer_repository.dart';
import '../../domain/value_objects/repository_types.dart';
import '../database/database_helper.dart';
import '../database/database_schema.dart';
import '../models/customer_model.dart';
import 'base_repository_impl.dart';

/// Implementation of CustomerRepository
class CustomerRepositoryImpl extends BaseRepositoryImpl<Customer, CustomerModel>
    implements CustomerRepository {
  
  @override
  String get tableName => DatabaseSchema.customersTable;
  
  @override
  CustomerModel toModel(Customer entity) => CustomerModel(entity);
  
  @override
  Customer fromModel(CustomerModel model) => model.customer;
  
  @override
  CustomerModel fromDatabase(Map<String, dynamic> map) => 
      CustomerModel.fromDatabase(map);
  
  @override
  Future<Customer?> getByPhone(String phone, {String? organizationId}) async {
    final results = await DatabaseHelper().query(
      tableName,
      where: organizationId != null
          ? 'phone = ? AND organization_id = ?'
          : 'phone = ?',
      whereArgs: organizationId != null
          ? [phone, organizationId]
          : [phone],
      limit: 1,
    );
    
    if (results.isEmpty) return null;
    return fromModel(fromDatabase(results.first));
  }
  
  @override
  Future<Customer?> getByEmail(String email, {String? organizationId}) async {
    final results = await DatabaseHelper().query(
      tableName,
      where: organizationId != null
          ? 'email = ? AND organization_id = ?'
          : 'email = ?',
      whereArgs: organizationId != null
          ? [email, organizationId]
          : [email],
      limit: 1,
    );
    
    if (results.isEmpty) return null;
    return fromModel(fromDatabase(results.first));
  }
  
  @override
  Future<Customer?> getByCode(String code, {String? organizationId}) async {
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
  Future<List<Customer>> getByType(CustomerType type, {String? organizationId}) async {
    final results = await DatabaseHelper().query(
      tableName,
      where: organizationId != null
          ? 'customer_type = ? AND organization_id = ?'
          : 'customer_type = ?',
      whereArgs: organizationId != null
          ? [type.name, organizationId]
          : [type.name],
    );
    
    return results.map((map) => fromModel(fromDatabase(map))).toList();
  }
  
  @override
  Future<void> updateBalance(String customerId, double amount) async {
    final db = DatabaseHelper();
    await db.transaction((txn) async {
      // Get current balance
      final results = await txn.query(
        tableName,
        columns: ['current_balance'],
        where: 'id = ?',
        whereArgs: [customerId],
      );
      
      if (results.isNotEmpty) {
        final currentBalance = (results.first['current_balance'] as num?)?.toDouble() ?? 0;
        final newBalance = currentBalance + amount;
        
        await txn.update(
          tableName,
          {
            'current_balance': newBalance,
            'updated_at': DateTime.now().millisecondsSinceEpoch,
          },
          where: 'id = ?',
          whereArgs: [customerId],
        );
      }
    });
  }
  
  @override
  Future<void> addLoyaltyPoints(String customerId, int points) async {
    final db = DatabaseHelper();
    await db.transaction((txn) async {
      // Get current points
      final results = await txn.query(
        tableName,
        columns: ['loyalty_points'],
        where: 'id = ?',
        whereArgs: [customerId],
      );
      
      if (results.isNotEmpty) {
        final currentPoints = results.first['loyalty_points'] as int? ?? 0;
        final newPoints = currentPoints + points;
        
        await txn.update(
          tableName,
          {
            'loyalty_points': newPoints,
            'updated_at': DateTime.now().millisecondsSinceEpoch,
          },
          where: 'id = ?',
          whereArgs: [customerId],
        );
      }
    });
  }
  
  @override
  Future<bool> redeemLoyaltyPoints(String customerId, int points) async {
    final db = DatabaseHelper();
    return await db.transaction((txn) async {
      // Get current points
      final results = await txn.query(
        tableName,
        columns: ['loyalty_points'],
        where: 'id = ?',
        whereArgs: [customerId],
      );
      
      if (results.isEmpty) return false;
      
      final currentPoints = results.first['loyalty_points'] as int? ?? 0;
      if (currentPoints < points) return false;
      
      final newPoints = currentPoints - points;
      
      await txn.update(
        tableName,
        {
          'loyalty_points': newPoints,
          'updated_at': DateTime.now().millisecondsSinceEpoch,
        },
        where: 'id = ?',
        whereArgs: [customerId],
      );
      
      return true;
    });
  }
  
  @override
  Future<List<Sale>> getPurchaseHistory(
    String customerId, {
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
  }) async {
    // This would query the sales table
    // For now, return empty list
    return [];
  }
  
  @override
  Future<CustomerStatistics> getStatistics(String customerId) async {
    // Query sales table for statistics
    final query = '''
      SELECT 
        COUNT(*) as total_purchases,
        SUM(total_amount) as total_spent,
        AVG(total_amount) as average_order_value,
        MAX(sale_date) as last_purchase_date
      FROM ${DatabaseSchema.salesTable}
      WHERE customer_id = ?
    ''';
    
    final results = await DatabaseHelper().rawQuery(query, [customerId]);
    
    if (results.isEmpty) {
      return CustomerStatistics(
        totalPurchases: 0,
        totalSpent: 0,
        averageOrderValue: 0,
        lastPurchaseDate: null,
        loyaltyPoints: 0,
        outstandingBalance: 0,
      );
    }
    
    final row = results.first;
    
    // Get loyalty points and balance from customer record
    final customer = await getById(customerId);
    
    return CustomerStatistics(
      totalPurchases: row['total_purchases'] as int? ?? 0,
      totalSpent: (row['total_spent'] as num?)?.toDouble() ?? 0,
      averageOrderValue: (row['average_order_value'] as num?)?.toDouble() ?? 0,
      lastPurchaseDate: row['last_purchase_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(row['last_purchase_date'] as int)
          : null,
      loyaltyPoints: customer?.loyaltyPoints ?? 0,
      outstandingBalance: customer?.currentBalance ?? 0,
    );
  }
  
  @override
  Future<List<Customer>> getCustomersWithBalance({String? organizationId}) async {
    final results = await DatabaseHelper().query(
      tableName,
      where: organizationId != null
          ? 'current_balance != 0 AND organization_id = ?'
          : 'current_balance != 0',
      whereArgs: organizationId != null ? [organizationId] : null,
      orderBy: 'current_balance DESC',
    );
    
    return results.map((map) => fromModel(fromDatabase(map))).toList();
  }
  
  @override
  Future<List<CustomerRevenue>> getTopCustomers({
    String? organizationId,
    DateTime? startDate,
    DateTime? endDate,
    int limit = 10,
  }) async {
    String where = '';
    List<dynamic> whereArgs = [];
    
    if (organizationId != null) {
      where = 's.organization_id = ?';
      whereArgs.add(organizationId);
    }
    
    if (startDate != null) {
      where += where.isEmpty ? '' : ' AND ';
      where += 's.sale_date >= ?';
      whereArgs.add(startDate.millisecondsSinceEpoch);
    }
    
    if (endDate != null) {
      where += where.isEmpty ? '' : ' AND ';
      where += 's.sale_date <= ?';
      whereArgs.add(endDate.millisecondsSinceEpoch);
    }
    
    final query = '''
      SELECT 
        c.id as customer_id,
        c.name as customer_name,
        SUM(s.total_amount) as total_revenue,
        COUNT(s.id) as order_count,
        AVG(s.total_amount) as average_order_value
      FROM ${DatabaseSchema.customersTable} c
      INNER JOIN ${DatabaseSchema.salesTable} s ON c.id = s.customer_id
      ${where.isEmpty ? '' : 'WHERE $where'}
      GROUP BY c.id, c.name
      ORDER BY total_revenue DESC
      LIMIT ?
    ''';
    
    whereArgs.add(limit);
    
    final results = await DatabaseHelper().rawQuery(query, whereArgs);
    
    return results.map((row) => CustomerRevenue(
      customerId: row['customer_id'] as String,
      customerName: row['customer_name'] as String,
      totalRevenue: (row['total_revenue'] as num).toDouble(),
      orderCount: row['order_count'] as int,
      averageOrderValue: (row['average_order_value'] as num).toDouble(),
    )).toList();
  }
  
  @override
  Future<List<Customer>> searchCustomers(String query, {String? organizationId}) async {
    final results = await DatabaseHelper().query(
      tableName,
      where: organizationId != null
          ? 'organization_id = ? AND (name LIKE ? OR phone LIKE ? OR email LIKE ? OR code LIKE ?)'
          : '(name LIKE ? OR phone LIKE ? OR email LIKE ? OR code LIKE ?)',
      whereArgs: organizationId != null
          ? [organizationId, '%$query%', '%$query%', '%$query%', '%$query%']
          : ['%$query%', '%$query%', '%$query%', '%$query%'],
    );
    
    return results.map((map) => fromModel(fromDatabase(map))).toList();
  }
  
  @override
  Future<List<Customer>> getByCity(String city, {String? organizationId}) async {
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
  Future<List<Customer>> getByState(String state, {String? organizationId}) async {
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
  Future<Customer> mergeCustomers(String primaryId, List<String> duplicateIds) async {
    // Complex operation that would:
    // 1. Update all references in sales, etc. to point to primary customer
    // 2. Merge loyalty points and balance
    // 3. Delete duplicate records
    // For now, just return the primary customer
    final primaryCustomer = await getById(primaryId);
    if (primaryCustomer == null) {
      throw Exception('Primary customer not found');
    }
    return primaryCustomer;
  }
}