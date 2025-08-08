import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String organizationId;
  final String name;
  final String sku;
  final String? barcode;
  final String? description;
  final String? categoryId;
  final String unit;
  final double currentStock;
  final double minStock;
  final double? maxStock;
  final double? reorderPoint;
  final double? reorderQuantity;
  final double? costPrice;
  final double? sellingPrice;
  final double taxRate;
  final String? warehouseLocation;
  final String? supplierId;
  final String? imageUrl;
  final bool isActive;
  final Map<String, dynamic> metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String currencyCode; // Currency code for prices
  final Map<String, double>? multiCurrencyPrices; // Prices in different currencies

  const Product({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.sku,
    this.barcode,
    this.description,
    this.categoryId,
    this.unit = 'pcs',
    this.currentStock = 0,
    this.minStock = 0,
    this.maxStock,
    this.reorderPoint,
    this.reorderQuantity,
    this.costPrice,
    this.sellingPrice,
    this.taxRate = 0,
    this.warehouseLocation,
    this.supplierId,
    this.imageUrl,
    this.isActive = true,
    this.metadata = const {},
    required this.createdAt,
    required this.updatedAt,
    this.currencyCode = 'USD',
    this.multiCurrencyPrices,
  });

  bool get isLowStock => currentStock <= minStock;
  bool get isOutOfStock => currentStock <= 0;
  bool get needsReorder => reorderPoint != null && currentStock <= reorderPoint!;
  
  double get stockValue => currentStock * (costPrice ?? 0);
  double get potentialRevenue => currentStock * (sellingPrice ?? 0);
  double get profit => (sellingPrice ?? 0) - (costPrice ?? 0);
  double get profitMargin {
    if (costPrice == null || costPrice == 0) return 0;
    return (profit / costPrice!) * 100;
  }

  Product copyWith({
    String? id,
    String? organizationId,
    String? name,
    String? sku,
    String? barcode,
    String? description,
    String? categoryId,
    String? unit,
    double? currentStock,
    double? minStock,
    double? maxStock,
    double? reorderPoint,
    double? reorderQuantity,
    double? costPrice,
    double? sellingPrice,
    double? taxRate,
    String? warehouseLocation,
    String? supplierId,
    String? imageUrl,
    bool? isActive,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? currencyCode,
    Map<String, double>? multiCurrencyPrices,
  }) {
    return Product(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      barcode: barcode ?? this.barcode,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      unit: unit ?? this.unit,
      currentStock: currentStock ?? this.currentStock,
      minStock: minStock ?? this.minStock,
      maxStock: maxStock ?? this.maxStock,
      reorderPoint: reorderPoint ?? this.reorderPoint,
      reorderQuantity: reorderQuantity ?? this.reorderQuantity,
      costPrice: costPrice ?? this.costPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      taxRate: taxRate ?? this.taxRate,
      warehouseLocation: warehouseLocation ?? this.warehouseLocation,
      supplierId: supplierId ?? this.supplierId,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      currencyCode: currencyCode ?? this.currencyCode,
      multiCurrencyPrices: multiCurrencyPrices ?? this.multiCurrencyPrices,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organization_id': organizationId,
      'name': name,
      'sku': sku,
      'barcode': barcode,
      'description': description,
      'category_id': categoryId,
      'unit': unit,
      'current_stock': currentStock,
      'min_stock': minStock,
      'max_stock': maxStock,
      'reorder_point': reorderPoint,
      'reorder_quantity': reorderQuantity,
      'cost_price': costPrice,
      'selling_price': sellingPrice,
      'tax_rate': taxRate,
      'warehouse_location': warehouseLocation,
      'supplier_id': supplierId,
      'image_url': imageUrl,
      'is_active': isActive,
      'metadata': metadata,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'currency_code': currencyCode,
      'multi_currency_prices': multiCurrencyPrices,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      organizationId: json['organization_id'] as String,
      name: json['name'] as String,
      sku: json['sku'] as String,
      barcode: json['barcode'] as String?,
      description: json['description'] as String?,
      categoryId: json['category_id'] as String?,
      unit: json['unit'] as String? ?? 'pcs',
      currentStock: (json['current_stock'] as num?)?.toDouble() ?? 0,
      minStock: (json['min_stock'] as num?)?.toDouble() ?? 0,
      maxStock: (json['max_stock'] as num?)?.toDouble(),
      reorderPoint: (json['reorder_point'] as num?)?.toDouble(),
      reorderQuantity: (json['reorder_quantity'] as num?)?.toDouble(),
      costPrice: (json['cost_price'] as num?)?.toDouble(),
      sellingPrice: (json['selling_price'] as num?)?.toDouble(),
      taxRate: (json['tax_rate'] as num?)?.toDouble() ?? 0,
      warehouseLocation: json['warehouse_location'] as String?,
      supplierId: json['supplier_id'] as String?,
      imageUrl: json['image_url'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      currencyCode: json['currency_code'] as String? ?? 'USD',
      multiCurrencyPrices: json['multi_currency_prices'] != null
          ? Map<String, double>.from(json['multi_currency_prices'] as Map)
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        organizationId,
        name,
        sku,
        barcode,
        description,
        categoryId,
        unit,
        currentStock,
        minStock,
        maxStock,
        reorderPoint,
        reorderQuantity,
        costPrice,
        sellingPrice,
        taxRate,
        warehouseLocation,
        supplierId,
        imageUrl,
        isActive,
        metadata,
        createdAt,
        updatedAt,
        currencyCode,
        multiCurrencyPrices,
      ];
}