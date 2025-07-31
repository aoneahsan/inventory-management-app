import 'dart:convert';

import '../../domain/entities/sale.dart';
import '../database/database_schema.dart';
import 'base_model.dart';

/// Database model for Sale entity
class SaleModel extends BaseModel {
  final Sale sale;
  
  SaleModel(this.sale);
  
  @override
  String get tableName => DatabaseSchema.salesTable;
  
  @override
  Map<String, dynamic> toDatabase() {
    return {
      DatabaseSchema.id: sale.id,
      DatabaseSchema.organizationId: sale.organizationId,
      'branch_id': sale.branchId,
      'sale_number': sale.saleNumber,
      'customer_id': sale.customerId,
      'sale_date': dateTimeToMillis(sale.saleDate),
      'subtotal': sale.subtotal,
      'tax_amount': sale.taxAmount,
      'discount_amount': sale.discountAmount,
      'total_amount': sale.totalAmount,
      'paid_amount': sale.paidAmount,
      'change_amount': sale.changeAmount,
      'payment_method': sale.paymentMethod?.name,
      'payment_reference': sale.paymentReference,
      'status': sale.status.name,
      'cashier_id': sale.cashierId,
      'register_id': sale.registerId,
      'notes': sale.notes,
      DatabaseSchema.metadata: encodeMetadata(sale.metadata),
      DatabaseSchema.createdAt: dateTimeToMillis(sale.createdAt),
      DatabaseSchema.updatedAt: dateTimeToMillis(sale.updatedAt),
      DatabaseSchema.syncedAt: dateTimeToMillis(sale.syncedAt),
    };
  }
  
  /// Create Sale from database map
  factory SaleModel.fromDatabase(Map<String, dynamic> map) {
    final sale = _fromMap(map);
    return SaleModel(sale);
  }
  
  static Sale _fromMap(Map<String, dynamic> map) {
    return Sale(
      id: map[DatabaseSchema.id] as String,
      organizationId: map[DatabaseSchema.organizationId] as String,
      branchId: map['branch_id'] as String,
      saleNumber: map['sale_number'] as String,
      customerId: map['customer_id'] as String?,
      saleDate: DateTime.fromMillisecondsSinceEpoch(map['sale_date'] as int),
      subtotal: (map['subtotal'] as num).toDouble(),
      taxAmount: (map['tax_amount'] as num).toDouble(),
      discountAmount: (map['discount_amount'] as num).toDouble(),
      totalAmount: (map['total_amount'] as num).toDouble(),
      paidAmount: (map['paid_amount'] as num).toDouble(),
      changeAmount: (map['change_amount'] as num).toDouble(),
      paymentMethod: _parsePaymentMethod(map['payment_method'] as String?),
      paymentReference: map['payment_reference'] as String?,
      status: _parseSaleStatus(map['status'] as String),
      cashierId: map['cashier_id'] as String?,
      registerId: map['register_id'] as String?,
      notes: map['notes'] as String?,
      items: [], // Items will be loaded separately
      metadata: _decodeMetadata(map[DatabaseSchema.metadata] as String?),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.createdAt] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.updatedAt] as int),
      syncedAt: map[DatabaseSchema.syncedAt] != null
          ? DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.syncedAt] as int)
          : null,
    );
  }
  
  static PaymentMethod? _parsePaymentMethod(String? method) {
    if (method == null) return null;
    try {
      return PaymentMethod.values.firstWhere((e) => e.name == method);
    } catch (_) {
      return null;
    }
  }
  
  static SaleStatus _parseSaleStatus(String status) {
    try {
      return SaleStatus.values.firstWhere((e) => e.name == status);
    } catch (_) {
      return SaleStatus.completed;
    }
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