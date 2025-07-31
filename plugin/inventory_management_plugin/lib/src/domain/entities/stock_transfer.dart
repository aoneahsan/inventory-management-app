import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_transfer.freezed.dart';
part 'stock_transfer.g.dart';

enum TransferStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('pending')
  pending,
  @JsonValue('approved')
  approved,
  @JsonValue('in_transit')
  inTransit,
  @JsonValue('partial')
  partial,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('rejected')
  rejected,
}

enum TransferItemStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('approved')
  approved,
  @JsonValue('rejected')
  rejected,
  @JsonValue('partial')
  partial,
  @JsonValue('received')
  received,
  @JsonValue('damaged')
  damaged,
  @JsonValue('lost')
  lost,
}

@freezed
class StockTransfer with _$StockTransfer {
  const factory StockTransfer({
    required String id,
    required String organizationId,
    required String transferNumber,
    required String fromBranchId,
    required String toBranchId,
    required TransferStatus status,
    required DateTime transferDate,
    DateTime? expectedDate,
    DateTime? completedDate,
    @Default(0) int totalItems,
    @Default(0) double totalQuantity,
    @Default(0) double totalValue,
    String? notes,
    required String createdBy,
    String? approvedBy,
    DateTime? approvedAt,
    String? receivedBy,
    DateTime? receivedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<StockTransferItem> items,
    DateTime? syncedAt,
    
    // Additional fields
    String? transportMode,
    String? transporterName,
    String? trackingNumber,
    String? vehicleNumber,
    String? driverName,
    String? driverContact,
    @Default({}) Map<String, dynamic> metadata,
    @Default({}) Map<String, dynamic> customFields,
    String? rejectionReason,
    DateTime? rejectedAt,
    String? rejectedBy,
  }) = _StockTransfer;
  
  const StockTransfer._();
  
  factory StockTransfer.fromJson(Map<String, dynamic> json) => 
      _$StockTransferFromJson(json);
  
  // Helper methods
  bool get isDraft => status == TransferStatus.draft;
  bool get isPending => status == TransferStatus.pending;
  bool get isApproved => status == TransferStatus.approved;
  bool get isInTransit => status == TransferStatus.inTransit;
  bool get isPartial => status == TransferStatus.partial;
  bool get isCompleted => status == TransferStatus.completed;
  bool get isCancelled => status == TransferStatus.cancelled;
  bool get isRejected => status == TransferStatus.rejected;
  
  bool get canEdit => isDraft || isPending;
  bool get canApprove => isPending;
  bool get canReject => isPending;
  bool get canStartTransit => isApproved;
  bool get canReceive => isInTransit || isPartial;
  bool get canCancel => !isCompleted && !isCancelled && !isRejected;
  
  double get totalReceivedQuantity => 
      items.fold(0, (sum, item) => sum + item.receivedQuantity);
      
  double get totalTransferredQuantity => 
      items.fold(0, (sum, item) => sum + item.quantity);
      
  double get receivePercentage {
    if (totalTransferredQuantity == 0) return 0;
    return (totalReceivedQuantity / totalTransferredQuantity) * 100;
  }
  
  int get daysInTransit {
    if (transferDate == null || !isInTransit) return 0;
    return DateTime.now().difference(transferDate).inDays;
  }
  
  bool get isOverdue {
    if (expectedDate == null || isCompleted) return false;
    return DateTime.now().isAfter(expectedDate!);
  }
  
  int get daysOverdue {
    if (!isOverdue || expectedDate == null) return 0;
    return DateTime.now().difference(expectedDate!).inDays;
  }
  
  String get statusDisplayName {
    switch (status) {
      case TransferStatus.draft:
        return 'Draft';
      case TransferStatus.pending:
        return 'Pending Approval';
      case TransferStatus.approved:
        return 'Approved';
      case TransferStatus.inTransit:
        return 'In Transit';
      case TransferStatus.partial:
        return 'Partially Received';
      case TransferStatus.completed:
        return 'Completed';
      case TransferStatus.cancelled:
        return 'Cancelled';
      case TransferStatus.rejected:
        return 'Rejected';
    }
  }
}

@freezed
class StockTransferItem with _$StockTransferItem {
  const factory StockTransferItem({
    required String id,
    required String transferId,
    required String productId,
    required double quantity,
    @Default(0) double receivedQuantity,
    @Default(0) double damagedQuantity,
    @Default(0) double lostQuantity,
    double? unitCost,
    required TransferItemStatus status,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
    
    // Additional fields
    String? productName,
    String? productSku,
    String? unit,
    String? batchId,
    String? batchNumber,
    List<String>? serialNumbers,
    @Default({}) Map<String, dynamic> metadata,
    String? receivedNotes,
    DateTime? receivedAt,
    String? receivedBy,
  }) = _StockTransferItem;
  
  const StockTransferItem._();
  
  factory StockTransferItem.fromJson(Map<String, dynamic> json) => 
      _$StockTransferItemFromJson(json);
  
  // Helper methods
  double get remainingQuantity => quantity - receivedQuantity - damagedQuantity - lostQuantity;
  double get totalValue => quantity * (unitCost ?? 0);
  double get receivedValue => receivedQuantity * (unitCost ?? 0);
  
  bool get isFullyReceived => receivedQuantity >= quantity;
  bool get isPartiallyReceived => receivedQuantity > 0 && receivedQuantity < quantity;
  bool get hasDiscrepancy => damagedQuantity > 0 || lostQuantity > 0;
  
  double get receivePercentage => 
      quantity > 0 ? (receivedQuantity / quantity) * 100 : 0;
      
  String get statusDisplayName {
    switch (status) {
      case TransferItemStatus.pending:
        return 'Pending';
      case TransferItemStatus.approved:
        return 'Approved';
      case TransferItemStatus.rejected:
        return 'Rejected';
      case TransferItemStatus.partial:
        return 'Partially Received';
      case TransferItemStatus.received:
        return 'Received';
      case TransferItemStatus.damaged:
        return 'Damaged';
      case TransferItemStatus.lost:
        return 'Lost';
    }
  }
}