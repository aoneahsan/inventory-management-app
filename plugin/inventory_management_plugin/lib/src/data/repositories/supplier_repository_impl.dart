import '../../domain/entities/supplier.dart';
import '../../domain/entities/purchase_order.dart';
import '../../domain/entities/supplier_transaction.dart';
import '../../domain/repositories/supplier_repository.dart';
import '../../domain/value_objects/repository_types.dart';
import '../database/database_helper.dart';
import '../database/database_schema.dart';
import '../models/supplier_model.dart';
import 'base_repository_impl.dart';

/// Implementation of SupplierRepository
class SupplierRepositoryImpl extends BaseRepositoryImpl<Supplier, SupplierModel>
    implements SupplierRepository {
  
  @override
  String get tableName => DatabaseSchema.suppliersTable;
  
  @override
  SupplierModel toModel(Supplier entity) => SupplierModel(entity);
  
  @override
  Supplier fromModel(SupplierModel model) => model.supplier;
  
  @override
  SupplierModel fromDatabase(Map<String, dynamic> map) => 
      SupplierModel.fromDatabase(map);
  
  @override
  Future<Supplier?> getByCode(String code, {String? organizationId}) async {
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
  Future<Supplier?> getByEmail(String email, {String? organizationId}) async {
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
  Future<Supplier?> getByPhone(String phone, {String? organizationId}) async {
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
  Future<void> updateBalance(String supplierId, double amount) async {
    final db = DatabaseHelper();
    await db.transaction((txn) async {
      // Get current balance
      final results = await txn.query(
        tableName,
        columns: ['current_balance'],
        where: 'id = ?',
        whereArgs: [supplierId],
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
          whereArgs: [supplierId],
        );
      }
    });
  }
  
  @override
  Future<List<PurchaseOrder>> getPurchaseOrders(
    String supplierId, {
    DateTime? startDate,
    DateTime? endDate,
    PurchaseOrderStatus? status,
  }) async {
    // This would query the purchase orders table
    // For now, return empty list
    return [];
  }
  
  @override
  Future<List<SupplierTransaction>> getTransactions(
    String supplierId, {
    DateTime? startDate,
    DateTime? endDate,
    TransactionType? type,
  }) async {
    // This would query the supplier transactions table
    // For now, return empty list
    return [];
  }
  
  @override
  Future<SupplierStatistics> getStatistics(String supplierId) async {
    // Query purchase orders table for statistics
    final query = '''
      SELECT 
        COUNT(*) as total_orders,
        SUM(total_amount) as total_purchases,
        AVG(total_amount) as average_order_value,
        MAX(order_date) as last_order_date
      FROM ${DatabaseSchema.purchaseOrdersTable}
      WHERE supplier_id = ?
    ''';
    
    final results = await DatabaseHelper().rawQuery(query, [supplierId]);
    
    if (results.isEmpty) {
      return SupplierStatistics(
        totalOrders: 0,
        totalPurchases: 0,
        averageOrderValue: 0,
        lastOrderDate: null,
        outstandingBalance: 0,
        onTimeDeliveryRate: 0,
      );
    }
    
    final row = results.first;
    
    // Get balance from supplier record
    final supplier = await getById(supplierId);
    
    return SupplierStatistics(
      totalOrders: row['total_orders'] as int? ?? 0,
      totalPurchases: (row['total_purchases'] as num?)?.toDouble() ?? 0,
      averageOrderValue: (row['average_order_value'] as num?)?.toDouble() ?? 0,
      lastOrderDate: row['last_order_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(row['last_order_date'] as int)
          : null,
      outstandingBalance: supplier?.currentBalance ?? 0,
      onTimeDeliveryRate: 0, // Would need to calculate from delivery data
    );
  }
  
  @override
  Future<List<Supplier>> getSuppliersWithBalance({String? organizationId}) async {
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
  Future<List<SupplierVolume>> getTopSuppliers({
    String? organizationId,
    DateTime? startDate,
    DateTime? endDate,
    int limit = 10,
  }) async {
    String where = '';
    List<dynamic> whereArgs = [];
    
    if (organizationId != null) {
      where = 'po.organization_id = ?';
      whereArgs.add(organizationId);
    }
    
    if (startDate != null) {
      where += where.isEmpty ? '' : ' AND ';
      where += 'po.order_date >= ?';
      whereArgs.add(startDate.millisecondsSinceEpoch);
    }
    
    if (endDate != null) {
      where += where.isEmpty ? '' : ' AND ';
      where += 'po.order_date <= ?';
      whereArgs.add(endDate.millisecondsSinceEpoch);
    }
    
    final query = '''
      SELECT 
        s.id as supplier_id,
        s.name as supplier_name,
        SUM(po.total_amount) as total_volume,
        COUNT(po.id) as order_count,
        AVG(po.total_amount) as average_order_value
      FROM ${DatabaseSchema.suppliersTable} s
      INNER JOIN ${DatabaseSchema.purchaseOrdersTable} po ON s.id = po.supplier_id
      ${where.isEmpty ? '' : 'WHERE $where'}
      GROUP BY s.id, s.name
      ORDER BY total_volume DESC
      LIMIT ?
    ''';
    
    whereArgs.add(limit);
    
    final results = await DatabaseHelper().rawQuery(query, whereArgs);
    
    return results.map((row) => SupplierVolume(
      supplierId: row['supplier_id'] as String,
      supplierName: row['supplier_name'] as String,
      totalVolume: (row['total_volume'] as num).toDouble(),
      orderCount: row['order_count'] as int,
      averageOrderValue: (row['average_order_value'] as num).toDouble(),
    )).toList();
  }
  
  @override
  Future<List<Supplier>> searchSuppliers(String query, {String? organizationId}) async {
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
  Future<List<Supplier>> getByProduct(String productId, {String? organizationId}) async {
    // This would require joining with purchase order items
    // For now, return empty list
    return [];
  }
  
  @override
  Future<List<Supplier>> getByPaymentTerms(String terms, {String? organizationId}) async {
    final results = await DatabaseHelper().query(
      tableName,
      where: organizationId != null
          ? 'payment_terms = ? AND organization_id = ?'
          : 'payment_terms = ?',
      whereArgs: organizationId != null
          ? [terms, organizationId]
          : [terms],
    );
    
    return results.map((map) => fromModel(fromDatabase(map))).toList();
  }
  
  @override
  Future<List<PaymentDue>> getPaymentsDue({
    String? organizationId,
    DateTime? dueDate,
  }) async {
    // This would query purchase bills and payment schedules
    // For now, return empty list
    return [];
  }
  
  @override
  Future<SupplierTransaction> recordPayment({
    required String supplierId,
    required double amount,
    required String paymentMethod,
    String? reference,
    String? notes,
  }) async {
    // Create transaction record and update balance
    final transactionId = DateTime.now().millisecondsSinceEpoch.toString();
    
    await DatabaseHelper().transaction((txn) async {
      // Insert transaction
      await txn.insert(DatabaseSchema.supplierTransactionsTable, {
        'id': transactionId,
        'supplier_id': supplierId,
        'transaction_type': 'payment',
        'amount': amount,
        'payment_method': paymentMethod,
        'reference': reference,
        'notes': notes,
        'created_at': DateTime.now().millisecondsSinceEpoch,
      });
      
      // Update supplier balance
      await updateBalance(supplierId, -amount);
    });
    
    // Return transaction
    return SupplierTransaction(
      id: transactionId,
      organizationId: '', // Would get from supplier
      supplierId: supplierId,
      transactionType: TransactionType.payment,
      referenceType: null,
      referenceId: null,
      amount: amount,
      paymentMethod: paymentMethod,
      reference: reference,
      notes: notes,
      createdAt: DateTime.now(),
      syncedAt: null,
    );
  }
}