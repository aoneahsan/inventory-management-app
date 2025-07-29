import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/customer.dart';
import '../../core/errors/exceptions.dart';
import '../database/database.dart';

class CustomerService {
  final FirebaseFirestore _firestore;
  final AppDatabase _database;
  final _uuid = const Uuid();

  CustomerService({
    FirebaseFirestore? firestore,
    AppDatabase? database,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _database = database ?? AppDatabase.instance;

  // Customer CRUD operations
  Future<List<Customer>> getCustomers(
    String organizationId, {
    String? searchQuery,
    String? customerType,
    bool? activeOnly,
    int? limit,
    int? offset,
  }) async {
    try {
      final db = await _database.database;
      String query = '''
        SELECT * FROM customers 
        WHERE organization_id = ?
      ''';

      final params = [organizationId];

      if (searchQuery != null && searchQuery.isNotEmpty) {
        query += ' AND (name LIKE ? OR email LIKE ? OR phone LIKE ? OR code LIKE ?)';
        final searchPattern = '%$searchQuery%';
        params.addAll([searchPattern, searchPattern, searchPattern, searchPattern]);
      }

      if (customerType != null) {
        query += ' AND customer_type = ?';
        params.add(customerType);
      }

      if (activeOnly == true) {
        query += ' AND status = ?';
        params.add('active');
      }

      query += ' ORDER BY name ASC';

      if (limit != null) {
        query += ' LIMIT ?';
        params.add(limit);
        if (offset != null) {
          query += ' OFFSET ?';
          params.add(offset);
        }
      }

      final results = await db.rawQuery(query, params);
      
      return results.map((row) => _customerFromDatabase(row)).toList();
    } catch (e) {
      throw BusinessException(message: 'Failed to load customers: $e');
    }
  }

  Future<Customer?> getCustomer(String customerId) async {
    try {
      final db = await _database.database;
      final results = await db.query(
        'customers',
        where: 'id = ?',
        whereArgs: [customerId],
        limit: 1,
      );

      if (results.isNotEmpty) {
        return _customerFromDatabase(results.first);
      }

      // Fallback to Firestore
      final doc = await _firestore.collection('customers').doc(customerId).get();
      if (doc.exists) {
        final customer = Customer.fromJson({...doc.data()!, 'id': doc.id});
        
        // Save to local database
        await _saveCustomerToDatabase(customer);
        
        return customer;
      }

      return null;
    } catch (e) {
      throw BusinessException(message: 'Failed to load customer: $e');
    }
  }

  Future<Customer> createCustomer({
    required String organizationId,
    required String name,
    String? code,
    String? email,
    String? phone,
    String? mobile,
    String? taxNumber,
    String customerType = 'retail',
    String? priceListId,
    double creditLimit = 0,
    String? address,
    String? shippingAddress,
  }) async {
    try {
      final now = DateTime.now();
      final customerId = _uuid.v4();
      
      // Generate customer code if not provided
      final customerCode = code ?? await _generateCustomerCode(organizationId);

      final customer = Customer(
        id: customerId,
        organizationId: organizationId,
        name: name,
        code: customerCode,
        email: email,
        phone: phone,
        mobile: mobile,
        taxNumber: taxNumber,
        customerType: customerType,
        priceListId: priceListId,
        creditLimit: creditLimit,
        currentBalance: 0,
        loyaltyPoints: 0,
        address: address,
        shippingAddress: shippingAddress ?? address,
        status: 'active',
        createdAt: now,
        updatedAt: now,
      );

      // Save to local database
      await _saveCustomerToDatabase(customer);

      // Sync to Firestore
      await _firestore.collection('customers').doc(customerId).set(customer.toJson());

      return customer;
    } catch (e) {
      throw BusinessException(message: 'Failed to create customer: $e');
    }
  }

  Future<Customer> updateCustomer({
    required String customerId,
    String? name,
    String? code,
    String? email,
    String? phone,
    String? mobile,
    String? taxNumber,
    String? customerType,
    String? priceListId,
    double? creditLimit,
    String? address,
    String? shippingAddress,
    String? status,
  }) async {
    try {
      final existingCustomer = await getCustomer(customerId);
      if (existingCustomer == null) {
        throw BusinessException(message: 'Customer not found');
      }

      final updatedCustomer = existingCustomer.copyWith(
        name: name ?? existingCustomer.name,
        code: code ?? existingCustomer.code,
        email: email ?? existingCustomer.email,
        phone: phone ?? existingCustomer.phone,
        mobile: mobile ?? existingCustomer.mobile,
        taxNumber: taxNumber ?? existingCustomer.taxNumber,
        customerType: customerType ?? existingCustomer.customerType,
        priceListId: priceListId ?? existingCustomer.priceListId,
        creditLimit: creditLimit ?? existingCustomer.creditLimit,
        address: address ?? existingCustomer.address,
        shippingAddress: shippingAddress ?? existingCustomer.shippingAddress,
        status: status ?? existingCustomer.status,
        updatedAt: DateTime.now(),
      );

      // Update local database
      await _updateCustomerInDatabase(updatedCustomer);

      // Sync to Firestore
      await _firestore.collection('customers').doc(customerId).update(updatedCustomer.toJson());

      return updatedCustomer;
    } catch (e) {
      throw BusinessException(message: 'Failed to update customer: $e');
    }
  }

  Future<void> deleteCustomer(String customerId) async {
    try {
      // Check if customer has any transactions
      final db = await _database.database;
      final salesCount = await db.rawQuery(
        'SELECT COUNT(*) as count FROM sales WHERE customer_id = ?',
        [customerId],
      );

      final count = salesCount.first['count'] as int;
      if (count > 0) {
        // Soft delete - just mark as inactive
        await updateCustomer(customerId: customerId, status: 'inactive');
      } else {
        // Hard delete
        await db.delete('customers', where: 'id = ?', whereArgs: [customerId]);
        await _firestore.collection('customers').doc(customerId).delete();
      }
    } catch (e) {
      throw BusinessException(message: 'Failed to delete customer: $e');
    }
  }

  // Customer balance operations
  Future<void> updateCustomerBalance(String customerId, double amount, String transactionType) async {
    try {
      final customer = await getCustomer(customerId);
      if (customer == null) {
        throw BusinessException(message: 'Customer not found');
      }

      double newBalance = customer.currentBalance;
      if (transactionType == 'payment') {
        newBalance -= amount;
      } else if (transactionType == 'purchase') {
        newBalance += amount;
      }

      await updateCustomer(
        customerId: customerId,
        currentBalance: newBalance,
      );
    } catch (e) {
      throw BusinessException(message: 'Failed to update customer balance: $e');
    }
  }

  // Loyalty points operations
  Future<void> addLoyaltyPoints(String customerId, int points) async {
    try {
      final customer = await getCustomer(customerId);
      if (customer == null) {
        throw BusinessException(message: 'Customer not found');
      }

      final newPoints = customer.loyaltyPoints + points;
      
      await updateCustomer(
        customerId: customerId,
        loyaltyPoints: newPoints,
      );
    } catch (e) {
      throw BusinessException(message: 'Failed to add loyalty points: $e');
    }
  }

  Future<void> redeemLoyaltyPoints(String customerId, int points) async {
    try {
      final customer = await getCustomer(customerId);
      if (customer == null) {
        throw BusinessException(message: 'Customer not found');
      }

      if (customer.loyaltyPoints < points) {
        throw BusinessException(message: 'Insufficient loyalty points');
      }

      final newPoints = customer.loyaltyPoints - points;
      
      await updateCustomer(
        customerId: customerId,
        loyaltyPoints: newPoints,
      );
    } catch (e) {
      throw BusinessException(message: 'Failed to redeem loyalty points: $e');
    }
  }

  // Customer statistics
  Future<Map<String, dynamic>> getCustomerStats(String organizationId) async {
    try {
      final db = await _database.database;
      
      // Total customers
      final totalResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM customers WHERE organization_id = ?',
        [organizationId],
      );
      
      // Active customers
      final activeResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM customers WHERE organization_id = ? AND status = ?',
        [organizationId, 'active'],
      );
      
      // Customers with credit
      final creditResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM customers WHERE organization_id = ? AND credit_limit > 0',
        [organizationId],
      );
      
      // Total outstanding balance
      final balanceResult = await db.rawQuery(
        'SELECT SUM(current_balance) as total FROM customers WHERE organization_id = ?',
        [organizationId],
      );

      return {
        'totalCustomers': totalResult.first['count'] ?? 0,
        'activeCustomers': activeResult.first['count'] ?? 0,
        'customersWithCredit': creditResult.first['count'] ?? 0,
        'totalOutstandingBalance': balanceResult.first['total'] ?? 0,
      };
    } catch (e) {
      throw BusinessException(message: 'Failed to get customer statistics: $e');
    }
  }

  // Helper methods
  Customer _customerFromDatabase(Map<String, dynamic> row) {
    return Customer(
      id: row['id'],
      organizationId: row['organization_id'],
      name: row['name'],
      code: row['code'],
      email: row['email'],
      phone: row['phone'],
      mobile: row['mobile'],
      taxNumber: row['tax_number'],
      customerType: row['customer_type'] ?? 'retail',
      priceListId: row['price_list_id'],
      creditLimit: row['credit_limit']?.toDouble() ?? 0,
      currentBalance: row['current_balance']?.toDouble() ?? 0,
      loyaltyPoints: row['loyalty_points'] ?? 0,
      address: row['address'],
      shippingAddress: row['shipping_address'],
      status: row['status'] ?? 'active',
      createdAt: DateTime.fromMillisecondsSinceEpoch(row['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(row['updated_at']),
    );
  }

  Future<void> _saveCustomerToDatabase(Customer customer) async {
    final db = await _database.database;
    await db.insert('customers', {
      'id': customer.id,
      'organization_id': customer.organizationId,
      'name': customer.name,
      'code': customer.code,
      'email': customer.email,
      'phone': customer.phone,
      'mobile': customer.mobile,
      'tax_number': customer.taxNumber,
      'customer_type': customer.customerType,
      'price_list_id': customer.priceListId,
      'credit_limit': customer.creditLimit,
      'current_balance': customer.currentBalance,
      'loyalty_points': customer.loyaltyPoints,
      'address': customer.address,
      'shipping_address': customer.shippingAddress,
      'status': customer.status,
      'created_at': customer.createdAt.millisecondsSinceEpoch,
      'updated_at': customer.updatedAt.millisecondsSinceEpoch,
    });
  }

  Future<void> _updateCustomerInDatabase(Customer customer) async {
    final db = await _database.database;
    await db.update(
      'customers',
      {
        'name': customer.name,
        'code': customer.code,
        'email': customer.email,
        'phone': customer.phone,
        'mobile': customer.mobile,
        'tax_number': customer.taxNumber,
        'customer_type': customer.customerType,
        'price_list_id': customer.priceListId,
        'credit_limit': customer.creditLimit,
        'current_balance': customer.currentBalance,
        'loyalty_points': customer.loyaltyPoints,
        'address': customer.address,
        'shipping_address': customer.shippingAddress,
        'status': customer.status,
        'updated_at': customer.updatedAt.millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [customer.id],
    );
  }

  Future<String> _generateCustomerCode(String organizationId) async {
    try {
      final db = await _database.database;
      final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM customers WHERE organization_id = ?',
        [organizationId],
      );
      
      final count = (result.first['count'] as int) + 1;
      return 'CUST${count.toString().padLeft(6, '0')}';
    } catch (e) {
      return 'CUST${DateTime.now().millisecondsSinceEpoch}';
    }
  }
}