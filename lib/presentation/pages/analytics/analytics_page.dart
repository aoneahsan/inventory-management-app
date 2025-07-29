import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/analytics/analytics_service.dart';
import '../../providers/auth_provider.dart';

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  return AnalyticsService();
});

final analyticsDataProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final org = ref.watch(currentOrganizationProvider);
  if (org == null) throw Exception('No organization');
  
  final analyticsService = ref.watch(analyticsServiceProvider);
  return analyticsService.getAnalyticsData(org.id);
});

class AnalyticsPage extends ConsumerStatefulWidget {
  const AnalyticsPage({super.key});

  @override
  ConsumerState<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends ConsumerState<AnalyticsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        title: const Text('Analytics & Reports'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Overview', icon: Icon(Icons.dashboard)),
            Tab(text: 'Inventory', icon: Icon(Icons.inventory)),
            Tab(text: 'Reports', icon: Icon(Icons.assessment)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildInventoryTab(),
          _buildReportsTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return Consumer(
      builder: (context, ref, child) {
        final analyticsAsync = ref.watch(analyticsDataProvider);

        return analyticsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
          data: (analytics) {
            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(analyticsDataProvider);
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    'Business Overview',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Key Metrics
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.2,
                    children: [
                      _buildMetricCard(
                        'Total Revenue',
                        '\$${analytics['total_revenue'] ?? 0}',
                        Icons.monetization_on,
                        Colors.green,
                        '+12.5%',
                      ),
                      _buildMetricCard(
                        'Total Orders',
                        '${analytics['total_orders'] ?? 0}',
                        Icons.shopping_cart,
                        Colors.blue,
                        '+8.3%',
                      ),
                      _buildMetricCard(
                        'Inventory Value',
                        '\$${analytics['inventory_value'] ?? 0}',
                        Icons.inventory,
                        Colors.orange,
                        '+15.2%',
                      ),
                      _buildMetricCard(
                        'Low Stock Items',
                        '${analytics['low_stock_count'] ?? 0}',
                        Icons.warning,
                        Colors.red,
                        '-5.7%',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Chart placeholder
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Revenue Trend',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'Revenue Chart\n(Chart library integration needed)',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInventoryTab() {
    return Consumer(
      builder: (context, ref, child) {
        final analyticsAsync = ref.watch(analyticsDataProvider);

        return analyticsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
          data: (analytics) {
            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(analyticsDataProvider);
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    'Inventory Analytics',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Inventory metrics
                  Row(
                    children: [
                      Expanded(
                        child: _buildInventoryMetricCard(
                          'Total Products',
                          '${analytics['total_products'] ?? 0}',
                          Icons.inventory_2,
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildInventoryMetricCard(
                          'Categories',
                          '${analytics['total_categories'] ?? 0}',
                          Icons.category,
                          Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInventoryMetricCard(
                          'Out of Stock',
                          '${analytics['out_of_stock'] ?? 0}',
                          Icons.remove_circle,
                          Colors.red,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildInventoryMetricCard(
                          'Low Stock',
                          '${analytics['low_stock_count'] ?? 0}',
                          Icons.warning,
                          Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Top products
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Top Moving Products',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 16),
                          ...((analytics['top_products'] as List?)?.map((product) =>
                              _buildTopProductTile(product)) ?? []),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildReportsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Available Reports',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        
        // Report categories
        _buildReportCard(
          'Inventory Reports',
          'Stock levels, movements, and valuation reports',
          Icons.inventory,
          Colors.blue,
          [
            'Stock Valuation Report',
            'Inventory Movement Report',
            'Low Stock Report',
            'Product Performance Report',
          ],
        ),
        const SizedBox(height: 16),
        _buildReportCard(
          'Financial Reports',
          'Revenue, costs, and profitability analysis',
          Icons.monetization_on,
          Colors.green,
          [
            'Revenue Report',
            'Profit & Loss Report',
            'Cost Analysis Report',
            'Financial Summary',
          ],
        ),
        const SizedBox(height: 16),
        _buildReportCard(
          'Operational Reports',
          'User activity and system performance',
          Icons.assessment,
          Colors.orange,
          [
            'User Activity Report',
            'System Usage Report',
            'Performance Metrics',
            'Audit Trail Report',
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, String change) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 24),
                Text(
                  change,
                  style: TextStyle(
                    color: change.startsWith('+') ? Colors.green : Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInventoryMetricCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopProductTile(Map<String, dynamic> product) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(
          '${product['movements'] ?? 0}',
          style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(product['name'] ?? 'Unknown Product'),
      subtitle: Text('SKU: ${product['sku'] ?? 'N/A'}'),
      trailing: Text(
        '${product['movements'] ?? 0} movements',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildReportCard(String title, String description, IconData icon, Color color, List<String> reports) {
    return Card(
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(description),
        children: reports.map((report) => ListTile(
          dense: true,
          leading: const Icon(Icons.description, size: 16),
          title: Text(report),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.visibility, size: 16),
                onPressed: () => _viewReport(report),
              ),
              IconButton(
                icon: const Icon(Icons.download, size: 16),
                onPressed: () => _downloadReport(report),
              ),
            ],
          ),
        )).toList(),
      ),
    );
  }

  void _viewReport(String reportName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Viewing $reportName')),
    );
  }

  void _downloadReport(String reportName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloading $reportName')),
    );
  }
}