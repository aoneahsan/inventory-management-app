import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_transfer_item.freezed.dart';
part 'stock_transfer_item.g.dart';

/// Stock transfer item entity
@freezed
class StockTransferItem with _$StockTransferItem {
  const factory StockTransferItem({
    required String id,
    required String stockTransferId,
    required String productId,
    required double requestedQuantity,
    double? approvedQuantity,
    double? shippedQuantity,
    double? receivedQuantity,
    String? batchId,
    String? serialNumber,
    String? discrepancyReason,
    String? notes,
    required DateTime createdAt,
  }) = _StockTransferItem;

  factory StockTransferItem.fromJson(Map<String, dynamic> json) =>
      _$StockTransferItemFromJson(json);
}