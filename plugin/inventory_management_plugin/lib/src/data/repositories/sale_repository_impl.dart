import 'dart:async';
import '../../domain/entities/sale.dart';
import '../../domain/repositories/sale_repository.dart';
import '../database/app_database.dart';
import '../models/sale_model.dart';
import '../database/tables/sales_table.dart';
import '../../core/utils/logger.dart';

/// Implementation of SaleRepository using Drift
class SaleRepositoryImpl implements SaleRepository {
  final AppDatabase _database;
  final _saleStreamController = StreamController<List<Sale>>.broadcast();

  SaleRepositoryImpl(this._database);

  @override
  Future<Sale?> getSaleById(String id) async {
    try {
      final query = _database.select(_database.sales)
        ..where((s) => s.id.equals(id));
      final result = await query.getSingleOrNull();
      
      if (result != null) {
        return _convertToEntity(result);
      }
      return null;
    } catch (e) {
      Logger.error('Error getting sale by ID: $e');
      rethrow;
    }
  }

  @override
  Future<List<Sale>> getAllSales() async {
    try {
      final results = await _database.select(_database.sales).get();
      return results.map((s) => _convertToEntity(s)).toList();
    } catch (e) {
      Logger.error('Error getting all sales: $e');
      rethrow;
    }
  }

  @override
  Future<List<Sale>> getSalesByDateRange(DateTime start, DateTime end) async {
    try {
      final query = _database.select(_database.sales)
        ..where((s) => s.createdAt.isBetweenValues(start, end))
        ..orderBy([(s) => OrderingTerm.desc(s.createdAt)]);
      
      final results = await query.get();
      return results.map((s) => _convertToEntity(s)).toList();
    } catch (e) {
      Logger.error('Error getting sales by date range: $e');
      rethrow;
    }
  }

  @override
  Future<List<Sale>> getSalesByBranch(String branchId) async {
    try {
      final query = _database.select(_database.sales)
        ..where((s) => s.branchId.equals(branchId))
        ..orderBy([(s) => OrderingTerm.desc(s.createdAt)]);
      
      final results = await query.get();
      return results.map((s) => _convertToEntity(s)).toList();
    } catch (e) {
      Logger.error('Error getting sales by branch: $e');
      rethrow;
    }
  }

  @override
  Future<List<Sale>> getSalesByCustomer(String customerId) async {
    try {
      final query = _database.select(_database.sales)
        ..where((s) => s.customerId.equals(customerId))
        ..orderBy([(s) => OrderingTerm.desc(s.createdAt)]);
      
      final results = await query.get();
      return results.map((s) => _convertToEntity(s)).toList();
    } catch (e) {
      Logger.error('Error getting sales by customer: $e');
      rethrow;
    }
  }

  @override
  Future<List<Sale>> getSalesByUser(String userId) async {
    try {
      final query = _database.select(_database.sales)
        ..where((s) => s.userId.equals(userId))
        ..orderBy([(s) => OrderingTerm.desc(s.createdAt)]);
      
      final results = await query.get();
      return results.map((s) => _convertToEntity(s)).toList();
    } catch (e) {
      Logger.error('Error getting sales by user: $e');
      rethrow;
    }
  }

  @override
  Future<List<Sale>> getPendingSyncSales() async {
    try {
      final query = _database.select(_database.sales)
        ..where((s) => s.syncStatus.equals('pending'))
        ..orderBy([(s) => OrderingTerm.asc(s.createdAt)]);
      
      final results = await query.get();
      return results.map((s) => _convertToEntity(s)).toList();
    } catch (e) {
      Logger.error('Error getting pending sync sales: $e');
      rethrow;
    }
  }

  @override
  Future<Sale> createSale(Sale sale) async {
    try {
      final model = _convertToModel(sale);
      final id = await _database.into(_database.sales).insert(model);
      
      // Notify listeners
      _notifyListeners();
      
      return sale.copyWith(id: id.toString());
    } catch (e) {
      Logger.error('Error creating sale: $e');
      rethrow;
    }
  }

  @override
  Future<Sale> updateSale(Sale sale) async {
    try {
      final model = _convertToModel(sale);
      final updated = await (_database.update(_database.sales)
        ..where((s) => s.id.equals(sale.id)))
        .write(model);
      
      if (updated > 0) {
        _notifyListeners();
        return sale;
      } else {
        throw Exception('Sale not found');
      }
    } catch (e) {
      Logger.error('Error updating sale: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteSale(String id) async {
    try {
      final deleted = await (_database.delete(_database.sales)
        ..where((s) => s.id.equals(id)))
        .go();
      
      if (deleted > 0) {
        _notifyListeners();
      } else {
        throw Exception('Sale not found');
      }
    } catch (e) {
      Logger.error('Error deleting sale: $e');
      rethrow;
    }
  }

  @override
  Future<void> markSaleAsSynced(String id) async {
    try {
      await (_database.update(_database.sales)
        ..where((s) => s.id.equals(id)))
        .write(const SalesCompanion(
          syncStatus: Value('synced'),
          syncedAt: Value.ofNullable(DateTime.now()),
        ));
      
      _notifyListeners();
    } catch (e) {
      Logger.error('Error marking sale as synced: $e');
      rethrow;
    }
  }

  @override
  Stream<List<Sale>> watchSales() {
    return _saleStreamController.stream;
  }

  @override
  Stream<List<Sale>> watchSalesByBranch(String branchId) {
    return _database.select(_database.sales)
      .where((s) => s.branchId.equals(branchId))
      .watch()
      .map((sales) => sales.map((s) => _convertToEntity(s)).toList());
  }

  @override
  Stream<Sale?> watchSale(String id) {
    return (_database.select(_database.sales)
      ..where((s) => s.id.equals(id)))
      .watchSingleOrNull()
      .map((sale) => sale != null ? _convertToEntity(sale) : null);
  }

  @override
  void dispose() {
    _saleStreamController.close();
  }

  void _notifyListeners() async {
    final sales = await getAllSales();
    _saleStreamController.add(sales);
  }

  Sale _convertToEntity(SalesData data) {
    return Sale(
      id: data.id,
      organizationId: data.organizationId,
      branchId: data.branchId,
      customerId: data.customerId,
      userId: data.userId,
      items: data.items,
      subtotal: data.subtotal,
      taxAmount: data.taxAmount,
      discountAmount: data.discountAmount,
      total: data.total,
      paymentMethod: data.paymentMethod,
      paymentStatus: data.paymentStatus,
      status: data.status,
      notes: data.notes,
      receiptNumber: data.receiptNumber,
      registerId: data.registerId,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      syncStatus: data.syncStatus,
      syncedAt: data.syncedAt,
    );
  }

  SalesCompanion _convertToModel(Sale sale) {
    return SalesCompanion(
      id: Value(sale.id),
      organizationId: Value(sale.organizationId),
      branchId: Value(sale.branchId),
      customerId: Value.ofNullable(sale.customerId),
      userId: Value(sale.userId),
      items: Value(sale.items),
      subtotal: Value(sale.subtotal),
      taxAmount: Value(sale.taxAmount),
      discountAmount: Value(sale.discountAmount),
      total: Value(sale.total),
      paymentMethod: Value(sale.paymentMethod),
      paymentStatus: Value(sale.paymentStatus),
      status: Value(sale.status),
      notes: Value.ofNullable(sale.notes),
      receiptNumber: Value.ofNullable(sale.receiptNumber),
      registerId: Value.ofNullable(sale.registerId),
      createdAt: Value(sale.createdAt),
      updatedAt: Value(sale.updatedAt),
      syncStatus: Value(sale.syncStatus),
      syncedAt: Value.ofNullable(sale.syncedAt),
    );
  }
}