// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SupplierTransactionImpl _$$SupplierTransactionImplFromJson(
        Map<String, dynamic> json) =>
    _$SupplierTransactionImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      supplierId: json['supplierId'] as String,
      transactionType: $enumDecode(
          _$SupplierTransactionTypeEnumMap, json['transactionType']),
      referenceId: json['referenceId'] as String?,
      referenceType: json['referenceType'] as String?,
      amount: (json['amount'] as num).toDouble(),
      balance: (json['balance'] as num).toDouble(),
      transactionDate: DateTime.parse(json['transactionDate'] as String),
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      invoiceNumber: json['invoiceNumber'] as String?,
      receiptNumber: json['receiptNumber'] as String?,
      paymentMethod:
          $enumDecodeNullable(_$PaymentMethodEnumMap, json['paymentMethod']),
      paymentReference: json['paymentReference'] as String?,
      bankName: json['bankName'] as String?,
      chequeNumber: json['chequeNumber'] as String?,
      chequeDate: json['chequeDate'] == null
          ? null
          : DateTime.parse(json['chequeDate'] as String),
      createdBy: json['createdBy'] as String?,
      approvedBy: json['approvedBy'] as String?,
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      status: json['status'] as String? ?? 'completed',
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      attachmentUrl: json['attachmentUrl'] as String?,
      currency: json['currency'] as String?,
      exchangeRate: (json['exchangeRate'] as num?)?.toDouble(),
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
      taxAmount: (json['taxAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$SupplierTransactionImplToJson(
        _$SupplierTransactionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'supplierId': instance.supplierId,
      'transactionType':
          _$SupplierTransactionTypeEnumMap[instance.transactionType]!,
      'referenceId': instance.referenceId,
      'referenceType': instance.referenceType,
      'amount': instance.amount,
      'balance': instance.balance,
      'transactionDate': instance.transactionDate.toIso8601String(),
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'invoiceNumber': instance.invoiceNumber,
      'receiptNumber': instance.receiptNumber,
      'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod],
      'paymentReference': instance.paymentReference,
      'bankName': instance.bankName,
      'chequeNumber': instance.chequeNumber,
      'chequeDate': instance.chequeDate?.toIso8601String(),
      'createdBy': instance.createdBy,
      'approvedBy': instance.approvedBy,
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'status': instance.status,
      'metadata': instance.metadata,
      'attachmentUrl': instance.attachmentUrl,
      'currency': instance.currency,
      'exchangeRate': instance.exchangeRate,
      'discountAmount': instance.discountAmount,
      'taxAmount': instance.taxAmount,
    };

const _$SupplierTransactionTypeEnumMap = {
  SupplierTransactionType.purchase: 'purchase',
  SupplierTransactionType.payment: 'payment',
  SupplierTransactionType.return_: 'return',
  SupplierTransactionType.creditNote: 'credit_note',
  SupplierTransactionType.debitNote: 'debit_note',
  SupplierTransactionType.openingBalance: 'opening_balance',
  SupplierTransactionType.adjustment: 'adjustment',
  SupplierTransactionType.discount: 'discount',
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.cash: 'cash',
  PaymentMethod.bankTransfer: 'bank_transfer',
  PaymentMethod.cheque: 'cheque',
  PaymentMethod.creditCard: 'credit_card',
  PaymentMethod.digitalWallet: 'digital_wallet',
  PaymentMethod.other: 'other',
};

_$SupplierPaymentScheduleImpl _$$SupplierPaymentScheduleImplFromJson(
        Map<String, dynamic> json) =>
    _$SupplierPaymentScheduleImpl(
      id: json['id'] as String,
      supplierId: json['supplierId'] as String,
      referenceId: json['referenceId'] as String,
      amount: (json['amount'] as num).toDouble(),
      dueDate: DateTime.parse(json['dueDate'] as String),
      status: json['status'] as String? ?? 'pending',
      paidAmount: (json['paidAmount'] as num?)?.toDouble(),
      paidDate: json['paidDate'] == null
          ? null
          : DateTime.parse(json['paidDate'] as String),
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$SupplierPaymentScheduleImplToJson(
        _$SupplierPaymentScheduleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'supplierId': instance.supplierId,
      'referenceId': instance.referenceId,
      'amount': instance.amount,
      'dueDate': instance.dueDate.toIso8601String(),
      'status': instance.status,
      'paidAmount': instance.paidAmount,
      'paidDate': instance.paidDate?.toIso8601String(),
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
    };
