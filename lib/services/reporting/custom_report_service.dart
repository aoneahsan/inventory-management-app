import '../../domain/entities/custom_report.dart';
import '../database/database.dart';

class CustomReportService {
  final _database = AppDatabase.instance;

  Future<List<Map<String, dynamic>>> executeReport(CustomReport report) async {
    switch (report.entityType) {
      case 'products':
        return _executeProductReport(report);
      case 'customers':
        return _executeCustomerReport(report);
      case 'orders':
        return _executeOrderReport(report);
      case 'inventory':
        return _executeInventoryReport(report);
      default:
        throw Exception('Unsupported entity type: ${report.entityType}');
    }
  }

  Future<List<Map<String, dynamic>>> _executeProductReport(CustomReport report) async {
    final products = await _database.getProducts(report.organizationId);
    var data = products;

    // Apply filters
    for (final filter in report.filters) {
      data = data.where((item) => _applyFilter(item, filter)).toList();
    }

    // Select fields
    data = data.map((item) {
      final filtered = <String, dynamic>{};
      for (final field in report.selectedFields) {
        filtered[field] = item[field];
      }
      return filtered;
    }).toList();

    // Sort
    if (report.sortBy != null) {
      data.sort((a, b) {
        final aValue = a[report.sortBy];
        final bValue = b[report.sortBy];
        final result = _compareValues(aValue, bValue);
        return report.sortAscending ? result : -result;
      });
    }

    return data;
  }

  Future<List<Map<String, dynamic>>> _executeCustomerReport(CustomReport report) async {
    // TODO: Add customers table to database
    var data = <Map<String, dynamic>>[];

    // Apply filters
    for (final filter in report.filters) {
      data = data.where((item) => _applyFilter(item, filter)).toList();
    }

    // Select fields
    data = data.map((item) {
      final filtered = <String, dynamic>{};
      for (final field in report.selectedFields) {
        filtered[field] = item[field];
      }
      return filtered;
    }).toList();

    return data;
  }

  Future<List<Map<String, dynamic>>> _executeOrderReport(CustomReport report) async {
    // Placeholder for order reports
    return [];
  }

  Future<List<Map<String, dynamic>>> _executeInventoryReport(CustomReport report) async {
    final movements = await _database.getInventoryMovements(report.organizationId);
    return movements;
  }

  bool _applyFilter(Map<String, dynamic> item, ReportFilter filter) {
    final value = item[filter.field];
    
    switch (filter.operator) {
      case '=':
        return value == filter.value;
      case '!=':
        return value != filter.value;
      case '>':
        return _compareValues(value, filter.value) > 0;
      case '>=':
        return _compareValues(value, filter.value) >= 0;
      case '<':
        return _compareValues(value, filter.value) < 0;
      case '<=':
        return _compareValues(value, filter.value) <= 0;
      case 'contains':
        return value.toString().contains(filter.value.toString());
      case 'starts_with':
        return value.toString().startsWith(filter.value.toString());
      case 'ends_with':
        return value.toString().endsWith(filter.value.toString());
      default:
        return true;
    }
  }

  int _compareValues(dynamic a, dynamic b) {
    if (a is num && b is num) {
      return a.compareTo(b);
    }
    return a.toString().compareTo(b.toString());
  }

  // Available fields for each entity type
  static List<String> getAvailableFields(String entityType) {
    switch (entityType) {
      case 'products':
        return ['id', 'name', 'sku', 'description', 'unitPrice', 'currentStock', 
                'minStockLevel', 'categoryId', 'isActive'];
      case 'customers':
        return ['id', 'name', 'email', 'phone', 'address', 'isActive'];
      case 'orders':
        return ['id', 'orderNumber', 'customerId', 'total', 'status', 'createdAt'];
      case 'inventory':
        return ['id', 'productId', 'movementType', 'quantity', 'reason', 'timestamp'];
      default:
        return [];
    }
  }

  // Available operators
  static List<String> getAvailableOperators() {
    return ['=', '!=', '>', '>=', '<', '<=', 'contains', 'starts_with', 'ends_with'];
  }
}