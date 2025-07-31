// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_inventory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BranchInventoryImpl _$$BranchInventoryImplFromJson(
        Map<String, dynamic> json) =>
    _$BranchInventoryImpl(
      id: json['id'] as String,
      branchId: json['branchId'] as String,
      productId: json['productId'] as String,
      currentStock: (json['currentStock'] as num?)?.toDouble() ?? 0,
      reservedStock: (json['reservedStock'] as num?)?.toDouble() ?? 0,
      availableStock: (json['availableStock'] as num?)?.toDouble() ?? 0,
      minStock: (json['minStock'] as num?)?.toDouble() ?? 0,
      maxStock: (json['maxStock'] as num?)?.toDouble(),
      reorderPoint: (json['reorderPoint'] as num?)?.toDouble(),
      reorderQuantity: (json['reorderQuantity'] as num?)?.toDouble() ?? 0,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      warehouseLocation: json['warehouseLocation'] as String?,
      shelfLocation: json['shelfLocation'] as String?,
      incomingStock: (json['incomingStock'] as num?)?.toDouble() ?? 0,
      outgoingStock: (json['outgoingStock'] as num?)?.toDouble() ?? 0,
      lastStockTakeDate: json['lastStockTakeDate'] == null
          ? null
          : DateTime.parse(json['lastStockTakeDate'] as String),
      lastStockTakeQuantity:
          (json['lastStockTakeQuantity'] as num?)?.toDouble(),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      averageDailySales: (json['averageDailySales'] as num?)?.toDouble() ?? 0,
      daysOfStock: (json['daysOfStock'] as num?)?.toInt() ?? 0,
      preferredSupplierId: json['preferredSupplierId'] as String?,
      activeAlerts: (json['activeAlerts'] as List<dynamic>?)
              ?.map((e) => StockAlert.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$BranchInventoryImplToJson(
        _$BranchInventoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'branchId': instance.branchId,
      'productId': instance.productId,
      'currentStock': instance.currentStock,
      'reservedStock': instance.reservedStock,
      'availableStock': instance.availableStock,
      'minStock': instance.minStock,
      'maxStock': instance.maxStock,
      'reorderPoint': instance.reorderPoint,
      'reorderQuantity': instance.reorderQuantity,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'warehouseLocation': instance.warehouseLocation,
      'shelfLocation': instance.shelfLocation,
      'incomingStock': instance.incomingStock,
      'outgoingStock': instance.outgoingStock,
      'lastStockTakeDate': instance.lastStockTakeDate?.toIso8601String(),
      'lastStockTakeQuantity': instance.lastStockTakeQuantity,
      'metadata': instance.metadata,
      'averageDailySales': instance.averageDailySales,
      'daysOfStock': instance.daysOfStock,
      'preferredSupplierId': instance.preferredSupplierId,
      'activeAlerts': instance.activeAlerts,
    };

_$StockAlertImpl _$$StockAlertImplFromJson(Map<String, dynamic> json) =>
    _$StockAlertImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      message: json['message'] as String,
      severity: $enumDecode(_$AlertSeverityEnumMap, json['severity']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      acknowledgedAt: json['acknowledgedAt'] == null
          ? null
          : DateTime.parse(json['acknowledgedAt'] as String),
      acknowledgedBy: json['acknowledgedBy'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$StockAlertImplToJson(_$StockAlertImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'message': instance.message,
      'severity': _$AlertSeverityEnumMap[instance.severity]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'acknowledgedAt': instance.acknowledgedAt?.toIso8601String(),
      'acknowledgedBy': instance.acknowledgedBy,
      'metadata': instance.metadata,
    };

const _$AlertSeverityEnumMap = {
  AlertSeverity.info: 'info',
  AlertSeverity.warning: 'warning',
  AlertSeverity.critical: 'critical',
};
