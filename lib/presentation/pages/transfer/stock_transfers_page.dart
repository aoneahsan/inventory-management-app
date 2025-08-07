import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/stock_transfer.dart';
import '../../../services/transfer/stock_transfer_service.dart';
import '../../providers/organization_provider.dart';

final stockTransfersProvider = FutureProvider.autoDispose<List<StockTransfer>>((ref) async {
  final organizationId = ref.watch(currentOrganizationIdProvider);
  if (organizationId == null) return [];
  
  final service = StockTransferService();
  return service.getTransfers(organizationId);
});

class StockTransfersPage extends ConsumerStatefulWidget {
  const StockTransfersPage({super.key});

  @override
  ConsumerState<StockTransfersPage> createState() => _StockTransfersPageState();
}

class _StockTransfersPageState extends ConsumerState<StockTransfersPage> {
  TransferStatus? _filterStatus;

  @override
  Widget build(BuildContext context) {
    final transfersAsync = ref.watch(stockTransfersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Transfers'),
        actions: [
          PopupMenuButton<TransferStatus?>(
            icon: const Icon(Icons.filter_list),
            onSelected: (status) {
              setState(() => _filterStatus = status);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: null,
                child: Text('All Transfers'),
              ),
              ...TransferStatus.values.map(
                (status) => PopupMenuItem(
                  value: status,
                  child: Text(status.displayName),
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/transfers/new'),
          ),
        ],
      ),
      // Drawer removed
      body: transfersAsync.when(
        data: (transfers) {
          final filteredTransfers = _filterStatus == null
              ? transfers
              : transfers.where((t) => t.status == _filterStatus).toList();

          if (filteredTransfers.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.swap_horiz,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No stock transfers',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Transfer inventory between branches',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => context.push('/transfers/new'),
                    icon: const Icon(Icons.add),
                    label: const Text('Create Transfer'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredTransfers.length,
            itemBuilder: (context, index) {
              final transfer = filteredTransfers[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () => context.push('/transfers/${transfer.id}'),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              transfer.transferNumber,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            _buildStatusChip(transfer.status),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'From: ${transfer.fromBranchId}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(width: 16),
                            Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            const SizedBox(width: 16),
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'To: ${transfer.toBranchId}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Items: ${transfer.items?.length ?? 0}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              _formatDate(transfer.transferDate),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        if (transfer.notes != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            transfer.notes!,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
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

  Widget _buildStatusChip(TransferStatus status) {
    Color backgroundColor;
    Color foregroundColor;

    switch (status) {
      case TransferStatus.pending:
        backgroundColor = Colors.orange.shade100;
        foregroundColor = Colors.orange.shade800;
        break;
      case TransferStatus.inTransit:
        backgroundColor = Colors.blue.shade100;
        foregroundColor = Colors.blue.shade800;
        break;
      case TransferStatus.completed:
        backgroundColor = Colors.green.shade100;
        foregroundColor = Colors.green.shade800;
        break;
      case TransferStatus.cancelled:
        backgroundColor = Colors.red.shade100;
        foregroundColor = Colors.red.shade800;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          color: foregroundColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}