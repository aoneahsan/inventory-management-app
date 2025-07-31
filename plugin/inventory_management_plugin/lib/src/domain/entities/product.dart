import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String organizationId,
    required String name,
    required String sku,
    String? barcode,
    String? description,
    String? categoryId,
    @Default('pcs') String unit,
    @Default(0) double stockQuantity,
    @Default(0) double reorderPoint,
    @Default(0) double reorderQuantity,
    @Default(0) double costPrice,
    @Default(0) double sellingPrice,
    @Default(0) double taxRate,
    String? imageUrl,
    @Default(true) bool isActive,
    @Default(false) bool isComposite,
    @Default(true) bool trackInventory,
    @Default({}) Map<String, dynamic> metadata,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
    
    // Additional fields from plugin requirements
    String? hsn,
    String? sac,
    @Default(0) double minStock,
    double? maxStock,
    String? warehouseLocation,
    String? supplierId,
    String? brandName,
    @Default([]) List<String> tags,
    ProductVariants? variants,
    @Default({}) Map<String, double> branchStock, // branchId -> stock
    @Default(false) bool trackSerialNumbers,
    @Default(false) bool trackBatches,
    @Default(30) int shelfLifeDays,
    String? customFields,
  }) = _Product;
  
  const Product._();
  
  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  
  // Helper methods
  bool get isLowStock => stockQuantity <= reorderPoint;
  bool get isOutOfStock => stockQuantity <= 0;
  bool get needsReorder => stockQuantity <= reorderPoint;
  
  double get stockValue => stockQuantity * costPrice;
  double get potentialRevenue => stockQuantity * sellingPrice;
  double get profit => sellingPrice - costPrice;
  double get profitMargin {
    if (costPrice == 0) return 0;
    return (profit / costPrice) * 100;
  }
  
  double get sellingPriceWithTax {
    return sellingPrice + (sellingPrice * (taxRate / 100));
  }
  
  double getStockForBranch(String branchId) {
    return branchStock[branchId] ?? 0;
  }
  
  bool isAvailableInBranch(String branchId) {
    return getStockForBranch(branchId) > 0;
  }
  
  double get totalBranchStock {
    return branchStock.values.fold(0, (sum, stock) => sum + stock);
  }
}

@freezed
class ProductVariants with _$ProductVariants {
  const factory ProductVariants({
    @Default({}) Map<String, List<String>> attributes, // e.g., {"color": ["red", "blue"], "size": ["S", "M", "L"]}
    @Default([]) List<ProductVariant> variants,
  }) = _ProductVariants;
  
  factory ProductVariants.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantsFromJson(json);
}

@freezed
class ProductVariant with _$ProductVariant {
  const factory ProductVariant({
    required String id,
    required String sku,
    String? barcode,
    required Map<String, String> attributes, // e.g., {"color": "red", "size": "M"}
    @Default(0) double stockQuantity,
    double? costPrice,
    double? sellingPrice,
    String? imageUrl,
    @Default(true) bool isActive,
  }) = _ProductVariant;
  
  factory ProductVariant.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantFromJson(json);
}