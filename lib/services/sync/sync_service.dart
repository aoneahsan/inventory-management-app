import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/errors/exceptions.dart';
import '../database/database.dart';

enum SyncStatus {
  idle,
  syncing,
  error,
  complete,
}

class SyncService {
  final FirebaseFirestore _firestore;
  final AppDatabase _database;
  
  SyncStatus _status = SyncStatus.idle;
  final _statusController = StreamController<SyncStatus>.broadcast();
  Timer? _periodicSyncTimer;
  bool _isOnline = true;
  
  SyncService({
    FirebaseFirestore? firestore,
    AppDatabase? database,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _database = database ?? AppDatabase.instance;

  Stream<SyncStatus> get statusStream => _statusController.stream;
  SyncStatus get currentStatus => _status;
  bool get isOnline => _isOnline;

  // Initialize real-time sync
  Future<void> initialize() async {
    try {
      _setupPeriodicSync();
      await _syncFromServer();
    } catch (e) {
      throw BusinessException(message: 'Failed to initialize sync service: $e');
    }
  }

  // Setup periodic sync every 30 seconds
  void _setupPeriodicSync() {
    _periodicSyncTimer?.cancel();
    _periodicSyncTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => _syncToServer(),
    );
  }

  // Sync local changes to server
  Future<void> _syncToServer() async {
    if (_status == SyncStatus.syncing) return;

    try {
      _updateStatus(SyncStatus.syncing);
      
      final queueItems = await _database.getSyncQueue();
      if (queueItems.isEmpty) {
        _updateStatus(SyncStatus.complete);
        return;
      }

      for (final item in queueItems) {
        await _syncQueueItem(item);
      }

      _updateStatus(SyncStatus.complete);
    } catch (e) {
      _updateStatus(SyncStatus.error);
      throw BusinessException(message: 'Failed to sync to server: $e');
    }
  }

  // Sync data from server
  Future<void> _syncFromServer() async {
    try {
      _updateStatus(SyncStatus.syncing);
      
      // This would typically listen to Firestore changes
      // For now, we'll implement a simple poll-based sync
      
      _updateStatus(SyncStatus.complete);
    } catch (e) {
      _updateStatus(SyncStatus.error);
      throw BusinessException(message: 'Failed to sync from server: $e');
    }
  }

  // Sync individual queue item
  Future<void> _syncQueueItem(Map<String, dynamic> item) async {
    try {
      final tableName = item['table_name'] as String;
      final operation = item['operation'] as String;
      final recordId = item['record_id'] as String;
      final data = json.decode(item['data'] as String) as Map<String, dynamic>;

      switch (tableName) {
        case 'products':
          await _syncProduct(operation, recordId, data);
          break;
        case 'categories':
          await _syncCategory(operation, recordId, data);
          break;
        case 'inventory_movements':
          await _syncInventoryMovement(operation, recordId, data);
          break;
        case 'organizations':
          await _syncOrganization(operation, recordId, data);
          break;
        case 'users':
          await _syncUser(operation, recordId, data);
          break;
        default:
          throw BusinessException(message: 'Unknown table for sync: $tableName');
      }

      // Remove from sync queue on success
      await _database.removeSyncQueueItem(item['id'] as int);
    } catch (e) {
      // Increment retry count
      final retryCount = (item['retry_count'] as int? ?? 0) + 1;
      if (retryCount >= 3) {
        // Mark as failed after 3 retries
        await _database.updateSyncQueueItem(item['id'] as int, {
          'retry_count': retryCount,
          'last_error': e.toString(),
        });
      } else {
        await _database.updateSyncQueueItem(item['id'] as int, {
          'retry_count': retryCount,
        });
      }
      throw BusinessException(message: 'Failed to sync item: $e');
    }
  }

  // Sync product to Firestore
  Future<void> _syncProduct(String operation, String recordId, Map<String, dynamic> data) async {
    switch (operation) {
      case 'create':
        await _firestore.collection('products').doc(recordId).set(data);
        break;
      case 'update':
        await _firestore.collection('products').doc(recordId).update(data);
        break;
      case 'delete':
        await _firestore.collection('products').doc(recordId).delete();
        break;
    }
  }

  // Sync category to Firestore
  Future<void> _syncCategory(String operation, String recordId, Map<String, dynamic> data) async {
    switch (operation) {
      case 'create':
        await _firestore.collection('categories').doc(recordId).set(data);
        break;
      case 'update':
        await _firestore.collection('categories').doc(recordId).update(data);
        break;
      case 'delete':
        await _firestore.collection('categories').doc(recordId).delete();
        break;
    }
  }

  // Sync inventory movement to Firestore
  Future<void> _syncInventoryMovement(String operation, String recordId, Map<String, dynamic> data) async {
    switch (operation) {
      case 'create':
        await _firestore.collection('inventory_movements').doc(recordId).set(data);
        break;
      case 'update':
        await _firestore.collection('inventory_movements').doc(recordId).update(data);
        break;
      case 'delete':
        await _firestore.collection('inventory_movements').doc(recordId).delete();
        break;
    }
  }

  // Sync organization to Firestore
  Future<void> _syncOrganization(String operation, String recordId, Map<String, dynamic> data) async {
    switch (operation) {
      case 'create':
        await _firestore.collection('organizations').doc(recordId).set(data);
        break;
      case 'update':
        await _firestore.collection('organizations').doc(recordId).update(data);
        break;
      case 'delete':
        await _firestore.collection('organizations').doc(recordId).delete();
        break;
    }
  }

  // Sync user to Firestore
  Future<void> _syncUser(String operation, String recordId, Map<String, dynamic> data) async {
    switch (operation) {
      case 'create':
        await _firestore.collection('users').doc(recordId).set(data);
        break;
      case 'update':
        await _firestore.collection('users').doc(recordId).update(data);
        break;
      case 'delete':
        await _firestore.collection('users').doc(recordId).delete();
        break;
    }
  }

  // Manual sync trigger
  Future<void> forcSync() async {
    await _syncToServer();
  }

  // Check network connectivity
  Future<void> updateNetworkStatus(bool isOnline) async {
    _isOnline = isOnline;
    
    if (isOnline && _status != SyncStatus.syncing) {
      // Automatically sync when coming back online
      await _syncToServer();
    }
  }

  // Get sync statistics
  Future<Map<String, dynamic>> getSyncStats() async {
    try {
      final queueItems = await _database.getSyncQueue();
      final pendingCount = queueItems.length;
      final failedCount = queueItems.where((item) => (item['retry_count'] as int? ?? 0) >= 3).length;
      
      return {
        'status': _status.name,
        'is_online': _isOnline,
        'pending_items': pendingCount,
        'failed_items': failedCount,
        'last_sync': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      throw BusinessException(message: 'Failed to get sync stats: $e');
    }
  }

  // Clear failed sync items
  Future<void> clearFailedItems() async {
    try {
      await _database.clearFailedSyncItems();
    } catch (e) {
      throw BusinessException(message: 'Failed to clear failed items: $e');
    }
  }

  // Retry failed sync items
  Future<void> retryFailedItems() async {
    try {
      await _database.resetFailedSyncItems();
      await _syncToServer();
    } catch (e) {
      throw BusinessException(message: 'Failed to retry failed items: $e');
    }
  }

  void _updateStatus(SyncStatus status) {
    _status = status;
    _statusController.add(status);
  }

  void dispose() {
    _periodicSyncTimer?.cancel();
    _statusController.close();
  }
}