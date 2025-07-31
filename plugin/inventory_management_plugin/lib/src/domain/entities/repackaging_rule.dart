import 'package:freezed_annotation/freezed_annotation.dart';

part 'repackaging_rule.freezed.dart';
part 'repackaging_rule.g.dart';

enum RepackagingType {
  @JsonValue('split')
  split, // Break down larger units to smaller
  @JsonValue('combine')
  combine, // Combine smaller units to larger
  @JsonValue('transform')
  transform, // Transform one product to another
  @JsonValue('bundle')
  bundle, // Create bundles/kits
  @JsonValue('unbundle')
  unbundle, // Break bundles into components
}

enum RepackagingStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('failed')
  failed,
}

@freezed
class RepackagingRule with _$RepackagingRule {
  const factory RepackagingRule({
    required String id,
    required String organizationId,
    required String fromProductId,
    required String toProductId,
    required double conversionRate,
    String? ruleName,
    @Default(1.0) double conversionFactor,
    @Default(false) bool requiresApproval,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
    
    // Additional fields
    @Default(RepackagingType.transform) RepackagingType type,
    String? fromProductName,
    String? toProductName,
    String? fromUnit,
    String? toUnit,
    double? wastagePercentage,
    double? laborCost,
    double? packagingCost,
    double? otherCosts,
    @Default(0) int processingTimeMinutes,
    String? description,
    String? instructions,
    @Default([]) List<String> requiredTools,
    @Default({}) Map<String, dynamic> qualityChecks,
    @Default(false) bool trackBatches,
    @Default(false) bool maintainSerialNumbers,
    String? categoryId,
    @Default(0) int priority,
    double? minQuantity,
    double? maxQuantity,
    @Default([]) List<RepackagingComponent> additionalComponents,
    String? createdBy,
    @Default({}) Map<String, dynamic> metadata,
  }) = _RepackagingRule;
  
  const RepackagingRule._();
  
  factory RepackagingRule.fromJson(Map<String, dynamic> json) => 
      _$RepackagingRuleFromJson(json);
  
  // Helper methods
  double calculateOutputQuantity(double inputQuantity) {
    final baseOutput = inputQuantity * conversionRate;
    if (wastagePercentage != null && wastagePercentage! > 0) {
      return baseOutput * (1 - wastagePercentage! / 100);
    }
    return baseOutput;
  }
  
  double calculateInputQuantity(double outputQuantity) {
    final baseInput = outputQuantity / conversionRate;
    if (wastagePercentage != null && wastagePercentage! > 0) {
      return baseInput / (1 - wastagePercentage! / 100);
    }
    return baseInput;
  }
  
  double calculateTotalCost(double quantity) {
    double totalCost = 0;
    
    if (laborCost != null) {
      totalCost += laborCost! * quantity;
    }
    
    if (packagingCost != null) {
      totalCost += packagingCost! * quantity;
    }
    
    if (otherCosts != null) {
      totalCost += otherCosts! * quantity;
    }
    
    // Add component costs
    for (final component in additionalComponents) {
      totalCost += component.unitCost * component.quantity * quantity;
    }
    
    return totalCost;
  }
  
  String get name => ruleName ?? '$fromProductName to $toProductName';
  
  String get displayConversionRate {
    if (fromUnit != null && toUnit != null) {
      return '1 $fromUnit = ${conversionRate.toStringAsFixed(2)} $toUnit';
    }
    return '1:${conversionRate.toStringAsFixed(2)}';
  }
  
  bool get hasWastage => wastagePercentage != null && wastagePercentage! > 0;
  bool get hasAdditionalCosts => laborCost != null || packagingCost != null || otherCosts != null;
  bool get hasComponents => additionalComponents.isNotEmpty;
  bool get hasQuantityLimits => minQuantity != null || maxQuantity != null;
  
  bool canProcess(double quantity) {
    if (!isActive) return false;
    if (minQuantity != null && quantity < minQuantity!) return false;
    if (maxQuantity != null && quantity > maxQuantity!) return false;
    return true;
  }
  
  String get typeDisplay {
    switch (type) {
      case RepackagingType.split:
        return 'Split';
      case RepackagingType.combine:
        return 'Combine';
      case RepackagingType.transform:
        return 'Transform';
      case RepackagingType.bundle:
        return 'Bundle';
      case RepackagingType.unbundle:
        return 'Unbundle';
    }
  }
  
  Duration get processingDuration => Duration(minutes: processingTimeMinutes);
}

@freezed
class RepackagingComponent with _$RepackagingComponent {
  const factory RepackagingComponent({
    required String productId,
    required String productName,
    required double quantity,
    @Default(0) double unitCost,
    String? unit,
    String? notes,
  }) = _RepackagingComponent;
  
  const RepackagingComponent._();
  
  factory RepackagingComponent.fromJson(Map<String, dynamic> json) => 
      _$RepackagingComponentFromJson(json);
  
  double get totalCost => quantity * unitCost;
}

@freezed
class RepackagingTransaction with _$RepackagingTransaction {
  const factory RepackagingTransaction({
    required String id,
    required String organizationId,
    required String ruleId,
    required String branchId,
    required double inputQuantity,
    required double outputQuantity,
    required double actualOutputQuantity,
    @Default(RepackagingStatus.pending) RepackagingStatus status,
    DateTime? startedAt,
    DateTime? completedAt,
    String? performedBy,
    String? approvedBy,
    DateTime? approvedAt,
    String? batchId,
    @Default([]) List<String> serialNumbers,
    double? totalCost,
    String? notes,
    @Default({}) Map<String, dynamic> qualityCheckResults,
    String? failureReason,
    required DateTime createdAt,
    DateTime? syncedAt,
  }) = _RepackagingTransaction;
  
  const RepackagingTransaction._();
  
  factory RepackagingTransaction.fromJson(Map<String, dynamic> json) => 
      _$RepackagingTransactionFromJson(json);
  
  // Helper methods
  bool get isPending => status == RepackagingStatus.pending;
  bool get isInProgress => status == RepackagingStatus.inProgress;
  bool get isCompleted => status == RepackagingStatus.completed;
  bool get isCancelled => status == RepackagingStatus.cancelled;
  bool get isFailed => status == RepackagingStatus.failed;
  
  bool get needsApproval => approvedAt == null && approvedBy == null;
  bool get isApproved => approvedAt != null;
  
  double get yieldPercentage {
    if (outputQuantity == 0) return 0;
    return (actualOutputQuantity / outputQuantity) * 100;
  }
  
  double get varianceQuantity => actualOutputQuantity - outputQuantity;
  double get variancePercentage {
    if (outputQuantity == 0) return 0;
    return (varianceQuantity / outputQuantity) * 100;
  }
  
  Duration? get processingTime {
    if (startedAt == null || completedAt == null) return null;
    return completedAt!.difference(startedAt!);
  }
  
  String get statusDisplay {
    switch (status) {
      case RepackagingStatus.pending:
        return 'Pending';
      case RepackagingStatus.inProgress:
        return 'In Progress';
      case RepackagingStatus.completed:
        return 'Completed';
      case RepackagingStatus.cancelled:
        return 'Cancelled';
      case RepackagingStatus.failed:
        return 'Failed';
    }
  }
}