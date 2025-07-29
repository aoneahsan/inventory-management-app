import 'package:equatable/equatable.dart';

class PurchaseOrder extends Equatable {
  final String id;
  final String organizationId;
  final String supplierId;
  final String poNumber;
  final DateTime orderDate;
  final DateTime? expectedDate;
  final String status; // draft, sent, partial, received, cancelled
  final double totalAmount;
  final double taxAmount;
  final double discountAmount;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;
  final List<PurchaseOrderItem> items;

  const PurchaseOrder({
    required this.id,
    required this.organizationId,
    required this.supplierId,
    required this.poNumber,
    required this.orderDate,
    this.expectedDate,
    required this.status,
    required this.totalAmount,
    this.taxAmount = 0,
    this.discountAmount = 0,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    this.items = const [],
  });

  @override
  List<Object?> get props => [
        id,
        organizationId,
        supplierId,
        poNumber,
        orderDate,
        expectedDate,
        status,
        totalAmount,
        taxAmount,
        discountAmount,
        notes,
        createdAt,
        updatedAt,
        createdBy,
        items,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'organization_id': organizationId,
      'supplier_id': supplierId,
      'po_number': poNumber,
      'order_date': orderDate.millisecondsSinceEpoch,
      'expected_date': expectedDate?.millisecondsSinceEpoch,
      'status': status,
      'total_amount': totalAmount,
      'tax_amount': taxAmount,
      'discount_amount': discountAmount,
      'notes': notes,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'created_by': createdBy,
    };
  }

  factory PurchaseOrder.fromMap(Map<String, dynamic> map) {
    return PurchaseOrder(
      id: map['id'] as String,
      organizationId: map['organization_id'] as String,
      supplierId: map['supplier_id'] as String,
      poNumber: map['po_number'] as String,
      orderDate: DateTime.fromMillisecondsSinceEpoch(map['order_date'] as int),
      expectedDate: map['expected_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['expected_date'] as int)
          : null,
      status: map['status'] as String,
      totalAmount: (map['total_amount'] ?? 0).toDouble(),
      taxAmount: (map['tax_amount'] ?? 0).toDouble(),
      discountAmount: (map['discount_amount'] ?? 0).toDouble(),
      notes: map['notes'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
      createdBy: map['created_by'] as String,
    );
  }

  PurchaseOrder copyWith({
    String? id,
    String? organizationId,
    String? supplierId,
    String? poNumber,
    DateTime? orderDate,
    DateTime? expectedDate,
    String? status,
    double? totalAmount,
    double? taxAmount,
    double? discountAmount,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    List<PurchaseOrderItem>? items,
  }) {
    return PurchaseOrder(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      supplierId: supplierId ?? this.supplierId,
      poNumber: poNumber ?? this.poNumber,
      orderDate: orderDate ?? this.orderDate,
      expectedDate: expectedDate ?? this.expectedDate,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      items: items ?? this.items,
    );
  }

  // Helper methods
  double get subtotal => totalAmount - taxAmount + discountAmount;
  
  bool get isDraft => status == 'draft';
  bool get isSent => status == 'sent';
  bool get isPartiallyReceived => status == 'partial';
  bool get isFullyReceived => status == 'received';
  bool get isCancelled => status == 'cancelled';

  bool get canEdit => isDraft;
  bool get canSend => isDraft;
  bool get canReceive => isSent || isPartiallyReceived;
  bool get canCancel => !isFullyReceived && !isCancelled;

  double get totalReceivedQuantity {
    return items.fold(0, (sum, item) => sum + item.receivedQuantity);
  }

  double get totalOrderedQuantity {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  double get receivePercentage {
    if (totalOrderedQuantity == 0) return 0;
    return (totalReceivedQuantity / totalOrderedQuantity) * 100;
  }
}

class PurchaseOrderItem extends Equatable {
  final String id;
  final String purchaseOrderId;
  final String productId;
  final double quantity;
  final double receivedQuantity;
  final double unitPrice;
  final double taxRate;
  final double discountRate;
  final double totalAmount;
  final DateTime createdAt;

  const PurchaseOrderItem({
    required this.id,
    required this.purchaseOrderId,
    required this.productId,
    required this.quantity,
    this.receivedQuantity = 0,
    required this.unitPrice,
    this.taxRate = 0,
    this.discountRate = 0,
    required this.totalAmount,
    required this.createdAt,
  });

  @override
  List<Object> get props => [
        id,
        purchaseOrderId,
        productId,
        quantity,
        receivedQuantity,
        unitPrice,
        taxRate,
        discountRate,
        totalAmount,
        createdAt,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'purchase_order_id': purchaseOrderId,
      'product_id': productId,
      'quantity': quantity,
      'received_quantity': receivedQuantity,
      'unit_price': unitPrice,
      'tax_rate': taxRate,
      'discount_rate': discountRate,
      'total_amount': totalAmount,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  factory PurchaseOrderItem.fromMap(Map<String, dynamic> map) {
    return PurchaseOrderItem(
      id: map['id'] as String,
      purchaseOrderId: map['purchase_order_id'] as String,
      productId: map['product_id'] as String,
      quantity: (map['quantity'] ?? 0).toDouble(),
      receivedQuantity: (map['received_quantity'] ?? 0).toDouble(),
      unitPrice: (map['unit_price'] ?? 0).toDouble(),
      taxRate: (map['tax_rate'] ?? 0).toDouble(),
      discountRate: (map['discount_rate'] ?? 0).toDouble(),
      totalAmount: (map['total_amount'] ?? 0).toDouble(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
    );
  }

  PurchaseOrderItem copyWith({
    String? id,
    String? purchaseOrderId,
    String? productId,
    double? quantity,
    double? receivedQuantity,
    double? unitPrice,
    double? taxRate,
    double? discountRate,
    double? totalAmount,
    DateTime? createdAt,
  }) {
    return PurchaseOrderItem(
      id: id ?? this.id,
      purchaseOrderId: purchaseOrderId ?? this.purchaseOrderId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      receivedQuantity: receivedQuantity ?? this.receivedQuantity,
      unitPrice: unitPrice ?? this.unitPrice,
      taxRate: taxRate ?? this.taxRate,
      discountRate: discountRate ?? this.discountRate,
      totalAmount: totalAmount ?? this.totalAmount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Helper methods
  double get subtotal => quantity * unitPrice;
  double get discountAmount => subtotal * (discountRate / 100);
  double get taxableAmount => subtotal - discountAmount;
  double get taxAmount => taxableAmount * (taxRate / 100);
  double get calculatedTotal => taxableAmount + taxAmount;
  
  double get remainingQuantity => quantity - receivedQuantity;
  bool get isFullyReceived => receivedQuantity >= quantity;
  bool get isPartiallyReceived => receivedQuantity > 0 && receivedQuantity < quantity;
  double get receivePercentage => quantity > 0 ? (receivedQuantity / quantity) * 100 : 0;
}