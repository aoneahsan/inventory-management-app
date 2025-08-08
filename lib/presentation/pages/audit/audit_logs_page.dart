import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../services/audit/audit_service.dart';
import '../../../domain/entities/audit_log.dart';
import '../../providers/auth_provider.dart';

class AuditLogsPage extends ConsumerStatefulWidget {
  const AuditLogsPage({super.key});

  @override
  ConsumerState<AuditLogsPage> createState() => _AuditLogsPageState();
}

class _AuditLogsPageState extends ConsumerState<AuditLogsPage> {
  final _auditService = AuditService();
  String? _selectedAction;
  String? _selectedEntityType;

  @override
  Widget build(BuildContext context) {
    final org = ref.watch(currentOrganizationProvider);
    if (org == null) {
      return const Scaffold(
        body: Center(child: Text('No organization selected')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Audit Logs'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              setState(() {
                if (value.startsWith('action:')) {
                  _selectedAction = value.substring(7);
                } else if (value.startsWith('entity:')) {
                  _selectedEntityType = value.substring(7);
                } else if (value == 'clear') {
                  _selectedAction = null;
                  _selectedEntityType = null;
                }
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'clear',
                child: Text('Clear Filters'),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'action:CREATE',
                child: Text('Created'),
              ),
              const PopupMenuItem(
                value: 'action:UPDATE',
                child: Text('Updated'),
              ),
              const PopupMenuItem(
                value: 'action:DELETE',
                child: Text('Deleted'),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'entity:product',
                child: Text('Products'),
              ),
              const PopupMenuItem(
                value: 'entity:customer',
                child: Text('Customers'),
              ),
              const PopupMenuItem(
                value: 'entity:order',
                child: Text('Orders'),
              ),
            ],
          ),
        ],
      ),
      body: StreamBuilder<List<AuditLog>>(
        stream: _auditService.streamAuditLogs(organizationId: org.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          var logs = snapshot.data ?? [];

          // Apply filters
          if (_selectedAction != null) {
            logs = logs.where((log) => log.action == _selectedAction).toList();
          }
          if (_selectedEntityType != null) {
            logs = logs.where((log) => log.entityType == _selectedEntityType).toList();
          }

          if (logs.isEmpty) {
            return const Center(child: Text('No audit logs found'));
          }

          return ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              return _AuditLogTile(log: log);
            },
          );
        },
      ),
    );
  }
}

class _AuditLogTile extends StatelessWidget {
  final AuditLog log;
  final _dateFormat = DateFormat.yMMMd().add_jm();

  _AuditLogTile({required this.log});

  IconData _getIcon() {
    switch (log.action) {
      case AuditAction.create:
        return Icons.add_circle;
      case AuditAction.update:
        return Icons.edit;
      case AuditAction.delete:
        return Icons.delete;
      case AuditAction.login:
        return Icons.login;
      case AuditAction.logout:
        return Icons.logout;
      case AuditAction.export:
        return Icons.download;
      case AuditAction.import:
        return Icons.upload;
      case AuditAction.backup:
        return Icons.backup;
      case AuditAction.restore:
        return Icons.restore;
      default:
        return Icons.info;
    }
  }

  Color _getColor() {
    switch (log.action) {
      case AuditAction.create:
        return Colors.green;
      case AuditAction.update:
        return Colors.blue;
      case AuditAction.delete:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: _getColor().withValues(alpha: 0.1),
          child: Icon(_getIcon(), color: _getColor()),
        ),
        title: Text('${log.action} ${log.entityType}'),
        subtitle: Text('by ${log.userName} • ${_dateFormat.format(log.timestamp)}'),
        children: [
          if (log.entityId != null)
            ListTile(
              dense: true,
              title: const Text('Entity ID'),
              subtitle: Text(log.entityId!),
            ),
          if (log.oldData != null)
            ListTile(
              dense: true,
              title: const Text('Old Data'),
              subtitle: Text(log.oldData.toString()),
            ),
          if (log.newData != null)
            ListTile(
              dense: true,
              title: const Text('New Data'),
              subtitle: Text(log.newData.toString()),
            ),
        ],
      ),
    );
  }
}