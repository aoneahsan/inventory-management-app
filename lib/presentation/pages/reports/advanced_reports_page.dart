import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import '../../../services/reporting/excel_report_service.dart';
import '../../../services/inventory/product_service.dart';
import '../../../services/pos/pos_service.dart';
import '../../../services/database/database.dart';
import '../../providers/organization_provider.dart';

final excelReportServiceProvider = Provider<ExcelReportService>((ref) {
  final database = AppDatabase.instance;
  final productService = ProductService(database: database);
  final posService = POSService(
    database: database,
    productService: productService,
    syncService: ref.read(syncServiceProvider),
  );
  
  return ExcelReportService(
    productService: productService,
    posService: posService,
  );
});

class AdvancedReportsPage extends ConsumerStatefulWidget {
  const AdvancedReportsPage({super.key});

  @override
  ConsumerState<AdvancedReportsPage> createState() => _AdvancedReportsPageState();
}

class _AdvancedReportsPageState extends ConsumerState<AdvancedReportsPage> {
  bool _isGenerating = false;
  String? _lastMessage;
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _generateReport(String reportType) async {
    final organization = ref.read(currentOrganizationProvider);
    if (organization == null) {
      setState(() {
        _lastMessage = 'No organization selected';
      });
      return;
    }

    setState(() {
      _isGenerating = true;
      _lastMessage = null;
    });

    try {
      final reportService = ref.read(excelReportServiceProvider);
      late final Uint8List bytes;
      late final String fileName;

      switch (reportType) {
        case 'inventory':
          bytes = await reportService.generateInventoryReport(
            organizationId: organization.id,
            includeMovements: true,
          );
          fileName = 'inventory_report_${DateTime.now().millisecondsSinceEpoch}.xlsx';
          break;
        case 'sales':
          bytes = await reportService.generateSalesReport(
            organizationId: organization.id,
            startDate: _startDate,
            endDate: _endDate,
          );
          fileName = 'sales_report_${DateTime.now().millisecondsSinceEpoch}.xlsx';
          break;
        case 'lowStock':
          bytes = await reportService.generateLowStockReport(
            organizationId: organization.id,
          );
          fileName = 'low_stock_report_${DateTime.now().millisecondsSinceEpoch}.xlsx';
          break;
        default:
          throw Exception('Unknown report type');
      }

      // Save to temporary directory
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/$fileName');
      await file.writeAsBytes(bytes);

      // Share the file
      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'Inventory Management Report',
        text: 'Please find attached the $reportType report.',
      );

      setState(() {
        _lastMessage = 'Report generated successfully!';
      });
    } catch (e) {
      setState(() {
        _lastMessage = 'Error generating report: $e';
      });
    } finally {
      setState(() {
        _isGenerating = false;
      });
    }
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Reports'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Excel Report Generation',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Generate comprehensive reports in Excel format with detailed analytics and insights.',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Report Types
            _buildReportCard(
              title: 'Inventory Report',
              description: 'Complete inventory overview with stock levels, values, and movement history',
              icon: Icons.inventory_2,
              color: Colors.blue,
              onGenerate: () => _generateReport('inventory'),
            ),
            _buildReportCard(
              title: 'Sales Report',
              description: 'Detailed sales analysis with revenue, tax, and payment method breakdown',
              icon: Icons.point_of_sale,
              color: Colors.green,
              onGenerate: () => _generateReport('sales'),
              showDateRange: true,
            ),
            _buildReportCard(
              title: 'Low Stock Report',
              description: 'Products below minimum stock levels with reorder recommendations',
              icon: Icons.warning,
              color: Colors.orange,
              onGenerate: () => _generateReport('lowStock'),
            ),

            // Date Range Selector for Sales
            if (_startDate != null && _endDate != null) ...[
              const SizedBox(height: 16),
              Card(
                color: Colors.blue.shade50,
                child: ListTile(
                  leading: const Icon(Icons.date_range, color: Colors.blue),
                  title: const Text('Selected Date Range'),
                  subtitle: Text(
                    '${_startDate!.toLocal().toString().split(' ')[0]} - ${_endDate!.toLocal().toString().split(' ')[0]}'
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      setState(() {
                        _startDate = null;
                        _endDate = null;
                      });
                    },
                    child: const Text('Clear'),
                  ),
                ),
              ),
            ],

            // Status Messages
            if (_lastMessage != null) ...[
              const SizedBox(height: 16),
              Card(
                color: _lastMessage!.startsWith('Error') 
                    ? Colors.red.shade50 
                    : Colors.green.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        _lastMessage!.startsWith('Error') 
                            ? Icons.error_outline 
                            : Icons.check_circle,
                        color: _lastMessage!.startsWith('Error') 
                            ? Colors.red 
                            : Colors.green,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _lastMessage!,
                          style: TextStyle(
                            color: _lastMessage!.startsWith('Error') 
                                ? Colors.red.shade700 
                                : Colors.green.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            // Loading Indicator
            if (_isGenerating) ...[
              const SizedBox(height: 24),
              const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 8),
              const Center(
                child: Text('Generating report...'),
              ),
            ],

            // Instructions
            const SizedBox(height: 24),
            Card(
              color: Colors.grey.shade100,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.grey.shade700),
                        const SizedBox(width: 8),
                        const Text(
                          'Report Features',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Excel format with multiple sheets\n'
                      '• Conditional formatting for easy analysis\n'
                      '• Automatic calculations and summaries\n'
                      '• Share directly via email or messaging apps\n'
                      '• Compatible with Excel, Google Sheets, etc.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onGenerate,
    bool showDateRange = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: _isGenerating ? null : onGenerate,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    if (showDateRange) ...[
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: _selectDateRange,
                        icon: const Icon(Icons.date_range, size: 20),
                        label: Text(
                          _startDate != null && _endDate != null
                              ? 'Change Date Range'
                              : 'Select Date Range',
                        ),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}