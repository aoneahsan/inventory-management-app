import '../entities/sale.dart';
import '../entities/sale_item.dart';
import '../entities/receipt.dart';
import 'base_repository.dart';

/// Repository interface for Sale entity
abstract class SaleRepository extends BaseRepository<Sale> {
  /// Get sale by sale number
  Future<Sale?> getBySaleNumber(String saleNumber, {String? organizationId});
  
  /// Get sales by branch
  Future<List<Sale>> getByBranch(String branchId, {
    DateTime? startDate,
    DateTime? endDate,
    SaleStatus? status,
  });
  
  /// Get sales by customer
  Future<List<Sale>> getByCustomer(String customerId, {
    DateTime? startDate,
    DateTime? endDate,
  });
  
  /// Get sales by cashier
  Future<List<Sale>> getByCashier(String cashierId, {
    DateTime? startDate,
    DateTime? endDate,
  });
  
  /// Get sales by payment method
  Future<List<Sale>> getByPaymentMethod(PaymentMethod method, {
    String? organizationId,
    DateTime? startDate,
    DateTime? endDate,
  });
  
  /// Get sales by status
  Future<List<Sale>> getByStatus(SaleStatus status, {
    String? organizationId,
    String? branchId,
  });
  
  /// Get sale items
  Future<List<SaleItem>> getSaleItems(String saleId);
  
  /// Create sale with items
  Future<Sale> createSaleWithItems(Sale sale, List<SaleItem> items);
  
  /// Void sale
  Future<bool> voidSale(String saleId, String reason, String voidedBy);
  
  /// Return sale items
  Future<Sale> returnItems({
    required String originalSaleId,
    required List<ReturnItem> items,
    required String reason,
    required String processedBy,
  });
  
  /// Get sales summary
  Future<SalesSummary> getSummary({
    String? organizationId,
    String? branchId,
    required DateTime startDate,
    required DateTime endDate,
  });
  
  /// Get sales by date range
  Future<List<Sale>> getByDateRange({
    String? organizationId,
    String? branchId,
    required DateTime startDate,
    required DateTime endDate,
  });
  
  /// Get daily sales report
  Future<DailySalesReport> getDailySalesReport({
    String? organizationId,
    String? branchId,
    required DateTime date,
  });
  
  /// Get product sales report
  Future<List<ProductSalesReport>> getProductSalesReport({
    String? organizationId,
    String? branchId,
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
  });
  
  /// Generate receipt
  Future<Receipt> generateReceipt(String saleId);
  
  /// Email receipt
  Future<bool> emailReceipt(String saleId, String email);
  
  /// Get payment summary
  Future<PaymentSummary> getPaymentSummary({
    String? organizationId,
    String? branchId,
    required DateTime startDate,
    required DateTime endDate,
  });
}