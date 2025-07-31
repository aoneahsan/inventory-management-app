import 'dart:async';
import '../../domain/entities/sale.dart';
import '../../domain/entities/purchase_order.dart';
import '../../domain/entities/inventory_movement.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/batch.dart';
import '../../domain/repositories/sale_repository.dart';
import '../../domain/repositories/purchase_order_repository.dart';
import '../../domain/repositories/inventory_movement_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/batch_repository.dart';
import '../../core/utils/logger.dart';

/// Service for generating various reports
class ReportingService {
  final SaleRepository _saleRepository;
  final PurchaseOrderRepository _purchaseOrderRepository;
  final InventoryMovementRepository _movementRepository;
  final ProductRepository _productRepository;
  final BatchRepository _batchRepository;

  ReportingService({
    required SaleRepository saleRepository,
    required PurchaseOrderRepository purchaseOrderRepository,
    required InventoryMovementRepository movementRepository,
    required ProductRepository productRepository,
    required BatchRepository batchRepository,
  })  : _saleRepository = saleRepository,
        _purchaseOrderRepository = purchaseOrderRepository,
        _movementRepository = movementRepository,
        _productRepository = productRepository,
        _batchRepository = batchRepository;

  /// Generates sales report
  Future<SalesReport> generateSalesReport({
    required DateTime startDate,
    required DateTime endDate,
    String? branchId,
    String? customerId,
    String? userId,
  }) async {
    try {
      var sales = await _saleRepository.getSalesByDateRange(startDate, endDate);

      // Apply filters
      if (branchId != null) {
        sales = sales.where((s) => s.branchId == branchId).toList();
      }
      if (customerId != null) {
        sales = sales.where((s) => s.customerId == customerId).toList();
      }
      if (userId != null) {
        sales = sales.where((s) => s.userId == userId).toList();
      }

      // Calculate totals
      double totalRevenue = 0;
      double totalTax = 0;
      double totalDiscount = 0;
      int totalTransactions = sales.length;
      Map<String, int> productsSold = {};
      Map<String, double> revenueByPaymentMethod = {};

      for (final sale in sales) {
        totalRevenue += sale.total;
        totalTax += sale.taxAmount;
        totalDiscount += sale.discountAmount;

        // Track payment methods
        revenueByPaymentMethod[sale.paymentMethod] = 
            (revenueByPaymentMethod[sale.paymentMethod] ?? 0) + sale.total;

        // Track products sold
        for (final item in sale.items) {
          final productId = item['productId'] as String;
          final quantity = item['quantity'] as int;
          productsSold[productId] = (productsSold[productId] ?? 0) + quantity;
        }
      }

      // Get top selling products
      final topProducts = await _getTopProducts(productsSold, 10);

      return SalesReport(
        startDate: startDate,
        endDate: endDate,
        totalRevenue: totalRevenue,
        totalTax: totalTax,
        totalDiscount: totalDiscount,
        totalTransactions: totalTransactions,
        averageTransactionValue: totalTransactions > 0 ? totalRevenue / totalTransactions : 0,
        topSellingProducts: topProducts,
        revenueByPaymentMethod: revenueByPaymentMethod,
        sales: sales,
      );
    } catch (e) {
      Logger.error('Error generating sales report: $e');
      rethrow;
    }
  }

  /// Generates inventory report
  Future<InventoryReport> generateInventoryReport({
    String? branchId,
    String? categoryId,
    bool includeLowStock = true,
    bool includeExpiring = true,
    double lowStockThreshold = 10,
  }) async {
    try {
      var products = await _productRepository.getAllProducts();

      // Apply category filter
      if (categoryId != null) {
        products = products.where((p) => p.categoryId == categoryId).toList();
      }

      final inventoryItems = <InventoryReportItem>[];
      double totalValue = 0;
      int lowStockCount = 0;
      int outOfStockCount = 0;
      int expiringCount = 0;

      for (final product in products) {
        // Get stock levels
        final stockLevels = <String, double>{};
        double totalStock = 0;

        if (branchId != null) {
          final stock = await _movementRepository.getProductStock(product.id, branchId);
          stockLevels[branchId] = stock;
          totalStock = stock;
        } else {
          // Get stock for all branches
          // This would need branch list from context
          final stock = await _movementRepository.getProductStock(product.id, 'default');
          stockLevels['default'] = stock;
          totalStock = stock;
        }

        // Check stock status
        if (totalStock == 0) {
          outOfStockCount++;
        } else if (totalStock <= lowStockThreshold) {
          lowStockCount++;
        }

        // Check expiring batches
        if (includeExpiring) {
          final expiringBatches = await _batchRepository.getExpiringBatches(30);
          final productExpiringBatches = expiringBatches
              .where((b) => b.productId == product.id)
              .toList();
          if (productExpiringBatches.isNotEmpty) {
            expiringCount++;
          }
        }

        // Calculate value
        final value = totalStock * (product.costPrice ?? 0);
        totalValue += value;

        inventoryItems.add(InventoryReportItem(
          product: product,
          stockLevels: stockLevels,
          totalStock: totalStock,
          value: value,
          isLowStock: totalStock > 0 && totalStock <= lowStockThreshold,
          isOutOfStock: totalStock == 0,
        ));
      }

      return InventoryReport(
        generatedAt: DateTime.now(),
        totalProducts: products.length,
        totalValue: totalValue,
        lowStockCount: lowStockCount,
        outOfStockCount: outOfStockCount,
        expiringCount: expiringCount,
        items: inventoryItems,
      );
    } catch (e) {
      Logger.error('Error generating inventory report: $e');
      rethrow;
    }
  }

  /// Generates purchase report
  Future<PurchaseReport> generatePurchaseReport({
    required DateTime startDate,
    required DateTime endDate,
    String? branchId,
    String? supplierId,
  }) async {
    try {
      var orders = await _purchaseOrderRepository.getOrdersByDateRange(startDate, endDate);

      // Apply filters
      if (branchId != null) {
        orders = orders.where((o) => o.branchId == branchId).toList();
      }
      if (supplierId != null) {
        orders = orders.where((o) => o.supplierId == supplierId).toList();
      }

      // Calculate totals
      double totalPurchaseValue = 0;
      int totalOrders = orders.length;
      int pendingOrders = 0;
      int completedOrders = 0;
      Map<String, double> purchaseBySupplier = {};

      for (final order in orders) {
        totalPurchaseValue += order.total;

        // Track order status
        if (order.status == 'pending') {
          pendingOrders++;
        } else if (order.status == 'completed') {
          completedOrders++;
        }

        // Track by supplier
        purchaseBySupplier[order.supplierId] = 
            (purchaseBySupplier[order.supplierId] ?? 0) + order.total;
      }

      return PurchaseReport(
        startDate: startDate,
        endDate: endDate,
        totalPurchaseValue: totalPurchaseValue,
        totalOrders: totalOrders,
        pendingOrders: pendingOrders,
        completedOrders: completedOrders,
        averageOrderValue: totalOrders > 0 ? totalPurchaseValue / totalOrders : 0,
        purchaseBySupplier: purchaseBySupplier,
        orders: orders,
      );
    } catch (e) {
      Logger.error('Error generating purchase report: $e');
      rethrow;
    }
  }

  /// Generates movement report
  Future<MovementReport> generateMovementReport({
    required DateTime startDate,
    required DateTime endDate,
    String? branchId,
    String? productId,
    String? movementType,
  }) async {
    try {
      var movements = await _movementRepository.getMovementsByDateRange(startDate, endDate);

      // Apply filters
      if (branchId != null) {
        movements = movements.where((m) => m.branchId == branchId).toList();
      }
      if (productId != null) {
        movements = movements.where((m) => m.productId == productId).toList();
      }
      if (movementType != null) {
        movements = movements.where((m) => m.movementType == movementType).toList();
      }

      // Group movements by type
      final movementsByType = <String, List<InventoryMovement>>{};
      final quantityByType = <String, double>{};

      for (final movement in movements) {
        movementsByType[movement.movementType] ??= [];
        movementsByType[movement.movementType]!.add(movement);

        quantityByType[movement.movementType] = 
            (quantityByType[movement.movementType] ?? 0) + movement.quantity;
      }

      return MovementReport(
        startDate: startDate,
        endDate: endDate,
        totalMovements: movements.length,
        movementsByType: movementsByType,
        quantityByType: quantityByType,
        movements: movements,
      );
    } catch (e) {
      Logger.error('Error generating movement report: $e');
      rethrow;
    }
  }

  /// Generates expiry report
  Future<ExpiryReport> generateExpiryReport({
    String? branchId,
    int daysBeforeExpiry = 30,
  }) async {
    try {
      final expiringBatches = await _batchRepository.getExpiringBatches(daysBeforeExpiry);
      final expiredBatches = await _batchRepository.getExpiredBatches();

      // Apply branch filter
      var filteredExpiring = expiringBatches;
      var filteredExpired = expiredBatches;

      if (branchId != null) {
        filteredExpiring = expiringBatches.where((b) => b.branchId == branchId).toList();
        filteredExpired = expiredBatches.where((b) => b.branchId == branchId).toList();
      }

      // Calculate values
      double expiringValue = 0;
      double expiredValue = 0;

      for (final batch in filteredExpiring) {
        expiringValue += batch.quantity * batch.unitCost;
      }

      for (final batch in filteredExpired) {
        expiredValue += batch.quantity * batch.unitCost;
      }

      return ExpiryReport(
        generatedAt: DateTime.now(),
        expiringBatches: filteredExpiring,
        expiredBatches: filteredExpired,
        totalExpiringValue: expiringValue,
        totalExpiredValue: expiredValue,
        daysBeforeExpiry: daysBeforeExpiry,
      );
    } catch (e) {
      Logger.error('Error generating expiry report: $e');
      rethrow;
    }
  }

  /// Gets top selling products
  Future<List<TopProduct>> _getTopProducts(
    Map<String, int> productsSold,
    int limit,
  ) async {
    // Sort by quantity sold
    final sorted = productsSold.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final topProducts = <TopProduct>[];

    for (int i = 0; i < sorted.length && i < limit; i++) {
      final entry = sorted[i];
      final product = await _productRepository.getProductById(entry.key);
      
      if (product != null) {
        topProducts.add(TopProduct(
          product: product,
          quantitySold: entry.value,
          revenue: entry.value * (product.sellingPrice ?? 0),
        ));
      }
    }

    return topProducts;
  }

  void dispose() {
    _saleRepository.dispose();
    _purchaseOrderRepository.dispose();
    _movementRepository.dispose();
    _productRepository.dispose();
    _batchRepository.dispose();
  }
}

// Report models
class SalesReport {
  final DateTime startDate;
  final DateTime endDate;
  final double totalRevenue;
  final double totalTax;
  final double totalDiscount;
  final int totalTransactions;
  final double averageTransactionValue;
  final List<TopProduct> topSellingProducts;
  final Map<String, double> revenueByPaymentMethod;
  final List<Sale> sales;

  SalesReport({
    required this.startDate,
    required this.endDate,
    required this.totalRevenue,
    required this.totalTax,
    required this.totalDiscount,
    required this.totalTransactions,
    required this.averageTransactionValue,
    required this.topSellingProducts,
    required this.revenueByPaymentMethod,
    required this.sales,
  });
}

class InventoryReport {
  final DateTime generatedAt;
  final int totalProducts;
  final double totalValue;
  final int lowStockCount;
  final int outOfStockCount;
  final int expiringCount;
  final List<InventoryReportItem> items;

  InventoryReport({
    required this.generatedAt,
    required this.totalProducts,
    required this.totalValue,
    required this.lowStockCount,
    required this.outOfStockCount,
    required this.expiringCount,
    required this.items,
  });
}

class InventoryReportItem {
  final Product product;
  final Map<String, double> stockLevels;
  final double totalStock;
  final double value;
  final bool isLowStock;
  final bool isOutOfStock;

  InventoryReportItem({
    required this.product,
    required this.stockLevels,
    required this.totalStock,
    required this.value,
    required this.isLowStock,
    required this.isOutOfStock,
  });
}

class PurchaseReport {
  final DateTime startDate;
  final DateTime endDate;
  final double totalPurchaseValue;
  final int totalOrders;
  final int pendingOrders;
  final int completedOrders;
  final double averageOrderValue;
  final Map<String, double> purchaseBySupplier;
  final List<PurchaseOrder> orders;

  PurchaseReport({
    required this.startDate,
    required this.endDate,
    required this.totalPurchaseValue,
    required this.totalOrders,
    required this.pendingOrders,
    required this.completedOrders,
    required this.averageOrderValue,
    required this.purchaseBySupplier,
    required this.orders,
  });
}

class MovementReport {
  final DateTime startDate;
  final DateTime endDate;
  final int totalMovements;
  final Map<String, List<InventoryMovement>> movementsByType;
  final Map<String, double> quantityByType;
  final List<InventoryMovement> movements;

  MovementReport({
    required this.startDate,
    required this.endDate,
    required this.totalMovements,
    required this.movementsByType,
    required this.quantityByType,
    required this.movements,
  });
}

class ExpiryReport {
  final DateTime generatedAt;
  final List<Batch> expiringBatches;
  final List<Batch> expiredBatches;
  final double totalExpiringValue;
  final double totalExpiredValue;
  final int daysBeforeExpiry;

  ExpiryReport({
    required this.generatedAt,
    required this.expiringBatches,
    required this.expiredBatches,
    required this.totalExpiringValue,
    required this.totalExpiredValue,
    required this.daysBeforeExpiry,
  });
}

class TopProduct {
  final Product product;
  final int quantitySold;
  final double revenue;

  TopProduct({
    required this.product,
    required this.quantitySold,
    required this.revenue,
  });
}