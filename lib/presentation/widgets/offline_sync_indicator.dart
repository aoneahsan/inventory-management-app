import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/pos/pos_service.dart';

class OfflineSyncIndicator extends ConsumerStatefulWidget {
  final POSService posService;
  
  const OfflineSyncIndicator({
    super.key,
    required this.posService,
  });

  @override
  ConsumerState<OfflineSyncIndicator> createState() => _OfflineSyncIndicatorState();
}

class _OfflineSyncIndicatorState extends ConsumerState<OfflineSyncIndicator> {
  Map<String, dynamic>? _syncStatus;
  bool _isSyncing = false;

  @override
  void initState() {
    super.initState();
    _loadSyncStatus();
    // Refresh status every 10 seconds
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 10));
      if (mounted) {
        await _loadSyncStatus();
        return true;
      }
      return false;
    });
  }

  Future<void> _loadSyncStatus() async {
    try {
      final status = await widget.posService.getOfflineSyncStatus();
      if (mounted) {
        setState(() {
          _syncStatus = status;
        });
      }
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> _triggerSync() async {
    setState(() {
      _isSyncing = true;
    });

    try {
      await widget.posService.syncOfflineData();
      await _loadSyncStatus();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sync completed successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sync failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSyncing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_syncStatus == null) {
      return const SizedBox.shrink();
    }

    final isOnline = _syncStatus!['isOnline'] as bool;
    final offlineSalesCount = _syncStatus!['offlineSalesCount'] as int;
    final pendingSyncItems = _syncStatus!['pendingSyncItems'] as int;

    if (isOnline && pendingSyncItems == 0) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_done,
              size: 16,
              color: Colors.green.shade700,
            ),
            const SizedBox(width: 6),
            Text(
              'Online',
              style: TextStyle(
                color: Colors.green.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return InkWell(
      onTap: isOnline && !_isSyncing ? _triggerSync : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isOnline ? Colors.orange.shade100 : Colors.red.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isSyncing)
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
              )
            else
              Icon(
                isOnline ? Icons.cloud_sync : Icons.cloud_off,
                size: 16,
                color: isOnline ? Colors.orange.shade700 : Colors.red.shade700,
              ),
            const SizedBox(width: 6),
            Text(
              isOnline
                  ? 'Sync pending: $pendingSyncItems'
                  : 'Offline: $offlineSalesCount sales',
              style: TextStyle(
                color: isOnline ? Colors.orange.shade700 : Colors.red.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (isOnline && !_isSyncing) ...[
              const SizedBox(width: 6),
              Icon(
                Icons.refresh,
                size: 16,
                color: Colors.orange.shade700,
              ),
            ],
          ],
        ),
      ),
    );
  }
}