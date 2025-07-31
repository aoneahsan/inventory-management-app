// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'supplier_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SupplierTransaction _$SupplierTransactionFromJson(Map<String, dynamic> json) {
  return _SupplierTransaction.fromJson(json);
}

/// @nodoc
mixin _$SupplierTransaction {
  String get id => throw _privateConstructorUsedError;
  String get organizationId => throw _privateConstructorUsedError;
  String get supplierId => throw _privateConstructorUsedError;
  SupplierTransactionType get transactionType =>
      throw _privateConstructorUsedError;
  String? get referenceId => throw _privateConstructorUsedError;
  String? get referenceType => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  double get balance => throw _privateConstructorUsedError;
  DateTime get transactionDate => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get syncedAt =>
      throw _privateConstructorUsedError; // Additional fields
  String? get invoiceNumber => throw _privateConstructorUsedError;
  String? get receiptNumber => throw _privateConstructorUsedError;
  PaymentMethod? get paymentMethod => throw _privateConstructorUsedError;
  String? get paymentReference => throw _privateConstructorUsedError;
  String? get bankName => throw _privateConstructorUsedError;
  String? get chequeNumber => throw _privateConstructorUsedError;
  DateTime? get chequeDate => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;
  String? get approvedBy => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  String? get attachmentUrl => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  double? get exchangeRate => throw _privateConstructorUsedError;
  double? get discountAmount => throw _privateConstructorUsedError;
  double? get taxAmount => throw _privateConstructorUsedError;

  /// Serializes this SupplierTransaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SupplierTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SupplierTransactionCopyWith<SupplierTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupplierTransactionCopyWith<$Res> {
  factory $SupplierTransactionCopyWith(
          SupplierTransaction value, $Res Function(SupplierTransaction) then) =
      _$SupplierTransactionCopyWithImpl<$Res, SupplierTransaction>;
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String supplierId,
      SupplierTransactionType transactionType,
      String? referenceId,
      String? referenceType,
      double amount,
      double balance,
      DateTime transactionDate,
      String? notes,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? invoiceNumber,
      String? receiptNumber,
      PaymentMethod? paymentMethod,
      String? paymentReference,
      String? bankName,
      String? chequeNumber,
      DateTime? chequeDate,
      String? createdBy,
      String? approvedBy,
      DateTime? approvedAt,
      String status,
      Map<String, dynamic> metadata,
      String? attachmentUrl,
      String? currency,
      double? exchangeRate,
      double? discountAmount,
      double? taxAmount});
}

/// @nodoc
class _$SupplierTransactionCopyWithImpl<$Res, $Val extends SupplierTransaction>
    implements $SupplierTransactionCopyWith<$Res> {
  _$SupplierTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SupplierTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? supplierId = null,
    Object? transactionType = null,
    Object? referenceId = freezed,
    Object? referenceType = freezed,
    Object? amount = null,
    Object? balance = null,
    Object? transactionDate = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? invoiceNumber = freezed,
    Object? receiptNumber = freezed,
    Object? paymentMethod = freezed,
    Object? paymentReference = freezed,
    Object? bankName = freezed,
    Object? chequeNumber = freezed,
    Object? chequeDate = freezed,
    Object? createdBy = freezed,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
    Object? status = null,
    Object? metadata = null,
    Object? attachmentUrl = freezed,
    Object? currency = freezed,
    Object? exchangeRate = freezed,
    Object? discountAmount = freezed,
    Object? taxAmount = freezed,
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
      supplierId: null == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as String,
      transactionType: null == transactionType
          ? _value.transactionType
          : transactionType // ignore: cast_nullable_to_non_nullable
              as SupplierTransactionType,
      referenceId: freezed == referenceId
          ? _value.referenceId
          : referenceId // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceType: freezed == referenceType
          ? _value.referenceType
          : referenceType // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      transactionDate: null == transactionDate
          ? _value.transactionDate
          : transactionDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
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
      invoiceNumber: freezed == invoiceNumber
          ? _value.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      receiptNumber: freezed == receiptNumber
          ? _value.receiptNumber
          : receiptNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod?,
      paymentReference: freezed == paymentReference
          ? _value.paymentReference
          : paymentReference // ignore: cast_nullable_to_non_nullable
              as String?,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      chequeNumber: freezed == chequeNumber
          ? _value.chequeNumber
          : chequeNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      chequeDate: freezed == chequeDate
          ? _value.chequeDate
          : chequeDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      attachmentUrl: freezed == attachmentUrl
          ? _value.attachmentUrl
          : attachmentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      exchangeRate: freezed == exchangeRate
          ? _value.exchangeRate
          : exchangeRate // ignore: cast_nullable_to_non_nullable
              as double?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      taxAmount: freezed == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SupplierTransactionImplCopyWith<$Res>
    implements $SupplierTransactionCopyWith<$Res> {
  factory _$$SupplierTransactionImplCopyWith(_$SupplierTransactionImpl value,
          $Res Function(_$SupplierTransactionImpl) then) =
      __$$SupplierTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String organizationId,
      String supplierId,
      SupplierTransactionType transactionType,
      String? referenceId,
      String? referenceType,
      double amount,
      double balance,
      DateTime transactionDate,
      String? notes,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? syncedAt,
      String? invoiceNumber,
      String? receiptNumber,
      PaymentMethod? paymentMethod,
      String? paymentReference,
      String? bankName,
      String? chequeNumber,
      DateTime? chequeDate,
      String? createdBy,
      String? approvedBy,
      DateTime? approvedAt,
      String status,
      Map<String, dynamic> metadata,
      String? attachmentUrl,
      String? currency,
      double? exchangeRate,
      double? discountAmount,
      double? taxAmount});
}

/// @nodoc
class __$$SupplierTransactionImplCopyWithImpl<$Res>
    extends _$SupplierTransactionCopyWithImpl<$Res, _$SupplierTransactionImpl>
    implements _$$SupplierTransactionImplCopyWith<$Res> {
  __$$SupplierTransactionImplCopyWithImpl(_$SupplierTransactionImpl _value,
      $Res Function(_$SupplierTransactionImpl) _then)
      : super(_value, _then);

  /// Create a copy of SupplierTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? organizationId = null,
    Object? supplierId = null,
    Object? transactionType = null,
    Object? referenceId = freezed,
    Object? referenceType = freezed,
    Object? amount = null,
    Object? balance = null,
    Object? transactionDate = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? syncedAt = freezed,
    Object? invoiceNumber = freezed,
    Object? receiptNumber = freezed,
    Object? paymentMethod = freezed,
    Object? paymentReference = freezed,
    Object? bankName = freezed,
    Object? chequeNumber = freezed,
    Object? chequeDate = freezed,
    Object? createdBy = freezed,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
    Object? status = null,
    Object? metadata = null,
    Object? attachmentUrl = freezed,
    Object? currency = freezed,
    Object? exchangeRate = freezed,
    Object? discountAmount = freezed,
    Object? taxAmount = freezed,
  }) {
    return _then(_$SupplierTransactionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: null == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String,
      supplierId: null == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as String,
      transactionType: null == transactionType
          ? _value.transactionType
          : transactionType // ignore: cast_nullable_to_non_nullable
              as SupplierTransactionType,
      referenceId: freezed == referenceId
          ? _value.referenceId
          : referenceId // ignore: cast_nullable_to_non_nullable
              as String?,
      referenceType: freezed == referenceType
          ? _value.referenceType
          : referenceType // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      transactionDate: null == transactionDate
          ? _value.transactionDate
          : transactionDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
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
      invoiceNumber: freezed == invoiceNumber
          ? _value.invoiceNumber
          : invoiceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      receiptNumber: freezed == receiptNumber
          ? _value.receiptNumber
          : receiptNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod?,
      paymentReference: freezed == paymentReference
          ? _value.paymentReference
          : paymentReference // ignore: cast_nullable_to_non_nullable
              as String?,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      chequeNumber: freezed == chequeNumber
          ? _value.chequeNumber
          : chequeNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      chequeDate: freezed == chequeDate
          ? _value.chequeDate
          : chequeDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      attachmentUrl: freezed == attachmentUrl
          ? _value.attachmentUrl
          : attachmentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      exchangeRate: freezed == exchangeRate
          ? _value.exchangeRate
          : exchangeRate // ignore: cast_nullable_to_non_nullable
              as double?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      taxAmount: freezed == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SupplierTransactionImpl extends _SupplierTransaction {
  const _$SupplierTransactionImpl(
      {required this.id,
      required this.organizationId,
      required this.supplierId,
      required this.transactionType,
      this.referenceId,
      this.referenceType,
      required this.amount,
      required this.balance,
      required this.transactionDate,
      this.notes,
      required this.createdAt,
      required this.updatedAt,
      this.syncedAt,
      this.invoiceNumber,
      this.receiptNumber,
      this.paymentMethod,
      this.paymentReference,
      this.bankName,
      this.chequeNumber,
      this.chequeDate,
      this.createdBy,
      this.approvedBy,
      this.approvedAt,
      this.status = 'completed',
      final Map<String, dynamic> metadata = const {},
      this.attachmentUrl,
      this.currency,
      this.exchangeRate,
      this.discountAmount,
      this.taxAmount})
      : _metadata = metadata,
        super._();

  factory _$SupplierTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SupplierTransactionImplFromJson(json);

  @override
  final String id;
  @override
  final String organizationId;
  @override
  final String supplierId;
  @override
  final SupplierTransactionType transactionType;
  @override
  final String? referenceId;
  @override
  final String? referenceType;
  @override
  final double amount;
  @override
  final double balance;
  @override
  final DateTime transactionDate;
  @override
  final String? notes;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? syncedAt;
// Additional fields
  @override
  final String? invoiceNumber;
  @override
  final String? receiptNumber;
  @override
  final PaymentMethod? paymentMethod;
  @override
  final String? paymentReference;
  @override
  final String? bankName;
  @override
  final String? chequeNumber;
  @override
  final DateTime? chequeDate;
  @override
  final String? createdBy;
  @override
  final String? approvedBy;
  @override
  final DateTime? approvedAt;
  @override
  @JsonKey()
  final String status;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  final String? attachmentUrl;
  @override
  final String? currency;
  @override
  final double? exchangeRate;
  @override
  final double? discountAmount;
  @override
  final double? taxAmount;

  @override
  String toString() {
    return 'SupplierTransaction(id: $id, organizationId: $organizationId, supplierId: $supplierId, transactionType: $transactionType, referenceId: $referenceId, referenceType: $referenceType, amount: $amount, balance: $balance, transactionDate: $transactionDate, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, syncedAt: $syncedAt, invoiceNumber: $invoiceNumber, receiptNumber: $receiptNumber, paymentMethod: $paymentMethod, paymentReference: $paymentReference, bankName: $bankName, chequeNumber: $chequeNumber, chequeDate: $chequeDate, createdBy: $createdBy, approvedBy: $approvedBy, approvedAt: $approvedAt, status: $status, metadata: $metadata, attachmentUrl: $attachmentUrl, currency: $currency, exchangeRate: $exchangeRate, discountAmount: $discountAmount, taxAmount: $taxAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupplierTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.supplierId, supplierId) ||
                other.supplierId == supplierId) &&
            (identical(other.transactionType, transactionType) ||
                other.transactionType == transactionType) &&
            (identical(other.referenceId, referenceId) ||
                other.referenceId == referenceId) &&
            (identical(other.referenceType, referenceType) ||
                other.referenceType == referenceType) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.transactionDate, transactionDate) ||
                other.transactionDate == transactionDate) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt) &&
            (identical(other.invoiceNumber, invoiceNumber) ||
                other.invoiceNumber == invoiceNumber) &&
            (identical(other.receiptNumber, receiptNumber) ||
                other.receiptNumber == receiptNumber) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.paymentReference, paymentReference) ||
                other.paymentReference == paymentReference) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.chequeNumber, chequeNumber) ||
                other.chequeNumber == chequeNumber) &&
            (identical(other.chequeDate, chequeDate) ||
                other.chequeDate == chequeDate) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.attachmentUrl, attachmentUrl) ||
                other.attachmentUrl == attachmentUrl) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.exchangeRate, exchangeRate) ||
                other.exchangeRate == exchangeRate) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.taxAmount, taxAmount) ||
                other.taxAmount == taxAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        organizationId,
        supplierId,
        transactionType,
        referenceId,
        referenceType,
        amount,
        balance,
        transactionDate,
        notes,
        createdAt,
        updatedAt,
        syncedAt,
        invoiceNumber,
        receiptNumber,
        paymentMethod,
        paymentReference,
        bankName,
        chequeNumber,
        chequeDate,
        createdBy,
        approvedBy,
        approvedAt,
        status,
        const DeepCollectionEquality().hash(_metadata),
        attachmentUrl,
        currency,
        exchangeRate,
        discountAmount,
        taxAmount
      ]);

  /// Create a copy of SupplierTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SupplierTransactionImplCopyWith<_$SupplierTransactionImpl> get copyWith =>
      __$$SupplierTransactionImplCopyWithImpl<_$SupplierTransactionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SupplierTransactionImplToJson(
      this,
    );
  }
}

abstract class _SupplierTransaction extends SupplierTransaction {
  const factory _SupplierTransaction(
      {required final String id,
      required final String organizationId,
      required final String supplierId,
      required final SupplierTransactionType transactionType,
      final String? referenceId,
      final String? referenceType,
      required final double amount,
      required final double balance,
      required final DateTime transactionDate,
      final String? notes,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final DateTime? syncedAt,
      final String? invoiceNumber,
      final String? receiptNumber,
      final PaymentMethod? paymentMethod,
      final String? paymentReference,
      final String? bankName,
      final String? chequeNumber,
      final DateTime? chequeDate,
      final String? createdBy,
      final String? approvedBy,
      final DateTime? approvedAt,
      final String status,
      final Map<String, dynamic> metadata,
      final String? attachmentUrl,
      final String? currency,
      final double? exchangeRate,
      final double? discountAmount,
      final double? taxAmount}) = _$SupplierTransactionImpl;
  const _SupplierTransaction._() : super._();

  factory _SupplierTransaction.fromJson(Map<String, dynamic> json) =
      _$SupplierTransactionImpl.fromJson;

  @override
  String get id;
  @override
  String get organizationId;
  @override
  String get supplierId;
  @override
  SupplierTransactionType get transactionType;
  @override
  String? get referenceId;
  @override
  String? get referenceType;
  @override
  double get amount;
  @override
  double get balance;
  @override
  DateTime get transactionDate;
  @override
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get syncedAt; // Additional fields
  @override
  String? get invoiceNumber;
  @override
  String? get receiptNumber;
  @override
  PaymentMethod? get paymentMethod;
  @override
  String? get paymentReference;
  @override
  String? get bankName;
  @override
  String? get chequeNumber;
  @override
  DateTime? get chequeDate;
  @override
  String? get createdBy;
  @override
  String? get approvedBy;
  @override
  DateTime? get approvedAt;
  @override
  String get status;
  @override
  Map<String, dynamic> get metadata;
  @override
  String? get attachmentUrl;
  @override
  String? get currency;
  @override
  double? get exchangeRate;
  @override
  double? get discountAmount;
  @override
  double? get taxAmount;

  /// Create a copy of SupplierTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SupplierTransactionImplCopyWith<_$SupplierTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SupplierPaymentSchedule _$SupplierPaymentScheduleFromJson(
    Map<String, dynamic> json) {
  return _SupplierPaymentSchedule.fromJson(json);
}

/// @nodoc
mixin _$SupplierPaymentSchedule {
  String get id => throw _privateConstructorUsedError;
  String get supplierId => throw _privateConstructorUsedError;
  String get referenceId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  DateTime get dueDate => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  double? get paidAmount => throw _privateConstructorUsedError;
  DateTime? get paidDate => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this SupplierPaymentSchedule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SupplierPaymentSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SupplierPaymentScheduleCopyWith<SupplierPaymentSchedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupplierPaymentScheduleCopyWith<$Res> {
  factory $SupplierPaymentScheduleCopyWith(SupplierPaymentSchedule value,
          $Res Function(SupplierPaymentSchedule) then) =
      _$SupplierPaymentScheduleCopyWithImpl<$Res, SupplierPaymentSchedule>;
  @useResult
  $Res call(
      {String id,
      String supplierId,
      String referenceId,
      double amount,
      DateTime dueDate,
      String status,
      double? paidAmount,
      DateTime? paidDate,
      String? notes,
      DateTime createdAt});
}

/// @nodoc
class _$SupplierPaymentScheduleCopyWithImpl<$Res,
        $Val extends SupplierPaymentSchedule>
    implements $SupplierPaymentScheduleCopyWith<$Res> {
  _$SupplierPaymentScheduleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SupplierPaymentSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? supplierId = null,
    Object? referenceId = null,
    Object? amount = null,
    Object? dueDate = null,
    Object? status = null,
    Object? paidAmount = freezed,
    Object? paidDate = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      supplierId: null == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as String,
      referenceId: null == referenceId
          ? _value.referenceId
          : referenceId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      paidAmount: freezed == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      paidDate: freezed == paidDate
          ? _value.paidDate
          : paidDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SupplierPaymentScheduleImplCopyWith<$Res>
    implements $SupplierPaymentScheduleCopyWith<$Res> {
  factory _$$SupplierPaymentScheduleImplCopyWith(
          _$SupplierPaymentScheduleImpl value,
          $Res Function(_$SupplierPaymentScheduleImpl) then) =
      __$$SupplierPaymentScheduleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String supplierId,
      String referenceId,
      double amount,
      DateTime dueDate,
      String status,
      double? paidAmount,
      DateTime? paidDate,
      String? notes,
      DateTime createdAt});
}

/// @nodoc
class __$$SupplierPaymentScheduleImplCopyWithImpl<$Res>
    extends _$SupplierPaymentScheduleCopyWithImpl<$Res,
        _$SupplierPaymentScheduleImpl>
    implements _$$SupplierPaymentScheduleImplCopyWith<$Res> {
  __$$SupplierPaymentScheduleImplCopyWithImpl(
      _$SupplierPaymentScheduleImpl _value,
      $Res Function(_$SupplierPaymentScheduleImpl) _then)
      : super(_value, _then);

  /// Create a copy of SupplierPaymentSchedule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? supplierId = null,
    Object? referenceId = null,
    Object? amount = null,
    Object? dueDate = null,
    Object? status = null,
    Object? paidAmount = freezed,
    Object? paidDate = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$SupplierPaymentScheduleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      supplierId: null == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as String,
      referenceId: null == referenceId
          ? _value.referenceId
          : referenceId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      paidAmount: freezed == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      paidDate: freezed == paidDate
          ? _value.paidDate
          : paidDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SupplierPaymentScheduleImpl extends _SupplierPaymentSchedule {
  const _$SupplierPaymentScheduleImpl(
      {required this.id,
      required this.supplierId,
      required this.referenceId,
      required this.amount,
      required this.dueDate,
      this.status = 'pending',
      this.paidAmount,
      this.paidDate,
      this.notes,
      required this.createdAt})
      : super._();

  factory _$SupplierPaymentScheduleImpl.fromJson(Map<String, dynamic> json) =>
      _$$SupplierPaymentScheduleImplFromJson(json);

  @override
  final String id;
  @override
  final String supplierId;
  @override
  final String referenceId;
  @override
  final double amount;
  @override
  final DateTime dueDate;
  @override
  @JsonKey()
  final String status;
  @override
  final double? paidAmount;
  @override
  final DateTime? paidDate;
  @override
  final String? notes;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'SupplierPaymentSchedule(id: $id, supplierId: $supplierId, referenceId: $referenceId, amount: $amount, dueDate: $dueDate, status: $status, paidAmount: $paidAmount, paidDate: $paidDate, notes: $notes, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupplierPaymentScheduleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.supplierId, supplierId) ||
                other.supplierId == supplierId) &&
            (identical(other.referenceId, referenceId) ||
                other.referenceId == referenceId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.paidDate, paidDate) ||
                other.paidDate == paidDate) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, supplierId, referenceId,
      amount, dueDate, status, paidAmount, paidDate, notes, createdAt);

  /// Create a copy of SupplierPaymentSchedule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SupplierPaymentScheduleImplCopyWith<_$SupplierPaymentScheduleImpl>
      get copyWith => __$$SupplierPaymentScheduleImplCopyWithImpl<
          _$SupplierPaymentScheduleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SupplierPaymentScheduleImplToJson(
      this,
    );
  }
}

abstract class _SupplierPaymentSchedule extends SupplierPaymentSchedule {
  const factory _SupplierPaymentSchedule(
      {required final String id,
      required final String supplierId,
      required final String referenceId,
      required final double amount,
      required final DateTime dueDate,
      final String status,
      final double? paidAmount,
      final DateTime? paidDate,
      final String? notes,
      required final DateTime createdAt}) = _$SupplierPaymentScheduleImpl;
  const _SupplierPaymentSchedule._() : super._();

  factory _SupplierPaymentSchedule.fromJson(Map<String, dynamic> json) =
      _$SupplierPaymentScheduleImpl.fromJson;

  @override
  String get id;
  @override
  String get supplierId;
  @override
  String get referenceId;
  @override
  double get amount;
  @override
  DateTime get dueDate;
  @override
  String get status;
  @override
  double? get paidAmount;
  @override
  DateTime? get paidDate;
  @override
  String? get notes;
  @override
  DateTime get createdAt;

  /// Create a copy of SupplierPaymentSchedule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SupplierPaymentScheduleImplCopyWith<_$SupplierPaymentScheduleImpl>
      get copyWith => throw _privateConstructorUsedError;
}
