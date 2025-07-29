import '../../core/errors/exceptions.dart';
import '../database/database.dart';

class AnalyticsService {
  final AppDatabase _database;

  AnalyticsService({AppDatabase? database})
      : _database = database ?? AppDatabase.instance;

  Future<Map<String, dynamic>> getAnalyticsData(String organizationId) async {
    try {
      final products = await _database.getProducts(organizationId);
      final categories = await _database.getCategories(organizationId);
      final movements = await _database.getInventoryMovements(organizationId, limit: 100);

      // Calculate metrics
      final totalProducts = products.length;
      final totalCategories = categories.length;
      final lowStockCount = products.where((p) => (p['current_stock'] as double? ?? 0) <= (p['min_stock'] as double? ?? 0)).length;
      final outOfStock = products.where((p) => (p['current_stock'] as double? ?? 0) == 0).length;

      // Calculate inventory value
      double inventoryValue = 0;
      for (final product in products) {
        final stock = product['current_stock'] as double? ?? 0;
        final costPrice = product['cost_price'] as double? ?? 0;
        inventoryValue += stock * costPrice;
      }

      // Top products by movement frequency
      final productMovements = <String, int>{};
      for (final movement in movements) {
        final productId = movement['product_id'] as String;
        productMovements[productId] = (productMovements[productId] ?? 0) + 1;
      }

      final topProducts = <Map<String, dynamic>>[];
      for (final entry in productMovements.entries.take(5)) {
        final product = products.firstWhere(
          (p) => p['id'] == entry.key,
          orElse: () => {'name': 'Unknown', 'sku': 'N/A'},
        );
        topProducts.add({
          'name': product['name'],
          'sku': product['sku'],
          'movements': entry.value,
        });
      }

      return {
        'total_products': totalProducts,
        'total_categories': totalCategories,
        'low_stock_count': lowStockCount,
        'out_of_stock': outOfStock,
        'inventory_value': inventoryValue.toStringAsFixed(2),
        'total_revenue': '45,230.50', // Mock data
        'total_orders': '1,234', // Mock data
        'top_products': topProducts,
      };
    } catch (e) {
      throw BusinessException(message: 'Failed to get analytics data: $e');
    }
  }

  Future<Map<String, dynamic>> generateReport(
    String organizationId,
    String reportType, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      switch (reportType) {
        case 'inventory_valuation':
          return _generateInventoryValuationReport(organizationId);
        case 'stock_movement':
          return _generateStockMovementReport(organizationId, startDate, endDate);
        case 'low_stock':
          return _generateLowStockReport(organizationId);
        default:
          throw BusinessException(message: 'Unknown report type: $reportType');
      }
    } catch (e) {
      if (e is BusinessException) rethrow;
      throw BusinessException(message: 'Failed to generate report: $e');
    }
  }

  Future<Map<String, dynamic>> _generateInventoryValuationReport(String organizationId) async {
    final products = await _database.getProducts(organizationId);

    final reportData = <String, dynamic>{
      'report_type': 'Inventory Valuation Report',
      'generated_at': DateTime.now().toIso8601String(),
      'organization_id': organizationId,
      'summary': {},
      'details': [],
    };

    double totalValue = 0;
    final categoryValues = <String, double>{};

    for (final product in products) {
      final stock = product['current_stock'] as double? ?? 0;
      final costPrice = product['cost_price'] as double? ?? 0;
      final value = stock * costPrice;
      totalValue += value;

      final categoryId = product['category_id'] as String?;
      if (categoryId != null) {
        categoryValues[categoryId] = (categoryValues[categoryId] ?? 0) + value;
      }

      reportData['details'].add({
        'product_name': product['name'],
        'sku': product['sku'],
        'current_stock': stock,
        'cost_price': costPrice,
        'total_value': value,
      });
    }

    reportData['summary'] = {
      'total_products': products.length,
      'total_value': totalValue,
      'category_breakdown': categoryValues,
    };

    return reportData;
  }

  Future<Map<String, dynamic>> _generateStockMovementReport(
    String organizationId,
    DateTime? startDate,
    DateTime? endDate,
  ) async {
    final movements = await _database.getInventoryMovements(
      organizationId,
      limit: 1000,
    );

    final reportData = <String, dynamic>{
      'report_type': 'Stock Movement Report',
      'generated_at': DateTime.now().toIso8601String(),
      'organization_id': organizationId,
      'period': {
        'start_date': startDate?.toIso8601String(),
        'end_date': endDate?.toIso8601String(),
      },
      'summary': {},
      'movements': movements,
    };

    // Calculate summary
    int totalMovements = movements.length;
    double totalQuantityIn = 0;
    double totalQuantityOut = 0;

    for (final movement in movements) {
      final quantity = movement['quantity'] as double? ?? 0;
      final type = movement['type'] as String?;

      if (type == 'purchase' || type == 'adjustment' && quantity > 0) {
        totalQuantityIn += quantity;
      } else {
        totalQuantityOut += quantity.abs();
      }
    }

    reportData['summary'] = {
      'total_movements': totalMovements,
      'total_quantity_in': totalQuantityIn,
      'total_quantity_out': totalQuantityOut,
      'net_change': totalQuantityIn - totalQuantityOut,
    };

    return reportData;
  }

  Future<Map<String, dynamic>> _generateLowStockReport(String organizationId) async {
    final products = await _database.getProducts(organizationId);

    final lowStockProducts = products.where((product) {
      final currentStock = product['current_stock'] as double? ?? 0;
      final minStock = product['min_stock'] as double? ?? 0;
      return currentStock <= minStock;
    }).toList();

    final reportData = <String, dynamic>{
      'report_type': 'Low Stock Report',
      'generated_at': DateTime.now().toIso8601String(),
      'organization_id': organizationId,
      'summary': {
        'total_products': products.length,
        'low_stock_products': lowStockProducts.length,
        'percentage': products.isNotEmpty ? (lowStockProducts.length / products.length * 100) : 0,
      },
      'products': lowStockProducts.map((product) => {
        'name': product['name'],
        'sku': product['sku'],
        'current_stock': product['current_stock'],
        'min_stock': product['min_stock'],
        'difference': (product['current_stock'] as double? ?? 0) - (product['min_stock'] as double? ?? 0),
      }).toList(),
    };

    return reportData;
  }

  Future<String> exportReport(Map<String, dynamic> reportData, String format) async {
    try {
      switch (format.toLowerCase()) {
        case 'csv':
          return _exportToCsv(reportData);
        case 'json':
          return _exportToJson(reportData);
        case 'pdf':
          return _exportToPdf(reportData);
        default:
          throw BusinessException(message: 'Unsupported export format: $format');
      }
    } catch (e) {
      if (e is BusinessException) rethrow;
      throw BusinessException(message: 'Failed to export report: $e');
    }
  }

  String _exportToCsv(Map<String, dynamic> reportData) {
    // Simple CSV export implementation
    final buffer = StringBuffer();
    buffer.writeln('${reportData['report_type']} - Generated: ${reportData['generated_at']}');
    buffer.writeln();

    if (reportData['details'] != null) {
      final details = reportData['details'] as List;
      if (details.isNotEmpty) {
        // Header
        final headers = (details.first as Map<String, dynamic>).keys.join(',');
        buffer.writeln(headers);

        // Data rows
        for (final row in details) {
          final values = (row as Map<String, dynamic>).values.join(',');
          buffer.writeln(values);
        }
      }
    }

    return buffer.toString();
  }

  String _exportToJson(Map<String, dynamic> reportData) {
    // Return JSON string representation
    return reportData.toString();
  }

  String _exportToPdf(Map<String, dynamic> reportData) {
    // PDF export would require a PDF library like pdf package
    return 'PDF export not implemented - requires pdf package';
  }
}