// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_transfer_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StockTransferItemImpl _$$StockTransferItemImplFromJson(
        Map<String, dynamic> json) =>
    _$StockTransferItemImpl(
      id: json['id'] as String,
      stockTransferId: json['stockTransferId'] as String,
      productId: json['productId'] as String,
      requestedQuantity: (json['requestedQuantity'] as num).toDouble(),
      approvedQuantity: (json['approvedQuantity'] as num?)?.toDouble(),
      shippedQuantity: (json['shippedQuantity'] as num?)?.toDouble(),
      receivedQuantity: (json['receivedQuantity'] as num?)?.toDouble(),
      batchId: json['batchId'] as String?,
      serialNumber: json['serialNumber'] as String?,
      discrepancyReason: json['discrepancyReason'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$StockTransferItemImplToJson(
        _$StockTransferItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stockTransferId': instance.stockTransferId,
      'productId': instance.productId,
      'requestedQuantity': instance.requestedQuantity,
      'approvedQuantity': instance.approvedQuantity,
      'shippedQuantity': instance.shippedQuantity,
      'receivedQuantity': instance.receivedQuantity,
      'batchId': instance.batchId,
      'serialNumber': instance.serialNumber,
      'discrepancyReason': instance.discrepancyReason,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
    };
