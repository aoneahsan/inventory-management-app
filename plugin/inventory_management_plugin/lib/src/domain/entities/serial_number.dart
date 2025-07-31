import 'package:freezed_annotation/freezed_annotation.dart';

part 'serial_number.freezed.dart';
part 'serial_number.g.dart';

enum SerialStatus {
  @JsonValue('available')
  available,
  @JsonValue('sold')
  sold,
  @JsonValue('returned')
  returned,
  @JsonValue('damaged')
  damaged,
  @JsonValue('lost')
  lost,
  @JsonValue('in_transit')
  inTransit,
  @JsonValue('reserved')
  reserved,
  @JsonValue('under_repair')
  underRepair,
}

@freezed
class SerialNumber with _$SerialNumber {
  const factory SerialNumber({
    required String id,
    required String organizationId,
    required String productId,
    required String serialNumber,
    String? batchId,
    required SerialStatus status,
    String? branchId,
    DateTime? purchaseDate,
    double? purchasePrice,
    String? purchaseOrderId,
    String? supplierId,
    String? saleId,
    String? customerId,
    DateTime? saleDate,
    double? salePrice,
    DateTime? warrantyEndDate,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
    
    // Additional tracking fields
    String? currentLocation,
    @Default([]) List<SerialMovement> movements,
    @Default({}) Map<String, dynamic> metadata,
    String? lastScannedBy,
    DateTime? lastScannedAt,
    @Default({}) Map<String, dynamic> customFields,
    String? returnReason,
    DateTime? returnDate,
    String? repairNotes,
    double? repairCost,
  }) = _SerialNumber;
  
  const SerialNumber._();
  
  factory SerialNumber.fromJson(Map<String, dynamic> json) => 
      _$SerialNumberFromJson(json);
  
  // Helper methods
  bool get isAvailable => status == SerialStatus.available;
  bool get isSold => status == SerialStatus.sold;
  bool get isReturned => status == SerialStatus.returned;
  bool get isDamaged => status == SerialStatus.damaged;
  bool get isLost => status == SerialStatus.lost;
  bool get isInTransit => status == SerialStatus.inTransit;
  bool get isReserved => status == SerialStatus.reserved;
  bool get isUnderRepair => status == SerialStatus.underRepair;
  
  bool get isInWarranty {
    return warrantyEndDate != null && warrantyEndDate!.isAfter(DateTime.now());
  }
  
  int get warrantyDaysRemaining {
    if (warrantyEndDate == null) return 0;
    final diff = warrantyEndDate!.difference(DateTime.now()).inDays;
    return diff > 0 ? diff : 0;
  }
  
  bool get canBeSold => isAvailable && branchId != null;
  bool get canBeReturned => isSold && saleId != null;
  bool get canBeTransferred => isAvailable || isReserved;
  
  String get statusDisplayName {
    switch (status) {
      case SerialStatus.available:
        return 'Available';
      case SerialStatus.sold:
        return 'Sold';
      case SerialStatus.returned:
        return 'Returned';
      case SerialStatus.damaged:
        return 'Damaged';
      case SerialStatus.lost:
        return 'Lost';
      case SerialStatus.inTransit:
        return 'In Transit';
      case SerialStatus.reserved:
        return 'Reserved';
      case SerialStatus.underRepair:
        return 'Under Repair';
    }
  }
  
  double get profitMargin {
    if (purchasePrice == null || salePrice == null || purchasePrice == 0) return 0;
    return ((salePrice! - purchasePrice!) / purchasePrice!) * 100;
  }
  
  int get ageInDays {
    final startDate = purchaseDate ?? createdAt;
    return DateTime.now().difference(startDate).inDays;
  }
}

@freezed
class SerialMovement with _$SerialMovement {
  const factory SerialMovement({
    required String id,
    required String serialNumberId,
    required String movementType,
    String? fromLocation,
    String? toLocation,
    String? fromBranchId,
    String? toBranchId,
    required String performedBy,
    String? notes,
    required DateTime timestamp,
    @Default({}) Map<String, dynamic> metadata,
  }) = _SerialMovement;
  
  factory SerialMovement.fromJson(Map<String, dynamic> json) => 
      _$SerialMovementFromJson(json);
}