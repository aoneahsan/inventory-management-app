import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import '../../../services/pos/pos_analytics_service.dart';
import '../../../services/database/database.dart';
import '../../../services/export/report_export_service.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/date_range_picker.dart';
import 'widgets/sales_summary_card.dart';
import 'widgets/payment_method_chart.dart';
import 'widgets/top_products_table.dart';
import 'widgets/hourly_sales_chart.dart';
import 'widgets/daily_trend_chart.dart';
import 'widgets/cashier_performance_table.dart';

final posAnalyticsProvider = Provider<POSAnalyticsService>((ref) {
  return POSAnalyticsService(database: AppDatabase.instance);
});

class POSReportsPage extends ConsumerStatefulWidget {
  const POSReportsPage({super.key});

  @override
  ConsumerState<POSReportsPage> createState() => _POSReportsPageState();
}

class _POSReportsPageState extends ConsumerState<POSReportsPage> {
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime _endDate = DateTime.now();
  String? _selectedRegisterId;
  bool _isLoading = true;
  
  Map<String, dynamic>? _salesSummary;
  List<Map<String, dynamic>>? _paymentMethodData;
  List<Map<String, dynamic>>? _topProducts;
  List<Map<String, dynamic>>? _hourlySales;
  List<Map<String, dynamic>>? _dailyTrend;
  List<Map<String, dynamic>>? _cashierPerformance;
  Map<String, dynamic>? _customerAnalytics;
  Map<String, dynamic>? _refundAnalytics;

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  Future<void> _loadReports() async {
    setState(() => _isLoading = true);

    try {
      final authState = ref.read(authStateProvider);
      final organizationId = authState.organization?.id;
      
      if (organizationId == null) {
        throw Exception('No organization selected');
      }

      final analytics = ref.read(posAnalyticsProvider);

      // Load all reports in parallel
      final results = await Future.wait([
        analytics.getSalesSummary(
          organizationId: organizationId,
          startDate: _startDate,
          endDate: _endDate,
          registerId: _selectedRegisterId,
        ),
        analytics.getSalesByPaymentMethod(
          organizationId: organizationId,
          startDate: _startDate,
          endDate: _endDate,
        ),
        analytics.getTopSellingProducts(
          organizationId: organizationId,
          startDate: _startDate,
          endDate: _endDate,
        ),
        analytics.getHourlySalesDistribution(
          organizationId: organizationId,
          date: _endDate,
        ),
        analytics.getDailySalesTrend(
          organizationId: organizationId,
          startDate: _startDate,
          endDate: _endDate,
        ),
        analytics.getSalesByUser(
          organizationId: organizationId,
          startDate: _startDate,
          endDate: _endDate,
        ),
        analytics.getCustomerAnalytics(
          organizationId: organizationId,
          startDate: _startDate,
          endDate: _endDate,
        ),
        analytics.getRefundAnalytics(
          organizationId: organizationId,
          startDate: _startDate,
          endDate: _endDate,
        ),
      ]);

      setState(() {
        _salesSummary = results[0] as Map<String, dynamic>;
        _paymentMethodData = results[1] as List<Map<String, dynamic>>;
        _topProducts = results[2] as List<Map<String, dynamic>>;
        _hourlySales = results[3] as List<Map<String, dynamic>>;
        _dailyTrend = results[4] as List<Map<String, dynamic>>;
        _cashierPerformance = results[5] as List<Map<String, dynamic>>;
        _customerAnalytics = results[6] as Map<String, dynamic>;
        _refundAnalytics = results[7] as Map<String, dynamic>;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading reports: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _onDateRangeChanged(DateTime start, DateTime end) {
    setState(() {
      _startDate = start;
      _endDate = end;
    });
    _loadReports();
  }

  Future<void> _exportReport() async {
    try {
      final authState = ref.read(authStateProvider);
      final organization = authState.organization;
      
      if (organization == null || _salesSummary == null) {
        throw Exception('No data to export');
      }

      final exportService = ReportExportService();
      final pdfData = await exportService.exportSalesReportToPdf(
        organization: organization,
        startDate: _startDate,
        endDate: _endDate,
        salesSummary: _salesSummary!,
        paymentMethodData: _paymentMethodData,
        topProducts: _topProducts,
        cashierPerformance: _cashierPerformance,
        customerAnalytics: _customerAnalytics,
        refundAnalytics: _refundAnalytics,
      );

      await Printing.sharePdf(
        bytes: pdfData,
        filename: 'sales_report_${DateFormat('yyyy-MM-dd').format(_startDate)}_to_${DateFormat('yyyy-MM-dd').format(_endDate)}.pdf',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error exporting report: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POS Reports'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadReports,
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _isLoading ? null : _exportReport,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Range Selector
                  DateRangePicker(
                    startDate: _startDate,
                    endDate: _endDate,
                    onDateRangeChanged: _onDateRangeChanged,
                  ),
                  const SizedBox(height: 24),

                  // Sales Summary Cards
                  if (_salesSummary != null)
                    SalesSummaryCard(summary: _salesSummary!),
                  const SizedBox(height: 24),

                  // Refund Summary
                  if (_refundAnalytics != null && _refundAnalytics!['refund_count'] > 0)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Refunds',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '${_refundAnalytics!['refund_count']}',
                                      style: Theme.of(context).textTheme.headlineMedium,
                                    ),
                                    const Text('Refunds'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '\$${(_refundAnalytics!['refund_amount'] ?? 0).toStringAsFixed(2)}',
                                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                        color: Colors.red,
                                      ),
                                    ),
                                    const Text('Total Amount'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (_refundAnalytics != null && _refundAnalytics!['refund_count'] > 0)
                    const SizedBox(height: 24),

                  // Charts Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Payment Methods Chart
                      if (_paymentMethodData != null && _paymentMethodData!.isNotEmpty)
                        Expanded(
                          child: PaymentMethodChart(data: _paymentMethodData!),
                        ),
                      const SizedBox(width: 16),
                      // Customer Analytics
                      if (_customerAnalytics != null)
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Customer Analytics',
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    '${_customerAnalytics!['uniqueCustomers']}',
                                    style: Theme.of(context).textTheme.headlineLarge,
                                  ),
                                  const Text('Unique Customers'),
                                  const SizedBox(height: 16),
                                  if (_customerAnalytics!['topCustomers'].isNotEmpty) ...[
                                    const Text(
                                      'Top Customers',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    ...(_customerAnalytics!['topCustomers'] as List).take(5).map(
                                      (customer) => Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(customer['customer_id'] ?? 'Unknown'),
                                            Text(
                                              '\$${customer['total_spent'].toStringAsFixed(2)}',
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Hourly Sales Distribution
                  if (_hourlySales != null)
                    HourlySalesChart(data: _hourlySales!),
                  const SizedBox(height: 24),

                  // Daily Sales Trend
                  if (_dailyTrend != null && _dailyTrend!.isNotEmpty)
                    DailyTrendChart(data: _dailyTrend!),
                  const SizedBox(height: 24),

                  // Top Products Table
                  if (_topProducts != null && _topProducts!.isNotEmpty)
                    TopProductsTable(products: _topProducts!),
                  const SizedBox(height: 24),

                  // Cashier Performance
                  if (_cashierPerformance != null && _cashierPerformance!.isNotEmpty)
                    CashierPerformanceTable(data: _cashierPerformance!),
                ],
              ),
            ),
    );
  }
}