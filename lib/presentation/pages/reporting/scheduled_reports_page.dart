import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/scheduled_report.dart';
import '../../../services/reporting/scheduled_report_service.dart';
import '../../providers/organization_provider.dart';

final scheduledReportsProvider = FutureProvider.autoDispose<List<ScheduledReport>>((ref) async {
  final organizationId = ref.watch(currentOrganizationIdProvider);
  if (organizationId == null) return [];
  
  final service = ScheduledReportService();
  return service.getScheduledReports(organizationId);
});

class ScheduledReportsPage extends ConsumerWidget {
  const ScheduledReportsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportsAsync = ref.watch(scheduledReportsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scheduled Reports'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showReportDialog(context, ref),
          ),
        ],
      ),
      body: reportsAsync.when(
        data: (reports) {
          if (reports.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.schedule,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No scheduled reports',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Automate report generation and delivery',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => _showReportDialog(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text('Schedule Report'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final report = reports[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ExpansionTile(
                  leading: CircleAvatar(
                    backgroundColor: report.isActive
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Colors.grey.shade200,
                    child: Icon(
                      _getReportIcon(report.reportType),
                      color: report.isActive
                          ? Theme.of(context).colorScheme.onPrimaryContainer
                          : Colors.grey,
                    ),
                  ),
                  title: Text(
                    report.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report.reportType.displayName,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 14,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _getFrequencyDisplay(report),
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Switch(
                    value: report.isActive,
                    onChanged: (value) async {
                      try {
                        final service = ScheduledReportService();
                        final organizationId = ref.read(currentOrganizationIdProvider);
                        if (organizationId == null) return;
                        
                        await service.updateReport(
                          organizationId: organizationId,
                          reportId: report.id,
                          isActive: value,
                        );
                        
                        ref.invalidate(scheduledReportsProvider);
                        
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Report ${value ? 'activated' : 'deactivated'}',
                              ),
                            ),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error updating report: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow(
                            context,
                            'Format:',
                            report.format.displayName,
                            Icons.description,
                          ),
                          const SizedBox(height: 8),
                          _buildInfoRow(
                            context,
                            'Recipients:',
                            report.recipients.join(', '),
                            Icons.email,
                          ),
                          if (report.deliveryTime != null) ...[
                            const SizedBox(height: 8),
                            _buildInfoRow(
                              context,
                              'Delivery Time:',
                              report.deliveryTime!,
                              Icons.access_time,
                            ),
                          ],
                          if (report.lastRunAt != null) ...[
                            const SizedBox(height: 8),
                            _buildInfoRow(
                              context,
                              'Last Run:',
                              _formatDateTime(report.lastRunAt!),
                              Icons.history,
                            ),
                          ],
                          if (report.nextRunAt != null) ...[
                            const SizedBox(height: 8),
                            _buildInfoRow(
                              context,
                              'Next Run:',
                              _formatDateTime(report.nextRunAt!),
                              Icons.upcoming,
                            ),
                          ],
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                onPressed: () async {
                                  await _runReportNow(context, ref, report);
                                },
                                icon: const Icon(Icons.play_arrow),
                                label: const Text('Run Now'),
                              ),
                              const SizedBox(width: 8),
                              TextButton.icon(
                                onPressed: () {
                                  _showReportHistory(context, ref, report);
                                },
                                icon: const Icon(Icons.history),
                                label: const Text('History'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Theme.of(context).colorScheme.outline),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.outline,
            fontSize: 13,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }

  IconData _getReportIcon(ReportType type) {
    switch (type) {
      case ReportType.inventory:
        return Icons.inventory_2;
      case ReportType.sales:
        return Icons.trending_up;
      case ReportType.purchase:
        return Icons.shopping_cart;
      case ReportType.stockMovement:
        return Icons.swap_horiz;
      case ReportType.expiry:
        return Icons.calendar_today;
      case ReportType.custom:
        return Icons.analytics;
      case ReportType.financial:
        return Icons.attach_money;
      case ReportType.customer:
        return Icons.people;
      case ReportType.supplier:
        return Icons.business;
      case ReportType.lowStock:
        return Icons.warning;
    }
  }

  String _getFrequencyDisplay(ScheduledReport report) {
    switch (report.frequency) {
      case ReportFrequency.daily:
        return 'Daily at ${report.deliveryTime ?? "9:00 AM"}';
      case ReportFrequency.weekly:
        final days = (report.parameters?['days'] as List<String>?) ?? ['Monday'];
        return 'Weekly on ${days.join(", ")}';
      case ReportFrequency.monthly:
        final day = report.parameters?['day'] ?? 1;
        return 'Monthly on day $day';
      case ReportFrequency.quarterly:
        return 'Quarterly';
      case ReportFrequency.yearly:
        return 'Yearly';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = dateTime.difference(now);
    
    if (difference.isNegative) {
      if (difference.inDays.abs() == 0) {
        return 'Today at ${_formatTime(dateTime)}';
      } else if (difference.inDays.abs() == 1) {
        return 'Yesterday at ${_formatTime(dateTime)}';
      } else if (difference.inDays.abs() < 7) {
        return '${difference.inDays.abs()} days ago';
      }
    } else {
      if (difference.inDays == 0) {
        return 'Today at ${_formatTime(dateTime)}';
      } else if (difference.inDays == 1) {
        return 'Tomorrow at ${_formatTime(dateTime)}';
      } else if (difference.inDays < 7) {
        return 'In ${difference.inDays} days';
      }
    }
    
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:${dateTime.minute.toString().padLeft(2, '0')} $period';
  }

  void _showReportDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => const _ScheduledReportDialog(),
    );
  }

  Future<void> _runReportNow(BuildContext context, WidgetRef ref, ScheduledReport report) async {
    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text('Generating report...'),
            ],
          ),
        ),
      );

      final service = ScheduledReportService();
      final organizationId = ref.read(currentOrganizationIdProvider);
      if (organizationId == null) {
        Navigator.of(context).pop();
        return;
      }

      await service.runReportNow(
        organizationId: organizationId,
        reportId: report.id,
      );

      if (context.mounted) {
        Navigator.of(context).pop(); // Close loading dialog
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Report generated and sent to ${report.recipients.join(", ")}'),
            backgroundColor: Colors.green,
          ),
        );
        
        // Refresh the reports list to update last run time
        ref.invalidate(scheduledReportsProvider);
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop(); // Close loading dialog
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error generating report: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showReportHistory(BuildContext context, WidgetRef ref, ScheduledReport report) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _ReportHistorySheet(report: report),
    );
  }
}

class _ScheduledReportDialog extends StatefulWidget {
  const _ScheduledReportDialog();

  @override
  State<_ScheduledReportDialog> createState() => _ScheduledReportDialogState();
}

class _ScheduledReportDialogState extends State<_ScheduledReportDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _recipientsController = TextEditingController();
  
  ReportType _selectedType = ReportType.inventory;
  ReportFrequency _selectedFrequency = ReportFrequency.daily;
  ReportFormat _selectedFormat = ReportFormat.pdf;
  TimeOfDay _deliveryTime = const TimeOfDay(hour: 9, minute: 0);

  @override
  void dispose() {
    _nameController.dispose();
    _recipientsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Schedule New Report'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Report Name*',
                  hintText: 'e.g., Daily Inventory Report',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter report name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<ReportType>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Report Type',
                ),
                items: ReportType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Row(
                      children: [
                        Icon(
                          _getReportTypeIcon(type),
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(type.displayName),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedType = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<ReportFrequency>(
                value: _selectedFrequency,
                decoration: const InputDecoration(
                  labelText: 'Frequency',
                ),
                items: ReportFrequency.values.map((frequency) {
                  return DropdownMenuItem(
                    value: frequency,
                    child: Text(frequency.displayName),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedFrequency = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Delivery Time'),
                subtitle: Text(_deliveryTime.format(context)),
                trailing: const Icon(Icons.access_time),
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: _deliveryTime,
                  );
                  if (time != null) {
                    setState(() => _deliveryTime = time);
                  }
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<ReportFormat>(
                value: _selectedFormat,
                decoration: const InputDecoration(
                  labelText: 'Format',
                ),
                items: ReportFormat.values.map((format) {
                  return DropdownMenuItem(
                    value: format,
                    child: Text(format.displayName),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedFormat = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _recipientsController,
                decoration: const InputDecoration(
                  labelText: 'Recipients*',
                  hintText: 'email1@example.com, email2@example.com',
                  helperText: 'Comma-separated email addresses',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter at least one recipient';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await _createScheduledReport(context);
            }
          },
          child: const Text('Schedule'),
        ),
      ],
    );
  }

  IconData _getReportTypeIcon(ReportType type) {
    switch (type) {
      case ReportType.inventory:
        return Icons.inventory_2;
      case ReportType.sales:
        return Icons.trending_up;
      case ReportType.purchase:
        return Icons.shopping_cart;
      case ReportType.stockMovement:
        return Icons.swap_horiz;
      case ReportType.expiry:
        return Icons.calendar_today;
      case ReportType.custom:
        return Icons.analytics;
      case ReportType.financial:
        return Icons.attach_money;
      case ReportType.customer:
        return Icons.people;
      case ReportType.supplier:
        return Icons.business;
      case ReportType.lowStock:
        return Icons.warning;
    }
  }

  Future<void> _createScheduledReport(BuildContext context) async {
    try {
      // Parse recipients
      final recipients = _recipientsController.text
          .split(',')
          .map((email) => email.trim())
          .where((email) => email.isNotEmpty)
          .toList();

      // Build parameters based on frequency
      final parameters = <String, dynamic>{};
      switch (_selectedFrequency) {
        case ReportFrequency.weekly:
          parameters['days'] = ['Monday']; // Default to Monday
          break;
        case ReportFrequency.monthly:
          parameters['day'] = 1; // Default to 1st of month
          break;
        default:
          break;
      }

      final report = ScheduledReport(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        organizationId: '', // Will be set by service
        name: _nameController.text.trim(),
        reportType: _selectedType,
        frequency: _selectedFrequency,
        format: _selectedFormat,
        recipients: recipients,
        deliveryTime: _deliveryTime.format(context),
        parameters: parameters,
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Get the current context's WidgetRef
      final container = ProviderScope.containerOf(context);
      final organizationId = container.read(currentOrganizationIdProvider);
      if (organizationId == null) {
        throw Exception('No organization selected');
      }

      final service = ScheduledReportService();
      await service.createScheduledReport(
        organizationId: organizationId,
        report: report,
      );

      if (context.mounted) {
        // Refresh the reports list
        container.invalidate(scheduledReportsProvider);
        
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Scheduled report created successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating scheduled report: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

class _ReportHistorySheet extends ConsumerWidget {
  final ScheduledReport report;

  const _ReportHistorySheet({
    required this.report,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) => Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Report History',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchReportHistory(ref),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                final history = snapshot.data ?? [];
                if (history.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          size: 48,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        const SizedBox(height: 16),
                        const Text('No history available'),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final run = history[index];
                    final status = run['status'] as String;
                    final runAt = DateTime.parse(run['runAt'] as String);
                    
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: status == 'success'
                              ? Colors.green.withValues(alpha: 0.1)
                              : Colors.red.withValues(alpha: 0.1),
                          child: Icon(
                            status == 'success'
                                ? Icons.check_circle
                                : Icons.error,
                            color: status == 'success'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        title: Text(
                          _formatDateTime(runAt),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Status: ${status.toUpperCase()}',
                              style: TextStyle(
                                color: status == 'success'
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            if (run['error'] != null)
                              Text(
                                'Error: ${run['error']}',
                                style: const TextStyle(fontSize: 12),
                              ),
                            if (run['duration'] != null)
                              Text(
                                'Duration: ${run['duration']}ms',
                                style: const TextStyle(fontSize: 12),
                              ),
                          ],
                        ),
                        trailing: run['downloadUrl'] != null
                            ? IconButton(
                                icon: const Icon(Icons.download),
                                onPressed: () {
                                  // TODO: Download report
                                },
                              )
                            : null,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchReportHistory(WidgetRef ref) async {
    final organizationId = ref.read(currentOrganizationIdProvider);
    if (organizationId == null) return [];

    final service = ScheduledReportService();
    return service.getReportHistory(
      organizationId: organizationId,
      reportId: report.id,
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}