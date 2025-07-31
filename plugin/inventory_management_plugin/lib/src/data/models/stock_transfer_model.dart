import 'dart:convert';

import '../../domain/entities/stock_transfer.dart';
import '../database/database_schema.dart';
import 'base_model.dart';

/// Database model for StockTransfer entity
class StockTransferModel extends BaseModel {
  final StockTransfer stockTransfer;
  
  StockTransferModel(this.stockTransfer);
  
  @override
  String get tableName => DatabaseSchema.stockTransfersTable;
  
  @override
  Map<String, dynamic> toDatabase() {
    return {
      DatabaseSchema.id: stockTransfer.id,
      DatabaseSchema.organizationId: stockTransfer.organizationId,
      'transfer_number': stockTransfer.transferNumber,
      'from_branch_id': stockTransfer.fromBranchId,
      'to_branch_id': stockTransfer.toBranchId,
      'transfer_date': dateTimeToMillis(stockTransfer.transferDate),
      'expected_date': dateTimeToMillis(stockTransfer.expectedDate),
      'status': stockTransfer.status.name,
      'transfer_type': stockTransfer.transferType.name,
      'priority': stockTransfer.priority.name,
      'shipping_method': stockTransfer.shippingMethod,
      'tracking_number': stockTransfer.trackingNumber,
      'shipping_cost': stockTransfer.shippingCost,
      'notes': stockTransfer.notes,
      'initiated_by': stockTransfer.initiatedBy,
      'approved_by': stockTransfer.approvedBy,
      'approved_at': dateTimeToMillis(stockTransfer.approvedAt),
      'shipped_by': stockTransfer.shippedBy,
      'shipped_at': dateTimeToMillis(stockTransfer.shippedAt),
      'received_by': stockTransfer.receivedBy,
      'received_at': dateTimeToMillis(stockTransfer.receivedAt),
      'rejection_reason': stockTransfer.rejectionReason,
      'rejected_by': stockTransfer.rejectedBy,
      'rejected_at': dateTimeToMillis(stockTransfer.rejectedAt),
      DatabaseSchema.metadata: encodeMetadata(stockTransfer.metadata),
      DatabaseSchema.createdAt: dateTimeToMillis(stockTransfer.createdAt),
      DatabaseSchema.updatedAt: dateTimeToMillis(stockTransfer.updatedAt),
      DatabaseSchema.syncedAt: dateTimeToMillis(stockTransfer.syncedAt),
    };
  }
  
  /// Create StockTransfer from database map
  factory StockTransferModel.fromDatabase(Map<String, dynamic> map) {
    final stockTransfer = _fromMap(map);
    return StockTransferModel(stockTransfer);
  }
  
  static StockTransfer _fromMap(Map<String, dynamic> map) {
    return StockTransfer(
      id: map[DatabaseSchema.id] as String,
      organizationId: map[DatabaseSchema.organizationId] as String,
      transferNumber: map['transfer_number'] as String,
      fromBranchId: map['from_branch_id'] as String,
      toBranchId: map['to_branch_id'] as String,
      transferDate: DateTime.fromMillisecondsSinceEpoch(map['transfer_date'] as int),
      expectedDate: map['expected_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['expected_date'] as int)
          : null,
      status: _parseTransferStatus(map['status'] as String),
      items: [], // Items will be loaded separately
      transferType: _parseTransferType(map['transfer_type'] as String),
      priority: _parsePriority(map['priority'] as String),
      shippingMethod: map['shipping_method'] as String?,
      trackingNumber: map['tracking_number'] as String?,
      shippingCost: (map['shipping_cost'] as num?)?.toDouble(),
      notes: map['notes'] as String?,
      initiatedBy: map['initiated_by'] as String?,
      approvedBy: map['approved_by'] as String?,
      approvedAt: map['approved_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['approved_at'] as int)
          : null,
      shippedBy: map['shipped_by'] as String?,
      shippedAt: map['shipped_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['shipped_at'] as int)
          : null,
      receivedBy: map['received_by'] as String?,
      receivedAt: map['received_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['received_at'] as int)
          : null,
      rejectionReason: map['rejection_reason'] as String?,
      rejectedBy: map['rejected_by'] as String?,
      rejectedAt: map['rejected_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['rejected_at'] as int)
          : null,
      metadata: _decodeMetadata(map[DatabaseSchema.metadata] as String?),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.createdAt] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.updatedAt] as int),
      syncedAt: map[DatabaseSchema.syncedAt] != null
          ? DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.syncedAt] as int)
          : null,
    );
  }
  
  static StockTransferStatus _parseTransferStatus(String status) {
    try {
      return StockTransferStatus.values.firstWhere((e) => e.name == status);
    } catch (_) {
      return StockTransferStatus.draft;
    }
  }
  
  static TransferType _parseTransferType(String type) {
    try {
      return TransferType.values.firstWhere((e) => e.name == type);
    } catch (_) {
      return TransferType.normal;
    }
  }
  
  static TransferPriority _parsePriority(String priority) {
    try {
      return TransferPriority.values.firstWhere((e) => e.name == priority);
    } catch (_) {
      return TransferPriority.normal;
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