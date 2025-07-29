import 'package:sqflite/sqflite.dart';
import '../database/database.dart';
import '../../domain/entities/sale.dart';

class POSAnalyticsService {
  final AppDatabase database;

  POSAnalyticsService({required this.database});

  // Sales summary by period
  Future<Map<String, dynamic>> getSalesSummary({
    required String organizationId,
    required DateTime startDate,
    required DateTime endDate,
    String? registerId,
  }) async {
    final db = await database.database;
    
    String query = '''
      SELECT 
        COUNT(*) as total_transactions,
        SUM(total_amount) as total_revenue,
        SUM(tax_amount) as total_tax,
        SUM(discount_amount) as total_discount,
        AVG(total_amount) as average_sale,
        MIN(total_amount) as min_sale,
        MAX(total_amount) as max_sale
      FROM sales 
      WHERE organization_id = ? 
        AND created_at >= ? 
        AND created_at <= ?
        AND status = ?
    ''';
    
    List<dynamic> args = [
      organizationId,
      startDate.millisecondsSinceEpoch,
      endDate.millisecondsSinceEpoch,
      'completed',
    ];
    
    if (registerId != null) {
      query += ' AND register_id = ?';
      args.add(registerId);
    }
    
    final results = await db.rawQuery(query, args);
    final summary = results.first;
    
    return {
      'totalTransactions': summary['total_transactions'] ?? 0,
      'totalRevenue': summary['total_revenue'] ?? 0.0,
      'totalTax': summary['total_tax'] ?? 0.0,
      'totalDiscount': summary['total_discount'] ?? 0.0,
      'averageSale': summary['average_sale'] ?? 0.0,
      'minSale': summary['min_sale'] ?? 0.0,
      'maxSale': summary['max_sale'] ?? 0.0,
    };
  }

  // Sales by payment method
  Future<List<Map<String, dynamic>>> getSalesByPaymentMethod({
    required String organizationId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final db = await database.database;
    
    final results = await db.rawQuery('''
      SELECT 
        payment_method,
        COUNT(*) as transaction_count,
        SUM(total_amount) as total_amount
      FROM sales 
      WHERE organization_id = ? 
        AND created_at >= ? 
        AND created_at <= ?
        AND status = ?
      GROUP BY payment_method
      ORDER BY total_amount DESC
    ''', [
      organizationId,
      startDate.millisecondsSinceEpoch,
      endDate.millisecondsSinceEpoch,
      'completed',
    ]);
    
    return results.map((row) => Map<String, dynamic>.from(row)).toList();
  }

  // Top selling products
  Future<List<Map<String, dynamic>>> getTopSellingProducts({
    required String organizationId,
    required DateTime startDate,
    required DateTime endDate,
    int limit = 10,
  }) async {
    final db = await database.database;
    
    final results = await db.rawQuery('''
      SELECT 
        si.product_id,
        si.product_name,
        SUM(si.quantity) as total_quantity,
        SUM(si.total_amount) as total_revenue,
        COUNT(DISTINCT s.id) as transaction_count
      FROM sale_items si
      JOIN sales s ON s.id = si.sale_id
      WHERE s.organization_id = ? 
        AND s.created_at >= ? 
        AND s.created_at <= ?
        AND s.status = ?
      GROUP BY si.product_id, si.product_name
      ORDER BY total_revenue DESC
      LIMIT ?
    ''', [
      organizationId,
      startDate.millisecondsSinceEpoch,
      endDate.millisecondsSinceEpoch,
      'completed',
      limit,
    ]);
    
    return results.map((row) => Map<String, dynamic>.from(row)).toList();
  }

  // Hourly sales distribution
  Future<List<Map<String, dynamic>>> getHourlySalesDistribution({
    required String organizationId,
    required DateTime date,
  }) async {
    final db = await database.database;
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    
    final results = await db.rawQuery('''
      SELECT 
        CAST(strftime('%H', datetime(created_at/1000, 'unixepoch')) AS INTEGER) as hour,
        COUNT(*) as transaction_count,
        SUM(total_amount) as total_amount
      FROM sales 
      WHERE organization_id = ? 
        AND created_at >= ? 
        AND created_at < ?
        AND status = ?
      GROUP BY hour
      ORDER BY hour
    ''', [
      organizationId,
      startOfDay.millisecondsSinceEpoch,
      endOfDay.millisecondsSinceEpoch,
      'completed',
    ]);
    
    // Fill in missing hours with zeros
    final hourlyData = List.generate(24, (hour) {
      final existing = results.firstWhere(
        (row) => row['hour'] == hour,
        orElse: () => {},
      );
      
      return {
        'hour': hour,
        'transaction_count': existing['transaction_count'] ?? 0,
        'total_amount': existing['total_amount'] ?? 0.0,
      };
    });
    
    return hourlyData;
  }

  // Daily sales trend
  Future<List<Map<String, dynamic>>> getDailySalesTrend({
    required String organizationId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final db = await database.database;
    
    final results = await db.rawQuery('''
      SELECT 
        date(created_at/1000, 'unixepoch') as sale_date,
        COUNT(*) as transaction_count,
        SUM(total_amount) as total_amount,
        SUM(tax_amount) as total_tax,
        SUM(discount_amount) as total_discount
      FROM sales 
      WHERE organization_id = ? 
        AND created_at >= ? 
        AND created_at <= ?
        AND status = ?
      GROUP BY sale_date
      ORDER BY sale_date
    ''', [
      organizationId,
      startDate.millisecondsSinceEpoch,
      endDate.millisecondsSinceEpoch,
      'completed',
    ]);
    
    return results.map((row) => Map<String, dynamic>.from(row)).toList();
  }

  // Sales by user/cashier
  Future<List<Map<String, dynamic>>> getSalesByUser({
    required String organizationId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final db = await database.database;
    
    final results = await db.rawQuery('''
      SELECT 
        s.user_id,
        u.name as user_name,
        COUNT(*) as transaction_count,
        SUM(s.total_amount) as total_amount,
        AVG(s.total_amount) as average_sale
      FROM sales s
      LEFT JOIN users u ON u.id = s.user_id
      WHERE s.organization_id = ? 
        AND s.created_at >= ? 
        AND s.created_at <= ?
        AND s.status = ?
      GROUP BY s.user_id, u.name
      ORDER BY total_amount DESC
    ''', [
      organizationId,
      startDate.millisecondsSinceEpoch,
      endDate.millisecondsSinceEpoch,
      'completed',
    ]);
    
    return results.map((row) => Map<String, dynamic>.from(row)).toList();
  }

  // Register summary
  Future<List<Map<String, dynamic>>> getRegisterSummary({
    required String organizationId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final db = await database.database;
    
    final results = await db.rawQuery('''
      SELECT 
        r.id as register_id,
        r.name as register_name,
        COUNT(s.id) as transaction_count,
        SUM(s.total_amount) as total_sales,
        r.opening_balance,
        r.current_balance,
        r.expected_balance
      FROM registers r
      LEFT JOIN sales s ON s.register_id = r.id 
        AND s.created_at >= ? 
        AND s.created_at <= ?
        AND s.status = ?
      WHERE r.organization_id = ?
      GROUP BY r.id, r.name, r.opening_balance, r.current_balance, r.expected_balance
    ''', [
      startDate.millisecondsSinceEpoch,
      endDate.millisecondsSinceEpoch,
      'completed',
      organizationId,
    ]);
    
    return results.map((row) => Map<String, dynamic>.from(row)).toList();
  }

  // Customer analytics
  Future<Map<String, dynamic>> getCustomerAnalytics({
    required String organizationId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final db = await database.database;
    
    // Total unique customers
    final customerCountResult = await db.rawQuery('''
      SELECT COUNT(DISTINCT customer_id) as unique_customers
      FROM sales 
      WHERE organization_id = ? 
        AND created_at >= ? 
        AND created_at <= ?
        AND status = ?
        AND customer_id IS NOT NULL
    ''', [
      organizationId,
      startDate.millisecondsSinceEpoch,
      endDate.millisecondsSinceEpoch,
      'completed',
    ]);
    
    // Top customers
    final topCustomers = await db.rawQuery('''
      SELECT 
        customer_id,
        COUNT(*) as transaction_count,
        SUM(total_amount) as total_spent,
        AVG(total_amount) as average_purchase
      FROM sales 
      WHERE organization_id = ? 
        AND created_at >= ? 
        AND created_at <= ?
        AND status = ?
        AND customer_id IS NOT NULL
      GROUP BY customer_id
      ORDER BY total_spent DESC
      LIMIT 10
    ''', [
      organizationId,
      startDate.millisecondsSinceEpoch,
      endDate.millisecondsSinceEpoch,
      'completed',
    ]);
    
    return {
      'uniqueCustomers': customerCountResult.first['unique_customers'] ?? 0,
      'topCustomers': topCustomers.map((row) => Map<String, dynamic>.from(row)).toList(),
    };
  }

  // Refund analytics
  Future<Map<String, dynamic>> getRefundAnalytics({
    required String organizationId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final db = await database.database;
    
    final results = await db.rawQuery('''
      SELECT 
        COUNT(*) as refund_count,
        SUM(total_amount) as refund_amount
      FROM sales 
      WHERE organization_id = ? 
        AND created_at >= ? 
        AND created_at <= ?
        AND status = ?
    ''', [
      organizationId,
      startDate.millisecondsSinceEpoch,
      endDate.millisecondsSinceEpoch,
      'refunded',
    ]);
    
    return Map<String, dynamic>.from(results.first);
  }
}