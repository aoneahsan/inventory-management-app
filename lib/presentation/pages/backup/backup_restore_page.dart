import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../services/backup/backup_service.dart';
import '../../providers/auth_provider.dart';

class BackupRestorePage extends ConsumerStatefulWidget {
  const BackupRestorePage({super.key});

  @override
  ConsumerState<BackupRestorePage> createState() => _BackupRestorePageState();
}

class _BackupRestorePageState extends ConsumerState<BackupRestorePage> {
  final _backupService = BackupService();
  List<BackupInfo> _backups = [];
  bool _loading = true;
  bool _processing = false;

  @override
  void initState() {
    super.initState();
    _loadBackups();
  }

  Future<void> _loadBackups() async {
    final org = ref.read(currentOrganizationProvider);
    if (org != null) {
      final backups = await _backupService.getBackupHistory(org.id);
      if (mounted) {
        setState(() {
          _backups = backups;
          _loading = false;
        });
      }
    }
  }

  Future<void> _createBackup() async {
    setState(() => _processing = true);

    try {
      final org = ref.read(currentOrganizationProvider);
      final user = ref.read(currentUserProvider);
      
      if (org != null && user != null) {
        await _backupService.createBackup(org.id, user.id);
        await _loadBackups();
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Backup created successfully')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Backup failed: $e')),
        );
      }
    } finally {
      setState(() => _processing = false);
    }
  }

  Future<void> _restoreBackup(String backupUrl) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restore Backup'),
        content: const Text(
          'This will replace all current data. Are you sure?'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Restore'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _processing = true);

    try {
      await _backupService.restoreBackup(backupUrl);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Backup restored successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Restore failed: $e')),
        );
      }
    } finally {
      setState(() => _processing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Backup & Restore'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _processing ? null : _loadBackups,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton.icon(
                    onPressed: _processing ? null : _createBackup,
                    icon: const Icon(Icons.backup),
                    label: const Text('Create New Backup'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                    ),
                  ),
                ),
                if (_processing)
                  const LinearProgressIndicator(),
                Expanded(
                  child: _backups.isEmpty
                      ? const Center(
                          child: Text('No backups found'),
                        )
                      : ListView.builder(
                          itemCount: _backups.length,
                          itemBuilder: (context, index) {
                            final backup = _backups[index];
                            return _BackupTile(
                              backup: backup,
                              onRestore: _processing
                                  ? null
                                  : () => _restoreBackup(backup.url),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}

class _BackupTile extends StatelessWidget {
  final BackupInfo backup;
  final VoidCallback? onRestore;

  const _BackupTile({
    required this.backup,
    this.onRestore,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.yMMMd().add_jm();
    final sizeInMB = (backup.size / 1024 / 1024).toStringAsFixed(2);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.cloud_download),
        ),
        title: Text(backup.name),
        subtitle: Text(
          '${dateFormat.format(backup.createdAt)} • $sizeInMB MB',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.restore),
          onPressed: onRestore,
          tooltip: 'Restore this backup',
        ),
      ),
    );
  }
}