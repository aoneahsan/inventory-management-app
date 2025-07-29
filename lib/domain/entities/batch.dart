import 'package:equatable/equatable.dart';

class Batch extends Equatable {
  final String id;
  final String organizationId;
  final String productId;
  final String batchNumber;
  final DateTime? manufacturingDate;
  final DateTime? expiryDate;
  final String? supplierId;
  final double? costPrice;
  final double currentQuantity;
  final double initialQuantity;
  final String? branchId;
  final String status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Batch({
    required this.id,
    required this.organizationId,
    required this.productId,
    required this.batchNumber,
    this.manufacturingDate,
    this.expiryDate,
    this.supplierId,
    this.costPrice,
    required this.currentQuantity,
    required this.initialQuantity,
    this.branchId,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  Batch copyWith({
    String? id,
    String? organizationId,
    String? productId,
    String? batchNumber,
    DateTime? manufacturingDate,
    DateTime? expiryDate,
    String? supplierId,
    double? costPrice,
    double? currentQuantity,
    double? initialQuantity,
    String? branchId,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Batch(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      productId: productId ?? this.productId,
      batchNumber: batchNumber ?? this.batchNumber,
      manufacturingDate: manufacturingDate ?? this.manufacturingDate,
      expiryDate: expiryDate ?? this.expiryDate,
      supplierId: supplierId ?? this.supplierId,
      costPrice: costPrice ?? this.costPrice,
      currentQuantity: currentQuantity ?? this.currentQuantity,
      initialQuantity: initialQuantity ?? this.initialQuantity,
      branchId: branchId ?? this.branchId,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'organization_id': organizationId,
      'product_id': productId,
      'batch_number': batchNumber,
      'manufacturing_date': manufacturingDate?.millisecondsSinceEpoch,
      'expiry_date': expiryDate?.millisecondsSinceEpoch,
      'supplier_id': supplierId,
      'cost_price': costPrice,
      'current_quantity': currentQuantity,
      'initial_quantity': initialQuantity,
      'branch_id': branchId,
      'status': status,
      'notes': notes,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Batch.fromMap(Map<String, dynamic> map) {
    return Batch(
      id: map['id'],
      organizationId: map['organization_id'],
      productId: map['product_id'],
      batchNumber: map['batch_number'],
      manufacturingDate: map['manufacturing_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['manufacturing_date'])
          : null,
      expiryDate: map['expiry_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['expiry_date'])
          : null,
      supplierId: map['supplier_id'],
      costPrice: map['cost_price']?.toDouble(),
      currentQuantity: map['current_quantity']?.toDouble() ?? 0.0,
      initialQuantity: map['initial_quantity']?.toDouble() ?? 0.0,
      branchId: map['branch_id'],
      status: map['status'] ?? 'active',
      notes: map['notes'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  bool get isExpired {
    return expiryDate != null && expiryDate!.isBefore(DateTime.now());
  }

  bool get isNearExpiry {
    if (expiryDate == null) return false;
    final daysUntilExpiry = expiryDate!.difference(DateTime.now()).inDays;
    return daysUntilExpiry > 0 && daysUntilExpiry <= 30;
  }

  double get usedQuantity => initialQuantity - currentQuantity;
  double get usagePercentage => (usedQuantity / initialQuantity) * 100;

  @override
  List<Object?> get props => [
        id,
        organizationId,
        productId,
        batchNumber,
        manufacturingDate,
        expiryDate,
        supplierId,
        costPrice,
        currentQuantity,
        initialQuantity,
        branchId,
        status,
        notes,
        createdAt,
        updatedAt,
      ];
}