import 'dart:async';
import '../../domain/entities/tax_rate.dart';
import '../../domain/repositories/tax_rate_repository.dart';
import '../database/app_database.dart';
import '../models/tax_rate_model.dart';
import '../database/tables/tax_rates_table.dart';
import '../../core/utils/logger.dart';

/// Implementation of TaxRateRepository using Drift
class TaxRateRepositoryImpl implements TaxRateRepository {
  final AppDatabase _database;
  final _taxRateStreamController = StreamController<List<TaxRate>>.broadcast();

  TaxRateRepositoryImpl(this._database);

  @override
  Future<TaxRate?> getTaxRateById(String id) async {
    try {
      final query = _database.select(_database.taxRates)
        ..where((t) => t.id.equals(id));
      final result = await query.getSingleOrNull();
      
      if (result != null) {
        return _convertToEntity(result);
      }
      return null;
    } catch (e) {
      Logger.error('Error getting tax rate by ID: $e');
      rethrow;
    }
  }

  @override
  Future<List<TaxRate>> getAllTaxRates() async {
    try {
      final results = await _database.select(_database.taxRates).get();
      return results.map((t) => _convertToEntity(t)).toList();
    } catch (e) {
      Logger.error('Error getting all tax rates: $e');
      rethrow;
    }
  }

  @override
  Future<List<TaxRate>> getActiveTaxRates() async {
    try {
      final query = _database.select(_database.taxRates)
        ..where((t) => t.isActive.equals(true))
        ..orderBy([(t) => OrderingTerm.asc(t.name)]);
      
      final results = await query.get();
      return results.map((t) => _convertToEntity(t)).toList();
    } catch (e) {
      Logger.error('Error getting active tax rates: $e');
      rethrow;
    }
  }

  @override
  Future<List<TaxRate>> getTaxRatesByCategory(String categoryId) async {
    try {
      final query = _database.select(_database.taxRates)
        ..where((t) => t.applicableCategories.contains(categoryId))
        ..orderBy([(t) => OrderingTerm.asc(t.name)]);
      
      final results = await query.get();
      return results.map((t) => _convertToEntity(t)).toList();
    } catch (e) {
      Logger.error('Error getting tax rates by category: $e');
      rethrow;
    }
  }

  @override
  Future<List<TaxRate>> getTaxRatesByProduct(String productId) async {
    try {
      final query = _database.select(_database.taxRates)
        ..where((t) => t.applicableProducts.contains(productId))
        ..orderBy([(t) => OrderingTerm.asc(t.name)]);
      
      final results = await query.get();
      return results.map((t) => _convertToEntity(t)).toList();
    } catch (e) {
      Logger.error('Error getting tax rates by product: $e');
      rethrow;
    }
  }

  @override
  Future<TaxRate?> getDefaultTaxRate() async {
    try {
      final query = _database.select(_database.taxRates)
        ..where((t) => t.isDefault.equals(true))
        ..limit(1);
      
      final result = await query.getSingleOrNull();
      if (result != null) {
        return _convertToEntity(result);
      }
      return null;
    } catch (e) {
      Logger.error('Error getting default tax rate: $e');
      rethrow;
    }
  }

  @override
  Future<List<TaxRate>> getPendingSyncTaxRates() async {
    try {
      final query = _database.select(_database.taxRates)
        ..where((t) => t.syncStatus.equals('pending'))
        ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
      
      final results = await query.get();
      return results.map((t) => _convertToEntity(t)).toList();
    } catch (e) {
      Logger.error('Error getting pending sync tax rates: $e');
      rethrow;
    }
  }

  @override
  Future<double> calculateTax(double amount, List<String> taxRateIds) async {
    try {
      if (taxRateIds.isEmpty) return 0;
      
      final query = _database.select(_database.taxRates)
        ..where((t) => t.id.isIn(taxRateIds) & t.isActive.equals(true));
      
      final results = await query.get();
      double totalTax = 0;
      
      for (final taxRate in results) {
        if (taxRate.isCompound) {
          // Compound tax is calculated on amount + previous taxes
          totalTax += (amount + totalTax) * (taxRate.rate / 100);
        } else {
          // Simple tax is calculated only on the original amount
          totalTax += amount * (taxRate.rate / 100);
        }
      }
      
      return totalTax;
    } catch (e) {
      Logger.error('Error calculating tax: $e');
      rethrow;
    }
  }

  @override
  Future<TaxRate> createTaxRate(TaxRate taxRate) async {
    try {
      final model = _convertToModel(taxRate);
      final id = await _database.into(_database.taxRates).insert(model);
      
      // Notify listeners
      _notifyListeners();
      
      return taxRate.copyWith(id: id.toString());
    } catch (e) {
      Logger.error('Error creating tax rate: $e');
      rethrow;
    }
  }

  @override
  Future<TaxRate> updateTaxRate(TaxRate taxRate) async {
    try {
      final model = _convertToModel(taxRate);
      final updated = await (_database.update(_database.taxRates)
        ..where((t) => t.id.equals(taxRate.id)))
        .write(model);
      
      if (updated > 0) {
        _notifyListeners();
        return taxRate;
      } else {
        throw Exception('Tax rate not found');
      }
    } catch (e) {
      Logger.error('Error updating tax rate: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteTaxRate(String id) async {
    try {
      final deleted = await (_database.delete(_database.taxRates)
        ..where((t) => t.id.equals(id)))
        .go();
      
      if (deleted > 0) {
        _notifyListeners();
      } else {
        throw Exception('Tax rate not found');
      }
    } catch (e) {
      Logger.error('Error deleting tax rate: $e');
      rethrow;
    }
  }

  @override
  Future<void> markTaxRateAsSynced(String id) async {
    try {
      await (_database.update(_database.taxRates)
        ..where((t) => t.id.equals(id)))
        .write(const TaxRatesCompanion(
          syncStatus: Value('synced'),
          syncedAt: Value.ofNullable(DateTime.now()),
        ));
      
      _notifyListeners();
    } catch (e) {
      Logger.error('Error marking tax rate as synced: $e');
      rethrow;
    }
  }

  @override
  Stream<List<TaxRate>> watchTaxRates() {
    return _taxRateStreamController.stream;
  }

  @override
  Stream<List<TaxRate>> watchActiveTaxRates() {
    return _database.select(_database.taxRates)
      .where((t) => t.isActive.equals(true))
      .watch()
      .map((rates) => rates.map((t) => _convertToEntity(t)).toList());
  }

  @override
  void dispose() {
    _taxRateStreamController.close();
  }

  void _notifyListeners() async {
    final taxRates = await getAllTaxRates();
    _taxRateStreamController.add(taxRates);
  }

  TaxRate _convertToEntity(TaxRatesData data) {
    return TaxRate(
      id: data.id,
      organizationId: data.organizationId,
      name: data.name,
      rate: data.rate,
      description: data.description,
      isActive: data.isActive,
      isDefault: data.isDefault,
      isCompound: data.isCompound,
      applicableCategories: data.applicableCategories,
      applicableProducts: data.applicableProducts,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      syncStatus: data.syncStatus,
      syncedAt: data.syncedAt,
    );
  }

  TaxRatesCompanion _convertToModel(TaxRate taxRate) {
    return TaxRatesCompanion(
      id: Value(taxRate.id),
      organizationId: Value(taxRate.organizationId),
      name: Value(taxRate.name),
      rate: Value(taxRate.rate),
      description: Value.ofNullable(taxRate.description),
      isActive: Value(taxRate.isActive),
      isDefault: Value(taxRate.isDefault),
      isCompound: Value(taxRate.isCompound),
      applicableCategories: Value(taxRate.applicableCategories),
      applicableProducts: Value(taxRate.applicableProducts),
      createdAt: Value(taxRate.createdAt),
      updatedAt: Value(taxRate.updatedAt),
      syncStatus: Value(taxRate.syncStatus),
      syncedAt: Value.ofNullable(taxRate.syncedAt),
    );
  }
}