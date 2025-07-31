import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/purchase_order.dart';
// Removed unused imports
import '../purchase_orders/purchase_orders_page.dart';

final purchaseOrderProvider = FutureProvider.family<PurchaseOrder?, String>((ref, orderId) async {
  final service = ref.watch(purchaseOrderServiceProvider);
  return await service.getPurchaseOrderById(orderId);
});

class PurchaseOrderDetailsPage extends ConsumerWidget {
  final String purchaseOrderId;

  const PurchaseOrderDetailsPage({
    super.key,
    required this.purchaseOrderId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderAsync = ref.watch(purchaseOrderProvider(purchaseOrderId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase Order Details'),
        actions: [
          orderAsync.when(
            data: (order) {
              if (order == null) return const SizedBox();
              return PopupMenuButton<String>(
                onSelected: (value) async {
                  switch (value) {
                    case 'edit':
                      context.push('/purchase-orders/$purchaseOrderId/edit');
                      break;
                    case 'send':
                      // TODO: Send PO
                      break;
                    case 'receive':
                      context.push('/purchase-orders/$purchaseOrderId/receive');
                      break;
                    case 'cancel':
                      // TODO: Cancel PO
                      break;
                  }
                },
                itemBuilder: (context) => [
                  if (order.canEdit)
                    const PopupMenuItem(
                      value: 'edit',
                      child: ListTile(
                        leading: Icon(Icons.edit),
                        title: Text('Edit'),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  if (order.canSend)
                    const PopupMenuItem(
                      value: 'send',
                      child: ListTile(
                        leading: Icon(Icons.send),
                        title: Text('Send to Supplier'),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  if (order.canReceive)
                    const PopupMenuItem(
                      value: 'receive',
                      child: ListTile(
                        leading: Icon(Icons.inventory),
                        title: Text('Receive Goods'),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  if (order.canCancel)
                    const PopupMenuItem(
                      value: 'cancel',
                      child: ListTile(
                        leading: Icon(Icons.cancel, color: Colors.red),
                        title: Text('Cancel Order', style: TextStyle(color: Colors.red)),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                ],
              );
            },
            loading: () => const SizedBox(),
            error: (_, _) => const SizedBox(),
          ),
        ],
      ),
      body: orderAsync.when(
        data: (order) {
          if (order == null) {
            return const Center(
              child: Text('Purchase order not found'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              order.poNumber,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            _StatusChip(status: order.status),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (order.receivePercentage > 0 && order.receivePercentage < 100) ...[
                          LinearProgressIndicator(
                            value: order.receivePercentage / 100,
                            backgroundColor: Colors.grey[300],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${order.receivePercentage.toStringAsFixed(0)}% received',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Order Info
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Information',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        _InfoRow(
                          label: 'Order Date',
                          value: _formatDate(order.orderDate),
                        ),
                        if (order.expectedDate != null)
                          _InfoRow(
                            label: 'Expected Date',
                            value: _formatDate(order.expectedDate!),
                          ),
                        _InfoRow(
                          label: 'Supplier ID',
                          value: order.supplierId, // TODO: Show supplier name
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Items
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Items',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        ...order.items.map((item) => _buildItemRow(context, item)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Totals
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _TotalRow(
                          label: 'Subtotal',
                          value: order.subtotal,
                        ),
                        if (order.discountAmount > 0)
                          _TotalRow(
                            label: 'Discount',
                            value: -order.discountAmount,
                            color: Colors.green,
                          ),
                        if (order.taxAmount > 0)
                          _TotalRow(
                            label: 'Tax',
                            value: order.taxAmount,
                          ),
                        const Divider(),
                        _TotalRow(
                          label: 'Total',
                          value: order.totalAmount,
                          isTotal: true,
                        ),
                      ],
                    ),
                  ),
                ),
                if (order.notes != null && order.notes!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notes',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(order.notes!),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: ${error.toString()}'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  ref.invalidate(purchaseOrderProvider(purchaseOrderId));
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemRow(BuildContext context, PurchaseOrderItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product ID: ${item.productId}', // TODO: Show product name
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  '${item.quantity} units @ \$${item.unitPrice.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (item.receivedQuantity > 0)
                  Text(
                    'Received: ${item.receivedQuantity} units',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
          Text(
            '\$${item.totalAmount.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (status) {
      case 'draft':
        color = Colors.grey;
        label = 'Draft';
        break;
      case 'sent':
        color = Colors.blue;
        label = 'Sent';
        break;
      case 'partial':
        color = Colors.orange;
        label = 'Partially Received';
        break;
      case 'received':
        color = Colors.green;
        label = 'Received';
        break;
      case 'cancelled':
        color = Colors.red;
        label = 'Cancelled';
        break;
      default:
        color = Colors.grey;
        label = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey[600]),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _TotalRow extends StatelessWidget {
  final String label;
  final double value;
  final Color? color;
  final bool isTotal;

  const _TotalRow({
    required this.label,
    required this.value,
    this.color,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
          Text(
            '\$${value.abs().toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              fontSize: isTotal ? 16 : 14,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}