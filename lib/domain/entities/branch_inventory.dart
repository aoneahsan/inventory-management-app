import 'package:equatable/equatable.dart';

class BranchInventory extends Equatable {
  final String id;
  final String branchId;
  final String productId;
  final double currentStock;
  final double reservedStock;
  final double availableStock;
  final double minStock;
  final double? maxStock;
  final double? reorderPoint;
  final DateTime lastUpdated;

  const BranchInventory({
    required this.id,
    required this.branchId,
    required this.productId,
    required this.currentStock,
    required this.reservedStock,
    required this.availableStock,
    required this.minStock,
    this.maxStock,
    this.reorderPoint,
    required this.lastUpdated,
  });

  BranchInventory copyWith({
    String? id,
    String? branchId,
    String? productId,
    double? currentStock,
    double? reservedStock,
    double? availableStock,
    double? minStock,
    double? maxStock,
    double? reorderPoint,
    DateTime? lastUpdated,
  }) {
    return BranchInventory(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      productId: productId ?? this.productId,
      currentStock: currentStock ?? this.currentStock,
      reservedStock: reservedStock ?? this.reservedStock,
      availableStock: availableStock ?? this.availableStock,
      minStock: minStock ?? this.minStock,
      maxStock: maxStock ?? this.maxStock,
      reorderPoint: reorderPoint ?? this.reorderPoint,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'branch_id': branchId,
      'product_id': productId,
      'current_stock': currentStock,
      'reserved_stock': reservedStock,
      'available_stock': availableStock,
      'min_stock': minStock,
      'max_stock': maxStock,
      'reorder_point': reorderPoint,
      'last_updated': lastUpdated.millisecondsSinceEpoch,
    };
  }

  factory BranchInventory.fromMap(Map<String, dynamic> map) {
    return BranchInventory(
      id: map['id'],
      branchId: map['branch_id'],
      productId: map['product_id'],
      currentStock: map['current_stock']?.toDouble() ?? 0.0,
      reservedStock: map['reserved_stock']?.toDouble() ?? 0.0,
      availableStock: map['available_stock']?.toDouble() ?? 0.0,
      minStock: map['min_stock']?.toDouble() ?? 0.0,
      maxStock: map['max_stock']?.toDouble(),
      reorderPoint: map['reorder_point']?.toDouble(),
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(map['last_updated']),
    );
  }

  bool get isLowStock => currentStock <= minStock;
  bool get needsReorder => reorderPoint != null && currentStock <= reorderPoint!;
  bool get isOverstock => maxStock != null && currentStock > maxStock!;

  @override
  List<Object?> get props => [
        id,
        branchId,
        productId,
        currentStock,
        reservedStock,
        availableStock,
        minStock,
        maxStock,
        reorderPoint,
        lastUpdated,
      ];
}