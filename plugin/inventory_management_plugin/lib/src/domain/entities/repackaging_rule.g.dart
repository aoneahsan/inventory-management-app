// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repackaging_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RepackagingRuleImpl _$$RepackagingRuleImplFromJson(
        Map<String, dynamic> json) =>
    _$RepackagingRuleImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      fromProductId: json['fromProductId'] as String,
      toProductId: json['toProductId'] as String,
      conversionRate: (json['conversionRate'] as num).toDouble(),
      ruleName: json['ruleName'] as String?,
      conversionFactor: (json['conversionFactor'] as num?)?.toDouble() ?? 1.0,
      requiresApproval: json['requiresApproval'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      type: $enumDecodeNullable(_$RepackagingTypeEnumMap, json['type']) ??
          RepackagingType.transform,
      fromProductName: json['fromProductName'] as String?,
      toProductName: json['toProductName'] as String?,
      fromUnit: json['fromUnit'] as String?,
      toUnit: json['toUnit'] as String?,
      wastagePercentage: (json['wastagePercentage'] as num?)?.toDouble(),
      laborCost: (json['laborCost'] as num?)?.toDouble(),
      packagingCost: (json['packagingCost'] as num?)?.toDouble(),
      otherCosts: (json['otherCosts'] as num?)?.toDouble(),
      processingTimeMinutes:
          (json['processingTimeMinutes'] as num?)?.toInt() ?? 0,
      description: json['description'] as String?,
      instructions: json['instructions'] as String?,
      requiredTools: (json['requiredTools'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      qualityChecks: json['qualityChecks'] as Map<String, dynamic>? ?? const {},
      trackBatches: json['trackBatches'] as bool? ?? false,
      maintainSerialNumbers: json['maintainSerialNumbers'] as bool? ?? false,
      categoryId: json['categoryId'] as String?,
      priority: (json['priority'] as num?)?.toInt() ?? 0,
      minQuantity: (json['minQuantity'] as num?)?.toDouble(),
      maxQuantity: (json['maxQuantity'] as num?)?.toDouble(),
      additionalComponents: (json['additionalComponents'] as List<dynamic>?)
              ?.map((e) =>
                  RepackagingComponent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdBy: json['createdBy'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$RepackagingRuleImplToJson(
        _$RepackagingRuleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'fromProductId': instance.fromProductId,
      'toProductId': instance.toProductId,
      'conversionRate': instance.conversionRate,
      'ruleName': instance.ruleName,
      'conversionFactor': instance.conversionFactor,
      'requiresApproval': instance.requiresApproval,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'type': _$RepackagingTypeEnumMap[instance.type]!,
      'fromProductName': instance.fromProductName,
      'toProductName': instance.toProductName,
      'fromUnit': instance.fromUnit,
      'toUnit': instance.toUnit,
      'wastagePercentage': instance.wastagePercentage,
      'laborCost': instance.laborCost,
      'packagingCost': instance.packagingCost,
      'otherCosts': instance.otherCosts,
      'processingTimeMinutes': instance.processingTimeMinutes,
      'description': instance.description,
      'instructions': instance.instructions,
      'requiredTools': instance.requiredTools,
      'qualityChecks': instance.qualityChecks,
      'trackBatches': instance.trackBatches,
      'maintainSerialNumbers': instance.maintainSerialNumbers,
      'categoryId': instance.categoryId,
      'priority': instance.priority,
      'minQuantity': instance.minQuantity,
      'maxQuantity': instance.maxQuantity,
      'additionalComponents': instance.additionalComponents,
      'createdBy': instance.createdBy,
      'metadata': instance.metadata,
    };

const _$RepackagingTypeEnumMap = {
  RepackagingType.split: 'split',
  RepackagingType.combine: 'combine',
  RepackagingType.transform: 'transform',
  RepackagingType.bundle: 'bundle',
  RepackagingType.unbundle: 'unbundle',
};

_$RepackagingComponentImpl _$$RepackagingComponentImplFromJson(
        Map<String, dynamic> json) =>
    _$RepackagingComponentImpl(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      unitCost: (json['unitCost'] as num?)?.toDouble() ?? 0,
      unit: json['unit'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$RepackagingComponentImplToJson(
        _$RepackagingComponentImpl instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'quantity': instance.quantity,
      'unitCost': instance.unitCost,
      'unit': instance.unit,
      'notes': instance.notes,
    };

_$RepackagingTransactionImpl _$$RepackagingTransactionImplFromJson(
        Map<String, dynamic> json) =>
    _$RepackagingTransactionImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      ruleId: json['ruleId'] as String,
      branchId: json['branchId'] as String,
      inputQuantity: (json['inputQuantity'] as num).toDouble(),
      outputQuantity: (json['outputQuantity'] as num).toDouble(),
      actualOutputQuantity: (json['actualOutputQuantity'] as num).toDouble(),
      status: $enumDecodeNullable(_$RepackagingStatusEnumMap, json['status']) ??
          RepackagingStatus.pending,
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      performedBy: json['performedBy'] as String?,
      approvedBy: json['approvedBy'] as String?,
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      batchId: json['batchId'] as String?,
      serialNumbers: (json['serialNumbers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      totalCost: (json['totalCost'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
      qualityCheckResults:
          json['qualityCheckResults'] as Map<String, dynamic>? ?? const {},
      failureReason: json['failureReason'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
    );

Map<String, dynamic> _$$RepackagingTransactionImplToJson(
        _$RepackagingTransactionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'ruleId': instance.ruleId,
      'branchId': instance.branchId,
      'inputQuantity': instance.inputQuantity,
      'outputQuantity': instance.outputQuantity,
      'actualOutputQuantity': instance.actualOutputQuantity,
      'status': _$RepackagingStatusEnumMap[instance.status]!,
      'startedAt': instance.startedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'performedBy': instance.performedBy,
      'approvedBy': instance.approvedBy,
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'batchId': instance.batchId,
      'serialNumbers': instance.serialNumbers,
      'totalCost': instance.totalCost,
      'notes': instance.notes,
      'qualityCheckResults': instance.qualityCheckResults,
      'failureReason': instance.failureReason,
      'createdAt': instance.createdAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
    };

const _$RepackagingStatusEnumMap = {
  RepackagingStatus.pending: 'pending',
  RepackagingStatus.inProgress: 'in_progress',
  RepackagingStatus.completed: 'completed',
  RepackagingStatus.cancelled: 'cancelled',
  RepackagingStatus.failed: 'failed',
};
