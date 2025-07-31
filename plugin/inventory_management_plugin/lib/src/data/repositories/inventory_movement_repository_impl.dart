import 'dart:async';
import '../../domain/entities/inventory_movement.dart';
import '../../domain/repositories/inventory_movement_repository.dart';
import '../database/app_database.dart';
import '../models/inventory_movement_model.dart';
import '../database/tables/inventory_movements_table.dart';
import '../../core/utils/logger.dart';

/// Implementation of InventoryMovementRepository using Drift
class InventoryMovementRepositoryImpl implements InventoryMovementRepository {
  final AppDatabase _database;
  final _movementStreamController = StreamController<List<InventoryMovement>>.broadcast();

  InventoryMovementRepositoryImpl(this._database);

  @override
  Future<InventoryMovement?> getMovementById(String id) async {
    try {
      final query = _database.select(_database.inventoryMovements)
        ..where((m) => m.id.equals(id));
      final result = await query.getSingleOrNull();
      
      if (result != null) {
        return _convertToEntity(result);
      }
      return null;
    } catch (e) {
      Logger.error('Error getting movement by ID: $e');
      rethrow;
    }
  }

  @override
  Future<List<InventoryMovement>> getAllMovements() async {
    try {
      final results = await _database.select(_database.inventoryMovements).get();
      return results.map((m) => _convertToEntity(m)).toList();
    } catch (e) {
      Logger.error('Error getting all movements: $e');
      rethrow;
    }
  }

  @override
  Future<List<InventoryMovement>> getMovementsByProduct(String productId) async {
    try {
      final query = _database.select(_database.inventoryMovements)
        ..where((m) => m.productId.equals(productId))
        ..orderBy([(m) => OrderingTerm.desc(m.createdAt)]);
      
      final results = await query.get();
      return results.map((m) => _convertToEntity(m)).toList();
    } catch (e) {
      Logger.error('Error getting movements by product: $e');
      rethrow;
    }
  }

  @override
  Future<List<InventoryMovement>> getMovementsByBranch(String branchId) async {
    try {
      final query = _database.select(_database.inventoryMovements)
        ..where((m) => m.branchId.equals(branchId))
        ..orderBy([(m) => OrderingTerm.desc(m.createdAt)]);
      
      final results = await query.get();
      return results.map((m) => _convertToEntity(m)).toList();
    } catch (e) {
      Logger.error('Error getting movements by branch: $e');
      rethrow;
    }
  }

  @override
  Future<List<InventoryMovement>> getMovementsByType(String type) async {
    try {
      final query = _database.select(_database.inventoryMovements)
        ..where((m) => m.movementType.equals(type))
        ..orderBy([(m) => OrderingTerm.desc(m.createdAt)]);
      
      final results = await query.get();
      return results.map((m) => _convertToEntity(m)).toList();
    } catch (e) {
      Logger.error('Error getting movements by type: $e');
      rethrow;
    }
  }

  @override
  Future<List<InventoryMovement>> getMovementsByDateRange(DateTime start, DateTime end) async {
    try {
      final query = _database.select(_database.inventoryMovements)
        ..where((m) => m.createdAt.isBetweenValues(start, end))
        ..orderBy([(m) => OrderingTerm.desc(m.createdAt)]);
      
      final results = await query.get();
      return results.map((m) => _convertToEntity(m)).toList();
    } catch (e) {
      Logger.error('Error getting movements by date range: $e');
      rethrow;
    }
  }

  @override
  Future<List<InventoryMovement>> getPendingSyncMovements() async {
    try {
      final query = _database.select(_database.inventoryMovements)
        ..where((m) => m.syncStatus.equals('pending'))
        ..orderBy([(m) => OrderingTerm.asc(m.createdAt)]);
      
      final results = await query.get();
      return results.map((m) => _convertToEntity(m)).toList();
    } catch (e) {
      Logger.error('Error getting pending sync movements: $e');
      rethrow;
    }
  }

  @override
  Future<double> getProductStock(String productId, String branchId) async {
    try {
      final query = _database.select(_database.inventoryMovements)
        ..where((m) => m.productId.equals(productId) & m.branchId.equals(branchId));
      
      final results = await query.get();
      double stock = 0;
      
      for (final movement in results) {
        if (['purchase', 'return', 'adjustment_in', 'transfer_in'].contains(movement.movementType)) {
          stock += movement.quantity;
        } else if (['sale', 'damage', 'adjustment_out', 'transfer_out'].contains(movement.movementType)) {
          stock -= movement.quantity;
        }
      }
      
      return stock;
    } catch (e) {
      Logger.error('Error calculating product stock: $e');
      rethrow;
    }
  }

  @override
  Future<InventoryMovement> createMovement(InventoryMovement movement) async {
    try {
      final model = _convertToModel(movement);
      final id = await _database.into(_database.inventoryMovements).insert(model);
      
      // Notify listeners
      _notifyListeners();
      
      return movement.copyWith(id: id.toString());
    } catch (e) {
      Logger.error('Error creating movement: $e');
      rethrow;
    }
  }

  @override
  Future<InventoryMovement> updateMovement(InventoryMovement movement) async {
    try {
      final model = _convertToModel(movement);
      final updated = await (_database.update(_database.inventoryMovements)
        ..where((m) => m.id.equals(movement.id)))
        .write(model);
      
      if (updated > 0) {
        _notifyListeners();
        return movement;
      } else {
        throw Exception('Movement not found');
      }
    } catch (e) {
      Logger.error('Error updating movement: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteMovement(String id) async {
    try {
      final deleted = await (_database.delete(_database.inventoryMovements)
        ..where((m) => m.id.equals(id)))
        .go();
      
      if (deleted > 0) {
        _notifyListeners();
      } else {
        throw Exception('Movement not found');
      }
    } catch (e) {
      Logger.error('Error deleting movement: $e');
      rethrow;
    }
  }

  @override
  Future<void> markMovementAsSynced(String id) async {
    try {
      await (_database.update(_database.inventoryMovements)
        ..where((m) => m.id.equals(id)))
        .write(const InventoryMovementsCompanion(
          syncStatus: Value('synced'),
          syncedAt: Value.ofNullable(DateTime.now()),
        ));
      
      _notifyListeners();
    } catch (e) {
      Logger.error('Error marking movement as synced: $e');
      rethrow;
    }
  }

  @override
  Stream<List<InventoryMovement>> watchMovements() {
    return _movementStreamController.stream;
  }

  @override
  Stream<List<InventoryMovement>> watchMovementsByProduct(String productId) {
    return _database.select(_database.inventoryMovements)
      .where((m) => m.productId.equals(productId))
      .watch()
      .map((movements) => movements.map((m) => _convertToEntity(m)).toList());
  }

  @override
  Stream<double> watchProductStock(String productId, String branchId) {
    return _database.select(_database.inventoryMovements)
      .where((m) => m.productId.equals(productId) & m.branchId.equals(branchId))
      .watch()
      .map((movements) {
        double stock = 0;
        for (final movement in movements) {
          if (['purchase', 'return', 'adjustment_in', 'transfer_in'].contains(movement.movementType)) {
            stock += movement.quantity;
          } else if (['sale', 'damage', 'adjustment_out', 'transfer_out'].contains(movement.movementType)) {
            stock -= movement.quantity;
          }
        }
        return stock;
      });
  }

  @override
  void dispose() {
    _movementStreamController.close();
  }

  void _notifyListeners() async {
    final movements = await getAllMovements();
    _movementStreamController.add(movements);
  }

  InventoryMovement _convertToEntity(InventoryMovementsData data) {
    return InventoryMovement(
      id: data.id,
      organizationId: data.organizationId,
      branchId: data.branchId,
      productId: data.productId,
      movementType: data.movementType,
      quantity: data.quantity,
      unitCost: data.unitCost,
      totalCost: data.totalCost,
      referenceType: data.referenceType,
      referenceId: data.referenceId,
      batchId: data.batchId,
      notes: data.notes,
      performedBy: data.performedBy,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      syncStatus: data.syncStatus,
      syncedAt: data.syncedAt,
    );
  }

  InventoryMovementsCompanion _convertToModel(InventoryMovement movement) {
    return InventoryMovementsCompanion(
      id: Value(movement.id),
      organizationId: Value(movement.organizationId),
      branchId: Value(movement.branchId),
      productId: Value(movement.productId),
      movementType: Value(movement.movementType),
      quantity: Value(movement.quantity),
      unitCost: Value(movement.unitCost),
      totalCost: Value(movement.totalCost),
      referenceType: Value.ofNullable(movement.referenceType),
      referenceId: Value.ofNullable(movement.referenceId),
      batchId: Value.ofNullable(movement.batchId),
      notes: Value.ofNullable(movement.notes),
      performedBy: Value(movement.performedBy),
      createdAt: Value(movement.createdAt),
      updatedAt: Value(movement.updatedAt),
      syncStatus: Value(movement.syncStatus),
      syncedAt: Value.ofNullable(movement.syncedAt),
    );
  }
}