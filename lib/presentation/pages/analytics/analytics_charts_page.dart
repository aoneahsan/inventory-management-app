import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../services/analytics/analytics_service.dart';
import '../../providers/auth_provider.dart';

class AnalyticsChartsPage extends ConsumerStatefulWidget {
  const AnalyticsChartsPage({super.key});

  @override
  ConsumerState<AnalyticsChartsPage> createState() => _AnalyticsChartsPageState();
}

class _AnalyticsChartsPageState extends ConsumerState<AnalyticsChartsPage> {
  final _analyticsService = AnalyticsService();
  Map<String, dynamic>? _analyticsData;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadAnalytics();
  }

  Future<void> _loadAnalytics() async {
    final org = ref.read(currentOrganizationProvider);
    if (org != null) {
      final data = await _analyticsService.getAnalyticsData(org.id);
      if (mounted) {
        setState(() {
          _analyticsData = {
            ...data,
            'lowStockCount': data['low_stock_count'],
            'normalStockCount': (data['total_products'] as int) - 
                (data['low_stock_count'] as int) - 
                (data['out_of_stock'] as int),
            'overstockCount': 0,
            'categoryStats': data['category_stats'] ?? [],
          };
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInventoryValueChart(),
            const SizedBox(height: 24),
            _buildCategoryDistributionChart(),
            const SizedBox(height: 24),
            _buildStockLevelChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildInventoryValueChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Inventory Value by Category',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: _getCategoryValueSections(),
                  centerSpaceRadius: 40,
                  sectionsSpace: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryDistributionChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Products per Category',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  barGroups: _getCategoryBarGroups(),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text('Cat ${value.toInt()}');
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStockLevelChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Stock Levels Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStockIndicator('Low Stock', Colors.red, 
                    _analyticsData?['lowStockCount'] ?? 0),
                _buildStockIndicator('Normal Stock', Colors.green, 
                    _analyticsData?['normalStockCount'] ?? 0),
                _buildStockIndicator('Overstocked', Colors.orange, 
                    _analyticsData?['overstockCount'] ?? 0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStockIndicator(String label, Color color, int count) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              count.toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }

  List<PieChartSectionData> _getCategoryValueSections() {
    final categories = _analyticsData?['categoryStats'] as List<dynamic>? ?? [];
    return categories.take(5).map((cat) {
      return PieChartSectionData(
        value: (cat['totalValue'] as num).toDouble(),
        title: '${cat['name']}\n\$${cat['totalValue']}',
        color: Colors.primaries[categories.indexOf(cat) % Colors.primaries.length],
        radius: 80,
      );
    }).toList();
  }

  List<BarChartGroupData> _getCategoryBarGroups() {
    final categories = _analyticsData?['categoryStats'] as List<dynamic>? ?? [];
    return categories.take(5).map((cat) {
      final index = categories.indexOf(cat);
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: (cat['productCount'] as num).toDouble(),
            color: Colors.blue,
            width: 20,
          ),
        ],
      );
    }).toList();
  }
}