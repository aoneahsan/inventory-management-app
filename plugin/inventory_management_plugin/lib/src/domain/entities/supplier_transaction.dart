import 'package:freezed_annotation/freezed_annotation.dart';

part 'supplier_transaction.freezed.dart';
part 'supplier_transaction.g.dart';

enum SupplierTransactionType {
  @JsonValue('purchase')
  purchase,
  @JsonValue('payment')
  payment,
  @JsonValue('return')
  return_,
  @JsonValue('credit_note')
  creditNote,
  @JsonValue('debit_note')
  debitNote,
  @JsonValue('opening_balance')
  openingBalance,
  @JsonValue('adjustment')
  adjustment,
  @JsonValue('discount')
  discount,
}

enum PaymentMethod {
  @JsonValue('cash')
  cash,
  @JsonValue('bank_transfer')
  bankTransfer,
  @JsonValue('cheque')
  cheque,
  @JsonValue('credit_card')
  creditCard,
  @JsonValue('digital_wallet')
  digitalWallet,
  @JsonValue('other')
  other,
}

@freezed
class SupplierTransaction with _$SupplierTransaction {
  const factory SupplierTransaction({
    required String id,
    required String organizationId,
    required String supplierId,
    required SupplierTransactionType transactionType,
    String? referenceId,
    String? referenceType,
    required double amount,
    required double balance,
    required DateTime transactionDate,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
    
    // Additional fields
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
    @Default('completed') String status,
    @Default({}) Map<String, dynamic> metadata,
    String? attachmentUrl,
    String? currency,
    double? exchangeRate,
    double? discountAmount,
    double? taxAmount,
  }) = _SupplierTransaction;
  
  const SupplierTransaction._();
  
  factory SupplierTransaction.fromJson(Map<String, dynamic> json) => 
      _$SupplierTransactionFromJson(json);
  
  // Helper methods
  bool get isPurchase => transactionType == SupplierTransactionType.purchase;
  bool get isPayment => transactionType == SupplierTransactionType.payment;
  bool get isReturn => transactionType == SupplierTransactionType.return_;
  bool get isCreditNote => transactionType == SupplierTransactionType.creditNote;
  bool get isDebitNote => transactionType == SupplierTransactionType.debitNote;
  bool get isAdjustment => transactionType == SupplierTransactionType.adjustment;
  
  bool get isDebit => isPurchase || isDebitNote;
  bool get isCredit => isPayment || isCreditNote || isReturn;
  
  double get effectiveAmount => isCredit ? -amount.abs() : amount.abs();
  
  bool get isPending => status == 'pending';
  bool get isCompleted => status == 'completed';
  bool get isCancelled => status == 'cancelled';
  bool get needsApproval => status == 'pending' && approvedAt == null;
  
  String get displayType {
    switch (transactionType) {
      case SupplierTransactionType.purchase:
        return 'Purchase';
      case SupplierTransactionType.payment:
        return 'Payment';
      case SupplierTransactionType.return_:
        return 'Return';
      case SupplierTransactionType.creditNote:
        return 'Credit Note';
      case SupplierTransactionType.debitNote:
        return 'Debit Note';
      case SupplierTransactionType.openingBalance:
        return 'Opening Balance';
      case SupplierTransactionType.adjustment:
        return 'Adjustment';
      case SupplierTransactionType.discount:
        return 'Discount';
    }
  }
  
  String get amountDisplay {
    final sign = isDebit ? '+' : '-';
    final curr = currency ?? 'USD';
    return '$sign $curr ${amount.toStringAsFixed(2)}';
  }
  
  String get paymentMethodDisplay {
    if (paymentMethod == null) return '';
    switch (paymentMethod!) {
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.bankTransfer:
        return 'Bank Transfer';
      case PaymentMethod.cheque:
        return 'Cheque';
      case PaymentMethod.creditCard:
        return 'Credit Card';
      case PaymentMethod.digitalWallet:
        return 'Digital Wallet';
      case PaymentMethod.other:
        return 'Other';
    }
  }
}

@freezed
class SupplierPaymentSchedule with _$SupplierPaymentSchedule {
  const factory SupplierPaymentSchedule({
    required String id,
    required String supplierId,
    required String referenceId,
    required double amount,
    required DateTime dueDate,
    @Default('pending') String status,
    double? paidAmount,
    DateTime? paidDate,
    String? notes,
    required DateTime createdAt,
  }) = _SupplierPaymentSchedule;
  
  const SupplierPaymentSchedule._();
  
  factory SupplierPaymentSchedule.fromJson(Map<String, dynamic> json) => 
      _$SupplierPaymentScheduleFromJson(json);
  
  bool get isPending => status == 'pending';
  bool get isPaid => status == 'paid';
  bool get isPartiallyPaid => status == 'partial';
  bool get isOverdue => isPending && dueDate.isBefore(DateTime.now());
  
  int get daysOverdue {
    if (!isOverdue) return 0;
    return DateTime.now().difference(dueDate).inDays;
  }
  
  double get remainingAmount => amount - (paidAmount ?? 0);
  double get paidPercentage => amount > 0 ? ((paidAmount ?? 0) / amount) * 100 : 0;
}