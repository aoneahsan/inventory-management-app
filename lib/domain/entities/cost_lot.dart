import 'package:equatable/equatable.dart';

class CostLot extends Equatable {
  final String id;
  final String organizationId;
  final String productId;
  final String? branchId;
  final String lotNumber;
  final DateTime purchaseDate;
  final double quantity;
  final double remainingQuantity;
  final double unitCost;
  final String? supplierId;
  final String? purchaseOrderId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CostLot({
    required this.id,
    required this.organizationId,
    required this.productId,
    this.branchId,
    required this.lotNumber,
    required this.purchaseDate,
    required this.quantity,
    required this.remainingQuantity,
    required this.unitCost,
    this.supplierId,
    this.purchaseOrderId,
    required this.createdAt,
    required this.updatedAt,
  });

  CostLot copyWith({
    String? id,
    String? organizationId,
    String? productId,
    String? branchId,
    String? lotNumber,
    DateTime? purchaseDate,
    double? quantity,
    double? remainingQuantity,
    double? unitCost,
    String? supplierId,
    String? purchaseOrderId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CostLot(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      productId: productId ?? this.productId,
      branchId: branchId ?? this.branchId,
      lotNumber: lotNumber ?? this.lotNumber,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      quantity: quantity ?? this.quantity,
      remainingQuantity: remainingQuantity ?? this.remainingQuantity,
      unitCost: unitCost ?? this.unitCost,
      supplierId: supplierId ?? this.supplierId,
      purchaseOrderId: purchaseOrderId ?? this.purchaseOrderId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'organization_id': organizationId,
      'product_id': productId,
      'branch_id': branchId,
      'lot_number': lotNumber,
      'purchase_date': purchaseDate.millisecondsSinceEpoch,
      'quantity': quantity,
      'remaining_quantity': remainingQuantity,
      'unit_cost': unitCost,
      'supplier_id': supplierId,
      'purchase_order_id': purchaseOrderId,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory CostLot.fromMap(Map<String, dynamic> map) {
    return CostLot(
      id: map['id'],
      organizationId: map['organization_id'],
      productId: map['product_id'],
      branchId: map['branch_id'],
      lotNumber: map['lot_number'],
      purchaseDate: DateTime.fromMillisecondsSinceEpoch(map['purchase_date']),
      quantity: map['quantity']?.toDouble() ?? 0.0,
      remainingQuantity: map['remaining_quantity']?.toDouble() ?? 0.0,
      unitCost: map['unit_cost']?.toDouble() ?? 0.0,
      supplierId: map['supplier_id'],
      purchaseOrderId: map['purchase_order_id'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  double get usedQuantity => quantity - remainingQuantity;
  double get totalCost => quantity * unitCost;
  double get remainingValue => remainingQuantity * unitCost;
  bool get isFullyConsumed => remainingQuantity == 0;
  double get consumptionPercentage => (usedQuantity / quantity) * 100;

  @override
  List<Object?> get props => [
        id,
        organizationId,
        productId,
        branchId,
        lotNumber,
        purchaseDate,
        quantity,
        remainingQuantity,
        unitCost,
        supplierId,
        purchaseOrderId,
        createdAt,
        updatedAt,
      ];
}