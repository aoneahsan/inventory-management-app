import '../entities/supplier.dart';
import '../entities/purchase_order.dart';
import '../entities/supplier_transaction.dart';
import 'base_repository.dart';

/// Repository interface for Supplier entity
abstract class SupplierRepository extends BaseRepository<Supplier> {
  /// Get supplier by code
  Future<Supplier?> getByCode(String code, {String? organizationId});
  
  /// Get supplier by email
  Future<Supplier?> getByEmail(String email, {String? organizationId});
  
  /// Get supplier by phone
  Future<Supplier?> getByPhone(String phone, {String? organizationId});
  
  /// Update supplier balance
  Future<void> updateBalance(String supplierId, double amount);
  
  /// Get supplier purchase orders
  Future<List<PurchaseOrder>> getPurchaseOrders(
    String supplierId, {
    DateTime? startDate,
    DateTime? endDate,
    PurchaseOrderStatus? status,
  });
  
  /// Get supplier transactions
  Future<List<SupplierTransaction>> getTransactions(
    String supplierId, {
    DateTime? startDate,
    DateTime? endDate,
    TransactionType? type,
  });
  
  /// Get supplier statistics
  Future<SupplierStatistics> getStatistics(String supplierId);
  
  /// Get suppliers with outstanding balance
  Future<List<Supplier>> getSuppliersWithBalance({String? organizationId});
  
  /// Get top suppliers by purchase volume
  Future<List<SupplierVolume>> getTopSuppliers({
    String? organizationId,
    DateTime? startDate,
    DateTime? endDate,
    int limit = 10,
  });
  
  /// Search suppliers
  Future<List<Supplier>> searchSuppliers(String query, {String? organizationId});
  
  /// Get suppliers by product
  Future<List<Supplier>> getByProduct(String productId, {String? organizationId});
  
  /// Get suppliers by payment terms
  Future<List<Supplier>> getByPaymentTerms(String terms, {String? organizationId});
  
  /// Get supplier payment due
  Future<List<PaymentDue>> getPaymentsDue({
    String? organizationId,
    DateTime? dueDate,
  });
  
  /// Record payment to supplier
  Future<SupplierTransaction> recordPayment({
    required String supplierId,
    required double amount,
    required String paymentMethod,
    String? reference,
    String? notes,
  });
}