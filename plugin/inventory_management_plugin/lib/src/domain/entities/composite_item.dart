import 'package:freezed_annotation/freezed_annotation.dart';

part 'composite_item.freezed.dart';
part 'composite_item.g.dart';

enum AssemblyType {
  @JsonValue('manual')
  manual,
  @JsonValue('automatic')
  automatic,
  @JsonValue('on_demand')
  onDemand,
}

@freezed
class CompositeItem with _$CompositeItem {
  const factory CompositeItem({
    required String id,
    required String organizationId,
    required String name,
    required String code,
    String? description,
    required double sellingPrice,
    double? costPrice,
    @Default(true) bool isActive,
    @Default(false) bool autoAssemble,
    @Default(true) bool canBeSoldSeparately,
    @Default(AssemblyType.manual) AssemblyType assemblyType,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<CompositeItemComponent> components,
    DateTime? syncedAt,
    
    // Additional fields
    String? sku,
    String? barcode,
    String? categoryId,
    @Default(0) double taxRate,
    String? imageUrl,
    @Default({}) Map<String, dynamic> metadata,
    @Default(0) double assemblyTime, // in minutes
    String? assemblyInstructions,
    @Default(false) bool trackInventory,
    @Default(0) double currentStock,
    String? unit,
    @Default(0) double minStock,
    double? maxStock,
  }) = _CompositeItem;
  
  const CompositeItem._();
  
  factory CompositeItem.fromJson(Map<String, dynamic> json) => 
      _$CompositeItemFromJson(json);
  
  // Helper methods
  double get calculatedCostPrice {
    if (components.isEmpty) return costPrice ?? 0.0;
    
    // Sum up component costs
    return components.fold(0.0, (total, component) => 
        total + (component.quantity * (component.unitCost ?? 0)));
  }
  
  double get totalComponentCost => calculatedCostPrice;
  
  double get effectiveCostPrice => costPrice ?? calculatedCostPrice;
  
  double get profitMargin {
    final cost = effectiveCostPrice;
    if (cost == 0) return 0;
    return ((sellingPrice - cost) / cost) * 100;
  }
  
  double get profitAmount => sellingPrice - effectiveCostPrice;
  
  double get sellingPriceWithTax => sellingPrice + (sellingPrice * (taxRate / 100));
  
  bool get hasAllComponents => components.isNotEmpty;
  
  bool get canAssemble {
    // In real implementation, would check if all component products have sufficient stock
    return isActive && hasAllComponents;
  }
  
  bool get needsRestock => trackInventory && currentStock <= minStock;
  
  double getTotalComponentQuantity(String productId) {
    return components
        .where((c) => c.productId == productId)
        .fold(0.0, (total, c) => total + c.quantity);
  }
  
  int get componentCount => components.length;
  
  Set<String> get uniqueComponentProducts => 
      components.map((c) => c.productId).toSet();
}

@freezed
class CompositeItemComponent with _$CompositeItemComponent {
  const factory CompositeItemComponent({
    required String id,
    required String compositeItemId,
    required String productId,
    required double quantity,
    double? unitCost,
    required DateTime createdAt,
    
    // Additional fields for better tracking
    String? productName,
    String? productSku,
    String? unit,
    @Default(false) bool isOptional,
    double? minQuantity,
    double? maxQuantity,
    String? notes,
    @Default(1) int sortOrder,
  }) = _CompositeItemComponent;
  
  const CompositeItemComponent._();
  
  factory CompositeItemComponent.fromJson(Map<String, dynamic> json) => 
      _$CompositeItemComponentFromJson(json);
  
  // Helper methods
  double get totalCost => quantity * (unitCost ?? 0);
  
  bool get isRequired => !isOptional;
  
  bool isValidQuantity(double qty) {
    if (minQuantity != null && qty < minQuantity!) return false;
    if (maxQuantity != null && qty > maxQuantity!) return false;
    return qty > 0;
  }
}

@freezed
class CompositeItemAssembly with _$CompositeItemAssembly {
  const factory CompositeItemAssembly({
    required String id,
    required String compositeItemId,
    required String branchId,
    required double quantity,
    required DateTime assemblyDate,
    required String assembledBy,
    @Default('pending') String status,
    DateTime? completedAt,
    String? notes,
    @Default({}) Map<String, double> componentsUsed,
    double? totalCost,
    required DateTime createdAt,
  }) = _CompositeItemAssembly;
  
  factory CompositeItemAssembly.fromJson(Map<String, dynamic> json) => 
      _$CompositeItemAssemblyFromJson(json);
}