import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../database/database_service.dart';
import '../../core/utils/logger.dart';

class SyncService {
  final DatabaseService databaseService;
  final Duration syncInterval;
  final int maxRetries;
  
  Timer? _syncTimer;
  bool _isSyncing = false;
  final _syncStatusController = StreamController<SyncStatus>.broadcast();
  
  SyncService({
    required this.databaseService,
    this.syncInterval = const Duration(minutes: 5),
    this.maxRetries = 3,
  });
  
  Stream<SyncStatus> get syncStatus => _syncStatusController.stream;
  bool get isSyncing => _isSyncing;
  
  Future<void> initialize() async {
    // Start periodic sync
    _startPeriodicSync();
    
    // Check for pending sync items
    await _checkPendingSyncItems();
  }
  
  void _startPeriodicSync() {
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(syncInterval, (_) {
      syncAll();
    });
  }
  
  Future<void> syncAll() async {
    if (_isSyncing) {
      Logger.debug('Sync already in progress, skipping...');
      return;
    }
    
    _isSyncing = true;
    _syncStatusController.add(SyncStatus.syncing());
    
    try {
      // Get all pending sync items
      final pendingItems = await _getPendingSyncItems();
      
      if (pendingItems.isEmpty) {
        _syncStatusController.add(SyncStatus.completed(
          message: 'No pending items to sync',
        ));
        return;
      }
      
      Logger.info('Starting sync for ${pendingItems.length} items');
      
      int successCount = 0;
      int failureCount = 0;
      final failedItems = <SyncQueueItem>[];
      
      // Process items in batches
      const batchSize = 50;
      for (var i = 0; i < pendingItems.length; i += batchSize) {
        final batch = pendingItems.skip(i).take(batchSize).toList();
        final results = await _processSyncBatch(batch);
        
        for (var j = 0; j < batch.length; j++) {
          if (results[j]) {
            successCount++;
            await _markSyncItemCompleted(batch[j].id);
          } else {
            failureCount++;
            failedItems.add(batch[j]);
            await _incrementRetryCount(batch[j].id);
          }
        }
        
        // Update progress
        _syncStatusController.add(SyncStatus.syncing(
          progress: (i + batch.length) / pendingItems.length,
          message: 'Synced ${i + batch.length} of ${pendingItems.length} items',
        ));
      }
      
      if (failureCount == 0) {
        _syncStatusController.add(SyncStatus.completed(
          message: 'Successfully synced $successCount items',
        ));
      } else {
        _syncStatusController.add(SyncStatus.partial(
          successCount: successCount,
          failureCount: failureCount,
          message: 'Synced $successCount items, $failureCount failed',
        ));
      }
      
    } catch (e) {
      Logger.error('Sync failed', error: e);
      _syncStatusController.add(SyncStatus.failed(
        message: 'Sync failed: ${e.toString()}',
      ));
    } finally {
      _isSyncing = false;
    }
  }
  
  Future<void> addToSyncQueue({
    required String tableName,
    required String operation,
    required String recordId,
    required Map<String, dynamic> data,
  }) async {
    final item = {
      'id': _generateSyncId(),
      'table_name': tableName,
      'operation': operation,
      'record_id': recordId,
      'data': jsonEncode(data),
      'retry_count': 0,
      'status': 'pending',
      'created_at': DateTime.now().millisecondsSinceEpoch,
    };
    
    await databaseService.insert('sync_queue', item);
    
    // Trigger immediate sync if not already syncing
    if (!_isSyncing) {
      syncAll();
    }
  }
  
  Future<List<SyncQueueItem>> _getPendingSyncItems() async {
    final results = await databaseService.query(
      'sync_queue',
      where: 'status = ? AND retry_count < ?',
      whereArgs: ['pending', maxRetries],
      orderBy: 'created_at ASC',
    );
    
    return results.map((row) => SyncQueueItem.fromMap(row)).toList();
  }
  
  Future<List<bool>> _processSyncBatch(List<SyncQueueItem> items) async {
    // This is where you would implement the actual sync logic
    // For now, we'll simulate the sync process
    final results = <bool>[];
    
    for (final item in items) {
      try {
        // Simulate API call
        await Future.delayed(const Duration(milliseconds: 100));
        
        // In a real implementation, you would:
        // 1. Determine the sync endpoint based on table and operation
        // 2. Prepare the request data
        // 3. Make the API call
        // 4. Handle the response
        
        // For demo purposes, randomly succeed/fail
        results.add(DateTime.now().millisecond % 3 != 0);
      } catch (e) {
        results.add(false);
      }
    }
    
    return results;
  }
  
  Future<void> _markSyncItemCompleted(String id) async {
    await databaseService.update(
      'sync_queue',
      {
        'status': 'completed',
        'processed_at': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  Future<void> _incrementRetryCount(String id) async {
    await databaseService.rawUpdate(
      'UPDATE sync_queue SET retry_count = retry_count + 1, error_message = ? WHERE id = ?',
      ['Sync failed', id],
    );
    
    // Mark as failed if exceeded max retries
    final item = await databaseService.findById('sync_queue', id);
    if (item != null && item['retry_count'] >= maxRetries) {
      await databaseService.update(
        'sync_queue',
        {'status': 'failed'},
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }
  
  Future<void> _checkPendingSyncItems() async {
    final count = await databaseService.count(
      'sync_queue',
      where: 'status = ?',
      whereArgs: ['pending'],
    );
    
    if (count > 0) {
      Logger.info('Found $count pending sync items');
      // Don't trigger immediate sync on startup, wait for next interval
    }
  }
  
  String _generateSyncId() {
    return '${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}';
  }
  
  Future<void> clearSyncQueue() async {
    await databaseService.delete('sync_queue');
    _syncStatusController.add(SyncStatus.idle());
  }
  
  Future<void> retrySyncItem(String id) async {
    await databaseService.update(
      'sync_queue',
      {
        'status': 'pending',
        'retry_count': 0,
        'error_message': null,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    
    // Trigger sync
    syncAll();
  }
  
  Future<SyncStatistics> getSyncStatistics() async {
    final pending = await databaseService.count(
      'sync_queue',
      where: 'status = ?',
      whereArgs: ['pending'],
    );
    
    final completed = await databaseService.count(
      'sync_queue',
      where: 'status = ?',
      whereArgs: ['completed'],
    );
    
    final failed = await databaseService.count(
      'sync_queue',
      where: 'status = ?',
      whereArgs: ['failed'],
    );
    
    return SyncStatistics(
      pendingCount: pending,
      completedCount: completed,
      failedCount: failed,
      totalCount: pending + completed + failed,
    );
  }
  
  void dispose() {
    _syncTimer?.cancel();
    _syncStatusController.close();
  }
}

// Supporting classes
class SyncQueueItem {
  final String id;
  final String tableName;
  final String operation;
  final String recordId;
  final Map<String, dynamic> data;
  final int retryCount;
  final String status;
  final String? errorMessage;
  final DateTime createdAt;
  final DateTime? processedAt;
  
  SyncQueueItem({
    required this.id,
    required this.tableName,
    required this.operation,
    required this.recordId,
    required this.data,
    required this.retryCount,
    required this.status,
    this.errorMessage,
    required this.createdAt,
    this.processedAt,
  });
  
  factory SyncQueueItem.fromMap(Map<String, dynamic> map) {
    return SyncQueueItem(
      id: map['id'],
      tableName: map['table_name'],
      operation: map['operation'],
      recordId: map['record_id'],
      data: jsonDecode(map['data']),
      retryCount: map['retry_count'],
      status: map['status'],
      errorMessage: map['error_message'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      processedAt: map['processed_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['processed_at'])
          : null,
    );
  }
}

abstract class SyncStatus {
  const SyncStatus();
  
  factory SyncStatus.idle() = IdleSyncStatus;
  factory SyncStatus.syncing({double? progress, String? message}) = SyncingSyncStatus;
  factory SyncStatus.completed({required String message}) = CompletedSyncStatus;
  factory SyncStatus.partial({
    required int successCount,
    required int failureCount,
    required String message,
  }) = PartialSyncStatus;
  factory SyncStatus.failed({required String message}) = FailedSyncStatus;
}

class IdleSyncStatus extends SyncStatus {
  const IdleSyncStatus();
}

class SyncingSyncStatus extends SyncStatus {
  final double? progress;
  final String? message;
  
  const SyncingSyncStatus({this.progress, this.message});
}

class CompletedSyncStatus extends SyncStatus {
  final String message;
  
  const CompletedSyncStatus({required this.message});
}

class PartialSyncStatus extends SyncStatus {
  final int successCount;
  final int failureCount;
  final String message;
  
  const PartialSyncStatus({
    required this.successCount,
    required this.failureCount,
    required this.message,
  });
}

class FailedSyncStatus extends SyncStatus {
  final String message;
  
  const FailedSyncStatus({required this.message});
}

class SyncStatistics {
  final int pendingCount;
  final int completedCount;
  final int failedCount;
  final int totalCount;
  
  const SyncStatistics({
    required this.pendingCount,
    required this.completedCount,
    required this.failedCount,
    required this.totalCount,
  });
  
  double get successRate {
    if (totalCount == 0) return 0;
    return completedCount / totalCount;
  }
}