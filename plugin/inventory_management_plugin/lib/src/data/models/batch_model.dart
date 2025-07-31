import 'dart:convert';

import '../../domain/entities/batch.dart';
import '../database/database_schema.dart';
import 'base_model.dart';

/// Database model for Batch entity
class BatchModel extends BaseModel {
  final Batch batch;
  
  BatchModel(this.batch);
  
  @override
  String get tableName => DatabaseSchema.batchesTable;
  
  @override
  Map<String, dynamic> toDatabase() {
    return {
      DatabaseSchema.id: batch.id,
      DatabaseSchema.organizationId: batch.organizationId,
      'product_id': batch.productId,
      'batch_number': batch.batchNumber,
      'manufacturing_date': dateTimeToMillis(batch.manufacturingDate),
      'expiry_date': dateTimeToMillis(batch.expiryDate),
      'supplier_id': batch.supplierId,
      'purchase_order_id': batch.purchaseOrderId,
      'quantity_received': batch.quantityReceived,
      'quantity_available': batch.quantityAvailable,
      'cost_price': batch.costPrice,
      'mrp': batch.mrp,
      'selling_price': batch.sellingPrice,
      'location': batch.location,
      'status': batch.status.name,
      'quality_check_status': batch.qualityCheckStatus?.name,
      'quality_check_date': dateTimeToMillis(batch.qualityCheckDate),
      'quality_check_by': batch.qualityCheckBy,
      'quality_check_notes': batch.qualityCheckNotes,
      'recall_date': dateTimeToMillis(batch.recallDate),
      'recall_reason': batch.recallReason,
      'disposal_date': dateTimeToMillis(batch.disposalDate),
      'disposal_reason': batch.disposalReason,
      'disposal_by': batch.disposalBy,
      'notes': batch.notes,
      DatabaseSchema.metadata: encodeMetadata(batch.metadata),
      DatabaseSchema.createdAt: dateTimeToMillis(batch.createdAt),
      DatabaseSchema.updatedAt: dateTimeToMillis(batch.updatedAt),
      DatabaseSchema.syncedAt: dateTimeToMillis(batch.syncedAt),
    };
  }
  
  /// Create Batch from database map
  factory BatchModel.fromDatabase(Map<String, dynamic> map) {
    final batch = _fromMap(map);
    return BatchModel(batch);
  }
  
  static Batch _fromMap(Map<String, dynamic> map) {
    return Batch(
      id: map[DatabaseSchema.id] as String,
      organizationId: map[DatabaseSchema.organizationId] as String,
      productId: map['product_id'] as String,
      batchNumber: map['batch_number'] as String,
      manufacturingDate: map['manufacturing_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['manufacturing_date'] as int)
          : null,
      expiryDate: map['expiry_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['expiry_date'] as int)
          : null,
      supplierId: map['supplier_id'] as String?,
      purchaseOrderId: map['purchase_order_id'] as String?,
      quantityReceived: (map['quantity_received'] as num).toDouble(),
      quantityAvailable: (map['quantity_available'] as num).toDouble(),
      costPrice: (map['cost_price'] as num?)?.toDouble(),
      mrp: (map['mrp'] as num?)?.toDouble(),
      sellingPrice: (map['selling_price'] as num?)?.toDouble(),
      location: map['location'] as String?,
      status: _parseBatchStatus(map['status'] as String),
      qualityCheckStatus: _parseQualityStatus(map['quality_check_status'] as String?),
      qualityCheckDate: map['quality_check_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['quality_check_date'] as int)
          : null,
      qualityCheckBy: map['quality_check_by'] as String?,
      qualityCheckNotes: map['quality_check_notes'] as String?,
      recallDate: map['recall_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['recall_date'] as int)
          : null,
      recallReason: map['recall_reason'] as String?,
      disposalDate: map['disposal_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['disposal_date'] as int)
          : null,
      disposalReason: map['disposal_reason'] as String?,
      disposalBy: map['disposal_by'] as String?,
      notes: map['notes'] as String?,
      metadata: _decodeMetadata(map[DatabaseSchema.metadata] as String?),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.createdAt] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.updatedAt] as int),
      syncedAt: map[DatabaseSchema.syncedAt] != null
          ? DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.syncedAt] as int)
          : null,
    );
  }
  
  static BatchStatus _parseBatchStatus(String status) {
    try {
      return BatchStatus.values.firstWhere((e) => e.name == status);
    } catch (_) {
      return BatchStatus.active;
    }
  }
  
  static QualityCheckStatus? _parseQualityStatus(String? status) {
    if (status == null) return null;
    try {
      return QualityCheckStatus.values.firstWhere((e) => e.name == status);
    } catch (_) {
      return null;
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