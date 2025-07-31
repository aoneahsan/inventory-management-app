// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scheduled_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ScheduledReport _$ScheduledReportFromJson(Map<String, dynamic> json) {
  return _ScheduledReport.fromJson(json);
}

/// @nodoc
mixin _$ScheduledReport {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  ReportType get reportType => throw _privateConstructorUsedError;
  Map<String, dynamic> get parameters => throw _privateConstructorUsedError;
  ReportSchedule get schedule => throw _privateConstructorUsedError;
  List<String> get recipients => throw _privateConstructorUsedError;
  ReportFormat get format => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get lastRun => throw _privateConstructorUsedError;
  DateTime? get nextRun => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional fields
  String? get description => throw _privateConstructorUsedError;
  List<ReportDelivery> get deliveryMethods =>
      throw _privateConstructorUsedError;
  String? get webhookUrl => throw _privateConstructorUsedError;
  String? get storageLocation => throw _privateConstructorUsedError;
  String? get timezone => throw _privateConstructorUsedError;
  int? get dayOfWeek =>
      throw _privateConstructorUsedError; // 1-7 for weekly reports
  int? get dayOfMonth =>
      throw _privateConstructorUsedError; // 1-31 for monthly reports
  String? get timeOfDay => throw _privateConstructorUsedError; // HH:mm format
  Map<String, dynamic> get filters => throw _privateConstructorUsedError;
  List<String> get includedSections => throw _privateConstructorUsedError;
  List<String> get excludedSections => throw _privateConstructorUsedError;
  String? get templateId => throw _privateConstructorUsedError;
  Map<String, dynamic> get customizations => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;
  String? get lastRunBy => throw _privateConstructorUsedError;
  String? get lastRunStatus => throw _privateConstructorUsedError;
  String? get lastRunError => throw _privateConstructorUsedError;
  int? get retryCount => throw _privateConstructorUsedError;
  DateTime? get nextRetryAt => throw _privateConstructorUsedError;
  bool get includeCharts => throw _privateConstructorUsedError;
  bool get includeSummary => throw _privateConstructorUsedError;
  bool get compressOutput => throw _privateConstructorUsedError;
  String? get emailSubjectTemplate => throw _privateConstructorUsedError;
  String? get emailBodyTemplate => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  List<ScheduledReportRun> get recentRuns => throw _privateConstructorUsedError;

  /// Serializes this ScheduledReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScheduledReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScheduledReportCopyWith<ScheduledReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduledReportCopyWith<$Res> {
  factory $ScheduledReportCopyWith(
          ScheduledReport value, $Res Function(ScheduledReport) then) =
      _$ScheduledReportCopyWithImpl<$Res, ScheduledReport>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String name,
      ReportType reportType,
      Map<String, dynamic> parameters,
      ReportSchedule schedule,
      List<String> recipients,
      ReportFormat format,
      bool isActive,
      DateTime? lastRun,
      DateTime? nextRun,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? description,
      List<ReportDelivery> deliveryMethods,
      String? webhookUrl,
      String? storageLocation,
      String? timezone,
      int? dayOfWeek,
      int? dayOfMonth,
      String? timeOfDay,
      Map<String, dynamic> filters,
      List<String> includedSections,
      List<String> excludedSections,
      String? templateId,
      Map<String, dynamic> customizations,
      String? createdBy,
      String? lastRunBy,
      String? lastRunStatus,
      String? lastRunError,
      int? retryCount,
      DateTime? nextRetryAt,
      bool includeCharts,
      bool includeSummary,
      bool compressOutput,
      String? emailSubjectTemplate,
      String? emailBodyTemplate,
      Map<String, dynamic> metadata,
      List<ScheduledReportRun> recentRuns});
}

/// @nodoc
class _$ScheduledReportCopyWithImpl<$Res, $Val extends ScheduledReport>
    implements $ScheduledReportCopyWith<$Res> {
  _$ScheduledReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScheduledReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? name = null,
    Object? reportType = null,
    Object? parameters = null,
    Object? schedule = null,
    Object? recipients = null,
    Object? format = null,
    Object? isActive = null,
    Object? lastRun = freezed,
    Object? nextRun = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? description = freezed,
    Object? deliveryMethods = null,
    Object? webhookUrl = freezed,
    Object? storageLocation = freezed,
    Object? timezone = freezed,
    Object? dayOfWeek = freezed,
    Object? dayOfMonth = freezed,
    Object? timeOfDay = freezed,
    Object? filters = null,
    Object? includedSections = null,
    Object? excludedSections = null,
    Object? templateId = freezed,
    Object? customizations = null,
    Object? createdBy = freezed,
    Object? lastRunBy = freezed,
    Object? lastRunStatus = freezed,
    Object? lastRunError = freezed,
    Object? retryCount = freezed,
    Object? nextRetryAt = freezed,
    Object? includeCharts = null,
    Object? includeSummary = null,
    Object? compressOutput = null,
    Object? emailSubjectTemplate = freezed,
    Object? emailBodyTemplate = freezed,
    Object? metadata = null,
    Object? recentRuns = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      reportType: null == reportType
          ? _value.reportType
          : reportType // ignore: cast_nullable_to_non_nullable
              as ReportType,
      parameters: null == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      schedule: null == schedule
          ? _value.schedule
          : schedule // ignore: cast_nullable_to_non_nullable
              as ReportSchedule,
      recipients: null == recipients
          ? _value.recipients
          : recipients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as ReportFormat,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      lastRun: freezed == lastRun
          ? _value.lastRun
          : lastRun // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextRun: freezed == nextRun
          ? _value.nextRun
          : nextRun // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryMethods: null == deliveryMethods
          ? _value.deliveryMethods
          : deliveryMethods // ignore: cast_nullable_to_non_nullable
              as List<ReportDelivery>,
      webhookUrl: freezed == webhookUrl
          ? _value.webhookUrl
          : webhookUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      storageLocation: freezed == storageLocation
          ? _value.storageLocation
          : storageLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      timezone: freezed == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String?,
      dayOfWeek: freezed == dayOfWeek
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as int?,
      dayOfMonth: freezed == dayOfMonth
          ? _value.dayOfMonth
          : dayOfMonth // ignore: cast_nullable_to_non_nullable
              as int?,
      timeOfDay: freezed == timeOfDay
          ? _value.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as String?,
      filters: null == filters
          ? _value.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      includedSections: null == includedSections
          ? _value.includedSections
          : includedSections // ignore: cast_nullable_to_non_nullable
              as List<String>,
      excludedSections: null == excludedSections
          ? _value.excludedSections
          : excludedSections // ignore: cast_nullable_to_non_nullable
              as List<String>,
      templateId: freezed == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String?,
      customizations: null == customizations
          ? _value.customizations
          : customizations // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      lastRunBy: freezed == lastRunBy
          ? _value.lastRunBy
          : lastRunBy // ignore: cast_nullable_to_non_nullable
              as String?,
      lastRunStatus: freezed == lastRunStatus
          ? _value.lastRunStatus
          : lastRunStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      lastRunError: freezed == lastRunError
          ? _value.lastRunError
          : lastRunError // ignore: cast_nullable_to_non_nullable
              as String?,
      retryCount: freezed == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int?,
      nextRetryAt: freezed == nextRetryAt
          ? _value.nextRetryAt
          : nextRetryAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      includeCharts: null == includeCharts
          ? _value.includeCharts
          : includeCharts // ignore: cast_nullable_to_non_nullable
              as bool,
      includeSummary: null == includeSummary
          ? _value.includeSummary
          : includeSummary // ignore: cast_nullable_to_non_nullable
              as bool,
      compressOutput: null == compressOutput
          ? _value.compressOutput
          : compressOutput // ignore: cast_nullable_to_non_nullable
              as bool,
      emailSubjectTemplate: freezed == emailSubjectTemplate
          ? _value.emailSubjectTemplate
          : emailSubjectTemplate // ignore: cast_nullable_to_non_nullable
              as String?,
      emailBodyTemplate: freezed == emailBodyTemplate
          ? _value.emailBodyTemplate
          : emailBodyTemplate // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      recentRuns: null == recentRuns
          ? _value.recentRuns
          : recentRuns // ignore: cast_nullable_to_non_nullable
              as List<ScheduledReportRun>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScheduledReportImplCopyWith<$Res>
    implements $ScheduledReportCopyWith<$Res> {
  factory _$$ScheduledReportImplCopyWith(_$ScheduledReportImpl value,
          $Res Function(_$ScheduledReportImpl) then) =
      __$$ScheduledReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String name,
      ReportType reportType,
      Map<String, dynamic> parameters,
      ReportSchedule schedule,
      List<String> recipients,
      ReportFormat format,
      bool isActive,
      DateTime? lastRun,
      DateTime? nextRun,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? description,
      List<ReportDelivery> deliveryMethods,
      String? webhookUrl,
      String? storageLocation,
      String? timezone,
      int? dayOfWeek,
      int? dayOfMonth,
      String? timeOfDay,
      Map<String, dynamic> filters,
      List<String> includedSections,
      List<String> excludedSections,
      String? templateId,
      Map<String, dynamic> customizations,
      String? createdBy,
      String? lastRunBy,
      String? lastRunStatus,
      String? lastRunError,
      int? retryCount,
      DateTime? nextRetryAt,
      bool includeCharts,
      bool includeSummary,
      bool compressOutput,
      String? emailSubjectTemplate,
      String? emailBodyTemplate,
      Map<String, dynamic> metadata,
      List<ScheduledReportRun> recentRuns});
}

/// @nodoc
class __$$ScheduledReportImplCopyWithImpl<$Res>
    extends _$ScheduledReportCopyWithImpl<$Res, _$ScheduledReportImpl>
    implements _$$ScheduledReportImplCopyWith<$Res> {
  __$$ScheduledReportImplCopyWithImpl(
      _$ScheduledReportImpl _value, $Res Function(_$ScheduledReportImpl) _then)
      : super(_value, _then);

  /// Create a copy of ScheduledReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? name = null,
    Object? reportType = null,
    Object? parameters = null,
    Object? schedule = null,
    Object? recipients = null,
    Object? format = null,
    Object? isActive = null,
    Object? lastRun = freezed,
    Object? nextRun = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? description = freezed,
    Object? deliveryMethods = null,
    Object? webhookUrl = freezed,
    Object? storageLocation = freezed,
    Object? timezone = freezed,
    Object? dayOfWeek = freezed,
    Object? dayOfMonth = freezed,
    Object? timeOfDay = freezed,
    Object? filters = null,
    Object? includedSections = null,
    Object? excludedSections = null,
    Object? templateId = freezed,
    Object? customizations = null,
    Object? createdBy = freezed,
    Object? lastRunBy = freezed,
    Object? lastRunStatus = freezed,
    Object? lastRunError = freezed,
    Object? retryCount = freezed,
    Object? nextRetryAt = freezed,
    Object? includeCharts = null,
    Object? includeSummary = null,
    Object? compressOutput = null,
    Object? emailSubjectTemplate = freezed,
    Object? emailBodyTemplate = freezed,
    Object? metadata = null,
    Object? recentRuns = null,
  }) {
    return _then(_$ScheduledReportImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      reportType: null == reportType
          ? _value.reportType
          : reportType // ignore: cast_nullable_to_non_nullable
              as ReportType,
      parameters: null == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      schedule: null == schedule
          ? _value.schedule
          : schedule // ignore: cast_nullable_to_non_nullable
              as ReportSchedule,
      recipients: null == recipients
          ? _value._recipients
          : recipients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as ReportFormat,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      lastRun: freezed == lastRun
          ? _value.lastRun
          : lastRun // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextRun: freezed == nextRun
          ? _value.nextRun
          : nextRun // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryMethods: null == deliveryMethods
          ? _value._deliveryMethods
          : deliveryMethods // ignore: cast_nullable_to_non_nullable
              as List<ReportDelivery>,
      webhookUrl: freezed == webhookUrl
          ? _value.webhookUrl
          : webhookUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      storageLocation: freezed == storageLocation
          ? _value.storageLocation
          : storageLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      timezone: freezed == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String?,
      dayOfWeek: freezed == dayOfWeek
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as int?,
      dayOfMonth: freezed == dayOfMonth
          ? _value.dayOfMonth
          : dayOfMonth // ignore: cast_nullable_to_non_nullable
              as int?,
      timeOfDay: freezed == timeOfDay
          ? _value.timeOfDay
          : timeOfDay // ignore: cast_nullable_to_non_nullable
              as String?,
      filters: null == filters
          ? _value._filters
          : filters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      includedSections: null == includedSections
          ? _value._includedSections
          : includedSections // ignore: cast_nullable_to_non_nullable
              as List<String>,
      excludedSections: null == excludedSections
          ? _value._excludedSections
          : excludedSections // ignore: cast_nullable_to_non_nullable
              as List<String>,
      templateId: freezed == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String?,
      customizations: null == customizations
          ? _value._customizations
          : customizations // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      lastRunBy: freezed == lastRunBy
          ? _value.lastRunBy
          : lastRunBy // ignore: cast_nullable_to_non_nullable
              as String?,
      lastRunStatus: freezed == lastRunStatus
          ? _value.lastRunStatus
          : lastRunStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      lastRunError: freezed == lastRunError
          ? _value.lastRunError
          : lastRunError // ignore: cast_nullable_to_non_nullable
              as String?,
      retryCount: freezed == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int?,
      nextRetryAt: freezed == nextRetryAt
          ? _value.nextRetryAt
          : nextRetryAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      includeCharts: null == includeCharts
          ? _value.includeCharts
          : includeCharts // ignore: cast_nullable_to_non_nullable
              as bool,
      includeSummary: null == includeSummary
          ? _value.includeSummary
          : includeSummary // ignore: cast_nullable_to_non_nullable
              as bool,
      compressOutput: null == compressOutput
          ? _value.compressOutput
          : compressOutput // ignore: cast_nullable_to_non_nullable
              as bool,
      emailSubjectTemplate: freezed == emailSubjectTemplate
          ? _value.emailSubjectTemplate
          : emailSubjectTemplate // ignore: cast_nullable_to_non_nullable
              as String?,
      emailBodyTemplate: freezed == emailBodyTemplate
          ? _value.emailBodyTemplate
          : emailBodyTemplate // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      recentRuns: null == recentRuns
          ? _value._recentRuns
          : recentRuns // ignore: cast_nullable_to_non_nullable
              as List<ScheduledReportRun>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduledReportImpl extends _ScheduledReport {
  const _$ScheduledReportImpl(
      {required this.id,
      required this.organizationId,
      required this.name,
      required this.reportType,
      final Map<String, dynamic> parameters = const {},
      required this.schedule,
      final List<String> recipients = const [],
      required this.format,
      this.isActive = true,
      this.lastRun,
      this.nextRun,
      required this.createdAt,
      required this.updatedAt,
      this.syncedAt,
      this.description,
      final List<ReportDelivery> deliveryMethods = const [ReportDelivery.email],
      this.webhookUrl,
      this.storageLocation,
      this.timezone,
      this.dayOfWeek,
      this.dayOfMonth,
      this.timeOfDay,
      final Map<String, dynamic> filters = const {},
      final List<String> includedSections = const [],
      final List<String> excludedSections = const [],
      this.templateId,
      final Map<String, dynamic> customizations = const {},
      this.createdBy,
      this.lastRunBy,
      this.lastRunStatus,
      this.lastRunError,
      this.retryCount,
      this.nextRetryAt,
      this.includeCharts = false,
      this.includeSummary = false,
      this.compressOutput = false,
      this.emailSubjectTemplate,
      this.emailBodyTemplate,
      final Map<String, dynamic> metadata = const {},
      final List<ScheduledReportRun> recentRuns = const []})
      : _parameters = parameters,
        _recipients = recipients,
        _deliveryMethods = deliveryMethods,
        _filters = filters,
        _includedSections = includedSections,
        _excludedSections = excludedSections,
        _customizations = customizations,
        _metadata = metadata,
        _recentRuns = recentRuns,
        super._();

  factory _$ScheduledReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduledReportImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String name;
  @override
  final ReportType reportType;
  final Map<String, dynamic> _parameters;
  @override
  @JsonKey()
  Map<String, dynamic> get parameters {
    if (_parameters is EqualUnmodifiableMapView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_parameters);
  }

  @override
  final ReportSchedule schedule;
  final List<String> _recipients;
  @override
  @JsonKey()
  List<String> get recipients {
    if (_recipients is EqualUnmodifiableListView) return _recipients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recipients);
  }

  @override
  final ReportFormat format;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime? lastRun;
  @override
  final DateTime? nextRun;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? syncedAt;
// Additional fields
  @override
  final String? description;
  final List<ReportDelivery> _deliveryMethods;
  @override
  @JsonKey()
  List<ReportDelivery> get deliveryMethods {
    if (_deliveryMethods is EqualUnmodifiableListView) return _deliveryMethods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deliveryMethods);
  }

  @override
  final String? webhookUrl;
  @override
  final String? storageLocation;
  @override
  final String? timezone;
  @override
  final int? dayOfWeek;
// 1-7 for weekly reports
  @override
  final int? dayOfMonth;
// 1-31 for monthly reports
  @override
  final String? timeOfDay;
// HH:mm format
  final Map<String, dynamic> _filters;
// HH:mm format
  @override
  @JsonKey()
  Map<String, dynamic> get filters {
    if (_filters is EqualUnmodifiableMapView) return _filters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_filters);
  }

  final List<String> _includedSections;
  @override
  @JsonKey()
  List<String> get includedSections {
    if (_includedSections is EqualUnmodifiableListView)
      return _includedSections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_includedSections);
  }

  final List<String> _excludedSections;
  @override
  @JsonKey()
  List<String> get excludedSections {
    if (_excludedSections is EqualUnmodifiableListView)
      return _excludedSections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_excludedSections);
  }

  @override
  final String? templateId;
  final Map<String, dynamic> _customizations;
  @override
  @JsonKey()
  Map<String, dynamic> get customizations {
    if (_customizations is EqualUnmodifiableMapView) return _customizations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_customizations);
  }

  @override
  final String? createdBy;
  @override
  final String? lastRunBy;
  @override
  final String? lastRunStatus;
  @override
  final String? lastRunError;
  @override
  final int? retryCount;
  @override
  final DateTime? nextRetryAt;
  @override
  @JsonKey()
  final bool includeCharts;
  @override
  @JsonKey()
  final bool includeSummary;
  @override
  @JsonKey()
  final bool compressOutput;
  @override
  final String? emailSubjectTemplate;
  @override
  final String? emailBodyTemplate;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  final List<ScheduledReportRun> _recentRuns;
  @override
  @JsonKey()
  List<ScheduledReportRun> get recentRuns {
    if (_recentRuns is EqualUnmodifiableListView) return _recentRuns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentRuns);
  }

  @override
  String toString() {
    return 'ScheduledReport(id: $id, organizationId: $organizationId, name: $name, reportType: $reportType, parameters: $parameters, schedule: $schedule, recipients: $recipients, format: $format, isActive: $isActive, lastRun: $lastRun, nextRun: $nextRun, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt, description: $description, deliveryMethods: $deliveryMethods, webhookUrl: $webhookUrl, storageLocation: $storageLocation, timezone: $timezone, dayOfWeek: $dayOfWeek, dayOfMonth: $dayOfMonth, timeOfDay: $timeOfDay, filters: $filters, includedSections: $includedSections, excludedSections: $excludedSections, templateId: $templateId, customizations: $customizations, createdBy: $createdBy, lastRunBy: $lastRunBy, lastRunStatus: $lastRunStatus, lastRunError: $lastRunError, retryCount: $retryCount, nextRetryAt: $nextRetryAt, includeCharts: $includeCharts, includeSummary: $includeSummary, compressOutput: $compressOutput, emailSubjectTemplate: $emailSubjectTemplate, emailBodyTemplate: $emailBodyTemplate, metadata: $metadata, recentRuns: $recentRuns)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduledReportImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.reportType, reportType) ||
                other.reportType == reportType) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters) &&
            (identical(other.schedule, schedule) ||
                other.schedule == schedule) &&
            const DeepCollectionEquality()
                .equals(other._recipients, _recipients) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.lastRun, lastRun) || other.lastRun == lastRun) &&
            (identical(other.nextRun, nextRun) || other.nextRun == nextRun) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._deliveryMethods, _deliveryMethods) &&
            (identical(other.webhookUrl, webhookUrl) ||
                other.webhookUrl == webhookUrl) &&
            (identical(other.storageLocation, storageLocation) ||
                other.storageLocation == storageLocation) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            (identical(other.dayOfMonth, dayOfMonth) ||
                other.dayOfMonth == dayOfMonth) &&
            (identical(other.timeOfDay, timeOfDay) ||
                other.timeOfDay == timeOfDay) &&
            const DeepCollectionEquality().equals(other._filters, _filters) &&
            const DeepCollectionEquality()
                .equals(other._includedSections, _includedSections) &&
            const DeepCollectionEquality()
                .equals(other._excludedSections, _excludedSections) &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            const DeepCollectionEquality()
                .equals(other._customizations, _customizations) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.lastRunBy, lastRunBy) ||
                other.lastRunBy == lastRunBy) &&
            (identical(other.lastRunStatus, lastRunStatus) ||
                other.lastRunStatus == lastRunStatus) &&
            (identical(other.lastRunError, lastRunError) ||
                other.lastRunError == lastRunError) &&
            (identical(other.retryCount, retryCount) ||
                other.retryCount == retryCount) &&
            (identical(other.nextRetryAt, nextRetryAt) ||
                other.nextRetryAt == nextRetryAt) &&
            (identical(other.includeCharts, includeCharts) ||
                other.includeCharts == includeCharts) &&
            (identical(other.includeSummary, includeSummary) ||
                other.includeSummary == includeSummary) &&
            (identical(other.compressOutput, compressOutput) ||
                other.compressOutput == compressOutput) &&
            (identical(other.emailSubjectTemplate, emailSubjectTemplate) ||
                other.emailSubjectTemplate == emailSubjectTemplate) &&
            (identical(other.emailBodyTemplate, emailBodyTemplate) ||
                other.emailBodyTemplate == emailBodyTemplate) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            const DeepCollectionEquality()
                .equals(other._recentRuns, _recentRuns));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        organizationId,
        name,
        reportType,
        const DeepCollectionEquality().hash(_parameters),
        schedule,
        const DeepCollectionEquality().hash(_recipients),
        format,
        isActive,
        lastRun,
        nextRun,
        createdAt,
        updatedAt,
        syncedAt,
        description,
        const DeepCollectionEquality().hash(_deliveryMethods),
        webhookUrl,
        storageLocation,
        timezone,
        dayOfWeek,
        dayOfMonth,
        timeOfDay,
        const DeepCollectionEquality().hash(_filters),
        const DeepCollectionEquality().hash(_includedSections),
        const DeepCollectionEquality().hash(_excludedSections),
        templateId,
        const DeepCollectionEquality().hash(_customizations),
        createdBy,
        lastRunBy,
        lastRunStatus,
        lastRunError,
        retryCount,
        nextRetryAt,
        includeCharts,
        includeSummary,
        compressOutput,
        emailSubjectTemplate,
        emailBodyTemplate,
        const DeepCollectionEquality().hash(_metadata),
        const DeepCollectionEquality().hash(_recentRuns)
      ]);

  /// Create a copy of ScheduledReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduledReportImplCopyWith<_$ScheduledReportImpl> get copyWith =>
      __$$ScheduledReportImplCopyWithImpl<_$ScheduledReportImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduledReportImplToJson(
      this,
    );
  }
}

abstract class _ScheduledReport extends ScheduledReport {
  const factory _ScheduledReport(
      {required final String id,
      required final String organizationId,
      required final String name,
      required final ReportType reportType,
      final Map<String, dynamic> parameters,
      required final ReportSchedule schedule,
      final List<String> recipients,
      required final ReportFormat format,
      final bool isActive,
      final DateTime? lastRun,
      final DateTime? nextRun,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final DateTime? syncedAt,
      final String? description,
      final List<ReportDelivery> deliveryMethods,
      final String? webhookUrl,
      final String? storageLocation,
      final String? timezone,
      final int? dayOfWeek,
      final int? dayOfMonth,
      final String? timeOfDay,
      final Map<String, dynamic> filters,
      final List<String> includedSections,
      final List<String> excludedSections,
      final String? templateId,
      final Map<String, dynamic> customizations,
      final String? createdBy,
      final String? lastRunBy,
      final String? lastRunStatus,
      final String? lastRunError,
      final int? retryCount,
      final DateTime? nextRetryAt,
      final bool includeCharts,
      final bool includeSummary,
      final bool compressOutput,
      final String? emailSubjectTemplate,
      final String? emailBodyTemplate,
      final Map<String, dynamic> metadata,
      final List<ScheduledReportRun> recentRuns}) = _$ScheduledReportImpl;
  const _ScheduledReport._() : super._();

  factory _ScheduledReport.fromJson(Map<String, dynamic> json) =
      _$ScheduledReportImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String get name;
  @override
  ReportType get reportType;
  @override
  Map<String, dynamic> get parameters;
  @override
  ReportSchedule get schedule;
  @override
  List<String> get recipients;
  @override
  ReportFormat get format;
  @override
  bool get isActive;
  @override
  DateTime? get lastRun;
  @override
  DateTime? get nextRun;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get syncedAt; // Additional fields
  @override
  String? get description;
  @override
  List<ReportDelivery> get deliveryMethods;
  @override
  String? get webhookUrl;
  @override
  String? get storageLocation;
  @override
  String? get timezone;
  @override
  int? get dayOfWeek; // 1-7 for weekly reports
  @override
  int? get dayOfMonth; // 1-31 for monthly reports
  @override
  String? get timeOfDay; // HH:mm format
  @override
  Map<String, dynamic> get filters;
  @override
  List<String> get includedSections;
  @override
  List<String> get excludedSections;
  @override
  String? get templateId;
  @override
  Map<String, dynamic> get customizations;
  @override
  String? get createdBy;
  @override
  String? get lastRunBy;
  @override
  String? get lastRunStatus;
  @override
  String? get lastRunError;
  @override
  int? get retryCount;
  @override
  DateTime? get nextRetryAt;
  @override
  bool get includeCharts;
  @override
  bool get includeSummary;
  @override
  bool get compressOutput;
  @override
  String? get emailSubjectTemplate;
  @override
  String? get emailBodyTemplate;
  @override
  Map<String, dynamic> get metadata;
  @override
  List<ScheduledReportRun> get recentRuns;

  /// Create a copy of ScheduledReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduledReportImplCopyWith<_$ScheduledReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScheduledReportRun _$ScheduledReportRunFromJson(Map<String, dynamic> json) {
  return _ScheduledReportRun.fromJson(json);
}

/// @nodoc
mixin _$ScheduledReportRun {
  String get id => throw _privateConstructorUsedError;
  String get reportId => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get outputUrl => throw _privateConstructorUsedError;
  int? get recordCount => throw _privateConstructorUsedError;
  int? get fileSize => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this ScheduledReportRun to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScheduledReportRun
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScheduledReportRunCopyWith<ScheduledReportRun> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduledReportRunCopyWith<$Res> {
  factory $ScheduledReportRunCopyWith(
          ScheduledReportRun value, $Res Function(ScheduledReportRun) then) =
      _$ScheduledReportRunCopyWithImpl<$Res, ScheduledReportRun>;
  @useResult
  $Res call(
      {String id,
      String reportId,
      DateTime startTime,
      DateTime? endTime,
      String status,
      String? errorMessage,
      String? outputUrl,
      int? recordCount,
      int? fileSize,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$ScheduledReportRunCopyWithImpl<$Res, $Val extends ScheduledReportRun>
    implements $ScheduledReportRunCopyWith<$Res> {
  _$ScheduledReportRunCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScheduledReportRun
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? reportId = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? outputUrl = freezed,
    Object? recordCount = freezed,
    Object? fileSize = freezed,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      reportId: null == reportId
          ? _value.reportId
          : reportId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      outputUrl: freezed == outputUrl
          ? _value.outputUrl
          : outputUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      recordCount: freezed == recordCount
          ? _value.recordCount
          : recordCount // ignore: cast_nullable_to_non_nullable
              as int?,
      fileSize: freezed == fileSize
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as int?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScheduledReportRunImplCopyWith<$Res>
    implements $ScheduledReportRunCopyWith<$Res> {
  factory _$$ScheduledReportRunImplCopyWith(_$ScheduledReportRunImpl value,
          $Res Function(_$ScheduledReportRunImpl) then) =
      __$$ScheduledReportRunImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String reportId,
      DateTime startTime,
      DateTime? endTime,
      String status,
      String? errorMessage,
      String? outputUrl,
      int? recordCount,
      int? fileSize,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$$ScheduledReportRunImplCopyWithImpl<$Res>
    extends _$ScheduledReportRunCopyWithImpl<$Res, _$ScheduledReportRunImpl>
    implements _$$ScheduledReportRunImplCopyWith<$Res> {
  __$$ScheduledReportRunImplCopyWithImpl(_$ScheduledReportRunImpl _value,
      $Res Function(_$ScheduledReportRunImpl) _then)
      : super(_value, _then);

  /// Create a copy of ScheduledReportRun
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? reportId = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? outputUrl = freezed,
    Object? recordCount = freezed,
    Object? fileSize = freezed,
    Object? metadata = null,
  }) {
    return _then(_$ScheduledReportRunImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      reportId: null == reportId
          ? _value.reportId
          : reportId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      outputUrl: freezed == outputUrl
          ? _value.outputUrl
          : outputUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      recordCount: freezed == recordCount
          ? _value.recordCount
          : recordCount // ignore: cast_nullable_to_non_nullable
              as int?,
      fileSize: freezed == fileSize
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as int?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduledReportRunImpl extends _ScheduledReportRun {
  const _$ScheduledReportRunImpl(
      {required this.id,
      required this.reportId,
      required this.startTime,
      this.endTime,
      required this.status,
      this.errorMessage,
      this.outputUrl,
      this.recordCount,
      this.fileSize,
      final Map<String, dynamic> metadata = const {}})
      : _metadata = metadata,
        super._();

  factory _$ScheduledReportRunImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduledReportRunImplFromJson(json);

  @override
  final String id;
  @override
  final String reportId;
  @override
  final DateTime startTime;
  @override
  final DateTime? endTime;
  @override
  final String status;
  @override
  final String? errorMessage;
  @override
  final String? outputUrl;
  @override
  final int? recordCount;
  @override
  final int? fileSize;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'ScheduledReportRun(id: $id, reportId: $reportId, startTime: $startTime, endTime: $endTime, status: $status, errorMessage: $errorMessage, outputUrl: $outputUrl, recordCount: $recordCount, fileSize: $fileSize, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduledReportRunImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.reportId, reportId) ||
                other.reportId == reportId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.outputUrl, outputUrl) ||
                other.outputUrl == outputUrl) &&
            (identical(other.recordCount, recordCount) ||
                other.recordCount == recordCount) &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      reportId,
      startTime,
      endTime,
      status,
      errorMessage,
      outputUrl,
      recordCount,
      fileSize,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of ScheduledReportRun
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduledReportRunImplCopyWith<_$ScheduledReportRunImpl> get copyWith =>
      __$$ScheduledReportRunImplCopyWithImpl<_$ScheduledReportRunImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduledReportRunImplToJson(
      this,
    );
  }
}

abstract class _ScheduledReportRun extends ScheduledReportRun {
  const factory _ScheduledReportRun(
      {required final String id,
      required final String reportId,
      required final DateTime startTime,
      final DateTime? endTime,
      required final String status,
      final String? errorMessage,
      final String? outputUrl,
      final int? recordCount,
      final int? fileSize,
      final Map<String, dynamic> metadata}) = _$ScheduledReportRunImpl;
  const _ScheduledReportRun._() : super._();

  factory _ScheduledReportRun.fromJson(Map<String, dynamic> json) =
      _$ScheduledReportRunImpl.fromJson;

  @override
  String get id;
  @override
  String get reportId;
  @override
  DateTime get startTime;
  @override
  DateTime? get endTime;
  @override
  String get status;
  @override
  String? get errorMessage;
  @override
  String? get outputUrl;
  @override
  int? get recordCount;
  @override
  int? get fileSize;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of ScheduledReportRun
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduledReportRunImplCopyWith<_$ScheduledReportRunImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
