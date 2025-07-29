import 'dart:convert';
import '../../domain/entities/cost_lot.dart';
import '../database/database.dart';
import '../sync/sync_service.dart';

class CostLotService {
  final AppDatabase _database = AppDatabase.instance;
  final SyncService _syncService = SyncService();

  Future<List<CostLot>> getCostLots(
    String productId,
    String branchId, {
    bool? availableOnly,
  }) async {
    final db = await _database.database;
    String query = 'SELECT * FROM cost_lots WHERE product_id = ? AND branch_id = ?';
    List<dynamic> args = [productId, branchId];

    if (availableOnly == true) {
      query += ' AND remaining_quantity > 0';
    }

    query += ' ORDER BY purchase_date ASC';

    final results = await db.rawQuery(query, args);
    return results.map((map) => CostLot.fromMap(map)).toList();
  }

  Future<String> createCostLot(CostLot lot) async {
    final db = await _database.database;
    final id = lot.id.isEmpty
        ? DateTime.now().millisecondsSinceEpoch.toString()
        : lot.id;

    await db.insert(
      'cost_lots',
      lot.copyWith(
        id: id,
        remainingQuantity: lot.purchaseQuantity,
      ).toMap(),
    );

    await _syncService.addToQueue(
      'cost_lots',
      id,
      'create',
      lot.toMap(),
    );

    return id;
  }

  Future<List<CostLot>> getFIFOLots(
    String productId,
    String branchId,
    double requiredQuantity,
  ) async {
    final availableLots = await getCostLots(
      productId,
      branchId,
      availableOnly: true,
    );

    final selectedLots = <CostLot>[];
    double totalQuantity = 0;

    for (final lot in availableLots) {
      selectedLots.add(lot);
      totalQuantity += lot.remainingQuantity;
      
      if (totalQuantity >= requiredQuantity) {
        break;
      }
    }

    return selectedLots;
  }

  Future<void> consumeFromLots(
    String productId,
    String branchId,
    double quantity,
  ) async {
    final db = await _database.database;
    final lots = await getFIFOLots(productId, branchId, quantity);
    
    double remainingToConsume = quantity;

    for (final lot in lots) {
      if (remainingToConsume <= 0) break;

      final consumeFromThisLot = lot.remainingQuantity >= remainingToConsume
          ? remainingToConsume
          : lot.remainingQuantity;

      await db.update(
        'cost_lots',
        {
          'remaining_quantity': lot.remainingQuantity - consumeFromThisLot,
          'updated_at': DateTime.now().millisecondsSinceEpoch,
        },
        where: 'id = ?',
        whereArgs: [lot.id],
      );

      remainingToConsume -= consumeFromThisLot;
    }
  }
}