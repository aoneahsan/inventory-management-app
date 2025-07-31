import 'package:freezed_annotation/freezed_annotation.dart';

part 'scheduled_report.freezed.dart';
part 'scheduled_report.g.dart';

enum ReportType {
  @JsonValue('inventory')
  inventory,
  @JsonValue('sales')
  sales,
  @JsonValue('purchase')
  purchase,
  @JsonValue('financial')
  financial,
  @JsonValue('customer')
  customer,
  @JsonValue('supplier')
  supplier,
  @JsonValue('stock_movement')
  stockMovement,
  @JsonValue('low_stock')
  lowStock,
  @JsonValue('expiry')
  expiry,
  @JsonValue('profit_loss')
  profitLoss,
  @JsonValue('tax')
  tax,
  @JsonValue('aging')
  aging,
  @JsonValue('performance')
  performance,
  @JsonValue('forecast')
  forecast,
  @JsonValue('custom')
  custom,
}

enum ReportSchedule {
  @JsonValue('daily')
  daily,
  @JsonValue('weekly')
  weekly,
  @JsonValue('monthly')
  monthly,
  @JsonValue('quarterly')
  quarterly,
  @JsonValue('yearly')
  yearly,
  @JsonValue('on_demand')
  onDemand,
}

enum ReportFormat {
  @JsonValue('pdf')
  pdf,
  @JsonValue('excel')
  excel,
  @JsonValue('csv')
  csv,
  @JsonValue('json')
  json,
  @JsonValue('html')
  html,
}

enum ReportDelivery {
  @JsonValue('email')
  email,
  @JsonValue('webhook')
  webhook,
  @JsonValue('storage')
  storage,
  @JsonValue('download')
  download,
}

@freezed
class ScheduledReport with _$ScheduledReport {
  const factory ScheduledReport({
    required String id,
    required String organizationId,
    required String name,
    required ReportType reportType,
    @Default({}) Map<String, dynamic> parameters,
    required ReportSchedule schedule,
    @Default([]) List<String> recipients,
    required ReportFormat format,
    @Default(true) bool isActive,
    DateTime? lastRun,
    DateTime? nextRun,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
    
    // Additional fields
    String? description,
    @Default([ReportDelivery.email]) List<ReportDelivery> deliveryMethods,
    String? webhookUrl,
    String? storageLocation,
    String? timezone,
    int? dayOfWeek, // 1-7 for weekly reports
    int? dayOfMonth, // 1-31 for monthly reports
    String? timeOfDay, // HH:mm format
    @Default({}) Map<String, dynamic> filters,
    @Default([]) List<String> includedSections,
    @Default([]) List<String> excludedSections,
    String? templateId,
    @Default({}) Map<String, dynamic> customizations,
    String? createdBy,
    String? lastRunBy,
    String? lastRunStatus,
    String? lastRunError,
    int? retryCount,
    DateTime? nextRetryAt,
    @Default(false) bool includeCharts,
    @Default(false) bool includeSummary,
    @Default(false) bool compressOutput,
    String? emailSubjectTemplate,
    String? emailBodyTemplate,
    @Default({}) Map<String, dynamic> metadata,
    @Default([]) List<ScheduledReportRun> recentRuns,
  }) = _ScheduledReport;
  
  const ScheduledReport._();
  
  factory ScheduledReport.fromJson(Map<String, dynamic> json) => 
      _$ScheduledReportFromJson(json);
  
  // Helper methods
  DateTime calculateNextRun() {
    final now = DateTime.now();
    final time = _parseTimeOfDay(timeOfDay ?? '09:00');
    
    switch (schedule) {
      case ReportSchedule.daily:
        var next = DateTime(now.year, now.month, now.day, time.hour, time.minute);
        if (next.isBefore(now)) {
          next = next.add(const Duration(days: 1));
        }
        return next;
        
      case ReportSchedule.weekly:
        final targetDay = dayOfWeek ?? 1; // Default to Monday
        var daysToAdd = (targetDay - now.weekday + 7) % 7;
        if (daysToAdd == 0 && now.hour >= time.hour && now.minute >= time.minute) {
          daysToAdd = 7;
        }
        return DateTime(now.year, now.month, now.day + daysToAdd, time.hour, time.minute);
        
      case ReportSchedule.monthly:
        final targetDay = dayOfMonth ?? 1;
        var next = DateTime(now.year, now.month, targetDay, time.hour, time.minute);
        if (next.isBefore(now)) {
          next = DateTime(now.year, now.month + 1, targetDay, time.hour, time.minute);
        }
        return next;
        
      case ReportSchedule.quarterly:
        final currentQuarter = ((now.month - 1) ~/ 3) + 1;
        final nextQuarter = currentQuarter == 4 ? 1 : currentQuarter + 1;
        final nextYear = currentQuarter == 4 ? now.year + 1 : now.year;
        final nextMonth = (nextQuarter - 1) * 3 + 1;
        return DateTime(nextYear, nextMonth, 1, time.hour, time.minute);
        
      case ReportSchedule.yearly:
        var next = DateTime(now.year + 1, 1, 1, time.hour, time.minute);
        return next;
        
      case ReportSchedule.onDemand:
        return DateTime.now(); // On-demand reports don't have scheduled runs
    }
  }
  
  TimeOfDay _parseTimeOfDay(String time) {
    final parts = time.split(':');
    final hour = int.tryParse(parts[0]) ?? 9;
    final minute = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;
    return TimeOfDay(hour: hour, minute: minute);
  }
  
  bool get isDue {
    if (nextRun == null || !isActive) return false;
    return DateTime.now().isAfter(nextRun!);
  }
  
  bool get isOverdue {
    if (nextRun == null || !isActive) return false;
    return DateTime.now().difference(nextRun!).inHours > 24;
  }
  
  bool get hasError => lastRunStatus == 'failed' || lastRunError != null;
  bool get isRetrying => retryCount != null && retryCount! > 0;
  bool get hasWebhook => deliveryMethods.contains(ReportDelivery.webhook);
  bool get hasEmailDelivery => deliveryMethods.contains(ReportDelivery.email);
  
  String get scheduleDisplay {
    switch (schedule) {
      case ReportSchedule.daily:
        return 'Daily at ${timeOfDay ?? "09:00"}';
      case ReportSchedule.weekly:
        final dayName = _getDayName(dayOfWeek ?? 1);
        return 'Weekly on $dayName at ${timeOfDay ?? "09:00"}';
      case ReportSchedule.monthly:
        return 'Monthly on day ${dayOfMonth ?? 1} at ${timeOfDay ?? "09:00"}';
      case ReportSchedule.quarterly:
        return 'Quarterly at ${timeOfDay ?? "09:00"}';
      case ReportSchedule.yearly:
        return 'Yearly on Jan 1 at ${timeOfDay ?? "09:00"}';
      case ReportSchedule.onDemand:
        return 'On Demand';
    }
  }
  
  String _getDayName(int day) {
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[(day - 1) % 7];
  }
  
  String get typeDisplay {
    switch (reportType) {
      case ReportType.inventory:
        return 'Inventory Report';
      case ReportType.sales:
        return 'Sales Report';
      case ReportType.purchase:
        return 'Purchase Report';
      case ReportType.financial:
        return 'Financial Report';
      case ReportType.customer:
        return 'Customer Report';
      case ReportType.supplier:
        return 'Supplier Report';
      case ReportType.stockMovement:
        return 'Stock Movement Report';
      case ReportType.lowStock:
        return 'Low Stock Alert';
      case ReportType.expiry:
        return 'Expiry Report';
      case ReportType.profitLoss:
        return 'Profit & Loss Report';
      case ReportType.tax:
        return 'Tax Report';
      case ReportType.aging:
        return 'Aging Report';
      case ReportType.performance:
        return 'Performance Report';
      case ReportType.forecast:
        return 'Forecast Report';
      case ReportType.custom:
        return 'Custom Report';
    }
  }
  
  List<String> get activeRecipients {
    if (!hasEmailDelivery) return [];
    return recipients;
  }
}

@freezed
class ScheduledReportRun with _$ScheduledReportRun {
  const factory ScheduledReportRun({
    required String id,
    required String reportId,
    required DateTime startTime,
    DateTime? endTime,
    required String status,
    String? errorMessage,
    String? outputUrl,
    int? recordCount,
    int? fileSize,
    @Default({}) Map<String, dynamic> metadata,
  }) = _ScheduledReportRun;
  
  const ScheduledReportRun._();
  
  factory ScheduledReportRun.fromJson(Map<String, dynamic> json) => 
      _$ScheduledReportRunFromJson(json);
  
  Duration? get duration {
    if (endTime == null) return null;
    return endTime!.difference(startTime);
  }
  
  bool get isSuccess => status == 'success';
  bool get isFailed => status == 'failed';
  bool get isRunning => status == 'running';
}

class TimeOfDay {
  final int hour;
  final int minute;
  
  const TimeOfDay({required this.hour, required this.minute});
  
  @override
  String toString() => '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}

// Report parameter builders
class ReportParameterBuilders {
  static Map<String, dynamic> inventoryReport({
    List<String>? branchIds,
    List<String>? categoryIds,
    bool includeInactive = false,
    bool includeZeroStock = false,
    String? sortBy,
  }) {
    return {
      if (branchIds != null) 'branchIds': branchIds,
      if (categoryIds != null) 'categoryIds': categoryIds,
      'includeInactive': includeInactive,
      'includeZeroStock': includeZeroStock,
      if (sortBy != null) 'sortBy': sortBy,
    };
  }
  
  static Map<String, dynamic> salesReport({
    DateTime? startDate,
    DateTime? endDate,
    List<String>? branchIds,
    List<String>? productIds,
    List<String>? customerIds,
    String? groupBy,
  }) {
    return {
      if (startDate != null) 'startDate': startDate.toIso8601String(),
      if (endDate != null) 'endDate': endDate.toIso8601String(),
      if (branchIds != null) 'branchIds': branchIds,
      if (productIds != null) 'productIds': productIds,
      if (customerIds != null) 'customerIds': customerIds,
      if (groupBy != null) 'groupBy': groupBy,
    };
  }
}