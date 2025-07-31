import '../entities/branch.dart';
import '../entities/branch_inventory.dart';
import '../entities/user.dart';
import 'base_repository.dart';

/// Repository interface for Branch entity
abstract class BranchRepository extends BaseRepository<Branch> {
  /// Get branch by code
  Future<Branch?> getByCode(String code, {String? organizationId});
  
  /// Get branches by type
  Future<List<Branch>> getByType(BranchType type, {String? organizationId});
  
  /// Get warehouses only
  Future<List<Branch>> getWarehouses({String? organizationId});
  
  /// Get stores only
  Future<List<Branch>> getStores({String? organizationId});
  
  /// Get branches that can sell
  Future<List<Branch>> getSellableBranches({String? organizationId});
  
  /// Get branch inventory
  Future<List<BranchInventory>> getInventory(String branchId, {
    String? productId,
    bool lowStockOnly = false,
  });
  
  /// Get branch users
  Future<List<User>> getBranchUsers(String branchId);
  
  /// Get branch manager
  Future<User?> getBranchManager(String branchId);
  
  /// Assign manager to branch
  Future<void> assignManager(String branchId, String userId);
  
  /// Transfer inventory between branches
  Future<String> transferInventory({
    required String fromBranchId,
    required String toBranchId,
    required List<TransferItem> items,
    String? notes,
  });
  
  /// Get branch statistics
  Future<BranchStatistics> getStatistics(
    String branchId, {
    DateTime? startDate,
    DateTime? endDate,
  });
  
  /// Get branch performance metrics
  Future<BranchPerformance> getPerformance(
    String branchId, {
    DateTime? startDate,
    DateTime? endDate,
  });
  
  /// Search branches
  Future<List<Branch>> searchBranches(String query, {String? organizationId});
  
  /// Get branches by city
  Future<List<Branch>> getByCity(String city, {String? organizationId});
  
  /// Get branches by state
  Future<List<Branch>> getByState(String state, {String? organizationId});
  
  /// Check product availability across branches
  Future<List<BranchStock>> checkProductAvailability(
    String productId, {
    String? organizationId,
  });
}