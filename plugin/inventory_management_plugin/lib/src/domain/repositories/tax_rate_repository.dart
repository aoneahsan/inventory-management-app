import '../entities/tax_rate.dart';
import 'base_repository.dart';

/// Repository interface for TaxRate entity
abstract class TaxRateRepository extends BaseRepository<TaxRate> {
  /// Get tax rate by code
  Future<TaxRate?> getByCode(String code, {String? organizationId});
  
  /// Get tax rates by type
  Future<List<TaxRate>> getByType(TaxType type, {String? organizationId});
  
  /// Get tax rates by HSN code
  Future<List<TaxRate>> getByHsnCode(String hsnCode, {String? organizationId});
  
  /// Get tax rates by SAC code
  Future<List<TaxRate>> getBySacCode(String sacCode, {String? organizationId});
  
  /// Get active tax rates
  Future<List<TaxRate>> getActiveTaxRates({
    String? organizationId,
    DateTime? asOfDate,
  });
  
  /// Get tax rates by country
  Future<List<TaxRate>> getByCountry(String country, {
    String? state,
    bool activeOnly = true,
  });
  
  /// Get applicable tax rates
  Future<List<TaxRate>> getApplicableTaxRates({
    required String productId,
    required String fromLocation,
    required String toLocation,
    required DateTime transactionDate,
  });
  
  /// Calculate tax amount
  Future<TaxCalculation> calculateTax({
    required double amount,
    required List<String> taxRateIds,
    bool isInclusive = false,
  });
  
  /// Get tax summary for period
  Future<TaxSummary> getTaxSummary({
    String? organizationId,
    String? branchId,
    required DateTime startDate,
    required DateTime endDate,
  });
  
  /// Get GST summary
  Future<GSTSummary> getGSTSummary({
    String? organizationId,
    required DateTime startDate,
    required DateTime endDate,
  });
  
  /// Validate tax configuration
  Future<TaxValidation> validateTaxConfiguration({
    required String organizationId,
    required String productId,
  });
}