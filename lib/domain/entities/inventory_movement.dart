import 'package:equatable/equatable.dart';

enum MovementType {
  purchase,     // Stock purchased from supplier
  sale,         // Stock sold to customer
  adjustment,   // Manual adjustment
  transfer,     // Transfer between warehouses
  return_,      // Return from customer
  damage,       // Damaged goods
  expired,      // Expired products
  in_,          // Stock in (alias for purchase)
  out,          // Stock out (alias for sale)
}

class InventoryMovement extends Equatable {
  final String id;
  final String organizationId;
  final String productId;
  final MovementType type;
  final double quantity;
  final double? unitCost;
  final double? totalCost;
  final String? reason;
  final String? referenceNumber;
  final String? referenceId;
  final String? referenceType;
  final String? fromWarehouse;
  final String? toWarehouse;
  final String performedBy;
  final String? notes;
  final DateTime createdAt;

  const InventoryMovement({
    required this.id,
    required this.organizationId,
    required this.productId,
    required this.type,
    required this.quantity,
    this.unitCost,
    this.totalCost,
    this.reason,
    this.referenceNumber,
    this.referenceId,
    this.referenceType,
    this.fromWarehouse,
    this.toWarehouse,
    required this.performedBy,
    this.notes,
    required this.createdAt,
  });

  bool get isIncoming => type == MovementType.purchase || type == MovementType.return_;
  bool get isOutgoing => type == MovementType.sale || type == MovementType.damage || type == MovementType.expired;
  bool get isTransfer => type == MovementType.transfer;
  bool get isAdjustment => type == MovementType.adjustment;

  String get typeDisplayName {
    switch (type) {
      case MovementType.purchase:
        return 'Purchase';
      case MovementType.sale:
        return 'Sale';
      case MovementType.adjustment:
        return 'Adjustment';
      case MovementType.transfer:
        return 'Transfer';
      case MovementType.return_:
        return 'Return';
      case MovementType.damage:
        return 'Damage';
      case MovementType.expired:
        return 'Expired';
      case MovementType.in_:
        return 'Stock In';
      case MovementType.out:
        return 'Stock Out';
    }
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organization_id': organizationId,
      'product_id': productId,
      'type': type.name == 'return_' ? 'return' : type.name.toUpperCase(),
      'quantity': quantity,
      'unit_cost': unitCost,
      'total_cost': totalCost,
      'reason': reason,
      'reference_number': referenceNumber,
      'reference_id': referenceId,
      'reference_type': referenceType,
      'from_warehouse': fromWarehouse,
      'to_warehouse': toWarehouse,
      'performed_by': performedBy,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory InventoryMovement.fromJson(Map<String, dynamic> json) {
    final typeStr = (json['type'] as String).toLowerCase();
    MovementType type;
    switch (typeStr) {
      case 'purchase':
        type = MovementType.purchase;
        break;
      case 'sale':
        type = MovementType.sale;
        break;
      case 'adjustment':
        type = MovementType.adjustment;
        break;
      case 'transfer':
        type = MovementType.transfer;
        break;
      case 'return':
        type = MovementType.return_;
        break;
      case 'damage':
        type = MovementType.damage;
        break;
      case 'expired':
        type = MovementType.expired;
        break;
      case 'in':
      case 'in_':
        type = MovementType.in_;
        break;
      case 'out':
        type = MovementType.out;
        break;
      default:
        type = MovementType.adjustment;
    }

    return InventoryMovement(
      id: json['id'] as String,
      organizationId: json['organization_id'] as String,
      productId: json['product_id'] as String,
      type: type,
      quantity: (json['quantity'] as num).toDouble(),
      unitCost: (json['unit_cost'] as num?)?.toDouble(),
      totalCost: (json['total_cost'] as num?)?.toDouble(),
      reason: json['reason'] as String?,
      referenceNumber: json['reference_number'] as String?,
      referenceId: json['reference_id'] as String?,
      referenceType: json['reference_type'] as String?,
      fromWarehouse: json['from_warehouse'] as String?,
      toWarehouse: json['to_warehouse'] as String?,
      performedBy: json['performed_by'] as String,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  @override
  List<Object?> get props => [
        id,
        organizationId,
        productId,
        type,
        quantity,
        unitCost,
        totalCost,
        reason,
        referenceNumber,
        referenceId,
        referenceType,
        fromWarehouse,
        toWarehouse,
        performedBy,
        notes,
        createdAt,
      ];
}