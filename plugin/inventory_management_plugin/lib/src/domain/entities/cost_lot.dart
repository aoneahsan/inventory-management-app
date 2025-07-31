import 'package:freezed_annotation/freezed_annotation.dart';

part 'cost_lot.freezed.dart';
part 'cost_lot.g.dart';

enum CostingMethod {
  @JsonValue('fifo')
  fifo,
  @JsonValue('lifo')
  lifo,
  @JsonValue('average')
  average,
  @JsonValue('specific')
  specific,
}

enum LotStatus {
  @JsonValue('active')
  active,
  @JsonValue('consumed')
  consumed,
  @JsonValue('expired')
  expired,
  @JsonValue('damaged')
  damaged,
  @JsonValue('returned')
  returned,
}

@freezed
class CostLot with _$CostLot {
  const factory CostLot({
    required String id,
    required String organizationId,
    required String productId,
    String? branchId,
    required String lotNumber,
    required DateTime purchaseDate,
    required double quantity,
    required double remainingQuantity,
    required double unitCost,
    String? supplierId,
    String? purchaseOrderId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
    
    // Additional fields
    String? batchId,
    DateTime? expiryDate,
    @Default(LotStatus.active) LotStatus status,
    String? warehouseLocation,
    double? landedCost,
    @Default({}) Map<String, double> additionalCosts,
    String? currency,
    double? exchangeRate,
    String? invoiceNumber,
    DateTime? receivedDate,
    String? receivedBy,
    @Default({}) Map<String, dynamic> metadata,
    double? taxAmount,
    double? discountAmount,
    String? notes,
    @Default([]) List<CostLotMovement> movements,
  }) = _CostLot;
  
  const CostLot._();
  
  factory CostLot.fromJson(Map<String, dynamic> json) => 
      _$CostLotFromJson(json);
  
  // Helper methods
  double get usedQuantity => quantity - remainingQuantity;
  double get totalCost => quantity * unitCost;
  double get remainingValue => remainingQuantity * unitCost;
  double get usedValue => usedQuantity * unitCost;
  bool get isFullyConsumed => remainingQuantity <= 0;
  double get consumptionPercentage => quantity > 0 ? (usedQuantity / quantity) * 100 : 0;
  
  double get effectiveUnitCost => landedCost ?? unitCost;
  double get totalLandedCost => quantity * effectiveUnitCost;
  double get remainingLandedValue => remainingQuantity * effectiveUnitCost;
  
  bool get isExpired => expiryDate != null && expiryDate!.isBefore(DateTime.now());
  bool get isExpiringSoon {
    if (expiryDate == null) return false;
    final daysUntilExpiry = expiryDate!.difference(DateTime.now()).inDays;
    return daysUntilExpiry > 0 && daysUntilExpiry <= 30;
  }
  
  int get daysUntilExpiry {
    if (expiryDate == null) return -1;
    return expiryDate!.difference(DateTime.now()).inDays;
  }
  
  int get ageInDays => DateTime.now().difference(purchaseDate).inDays;
  
  bool get isOld => ageInDays > 180; // Over 6 months old
  
  double get totalAdditionalCosts {
    return additionalCosts.values.fold(0.0, (sum, cost) => sum + cost);
  }
  
  double get actualUnitCost {
    final baseCost = unitCost;
    final additionalPerUnit = quantity > 0 ? totalAdditionalCosts / quantity : 0;
    final taxPerUnit = quantity > 0 ? (taxAmount ?? 0) / quantity : 0;
    final discountPerUnit = quantity > 0 ? (discountAmount ?? 0) / quantity : 0;
    return baseCost + additionalPerUnit + taxPerUnit - discountPerUnit;
  }
  
  bool canConsume(double requestedQuantity) {
    return status == LotStatus.active && 
           remainingQuantity >= requestedQuantity &&
           !isExpired;
  }
  
  String get displayStatus {
    if (isExpired) return 'Expired';
    if (isFullyConsumed) return 'Consumed';
    return status.name.toUpperCase();
  }
  
  Map<String, dynamic> getCostBreakdown() {
    return {
      'baseCost': unitCost * quantity,
      'additionalCosts': totalAdditionalCosts,
      'taxAmount': taxAmount ?? 0,
      'discountAmount': discountAmount ?? 0,
      'totalCost': totalLandedCost,
      'effectiveUnitCost': effectiveUnitCost,
    };
  }
}

@freezed
class CostLotMovement with _$CostLotMovement {
  const factory CostLotMovement({
    required String id,
    required String costLotId,
    required String movementType,
    required double quantity,
    required DateTime movementDate,
    String? referenceId,
    String? referenceType,
    String? notes,
    required DateTime createdAt,
  }) = _CostLotMovement;
  
  factory CostLotMovement.fromJson(Map<String, dynamic> json) => 
      _$CostLotMovementFromJson(json);
}

// FIFO/LIFO cost calculation helper
class CostCalculator {
  static List<CostLotAllocation> allocateCost({
    required List<CostLot> availableLots,
    required double requestedQuantity,
    required CostingMethod method,
  }) {
    final allocations = <CostLotAllocation>[];
    double remainingQuantity = requestedQuantity;
    
    // Sort lots based on costing method
    final sortedLots = List<CostLot>.from(availableLots);
    switch (method) {
      case CostingMethod.fifo:
        sortedLots.sort((a, b) => a.purchaseDate.compareTo(b.purchaseDate));
        break;
      case CostingMethod.lifo:
        sortedLots.sort((a, b) => b.purchaseDate.compareTo(a.purchaseDate));
        break;
      case CostingMethod.average:
        // For average cost, we don't need to sort
        break;
      case CostingMethod.specific:
        // Specific identification requires manual selection
        break;
    }
    
    if (method == CostingMethod.average) {
      // Calculate weighted average cost
      double totalValue = 0;
      double totalQuantity = 0;
      for (final lot in sortedLots) {
        if (lot.canConsume(0.01)) { // Check if lot is available
          totalValue += lot.remainingQuantity * lot.effectiveUnitCost;
          totalQuantity += lot.remainingQuantity;
        }
      }
      
      if (totalQuantity > 0) {
        final averageCost = totalValue / totalQuantity;
        final quantityToAllocate = requestedQuantity.clamp(0, totalQuantity);
        
        // Create a virtual allocation for average cost
        allocations.add(CostLotAllocation(
          costLotId: 'average',
          quantity: quantityToAllocate,
          unitCost: averageCost,
          totalCost: quantityToAllocate * averageCost,
        ));
      }
    } else {
      // FIFO/LIFO allocation
      for (final lot in sortedLots) {
        if (remainingQuantity <= 0) break;
        if (!lot.canConsume(0.01)) continue;
        
        final quantityToAllocate = remainingQuantity.clamp(0, lot.remainingQuantity);
        if (quantityToAllocate > 0) {
          allocations.add(CostLotAllocation(
            costLotId: lot.id,
            quantity: quantityToAllocate,
            unitCost: lot.effectiveUnitCost,
            totalCost: quantityToAllocate * lot.effectiveUnitCost,
          ));
          remainingQuantity -= quantityToAllocate;
        }
      }
    }
    
    return allocations;
  }
}

@freezed
class CostLotAllocation with _$CostLotAllocation {
  const factory CostLotAllocation({
    required String costLotId,
    required double quantity,
    required double unitCost,
    required double totalCost,
  }) = _CostLotAllocation;
  
  factory CostLotAllocation.fromJson(Map<String, dynamic> json) => 
      _$CostLotAllocationFromJson(json);
}