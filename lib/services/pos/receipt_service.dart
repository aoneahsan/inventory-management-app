import 'dart:convert';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../domain/entities/sale.dart';
import '../../domain/entities/receipt.dart';
import '../../domain/entities/organization.dart';
import '../database/database.dart';
import '../sync/sync_service.dart';

class ReceiptService {
  final AppDatabase _database;
  final SyncService _syncService;

  ReceiptService({
    required AppDatabase database,
    required SyncService syncService,
  })  : _database = database,
        _syncService = syncService;

  // Generate receipt
  Future<Receipt> generateReceipt({
    required Sale sale,
    required String template,
    required String format,
    Map<String, dynamic>? customFields,
  }) async {
    final db = await _database.database;
    final now = DateTime.now();
    
    final receipt = Receipt(
      id: now.millisecondsSinceEpoch.toString(),
      saleId: sale.id,
      receiptNumber: sale.receiptNumber,
      template: template,
      customFields: customFields,
      format: format,
      createdAt: now,
    );

    await db.insert('receipts', {
      'id': receipt.id,
      'sale_id': receipt.saleId,
      'receipt_number': receipt.receiptNumber,
      'template': receipt.template,
      'custom_fields': receipt.customFields != null 
          ? jsonEncode(receipt.customFields) 
          : null,
      'format': receipt.format,
      'is_printed': 0,
      'created_at': receipt.createdAt.millisecondsSinceEpoch,
    });

    await _syncService.queueForSync('receipts', 'create', receipt.id, receipt.toJson());

    return receipt;
  }

  // Generate PDF receipt
  Future<Uint8List> generatePdfReceipt({
    required Sale sale,
    required Organization organization,
    required Receipt receipt,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: receipt.format == ReceiptFormat.thermal 
            ? PdfPageFormat.roll80 
            : PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text(
                      organization.name,
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    if (organization.settings?['address'] != null)
                      pw.Text(organization.settings!['address']),
                    if (organization.settings?['phone'] != null)
                      pw.Text('Tel: ${organization.settings!['phone']}'),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      'Receipt #${receipt.receiptNumber}',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text(
                      _formatDateTime(sale.createdAt),
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
              pw.Divider(),
              
              // Items
              pw.Container(
                child: pw.Column(
                  children: sale.items.map((item) {
                    return pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(item.productName),
                              pw.Text(
                                '${item.quantity} x \$${item.unitPrice.toStringAsFixed(2)}',
                                style: const pw.TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        pw.Text('\$${item.totalAmount.toStringAsFixed(2)}'),
                      ],
                    );
                  }).toList(),
                ),
              ),
              pw.Divider(),
              
              // Totals
              _buildTotalRow('Subtotal', sale.subtotal),
              if (sale.discountAmount > 0)
                _buildTotalRow('Discount', -sale.discountAmount),
              if (sale.taxAmount > 0)
                _buildTotalRow('Tax', sale.taxAmount),
              pw.Divider(),
              _buildTotalRow(
                'Total',
                sale.totalAmount,
                bold: true,
              ),
              pw.SizedBox(height: 10),
              
              // Payment info
              pw.Text('Payment Method: ${_formatPaymentMethod(sale.paymentMethod)}'),
              
              // Footer
              pw.SizedBox(height: 20),
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text(
                      'Thank you for your purchase!',
                      style: const pw.TextStyle(fontSize: 12),
                    ),
                    if (receipt.customFields?['returnPolicy'] != null)
                      pw.Text(
                        receipt.customFields!['returnPolicy'],
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  // Mark receipt as printed
  Future<void> markAsPrinted({
    required String receiptId,
    required String printerName,
  }) async {
    final db = await _database.database;
    final now = DateTime.now();

    await db.update(
      'receipts',
      {
        'is_printed': 1,
        'printed_at': now.millisecondsSinceEpoch,
        'printer_name': printerName,
      },
      where: 'id = ?',
      whereArgs: [receiptId],
    );

    await _syncService.queueForSync('receipts', 'update', receiptId, {
      'is_printed': true,
      'printed_at': now.toIso8601String(),
      'printer_name': printerName,
    });
  }

  // Send digital receipt
  Future<void> sendDigitalReceipt({
    required String receiptId,
    required String type,
    required String recipient,
  }) async {
    final db = await _database.database;

    await db.update(
      'receipts',
      {
        'digital_receipt': jsonEncode({
          'type': type,
          'recipient': recipient,
          'sent_at': DateTime.now().toIso8601String(),
        }),
      },
      where: 'id = ?',
      whereArgs: [receiptId],
    );
  }

  // Get receipt
  Future<Receipt?> getReceipt(String id) async {
    final db = await _database.database;
    final results = await db.query('receipts', where: 'id = ?', whereArgs: [id]);
    
    if (results.isEmpty) return null;

    final row = results.first;
    return Receipt(
      id: row['id'] as String,
      saleId: row['sale_id'] as String,
      receiptNumber: row['receipt_number'] as String,
      template: row['template'] as String,
      customFields: row['custom_fields'] != null
          ? Map<String, dynamic>.from(jsonDecode(row['custom_fields'] as String))
          : null,
      format: row['format'] as String,
      isPrinted: row['is_printed'] == 1,
      printedAt: row['printed_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(row['printed_at'] as int)
          : null,
      printerName: row['printer_name'] as String?,
      digitalReceipt: row['digital_receipt'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(row['created_at'] as int),
    );
  }

  pw.Widget _buildTotalRow(String label, double amount, {bool bold = false}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
        pw.Text(
          '\$${amount.toStringAsFixed(2)}',
          style: pw.TextStyle(
            fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} '
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _formatPaymentMethod(String method) {
    switch (method) {
      case 'cash':
        return 'Cash';
      case 'card':
        return 'Card';
      case 'upi':
        return 'UPI';
      case 'wallet':
        return 'Digital Wallet';
      case 'credit':
        return 'Store Credit';
      case 'split':
        return 'Split Payment';
      default:
        return method;
    }
  }
}