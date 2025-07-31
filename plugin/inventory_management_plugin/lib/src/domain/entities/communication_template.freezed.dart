// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'communication_template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CommunicationTemplate _$CommunicationTemplateFromJson(
    Map<String, dynamic> json) {
  return _CommunicationTemplate.fromJson(json);
}

/// @nodoc
mixin _$CommunicationTemplate {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  CommunicationType get type => throw _privateConstructorUsedError;
  CommunicationTrigger get trigger => throw _privateConstructorUsedError;
  String? get subject => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  List<String> get variables => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional fields
  String? get description => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  String? get languageCode => throw _privateConstructorUsedError;
  int get priority => throw _privateConstructorUsedError;
  String? get senderName => throw _privateConstructorUsedError;
  String? get senderEmail => throw _privateConstructorUsedError;
  String? get senderPhone => throw _privateConstructorUsedError;
  List<String> get attachmentUrls => throw _privateConstructorUsedError;
  Map<String, String> get headers => throw _privateConstructorUsedError;
  bool get requiresApproval => throw _privateConstructorUsedError;
  String? get approvedBy => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  int get delayMinutes => throw _privateConstructorUsedError;
  String? get scheduleCron => throw _privateConstructorUsedError;
  bool get trackOpens => throw _privateConstructorUsedError;
  bool get trackClicks => throw _privateConstructorUsedError;
  bool get isTransactional => throw _privateConstructorUsedError;
  String? get replyTo => throw _privateConstructorUsedError;
  List<String> get ccEmails => throw _privateConstructorUsedError;
  List<String> get bccEmails => throw _privateConstructorUsedError;

  /// Serializes this CommunicationTemplate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommunicationTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommunicationTemplateCopyWith<CommunicationTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunicationTemplateCopyWith<$Res> {
  factory $CommunicationTemplateCopyWith(CommunicationTemplate value,
          $Res Function(CommunicationTemplate) then) =
      _$CommunicationTemplateCopyWithImpl<$Res, CommunicationTemplate>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String name,
      CommunicationType type,
      CommunicationTrigger trigger,
      String? subject,
      String content,
      List<String> variables,
      bool isActive,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? description,
      String? categoryId,
      Map<String, dynamic> metadata,
      String? languageCode,
      int priority,
      String? senderName,
      String? senderEmail,
      String? senderPhone,
      List<String> attachmentUrls,
      Map<String, String> headers,
      bool requiresApproval,
      String? approvedBy,
      DateTime? approvedAt,
      int delayMinutes,
      String? scheduleCron,
      bool trackOpens,
      bool trackClicks,
      bool isTransactional,
      String? replyTo,
      List<String> ccEmails,
      List<String> bccEmails});
}

/// @nodoc
class _$CommunicationTemplateCopyWithImpl<$Res,
        $Val extends CommunicationTemplate>
    implements $CommunicationTemplateCopyWith<$Res> {
  _$CommunicationTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommunicationTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? name = null,
    Object? type = null,
    Object? trigger = null,
    Object? subject = freezed,
    Object? content = null,
    Object? variables = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? description = freezed,
    Object? categoryId = freezed,
    Object? metadata = null,
    Object? languageCode = freezed,
    Object? priority = null,
    Object? senderName = freezed,
    Object? senderEmail = freezed,
    Object? senderPhone = freezed,
    Object? attachmentUrls = null,
    Object? headers = null,
    Object? requiresApproval = null,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
    Object? delayMinutes = null,
    Object? scheduleCron = freezed,
    Object? trackOpens = null,
    Object? trackClicks = null,
    Object? isTransactional = null,
    Object? replyTo = freezed,
    Object? ccEmails = null,
    Object? bccEmails = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CommunicationType,
      trigger: null == trigger
          ? _value.trigger
          : trigger // ignore: cast_nullable_to_non_nullable
              as CommunicationTrigger,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      variables: null == variables
          ? _value.variables
          : variables // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
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
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      languageCode: freezed == languageCode
          ? _value.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      senderName: freezed == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String?,
      senderEmail: freezed == senderEmail
          ? _value.senderEmail
          : senderEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      senderPhone: freezed == senderPhone
          ? _value.senderPhone
          : senderPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      attachmentUrls: null == attachmentUrls
          ? _value.attachmentUrls
          : attachmentUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      headers: null == headers
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      requiresApproval: null == requiresApproval
          ? _value.requiresApproval
          : requiresApproval // ignore: cast_nullable_to_non_nullable
              as bool,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      delayMinutes: null == delayMinutes
          ? _value.delayMinutes
          : delayMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      scheduleCron: freezed == scheduleCron
          ? _value.scheduleCron
          : scheduleCron // ignore: cast_nullable_to_non_nullable
              as String?,
      trackOpens: null == trackOpens
          ? _value.trackOpens
          : trackOpens // ignore: cast_nullable_to_non_nullable
              as bool,
      trackClicks: null == trackClicks
          ? _value.trackClicks
          : trackClicks // ignore: cast_nullable_to_non_nullable
              as bool,
      isTransactional: null == isTransactional
          ? _value.isTransactional
          : isTransactional // ignore: cast_nullable_to_non_nullable
              as bool,
      replyTo: freezed == replyTo
          ? _value.replyTo
          : replyTo // ignore: cast_nullable_to_non_nullable
              as String?,
      ccEmails: null == ccEmails
          ? _value.ccEmails
          : ccEmails // ignore: cast_nullable_to_non_nullable
              as List<String>,
      bccEmails: null == bccEmails
          ? _value.bccEmails
          : bccEmails // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommunicationTemplateImplCopyWith<$Res>
    implements $CommunicationTemplateCopyWith<$Res> {
  factory _$$CommunicationTemplateImplCopyWith(
          _$CommunicationTemplateImpl value,
          $Res Function(_$CommunicationTemplateImpl) then) =
      __$$CommunicationTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String name,
      CommunicationType type,
      CommunicationTrigger trigger,
      String? subject,
      String content,
      List<String> variables,
      bool isActive,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? description,
      String? categoryId,
      Map<String, dynamic> metadata,
      String? languageCode,
      int priority,
      String? senderName,
      String? senderEmail,
      String? senderPhone,
      List<String> attachmentUrls,
      Map<String, String> headers,
      bool requiresApproval,
      String? approvedBy,
      DateTime? approvedAt,
      int delayMinutes,
      String? scheduleCron,
      bool trackOpens,
      bool trackClicks,
      bool isTransactional,
      String? replyTo,
      List<String> ccEmails,
      List<String> bccEmails});
}

/// @nodoc
class __$$CommunicationTemplateImplCopyWithImpl<$Res>
    extends _$CommunicationTemplateCopyWithImpl<$Res,
        _$CommunicationTemplateImpl>
    implements _$$CommunicationTemplateImplCopyWith<$Res> {
  __$$CommunicationTemplateImplCopyWithImpl(_$CommunicationTemplateImpl _value,
      $Res Function(_$CommunicationTemplateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CommunicationTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? name = null,
    Object? type = null,
    Object? trigger = null,
    Object? subject = freezed,
    Object? content = null,
    Object? variables = null,
    Object? isActive = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? description = freezed,
    Object? categoryId = freezed,
    Object? metadata = null,
    Object? languageCode = freezed,
    Object? priority = null,
    Object? senderName = freezed,
    Object? senderEmail = freezed,
    Object? senderPhone = freezed,
    Object? attachmentUrls = null,
    Object? headers = null,
    Object? requiresApproval = null,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
    Object? delayMinutes = null,
    Object? scheduleCron = freezed,
    Object? trackOpens = null,
    Object? trackClicks = null,
    Object? isTransactional = null,
    Object? replyTo = freezed,
    Object? ccEmails = null,
    Object? bccEmails = null,
  }) {
    return _then(_$CommunicationTemplateImpl(
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CommunicationType,
      trigger: null == trigger
          ? _value.trigger
          : trigger // ignore: cast_nullable_to_non_nullable
              as CommunicationTrigger,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      variables: null == variables
          ? _value._variables
          : variables // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
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
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      languageCode: freezed == languageCode
          ? _value.languageCode
          : languageCode // ignore: cast_nullable_to_non_nullable
              as String?,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      senderName: freezed == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String?,
      senderEmail: freezed == senderEmail
          ? _value.senderEmail
          : senderEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      senderPhone: freezed == senderPhone
          ? _value.senderPhone
          : senderPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      attachmentUrls: null == attachmentUrls
          ? _value._attachmentUrls
          : attachmentUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      headers: null == headers
          ? _value._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      requiresApproval: null == requiresApproval
          ? _value.requiresApproval
          : requiresApproval // ignore: cast_nullable_to_non_nullable
              as bool,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      delayMinutes: null == delayMinutes
          ? _value.delayMinutes
          : delayMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      scheduleCron: freezed == scheduleCron
          ? _value.scheduleCron
          : scheduleCron // ignore: cast_nullable_to_non_nullable
              as String?,
      trackOpens: null == trackOpens
          ? _value.trackOpens
          : trackOpens // ignore: cast_nullable_to_non_nullable
              as bool,
      trackClicks: null == trackClicks
          ? _value.trackClicks
          : trackClicks // ignore: cast_nullable_to_non_nullable
              as bool,
      isTransactional: null == isTransactional
          ? _value.isTransactional
          : isTransactional // ignore: cast_nullable_to_non_nullable
              as bool,
      replyTo: freezed == replyTo
          ? _value.replyTo
          : replyTo // ignore: cast_nullable_to_non_nullable
              as String?,
      ccEmails: null == ccEmails
          ? _value._ccEmails
          : ccEmails // ignore: cast_nullable_to_non_nullable
              as List<String>,
      bccEmails: null == bccEmails
          ? _value._bccEmails
          : bccEmails // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommunicationTemplateImpl extends _CommunicationTemplate {
  const _$CommunicationTemplateImpl(
      {required this.id,
      required this.organizationId,
      required this.name,
      required this.type,
      required this.trigger,
      this.subject,
      required this.content,
      final List<String> variables = const [],
      this.isActive = true,
      required this.createdAt,
      required this.updatedAt,
      this.syncedAt,
      this.description,
      this.categoryId,
      final Map<String, dynamic> metadata = const {},
      this.languageCode,
      this.priority = 0,
      this.senderName,
      this.senderEmail,
      this.senderPhone,
      final List<String> attachmentUrls = const [],
      final Map<String, String> headers = const {},
      this.requiresApproval = false,
      this.approvedBy,
      this.approvedAt,
      this.delayMinutes = 0,
      this.scheduleCron,
      this.trackOpens = true,
      this.trackClicks = true,
      this.isTransactional = false,
      this.replyTo,
      final List<String> ccEmails = const [],
      final List<String> bccEmails = const []})
      : _variables = variables,
        _metadata = metadata,
        _attachmentUrls = attachmentUrls,
        _headers = headers,
        _ccEmails = ccEmails,
        _bccEmails = bccEmails,
        super._();

  factory _$CommunicationTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommunicationTemplateImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String name;
  @override
  final CommunicationType type;
  @override
  final CommunicationTrigger trigger;
  @override
  final String? subject;
  @override
  final String content;
  final List<String> _variables;
  @override
  @JsonKey()
  List<String> get variables {
    if (_variables is EqualUnmodifiableListView) return _variables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_variables);
  }

  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? syncedAt;
// Additional fields
  @override
  final String? description;
  @override
  final String? categoryId;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  final String? languageCode;
  @override
  @JsonKey()
  final int priority;
  @override
  final String? senderName;
  @override
  final String? senderEmail;
  @override
  final String? senderPhone;
  final List<String> _attachmentUrls;
  @override
  @JsonKey()
  List<String> get attachmentUrls {
    if (_attachmentUrls is EqualUnmodifiableListView) return _attachmentUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachmentUrls);
  }

  final Map<String, String> _headers;
  @override
  @JsonKey()
  Map<String, String> get headers {
    if (_headers is EqualUnmodifiableMapView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_headers);
  }

  @override
  @JsonKey()
  final bool requiresApproval;
  @override
  final String? approvedBy;
  @override
  final DateTime? approvedAt;
  @override
  @JsonKey()
  final int delayMinutes;
  @override
  final String? scheduleCron;
  @override
  @JsonKey()
  final bool trackOpens;
  @override
  @JsonKey()
  final bool trackClicks;
  @override
  @JsonKey()
  final bool isTransactional;
  @override
  final String? replyTo;
  final List<String> _ccEmails;
  @override
  @JsonKey()
  List<String> get ccEmails {
    if (_ccEmails is EqualUnmodifiableListView) return _ccEmails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ccEmails);
  }

  final List<String> _bccEmails;
  @override
  @JsonKey()
  List<String> get bccEmails {
    if (_bccEmails is EqualUnmodifiableListView) return _bccEmails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bccEmails);
  }

  @override
  String toString() {
    return 'CommunicationTemplate(id: $id, organizationId: $organizationId, name: $name, type: $type, trigger: $trigger, subject: $subject, content: $content, variables: $variables, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt, description: $description, categoryId: $categoryId, metadata: $metadata, languageCode: $languageCode, priority: $priority, senderName: $senderName, senderEmail: $senderEmail, senderPhone: $senderPhone, attachmentUrls: $attachmentUrls, headers: $headers, requiresApproval: $requiresApproval, approvedBy: $approvedBy, approvedAt: $approvedAt, delayMinutes: $delayMinutes, scheduleCron: $scheduleCron, trackOpens: $trackOpens, trackClicks: $trackClicks, isTransactional: $isTransactional, replyTo: $replyTo, ccEmails: $ccEmails, bccEmails: $bccEmails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommunicationTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.trigger, trigger) || other.trigger == trigger) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality()
                .equals(other._variables, _variables) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.languageCode, languageCode) ||
                other.languageCode == languageCode) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.senderEmail, senderEmail) ||
                other.senderEmail == senderEmail) &&
            (identical(other.senderPhone, senderPhone) ||
                other.senderPhone == senderPhone) &&
            const DeepCollectionEquality()
                .equals(other._attachmentUrls, _attachmentUrls) &&
            const DeepCollectionEquality().equals(other._headers, _headers) &&
            (identical(other.requiresApproval, requiresApproval) ||
                other.requiresApproval == requiresApproval) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.delayMinutes, delayMinutes) ||
                other.delayMinutes == delayMinutes) &&
            (identical(other.scheduleCron, scheduleCron) ||
                other.scheduleCron == scheduleCron) &&
            (identical(other.trackOpens, trackOpens) ||
                other.trackOpens == trackOpens) &&
            (identical(other.trackClicks, trackClicks) ||
                other.trackClicks == trackClicks) &&
            (identical(other.isTransactional, isTransactional) ||
                other.isTransactional == isTransactional) &&
            (identical(other.replyTo, replyTo) || other.replyTo == replyTo) &&
            const DeepCollectionEquality().equals(other._ccEmails, _ccEmails) &&
            const DeepCollectionEquality()
                .equals(other._bccEmails, _bccEmails));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        organizationId,
        name,
        type,
        trigger,
        subject,
        content,
        const DeepCollectionEquality().hash(_variables),
        isActive,
        createdAt,
        updatedAt,
        syncedAt,
        description,
        categoryId,
        const DeepCollectionEquality().hash(_metadata),
        languageCode,
        priority,
        senderName,
        senderEmail,
        senderPhone,
        const DeepCollectionEquality().hash(_attachmentUrls),
        const DeepCollectionEquality().hash(_headers),
        requiresApproval,
        approvedBy,
        approvedAt,
        delayMinutes,
        scheduleCron,
        trackOpens,
        trackClicks,
        isTransactional,
        replyTo,
        const DeepCollectionEquality().hash(_ccEmails),
        const DeepCollectionEquality().hash(_bccEmails)
      ]);

  /// Create a copy of CommunicationTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommunicationTemplateImplCopyWith<_$CommunicationTemplateImpl>
      get copyWith => __$$CommunicationTemplateImplCopyWithImpl<
          _$CommunicationTemplateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommunicationTemplateImplToJson(
      this,
    );
  }
}

abstract class _CommunicationTemplate extends CommunicationTemplate {
  const factory _CommunicationTemplate(
      {required final String id,
      required final String organizationId,
      required final String name,
      required final CommunicationType type,
      required final CommunicationTrigger trigger,
      final String? subject,
      required final String content,
      final List<String> variables,
      final bool isActive,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final DateTime? syncedAt,
      final String? description,
      final String? categoryId,
      final Map<String, dynamic> metadata,
      final String? languageCode,
      final int priority,
      final String? senderName,
      final String? senderEmail,
      final String? senderPhone,
      final List<String> attachmentUrls,
      final Map<String, String> headers,
      final bool requiresApproval,
      final String? approvedBy,
      final DateTime? approvedAt,
      final int delayMinutes,
      final String? scheduleCron,
      final bool trackOpens,
      final bool trackClicks,
      final bool isTransactional,
      final String? replyTo,
      final List<String> ccEmails,
      final List<String> bccEmails}) = _$CommunicationTemplateImpl;
  const _CommunicationTemplate._() : super._();

  factory _CommunicationTemplate.fromJson(Map<String, dynamic> json) =
      _$CommunicationTemplateImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String get name;
  @override
  CommunicationType get type;
  @override
  CommunicationTrigger get trigger;
  @override
  String? get subject;
  @override
  String get content;
  @override
  List<String> get variables;
  @override
  bool get isActive;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get syncedAt; // Additional fields
  @override
  String? get description;
  @override
  String? get categoryId;
  @override
  Map<String, dynamic> get metadata;
  @override
  String? get languageCode;
  @override
  int get priority;
  @override
  String? get senderName;
  @override
  String? get senderEmail;
  @override
  String? get senderPhone;
  @override
  List<String> get attachmentUrls;
  @override
  Map<String, String> get headers;
  @override
  bool get requiresApproval;
  @override
  String? get approvedBy;
  @override
  DateTime? get approvedAt;
  @override
  int get delayMinutes;
  @override
  String? get scheduleCron;
  @override
  bool get trackOpens;
  @override
  bool get trackClicks;
  @override
  bool get isTransactional;
  @override
  String? get replyTo;
  @override
  List<String> get ccEmails;
  @override
  List<String> get bccEmails;

  /// Create a copy of CommunicationTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommunicationTemplateImplCopyWith<_$CommunicationTemplateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CommunicationLog _$CommunicationLogFromJson(Map<String, dynamic> json) {
  return _CommunicationLog.fromJson(json);
}

/// @nodoc
mixin _$CommunicationLog {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String? get templateId => throw _privateConstructorUsedError;
  String? get customerId => throw _privateConstructorUsedError;
  String? get supplierId => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  CommunicationType get type => throw _privateConstructorUsedError;
  String get recipient => throw _privateConstructorUsedError;
  String? get subject => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  CommunicationStatus get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  DateTime? get sentAt => throw _privateConstructorUsedError;
  DateTime? get deliveredAt => throw _privateConstructorUsedError;
  DateTime? get readAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional fields
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  String? get messageId => throw _privateConstructorUsedError;
  String? get conversationId => throw _privateConstructorUsedError;
  double get cost => throw _privateConstructorUsedError;
  String? get provider => throw _privateConstructorUsedError;
  int get retryCount => throw _privateConstructorUsedError;
  DateTime? get nextRetryAt => throw _privateConstructorUsedError;
  List<String> get attachmentUrls => throw _privateConstructorUsedError;
  String? get direction =>
      throw _privateConstructorUsedError; // 'inbound' or 'outbound'
  String? get replyToId => throw _privateConstructorUsedError;
  Map<String, dynamic> get providerResponse =>
      throw _privateConstructorUsedError;
  String? get campaignId => throw _privateConstructorUsedError;
  List<CommunicationEvent> get events => throw _privateConstructorUsedError;

  /// Serializes this CommunicationLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommunicationLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommunicationLogCopyWith<CommunicationLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunicationLogCopyWith<$Res> {
  factory $CommunicationLogCopyWith(
          CommunicationLog value, $Res Function(CommunicationLog) then) =
      _$CommunicationLogCopyWithImpl<$Res, CommunicationLog>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String? templateId,
      String? customerId,
      String? supplierId,
      String? userId,
      CommunicationType type,
      String recipient,
      String? subject,
      String content,
      CommunicationStatus status,
      String? errorMessage,
      DateTime? sentAt,
      DateTime? deliveredAt,
      DateTime? readAt,
      DateTime createdAt,
      DateTime? syncedAt,
      Map<String, dynamic> metadata,
      String? messageId,
      String? conversationId,
      double cost,
      String? provider,
      int retryCount,
      DateTime? nextRetryAt,
      List<String> attachmentUrls,
      String? direction,
      String? replyToId,
      Map<String, dynamic> providerResponse,
      String? campaignId,
      List<CommunicationEvent> events});
}

/// @nodoc
class _$CommunicationLogCopyWithImpl<$Res, $Val extends CommunicationLog>
    implements $CommunicationLogCopyWith<$Res> {
  _$CommunicationLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommunicationLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? templateId = freezed,
    Object? customerId = freezed,
    Object? supplierId = freezed,
    Object? userId = freezed,
    Object? type = null,
    Object? recipient = null,
    Object? subject = freezed,
    Object? content = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? sentAt = freezed,
    Object? deliveredAt = freezed,
    Object? readAt = freezed,
    Object? createdAt = null,
    Object? syncedAt = freezed,
    Object? metadata = null,
    Object? messageId = freezed,
    Object? conversationId = freezed,
    Object? cost = null,
    Object? provider = freezed,
    Object? retryCount = null,
    Object? nextRetryAt = freezed,
    Object? attachmentUrls = null,
    Object? direction = freezed,
    Object? replyToId = freezed,
    Object? providerResponse = null,
    Object? campaignId = freezed,
    Object? events = null,
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
      templateId: freezed == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierId: freezed == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CommunicationType,
      recipient: null == recipient
          ? _value.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as String,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CommunicationStatus,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      sentAt: freezed == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      messageId: freezed == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String?,
      conversationId: freezed == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String?,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      retryCount: null == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
      nextRetryAt: freezed == nextRetryAt
          ? _value.nextRetryAt
          : nextRetryAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      attachmentUrls: null == attachmentUrls
          ? _value.attachmentUrls
          : attachmentUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      direction: freezed == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String?,
      replyToId: freezed == replyToId
          ? _value.replyToId
          : replyToId // ignore: cast_nullable_to_non_nullable
              as String?,
      providerResponse: null == providerResponse
          ? _value.providerResponse
          : providerResponse // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      campaignId: freezed == campaignId
          ? _value.campaignId
          : campaignId // ignore: cast_nullable_to_non_nullable
              as String?,
      events: null == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as List<CommunicationEvent>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommunicationLogImplCopyWith<$Res>
    implements $CommunicationLogCopyWith<$Res> {
  factory _$$CommunicationLogImplCopyWith(_$CommunicationLogImpl value,
          $Res Function(_$CommunicationLogImpl) then) =
      __$$CommunicationLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String? templateId,
      String? customerId,
      String? supplierId,
      String? userId,
      CommunicationType type,
      String recipient,
      String? subject,
      String content,
      CommunicationStatus status,
      String? errorMessage,
      DateTime? sentAt,
      DateTime? deliveredAt,
      DateTime? readAt,
      DateTime createdAt,
      DateTime? syncedAt,
      Map<String, dynamic> metadata,
      String? messageId,
      String? conversationId,
      double cost,
      String? provider,
      int retryCount,
      DateTime? nextRetryAt,
      List<String> attachmentUrls,
      String? direction,
      String? replyToId,
      Map<String, dynamic> providerResponse,
      String? campaignId,
      List<CommunicationEvent> events});
}

/// @nodoc
class __$$CommunicationLogImplCopyWithImpl<$Res>
    extends _$CommunicationLogCopyWithImpl<$Res, _$CommunicationLogImpl>
    implements _$$CommunicationLogImplCopyWith<$Res> {
  __$$CommunicationLogImplCopyWithImpl(_$CommunicationLogImpl _value,
      $Res Function(_$CommunicationLogImpl) _then)
      : super(_value, _then);

  /// Create a copy of CommunicationLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? templateId = freezed,
    Object? customerId = freezed,
    Object? supplierId = freezed,
    Object? userId = freezed,
    Object? type = null,
    Object? recipient = null,
    Object? subject = freezed,
    Object? content = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? sentAt = freezed,
    Object? deliveredAt = freezed,
    Object? readAt = freezed,
    Object? createdAt = null,
    Object? syncedAt = freezed,
    Object? metadata = null,
    Object? messageId = freezed,
    Object? conversationId = freezed,
    Object? cost = null,
    Object? provider = freezed,
    Object? retryCount = null,
    Object? nextRetryAt = freezed,
    Object? attachmentUrls = null,
    Object? direction = freezed,
    Object? replyToId = freezed,
    Object? providerResponse = null,
    Object? campaignId = freezed,
    Object? events = null,
  }) {
    return _then(_$CommunicationLogImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      templateId: freezed == templateId
          ? _value.templateId
          : templateId // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierId: freezed == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CommunicationType,
      recipient: null == recipient
          ? _value.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as String,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CommunicationStatus,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      sentAt: freezed == sentAt
          ? _value.sentAt
          : sentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      messageId: freezed == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String?,
      conversationId: freezed == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String?,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      retryCount: null == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
      nextRetryAt: freezed == nextRetryAt
          ? _value.nextRetryAt
          : nextRetryAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      attachmentUrls: null == attachmentUrls
          ? _value._attachmentUrls
          : attachmentUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      direction: freezed == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String?,
      replyToId: freezed == replyToId
          ? _value.replyToId
          : replyToId // ignore: cast_nullable_to_non_nullable
              as String?,
      providerResponse: null == providerResponse
          ? _value._providerResponse
          : providerResponse // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      campaignId: freezed == campaignId
          ? _value.campaignId
          : campaignId // ignore: cast_nullable_to_non_nullable
              as String?,
      events: null == events
          ? _value._events
          : events // ignore: cast_nullable_to_non_nullable
              as List<CommunicationEvent>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommunicationLogImpl extends _CommunicationLog {
  const _$CommunicationLogImpl(
      {required this.id,
      required this.organizationId,
      this.templateId,
      this.customerId,
      this.supplierId,
      this.userId,
      required this.type,
      required this.recipient,
      this.subject,
      required this.content,
      this.status = CommunicationStatus.pending,
      this.errorMessage,
      this.sentAt,
      this.deliveredAt,
      this.readAt,
      required this.createdAt,
      this.syncedAt,
      final Map<String, dynamic> metadata = const {},
      this.messageId,
      this.conversationId,
      this.cost = 0,
      this.provider,
      this.retryCount = 0,
      this.nextRetryAt,
      final List<String> attachmentUrls = const [],
      this.direction,
      this.replyToId,
      final Map<String, dynamic> providerResponse = const {},
      this.campaignId,
      final List<CommunicationEvent> events = const []})
      : _metadata = metadata,
        _attachmentUrls = attachmentUrls,
        _providerResponse = providerResponse,
        _events = events,
        super._();

  factory _$CommunicationLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommunicationLogImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String? templateId;
  @override
  final String? customerId;
  @override
  final String? supplierId;
  @override
  final String? userId;
  @override
  final CommunicationType type;
  @override
  final String recipient;
  @override
  final String? subject;
  @override
  final String content;
  @override
  @JsonKey()
  final CommunicationStatus status;
  @override
  final String? errorMessage;
  @override
  final DateTime? sentAt;
  @override
  final DateTime? deliveredAt;
  @override
  final DateTime? readAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime? syncedAt;
// Additional fields
  final Map<String, dynamic> _metadata;
// Additional fields
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  final String? messageId;
  @override
  final String? conversationId;
  @override
  @JsonKey()
  final double cost;
  @override
  final String? provider;
  @override
  @JsonKey()
  final int retryCount;
  @override
  final DateTime? nextRetryAt;
  final List<String> _attachmentUrls;
  @override
  @JsonKey()
  List<String> get attachmentUrls {
    if (_attachmentUrls is EqualUnmodifiableListView) return _attachmentUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachmentUrls);
  }

  @override
  final String? direction;
// 'inbound' or 'outbound'
  @override
  final String? replyToId;
  final Map<String, dynamic> _providerResponse;
  @override
  @JsonKey()
  Map<String, dynamic> get providerResponse {
    if (_providerResponse is EqualUnmodifiableMapView) return _providerResponse;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_providerResponse);
  }

  @override
  final String? campaignId;
  final List<CommunicationEvent> _events;
  @override
  @JsonKey()
  List<CommunicationEvent> get events {
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_events);
  }

  @override
  String toString() {
    return 'CommunicationLog(id: $id, organizationId: $organizationId, templateId: $templateId, customerId: $customerId, supplierId: $supplierId, userId: $userId, type: $type, recipient: $recipient, subject: $subject, content: $content, status: $status, errorMessage: $errorMessage, sentAt: $sentAt, deliveredAt: $deliveredAt, readAt: $readAt, createdAt: $createdAt, syncedAt: $syncedAt, metadata: $metadata, messageId: $messageId, conversationId: $conversationId, cost: $cost, provider: $provider, retryCount: $retryCount, nextRetryAt: $nextRetryAt, attachmentUrls: $attachmentUrls, direction: $direction, replyToId: $replyToId, providerResponse: $providerResponse, campaignId: $campaignId, events: $events)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommunicationLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.templateId, templateId) ||
                other.templateId == templateId) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.supplierId, supplierId) ||
                other.supplierId == supplierId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.recipient, recipient) ||
                other.recipient == recipient) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt) &&
            (identical(other.deliveredAt, deliveredAt) ||
                other.deliveredAt == deliveredAt) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.retryCount, retryCount) ||
                other.retryCount == retryCount) &&
            (identical(other.nextRetryAt, nextRetryAt) ||
                other.nextRetryAt == nextRetryAt) &&
            const DeepCollectionEquality()
                .equals(other._attachmentUrls, _attachmentUrls) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.replyToId, replyToId) ||
                other.replyToId == replyToId) &&
            const DeepCollectionEquality()
                .equals(other._providerResponse, _providerResponse) &&
            (identical(other.campaignId, campaignId) ||
                other.campaignId == campaignId) &&
            const DeepCollectionEquality().equals(other._events, _events));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        organizationId,
        templateId,
        customerId,
        supplierId,
        userId,
        type,
        recipient,
        subject,
        content,
        status,
        errorMessage,
        sentAt,
        deliveredAt,
        readAt,
        createdAt,
        syncedAt,
        const DeepCollectionEquality().hash(_metadata),
        messageId,
        conversationId,
        cost,
        provider,
        retryCount,
        nextRetryAt,
        const DeepCollectionEquality().hash(_attachmentUrls),
        direction,
        replyToId,
        const DeepCollectionEquality().hash(_providerResponse),
        campaignId,
        const DeepCollectionEquality().hash(_events)
      ]);

  /// Create a copy of CommunicationLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommunicationLogImplCopyWith<_$CommunicationLogImpl> get copyWith =>
      __$$CommunicationLogImplCopyWithImpl<_$CommunicationLogImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommunicationLogImplToJson(
      this,
    );
  }
}

abstract class _CommunicationLog extends CommunicationLog {
  const factory _CommunicationLog(
      {required final String id,
      required final String organizationId,
      final String? templateId,
      final String? customerId,
      final String? supplierId,
      final String? userId,
      required final CommunicationType type,
      required final String recipient,
      final String? subject,
      required final String content,
      final CommunicationStatus status,
      final String? errorMessage,
      final DateTime? sentAt,
      final DateTime? deliveredAt,
      final DateTime? readAt,
      required final DateTime createdAt,
      final DateTime? syncedAt,
      final Map<String, dynamic> metadata,
      final String? messageId,
      final String? conversationId,
      final double cost,
      final String? provider,
      final int retryCount,
      final DateTime? nextRetryAt,
      final List<String> attachmentUrls,
      final String? direction,
      final String? replyToId,
      final Map<String, dynamic> providerResponse,
      final String? campaignId,
      final List<CommunicationEvent> events}) = _$CommunicationLogImpl;
  const _CommunicationLog._() : super._();

  factory _CommunicationLog.fromJson(Map<String, dynamic> json) =
      _$CommunicationLogImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String? get templateId;
  @override
  String? get customerId;
  @override
  String? get supplierId;
  @override
  String? get userId;
  @override
  CommunicationType get type;
  @override
  String get recipient;
  @override
  String? get subject;
  @override
  String get content;
  @override
  CommunicationStatus get status;
  @override
  String? get errorMessage;
  @override
  DateTime? get sentAt;
  @override
  DateTime? get deliveredAt;
  @override
  DateTime? get readAt;
  @override
  DateTime get createdAt;
  @override
  DateTime? get syncedAt; // Additional fields
  @override
  Map<String, dynamic> get metadata;
  @override
  String? get messageId;
  @override
  String? get conversationId;
  @override
  double get cost;
  @override
  String? get provider;
  @override
  int get retryCount;
  @override
  DateTime? get nextRetryAt;
  @override
  List<String> get attachmentUrls;
  @override
  String? get direction; // 'inbound' or 'outbound'
  @override
  String? get replyToId;
  @override
  Map<String, dynamic> get providerResponse;
  @override
  String? get campaignId;
  @override
  List<CommunicationEvent> get events;

  /// Create a copy of CommunicationLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommunicationLogImplCopyWith<_$CommunicationLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CommunicationEvent _$CommunicationEventFromJson(Map<String, dynamic> json) {
  return _CommunicationEvent.fromJson(json);
}

/// @nodoc
mixin _$CommunicationEvent {
  String get type => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  /// Serializes this CommunicationEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommunicationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommunicationEventCopyWith<CommunicationEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunicationEventCopyWith<$Res> {
  factory $CommunicationEventCopyWith(
          CommunicationEvent value, $Res Function(CommunicationEvent) then) =
      _$CommunicationEventCopyWithImpl<$Res, CommunicationEvent>;
  @useResult
  $Res call({String type, DateTime timestamp, Map<String, dynamic> data});
}

/// @nodoc
class _$CommunicationEventCopyWithImpl<$Res, $Val extends CommunicationEvent>
    implements $CommunicationEventCopyWith<$Res> {
  _$CommunicationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommunicationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? timestamp = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommunicationEventImplCopyWith<$Res>
    implements $CommunicationEventCopyWith<$Res> {
  factory _$$CommunicationEventImplCopyWith(_$CommunicationEventImpl value,
          $Res Function(_$CommunicationEventImpl) then) =
      __$$CommunicationEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, DateTime timestamp, Map<String, dynamic> data});
}

/// @nodoc
class __$$CommunicationEventImplCopyWithImpl<$Res>
    extends _$CommunicationEventCopyWithImpl<$Res, _$CommunicationEventImpl>
    implements _$$CommunicationEventImplCopyWith<$Res> {
  __$$CommunicationEventImplCopyWithImpl(_$CommunicationEventImpl _value,
      $Res Function(_$CommunicationEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of CommunicationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? timestamp = null,
    Object? data = null,
  }) {
    return _then(_$CommunicationEventImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommunicationEventImpl implements _CommunicationEvent {
  const _$CommunicationEventImpl(
      {required this.type,
      required this.timestamp,
      final Map<String, dynamic> data = const {}})
      : _data = data;

  factory _$CommunicationEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommunicationEventImplFromJson(json);

  @override
  final String type;
  @override
  final DateTime timestamp;
  final Map<String, dynamic> _data;
  @override
  @JsonKey()
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'CommunicationEvent(type: $type, timestamp: $timestamp, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommunicationEventImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, timestamp, const DeepCollectionEquality().hash(_data));

  /// Create a copy of CommunicationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommunicationEventImplCopyWith<_$CommunicationEventImpl> get copyWith =>
      __$$CommunicationEventImplCopyWithImpl<_$CommunicationEventImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommunicationEventImplToJson(
      this,
    );
  }
}

abstract class _CommunicationEvent implements CommunicationEvent {
  const factory _CommunicationEvent(
      {required final String type,
      required final DateTime timestamp,
      final Map<String, dynamic> data}) = _$CommunicationEventImpl;

  factory _CommunicationEvent.fromJson(Map<String, dynamic> json) =
      _$CommunicationEventImpl.fromJson;

  @override
  String get type;
  @override
  DateTime get timestamp;
  @override
  Map<String, dynamic> get data;

  /// Create a copy of CommunicationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommunicationEventImplCopyWith<_$CommunicationEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
