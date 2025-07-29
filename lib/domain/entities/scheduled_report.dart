import 'dart:convert';
import 'package:equatable/equatable.dart';

class ScheduledReport extends Equatable {
  final String id;
  final String organizationId;
  final String name;
  final ReportType reportType;
  final Map<String, dynamic>? parameters;
  final ReportSchedule schedule;
  final List<String> recipients;
  final ReportFormat format;
  final bool isActive;
  final DateTime? lastRun;
  final DateTime? nextRun;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ScheduledReport({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.reportType,
    this.parameters,
    required this.schedule,
    required this.recipients,
    required this.format,
    required this.isActive,
    this.lastRun,
    this.nextRun,
    required this.createdAt,
    required this.updatedAt,
  });
  
  ReportFrequency get frequency => schedule == ReportSchedule.daily
      ? ReportFrequency.daily
      : schedule == ReportSchedule.weekly
          ? ReportFrequency.weekly
          : ReportFrequency.monthly;
          
  DateTime? get lastRunAt => lastRun;
  DateTime? get nextRunAt => nextRun;
  String? get deliveryTime => parameters?['deliveryTime'] ?? '9:00 AM';

  ScheduledReport copyWith({
    String? id,
    String? organizationId,
    String? name,
    ReportType? reportType,
    Map<String, dynamic>? parameters,
    ReportSchedule? schedule,
    List<String>? recipients,
    ReportFormat? format,
    bool? isActive,
    DateTime? lastRun,
    DateTime? nextRun,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ScheduledReport(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      name: name ?? this.name,
      reportType: reportType ?? this.reportType,
      parameters: parameters ?? this.parameters,
      schedule: schedule ?? this.schedule,
      recipients: recipients ?? this.recipients,
      format: format ?? this.format,
      isActive: isActive ?? this.isActive,
      lastRun: lastRun ?? this.lastRun,
      nextRun: nextRun ?? this.nextRun,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'organization_id': organizationId,
      'name': name,
      'report_type': reportType.value,
      'parameters': parameters != null ? jsonEncode(parameters) : null,
      'schedule': schedule.value,
      'recipients': jsonEncode(recipients),
      'format': format.value,
      'is_active': isActive ? 1 : 0,
      'last_run': lastRun?.millisecondsSinceEpoch,
      'next_run': nextRun?.millisecondsSinceEpoch,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory ScheduledReport.fromMap(Map<String, dynamic> map) {
    return ScheduledReport(
      id: map['id'],
      organizationId: map['organization_id'],
      name: map['name'],
      reportType: ReportType.fromString(map['report_type']),
      parameters: map['parameters'] != null
          ? jsonDecode(map['parameters']) as Map<String, dynamic>
          : null,
      schedule: ReportSchedule.fromString(map['schedule']),
      recipients: List<String>.from(jsonDecode(map['recipients'])),
      format: ReportFormat.fromString(map['format']),
      isActive: map['is_active'] == 1,
      lastRun: map['last_run'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['last_run'])
          : null,
      nextRun: map['next_run'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['next_run'])
          : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  DateTime calculateNextRun() {
    final now = DateTime.now();
    switch (schedule) {
      case ReportSchedule.daily:
        return DateTime(now.year, now.month, now.day + 1, 6, 0); // 6 AM next day
      case ReportSchedule.weekly:
        final daysUntilMonday = (8 - now.weekday) % 7;
        return DateTime(now.year, now.month, now.day + daysUntilMonday, 6, 0);
      case ReportSchedule.monthly:
        if (now.month == 12) {
          return DateTime(now.year + 1, 1, 1, 6, 0);
        } else {
          return DateTime(now.year, now.month + 1, 1, 6, 0);
        }
    }
  }

  @override
  List<Object?> get props => [
        id,
        organizationId,
        name,
        reportType,
        parameters,
        schedule,
        recipients,
        format,
        isActive,
        lastRun,
        nextRun,
        createdAt,
        updatedAt,
      ];
}

enum ReportType {
  inventory('inventory'),
  sales('sales'),
  purchase('purchase'),
  financial('financial'),
  customer('customer'),
  supplier('supplier'),
  stockMovement('stock_movement'),
  lowStock('low_stock'),
  expiry('expiry'),
  custom('custom');

  final String value;
  const ReportType(this.value);

  static ReportType fromString(String value) {
    return ReportType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => ReportType.custom,
    );
  }
}

enum ReportSchedule {
  daily('daily'),
  weekly('weekly'),
  monthly('monthly');

  final String value;
  const ReportSchedule(this.value);

  static ReportSchedule fromString(String value) {
    return ReportSchedule.values.firstWhere(
      (schedule) => schedule.value == value,
      orElse: () => ReportSchedule.monthly,
    );
  }
}

enum ReportFormat {
  pdf('pdf'),
  excel('excel'),
  csv('csv');

  final String value;
  const ReportFormat(this.value);

  static ReportFormat fromString(String value) {
    return ReportFormat.values.firstWhere(
      (format) => format.value == value,
      orElse: () => ReportFormat.pdf,
    );
  }
}

// Type aliases for UI compatibility
typedef ReportFrequency = ReportSchedule;

extension ReportTypeExtension on ReportType {
  String get displayName {
    switch (this) {
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
        return 'Stock Movement';
      case ReportType.lowStock:
        return 'Low Stock Alert';
      case ReportType.expiry:
        return 'Expiry Report';
      case ReportType.custom:
        return 'Custom Report';
    }
  }
}

extension ReportScheduleExtension on ReportSchedule {
  String get displayName {
    switch (this) {
      case ReportSchedule.daily:
        return 'Daily';
      case ReportSchedule.weekly:
        return 'Weekly';
      case ReportSchedule.monthly:
        return 'Monthly';
    }
  }
}

extension ReportFormatExtension on ReportFormat {
  String get displayName {
    switch (this) {
      case ReportFormat.pdf:
        return 'PDF';
      case ReportFormat.excel:
        return 'Excel';
      case ReportFormat.csv:
        return 'CSV';
    }
  }
}