import 'dart:convert';

import '../../domain/entities/purchase_order.dart';
import '../database/database_schema.dart';
import 'base_model.dart';

/// Database model for PurchaseOrder entity
class PurchaseOrderModel extends BaseModel {
  final PurchaseOrder purchaseOrder;
  
  PurchaseOrderModel(this.purchaseOrder);
  
  @override
  String get tableName => DatabaseSchema.purchaseOrdersTable;
  
  @override
  Map<String, dynamic> toDatabase() {
    return {
      DatabaseSchema.id: purchaseOrder.id,
      DatabaseSchema.organizationId: purchaseOrder.organizationId,
      'supplier_id': purchaseOrder.supplierId,
      'po_number': purchaseOrder.poNumber,
      'order_date': dateTimeToMillis(purchaseOrder.orderDate),
      'expected_delivery_date': dateTimeToMillis(purchaseOrder.expectedDeliveryDate),
      'branch_id': purchaseOrder.branchId,
      'status': purchaseOrder.status.name,
      'subtotal': purchaseOrder.subtotal,
      'tax_amount': purchaseOrder.taxAmount,
      'shipping_amount': purchaseOrder.shippingAmount,
      'discount_amount': purchaseOrder.discountAmount,
      'total_amount': purchaseOrder.totalAmount,
      'notes': purchaseOrder.notes,
      'payment_terms': purchaseOrder.paymentTerms,
      'shipping_address': purchaseOrder.shippingAddress,
      'billing_address': purchaseOrder.billingAddress,
      'approved_by': purchaseOrder.approvedBy,
      'approved_at': dateTimeToMillis(purchaseOrder.approvedAt),
      'received_by': purchaseOrder.receivedBy,
      'received_at': dateTimeToMillis(purchaseOrder.receivedAt),
      DatabaseSchema.metadata: encodeMetadata(purchaseOrder.metadata),
      DatabaseSchema.createdAt: dateTimeToMillis(purchaseOrder.createdAt),
      DatabaseSchema.updatedAt: dateTimeToMillis(purchaseOrder.updatedAt),
      DatabaseSchema.syncedAt: dateTimeToMillis(purchaseOrder.syncedAt),
    };
  }
  
  /// Create PurchaseOrder from database map
  factory PurchaseOrderModel.fromDatabase(Map<String, dynamic> map) {
    final purchaseOrder = _fromMap(map);
    return PurchaseOrderModel(purchaseOrder);
  }
  
  static PurchaseOrder _fromMap(Map<String, dynamic> map) {
    return PurchaseOrder(
      id: map[DatabaseSchema.id] as String,
      organizationId: map[DatabaseSchema.organizationId] as String,
      supplierId: map['supplier_id'] as String,
      poNumber: map['po_number'] as String,
      orderDate: DateTime.fromMillisecondsSinceEpoch(map['order_date'] as int),
      expectedDeliveryDate: map['expected_delivery_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['expected_delivery_date'] as int)
          : null,
      branchId: map['branch_id'] as String,
      status: _parsePOStatus(map['status'] as String),
      subtotal: (map['subtotal'] as num).toDouble(),
      taxAmount: (map['tax_amount'] as num).toDouble(),
      shippingAmount: (map['shipping_amount'] as num?)?.toDouble() ?? 0,
      discountAmount: (map['discount_amount'] as num?)?.toDouble() ?? 0,
      totalAmount: (map['total_amount'] as num).toDouble(),
      notes: map['notes'] as String?,
      paymentTerms: map['payment_terms'] as String?,
      shippingAddress: map['shipping_address'] as String?,
      billingAddress: map['billing_address'] as String?,
      items: [], // Items will be loaded separately
      approvedBy: map['approved_by'] as String?,
      approvedAt: map['approved_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['approved_at'] as int)
          : null,
      receivedBy: map['received_by'] as String?,
      receivedAt: map['received_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['received_at'] as int)
          : null,
      metadata: _decodeMetadata(map[DatabaseSchema.metadata] as String?),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.createdAt] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.updatedAt] as int),
      syncedAt: map[DatabaseSchema.syncedAt] != null
          ? DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.syncedAt] as int)
          : null,
    );
  }
  
  static PurchaseOrderStatus _parsePOStatus(String status) {
    try {
      return PurchaseOrderStatus.values.firstWhere((e) => e.name == status);
    } catch (_) {
      return PurchaseOrderStatus.draft;
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