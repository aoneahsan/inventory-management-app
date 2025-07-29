import 'package:equatable/equatable.dart';

class StockTransfer extends Equatable {
  final String id;
  final String organizationId;
  final String transferNumber;
  final String fromBranchId;
  final String toBranchId;
  final TransferStatus status;
  final DateTime transferDate;
  final DateTime? expectedDate;
  final DateTime? completedDate;
  final int totalItems;
  final String? notes;
  final String createdBy;
  final String? approvedBy;
  final String? receivedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<StockTransferItem>? items;

  const StockTransfer({
    required this.id,
    required this.organizationId,
    required this.transferNumber,
    required this.fromBranchId,
    required this.toBranchId,
    required this.status,
    required this.transferDate,
    this.expectedDate,
    this.completedDate,
    required this.totalItems,
    this.notes,
    required this.createdBy,
    this.approvedBy,
    this.receivedBy,
    required this.createdAt,
    required this.updatedAt,
    this.items,
  });

  StockTransfer copyWith({
    String? id,
    String? organizationId,
    String? transferNumber,
    String? fromBranchId,
    String? toBranchId,
    TransferStatus? status,
    DateTime? transferDate,
    DateTime? expectedDate,
    DateTime? completedDate,
    int? totalItems,
    String? notes,
    String? createdBy,
    String? approvedBy,
    String? receivedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<StockTransferItem>? items,
  }) {
    return StockTransfer(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      transferNumber: transferNumber ?? this.transferNumber,
      fromBranchId: fromBranchId ?? this.fromBranchId,
      toBranchId: toBranchId ?? this.toBranchId,
      status: status ?? this.status,
      transferDate: transferDate ?? this.transferDate,
      expectedDate: expectedDate ?? this.expectedDate,
      completedDate: completedDate ?? this.completedDate,
      totalItems: totalItems ?? this.totalItems,
      notes: notes ?? this.notes,
      createdBy: createdBy ?? this.createdBy,
      approvedBy: approvedBy ?? this.approvedBy,
      receivedBy: receivedBy ?? this.receivedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'organization_id': organizationId,
      'transfer_number': transferNumber,
      'from_branch_id': fromBranchId,
      'to_branch_id': toBranchId,
      'status': status.value,
      'transfer_date': transferDate.millisecondsSinceEpoch,
      'expected_date': expectedDate?.millisecondsSinceEpoch,
      'completed_date': completedDate?.millisecondsSinceEpoch,
      'total_items': totalItems,
      'notes': notes,
      'created_by': createdBy,
      'approved_by': approvedBy,
      'received_by': receivedBy,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory StockTransfer.fromMap(Map<String, dynamic> map) {
    return StockTransfer(
      id: map['id'],
      organizationId: map['organization_id'],
      transferNumber: map['transfer_number'],
      fromBranchId: map['from_branch_id'],
      toBranchId: map['to_branch_id'],
      status: TransferStatus.fromString(map['status']),
      transferDate: DateTime.fromMillisecondsSinceEpoch(map['transfer_date']),
      expectedDate: map['expected_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['expected_date'])
          : null,
      completedDate: map['completed_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['completed_date'])
          : null,
      totalItems: map['total_items'],
      notes: map['notes'],
      createdBy: map['created_by'],
      approvedBy: map['approved_by'],
      receivedBy: map['received_by'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        organizationId,
        transferNumber,
        fromBranchId,
        toBranchId,
        status,
        transferDate,
        expectedDate,
        completedDate,
        totalItems,
        notes,
        createdBy,
        approvedBy,
        receivedBy,
        createdAt,
        updatedAt,
        items,
      ];
}

enum TransferStatus {
  pending('pending'),
  inTransit('in_transit'),
  completed('completed'),
  cancelled('cancelled');

  final String value;
  const TransferStatus(this.value);

  static TransferStatus fromString(String value) {
    return TransferStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => TransferStatus.pending,
    );
  }
}

class StockTransferItem extends Equatable {
  final String id;
  final String transferId;
  final String productId;
  final double quantity;
  final double receivedQuantity;
  final double? unitCost;
  final TransferItemStatus status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const StockTransferItem({
    required this.id,
    required this.transferId,
    required this.productId,
    required this.quantity,
    required this.receivedQuantity,
    this.unitCost,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  StockTransferItem copyWith({
    String? id,
    String? transferId,
    String? productId,
    double? quantity,
    double? receivedQuantity,
    double? unitCost,
    TransferItemStatus? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StockTransferItem(
      id: id ?? this.id,
      transferId: transferId ?? this.transferId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      receivedQuantity: receivedQuantity ?? this.receivedQuantity,
      unitCost: unitCost ?? this.unitCost,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transfer_id': transferId,
      'product_id': productId,
      'quantity': quantity,
      'received_quantity': receivedQuantity,
      'unit_cost': unitCost,
      'status': status.value,
      'notes': notes,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory StockTransferItem.fromMap(Map<String, dynamic> map) {
    return StockTransferItem(
      id: map['id'],
      transferId: map['transfer_id'],
      productId: map['product_id'],
      quantity: map['quantity']?.toDouble() ?? 0.0,
      receivedQuantity: map['received_quantity']?.toDouble() ?? 0.0,
      unitCost: map['unit_cost']?.toDouble(),
      status: TransferItemStatus.fromString(map['status'] ?? 'pending'),
      notes: map['notes'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] ?? map['created_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        transferId,
        productId,
        quantity,
        receivedQuantity,
        unitCost,
        status,
        notes,
        createdAt,
        updatedAt,
      ];
}

enum TransferItemStatus {
  pending('pending'),
  approved('approved'),
  rejected('rejected'),
  received('received');

  final String value;
  const TransferItemStatus(this.value);

  static TransferItemStatus fromString(String value) {
    return TransferItemStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => TransferItemStatus.pending,
    );
  }
}