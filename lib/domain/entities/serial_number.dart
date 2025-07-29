import 'package:equatable/equatable.dart';

class SerialNumber extends Equatable {
  final String id;
  final String organizationId;
  final String productId;
  final String serialNumber;
  final String? batchId;
  final SerialStatus status;
  final String? branchId;
  final DateTime? purchaseDate;
  final double? purchasePrice;
  final String? saleId;
  final DateTime? saleDate;
  final double? salePrice;
  final DateTime? warrantyEndDate;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SerialNumber({
    required this.id,
    required this.organizationId,
    required this.productId,
    required this.serialNumber,
    this.batchId,
    required this.status,
    this.branchId,
    this.purchaseDate,
    this.purchasePrice,
    this.saleId,
    this.saleDate,
    this.salePrice,
    this.warrantyEndDate,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  SerialNumber copyWith({
    String? id,
    String? organizationId,
    String? productId,
    String? serialNumber,
    String? batchId,
    SerialStatus? status,
    String? branchId,
    DateTime? purchaseDate,
    double? purchasePrice,
    String? saleId,
    DateTime? saleDate,
    double? salePrice,
    DateTime? warrantyEndDate,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SerialNumber(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      productId: productId ?? this.productId,
      serialNumber: serialNumber ?? this.serialNumber,
      batchId: batchId ?? this.batchId,
      status: status ?? this.status,
      branchId: branchId ?? this.branchId,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      saleId: saleId ?? this.saleId,
      saleDate: saleDate ?? this.saleDate,
      salePrice: salePrice ?? this.salePrice,
      warrantyEndDate: warrantyEndDate ?? this.warrantyEndDate,
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
      'serial_number': serialNumber,
      'batch_id': batchId,
      'status': status.value,
      'branch_id': branchId,
      'purchase_date': purchaseDate?.millisecondsSinceEpoch,
      'purchase_price': purchasePrice,
      'sale_id': saleId,
      'sale_date': saleDate?.millisecondsSinceEpoch,
      'sale_price': salePrice,
      'warranty_end_date': warrantyEndDate?.millisecondsSinceEpoch,
      'notes': notes,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory SerialNumber.fromMap(Map<String, dynamic> map) {
    return SerialNumber(
      id: map['id'],
      organizationId: map['organization_id'],
      productId: map['product_id'],
      serialNumber: map['serial_number'],
      batchId: map['batch_id'],
      status: SerialStatus.fromString(map['status']),
      branchId: map['branch_id'],
      purchaseDate: map['purchase_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['purchase_date'])
          : null,
      purchasePrice: map['purchase_price']?.toDouble(),
      saleId: map['sale_id'],
      saleDate: map['sale_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['sale_date'])
          : null,
      salePrice: map['sale_price']?.toDouble(),
      warrantyEndDate: map['warranty_end_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['warranty_end_date'])
          : null,
      notes: map['notes'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  bool get isInWarranty {
    return warrantyEndDate != null && warrantyEndDate!.isAfter(DateTime.now());
  }

  @override
  List<Object?> get props => [
        id,
        organizationId,
        productId,
        serialNumber,
        batchId,
        status,
        branchId,
        purchaseDate,
        purchasePrice,
        saleId,
        saleDate,
        salePrice,
        warrantyEndDate,
        notes,
        createdAt,
        updatedAt,
      ];
}

enum SerialStatus {
  available('available'),
  sold('sold'),
  returned('returned'),
  damaged('damaged'),
  lost('lost');

  final String value;
  const SerialStatus(this.value);

  static SerialStatus fromString(String value) {
    return SerialStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => SerialStatus.available,
    );
  }
  
  String get displayName {
    switch (this) {
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
    }
  }
}