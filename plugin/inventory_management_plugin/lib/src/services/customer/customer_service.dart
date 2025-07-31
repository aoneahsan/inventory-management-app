import 'dart:async';
import '../../domain/entities/customer.dart';
import '../../core/utils/logger.dart';
import '../database/database_service.dart';
import '../sync/sync_service.dart';

class CustomerService {
  final DatabaseService _databaseService;
  final SyncService? _syncService;
  final _customerStreamController = StreamController<List<Customer>>.broadcast();
  
  CustomerService({
    required DatabaseService databaseService,
    SyncService? syncService,
  })  : _databaseService = databaseService,
        _syncService = syncService;
  
  Stream<List<Customer>> get customersStream => _customerStreamController.stream;
  
  // Create a new customer
  Future<Customer> createCustomer(Customer customer) async {
    try {
      final now = DateTime.now();
      final newCustomer = customer.copyWith(
        id: _generateCustomerId(),
        customerCode: customer.customerCode ?? _generateCustomerCode(),
        createdAt: now,
        updatedAt: now,
      );
      
      // Save to local database
      await _databaseService.insert('customers', newCustomer.toJson());
      
      // Add to sync queue
      if (_syncService != null) {
        await _syncService.addToSyncQueue(
          tableName: 'customers',
          operation: 'create',
          recordId: newCustomer.id,
          data: newCustomer.toJson(),
        );
      }
      
      Logger.info('Customer created: ${newCustomer.id}');
      await _refreshCustomerStream();
      
      return newCustomer;
    } catch (e) {
      Logger.error('Failed to create customer', error: e);
      rethrow;
    }
  }
  
  // Update an existing customer
  Future<Customer> updateCustomer(Customer customer) async {
    try {
      final updatedCustomer = customer.copyWith(
        updatedAt: DateTime.now(),
      );
      
      await _databaseService.update(
        'customers',
        updatedCustomer.toJson(),
        where: 'id = ?',
        whereArgs: [customer.id],
      );
      
      // Add to sync queue
      if (_syncService != null) {
        await _syncService.addToSyncQueue(
          tableName: 'customers',
          operation: 'update',
          recordId: updatedCustomer.id,
          data: updatedCustomer.toJson(),
        );
      }
      
      Logger.info('Customer updated: ${updatedCustomer.id}');
      await _refreshCustomerStream();
      
      return updatedCustomer;
    } catch (e) {
      Logger.error('Failed to update customer', error: e);
      rethrow;
    }
  }
  
  // Delete a customer
  Future<void> deleteCustomer(String customerId) async {
    try {
      // Check if customer has transactions
      final hasTransactions = await _hasTransactions(customerId);
      if (hasTransactions) {
        throw Exception('Cannot delete customer with existing transactions');
      }
      
      await _databaseService.delete(
        'customers',
        where: 'id = ?',
        whereArgs: [customerId],
      );
      
      // Add to sync queue
      if (_syncService != null) {
        await _syncService.addToSyncQueue(
          tableName: 'customers',
          operation: 'delete',
          recordId: customerId,
          data: {'id': customerId},
        );
      }
      
      Logger.info('Customer deleted: $customerId');
      await _refreshCustomerStream();
    } catch (e) {
      Logger.error('Failed to delete customer', error: e);
      rethrow;
    }
  }
  
  // Get a single customer by ID
  Future<Customer?> getCustomerById(String customerId) async {
    try {
      final result = await _databaseService.findById('customers', customerId);
      if (result == null) return null;
      
      return Customer.fromJson(result);
    } catch (e) {
      Logger.error('Failed to get customer by ID', error: e);
      rethrow;
    }
  }
  
  // Get customer by code
  Future<Customer?> getCustomerByCode(String customerCode, String organizationId) async {
    try {
      final results = await _databaseService.query(
        'customers',
        where: 'customer_code = ? AND organization_id = ?',
        whereArgs: [customerCode, organizationId],
        limit: 1,
      );
      
      if (results.isEmpty) return null;
      return Customer.fromJson(results.first);
    } catch (e) {
      Logger.error('Failed to get customer by code', error: e);
      rethrow;
    }
  }
  
  // Get customer by phone
  Future<Customer?> getCustomerByPhone(String phone, String organizationId) async {
    try {
      final results = await _databaseService.query(
        'customers',
        where: 'phone = ? AND organization_id = ?',
        whereArgs: [phone, organizationId],
        limit: 1,
      );
      
      if (results.isEmpty) return null;
      return Customer.fromJson(results.first);
    } catch (e) {
      Logger.error('Failed to get customer by phone', error: e);
      rethrow;
    }
  }
  
  // Get all customers for an organization
  Future<List<Customer>> getCustomers({
    required String organizationId,
    String? groupId,
    bool? isActive,
    String? searchQuery,
    String? sortBy,
    bool ascending = true,
    int? limit,
    int? offset,
  }) async {
    try {
      final whereConditions = <String>['organization_id = ?'];
      final whereArgs = <dynamic>[organizationId];
      
      if (groupId != null) {
        whereConditions.add('group_id = ?');
        whereArgs.add(groupId);
      }
      
      if (isActive != null) {
        whereConditions.add('is_active = ?');
        whereArgs.add(isActive ? 1 : 0);
      }
      
      if (searchQuery != null && searchQuery.isNotEmpty) {
        whereConditions.add(
          '(name LIKE ? OR email LIKE ? OR phone LIKE ? OR customer_code LIKE ?)'
        );
        final searchPattern = '%$searchQuery%';
        whereArgs.addAll([searchPattern, searchPattern, searchPattern, searchPattern]);
      }
      
      String? orderBy;
      if (sortBy != null) {
        orderBy = '$sortBy ${ascending ? 'ASC' : 'DESC'}';
      }
      
      final results = await _databaseService.query(
        'customers',
        where: whereConditions.join(' AND '),
        whereArgs: whereArgs,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
      
      return results.map((json) => Customer.fromJson(json)).toList();
    } catch (e) {
      Logger.error('Failed to get customers', error: e);
      rethrow;
    }
  }
  
  // Get customers with outstanding credit
  Future<List<Customer>> getCustomersWithCredit(String organizationId) async {
    try {
      final results = await _databaseService.query(
        'customers',
        where: 'organization_id = ? AND credit_balance > 0',
        whereArgs: [organizationId],
        orderBy: 'credit_balance DESC',
      );
      
      return results.map((json) => Customer.fromJson(json)).toList();
    } catch (e) {
      Logger.error('Failed to get customers with credit', error: e);
      rethrow;
    }
  }
  
  // Update customer credit
  Future<Customer> updateCustomerCredit(
    String customerId,
    double amount, {
    String? reason,
    String? referenceId,
  }) async {
    try {
      final customer = await getCustomerById(customerId);
      if (customer == null) {
        throw Exception('Customer not found');
      }
      
      final newCreditBalance = customer.creditBalance + amount;
      if (newCreditBalance < 0) {
        throw Exception('Credit balance cannot be negative');
      }
      
      if (newCreditBalance > customer.creditLimit) {
        throw Exception('Credit balance exceeds credit limit');
      }
      
      // Update customer credit
      final updatedCustomer = customer.copyWith(
        creditBalance: newCreditBalance,
        lastPurchaseAt: amount < 0 ? DateTime.now() : customer.lastPurchaseAt,
      );
      
      await updateCustomer(updatedCustomer);
      
      // Record credit transaction
      await _databaseService.insert('credit_transactions', {
        'id': _generateTransactionId(),
        'customer_id': customerId,
        'organization_id': customer.organizationId,
        'amount': amount,
        'balance_after': newCreditBalance,
        'reason': reason,
        'reference_id': referenceId,
        'created_at': DateTime.now().millisecondsSinceEpoch,
      });
      
      return updatedCustomer;
    } catch (e) {
      Logger.error('Failed to update customer credit', error: e);
      rethrow;
    }
  }
  
  // Update loyalty points
  Future<Customer> updateLoyaltyPoints(
    String customerId,
    int points, {
    String? reason,
    String? referenceId,
  }) async {
    try {
      final customer = await getCustomerById(customerId);
      if (customer == null) {
        throw Exception('Customer not found');
      }
      
      final newPoints = customer.loyaltyPoints + points;
      if (newPoints < 0) {
        throw Exception('Loyalty points cannot be negative');
      }
      
      // Update customer points
      final updatedCustomer = customer.copyWith(
        loyaltyPoints: newPoints,
        totalLoyaltyPointsEarned: points > 0 
            ? customer.totalLoyaltyPointsEarned + points 
            : customer.totalLoyaltyPointsEarned,
        totalLoyaltyPointsRedeemed: points < 0 
            ? customer.totalLoyaltyPointsRedeemed + points.abs() 
            : customer.totalLoyaltyPointsRedeemed,
      );
      
      await updateCustomer(updatedCustomer);
      
      // Record loyalty transaction
      await _databaseService.insert('loyalty_transactions', {
        'id': _generateTransactionId(),
        'customer_id': customerId,
        'organization_id': customer.organizationId,
        'points': points,
        'balance_after': newPoints,
        'reason': reason,
        'reference_id': referenceId,
        'created_at': DateTime.now().millisecondsSinceEpoch,
      });
      
      return updatedCustomer;
    } catch (e) {
      Logger.error('Failed to update loyalty points', error: e);
      rethrow;
    }
  }
  
  // Search customers
  Future<List<Customer>> searchCustomers(
    String query,
    String organizationId, {
    int limit = 20,
  }) async {
    try {
      final searchPattern = '%$query%';
      final results = await _databaseService.query(
        'customers',
        where: 'organization_id = ? AND (name LIKE ? OR email LIKE ? OR phone LIKE ?)',
        whereArgs: [organizationId, searchPattern, searchPattern, searchPattern],
        limit: limit,
      );
      
      return results.map((json) => Customer.fromJson(json)).toList();
    } catch (e) {
      Logger.error('Failed to search customers', error: e);
      rethrow;
    }
  }
  
  // Get customer purchase history
  Future<List<Map<String, dynamic>>> getCustomerPurchaseHistory(
    String customerId, {
    int limit = 50,
  }) async {
    try {
      final results = await _databaseService.query(
        'sales',
        where: 'customer_id = ?',
        whereArgs: [customerId],
        orderBy: 'created_at DESC',
        limit: limit,
      );
      
      return results;
    } catch (e) {
      Logger.error('Failed to get customer purchase history', error: e);
      rethrow;
    }
  }
  
  // Get customer statistics
  Future<Map<String, dynamic>> getCustomerStats(String customerId) async {
    try {
      final customer = await getCustomerById(customerId);
      if (customer == null) {
        throw Exception('Customer not found');
      }
      
      // Get total purchases
      final purchaseStats = await _databaseService.rawQuery('''
        SELECT 
          COUNT(*) as total_orders,
          SUM(total_amount) as total_spent,
          AVG(total_amount) as average_order_value,
          MAX(created_at) as last_purchase_date
        FROM sales
        WHERE customer_id = ?
      ''', [customerId]);
      
      return {
        'customer': customer.toJson(),
        'stats': purchaseStats.isNotEmpty ? purchaseStats.first : {},
      };
    } catch (e) {
      Logger.error('Failed to get customer stats', error: e);
      rethrow;
    }
  }
  
  // Bulk import customers
  Future<List<Customer>> bulkImportCustomers(
    List<Customer> customers,
    String organizationId,
  ) async {
    try {
      final importedCustomers = <Customer>[];
      
      await _databaseService.transaction((txn) async {
        for (final customer in customers) {
          final now = DateTime.now();
          final newCustomer = customer.copyWith(
            id: _generateCustomerId(),
            customerCode: customer.customerCode ?? _generateCustomerCode(),
            organizationId: organizationId,
            createdAt: now,
            updatedAt: now,
          );
          
          await txn.insert('customers', newCustomer.toJson());
          importedCustomers.add(newCustomer);
        }
      });
      
      // Add to sync queue
      if (_syncService != null) {
        for (final customer in importedCustomers) {
          await _syncService.addToSyncQueue(
            tableName: 'customers',
            operation: 'create',
            recordId: customer.id,
            data: customer.toJson(),
          );
        }
      }
      
      Logger.info('Bulk imported ${importedCustomers.length} customers');
      await _refreshCustomerStream();
      
      return importedCustomers;
    } catch (e) {
      Logger.error('Failed to bulk import customers', error: e);
      rethrow;
    }
  }
  
  // Private helper methods
  String _generateCustomerId() {
    return 'cust_${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}';
  }
  
  String _generateCustomerCode() {
    return 'C${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}';
  }
  
  String _generateTransactionId() {
    return 'txn_${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}';
  }
  
  Future<bool> _hasTransactions(String customerId) async {
    final count = await _databaseService.count(
      'sales',
      where: 'customer_id = ?',
      whereArgs: [customerId],
    );
    return count > 0;
  }
  
  Future<void> _refreshCustomerStream() async {
    // This would typically emit the current customer list to the stream
    // Implementation depends on current context/organization
  }
  
  void dispose() {
    _customerStreamController.close();
  }
}