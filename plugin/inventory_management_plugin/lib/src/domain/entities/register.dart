import 'package:freezed_annotation/freezed_annotation.dart';

part 'register.freezed.dart';
part 'register.g.dart';

enum RegisterStatus {
  @JsonValue('open')
  open,
  @JsonValue('closed')
  closed,
  @JsonValue('suspended')
  suspended,
  @JsonValue('counting')
  counting,
  @JsonValue('reconciling')
  reconciling,
}

enum RegisterTransactionType {
  @JsonValue('sale')
  sale,
  @JsonValue('refund')
  refund,
  @JsonValue('cash_in')
  cashIn,
  @JsonValue('cash_out')
  cashOut,
  @JsonValue('adjustment')
  adjustment,
  @JsonValue('float_addition')
  floatAddition,
  @JsonValue('float_removal')
  floatRemoval,
  @JsonValue('tips')
  tips,
}

@freezed
class Register with _$Register {
  const factory Register({
    required String id,
    required String organizationId,
    required String branchId,
    required String name,
    String? location,
    @Default(0) double openingBalance,
    @Default(0) double currentBalance,
    @Default(0) double expectedBalance,
    required RegisterStatus status,
    required String openedBy,
    required DateTime openedAt,
    String? closedBy,
    DateTime? closedAt,
    @Default({}) Map<String, int> denominations,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
    
    // Additional fields
    @Default(0) double totalSales,
    @Default(0) double totalRefunds,
    @Default(0) double totalCashIn,
    @Default(0) double totalCashOut,
    @Default(0) int transactionCount,
    @Default({}) Map<String, double> paymentMethodTotals,
    String? notes,
    @Default([]) List<RegisterTransaction> recentTransactions,
    @Default({}) Map<String, dynamic> metadata,
    String? terminalId,
    @Default(false) bool requiresFloatCount,
    DateTime? lastActivityAt,
  }) = _Register;
  
  const Register._();
  
  factory Register.fromJson(Map<String, dynamic> json) => 
      _$RegisterFromJson(json);
  
  // Helper methods
  double get cashDifference => currentBalance - expectedBalance;
  bool get hasDiscrepancy => cashDifference.abs() > 0.01;
  bool get isOver => cashDifference > 0;
  bool get isShort => cashDifference < 0;
  
  bool get isOpen => status == RegisterStatus.open;
  bool get isClosed => status == RegisterStatus.closed;
  bool get isSuspended => status == RegisterStatus.suspended;
  bool get isCounting => status == RegisterStatus.counting;
  bool get isReconciling => status == RegisterStatus.reconciling;
  
  bool get canAcceptTransactions => isOpen;
  bool get canClose => isOpen || isCounting;
  bool get canSuspend => isOpen;
  bool get canResume => isSuspended;
  
  double get netCashFlow => totalCashIn - totalCashOut;
  double get grossRevenue => totalSales - totalRefunds;
  
  Duration get sessionDuration {
    final endTime = closedAt ?? DateTime.now();
    return endTime.difference(openedAt);
  }
  
  double getPaymentMethodTotal(String method) {
    return paymentMethodTotals[method] ?? 0;
  }
  
  int getDenominationCount(String denomination) {
    return denominations[denomination] ?? 0;
  }
  
  double calculateDenominationTotal() {
    double total = 0;
    denominations.forEach((denom, count) {
      final value = double.tryParse(denom) ?? 0;
      total += value * count;
    });
    return total;
  }
}

@freezed
class RegisterTransaction with _$RegisterTransaction {
  const factory RegisterTransaction({
    required String id,
    required String registerId,
    required RegisterTransactionType type,
    required double amount,
    String? reason,
    required String performedBy,
    required DateTime createdAt,
    
    // Additional fields
    String? referenceId,
    String? referenceType,
    String? paymentMethod,
    @Default({}) Map<String, dynamic> metadata,
    String? notes,
  }) = _RegisterTransaction;
  
  const RegisterTransaction._();
  
  factory RegisterTransaction.fromJson(Map<String, dynamic> json) => 
      _$RegisterTransactionFromJson(json);
  
  // Helper methods
  bool get isInflow => 
      type == RegisterTransactionType.sale || 
      type == RegisterTransactionType.cashIn ||
      type == RegisterTransactionType.floatAddition;
      
  bool get isOutflow => 
      type == RegisterTransactionType.refund || 
      type == RegisterTransactionType.cashOut ||
      type == RegisterTransactionType.floatRemoval;
      
  double get effectiveAmount => isOutflow ? -amount.abs() : amount.abs();
  
  String get typeDisplayName {
    switch (type) {
      case RegisterTransactionType.sale:
        return 'Sale';
      case RegisterTransactionType.refund:
        return 'Refund';
      case RegisterTransactionType.cashIn:
        return 'Cash In';
      case RegisterTransactionType.cashOut:
        return 'Cash Out';
      case RegisterTransactionType.adjustment:
        return 'Adjustment';
      case RegisterTransactionType.floatAddition:
        return 'Float Addition';
      case RegisterTransactionType.floatRemoval:
        return 'Float Removal';
      case RegisterTransactionType.tips:
        return 'Tips';
    }
  }
}

@freezed
class RegisterReport with _$RegisterReport {
  const factory RegisterReport({
    required String registerId,
    required DateTime startTime,
    required DateTime endTime,
    required double openingBalance,
    required double closingBalance,
    required double expectedBalance,
    required double discrepancy,
    required Map<String, double> salesByPaymentMethod,
    required Map<String, double> refundsByPaymentMethod,
    required double totalSales,
    required double totalRefunds,
    required double totalCashIn,
    required double totalCashOut,
    required double netRevenue,
    required int transactionCount,
    required Map<String, int> denominationCounts,
    String? notes,
    String? preparedBy,
    DateTime? approvedAt,
    String? approvedBy,
  }) = _RegisterReport;
  
  factory RegisterReport.fromJson(Map<String, dynamic> json) => 
      _$RegisterReportFromJson(json);
}