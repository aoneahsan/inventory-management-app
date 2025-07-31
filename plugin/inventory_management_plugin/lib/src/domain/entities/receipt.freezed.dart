// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'receipt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Receipt _$ReceiptFromJson(Map<String, dynamic> json) {
  return _Receipt.fromJson(json);
}

/// @nodoc
mixin _$Receipt {
  String get id => throw _privateConstructorUsedError;
  String get saleId => throw _privateConstructorUsedError;
  String get receiptNumber => throw _privateConstructorUsedError;
  String get template => throw _privateConstructorUsedError;
  Map<String, dynamic> get customFields => throw _privateConstructorUsedError;
  String get format => throw _privateConstructorUsedError;
  bool get isPrinted => throw _privateConstructorUsedError;
  DateTime? get printedAt => throw _privateConstructorUsedError;
  String? get printerName => throw _privateConstructorUsedError;
  String? get digitalReceipt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional fields
  String? get organizationId => throw _privateConstructorUsedError;
  String? get branchId => throw _privateConstructorUsedError;
  String? get registerId => throw _privateConstructorUsedError;
  String? get cashierId => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  String? get qrCode => throw _privateConstructorUsedError;
  String? get barcode => throw _privateConstructorUsedError;
  bool get isReprint => throw _privateConstructorUsedError;
  int? get reprintCount => throw _privateConstructorUsedError;
  String? get reprintReason => throw _privateConstructorUsedError;
  DateTime? get emailedAt => throw _privateConstructorUsedError;
  String? get emailedTo => throw _privateConstructorUsedError;
  DateTime? get smsAt => throw _privateConstructorUsedError;
  String? get smsTo => throw _privateConstructorUsedError;
  String? get signatureUrl => throw _privateConstructorUsedError;
  Map<String, dynamic> get headerData => throw _privateConstructorUsedError;
  Map<String, dynamic> get footerData => throw _privateConstructorUsedError;

  /// Serializes this Receipt to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Receipt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReceiptCopyWith<Receipt> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceiptCopyWith<$Res> {
  factory $ReceiptCopyWith(Receipt value, $Res Function(Receipt) then) =
      _$ReceiptCopyWithImpl<$Res, Receipt>;
  @useResult
  $Res call(
      {String id,
      String saleId,
      String receiptNumber,
      String template,
      Map<String, dynamic> customFields,
      String format,
      bool isPrinted,
      DateTime? printedAt,
      String? printerName,
      String? digitalReceipt,
      DateTime createdAt,
      DateTime? syncedAt,
      String? organizationId,
      String? branchId,
      String? registerId,
      String? cashierId,
      Map<String, dynamic> metadata,
      String? qrCode,
      String? barcode,
      bool isReprint,
      int? reprintCount,
      String? reprintReason,
      DateTime? emailedAt,
      String? emailedTo,
      DateTime? smsAt,
      String? smsTo,
      String? signatureUrl,
      Map<String, dynamic> headerData,
      Map<String, dynamic> footerData});
}

/// @nodoc
class _$ReceiptCopyWithImpl<$Res, $Val extends Receipt>
    implements $ReceiptCopyWith<$Res> {
  _$ReceiptCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Receipt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? saleId = null,
    Object? receiptNumber = null,
    Object? template = null,
    Object? customFields = null,
    Object? format = null,
    Object? isPrinted = null,
    Object? printedAt = freezed,
    Object? printerName = freezed,
    Object? digitalReceipt = freezed,
    Object? createdAt = null,
    Object? syncedAt = freezed,
    Object? organizationId = freezed,
    Object? branchId = freezed,
    Object? registerId = freezed,
    Object? cashierId = freezed,
    Object? metadata = null,
    Object? qrCode = freezed,
    Object? barcode = freezed,
    Object? isReprint = null,
    Object? reprintCount = freezed,
    Object? reprintReason = freezed,
    Object? emailedAt = freezed,
    Object? emailedTo = freezed,
    Object? smsAt = freezed,
    Object? smsTo = freezed,
    Object? signatureUrl = freezed,
    Object? headerData = null,
    Object? footerData = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      saleId: null == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
              as String,
      receiptNumber: null == receiptNumber
          ? _value.receiptNumber
          : receiptNumber // ignore: cast_nullable_to_non_nullable
              as String,
      template: null == template
          ? _value.template
          : template // ignore: cast_nullable_to_non_nullable
              as String,
      customFields: null == customFields
          ? _value.customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      isPrinted: null == isPrinted
          ? _value.isPrinted
          : isPrinted // ignore: cast_nullable_to_non_nullable
              as bool,
      printedAt: freezed == printedAt
          ? _value.printedAt
          : printedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      printerName: freezed == printerName
          ? _value.printerName
          : printerName // ignore: cast_nullable_to_non_nullable
              as String?,
      digitalReceipt: freezed == digitalReceipt
          ? _value.digitalReceipt
          : digitalReceipt // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
      branchId: freezed == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as String?,
      registerId: freezed == registerId
          ? _value.registerId
          : registerId // ignore: cast_nullable_to_non_nullable
              as String?,
      cashierId: freezed == cashierId
          ? _value.cashierId
          : cashierId // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      qrCode: freezed == qrCode
          ? _value.qrCode
          : qrCode // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      isReprint: null == isReprint
          ? _value.isReprint
          : isReprint // ignore: cast_nullable_to_non_nullable
              as bool,
      reprintCount: freezed == reprintCount
          ? _value.reprintCount
          : reprintCount // ignore: cast_nullable_to_non_nullable
              as int?,
      reprintReason: freezed == reprintReason
          ? _value.reprintReason
          : reprintReason // ignore: cast_nullable_to_non_nullable
              as String?,
      emailedAt: freezed == emailedAt
          ? _value.emailedAt
          : emailedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      emailedTo: freezed == emailedTo
          ? _value.emailedTo
          : emailedTo // ignore: cast_nullable_to_non_nullable
              as String?,
      smsAt: freezed == smsAt
          ? _value.smsAt
          : smsAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      smsTo: freezed == smsTo
          ? _value.smsTo
          : smsTo // ignore: cast_nullable_to_non_nullable
              as String?,
      signatureUrl: freezed == signatureUrl
          ? _value.signatureUrl
          : signatureUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      headerData: null == headerData
          ? _value.headerData
          : headerData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      footerData: null == footerData
          ? _value.footerData
          : footerData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReceiptImplCopyWith<$Res> implements $ReceiptCopyWith<$Res> {
  factory _$$ReceiptImplCopyWith(
          _$ReceiptImpl value, $Res Function(_$ReceiptImpl) then) =
      __$$ReceiptImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String saleId,
      String receiptNumber,
      String template,
      Map<String, dynamic> customFields,
      String format,
      bool isPrinted,
      DateTime? printedAt,
      String? printerName,
      String? digitalReceipt,
      DateTime createdAt,
      DateTime? syncedAt,
      String? organizationId,
      String? branchId,
      String? registerId,
      String? cashierId,
      Map<String, dynamic> metadata,
      String? qrCode,
      String? barcode,
      bool isReprint,
      int? reprintCount,
      String? reprintReason,
      DateTime? emailedAt,
      String? emailedTo,
      DateTime? smsAt,
      String? smsTo,
      String? signatureUrl,
      Map<String, dynamic> headerData,
      Map<String, dynamic> footerData});
}

/// @nodoc
class __$$ReceiptImplCopyWithImpl<$Res>
    extends _$ReceiptCopyWithImpl<$Res, _$ReceiptImpl>
    implements _$$ReceiptImplCopyWith<$Res> {
  __$$ReceiptImplCopyWithImpl(
      _$ReceiptImpl _value, $Res Function(_$ReceiptImpl) _then)
      : super(_value, _then);

  /// Create a copy of Receipt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? saleId = null,
    Object? receiptNumber = null,
    Object? template = null,
    Object? customFields = null,
    Object? format = null,
    Object? isPrinted = null,
    Object? printedAt = freezed,
    Object? printerName = freezed,
    Object? digitalReceipt = freezed,
    Object? createdAt = null,
    Object? syncedAt = freezed,
    Object? organizationId = freezed,
    Object? branchId = freezed,
    Object? registerId = freezed,
    Object? cashierId = freezed,
    Object? metadata = null,
    Object? qrCode = freezed,
    Object? barcode = freezed,
    Object? isReprint = null,
    Object? reprintCount = freezed,
    Object? reprintReason = freezed,
    Object? emailedAt = freezed,
    Object? emailedTo = freezed,
    Object? smsAt = freezed,
    Object? smsTo = freezed,
    Object? signatureUrl = freezed,
    Object? headerData = null,
    Object? footerData = null,
  }) {
    return _then(_$ReceiptImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      saleId: null == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
              as String,
      receiptNumber: null == receiptNumber
          ? _value.receiptNumber
          : receiptNumber // ignore: cast_nullable_to_non_nullable
              as String,
      template: null == template
          ? _value.template
          : template // ignore: cast_nullable_to_non_nullable
              as String,
      customFields: null == customFields
          ? _value._customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      isPrinted: null == isPrinted
          ? _value.isPrinted
          : isPrinted // ignore: cast_nullable_to_non_nullable
              as bool,
      printedAt: freezed == printedAt
          ? _value.printedAt
          : printedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      printerName: freezed == printerName
          ? _value.printerName
          : printerName // ignore: cast_nullable_to_non_nullable
              as String?,
      digitalReceipt: freezed == digitalReceipt
          ? _value.digitalReceipt
          : digitalReceipt // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
      branchId: freezed == branchId
          ? _value.branchId
          : branchId // ignore: cast_nullable_to_non_nullable
              as String?,
      registerId: freezed == registerId
          ? _value.registerId
          : registerId // ignore: cast_nullable_to_non_nullable
              as String?,
      cashierId: freezed == cashierId
          ? _value.cashierId
          : cashierId // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      qrCode: freezed == qrCode
          ? _value.qrCode
          : qrCode // ignore: cast_nullable_to_non_nullable
              as String?,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      isReprint: null == isReprint
          ? _value.isReprint
          : isReprint // ignore: cast_nullable_to_non_nullable
              as bool,
      reprintCount: freezed == reprintCount
          ? _value.reprintCount
          : reprintCount // ignore: cast_nullable_to_non_nullable
              as int?,
      reprintReason: freezed == reprintReason
          ? _value.reprintReason
          : reprintReason // ignore: cast_nullable_to_non_nullable
              as String?,
      emailedAt: freezed == emailedAt
          ? _value.emailedAt
          : emailedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      emailedTo: freezed == emailedTo
          ? _value.emailedTo
          : emailedTo // ignore: cast_nullable_to_non_nullable
              as String?,
      smsAt: freezed == smsAt
          ? _value.smsAt
          : smsAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      smsTo: freezed == smsTo
          ? _value.smsTo
          : smsTo // ignore: cast_nullable_to_non_nullable
              as String?,
      signatureUrl: freezed == signatureUrl
          ? _value.signatureUrl
          : signatureUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      headerData: null == headerData
          ? _value._headerData
          : headerData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      footerData: null == footerData
          ? _value._footerData
          : footerData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReceiptImpl extends _Receipt {
  const _$ReceiptImpl(
      {required this.id,
      required this.saleId,
      required this.receiptNumber,
      this.template = 'default',
      final Map<String, dynamic> customFields = const {},
      this.format = 'thermal',
      this.isPrinted = false,
      this.printedAt,
      this.printerName,
      this.digitalReceipt,
      required this.createdAt,
      this.syncedAt,
      this.organizationId,
      this.branchId,
      this.registerId,
      this.cashierId,
      final Map<String, dynamic> metadata = const {},
      this.qrCode,
      this.barcode,
      this.isReprint = false,
      this.reprintCount,
      this.reprintReason,
      this.emailedAt,
      this.emailedTo,
      this.smsAt,
      this.smsTo,
      this.signatureUrl,
      final Map<String, dynamic> headerData = const {},
      final Map<String, dynamic> footerData = const {}})
      : _customFields = customFields,
        _metadata = metadata,
        _headerData = headerData,
        _footerData = footerData,
        super._();

  factory _$ReceiptImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReceiptImplFromJson(json);

  @override
  final String id;
  @override
  final String saleId;
  @override
  final String receiptNumber;
  @override
  @JsonKey()
  final String template;
  final Map<String, dynamic> _customFields;
  @override
  @JsonKey()
  Map<String, dynamic> get customFields {
    if (_customFields is EqualUnmodifiableMapView) return _customFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_customFields);
  }

  @override
  @JsonKey()
  final String format;
  @override
  @JsonKey()
  final bool isPrinted;
  @override
  final DateTime? printedAt;
  @override
  final String? printerName;
  @override
  final String? digitalReceipt;
  @override
  final DateTime createdAt;
  @override
  final DateTime? syncedAt;
// Additional fields
  @override
  final String? organizationId;
  @override
  final String? branchId;
  @override
  final String? registerId;
  @override
  final String? cashierId;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  final String? qrCode;
  @override
  final String? barcode;
  @override
  @JsonKey()
  final bool isReprint;
  @override
  final int? reprintCount;
  @override
  final String? reprintReason;
  @override
  final DateTime? emailedAt;
  @override
  final String? emailedTo;
  @override
  final DateTime? smsAt;
  @override
  final String? smsTo;
  @override
  final String? signatureUrl;
  final Map<String, dynamic> _headerData;
  @override
  @JsonKey()
  Map<String, dynamic> get headerData {
    if (_headerData is EqualUnmodifiableMapView) return _headerData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_headerData);
  }

  final Map<String, dynamic> _footerData;
  @override
  @JsonKey()
  Map<String, dynamic> get footerData {
    if (_footerData is EqualUnmodifiableMapView) return _footerData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_footerData);
  }

  @override
  String toString() {
    return 'Receipt(id: $id, saleId: $saleId, receiptNumber: $receiptNumber, template: $template, customFields: $customFields, format: $format, isPrinted: $isPrinted, printedAt: $printedAt, printerName: $printerName, digitalReceipt: $digitalReceipt, createdAt: $createdAt, syncedAt: $syncedAt, organizationId: $organizationId, branchId: $branchId, registerId: $registerId, cashierId: $cashierId, metadata: $metadata, qrCode: $qrCode, barcode: $barcode, isReprint: $isReprint, reprintCount: $reprintCount, reprintReason: $reprintReason, emailedAt: $emailedAt, emailedTo: $emailedTo, smsAt: $smsAt, smsTo: $smsTo, signatureUrl: $signatureUrl, headerData: $headerData, footerData: $footerData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReceiptImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.saleId, saleId) || other.saleId == saleId) &&
            (identical(other.receiptNumber, receiptNumber) ||
                other.receiptNumber == receiptNumber) &&
            (identical(other.template, template) ||
                other.template == template) &&
            const DeepCollectionEquality()
                .equals(other._customFields, _customFields) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.isPrinted, isPrinted) ||
                other.isPrinted == isPrinted) &&
            (identical(other.printedAt, printedAt) ||
                other.printedAt == printedAt) &&
            (identical(other.printerName, printerName) ||
                other.printerName == printerName) &&
            (identical(other.digitalReceipt, digitalReceipt) ||
                other.digitalReceipt == digitalReceipt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.branchId, branchId) ||
                other.branchId == branchId) &&
            (identical(other.registerId, registerId) ||
                other.registerId == registerId) &&
            (identical(other.cashierId, cashierId) ||
                other.cashierId == cashierId) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.qrCode, qrCode) || other.qrCode == qrCode) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.isReprint, isReprint) ||
                other.isReprint == isReprint) &&
            (identical(other.reprintCount, reprintCount) ||
                other.reprintCount == reprintCount) &&
            (identical(other.reprintReason, reprintReason) ||
                other.reprintReason == reprintReason) &&
            (identical(other.emailedAt, emailedAt) ||
                other.emailedAt == emailedAt) &&
            (identical(other.emailedTo, emailedTo) ||
                other.emailedTo == emailedTo) &&
            (identical(other.smsAt, smsAt) || other.smsAt == smsAt) &&
            (identical(other.smsTo, smsTo) || other.smsTo == smsTo) &&
            (identical(other.signatureUrl, signatureUrl) ||
                other.signatureUrl == signatureUrl) &&
            const DeepCollectionEquality()
                .equals(other._headerData, _headerData) &&
            const DeepCollectionEquality()
                .equals(other._footerData, _footerData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        saleId,
        receiptNumber,
        template,
        const DeepCollectionEquality().hash(_customFields),
        format,
        isPrinted,
        printedAt,
        printerName,
        digitalReceipt,
        createdAt,
        syncedAt,
        organizationId,
        branchId,
        registerId,
        cashierId,
        const DeepCollectionEquality().hash(_metadata),
        qrCode,
        barcode,
        isReprint,
        reprintCount,
        reprintReason,
        emailedAt,
        emailedTo,
        smsAt,
        smsTo,
        signatureUrl,
        const DeepCollectionEquality().hash(_headerData),
        const DeepCollectionEquality().hash(_footerData)
      ]);

  /// Create a copy of Receipt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReceiptImplCopyWith<_$ReceiptImpl> get copyWith =>
      __$$ReceiptImplCopyWithImpl<_$ReceiptImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReceiptImplToJson(
      this,
    );
  }
}

abstract class _Receipt extends Receipt {
  const factory _Receipt(
      {required final String id,
      required final String saleId,
      required final String receiptNumber,
      final String template,
      final Map<String, dynamic> customFields,
      final String format,
      final bool isPrinted,
      final DateTime? printedAt,
      final String? printerName,
      final String? digitalReceipt,
      required final DateTime createdAt,
      final DateTime? syncedAt,
      final String? organizationId,
      final String? branchId,
      final String? registerId,
      final String? cashierId,
      final Map<String, dynamic> metadata,
      final String? qrCode,
      final String? barcode,
      final bool isReprint,
      final int? reprintCount,
      final String? reprintReason,
      final DateTime? emailedAt,
      final String? emailedTo,
      final DateTime? smsAt,
      final String? smsTo,
      final String? signatureUrl,
      final Map<String, dynamic> headerData,
      final Map<String, dynamic> footerData}) = _$ReceiptImpl;
  const _Receipt._() : super._();

  factory _Receipt.fromJson(Map<String, dynamic> json) = _$ReceiptImpl.fromJson;

  @override
  String get id;
  @override
  String get saleId;
  @override
  String get receiptNumber;
  @override
  String get template;
  @override
  Map<String, dynamic> get customFields;
  @override
  String get format;
  @override
  bool get isPrinted;
  @override
  DateTime? get printedAt;
  @override
  String? get printerName;
  @override
  String? get digitalReceipt;
  @override
  DateTime get createdAt;
  @override
  DateTime? get syncedAt; // Additional fields
  @override
  String? get organizationId;
  @override
  String? get branchId;
  @override
  String? get registerId;
  @override
  String? get cashierId;
  @override
  Map<String, dynamic> get metadata;
  @override
  String? get qrCode;
  @override
  String? get barcode;
  @override
  bool get isReprint;
  @override
  int? get reprintCount;
  @override
  String? get reprintReason;
  @override
  DateTime? get emailedAt;
  @override
  String? get emailedTo;
  @override
  DateTime? get smsAt;
  @override
  String? get smsTo;
  @override
  String? get signatureUrl;
  @override
  Map<String, dynamic> get headerData;
  @override
  Map<String, dynamic> get footerData;

  /// Create a copy of Receipt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReceiptImplCopyWith<_$ReceiptImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
