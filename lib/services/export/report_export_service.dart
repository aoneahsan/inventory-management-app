import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import '../../domain/entities/organization.dart';

class ReportExportService {
  Future<Uint8List> exportSalesReportToPdf({
    required Organization organization,
    required DateTime startDate,
    required DateTime endDate,
    required Map<String, dynamic> salesSummary,
    List<Map<String, dynamic>>? paymentMethodData,
    List<Map<String, dynamic>>? topProducts,
    List<Map<String, dynamic>>? cashierPerformance,
    Map<String, dynamic>? customerAnalytics,
    Map<String, dynamic>? refundAnalytics,
  }) async {
    final pdf = pw.Document();
    final dateFormat = DateFormat('MMM d, yyyy');

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => [
          // Header
          pw.Header(
            level: 0,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Sales Report',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  organization.name,
                  style: pw.TextStyle(
                    fontSize: 18,
                    color: PdfColors.grey700,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  '${dateFormat.format(startDate)} - ${dateFormat.format(endDate)}',
                  style: pw.TextStyle(
                    fontSize: 14,
                    color: PdfColors.grey600,
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 20),

          // Sales Summary
          _buildSummarySection(salesSummary),
          pw.SizedBox(height: 20),

          // Refunds
          if (refundAnalytics != null && refundAnalytics['refund_count'] > 0) ...[
            _buildRefundSection(refundAnalytics),
            pw.SizedBox(height: 20),
          ],

          // Payment Methods
          if (paymentMethodData != null && paymentMethodData.isNotEmpty) ...[
            _buildPaymentMethodsSection(paymentMethodData),
            pw.SizedBox(height: 20),
          ],

          // Customer Analytics
          if (customerAnalytics != null) ...[
            _buildCustomerAnalyticsSection(customerAnalytics),
            pw.SizedBox(height: 20),
          ],

          // Top Products
          if (topProducts != null && topProducts.isNotEmpty) ...[
            _buildTopProductsSection(topProducts),
            pw.SizedBox(height: 20),
          ],

          // Cashier Performance
          if (cashierPerformance != null && cashierPerformance.isNotEmpty) ...[
            _buildCashierPerformanceSection(cashierPerformance),
          ],

          // Footer
          pw.SizedBox(height: 40),
          pw.Divider(),
          pw.Text(
            'Generated on ${dateFormat.format(DateTime.now())} at ${DateFormat('HH:mm').format(DateTime.now())}',
            style: pw.TextStyle(
              fontSize: 10,
              color: PdfColors.grey600,
            ),
          ),
        ],
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildSummarySection(Map<String, dynamic> summary) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Sales Summary',
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 10),
        pw.GridView(
          crossAxisCount: 3,
          childAspectRatio: 2.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            _buildSummaryItem('Total Revenue', '\$${(summary['totalRevenue'] ?? 0).toStringAsFixed(2)}'),
            _buildSummaryItem('Transactions', '${summary['totalTransactions'] ?? 0}'),
            _buildSummaryItem('Average Sale', '\$${(summary['averageSale'] ?? 0).toStringAsFixed(2)}'),
            _buildSummaryItem('Total Tax', '\$${(summary['totalTax'] ?? 0).toStringAsFixed(2)}'),
            _buildSummaryItem('Total Discount', '\$${(summary['totalDiscount'] ?? 0).toStringAsFixed(2)}'),
            _buildSummaryItem('Max Sale', '\$${(summary['maxSale'] ?? 0).toStringAsFixed(2)}'),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildSummaryItem(String label, String value) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              fontSize: 10,
              color: PdfColors.grey700,
            ),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildRefundSection(Map<String, dynamic> refunds) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Refunds',
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          children: [
            _buildSummaryItem('Refund Count', '${refunds['refund_count'] ?? 0}'),
            pw.SizedBox(width: 20),
            _buildSummaryItem('Refund Amount', '\$${(refunds['refund_amount'] ?? 0).toStringAsFixed(2)}'),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildPaymentMethodsSection(List<Map<String, dynamic>> data) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Payment Methods',
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300),
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey200),
              children: [
                _buildTableHeader('Payment Method'),
                _buildTableHeader('Transactions'),
                _buildTableHeader('Total Amount'),
              ],
            ),
            ...data.map((item) => pw.TableRow(
              children: [
                _buildTableCell(item['payment_method'] ?? 'Unknown'),
                _buildTableCell('${item['transaction_count'] ?? 0}'),
                _buildTableCell('\$${(item['total_amount'] ?? 0).toStringAsFixed(2)}'),
              ],
            )),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildCustomerAnalyticsSection(Map<String, dynamic> analytics) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Customer Analytics',
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Text('Unique Customers: ${analytics['uniqueCustomers'] ?? 0}'),
        if ((analytics['topCustomers'] as List?)?.isNotEmpty ?? false) ...[
          pw.SizedBox(height: 10),
          pw.Text(
            'Top Customers',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 5),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300),
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.grey200),
                children: [
                  _buildTableHeader('Customer ID'),
                  _buildTableHeader('Transactions'),
                  _buildTableHeader('Total Spent'),
                ],
              ),
              ...(analytics['topCustomers'] as List).take(10).map((customer) => pw.TableRow(
                children: [
                  _buildTableCell(customer['customer_id'] ?? 'Unknown'),
                  _buildTableCell('${customer['transaction_count'] ?? 0}'),
                  _buildTableCell('\$${(customer['total_spent'] ?? 0).toStringAsFixed(2)}'),
                ],
              )),
            ],
          ),
        ],
      ],
    );
  }

  pw.Widget _buildTopProductsSection(List<Map<String, dynamic>> products) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Top Selling Products',
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300),
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey200),
              children: [
                _buildTableHeader('Product'),
                _buildTableHeader('Quantity'),
                _buildTableHeader('Revenue'),
                _buildTableHeader('Transactions'),
              ],
            ),
            ...products.take(10).map((product) => pw.TableRow(
              children: [
                _buildTableCell(product['product_name'] ?? 'Unknown'),
                _buildTableCell('${product['total_quantity'] ?? 0}'),
                _buildTableCell('\$${(product['total_revenue'] ?? 0).toStringAsFixed(2)}'),
                _buildTableCell('${product['transaction_count'] ?? 0}'),
              ],
            )),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildCashierPerformanceSection(List<Map<String, dynamic>> data) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Cashier Performance',
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300),
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey200),
              children: [
                _buildTableHeader('Cashier'),
                _buildTableHeader('Transactions'),
                _buildTableHeader('Total Sales'),
                _buildTableHeader('Average Sale'),
              ],
            ),
            ...data.map((cashier) => pw.TableRow(
              children: [
                _buildTableCell(cashier['user_name'] ?? 'Unknown'),
                _buildTableCell('${cashier['transaction_count'] ?? 0}'),
                _buildTableCell('\$${(cashier['total_amount'] ?? 0).toStringAsFixed(2)}'),
                _buildTableCell('\$${(cashier['average_sale'] ?? 0).toStringAsFixed(2)}'),
              ],
            )),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildTableHeader(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  pw.Widget _buildTableCell(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: const pw.TextStyle(fontSize: 11),
      ),
    );
  }
}