import 'dart:typed_data';
import 'package:excel/excel.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/inventory_movement.dart';
import '../../domain/entities/sale.dart';
import '../inventory/product_service.dart';
import '../pos/pos_service.dart';

class ExcelReportService {
  final ProductService _productService;
  final POSService _posService;

  ExcelReportService({
    required ProductService productService,
    required POSService posService,
  })  : _productService = productService,
        _posService = posService;

  // Generate Inventory Report
  Future<Uint8List> generateInventoryReport({
    required String organizationId,
    String? categoryId,
    bool includeMovements = false,
  }) async {
    final excel = Excel.createExcel();
    final sheet = excel['Inventory Report'];

    // Headers
    final headers = [
      'SKU',
      'Product Name',
      'Category',
      'Current Stock',
      'Min Stock',
      'Max Stock',
      'Unit',
      'Cost Price',
      'Selling Price',
      'Stock Value',
      'Status',
    ];

    // Add headers
    for (int i = 0; i < headers.length; i++) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0)).value = TextCellValue(headers[i]);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0)).cellStyle = CellStyle(
        bold: true,
        backgroundColorHex: ExcelColor.gray300,
      );
    }

    // Get products
    final products = await _productService.getProducts(
      organizationId,
      categoryId: categoryId,
    );

    // Add product data
    for (int i = 0; i < products.length; i++) {
      final product = products[i];
      final row = i + 1;

      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row)).value = TextCellValue(product.sku);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row)).value = TextCellValue(product.name);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row)).value = TextCellValue(product.categoryId ?? 'Uncategorized');
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row)).value = DoubleCellValue(product.currentStock);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row)).value = DoubleCellValue(product.minStock);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row)).value = DoubleCellValue(product.maxStock ?? 0);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: row)).value = TextCellValue(product.unit);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: row)).value = DoubleCellValue(product.costPrice ?? 0);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: row)).value = DoubleCellValue(product.sellingPrice ?? 0);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: row)).value = DoubleCellValue(product.stockValue);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: row)).value = TextCellValue(
        product.isOutOfStock ? 'Out of Stock' : product.isLowStock ? 'Low Stock' : 'In Stock'
      );

      // Apply conditional formatting
      if (product.isOutOfStock) {
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: row)).cellStyle = CellStyle(
          fontColorHex: ExcelColor.red,
        );
      } else if (product.isLowStock) {
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: row)).cellStyle = CellStyle(
          fontColorHex: ExcelColor.orange,
        );
      }
    }

    // Add movements sheet if requested
    if (includeMovements) {
      final movementSheet = excel['Stock Movements'];
      
      // Movement headers
      final movementHeaders = [
        'Date',
        'Product',
        'Type',
        'Quantity',
        'Unit Cost',
        'Total Cost',
        'Reason',
        'Performed By',
      ];

      for (int i = 0; i < movementHeaders.length; i++) {
        movementSheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0)).value = TextCellValue(movementHeaders[i]);
        movementSheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0)).cellStyle = CellStyle(
          bold: true,
          backgroundColorHex: ExcelColor.gray300,
        );
      }

      // Get movements
      final movements = await _productService.getInventoryMovements(organizationId, limit: 1000);
      
      for (int i = 0; i < movements.length; i++) {
        final movement = movements[i];
        final row = i + 1;

        movementSheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row)).value = TextCellValue(
          movement.createdAt.toLocal().toString().split('.')[0]
        );
        movementSheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row)).value = TextCellValue(movement.productId);
        movementSheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row)).value = TextCellValue(movement.type.name);
        movementSheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row)).value = DoubleCellValue(movement.quantity);
        movementSheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row)).value = DoubleCellValue(movement.unitCost ?? 0);
        movementSheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row)).value = DoubleCellValue(movement.totalCost);
        movementSheet.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: row)).value = TextCellValue(movement.reason ?? '');
        movementSheet.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: row)).value = TextCellValue(movement.performedBy);
      }
    }

    // Remove default sheet
    excel.delete('Sheet1');

    // Generate Excel file
    final bytes = excel.save();
    return Uint8List.fromList(bytes!);
  }

  // Generate Sales Report
  Future<Uint8List> generateSalesReport({
    required String organizationId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final excel = Excel.createExcel();
    final sheet = excel['Sales Report'];

    // Headers
    final headers = [
      'Date',
      'Receipt #',
      'Customer',
      'Items',
      'Subtotal',
      'Tax',
      'Discount',
      'Total',
      'Payment Method',
      'Status',
    ];

    // Add headers
    for (int i = 0; i < headers.length; i++) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0)).value = TextCellValue(headers[i]);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0)).cellStyle = CellStyle(
        bold: true,
        backgroundColorHex: ExcelColor.gray300,
      );
    }

    // Get sales
    final sales = await _posService.getSales(
      organizationId,
      startDate: startDate,
      endDate: endDate,
    );

    // Add sales data
    double totalRevenue = 0;
    for (int i = 0; i < sales.length; i++) {
      final sale = sales[i];
      final row = i + 1;

      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row)).value = TextCellValue(
        sale.createdAt.toLocal().toString().split('.')[0]
      );
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row)).value = TextCellValue(sale.receiptNumber);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row)).value = TextCellValue(sale.customerId ?? 'Walk-in');
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row)).value = IntCellValue(sale.items.length);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row)).value = DoubleCellValue(sale.subtotal);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row)).value = DoubleCellValue(sale.taxAmount);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: row)).value = DoubleCellValue(sale.discountAmount);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: row)).value = DoubleCellValue(sale.totalAmount);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: row)).value = TextCellValue(sale.paymentMethod);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: row)).value = TextCellValue(sale.status);

      totalRevenue += sale.totalAmount;
    }

    // Add summary row
    final summaryRow = sales.length + 2;
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: summaryRow)).value = TextCellValue('Total Revenue:');
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: summaryRow)).cellStyle = CellStyle(bold: true);
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: summaryRow)).value = DoubleCellValue(totalRevenue);
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: summaryRow)).cellStyle = CellStyle(
      bold: true,
      fontColorHex: ExcelColor.green,
    );

    // Remove default sheet
    excel.delete('Sheet1');

    // Generate Excel file
    final bytes = excel.save();
    return Uint8List.fromList(bytes!);
  }

  // Generate Low Stock Report
  Future<Uint8List> generateLowStockReport({
    required String organizationId,
  }) async {
    final excel = Excel.createExcel();
    final sheet = excel['Low Stock Report'];

    // Headers
    final headers = [
      'SKU',
      'Product Name',
      'Current Stock',
      'Min Stock',
      'Reorder Point',
      'Reorder Quantity',
      'Supplier',
      'Last Purchase Date',
      'Action Required',
    ];

    // Add headers
    for (int i = 0; i < headers.length; i++) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0)).value = TextCellValue(headers[i]);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0)).cellStyle = CellStyle(
        bold: true,
        backgroundColorHex: ExcelColor.gray300,
      );
    }

    // Get low stock products
    final products = await _productService.getProducts(
      organizationId,
      lowStockOnly: true,
    );

    // Add product data
    for (int i = 0; i < products.length; i++) {
      final product = products[i];
      final row = i + 1;

      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row)).value = TextCellValue(product.sku);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row)).value = TextCellValue(product.name);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row)).value = DoubleCellValue(product.currentStock);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row)).value = DoubleCellValue(product.minStock);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row)).value = DoubleCellValue(product.reorderPoint ?? product.minStock);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row)).value = DoubleCellValue(product.reorderQuantity ?? 0);
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: row)).value = TextCellValue(product.supplierId ?? 'N/A');
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: row)).value = TextCellValue('N/A'); // Would need to fetch from movements
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: row)).value = TextCellValue(
        product.isOutOfStock ? 'URGENT - Out of Stock' : 'Reorder Soon'
      );

      // Apply formatting
      if (product.isOutOfStock) {
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: row)).cellStyle = CellStyle(
          fontColorHex: ExcelColor.red,
          bold: true,
        );
      }
    }

    // Remove default sheet
    excel.delete('Sheet1');

    // Generate Excel file
    final bytes = excel.save();
    return Uint8List.fromList(bytes!);
  }
}