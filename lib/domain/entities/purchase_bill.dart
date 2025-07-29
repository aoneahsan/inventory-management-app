import 'package:equatable/equatable.dart';

class PurchaseBill extends Equatable {
  final String id;
  final String organizationId;
  final String supplierId;
  final String? purchaseOrderId;
  final String billNumber;
  final DateTime billDate;
  final DateTime? dueDate;
  final String status; // draft, pending, partial, paid, overdue
  final double totalAmount;
  final double paidAmount;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PurchaseBill({
    required this.id,
    required this.organizationId,
    required this.supplierId,
    this.purchaseOrderId,
    required this.billNumber,
    required this.billDate,
    this.dueDate,
    required this.status,
    required this.totalAmount,
    this.paidAmount = 0,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        organizationId,
        supplierId,
        purchaseOrderId,
        billNumber,
        billDate,
        dueDate,
        status,
        totalAmount,
        paidAmount,
        notes,
        createdAt,
        updatedAt,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'organization_id': organizationId,
      'supplier_id': supplierId,
      'purchase_order_id': purchaseOrderId,
      'bill_number': billNumber,
      'bill_date': billDate.millisecondsSinceEpoch,
      'due_date': dueDate?.millisecondsSinceEpoch,
      'status': status,
      'total_amount': totalAmount,
      'paid_amount': paidAmount,
      'notes': notes,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory PurchaseBill.fromMap(Map<String, dynamic> map) {
    return PurchaseBill(
      id: map['id'] as String,
      organizationId: map['organization_id'] as String,
      supplierId: map['supplier_id'] as String,
      purchaseOrderId: map['purchase_order_id'] as String?,
      billNumber: map['bill_number'] as String,
      billDate: DateTime.fromMillisecondsSinceEpoch(map['bill_date'] as int),
      dueDate: map['due_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['due_date'] as int)
          : null,
      status: map['status'] as String,
      totalAmount: (map['total_amount'] ?? 0).toDouble(),
      paidAmount: (map['paid_amount'] ?? 0).toDouble(),
      notes: map['notes'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
    );
  }

  PurchaseBill copyWith({
    String? id,
    String? organizationId,
    String? supplierId,
    String? purchaseOrderId,
    String? billNumber,
    DateTime? billDate,
    DateTime? dueDate,
    String? status,
    double? totalAmount,
    double? paidAmount,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PurchaseBill(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      supplierId: supplierId ?? this.supplierId,
      purchaseOrderId: purchaseOrderId ?? this.purchaseOrderId,
      billNumber: billNumber ?? this.billNumber,
      billDate: billDate ?? this.billDate,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Helper methods
  double get remainingAmount => totalAmount - paidAmount;
  double get paidPercentage => totalAmount > 0 ? (paidAmount / totalAmount) * 100 : 0;
  
  bool get isDraft => status == 'draft';
  bool get isPending => status == 'pending';
  bool get isPartiallyPaid => status == 'partial';
  bool get isFullyPaid => status == 'paid';
  bool get isOverdue => status == 'overdue';

  bool get canEdit => isDraft;
  bool get canPay => !isFullyPaid && !isDraft;
  bool get canDelete => isDraft;

  bool checkOverdue() {
    if (dueDate == null || isFullyPaid) return false;
    return DateTime.now().isAfter(dueDate!);
  }

  int get daysUntilDue {
    if (dueDate == null) return 0;
    return dueDate!.difference(DateTime.now()).inDays;
  }

  int get daysOverdue {
    if (dueDate == null || !checkOverdue()) return 0;
    return DateTime.now().difference(dueDate!).inDays;
  }
}