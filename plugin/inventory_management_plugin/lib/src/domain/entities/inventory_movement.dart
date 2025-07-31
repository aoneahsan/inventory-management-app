import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_movement.freezed.dart';
part 'inventory_movement.g.dart';

enum MovementType {
  @JsonValue('purchase')
  purchase,
  @JsonValue('sale')
  sale,
  @JsonValue('adjustment')
  adjustment,
  @JsonValue('transfer')
  transfer,
  @JsonValue('return')
  return_,
  @JsonValue('damage')
  damage,
  @JsonValue('expired')
  expired,
  @JsonValue('production_in')
  productionIn,
  @JsonValue('production_out')
  productionOut,
  @JsonValue('stock_take')
  stockTake,
  @JsonValue('repackaging_in')
  repackagingIn,
  @JsonValue('repackaging_out')
  repackagingOut,
}

@freezed
class InventoryMovement with _$InventoryMovement {
  const factory InventoryMovement({
    required String id,
    required String organizationId,
    required String productId,
    required MovementType type,
    required double quantity,
    double? unitCost,
    double? totalCost,
    String? reason,
    String? referenceNumber,
    String? referenceId,
    String? referenceType,
    String? fromBranchId,
    String? toBranchId,
    String? fromLocation,
    String? toLocation,
    required String performedBy,
    String? notes,
    required DateTime createdAt,
    DateTime? syncedAt,
    
    // Additional tracking fields
    String? batchId,
    String? serialNumber,
    @Default('pending') String status,
    String? approvedBy,
    DateTime? approvedAt,
    @Default({}) Map<String, dynamic> metadata,
    double? stockBefore,
    double? stockAfter,
    String? supplierId,
    String? customerId,
  }) = _InventoryMovement;
  
  const InventoryMovement._();
  
  factory InventoryMovement.fromJson(Map<String, dynamic> json) => 
      _$InventoryMovementFromJson(json);
  
  // Helper methods
  bool get isIncoming => 
      type == MovementType.purchase || 
      type == MovementType.return_ ||
      type == MovementType.productionIn ||
      type == MovementType.repackagingIn ||
      (type == MovementType.adjustment && quantity > 0);
      
  bool get isOutgoing => 
      type == MovementType.sale || 
      type == MovementType.damage || 
      type == MovementType.expired ||
      type == MovementType.productionOut ||
      type == MovementType.repackagingOut ||
      (type == MovementType.adjustment && quantity < 0);
      
  bool get isTransfer => type == MovementType.transfer;
  bool get isAdjustment => type == MovementType.adjustment;
  bool get needsApproval => status == 'pending' && (type == MovementType.adjustment || type == MovementType.damage);
  bool get isApproved => status == 'approved';
  
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
      case MovementType.productionIn:
        return 'Production In';
      case MovementType.productionOut:
        return 'Production Out';
      case MovementType.stockTake:
        return 'Stock Take';
      case MovementType.repackagingIn:
        return 'Repackaging In';
      case MovementType.repackagingOut:
        return 'Repackaging Out';
    }
  }
  
  double get effectiveQuantity {
    if (isIncoming) return quantity.abs();
    if (isOutgoing) return -quantity.abs();
    return quantity;
  }
  
  double get stockChange {
    if (type == MovementType.transfer) return 0;
    return effectiveQuantity;
  }
}