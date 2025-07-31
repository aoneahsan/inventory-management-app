import 'package:freezed_annotation/freezed_annotation.dart';

part 'branch_inventory.freezed.dart';
part 'branch_inventory.g.dart';

@freezed
class BranchInventory with _$BranchInventory {
  const factory BranchInventory({
    required String id,
    required String branchId,
    required String productId,
    @Default(0) double currentStock,
    @Default(0) double reservedStock,
    @Default(0) double availableStock,
    @Default(0) double minStock,
    double? maxStock,
    double? reorderPoint,
    @Default(0) double reorderQuantity,
    required DateTime lastUpdated,
    DateTime? syncedAt,
    
    // Additional tracking fields
    String? warehouseLocation,
    String? shelfLocation,
    @Default(0) double incomingStock,
    @Default(0) double outgoingStock,
    DateTime? lastStockTakeDate,
    double? lastStockTakeQuantity,
    @Default({}) Map<String, dynamic> metadata,
    @Default(0) double averageDailySales,
    @Default(0) int daysOfStock,
    String? preferredSupplierId,
    @Default([]) List<StockAlert> activeAlerts,
  }) = _BranchInventory;
  
  const BranchInventory._();
  
  factory BranchInventory.fromJson(Map<String, dynamic> json) => 
      _$BranchInventoryFromJson(json);
  
  // Helper methods
  bool get isLowStock => currentStock <= minStock && minStock > 0;
  bool get needsReorder => reorderPoint != null && currentStock <= reorderPoint!;
  bool get isOverstock => maxStock != null && currentStock > maxStock!;
  bool get isOutOfStock => currentStock <= 0;
  bool get hasReservedStock => reservedStock > 0;
  
  double get totalStock => currentStock + incomingStock;
  double get netAvailableStock => availableStock - outgoingStock;
  
  int get estimatedDaysOfStock {
    if (averageDailySales <= 0) return 999;
    return (currentStock / averageDailySales).round();
  }
  
  bool get needsStockTake {
    if (lastStockTakeDate == null) return true;
    final daysSinceLastCount = DateTime.now().difference(lastStockTakeDate!).inDays;
    return daysSinceLastCount > 30; // Monthly stock take
  }
  
  double get stockAccuracy {
    if (lastStockTakeQuantity == null || lastStockTakeQuantity == 0) return 100;
    final variance = (currentStock - lastStockTakeQuantity!).abs();
    return ((1 - (variance / lastStockTakeQuantity!)) * 100).clamp(0, 100);
  }
  
  StockStatus get stockStatus {
    if (isOutOfStock) return StockStatus.outOfStock;
    if (isLowStock) return StockStatus.lowStock;
    if (needsReorder) return StockStatus.reorderNeeded;
    if (isOverstock) return StockStatus.overstock;
    return StockStatus.optimal;
  }
}

enum StockStatus {
  @JsonValue('out_of_stock')
  outOfStock,
  @JsonValue('low_stock')
  lowStock,
  @JsonValue('reorder_needed')
  reorderNeeded,
  @JsonValue('optimal')
  optimal,
  @JsonValue('overstock')
  overstock,
}

@freezed
class StockAlert with _$StockAlert {
  const factory StockAlert({
    required String id,
    required String type,
    required String message,
    required AlertSeverity severity,
    required DateTime createdAt,
    DateTime? acknowledgedAt,
    String? acknowledgedBy,
    @Default({}) Map<String, dynamic> metadata,
  }) = _StockAlert;
  
  factory StockAlert.fromJson(Map<String, dynamic> json) => 
      _$StockAlertFromJson(json);
}

enum AlertSeverity {
  @JsonValue('info')
  info,
  @JsonValue('warning')
  warning,
  @JsonValue('critical')
  critical,
}