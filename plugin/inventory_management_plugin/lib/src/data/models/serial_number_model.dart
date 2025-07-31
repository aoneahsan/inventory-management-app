import 'dart:convert';

import '../../domain/entities/serial_number.dart';
import '../database/database_schema.dart';
import 'base_model.dart';

/// Database model for SerialNumber entity
class SerialNumberModel extends BaseModel {
  final SerialNumber serialNumber;
  
  SerialNumberModel(this.serialNumber);
  
  @override
  String get tableName => DatabaseSchema.serialNumbersTable;
  
  @override
  Map<String, dynamic> toDatabase() {
    return {
      DatabaseSchema.id: serialNumber.id,
      DatabaseSchema.organizationId: serialNumber.organizationId,
      'product_id': serialNumber.productId,
      'serial_number': serialNumber.serialNumber,
      'batch_id': serialNumber.batchId,
      'status': serialNumber.status.name,
      'branch_id': serialNumber.branchId,
      'location': serialNumber.location,
      'purchase_order_id': serialNumber.purchaseOrderId,
      'purchase_date': dateTimeToMillis(serialNumber.purchaseDate),
      'purchase_price': serialNumber.purchasePrice,
      'supplier_id': serialNumber.supplierId,
      'warranty_start_date': dateTimeToMillis(serialNumber.warrantyStartDate),
      'warranty_end_date': dateTimeToMillis(serialNumber.warrantyEndDate),
      'warranty_terms': serialNumber.warrantyTerms,
      'sale_id': serialNumber.saleId,
      'sale_date': dateTimeToMillis(serialNumber.saleDate),
      'selling_price': serialNumber.sellingPrice,
      'customer_id': serialNumber.customerId,
      'return_date': dateTimeToMillis(serialNumber.returnDate),
      'return_reason': serialNumber.returnReason,
      'notes': serialNumber.notes,
      DatabaseSchema.metadata: encodeMetadata(serialNumber.metadata),
      DatabaseSchema.createdAt: dateTimeToMillis(serialNumber.createdAt),
      DatabaseSchema.updatedAt: dateTimeToMillis(serialNumber.updatedAt),
      DatabaseSchema.syncedAt: dateTimeToMillis(serialNumber.syncedAt),
    };
  }
  
  /// Create SerialNumber from database map
  factory SerialNumberModel.fromDatabase(Map<String, dynamic> map) {
    final serialNumber = _fromMap(map);
    return SerialNumberModel(serialNumber);
  }
  
  static SerialNumber _fromMap(Map<String, dynamic> map) {
    return SerialNumber(
      id: map[DatabaseSchema.id] as String,
      organizationId: map[DatabaseSchema.organizationId] as String,
      productId: map['product_id'] as String,
      serialNumber: map['serial_number'] as String,
      batchId: map['batch_id'] as String?,
      status: _parseSerialStatus(map['status'] as String),
      branchId: map['branch_id'] as String?,
      location: map['location'] as String?,
      purchaseOrderId: map['purchase_order_id'] as String?,
      purchaseDate: map['purchase_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['purchase_date'] as int)
          : null,
      purchasePrice: (map['purchase_price'] as num?)?.toDouble(),
      supplierId: map['supplier_id'] as String?,
      warrantyStartDate: map['warranty_start_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['warranty_start_date'] as int)
          : null,
      warrantyEndDate: map['warranty_end_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['warranty_end_date'] as int)
          : null,
      warrantyTerms: map['warranty_terms'] as String?,
      saleId: map['sale_id'] as String?,
      saleDate: map['sale_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['sale_date'] as int)
          : null,
      sellingPrice: (map['selling_price'] as num?)?.toDouble(),
      customerId: map['customer_id'] as String?,
      returnDate: map['return_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['return_date'] as int)
          : null,
      returnReason: map['return_reason'] as String?,
      notes: map['notes'] as String?,
      movements: [], // Movements will be loaded separately
      metadata: _decodeMetadata(map[DatabaseSchema.metadata] as String?),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.createdAt] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.updatedAt] as int),
      syncedAt: map[DatabaseSchema.syncedAt] != null
          ? DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.syncedAt] as int)
          : null,
    );
  }
  
  static SerialNumberStatus _parseSerialStatus(String status) {
    try {
      return SerialNumberStatus.values.firstWhere((e) => e.name == status);
    } catch (_) {
      return SerialNumberStatus.available;
    }
  }
  
  static Map<String, dynamic> _decodeMetadata(String? metadata) {
    if (metadata == null || metadata.isEmpty) return {};
    try {
      return Map<String, dynamic>.from(json.decode(metadata));
    } catch (_) {
      return {};
    }
  }
}