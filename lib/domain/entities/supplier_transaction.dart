import 'package:equatable/equatable.dart';

class SupplierTransaction extends Equatable {
  final String id;
  final String supplierId;
  final String transactionType; // purchase, payment, return, credit_note
  final String? referenceId; // Reference to purchase order, bill, or payment
  final double amount;
  final double balance; // Running balance after this transaction
  final DateTime transactionDate;
  final String? notes;
  final DateTime createdAt;

  const SupplierTransaction({
    required this.id,
    required this.supplierId,
    required this.transactionType,
    this.referenceId,
    required this.amount,
    required this.balance,
    required this.transactionDate,
    this.notes,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        supplierId,
        transactionType,
        referenceId,
        amount,
        balance,
        transactionDate,
        notes,
        createdAt,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'supplier_id': supplierId,
      'transaction_type': transactionType,
      'reference_id': referenceId,
      'amount': amount,
      'balance': balance,
      'transaction_date': transactionDate.millisecondsSinceEpoch,
      'notes': notes,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  factory SupplierTransaction.fromMap(Map<String, dynamic> map) {
    return SupplierTransaction(
      id: map['id'] as String,
      supplierId: map['supplier_id'] as String,
      transactionType: map['transaction_type'] as String,
      referenceId: map['reference_id'] as String?,
      amount: (map['amount'] ?? 0).toDouble(),
      balance: (map['balance'] ?? 0).toDouble(),
      transactionDate: DateTime.fromMillisecondsSinceEpoch(
          map['transaction_date'] as int),
      notes: map['notes'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
    );
  }

  SupplierTransaction copyWith({
    String? id,
    String? supplierId,
    String? transactionType,
    String? referenceId,
    double? amount,
    double? balance,
    DateTime? transactionDate,
    String? notes,
    DateTime? createdAt,
  }) {
    return SupplierTransaction(
      id: id ?? this.id,
      supplierId: supplierId ?? this.supplierId,
      transactionType: transactionType ?? this.transactionType,
      referenceId: referenceId ?? this.referenceId,
      amount: amount ?? this.amount,
      balance: balance ?? this.balance,
      transactionDate: transactionDate ?? this.transactionDate,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Helper methods
  bool get isPurchase => transactionType == 'purchase';
  bool get isPayment => transactionType == 'payment';
  bool get isReturn => transactionType == 'return';
  bool get isCreditNote => transactionType == 'credit_note';

  bool get isDebit => isPurchase || isReturn;
  bool get isCredit => isPayment || isCreditNote;

  String get displayType {
    switch (transactionType) {
      case 'purchase':
        return 'Purchase';
      case 'payment':
        return 'Payment';
      case 'return':
        return 'Return';
      case 'credit_note':
        return 'Credit Note';
      default:
        return transactionType;
    }
  }

  String get amountDisplay {
    final sign = isDebit ? '+' : '-';
    return '$sign\$${amount.toStringAsFixed(2)}';
  }
}