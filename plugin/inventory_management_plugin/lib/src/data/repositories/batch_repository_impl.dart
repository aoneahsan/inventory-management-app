import 'dart:async';
import '../../domain/entities/batch.dart';
import '../../domain/repositories/batch_repository.dart';
import '../database/app_database.dart';
import '../models/batch_model.dart';
import '../database/tables/batches_table.dart';
import '../../core/utils/logger.dart';

/// Implementation of BatchRepository using Drift
class BatchRepositoryImpl implements BatchRepository {
  final AppDatabase _database;
  final _batchStreamController = StreamController<List<Batch>>.broadcast();

  BatchRepositoryImpl(this._database);

  @override
  Future<Batch?> getBatchById(String id) async {
    try {
      final query = _database.select(_database.batches)
        ..where((b) => b.id.equals(id));
      final result = await query.getSingleOrNull();
      
      if (result != null) {
        return _convertToEntity(result);
      }
      return null;
    } catch (e) {
      Logger.error('Error getting batch by ID: $e');
      rethrow;
    }
  }

  @override
  Future<Batch?> getBatchByNumber(String batchNumber) async {
    try {
      final query = _database.select(_database.batches)
        ..where((b) => b.batchNumber.equals(batchNumber));
      final result = await query.getSingleOrNull();
      
      if (result != null) {
        return _convertToEntity(result);
      }
      return null;
    } catch (e) {
      Logger.error('Error getting batch by number: $e');
      rethrow;
    }
  }

  @override
  Future<List<Batch>> getAllBatches() async {
    try {
      final results = await _database.select(_database.batches).get();
      return results.map((b) => _convertToEntity(b)).toList();
    } catch (e) {
      Logger.error('Error getting all batches: $e');
      rethrow;
    }
  }

  @override
  Future<List<Batch>> getBatchesByProduct(String productId) async {
    try {
      final query = _database.select(_database.batches)
        ..where((b) => b.productId.equals(productId))
        ..orderBy([(b) => OrderingTerm.desc(b.expiryDate)]);
      
      final results = await query.get();
      return results.map((b) => _convertToEntity(b)).toList();
    } catch (e) {
      Logger.error('Error getting batches by product: $e');
      rethrow;
    }
  }

  @override
  Future<List<Batch>> getActiveBatches(String productId) async {
    try {
      final now = DateTime.now();
      final query = _database.select(_database.batches)
        ..where((b) => 
          b.productId.equals(productId) & 
          b.quantity.isBiggerThanValue(0) &
          (b.expiryDate.isNull() | b.expiryDate.isBiggerThanValue(now)))
        ..orderBy([(b) => OrderingTerm.asc(b.expiryDate)]);
      
      final results = await query.get();
      return results.map((b) => _convertToEntity(b)).toList();
    } catch (e) {
      Logger.error('Error getting active batches: $e');
      rethrow;
    }
  }

  @override
  Future<List<Batch>> getExpiringBatches(int daysBeforeExpiry) async {
    try {
      final now = DateTime.now();
      final expiryThreshold = now.add(Duration(days: daysBeforeExpiry));
      
      final query = _database.select(_database.batches)
        ..where((b) => 
          b.expiryDate.isNotNull() &
          b.expiryDate.isSmallerOrEqualValue(expiryThreshold) &
          b.expiryDate.isBiggerThanValue(now) &
          b.quantity.isBiggerThanValue(0))
        ..orderBy([(b) => OrderingTerm.asc(b.expiryDate)]);
      
      final results = await query.get();
      return results.map((b) => _convertToEntity(b)).toList();
    } catch (e) {
      Logger.error('Error getting expiring batches: $e');
      rethrow;
    }
  }

  @override
  Future<List<Batch>> getExpiredBatches() async {
    try {
      final now = DateTime.now();
      final query = _database.select(_database.batches)
        ..where((b) => 
          b.expiryDate.isNotNull() &
          b.expiryDate.isSmallerThanValue(now) &
          b.quantity.isBiggerThanValue(0))
        ..orderBy([(b) => OrderingTerm.desc(b.expiryDate)]);
      
      final results = await query.get();
      return results.map((b) => _convertToEntity(b)).toList();
    } catch (e) {
      Logger.error('Error getting expired batches: $e');
      rethrow;
    }
  }

  @override
  Future<List<Batch>> getLowStockBatches(double threshold) async {
    try {
      final query = _database.select(_database.batches)
        ..where((b) => 
          b.quantity.isBiggerThanValue(0) &
          b.quantity.isSmallerOrEqualValue(threshold))
        ..orderBy([(b) => OrderingTerm.asc(b.quantity)]);
      
      final results = await query.get();
      return results.map((b) => _convertToEntity(b)).toList();
    } catch (e) {
      Logger.error('Error getting low stock batches: $e');
      rethrow;
    }
  }

  @override
  Future<List<Batch>> getPendingSyncBatches() async {
    try {
      final query = _database.select(_database.batches)
        ..where((b) => b.syncStatus.equals('pending'))
        ..orderBy([(b) => OrderingTerm.asc(b.createdAt)]);
      
      final results = await query.get();
      return results.map((b) => _convertToEntity(b)).toList();
    } catch (e) {
      Logger.error('Error getting pending sync batches: $e');
      rethrow;
    }
  }

  @override
  Future<Batch> createBatch(Batch batch) async {
    try {
      final model = _convertToModel(batch);
      final id = await _database.into(_database.batches).insert(model);
      
      // Notify listeners
      _notifyListeners();
      
      return batch.copyWith(id: id.toString());
    } catch (e) {
      Logger.error('Error creating batch: $e');
      rethrow;
    }
  }

  @override
  Future<Batch> updateBatch(Batch batch) async {
    try {
      final model = _convertToModel(batch);
      final updated = await (_database.update(_database.batches)
        ..where((b) => b.id.equals(batch.id)))
        .write(model);
      
      if (updated > 0) {
        _notifyListeners();
        return batch;
      } else {
        throw Exception('Batch not found');
      }
    } catch (e) {
      Logger.error('Error updating batch: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteBatch(String id) async {
    try {
      final deleted = await (_database.delete(_database.batches)
        ..where((b) => b.id.equals(id)))
        .go();
      
      if (deleted > 0) {
        _notifyListeners();
      } else {
        throw Exception('Batch not found');
      }
    } catch (e) {
      Logger.error('Error deleting batch: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateBatchQuantity(String id, double newQuantity) async {
    try {
      await (_database.update(_database.batches)
        ..where((b) => b.id.equals(id)))
        .write(BatchesCompanion(
          quantity: Value(newQuantity),
          updatedAt: Value(DateTime.now()),
        ));
      
      _notifyListeners();
    } catch (e) {
      Logger.error('Error updating batch quantity: $e');
      rethrow;
    }
  }

  @override
  Future<void> markBatchAsSynced(String id) async {
    try {
      await (_database.update(_database.batches)
        ..where((b) => b.id.equals(id)))
        .write(const BatchesCompanion(
          syncStatus: Value('synced'),
          syncedAt: Value.ofNullable(DateTime.now()),
        ));
      
      _notifyListeners();
    } catch (e) {
      Logger.error('Error marking batch as synced: $e');
      rethrow;
    }
  }

  @override
  Stream<List<Batch>> watchBatches() {
    return _batchStreamController.stream;
  }

  @override
  Stream<List<Batch>> watchBatchesByProduct(String productId) {
    return _database.select(_database.batches)
      .where((b) => b.productId.equals(productId))
      .watch()
      .map((batches) => batches.map((b) => _convertToEntity(b)).toList());
  }

  @override
  Stream<Batch?> watchBatch(String id) {
    return (_database.select(_database.batches)
      ..where((b) => b.id.equals(id)))
      .watchSingleOrNull()
      .map((batch) => batch != null ? _convertToEntity(batch) : null);
  }

  @override
  void dispose() {
    _batchStreamController.close();
  }

  void _notifyListeners() async {
    final batches = await getAllBatches();
    _batchStreamController.add(batches);
  }

  Batch _convertToEntity(BatchesData data) {
    return Batch(
      id: data.id,
      organizationId: data.organizationId,
      branchId: data.branchId,
      productId: data.productId,
      batchNumber: data.batchNumber,
      manufacturingDate: data.manufacturingDate,
      expiryDate: data.expiryDate,
      quantity: data.quantity,
      unitCost: data.unitCost,
      supplierId: data.supplierId,
      purchaseOrderId: data.purchaseOrderId,
      notes: data.notes,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      syncStatus: data.syncStatus,
      syncedAt: data.syncedAt,
    );
  }

  BatchesCompanion _convertToModel(Batch batch) {
    return BatchesCompanion(
      id: Value(batch.id),
      organizationId: Value(batch.organizationId),
      branchId: Value(batch.branchId),
      productId: Value(batch.productId),
      batchNumber: Value(batch.batchNumber),
      manufacturingDate: Value.ofNullable(batch.manufacturingDate),
      expiryDate: Value.ofNullable(batch.expiryDate),
      quantity: Value(batch.quantity),
      unitCost: Value(batch.unitCost),
      supplierId: Value.ofNullable(batch.supplierId),
      purchaseOrderId: Value.ofNullable(batch.purchaseOrderId),
      notes: Value.ofNullable(batch.notes),
      createdAt: Value(batch.createdAt),
      updatedAt: Value(batch.updatedAt),
      syncStatus: Value(batch.syncStatus),
      syncedAt: Value.ofNullable(batch.syncedAt),
    );
  }
}