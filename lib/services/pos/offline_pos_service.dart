import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sqflite/sqflite.dart';
import '../database/database.dart';
import '../sync/sync_service.dart';
import '../../domain/entities/sale.dart';
import '../../domain/entities/register.dart';
import '../../domain/entities/receipt.dart';

class OfflinePOSService {
  final AppDatabase database;
  final SyncService syncService;
  final Connectivity _connectivity = Connectivity();

  OfflinePOSService({
    required this.database,
    required this.syncService,
  });

  // Check if online
  Future<bool> isOnline() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // Queue a sale for sync
  Future<void> queueSaleForSync(Sale sale) async {
    final db = await database.database;
    
    await db.transaction((txn) async {
      // Save sale locally with offline flag
      await txn.insert('sales', {
        'id': sale.id,
        'organization_id': sale.organizationId,
        'register_id': sale.registerId,
        'user_id': sale.userId,
        'customer_id': sale.customerId,
        'receipt_number': sale.receiptNumber,
        'subtotal': sale.subtotal,
        'tax_amount': sale.taxAmount,
        'discount_amount': sale.discountAmount,
        'total_amount': sale.totalAmount,
        'payment_method': sale.paymentMethod,
        'split_payments': sale.splitPayments != null 
            ? json.encode(sale.splitPayments) 
            : null,
        'status': sale.status,
        'is_offline_sale': 1,
        'notes': sale.notes,
        'created_at': sale.createdAt.millisecondsSinceEpoch,
      });

      // Save sale items
      for (final item in sale.items) {
        await txn.insert('sale_items', {
          'id': item.id,
          'sale_id': sale.id,
          'product_id': item.productId,
          'product_name': item.productName,
          'quantity': item.quantity,
          'unit_price': item.unitPrice,
          'discount_amount': item.discountAmount,
          'tax_amount': item.taxAmount,
          'total_amount': item.totalAmount,
          'notes': item.notes,
          'created_at': DateTime.now().millisecondsSinceEpoch,
        });
      }

      // Add to sync queue
      await txn.insert('sync_queue', {
        'table_name': 'sales',
        'operation': 'create',
        'record_id': sale.id,
        'data': json.encode(sale.toJson()),
        'created_at': DateTime.now().millisecondsSinceEpoch,
      });
    });
  }

  // Queue register transaction for sync
  Future<void> queueRegisterTransactionForSync(RegisterTransaction transaction) async {
    final db = await database.database;
    
    await db.insert('sync_queue', {
      'table_name': 'register_transactions',
      'operation': 'create',
      'record_id': transaction.id,
      'data': json.encode(transaction.toJson()),
      'created_at': DateTime.now().millisecondsSinceEpoch,
    });
  }

  // Get pending sync items
  Future<List<Map<String, dynamic>>> getPendingSyncItems() async {
    final db = await database.database;
    
    return await db.query(
      'sync_queue',
      orderBy: 'created_at ASC',
      limit: 100,
    );
  }

  // Process sync queue
  Future<void> processSyncQueue() async {
    if (!await isOnline()) return;

    final pendingItems = await getPendingSyncItems();
    
    for (final item in pendingItems) {
      try {
        await _syncItem(item);
        
        // Remove from queue on success
        final db = await database.database;
        await db.delete(
          'sync_queue',
          where: 'id = ?',
          whereArgs: [item['id']],
        );
      } catch (e) {
        // Increment retry count
        final db = await database.database;
        await db.update(
          'sync_queue',
          {'retry_count': (item['retry_count'] ?? 0) + 1},
          where: 'id = ?',
          whereArgs: [item['id']],
        );
      }
    }
  }

  Future<void> _syncItem(Map<String, dynamic> item) async {
    final tableName = item['table_name'];
    final operation = item['operation'];
    final data = json.decode(item['data']);

    switch (tableName) {
      case 'sales':
        await syncService.syncSale(Sale.fromJson(data));
        break;
      case 'register_transactions':
        await syncService.syncRegisterTransaction(
          RegisterTransaction.fromJson(data),
        );
        break;
      default:
        throw Exception('Unknown table: $tableName');
    }
  }

  // Monitor connectivity and sync automatically
  void startAutoSync() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        // Back online, process sync queue
        processSyncQueue();
      }
    });
  }

  // Get offline sales count
  Future<int> getOfflineSalesCount() async {
    final db = await database.database;
    
    final result = await db.rawQuery('''
      SELECT COUNT(*) as count 
      FROM sales 
      WHERE is_offline_sale = 1
    ''');
    
    return Sqflite.firstIntValue(result) ?? 0;
  }

  // Get sync queue size
  Future<int> getSyncQueueSize() async {
    final db = await database.database;
    
    final result = await db.rawQuery('''
      SELECT COUNT(*) as count 
      FROM sync_queue
    ''');
    
    return Sqflite.firstIntValue(result) ?? 0;
  }

  // Clear old sync queue items (older than 7 days with more than 10 retries)
  Future<void> cleanupSyncQueue() async {
    final db = await database.database;
    final sevenDaysAgo = DateTime.now()
        .subtract(const Duration(days: 7))
        .millisecondsSinceEpoch;
    
    await db.delete(
      'sync_queue',
      where: 'created_at < ? AND retry_count > ?',
      whereArgs: [sevenDaysAgo, 10],
    );
  }
}