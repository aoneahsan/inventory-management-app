/// Value objects and types used in repository interfaces

/// Product price update
class ProductPriceUpdate {
  final String productId;
  final double? purchasePrice;
  final double? sellingPrice;
  final DateTime effectiveDate;

  ProductPriceUpdate({
    required this.productId,
    this.purchasePrice,
    this.sellingPrice,
    required this.effectiveDate,
  });
}

/// Product movement
class ProductMovement {
  final String id;
  final DateTime date;
  final String type;
  final double quantity;
  final String? reference;
  final String? branchId;

  ProductMovement({
    required this.id,
    required this.date,
    required this.type,
    required this.quantity,
    this.reference,
    this.branchId,
  });
}

/// Product statistics
class ProductStatistics {
  final int totalSold;
  final double totalRevenue;
  final double averagePrice;
  final double profitMargin;
  final int daysInStock;
  final double turnoverRate;

  ProductStatistics({
    required this.totalSold,
    required this.totalRevenue,
    required this.averagePrice,
    required this.profitMargin,
    required this.daysInStock,
    required this.turnoverRate,
  });
}

/// Category node for tree structure
class CategoryNode {
  final String id;
  final String name;
  final String? parentId;
  final List<CategoryNode> children;
  final int productCount;

  CategoryNode({
    required this.id,
    required this.name,
    this.parentId,
    required this.children,
    required this.productCount,
  });
}

/// Category order
class CategoryOrder {
  final String categoryId;
  final int sortOrder;

  CategoryOrder({
    required this.categoryId,
    required this.sortOrder,
  });
}

/// Customer statistics
class CustomerStatistics {
  final int totalPurchases;
  final double totalSpent;
  final double averageOrderValue;
  final DateTime? lastPurchaseDate;
  final int loyaltyPoints;
  final double outstandingBalance;

  CustomerStatistics({
    required this.totalPurchases,
    required this.totalSpent,
    required this.averageOrderValue,
    this.lastPurchaseDate,
    required this.loyaltyPoints,
    required this.outstandingBalance,
  });
}

/// Customer revenue
class CustomerRevenue {
  final String customerId;
  final String customerName;
  final double totalRevenue;
  final int orderCount;
  final double averageOrderValue;

  CustomerRevenue({
    required this.customerId,
    required this.customerName,
    required this.totalRevenue,
    required this.orderCount,
    required this.averageOrderValue,
  });
}

/// Supplier statistics
class SupplierStatistics {
  final int totalOrders;
  final double totalPurchases;
  final double averageOrderValue;
  final DateTime? lastOrderDate;
  final double outstandingBalance;
  final double onTimeDeliveryRate;

  SupplierStatistics({
    required this.totalOrders,
    required this.totalPurchases,
    required this.averageOrderValue,
    this.lastOrderDate,
    required this.outstandingBalance,
    required this.onTimeDeliveryRate,
  });
}

/// Supplier volume
class SupplierVolume {
  final String supplierId;
  final String supplierName;
  final double totalVolume;
  final int orderCount;
  final double averageOrderValue;

  SupplierVolume({
    required this.supplierId,
    required this.supplierName,
    required this.totalVolume,
    required this.orderCount,
    required this.averageOrderValue,
  });
}

/// Payment due
class PaymentDue {
  final String supplierId;
  final String supplierName;
  final double amountDue;
  final DateTime dueDate;
  final int daysOverdue;
  final String? invoiceNumber;

  PaymentDue({
    required this.supplierId,
    required this.supplierName,
    required this.amountDue,
    required this.dueDate,
    required this.daysOverdue,
    this.invoiceNumber,
  });
}

/// Transfer item
class TransferItem {
  final String productId;
  final double quantity;
  final String? batchId;
  final String? serialNumber;

  TransferItem({
    required this.productId,
    required this.quantity,
    this.batchId,
    this.serialNumber,
  });
}

/// Branch statistics
class BranchStatistics {
  final double totalSales;
  final int transactionCount;
  final double averageTransactionValue;
  final int activeProducts;
  final double inventoryValue;
  final int activeCustomers;

  BranchStatistics({
    required this.totalSales,
    required this.transactionCount,
    required this.averageTransactionValue,
    required this.activeProducts,
    required this.inventoryValue,
    required this.activeCustomers,
  });
}

/// Branch performance
class BranchPerformance {
  final double salesGrowth;
  final double profitMargin;
  final double inventoryTurnover;
  final double customerRetention;
  final double employeeProductivity;
  final int stockouts;

  BranchPerformance({
    required this.salesGrowth,
    required this.profitMargin,
    required this.inventoryTurnover,
    required this.customerRetention,
    required this.employeeProductivity,
    required this.stockouts,
  });
}

/// Branch stock
class BranchStock {
  final String branchId;
  final String branchName;
  final double availableQuantity;
  final double reservedQuantity;
  final DateTime? lastUpdated;

  BranchStock({
    required this.branchId,
    required this.branchName,
    required this.availableQuantity,
    required this.reservedQuantity,
    this.lastUpdated,
  });
}

/// Return item
class ReturnItem {
  final String saleItemId;
  final String productId;
  final double quantity;
  final double refundAmount;
  final String reason;

  ReturnItem({
    required this.saleItemId,
    required this.productId,
    required this.quantity,
    required this.refundAmount,
    required this.reason,
  });
}

/// Sales summary
class SalesSummary {
  final double totalSales;
  final int transactionCount;
  final double averageTransactionValue;
  final double totalTax;
  final double totalDiscount;
  final Map<String, double> salesByPaymentMethod;

  SalesSummary({
    required this.totalSales,
    required this.transactionCount,
    required this.averageTransactionValue,
    required this.totalTax,
    required this.totalDiscount,
    required this.salesByPaymentMethod,
  });
}

/// Daily sales report
class DailySalesReport {
  final DateTime date;
  final double openingCash;
  final double closingCash;
  final double totalSales;
  final double totalReturns;
  final double netSales;
  final int transactionCount;
  final Map<String, double> salesByHour;
  final Map<String, double> salesByCategory;

  DailySalesReport({
    required this.date,
    required this.openingCash,
    required this.closingCash,
    required this.totalSales,
    required this.totalReturns,
    required this.netSales,
    required this.transactionCount,
    required this.salesByHour,
    required this.salesByCategory,
  });
}

/// Product sales report
class ProductSalesReport {
  final String productId;
  final String productName;
  final String sku;
  final double quantitySold;
  final double totalRevenue;
  final double totalCost;
  final double profit;
  final double profitMargin;

  ProductSalesReport({
    required this.productId,
    required this.productName,
    required this.sku,
    required this.quantitySold,
    required this.totalRevenue,
    required this.totalCost,
    required this.profit,
    required this.profitMargin,
  });
}

/// Payment summary
class PaymentSummary {
  final Map<String, double> totalByMethod;
  final double totalCash;
  final double totalCard;
  final double totalDigital;
  final double totalCredit;
  final double totalReceived;

  PaymentSummary({
    required this.totalByMethod,
    required this.totalCash,
    required this.totalCard,
    required this.totalDigital,
    required this.totalCredit,
    required this.totalReceived,
  });
}

/// Stock movement summary
class StockMovementSummary {
  final double openingStock;
  final double purchases;
  final double sales;
  final double adjustments;
  final double transfers;
  final double returns;
  final double closingStock;

  StockMovementSummary({
    required this.openingStock,
    required this.purchases,
    required this.sales,
    required this.adjustments,
    required this.transfers,
    required this.returns,
    required this.closingStock,
  });
}

/// Stock valuation
class StockValuation {
  final double totalQuantity;
  final double totalValue;
  final double averageCost;
  final Map<String, double> valueByProduct;
  final Map<String, double> valueByCategory;

  StockValuation({
    required this.totalQuantity,
    required this.totalValue,
    required this.averageCost,
    required this.valueByProduct,
    required this.valueByCategory,
  });
}

/// Received item
class ReceivedItem {
  final String itemId;
  final String productId;
  final double orderedQuantity;
  final double receivedQuantity;
  final String? batchNumber;
  final DateTime? expiryDate;
  final String? notes;

  ReceivedItem({
    required this.itemId,
    required this.productId,
    required this.orderedQuantity,
    required this.receivedQuantity,
    this.batchNumber,
    this.expiryDate,
    this.notes,
  });
}

/// Purchase order summary
class PurchaseOrderSummary {
  final int totalOrders;
  final double totalValue;
  final int pendingOrders;
  final int approvedOrders;
  final int receivedOrders;
  final double pendingValue;

  PurchaseOrderSummary({
    required this.totalOrders,
    required this.totalValue,
    required this.pendingOrders,
    required this.approvedOrders,
    required this.receivedOrders,
    required this.pendingValue,
  });
}

/// Goods receipt note
class GoodsReceiptNote {
  final String grnNumber;
  final String purchaseOrderNumber;
  final DateTime receiptDate;
  final String supplierName;
  final List<ReceivedItem> items;
  final String receivedBy;
  final String? notes;

  GoodsReceiptNote({
    required this.grnNumber,
    required this.purchaseOrderNumber,
    required this.receiptDate,
    required this.supplierName,
    required this.items,
    required this.receivedBy,
    this.notes,
  });
}

/// Supplier performance
class SupplierPerformance {
  final double onTimeDeliveryRate;
  final double qualityScore;
  final double priceCompetitiveness;
  final int totalOrders;
  final int delayedOrders;
  final int rejectedOrders;

  SupplierPerformance({
    required this.onTimeDeliveryRate,
    required this.qualityScore,
    required this.priceCompetitiveness,
    required this.totalOrders,
    required this.delayedOrders,
    required this.rejectedOrders,
  });
}

/// Batch allocation
class BatchAllocation {
  final String batchId;
  final double totalQuantity;
  final double availableQuantity;
  final double allocatedQuantity;
  final Map<String, double> allocationDetails;

  BatchAllocation({
    required this.batchId,
    required this.totalQuantity,
    required this.availableQuantity,
    required this.allocatedQuantity,
    required this.allocationDetails,
  });
}

/// Batch valuation
class BatchValuation {
  final double totalQuantity;
  final double totalValue;
  final double averageCost;
  final int activeBatches;
  final int expiredBatches;
  final double expiredValue;

  BatchValuation({
    required this.totalQuantity,
    required this.totalValue,
    required this.averageCost,
    required this.activeBatches,
    required this.expiredBatches,
    required this.expiredValue,
  });
}

/// Received transfer item
class ReceivedTransferItem {
  final String itemId;
  final String productId;
  final double requestedQuantity;
  final double receivedQuantity;
  final String? discrepancyReason;

  ReceivedTransferItem({
    required this.itemId,
    required this.productId,
    required this.requestedQuantity,
    required this.receivedQuantity,
    this.discrepancyReason,
  });
}

/// Transfer summary
class TransferSummary {
  final int totalTransfers;
  final int pendingTransfers;
  final int inTransitTransfers;
  final int completedTransfers;
  final double totalValue;
  final Map<String, int> transfersByStatus;

  TransferSummary({
    required this.totalTransfers,
    required this.pendingTransfers,
    required this.inTransitTransfers,
    required this.completedTransfers,
    required this.totalValue,
    required this.transfersByStatus,
  });
}

/// Transfer route
class TransferRoute {
  final String fromBranchId;
  final String fromBranchName;
  final String toBranchId;
  final String toBranchName;
  final int transferCount;
  final double totalValue;
  final double averageTransitTime;

  TransferRoute({
    required this.fromBranchId,
    required this.fromBranchName,
    required this.toBranchId,
    required this.toBranchName,
    required this.transferCount,
    required this.totalValue,
    required this.averageTransitTime,
  });
}

/// Tax calculation
class TaxCalculation {
  final double baseAmount;
  final double totalTax;
  final double totalAmount;
  final Map<String, double> taxBreakdown;

  TaxCalculation({
    required this.baseAmount,
    required this.totalTax,
    required this.totalAmount,
    required this.taxBreakdown,
  });
}

/// Tax summary
class TaxSummary {
  final double totalSales;
  final double totalTaxCollected;
  final Map<String, double> taxByType;
  final Map<String, double> taxByRate;

  TaxSummary({
    required this.totalSales,
    required this.totalTaxCollected,
    required this.taxByType,
    required this.taxByRate,
  });
}

/// GST summary
class GSTSummary {
  final double totalCGST;
  final double totalSGST;
  final double totalIGST;
  final double totalCess;
  final double totalTax;
  final Map<String, double> taxByHSN;

  GSTSummary({
    required this.totalCGST,
    required this.totalSGST,
    required this.totalIGST,
    required this.totalCess,
    required this.totalTax,
    required this.taxByHSN,
  });
}

/// Tax validation
class TaxValidation {
  final bool isValid;
  final List<String> errors;
  final List<String> warnings;

  TaxValidation({
    required this.isValid,
    required this.errors,
    required this.warnings,
  });
}