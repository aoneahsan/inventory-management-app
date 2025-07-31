import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_plugin/inventory_management_plugin.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reports'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Sales'),
              Tab(text: 'Inventory'),
              Tab(text: 'Purchase'),
              Tab(text: 'Expiry'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _SalesReportTab(),
            _InventoryReportTab(),
            _PurchaseReportTab(),
            _ExpiryReportTab(),
          ],
        ),
      ),
    );
  }
}

class _SalesReportTab extends ConsumerStatefulWidget {
  const _SalesReportTab();

  @override
  ConsumerState<_SalesReportTab> createState() => _SalesReportTabState();
}

class _SalesReportTabState extends ConsumerState<_SalesReportTab> {
  DateTimeRange? _dateRange;
  String? _selectedBranch;
  String? _selectedCustomer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        // Filters
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: InkWell(
                        onTap: () async {
                          final range = await showDateRangePicker(
                            context: context,
                            firstDate: DateTime.now().subtract(const Duration(days: 365)),
                            lastDate: DateTime.now(),
                          );
                          if (range != null) {
                            setState(() {
                              _dateRange = range;
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              const Icon(Icons.date_range),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _dateRange != null
                                      ? '${_formatDate(_dateRange!.start)} - ${_formatDate(_dateRange!.end)}'
                                      : 'Select date range',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton.icon(
                    onPressed: _dateRange != null ? _generateReport : null,
                    icon: const Icon(Icons.analytics),
                    label: const Text('Generate'),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Report content
        Expanded(
          child: _dateRange == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.analytics_outlined,
                        size: 80,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Select a date range to generate report',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                )
              : _buildReportContent(),
        ),
      ],
    );
  }

  Widget _buildReportContent() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Summary cards
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: const [
            _ReportCard(
              title: 'Total Sales',
              value: '\$12,450',
              icon: Icons.monetization_on,
              color: Colors.green,
            ),
            _ReportCard(
              title: 'Transactions',
              value: '156',
              icon: Icons.receipt,
              color: Colors.blue,
            ),
            _ReportCard(
              title: 'Average Sale',
              value: '\$79.81',
              icon: Icons.trending_up,
              color: Colors.orange,
            ),
            _ReportCard(
              title: 'Top Product',
              value: 'Product ABC',
              icon: Icons.star,
              color: Colors.purple,
            ),
          ],
        ),
        const SizedBox(height: 24),
        
        // Sales chart placeholder
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sales Trend',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Container(
                  height: 200,
                  alignment: Alignment.center,
                  child: const Text('Sales chart would be displayed here'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Top products
        Card(
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
                ...List.generate(5, (index) => 
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text('Product ${String.fromCharCode(65 + index)}'),
                    subtitle: Text('${100 - index * 10} units sold'),
                    trailing: Text('\$${(100 - index * 10) * 15}'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _generateReport() async {
    if (_dateRange == null) return;
    
    final reportingService = ref.read(reportingServiceProvider);
    
    try {
      final report = await reportingService.generateSalesReport(
        startDate: _dateRange!.start,
        endDate: _dateRange!.end,
        branchId: _selectedBranch,
        customerId: _selectedCustomer,
      );
      
      // Update UI with report data
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Report generated successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error generating report: $e')),
        );
      }
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _InventoryReportTab extends ConsumerWidget {
  const _InventoryReportTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text('Inventory reports would be displayed here'),
    );
  }
}

class _PurchaseReportTab extends ConsumerWidget {
  const _PurchaseReportTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text('Purchase reports would be displayed here'),
    );
  }
}

class _ExpiryReportTab extends ConsumerWidget {
  const _ExpiryReportTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text('Expiry reports would be displayed here'),
    );
  }
}

class _ReportCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _ReportCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            const Spacer(),
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}