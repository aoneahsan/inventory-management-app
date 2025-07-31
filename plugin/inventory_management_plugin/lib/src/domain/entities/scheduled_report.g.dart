// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduledReportImpl _$$ScheduledReportImplFromJson(
        Map<String, dynamic> json) =>
    _$ScheduledReportImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      name: json['name'] as String,
      reportType: $enumDecode(_$ReportTypeEnumMap, json['reportType']),
      parameters: json['parameters'] as Map<String, dynamic>? ?? const {},
      schedule: $enumDecode(_$ReportScheduleEnumMap, json['schedule']),
      recipients: (json['recipients'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      format: $enumDecode(_$ReportFormatEnumMap, json['format']),
      isActive: json['isActive'] as bool? ?? true,
      lastRun: json['lastRun'] == null
          ? null
          : DateTime.parse(json['lastRun'] as String),
      nextRun: json['nextRun'] == null
          ? null
          : DateTime.parse(json['nextRun'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      description: json['description'] as String?,
      deliveryMethods: (json['deliveryMethods'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$ReportDeliveryEnumMap, e))
              .toList() ??
          const [ReportDelivery.email],
      webhookUrl: json['webhookUrl'] as String?,
      storageLocation: json['storageLocation'] as String?,
      timezone: json['timezone'] as String?,
      dayOfWeek: (json['dayOfWeek'] as num?)?.toInt(),
      dayOfMonth: (json['dayOfMonth'] as num?)?.toInt(),
      timeOfDay: json['timeOfDay'] as String?,
      filters: json['filters'] as Map<String, dynamic>? ?? const {},
      includedSections: (json['includedSections'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      excludedSections: (json['excludedSections'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      templateId: json['templateId'] as String?,
      customizations:
          json['customizations'] as Map<String, dynamic>? ?? const {},
      createdBy: json['createdBy'] as String?,
      lastRunBy: json['lastRunBy'] as String?,
      lastRunStatus: json['lastRunStatus'] as String?,
      lastRunError: json['lastRunError'] as String?,
      retryCount: (json['retryCount'] as num?)?.toInt(),
      nextRetryAt: json['nextRetryAt'] == null
          ? null
          : DateTime.parse(json['nextRetryAt'] as String),
      includeCharts: json['includeCharts'] as bool? ?? false,
      includeSummary: json['includeSummary'] as bool? ?? false,
      compressOutput: json['compressOutput'] as bool? ?? false,
      emailSubjectTemplate: json['emailSubjectTemplate'] as String?,
      emailBodyTemplate: json['emailBodyTemplate'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      recentRuns: (json['recentRuns'] as List<dynamic>?)
              ?.map(
                  (e) => ScheduledReportRun.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ScheduledReportImplToJson(
        _$ScheduledReportImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'name': instance.name,
      'reportType': _$ReportTypeEnumMap[instance.reportType]!,
      'parameters': instance.parameters,
      'schedule': _$ReportScheduleEnumMap[instance.schedule]!,
      'recipients': instance.recipients,
      'format': _$ReportFormatEnumMap[instance.format]!,
      'isActive': instance.isActive,
      'lastRun': instance.lastRun?.toIso8601String(),
      'nextRun': instance.nextRun?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'description': instance.description,
      'deliveryMethods': instance.deliveryMethods
          .map((e) => _$ReportDeliveryEnumMap[e]!)
          .toList(),
      'webhookUrl': instance.webhookUrl,
      'storageLocation': instance.storageLocation,
      'timezone': instance.timezone,
      'dayOfWeek': instance.dayOfWeek,
      'dayOfMonth': instance.dayOfMonth,
      'timeOfDay': instance.timeOfDay,
      'filters': instance.filters,
      'includedSections': instance.includedSections,
      'excludedSections': instance.excludedSections,
      'templateId': instance.templateId,
      'customizations': instance.customizations,
      'createdBy': instance.createdBy,
      'lastRunBy': instance.lastRunBy,
      'lastRunStatus': instance.lastRunStatus,
      'lastRunError': instance.lastRunError,
      'retryCount': instance.retryCount,
      'nextRetryAt': instance.nextRetryAt?.toIso8601String(),
      'includeCharts': instance.includeCharts,
      'includeSummary': instance.includeSummary,
      'compressOutput': instance.compressOutput,
      'emailSubjectTemplate': instance.emailSubjectTemplate,
      'emailBodyTemplate': instance.emailBodyTemplate,
      'metadata': instance.metadata,
      'recentRuns': instance.recentRuns,
    };

const _$ReportTypeEnumMap = {
  ReportType.inventory: 'inventory',
  ReportType.sales: 'sales',
  ReportType.purchase: 'purchase',
  ReportType.financial: 'financial',
  ReportType.customer: 'customer',
  ReportType.supplier: 'supplier',
  ReportType.stockMovement: 'stock_movement',
  ReportType.lowStock: 'low_stock',
  ReportType.expiry: 'expiry',
  ReportType.profitLoss: 'profit_loss',
  ReportType.tax: 'tax',
  ReportType.aging: 'aging',
  ReportType.performance: 'performance',
  ReportType.forecast: 'forecast',
  ReportType.custom: 'custom',
};

const _$ReportScheduleEnumMap = {
  ReportSchedule.daily: 'daily',
  ReportSchedule.weekly: 'weekly',
  ReportSchedule.monthly: 'monthly',
  ReportSchedule.quarterly: 'quarterly',
  ReportSchedule.yearly: 'yearly',
  ReportSchedule.onDemand: 'on_demand',
};

const _$ReportFormatEnumMap = {
  ReportFormat.pdf: 'pdf',
  ReportFormat.excel: 'excel',
  ReportFormat.csv: 'csv',
  ReportFormat.json: 'json',
  ReportFormat.html: 'html',
};

const _$ReportDeliveryEnumMap = {
  ReportDelivery.email: 'email',
  ReportDelivery.webhook: 'webhook',
  ReportDelivery.storage: 'storage',
  ReportDelivery.download: 'download',
};

_$ScheduledReportRunImpl _$$ScheduledReportRunImplFromJson(
        Map<String, dynamic> json) =>
    _$ScheduledReportRunImpl(
      id: json['id'] as String,
      reportId: json['reportId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      status: json['status'] as String,
      errorMessage: json['errorMessage'] as String?,
      outputUrl: json['outputUrl'] as String?,
      recordCount: (json['recordCount'] as num?)?.toInt(),
      fileSize: (json['fileSize'] as num?)?.toInt(),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$ScheduledReportRunImplToJson(
        _$ScheduledReportRunImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reportId': instance.reportId,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'status': instance.status,
      'errorMessage': instance.errorMessage,
      'outputUrl': instance.outputUrl,
      'recordCount': instance.recordCount,
      'fileSize': instance.fileSize,
      'metadata': instance.metadata,
    };
