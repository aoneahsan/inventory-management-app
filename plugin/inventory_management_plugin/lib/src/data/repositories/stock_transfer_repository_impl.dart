import 'dart:async';
import '../../domain/entities/stock_transfer.dart';
import '../../domain/repositories/stock_transfer_repository.dart';
import '../database/app_database.dart';
import '../models/stock_transfer_model.dart';
import '../database/tables/stock_transfers_table.dart';
import '../../core/utils/logger.dart';

/// Implementation of StockTransferRepository using Drift
class StockTransferRepositoryImpl implements StockTransferRepository {
  final AppDatabase _database;
  final _transferStreamController = StreamController<List<StockTransfer>>.broadcast();

  StockTransferRepositoryImpl(this._database);

  @override
  Future<StockTransfer?> getTransferById(String id) async {
    try {
      final query = _database.select(_database.stockTransfers)
        ..where((t) => t.id.equals(id));
      final result = await query.getSingleOrNull();
      
      if (result != null) {
        return _convertToEntity(result);
      }
      return null;
    } catch (e) {
      Logger.error('Error getting transfer by ID: $e');
      rethrow;
    }
  }

  @override
  Future<List<StockTransfer>> getAllTransfers() async {
    try {
      final results = await _database.select(_database.stockTransfers).get();
      return results.map((t) => _convertToEntity(t)).toList();
    } catch (e) {
      Logger.error('Error getting all transfers: $e');
      rethrow;
    }
  }

  @override
  Future<List<StockTransfer>> getTransfersByBranch(String branchId) async {
    try {
      final query = _database.select(_database.stockTransfers)
        ..where((t) => t.fromBranchId.equals(branchId) | t.toBranchId.equals(branchId))
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
      
      final results = await query.get();
      return results.map((t) => _convertToEntity(t)).toList();
    } catch (e) {
      Logger.error('Error getting transfers by branch: $e');
      rethrow;
    }
  }

  @override
  Future<List<StockTransfer>> getOutgoingTransfers(String branchId) async {
    try {
      final query = _database.select(_database.stockTransfers)
        ..where((t) => t.fromBranchId.equals(branchId))
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
      
      final results = await query.get();
      return results.map((t) => _convertToEntity(t)).toList();
    } catch (e) {
      Logger.error('Error getting outgoing transfers: $e');
      rethrow;
    }
  }

  @override
  Future<List<StockTransfer>> getIncomingTransfers(String branchId) async {
    try {
      final query = _database.select(_database.stockTransfers)
        ..where((t) => t.toBranchId.equals(branchId))
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
      
      final results = await query.get();
      return results.map((t) => _convertToEntity(t)).toList();
    } catch (e) {
      Logger.error('Error getting incoming transfers: $e');
      rethrow;
    }
  }

  @override
  Future<List<StockTransfer>> getTransfersByStatus(String status) async {
    try {
      final query = _database.select(_database.stockTransfers)
        ..where((t) => t.status.equals(status))
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
      
      final results = await query.get();
      return results.map((t) => _convertToEntity(t)).toList();
    } catch (e) {
      Logger.error('Error getting transfers by status: $e');
      rethrow;
    }
  }

  @override
  Future<List<StockTransfer>> getPendingTransfers(String branchId) async {
    try {
      final query = _database.select(_database.stockTransfers)
        ..where((t) => 
          (t.toBranchId.equals(branchId) & t.status.equals('in_transit')) |
          (t.toBranchId.equals(branchId) & t.status.equals('pending')))
        ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
      
      final results = await query.get();
      return results.map((t) => _convertToEntity(t)).toList();
    } catch (e) {
      Logger.error('Error getting pending transfers: $e');
      rethrow;
    }
  }

  @override
  Future<List<StockTransfer>> getPendingSyncTransfers() async {
    try {
      final query = _database.select(_database.stockTransfers)
        ..where((t) => t.syncStatus.equals('pending'))
        ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
      
      final results = await query.get();
      return results.map((t) => _convertToEntity(t)).toList();
    } catch (e) {
      Logger.error('Error getting pending sync transfers: $e');
      rethrow;
    }
  }

  @override
  Future<StockTransfer> createTransfer(StockTransfer transfer) async {
    try {
      final model = _convertToModel(transfer);
      final id = await _database.into(_database.stockTransfers).insert(model);
      
      // Notify listeners
      _notifyListeners();
      
      return transfer.copyWith(id: id.toString());
    } catch (e) {
      Logger.error('Error creating transfer: $e');
      rethrow;
    }
  }

  @override
  Future<StockTransfer> updateTransfer(StockTransfer transfer) async {
    try {
      final model = _convertToModel(transfer);
      final updated = await (_database.update(_database.stockTransfers)
        ..where((t) => t.id.equals(transfer.id)))
        .write(model);
      
      if (updated > 0) {
        _notifyListeners();
        return transfer;
      } else {
        throw Exception('Transfer not found');
      }
    } catch (e) {
      Logger.error('Error updating transfer: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteTransfer(String id) async {
    try {
      final deleted = await (_database.delete(_database.stockTransfers)
        ..where((t) => t.id.equals(id)))
        .go();
      
      if (deleted > 0) {
        _notifyListeners();
      } else {
        throw Exception('Transfer not found');
      }
    } catch (e) {
      Logger.error('Error deleting transfer: $e');
      rethrow;
    }
  }

  @override
  Future<void> markTransferAsSynced(String id) async {
    try {
      await (_database.update(_database.stockTransfers)
        ..where((t) => t.id.equals(id)))
        .write(const StockTransfersCompanion(
          syncStatus: Value('synced'),
          syncedAt: Value.ofNullable(DateTime.now()),
        ));
      
      _notifyListeners();
    } catch (e) {
      Logger.error('Error marking transfer as synced: $e');
      rethrow;
    }
  }

  @override
  Stream<List<StockTransfer>> watchTransfers() {
    return _transferStreamController.stream;
  }

  @override
  Stream<List<StockTransfer>> watchTransfersByBranch(String branchId) {
    return _database.select(_database.stockTransfers)
      .where((t) => t.fromBranchId.equals(branchId) | t.toBranchId.equals(branchId))
      .watch()
      .map((transfers) => transfers.map((t) => _convertToEntity(t)).toList());
  }

  @override
  Stream<StockTransfer?> watchTransfer(String id) {
    return (_database.select(_database.stockTransfers)
      ..where((t) => t.id.equals(id)))
      .watchSingleOrNull()
      .map((transfer) => transfer != null ? _convertToEntity(transfer) : null);
  }

  @override
  void dispose() {
    _transferStreamController.close();
  }

  void _notifyListeners() async {
    final transfers = await getAllTransfers();
    _transferStreamController.add(transfers);
  }

  StockTransfer _convertToEntity(StockTransfersData data) {
    return StockTransfer(
      id: data.id,
      organizationId: data.organizationId,
      fromBranchId: data.fromBranchId,
      toBranchId: data.toBranchId,
      transferNumber: data.transferNumber,
      status: data.status,
      items: data.items,
      notes: data.notes,
      initiatedBy: data.initiatedBy,
      initiatedAt: data.initiatedAt,
      approvedBy: data.approvedBy,
      approvedAt: data.approvedAt,
      receivedBy: data.receivedBy,
      receivedAt: data.receivedAt,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      syncStatus: data.syncStatus,
      syncedAt: data.syncedAt,
    );
  }

  StockTransfersCompanion _convertToModel(StockTransfer transfer) {
    return StockTransfersCompanion(
      id: Value(transfer.id),
      organizationId: Value(transfer.organizationId),
      fromBranchId: Value(transfer.fromBranchId),
      toBranchId: Value(transfer.toBranchId),
      transferNumber: Value(transfer.transferNumber),
      status: Value(transfer.status),
      items: Value(transfer.items),
      notes: Value.ofNullable(transfer.notes),
      initiatedBy: Value(transfer.initiatedBy),
      initiatedAt: Value(transfer.initiatedAt),
      approvedBy: Value.ofNullable(transfer.approvedBy),
      approvedAt: Value.ofNullable(transfer.approvedAt),
      receivedBy: Value.ofNullable(transfer.receivedBy),
      receivedAt: Value.ofNullable(transfer.receivedAt),
      createdAt: Value(transfer.createdAt),
      updatedAt: Value(transfer.updatedAt),
      syncStatus: Value(transfer.syncStatus),
      syncedAt: Value.ofNullable(transfer.syncedAt),
    );
  }
}