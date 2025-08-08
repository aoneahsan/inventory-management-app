import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:barcode/barcode.dart';
import 'package:printing/printing.dart';
import '../../domain/entities/product.dart';

class BarcodeService {
  // Generate barcode for a single product
  Future<Uint8List> generateBarcode({
    required Product product,
    BarcodeType type = BarcodeType.code128,
    double width = 200,
    double height = 80,
    bool showText = true,
  }) async {
    final pdf = pw.Document();
    final barcode = Barcode.fromType(type);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.BarcodeWidget(
                  barcode: barcode,
                  data: product.barcode ?? product.sku,
                  width: width,
                  height: height,
                  drawText: showText,
                ),
                if (showText) ...[
                  pw.SizedBox(height: 10),
                  pw.Text(
                    product.name,
                    style: const pw.TextStyle(fontSize: 14),
                  ),
                  pw.Text(
                    'SKU: ${product.sku}',
                    style: const pw.TextStyle(fontSize: 12),
                  ),
                  if (product.sellingPrice != null)
                    pw.Text(
                      '\$${product.sellingPrice!.toStringAsFixed(2)}',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                ],
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  // Generate barcode labels sheet
  Future<Uint8List> generateBarcodeSheet({
    required List<Product> products,
    int columns = 3,
    int rows = 7,
    double labelWidth = 63.5, // mm
    double labelHeight = 38.1, // mm
    double marginTop = 10, // mm
    double marginBottom = 10, // mm
    double marginLeft = 10, // mm
    double marginRight = 10, // mm
    double horizontalGap = 2.5, // mm
    double verticalGap = 0, // mm
  }) async {
    final pdf = pw.Document();
    final barcode = Barcode.fromType(BarcodeType.code128);

    // Convert mm to points (1mm = 2.83465 points)
    final mmToPt = 2.83465;
    final labelWidthPt = labelWidth * mmToPt;
    final labelHeightPt = labelHeight * mmToPt;
    final marginTopPt = marginTop * mmToPt;
    final marginBottomPt = marginBottom * mmToPt;
    final marginLeftPt = marginLeft * mmToPt;
    final marginRightPt = marginRight * mmToPt;
    final horizontalGapPt = horizontalGap * mmToPt;
    final verticalGapPt = verticalGap * mmToPt;

    // Calculate products per page
    final productsPerPage = columns * rows;
    final totalPages = (products.length / productsPerPage).ceil();

    for (int pageIndex = 0; pageIndex < totalPages; pageIndex++) {
      final startIndex = pageIndex * productsPerPage;
      final endIndex = (startIndex + productsPerPage).clamp(0, products.length);
      final pageProducts = products.sublist(startIndex, endIndex);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.only(
            top: marginTopPt,
            bottom: marginBottomPt,
            left: marginLeftPt,
            right: marginRightPt,
          ),
          build: (context) {
            final labels = <pw.Widget>[];

            for (int i = 0; i < pageProducts.length; i++) {
              final product = pageProducts[i];
              final row = i ~/ columns;
              final col = i % columns;

              labels.add(
                pw.Positioned(
                  left: col * (labelWidthPt + horizontalGapPt),
                  top: row * (labelHeightPt + verticalGapPt),
                  child: pw.Container(
                    width: labelWidthPt,
                    height: labelHeightPt,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(
                        color: PdfColors.grey300,
                        width: 0.5,
                      ),
                    ),
                    padding: const pw.EdgeInsets.all(5),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.BarcodeWidget(
                          barcode: barcode,
                          data: product.barcode ?? product.sku,
                          width: labelWidthPt - 20,
                          height: labelHeightPt * 0.4,
                          drawText: false,
                        ),
                        pw.SizedBox(height: 2),
                        pw.Text(
                          product.name,
                          style: const pw.TextStyle(fontSize: 8),
                          maxLines: 1,
                          overflow: pw.TextOverflow.clip,
                        ),
                        pw.Text(
                          product.sku,
                          style: const pw.TextStyle(fontSize: 7),
                        ),
                        if (product.sellingPrice != null)
                          pw.Text(
                            '\$${product.sellingPrice!.toStringAsFixed(2)}',
                            style: pw.TextStyle(
                              fontSize: 10,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return pw.Stack(children: labels);
          },
        ),
      );
    }

    return pdf.save();
  }

  // Generate price tags
  Future<Uint8List> generatePriceTags({
    required List<Product> products,
    double tagWidth = 50, // mm
    double tagHeight = 30, // mm
    bool includeBarcode = true,
  }) async {
    final pdf = pw.Document();
    final barcode = Barcode.fromType(BarcodeType.code128);
    final mmToPt = 2.83465;
    final tagWidthPt = tagWidth * mmToPt;
    final tagHeightPt = tagHeight * mmToPt;

    // Calculate tags per page
    final pageWidth = PdfPageFormat.a4.width - 40; // margins
    final pageHeight = PdfPageFormat.a4.height - 40; // margins
    final columns = (pageWidth / tagWidthPt).floor();
    final rows = (pageHeight / tagHeightPt).floor();
    final tagsPerPage = columns * rows;

    final totalPages = (products.length / tagsPerPage).ceil();

    for (int pageIndex = 0; pageIndex < totalPages; pageIndex++) {
      final startIndex = pageIndex * tagsPerPage;
      final endIndex = (startIndex + tagsPerPage).clamp(0, products.length);
      final pageProducts = products.sublist(startIndex, endIndex);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(20),
          build: (context) {
            return pw.GridView(
              crossAxisCount: columns,
              childAspectRatio: tagWidthPt / tagHeightPt,
              children: pageProducts.map((product) {
                return pw.Container(
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      color: PdfColors.grey400,
                      width: 1,
                    ),
                  ),
                  padding: const pw.EdgeInsets.all(4),
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        product.name,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: pw.TextOverflow.clip,
                        textAlign: pw.TextAlign.center,
                      ),
                      if (includeBarcode && (product.barcode != null || product.sku.isNotEmpty))
                        pw.Padding(
                          padding: const pw.EdgeInsets.symmetric(vertical: 2),
                          child: pw.BarcodeWidget(
                            barcode: barcode,
                            data: product.barcode ?? product.sku,
                            width: tagWidthPt - 10,
                            height: tagHeightPt * 0.3,
                            drawText: false,
                          ),
                        ),
                      pw.Text(
                        'SKU: ${product.sku}',
                        style: const pw.TextStyle(fontSize: 8),
                      ),
                      if (product.sellingPrice != null)
                        pw.Text(
                          '\$${product.sellingPrice!.toStringAsFixed(2)}',
                          style: pw.TextStyle(
                            fontSize: 14,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.green800,
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      );
    }

    return pdf.save();
  }

  // Print barcode
  Future<bool> printBarcode(Uint8List pdfData, {String jobName = 'Barcode Print'}) async {
    try {
      await Printing.layoutPdf(
        onLayout: (format) async => pdfData,
        name: jobName,
      );
      return true;
    } catch (e) {
      print('Error printing barcode: $e');
      return false;
    }
  }

  // Share barcode as PDF
  Future<void> shareBarcode(Uint8List pdfData, {String filename = 'barcode.pdf'}) async {
    await Printing.sharePdf(
      bytes: pdfData,
      filename: filename,
    );
  }
}