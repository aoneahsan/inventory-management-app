import 'dart:convert';

import '../../domain/entities/product.dart';
import '../database/database_schema.dart';
import 'base_model.dart';

/// Database model for Product entity
class ProductModel extends BaseModel {
  final Product product;
  
  ProductModel(this.product);
  
  @override
  String get tableName => DatabaseSchema.productsTable;
  
  @override
  Map<String, dynamic> toDatabase() {
    return {
      DatabaseSchema.id: product.id,
      DatabaseSchema.organizationId: product.organizationId,
      'name': product.name,
      'sku': product.sku,
      'barcode': product.barcode,
      'category_id': product.categoryId,
      'description': product.description,
      'unit': product.unit,
      'purchase_price': product.purchasePrice,
      'selling_price': product.sellingPrice,
      'tax_rate': product.taxRate,
      'hsn_code': product.hsnCode,
      'brand': product.brand,
      'model': product.model,
      DatabaseSchema.isActive: boolToInt(product.isActive),
      'track_inventory': boolToInt(product.trackInventory),
      'track_batches': boolToInt(product.trackBatches),
      'track_serial_numbers': boolToInt(product.trackSerialNumbers),
      'low_stock_alert': boolToInt(product.lowStockAlert),
      'reorder_point': product.reorderPoint,
      'reorder_quantity': product.reorderQuantity,
      'image_url': product.imageUrl,
      DatabaseSchema.metadata: encodeMetadata(product.metadata),
      DatabaseSchema.createdAt: dateTimeToMillis(product.createdAt),
      DatabaseSchema.updatedAt: dateTimeToMillis(product.updatedAt),
      DatabaseSchema.syncedAt: dateTimeToMillis(product.syncedAt),
    };
  }
  
  /// Create Product from database map
  factory ProductModel.fromDatabase(Map<String, dynamic> map) {
    final model = ProductModel._fromMap(map);
    return ProductModel(model);
  }
  
  static Product _fromMap(Map<String, dynamic> map) {
    return Product(
      id: map[DatabaseSchema.id] as String,
      organizationId: map[DatabaseSchema.organizationId] as String,
      name: map['name'] as String,
      sku: map['sku'] as String,
      barcode: map['barcode'] as String?,
      categoryId: map['category_id'] as String?,
      description: map['description'] as String?,
      unit: map['unit'] as String,
      purchasePrice: (map['purchase_price'] as num).toDouble(),
      sellingPrice: (map['selling_price'] as num).toDouble(),
      taxRate: (map['tax_rate'] as num?)?.toDouble() ?? 0,
      hsnCode: map['hsn_code'] as String?,
      brand: map['brand'] as String?,
      model: map['model'] as String?,
      isActive: map[DatabaseSchema.isActive] == 1,
      trackInventory: map['track_inventory'] == 1,
      trackBatches: map['track_batches'] == 1,
      trackSerialNumbers: map['track_serial_numbers'] == 1,
      lowStockAlert: map['low_stock_alert'] == 1,
      reorderPoint: (map['reorder_point'] as num?)?.toDouble() ?? 0,
      reorderQuantity: (map['reorder_quantity'] as num?)?.toDouble() ?? 0,
      imageUrl: map['image_url'] as String?,
      metadata: _decodeMetadata(map[DatabaseSchema.metadata] as String?),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.createdAt] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.updatedAt] as int),
      syncedAt: map[DatabaseSchema.syncedAt] != null
          ? DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.syncedAt] as int)
          : null,
    );
  }
  
  static Map<String, dynamic> _decodeMetadata(String? metadata) {
    if (metadata == null || metadata.isEmpty) return {};
    try {
      return Map<String, dynamic>.from(json.decode(metadata));
    } catch (_) {
      return {};
    }
  }
}