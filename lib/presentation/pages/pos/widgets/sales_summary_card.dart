import 'package:flutter/material.dart';

class SalesSummaryCard extends StatelessWidget {
  final Map<String, dynamic> summary;

  const SalesSummaryCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sales Summary',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              childAspectRatio: 2.5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _SummaryItem(
                  label: 'Total Revenue',
                  value: '\$${(summary['totalRevenue'] ?? 0).toStringAsFixed(2)}',
                  icon: Icons.attach_money,
                  color: Colors.green,
                ),
                _SummaryItem(
                  label: 'Transactions',
                  value: '${summary['totalTransactions'] ?? 0}',
                  icon: Icons.receipt,
                  color: Colors.blue,
                ),
                _SummaryItem(
                  label: 'Average Sale',
                  value: '\$${(summary['averageSale'] ?? 0).toStringAsFixed(2)}',
                  icon: Icons.trending_up,
                  color: Colors.orange,
                ),
                _SummaryItem(
                  label: 'Total Tax',
                  value: '\$${(summary['totalTax'] ?? 0).toStringAsFixed(2)}',
                  icon: Icons.account_balance,
                  color: Colors.purple,
                ),
                _SummaryItem(
                  label: 'Total Discount',
                  value: '\$${(summary['totalDiscount'] ?? 0).toStringAsFixed(2)}',
                  icon: Icons.local_offer,
                  color: Colors.red,
                ),
                _SummaryItem(
                  label: 'Min Sale',
                  value: '\$${(summary['minSale'] ?? 0).toStringAsFixed(2)}',
                  icon: Icons.trending_down,
                  color: Colors.grey,
                ),
                _SummaryItem(
                  label: 'Max Sale',
                  value: '\$${(summary['maxSale'] ?? 0).toStringAsFixed(2)}',
                  icon: Icons.trending_up,
                  color: Colors.teal,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}