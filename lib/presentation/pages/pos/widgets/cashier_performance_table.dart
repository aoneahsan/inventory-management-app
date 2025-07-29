import 'package:flutter/material.dart';

class CashierPerformanceTable extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const CashierPerformanceTable({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cashier Performance',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Cashier')),
                  DataColumn(label: Text('Transactions')),
                  DataColumn(label: Text('Total Sales')),
                  DataColumn(label: Text('Average Sale')),
                ],
                rows: data.map((cashier) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Text(
                          cashier['user_name'] ?? 'Unknown',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataCell(Text('${cashier['transaction_count'] ?? 0}')),
                      DataCell(
                        Text(
                          '\$${(cashier['total_amount'] ?? 0).toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataCell(
                        Text('\$${(cashier['average_sale'] ?? 0).toStringAsFixed(2)}'),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}