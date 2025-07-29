import 'package:flutter/material.dart';

class TopProductsTable extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const TopProductsTable({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top Selling Products',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Rank')),
                  DataColumn(label: Text('Product')),
                  DataColumn(label: Text('Quantity Sold')),
                  DataColumn(label: Text('Revenue')),
                  DataColumn(label: Text('Transactions')),
                ],
                rows: products.asMap().entries.map((entry) {
                  final index = entry.key;
                  final product = entry.value;
                  
                  return DataRow(
                    cells: [
                      DataCell(Text('#${index + 1}')),
                      DataCell(
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 200),
                          child: Text(
                            product['product_name'] ?? 'Unknown',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      DataCell(Text('${product['total_quantity'] ?? 0}')),
                      DataCell(
                        Text(
                          '\$${(product['total_revenue'] ?? 0).toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataCell(Text('${product['transaction_count'] ?? 0}')),
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