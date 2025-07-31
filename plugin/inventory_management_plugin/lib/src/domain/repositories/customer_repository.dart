import '../entities/customer.dart';
import '../entities/sale.dart';
import 'base_repository.dart';

/// Repository interface for Customer entity
abstract class CustomerRepository extends BaseRepository<Customer> {
  /// Get customer by phone number
  Future<Customer?> getByPhone(String phone, {String? organizationId});
  
  /// Get customer by email
  Future<Customer?> getByEmail(String email, {String? organizationId});
  
  /// Get customer by code
  Future<Customer?> getByCode(String code, {String? organizationId});
  
  /// Get customers by type
  Future<List<Customer>> getByType(CustomerType type, {String? organizationId});
  
  /// Update customer balance
  Future<void> updateBalance(String customerId, double amount);
  
  /// Add loyalty points
  Future<void> addLoyaltyPoints(String customerId, int points);
  
  /// Redeem loyalty points
  Future<bool> redeemLoyaltyPoints(String customerId, int points);
  
  /// Get customer purchase history
  Future<List<Sale>> getPurchaseHistory(
    String customerId, {
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
  });
  
  /// Get customer statistics
  Future<CustomerStatistics> getStatistics(String customerId);
  
  /// Get customers with outstanding balance
  Future<List<Customer>> getCustomersWithBalance({String? organizationId});
  
  /// Get top customers by revenue
  Future<List<CustomerRevenue>> getTopCustomers({
    String? organizationId,
    DateTime? startDate,
    DateTime? endDate,
    int limit = 10,
  });
  
  /// Search customers
  Future<List<Customer>> searchCustomers(String query, {String? organizationId});
  
  /// Get customers by city
  Future<List<Customer>> getByCity(String city, {String? organizationId});
  
  /// Get customers by state
  Future<List<Customer>> getByState(String state, {String? organizationId});
  
  /// Merge duplicate customers
  Future<Customer> mergeCustomers(String primaryId, List<String> duplicateIds);
}