import '../../domain/entities/sale_item.dart';
import '../database/database_schema.dart';
import 'base_model.dart';

/// Database model for SaleItem entity
class SaleItemModel extends BaseModel {
  final SaleItem saleItem;
  
  SaleItemModel(this.saleItem);
  
  @override
  String get tableName => DatabaseSchema.saleItemsTable;
  
  @override
  Map<String, dynamic> toDatabase() {
    return {
      DatabaseSchema.id: saleItem.id,
      'sale_id': saleItem.saleId,
      'product_id': saleItem.productId,
      'quantity': saleItem.quantity,
      'unit_price': saleItem.unitPrice,
      'subtotal': saleItem.subtotal,
      'discount_amount': saleItem.discountAmount,
      'tax_amount': saleItem.taxAmount,
      'total_amount': saleItem.totalAmount,
      'cost_price': saleItem.costPrice,
      'batch_id': saleItem.batchId,
      'serial_number': saleItem.serialNumber,
      'notes': saleItem.notes,
      DatabaseSchema.createdAt: dateTimeToMillis(saleItem.createdAt),
    };
  }
  
  /// Create SaleItem from database map
  factory SaleItemModel.fromDatabase(Map<String, dynamic> map) {
    final saleItem = _fromMap(map);
    return SaleItemModel(saleItem);
  }
  
  static SaleItem _fromMap(Map<String, dynamic> map) {
    return SaleItem(
      id: map[DatabaseSchema.id] as String,
      saleId: map['sale_id'] as String,
      productId: map['product_id'] as String,
      quantity: (map['quantity'] as num).toDouble(),
      unitPrice: (map['unit_price'] as num).toDouble(),
      subtotal: (map['subtotal'] as num).toDouble(),
      discountAmount: (map['discount_amount'] as num?)?.toDouble() ?? 0,
      taxAmount: (map['tax_amount'] as num?)?.toDouble() ?? 0,
      totalAmount: (map['total_amount'] as num).toDouble(),
      costPrice: (map['cost_price'] as num?)?.toDouble(),
      batchId: map['batch_id'] as String?,
      serialNumber: map['serial_number'] as String?,
      notes: map['notes'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.createdAt] as int),
    );
  }
}