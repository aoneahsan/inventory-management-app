// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_transfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StockTransferImpl _$$StockTransferImplFromJson(Map<String, dynamic> json) =>
    _$StockTransferImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      transferNumber: json['transferNumber'] as String,
      fromBranchId: json['fromBranchId'] as String,
      toBranchId: json['toBranchId'] as String,
      status: $enumDecode(_$TransferStatusEnumMap, json['status']),
      transferDate: DateTime.parse(json['transferDate'] as String),
      expectedDate: json['expectedDate'] == null
          ? null
          : DateTime.parse(json['expectedDate'] as String),
      completedDate: json['completedDate'] == null
          ? null
          : DateTime.parse(json['completedDate'] as String),
      totalItems: (json['totalItems'] as num?)?.toInt() ?? 0,
      totalQuantity: (json['totalQuantity'] as num?)?.toDouble() ?? 0,
      totalValue: (json['totalValue'] as num?)?.toDouble() ?? 0,
      notes: json['notes'] as String?,
      createdBy: json['createdBy'] as String,
      approvedBy: json['approvedBy'] as String?,
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      receivedBy: json['receivedBy'] as String?,
      receivedAt: json['receivedAt'] == null
          ? null
          : DateTime.parse(json['receivedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      items: (json['items'] as List<dynamic>?)
              ?.map(
                  (e) => StockTransferItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      transportMode: json['transportMode'] as String?,
      transporterName: json['transporterName'] as String?,
      trackingNumber: json['trackingNumber'] as String?,
      vehicleNumber: json['vehicleNumber'] as String?,
      driverName: json['driverName'] as String?,
      driverContact: json['driverContact'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      customFields: json['customFields'] as Map<String, dynamic>? ?? const {},
      rejectionReason: json['rejectionReason'] as String?,
      rejectedAt: json['rejectedAt'] == null
          ? null
          : DateTime.parse(json['rejectedAt'] as String),
      rejectedBy: json['rejectedBy'] as String?,
    );

Map<String, dynamic> _$$StockTransferImplToJson(_$StockTransferImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'transferNumber': instance.transferNumber,
      'fromBranchId': instance.fromBranchId,
      'toBranchId': instance.toBranchId,
      'status': _$TransferStatusEnumMap[instance.status]!,
      'transferDate': instance.transferDate.toIso8601String(),
      'expectedDate': instance.expectedDate?.toIso8601String(),
      'completedDate': instance.completedDate?.toIso8601String(),
      'totalItems': instance.totalItems,
      'totalQuantity': instance.totalQuantity,
      'totalValue': instance.totalValue,
      'notes': instance.notes,
      'createdBy': instance.createdBy,
      'approvedBy': instance.approvedBy,
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'receivedBy': instance.receivedBy,
      'receivedAt': instance.receivedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'items': instance.items,
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'transportMode': instance.transportMode,
      'transporterName': instance.transporterName,
      'trackingNumber': instance.trackingNumber,
      'vehicleNumber': instance.vehicleNumber,
      'driverName': instance.driverName,
      'driverContact': instance.driverContact,
      'metadata': instance.metadata,
      'customFields': instance.customFields,
      'rejectionReason': instance.rejectionReason,
      'rejectedAt': instance.rejectedAt?.toIso8601String(),
      'rejectedBy': instance.rejectedBy,
    };

const _$TransferStatusEnumMap = {
  TransferStatus.draft: 'draft',
  TransferStatus.pending: 'pending',
  TransferStatus.approved: 'approved',
  TransferStatus.inTransit: 'in_transit',
  TransferStatus.partial: 'partial',
  TransferStatus.completed: 'completed',
  TransferStatus.cancelled: 'cancelled',
  TransferStatus.rejected: 'rejected',
};

_$StockTransferItemImpl _$$StockTransferItemImplFromJson(
        Map<String, dynamic> json) =>
    _$StockTransferItemImpl(
      id: json['id'] as String,
      transferId: json['transferId'] as String,
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      receivedQuantity: (json['receivedQuantity'] as num?)?.toDouble() ?? 0,
      damagedQuantity: (json['damagedQuantity'] as num?)?.toDouble() ?? 0,
      lostQuantity: (json['lostQuantity'] as num?)?.toDouble() ?? 0,
      unitCost: (json['unitCost'] as num?)?.toDouble(),
      status: $enumDecode(_$TransferItemStatusEnumMap, json['status']),
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      productName: json['productName'] as String?,
      productSku: json['productSku'] as String?,
      unit: json['unit'] as String?,
      batchId: json['batchId'] as String?,
      batchNumber: json['batchNumber'] as String?,
      serialNumbers: (json['serialNumbers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      receivedNotes: json['receivedNotes'] as String?,
      receivedAt: json['receivedAt'] == null
          ? null
          : DateTime.parse(json['receivedAt'] as String),
      receivedBy: json['receivedBy'] as String?,
    );

Map<String, dynamic> _$$StockTransferItemImplToJson(
        _$StockTransferItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transferId': instance.transferId,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'receivedQuantity': instance.receivedQuantity,
      'damagedQuantity': instance.damagedQuantity,
      'lostQuantity': instance.lostQuantity,
      'unitCost': instance.unitCost,
      'status': _$TransferItemStatusEnumMap[instance.status]!,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'productName': instance.productName,
      'productSku': instance.productSku,
      'unit': instance.unit,
      'batchId': instance.batchId,
      'batchNumber': instance.batchNumber,
      'serialNumbers': instance.serialNumbers,
      'metadata': instance.metadata,
      'receivedNotes': instance.receivedNotes,
      'receivedAt': instance.receivedAt?.toIso8601String(),
      'receivedBy': instance.receivedBy,
    };

const _$TransferItemStatusEnumMap = {
  TransferItemStatus.pending: 'pending',
  TransferItemStatus.approved: 'approved',
  TransferItemStatus.rejected: 'rejected',
  TransferItemStatus.partial: 'partial',
  TransferItemStatus.received: 'received',
  TransferItemStatus.damaged: 'damaged',
  TransferItemStatus.lost: 'lost',
};
