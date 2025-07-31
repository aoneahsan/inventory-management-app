import 'package:freezed_annotation/freezed_annotation.dart';

part 'batch.freezed.dart';
part 'batch.g.dart';

@freezed
class Batch with _$Batch {
  const factory Batch({
    required String id,
    required String organizationId,
    required String productId,
    required String batchNumber,
    DateTime? manufacturingDate,
    DateTime? expiryDate,
    String? supplierId,
    double? costPrice,
    @Default(0) double currentQuantity,
    @Default(0) double initialQuantity,
    String? branchId,
    @Default('active') String status,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
    
    // Additional fields for enhanced tracking
    String? purchaseOrderId,
    String? warehouseLocation,
    @Default({}) Map<String, dynamic> metadata,
    @Default([]) List<String> tags,
    double? sellingPrice,
    String? qualityStatus, // passed, rejected, pending
    Map<String, dynamic>? testResults,
  }) = _Batch;
  
  const Batch._();
  
  factory Batch.fromJson(Map<String, dynamic> json) => _$BatchFromJson(json);
  
  // Helper methods
  bool get isExpired {
    return expiryDate != null && expiryDate!.isBefore(DateTime.now());
  }
  
  bool get isNearExpiry {
    if (expiryDate == null) return false;
    final daysUntilExpiry = expiryDate!.difference(DateTime.now()).inDays;
    return daysUntilExpiry > 0 && daysUntilExpiry <= 30;
  }
  
  int get daysUntilExpiry {
    if (expiryDate == null) return -1;
    return expiryDate!.difference(DateTime.now()).inDays;
  }
  
  double get usedQuantity => initialQuantity - currentQuantity;
  
  double get usagePercentage {
    if (initialQuantity == 0) return 0;
    return (usedQuantity / initialQuantity) * 100;
  }
  
  double get availablePercentage {
    if (initialQuantity == 0) return 0;
    return (currentQuantity / initialQuantity) * 100;
  }
  
  bool get isEmpty => currentQuantity <= 0;
  
  bool get isLowStock {
    // Consider batch low stock if less than 20% remaining
    return availablePercentage < 20 && !isEmpty;
  }
  
  double get totalValue {
    return currentQuantity * (costPrice ?? 0);
  }
}