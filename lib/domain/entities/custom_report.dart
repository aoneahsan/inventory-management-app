import 'package:equatable/equatable.dart';

class CustomReport extends Equatable {
  final String id;
  final String organizationId;
  final String name;
  final String description;
  final String entityType;
  final List<String> selectedFields;
  final List<ReportFilter> filters;
  final List<String> groupBy;
  final String? sortBy;
  final bool sortAscending;
  final String createdBy;
  final DateTime createdAt;
  final DateTime? lastRun;

  const CustomReport({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.description,
    required this.entityType,
    required this.selectedFields,
    required this.filters,
    required this.groupBy,
    this.sortBy,
    this.sortAscending = true,
    required this.createdBy,
    required this.createdAt,
    this.lastRun,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organization_id': organizationId,
      'name': name,
      'description': description,
      'entity_type': entityType,
      'selected_fields': selectedFields,
      'filters': filters.map((f) => f.toJson()).toList(),
      'group_by': groupBy,
      'sort_by': sortBy,
      'sort_ascending': sortAscending,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'last_run': lastRun?.toIso8601String(),
    };
  }

  factory CustomReport.fromJson(Map<String, dynamic> json) {
    return CustomReport(
      id: json['id'] as String,
      organizationId: json['organization_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      entityType: json['entity_type'] as String,
      selectedFields: List<String>.from(json['selected_fields']),
      filters: (json['filters'] as List).map((f) => ReportFilter.fromJson(f)).toList(),
      groupBy: List<String>.from(json['group_by'] ?? []),
      sortBy: json['sort_by'] as String?,
      sortAscending: json['sort_ascending'] as bool? ?? true,
      createdBy: json['created_by'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      lastRun: json['last_run'] != null ? DateTime.parse(json['last_run'] as String) : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        organizationId,
        name,
        description,
        entityType,
        selectedFields,
        filters,
        groupBy,
        sortBy,
        sortAscending,
        createdBy,
        createdAt,
        lastRun,
      ];
}

class ReportFilter extends Equatable {
  final String field;
  final String operator;
  final dynamic value;

  const ReportFilter({
    required this.field,
    required this.operator,
    required this.value,
  });

  Map<String, dynamic> toJson() {
    return {
      'field': field,
      'operator': operator,
      'value': value,
    };
  }

  factory ReportFilter.fromJson(Map<String, dynamic> json) {
    return ReportFilter(
      field: json['field'] as String,
      operator: json['operator'] as String,
      value: json['value'],
    );
  }

  @override
  List<Object?> get props => [field, operator, value];
}