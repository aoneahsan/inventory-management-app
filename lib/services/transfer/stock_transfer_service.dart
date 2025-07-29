import '../../domain/entities/stock_transfer.dart';
import '../../domain/entities/inventory_movement.dart';
import '../database/database.dart';
import '../branch/branch_service.dart';
import '../sync/sync_service.dart';

class StockTransferService {
  final AppDatabase _database = AppDatabase.instance;
  final BranchService _branchService = BranchService();
  final SyncService _syncService = SyncService();

  Future<List<StockTransfer>> getTransfers(String organizationId, {
    TransferStatus? status,
    String? fromBranchId,
    String? toBranchId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final db = await _database.database;
    String query = 'SELECT * FROM stock_transfers WHERE organization_id = ?';
    List<dynamic> args = [organizationId];

    if (status != null) {
      query += ' AND status = ?';
      args.add(status.value);
    }

    if (fromBranchId != null) {
      query += ' AND from_branch_id = ?';
      args.add(fromBranchId);
    }

    if (toBranchId != null) {
      query += ' AND to_branch_id = ?';
      args.add(toBranchId);
    }

    if (startDate != null) {
      query += ' AND transfer_date >= ?';
      args.add(startDate.millisecondsSinceEpoch);
    }

    if (endDate != null) {
      query += ' AND transfer_date <= ?';
      args.add(endDate.millisecondsSinceEpoch);
    }

    query += ' ORDER BY transfer_date DESC';

    final results = await db.rawQuery(query, args);
    final transfers = results.map((map) => StockTransfer.fromMap(map)).toList();

    // Load items for each transfer
    for (final transfer in transfers) {
      final items = await getTransferItems(transfer.id);
      transfers[transfers.indexOf(transfer)] = transfer.copyWith(items: items);
    }

    return transfers;
  }

  Future<StockTransfer?> getTransfer(String transferId) async {
    final db = await _database.database;
    final results = await db.query(
      'stock_transfers',
      where: 'id = ?',
      whereArgs: [transferId],
    );

    if (results.isEmpty) return null;
    
    final transfer = StockTransfer.fromMap(results.first);
    final items = await getTransferItems(transferId);
    return transfer.copyWith(items: items);
  }

  Future<List<StockTransferItem>> getTransferItems(String transferId) async {
    final db = await _database.database;
    final results = await db.query(
      'stock_transfer_items',
      where: 'transfer_id = ?',
      whereArgs: [transferId],
    );

    return results.map((map) => StockTransferItem.fromMap(map)).toList();
  }

  Future<String> createTransfer(StockTransfer transfer) async {
    final db = await _database.database;
    final id = transfer.id.isEmpty
        ? DateTime.now().millisecondsSinceEpoch.toString()
        : transfer.id;
    
    final transferNumber = await _generateTransferNumber(transfer.organizationId);

    // Start transaction
    await db.transaction((txn) async {
      // Create transfer record
      await txn.insert(
        'stock_transfers',
        transfer.copyWith(
          id: id,
          transferNumber: transferNumber,
          status: TransferStatus.pending,
        ).toMap(),
      );

      // Create transfer items
      if (transfer.items != null) {
        for (final item in transfer.items!) {
          await txn.insert(
            'stock_transfer_items',
            item.copyWith(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              transferId: id,
            ).toMap(),
          );

          // Reserve stock in source branch
          await _branchService.reserveStock(
            transfer.fromBranchId,
            item.productId,
            item.quantity,
          );
        }
      }

      // Add to sync queue
      await _syncService.addToQueue(
        'stock_transfers',
        id,
        'create',
        transfer.toMap(),
      );
    });

    return id;
  }

  Future<void> updateTransferStatus(
    String transferId,
    TransferStatus newStatus, {
    String? approvedBy,
    String? receivedBy,
  }) async {
    final db = await _database.database;
    final transfer = await getTransfer(transferId);
    
    if (transfer == null) {
      throw Exception('Transfer not found');
    }

    final updates = <String, dynamic>{
      'status': newStatus.value,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    };

    if (newStatus == TransferStatus.inTransit && approvedBy != null) {
      updates['approved_by'] = approvedBy;
    }

    if (newStatus == TransferStatus.completed) {
      updates['completed_date'] = DateTime.now().millisecondsSinceEpoch;
      if (receivedBy != null) {
        updates['received_by'] = receivedBy;
      }
    }

    await db.transaction((txn) async {
      // Update transfer status
      await txn.update(
        'stock_transfers',
        updates,
        where: 'id = ?',
        whereArgs: [transferId],
      );

      // Handle status-specific actions
      if (newStatus == TransferStatus.inTransit) {
        // Stock is now in transit, maintain reservation
      } else if (newStatus == TransferStatus.completed) {
        // Complete the transfer
        await _completeTransfer(transfer);
      } else if (newStatus == TransferStatus.cancelled) {
        // Cancel the transfer
        await _cancelTransfer(transfer);
      }

      // Add to sync queue
      await _syncService.addToQueue(
        'stock_transfers',
        transferId,
        'update',
        updates,
      );
    });
  }

  Future<void> _completeTransfer(StockTransfer transfer) async {
    if (transfer.items == null) return;

    final db = await _database.database;
    
    for (final item in transfer.items!) {
      // Remove stock from source branch
      await _branchService.updateBranchInventory(
        transfer.fromBranchId,
        item.productId,
        -item.quantity,
      );

      // Release reserved stock
      await _branchService.releaseReservedStock(
        transfer.fromBranchId,
        item.productId,
        item.quantity,
      );

      // Add stock to destination branch
      await _branchService.updateBranchInventory(
        transfer.toBranchId,
        item.productId,
        item.receivedQuantity > 0 ? item.receivedQuantity : item.quantity,
      );

      // Create inventory movements
      final outMovement = InventoryMovement(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        organizationId: transfer.organizationId,
        productId: item.productId,
        type: MovementType.out,
        quantity: item.quantity,
        reason: 'Transfer to ${transfer.toBranchId}',
        referenceId: transfer.id,
        referenceType: 'stock_transfer',
        performedBy: transfer.createdBy,
        createdAt: DateTime.now(),
      );

      final inMovement = InventoryMovement(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        organizationId: transfer.organizationId,
        productId: item.productId,
        type: MovementType.in_,
        quantity: item.receivedQuantity > 0 ? item.receivedQuantity : item.quantity,
        reason: 'Transfer from ${transfer.fromBranchId}',
        referenceId: transfer.id,
        referenceType: 'stock_transfer',
        performedBy: transfer.receivedBy ?? transfer.createdBy,
        createdAt: DateTime.now(),
      );

      await db.insert('inventory_movements', outMovement.toMap());
      await db.insert('inventory_movements', inMovement.toMap());
    }
  }

  Future<void> _cancelTransfer(StockTransfer transfer) async {
    if (transfer.items == null) return;

    // Release all reserved stock
    for (final item in transfer.items!) {
      await _branchService.releaseReservedStock(
        transfer.fromBranchId,
        item.productId,
        item.quantity,
      );
    }
  }

  Future<void> updateReceivedQuantity(
    String transferId,
    String itemId,
    double receivedQuantity,
  ) async {
    final db = await _database.database;
    
    await db.update(
      'stock_transfer_items',
      {'received_quantity': receivedQuantity},
      where: 'id = ? AND transfer_id = ?',
      whereArgs: [itemId, transferId],
    );

    await _syncService.addToQueue(
      'stock_transfer_items',
      itemId,
      'update',
      {'received_quantity': receivedQuantity},
    );
  }

  Future<String> _generateTransferNumber(String organizationId) async {
    final db = await _database.database;
    final count = await db.rawQuery(
      'SELECT COUNT(*) as count FROM stock_transfers WHERE organization_id = ?',
      [organizationId],
    );
    
    final transferCount = count.first['count'] as int? ?? 0;
    final date = DateTime.now();
    return 'TR-${date.year}${date.month.toString().padLeft(2, '0')}-${(transferCount + 1).toString().padLeft(4, '0')}';
  }

  Future<Map<String, dynamic>> getTransferStats(String organizationId) async {
    final db = await _database.database;
    
    final pendingCount = await db.rawQuery(
      'SELECT COUNT(*) as count FROM stock_transfers WHERE organization_id = ? AND status = ?',
      [organizationId, TransferStatus.pending.value],
    );

    final inTransitCount = await db.rawQuery(
      'SELECT COUNT(*) as count FROM stock_transfers WHERE organization_id = ? AND status = ?',
      [organizationId, TransferStatus.inTransit.value],
    );

    final completedToday = await db.rawQuery(
      'SELECT COUNT(*) as count FROM stock_transfers WHERE organization_id = ? AND status = ? AND completed_date >= ?',
      [
        organizationId,
        TransferStatus.completed.value,
        DateTime.now().subtract(const Duration(days: 1)).millisecondsSinceEpoch,
      ],
    );

    return {
      'pending_transfers': pendingCount.first['count'] ?? 0,
      'in_transit_transfers': inTransitCount.first['count'] ?? 0,
      'completed_today': completedToday.first['count'] ?? 0,
    };
  }
}