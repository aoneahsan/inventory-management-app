import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/serial_number.dart';
import '../../../domain/entities/batch.dart';
import '../../../services/tracking/serial_batch_service.dart';
import '../../providers/organization_provider.dart';

enum TrackingView { serials, batches }

class SerialBatchPage extends ConsumerStatefulWidget {
  const SerialBatchPage({super.key});

  @override
  ConsumerState<SerialBatchPage> createState() => _SerialBatchPageState();
}

class _SerialBatchPageState extends ConsumerState<SerialBatchPage> 
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _service = SerialBatchService();
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Serial & Batch Tracking'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Serial Numbers'),
            Tab(text: 'Batches'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _SerialNumbersView(service: _service),
          _BatchesView(service: _service),
        ],
      ),
    );
  }
}

class _SerialNumbersView extends ConsumerWidget {
  final SerialBatchService service;

  const _SerialNumbersView({required this.service});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final organizationId = ref.watch(currentOrganizationIdProvider);
    
    if (organizationId == null) {
      return const Center(child: Text('No organization selected'));
    }

    return FutureBuilder<List<SerialNumber>>(
      future: service.getSerialNumbers(organizationId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final serials = snapshot.data ?? [];
        
        if (serials.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.qr_code_2,
                  size: 64,
                  color: Theme.of(context).colorScheme.outline,
                ),
                const SizedBox(height: 16),
                Text(
                  'No serial numbers tracked',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Serial numbers will appear here when added',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: serials.length,
          itemBuilder: (context, index) {
            final serial = serials[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: _getSerialStatusColor(serial.status),
                  child: Icon(
                    _getSerialStatusIcon(serial.status),
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                title: Text(serial.serialNumber),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Product: ${serial.productId}'),
                    if (serial.warrantyEndDate != null)
                      Text(
                        'Warranty: ${_formatDate(serial.warrantyEndDate!)}',
                        style: TextStyle(
                          color: serial.warrantyEndDate!.isAfter(DateTime.now())
                              ? Colors.green
                              : Colors.red,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
                trailing: Chip(
                  label: Text(
                    serial.status.displayName,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Color _getSerialStatusColor(SerialStatus status) {
    switch (status) {
      case SerialStatus.available:
        return Colors.green;
      case SerialStatus.sold:
        return Colors.blue;
      case SerialStatus.returned:
        return Colors.orange;
      case SerialStatus.damaged:
        return Colors.red;
      case SerialStatus.lost:
        return Colors.grey;
    }
  }

  IconData _getSerialStatusIcon(SerialStatus status) {
    switch (status) {
      case SerialStatus.available:
        return Icons.check_circle;
      case SerialStatus.sold:
        return Icons.shopping_cart;
      case SerialStatus.returned:
        return Icons.undo;
      case SerialStatus.damaged:
        return Icons.warning;
      case SerialStatus.lost:
        return Icons.help_outline;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _BatchesView extends ConsumerWidget {
  final SerialBatchService service;

  const _BatchesView({required this.service});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final organizationId = ref.watch(currentOrganizationIdProvider);
    
    if (organizationId == null) {
      return const Center(child: Text('No organization selected'));
    }

    return FutureBuilder<List<Batch>>(
      future: service.getBatches(organizationId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final batches = snapshot.data ?? [];
        
        if (batches.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inventory_2,
                  size: 64,
                  color: Theme.of(context).colorScheme.outline,
                ),
                const SizedBox(height: 16),
                Text(
                  'No batches tracked',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Batches will appear here when added',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: batches.length,
          itemBuilder: (context, index) {
            final batch = batches[index];
            final isExpired = batch.expiryDate != null && 
                batch.expiryDate!.isBefore(DateTime.now());
            final isNearExpiry = batch.expiryDate != null && 
                !isExpired &&
                batch.expiryDate!.isBefore(
                  DateTime.now().add(const Duration(days: 30))
                );

            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: isExpired
                      ? Colors.red
                      : isNearExpiry
                          ? Colors.orange
                          : Colors.green,
                  child: Icon(
                    isExpired
                        ? Icons.error
                        : isNearExpiry
                            ? Icons.warning
                            : Icons.check,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                title: Text(batch.batchNumber),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Product: ${batch.productId}'),
                    Text('Qty: ${batch.currentQuantity}/${batch.initialQuantity}'),
                    if (batch.expiryDate != null)
                      Text(
                        'Expiry: ${_formatDate(batch.expiryDate!)}',
                        style: TextStyle(
                          color: isExpired
                              ? Colors.red
                              : isNearExpiry
                                  ? Colors.orange
                                  : Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹${batch.costPrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      batch.status,
                      style: TextStyle(
                        fontSize: 12,
                        color: batch.status == 'active'
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}