import 'dart:async';
import '../../domain/entities/tax_rate.dart';
import '../../domain/repositories/tax_rate_repository.dart';
import '../../core/utils/logger.dart';
import '../sync/sync_service.dart';

/// Service for managing tax calculations and rates
class TaxService {
  final TaxRateRepository _taxRepository;
  final SyncService? _syncService;
  
  TaxService({
    required TaxRateRepository taxRepository,
    SyncService? syncService,
  })  : _taxRepository = taxRepository,
        _syncService = syncService;
  
  /// Calculate tax for a given amount
  Future<double> calculateTax({
    required double amount,
    required String taxRateId,
    bool isInclusive = false,
  }) async {
    try {
      final taxRate = await _taxRepository.getById(taxRateId);
      if (taxRate == null) throw Exception('Tax rate not found');
      
      if (!taxRate.isActive) {
        throw Exception('Tax rate is not active');
      }
      
      if (isInclusive) {
        // Tax is included in the amount
        return amount - (amount / (1 + taxRate.rate / 100));
      } else {
        // Tax needs to be added
        return amount * (taxRate.rate / 100);
      }
    } catch (e) {
      Logger.error('Failed to calculate tax', error: e);
      rethrow;
    }
  }
  
  /// Calculate compound tax
  Future<double> calculateCompoundTax({
    required double amount,
    required List<String> taxRateIds,
    bool isInclusive = false,
  }) async {
    try {
      double totalTax = 0;
      double baseAmount = amount;
      
      for (final taxRateId in taxRateIds) {
        final tax = await calculateTax(
          amount: baseAmount,
          taxRateId: taxRateId,
          isInclusive: false,
        );
        totalTax += tax;
        baseAmount += tax; // For compound calculation
      }
      
      if (isInclusive) {
        // Reverse calculate if tax was inclusive
        final totalRate = await _getTotalTaxRate(taxRateIds);
        return amount - (amount / (1 + totalRate / 100));
      }
      
      return totalTax;
    } catch (e) {
      Logger.error('Failed to calculate compound tax', error: e);
      rethrow;
    }
  }
  
  /// Create a new tax rate
  Future<TaxRate> createTaxRate({
    required String organizationId,
    required String name,
    required String code,
    required double rate,
    required TaxType type,
    String? description,
  }) async {
    try {
      final taxRate = TaxRate(
        id: _generateTaxRateId(),
        organizationId: organizationId,
        name: name,
        code: code,
        rate: rate,
        type: type,
        description: description,
        isActive: true,
        isDefault: false,
        createdAt: DateTime.now(),
        syncedAt: null,
      );
      
      final created = await _taxRepository.create(taxRate);
      
      if (_syncService != null) {
        await _syncService.addToSyncQueue(
          tableName: 'tax_rates',
          operation: 'create',
          recordId: created.id,
          data: created.toJson(),
        );
      }
      
      Logger.info('Tax rate created: ${created.id}');
      return created;
    } catch (e) {
      Logger.error('Failed to create tax rate', error: e);
      rethrow;
    }
  }
  
  /// Get applicable tax rates for a location
  Future<List<TaxRate>> getApplicableTaxRates({
    required String organizationId,
    String? state,
    String? city,
  }) async {
    try {
      final allRates = await _taxRepository.getByOrganizationId(organizationId);
      
      // Filter based on location if provided
      if (state != null || city != null) {
        return allRates.where((rate) {
          // Add location-based filtering logic
          return rate.isActive;
        }).toList();
      }
      
      return allRates.where((rate) => rate.isActive).toList();
    } catch (e) {
      Logger.error('Failed to get applicable tax rates', error: e);
      rethrow;
    }
  }
  
  /// Get default tax rate
  Future<TaxRate?> getDefaultTaxRate(String organizationId) async {
    try {
      return await _taxRepository.getDefault(organizationId);
    } catch (e) {
      Logger.error('Failed to get default tax rate', error: e);
      return null;
    }
  }
  
  /// Set default tax rate
  Future<void> setDefaultTaxRate(String taxRateId) async {
    try {
      await _taxRepository.setDefault(taxRateId);
      Logger.info('Default tax rate set: $taxRateId');
    } catch (e) {
      Logger.error('Failed to set default tax rate', error: e);
      rethrow;
    }
  }
  
  /// Helper method to calculate total tax rate
  Future<double> _getTotalTaxRate(List<String> taxRateIds) async {
    double totalRate = 0;
    
    for (final id in taxRateIds) {
      final taxRate = await _taxRepository.getById(id);
      if (taxRate != null && taxRate.isActive) {
        totalRate += taxRate.rate;
      }
    }
    
    return totalRate;
  }
  
  String _generateTaxRateId() => 'TAX${DateTime.now().millisecondsSinceEpoch}';
}