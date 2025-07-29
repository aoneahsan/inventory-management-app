import 'dart:convert';
import '../../domain/entities/serial_number.dart';
import '../../domain/entities/batch.dart';
import '../database/database.dart';
import '../sync/sync_service.dart';

class SerialBatchService {
  final AppDatabase _database = AppDatabase.instance;
  final SyncService _syncService = SyncService();

  // Serial Number Management
  Future<List<SerialNumber>> getSerialNumbers(
    String organizationId, {
    String? productId,
    String? branchId,
    SerialStatus? status,
    String? searchQuery,
  }) async {
    final db = await _database.database;
    String query = 'SELECT * FROM serial_numbers WHERE organization_id = ?';
    List<dynamic> args = [organizationId];

    if (productId != null) {
      query += ' AND product_id = ?';
      args.add(productId);
    }

    if (branchId != null) {
      query += ' AND branch_id = ?';
      args.add(branchId);
    }

    if (status != null) {
      query += ' AND status = ?';
      args.add(status.value);
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query += ' AND serial_number LIKE ?';
      args.add('%$searchQuery%');
    }

    query += ' ORDER BY created_at DESC';

    final results = await db.rawQuery(query, args);
    return results.map((map) => SerialNumber.fromMap(map)).toList();
  }

  Future<SerialNumber?> getSerialNumber(String serialNumber) async {
    final db = await _database.database;
    final results = await db.query(
      'serial_numbers',
      where: 'serial_number = ?',
      whereArgs: [serialNumber],
    );

    if (results.isEmpty) return null;
    return SerialNumber.fromMap(results.first);
  }

  Future<String> createSerialNumber(SerialNumber serial) async {
    final db = await _database.database;
    final id = serial.id.isEmpty
        ? DateTime.now().millisecondsSinceEpoch.toString()
        : serial.id;

    // Check if serial number already exists
    final existing = await getSerialNumber(serial.serialNumber);
    if (existing != null) {
      throw Exception('Serial number already exists');
    }

    await db.insert(
      'serial_numbers',
      serial.copyWith(id: id).toMap(),
    );

    await _syncService.addToQueue(
      'serial_numbers',
      id,
      'create',
      serial.toMap(),
    );

    return id;
  }

  Future<void> updateSerialStatus(
    String serialId,
    SerialStatus newStatus, {
    String? saleId,
    double? salePrice,
    String? notes,
  }) async {
    final db = await _database.database;
    final updates = <String, dynamic>{
      'status': newStatus.value,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    };

    if (newStatus == SerialStatus.sold) {
      updates['sale_id'] = saleId;
      updates['sale_date'] = DateTime.now().millisecondsSinceEpoch;
      updates['sale_price'] = salePrice;
    }

    if (notes != null) {
      updates['notes'] = notes;
    }

    await db.update(
      'serial_numbers',
      updates,
      where: 'id = ?',
      whereArgs: [serialId],
    );

    await _syncService.addToQueue(
      'serial_numbers',
      serialId,
      'update',
      updates,
    );
  }

  Future<void> transferSerial(
    String serialId,
    String toBranchId,
  ) async {
    final db = await _database.database;
    await db.update(
      'serial_numbers',
      {
        'branch_id': toBranchId,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [serialId],
    );

    await _syncService.addToQueue(
      'serial_numbers',
      serialId,
      'update',
      {'branch_id': toBranchId},
    );
  }

  // Batch Management
  Future<List<Batch>> getBatches(
    String organizationId, {
    String? productId,
    String? branchId,
    String? supplierId,
    bool? activeOnly,
    bool? nearExpiry,
  }) async {
    final db = await _database.database;
    String query = 'SELECT * FROM batches WHERE organization_id = ?';
    List<dynamic> args = [organizationId];

    if (productId != null) {
      query += ' AND product_id = ?';
      args.add(productId);
    }

    if (branchId != null) {
      query += ' AND branch_id = ?';
      args.add(branchId);
    }

    if (supplierId != null) {
      query += ' AND supplier_id = ?';
      args.add(supplierId);
    }

    if (activeOnly == true) {
      query += ' AND status = ? AND current_quantity > 0';
      args.add('active');
    }

    if (nearExpiry == true) {
      final thirtyDaysFromNow = DateTime.now()
          .add(const Duration(days: 30))
          .millisecondsSinceEpoch;
      query += ' AND expiry_date IS NOT NULL AND expiry_date <= ?';
      args.add(thirtyDaysFromNow);
    }

    query += ' ORDER BY created_at DESC';

    final results = await db.rawQuery(query, args);
    return results.map((map) => Batch.fromMap(map)).toList();
  }

  Future<Batch?> getBatch(String batchId) async {
    final db = await _database.database;
    final results = await db.query(
      'batches',
      where: 'id = ?',
      whereArgs: [batchId],
    );

    if (results.isEmpty) return null;
    return Batch.fromMap(results.first);
  }

  Future<Batch?> getBatchByNumber(String batchNumber) async {
    final db = await _database.database;
    final results = await db.query(
      'batches',
      where: 'batch_number = ?',
      whereArgs: [batchNumber],
    );

    if (results.isEmpty) return null;
    return Batch.fromMap(results.first);
  }

  Future<String> createBatch(Batch batch) async {
    final db = await _database.database;
    final id = batch.id.isEmpty
        ? DateTime.now().millisecondsSinceEpoch.toString()
        : batch.id;

    // Check if batch number already exists
    final existing = await getBatchByNumber(batch.batchNumber);
    if (existing != null) {
      throw Exception('Batch number already exists');
    }

    await db.insert(
      'batches',
      batch.copyWith(
        id: id,
        currentQuantity: batch.initialQuantity,
      ).toMap(),
    );

    await _syncService.addToQueue(
      'batches',
      id,
      'create',
      batch.toMap(),
    );

    return id;
  }

  Future<void> updateBatchQuantity(
    String batchId,
    double quantityChange,
  ) async {
    final db = await _database.database;
    final batch = await getBatch(batchId);
    
    if (batch == null) {
      throw Exception('Batch not found');
    }

    final newQuantity = batch.currentQuantity + quantityChange;
    if (newQuantity < 0) {
      throw Exception('Insufficient batch quantity');
    }

    await db.update(
      'batches',
      {
        'current_quantity': newQuantity,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [batchId],
    );

    await _syncService.addToQueue(
      'batches',
      batchId,
      'update',
      {'current_quantity': newQuantity},
    );
  }

  Future<void> updateBatchStatus(
    String batchId,
    String status,
  ) async {
    final db = await _database.database;
    await db.update(
      'batches',
      {
        'status': status,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [batchId],
    );

    await _syncService.addToQueue(
      'batches',
      batchId,
      'update',
      {'status': status},
    );
  }

  // Analytics
  Future<Map<String, dynamic>> getSerialStats(String organizationId) async {
    final db = await _database.database;
    
    final totalSerials = await db.rawQuery(
      'SELECT COUNT(*) as count FROM serial_numbers WHERE organization_id = ?',
      [organizationId],
    );

    final availableSerials = await db.rawQuery(
      'SELECT COUNT(*) as count FROM serial_numbers WHERE organization_id = ? AND status = ?',
      [organizationId, SerialStatus.available.value],
    );

    final inWarranty = await db.rawQuery(
      'SELECT COUNT(*) as count FROM serial_numbers WHERE organization_id = ? AND warranty_end_date > ?',
      [organizationId, DateTime.now().millisecondsSinceEpoch],
    );

    return {
      'total_serials': totalSerials.first['count'] ?? 0,
      'available_serials': availableSerials.first['count'] ?? 0,
      'in_warranty': inWarranty.first['count'] ?? 0,
    };
  }

  Future<Map<String, dynamic>> getBatchStats(String organizationId) async {
    final db = await _database.database;
    
    final totalBatches = await db.rawQuery(
      'SELECT COUNT(*) as count FROM batches WHERE organization_id = ?',
      [organizationId],
    );

    final activeBatches = await db.rawQuery(
      'SELECT COUNT(*) as count FROM batches WHERE organization_id = ? AND status = ? AND current_quantity > 0',
      [organizationId, 'active'],
    );

    final expiringBatches = await db.rawQuery(
      'SELECT COUNT(*) as count FROM batches WHERE organization_id = ? AND expiry_date IS NOT NULL AND expiry_date <= ?',
      [
        organizationId,
        DateTime.now().add(const Duration(days: 30)).millisecondsSinceEpoch,
      ],
    );

    final expiredBatches = await db.rawQuery(
      'SELECT COUNT(*) as count FROM batches WHERE organization_id = ? AND expiry_date IS NOT NULL AND expiry_date < ?',
      [organizationId, DateTime.now().millisecondsSinceEpoch],
    );

    return {
      'total_batches': totalBatches.first['count'] ?? 0,
      'active_batches': activeBatches.first['count'] ?? 0,
      'expiring_soon': expiringBatches.first['count'] ?? 0,
      'expired': expiredBatches.first['count'] ?? 0,
    };
  }

  // FIFO Selection
  Future<List<Batch>> getFIFOBatches(
    String productId,
    String branchId,
    double requiredQuantity,
  ) async {
    final db = await _database.database;
    final batches = await db.query(
      'batches',
      where: 'product_id = ? AND branch_id = ? AND status = ? AND current_quantity > 0',
      whereArgs: [productId, branchId, 'active'],
      orderBy: 'purchase_date ASC, created_at ASC',
    );

    final selectedBatches = <Batch>[];
    double totalQuantity = 0;

    for (final batchMap in batches) {
      final batch = Batch.fromMap(batchMap);
      selectedBatches.add(batch);
      totalQuantity += batch.currentQuantity;
      
      if (totalQuantity >= requiredQuantity) {
        break;
      }
    }

    return selectedBatches;
  }
}