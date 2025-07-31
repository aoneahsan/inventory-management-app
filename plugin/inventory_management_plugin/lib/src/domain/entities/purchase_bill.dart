import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_bill.freezed.dart';
part 'purchase_bill.g.dart';

enum PurchaseBillStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('pending')
  pending,
  @JsonValue('partial')
  partial,
  @JsonValue('paid')
  paid,
  @JsonValue('overdue')
  overdue,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('disputed')
  disputed,
}

enum PaymentTerm {
  @JsonValue('immediate')
  immediate,
  @JsonValue('net_7')
  net7,
  @JsonValue('net_15')
  net15,
  @JsonValue('net_30')
  net30,
  @JsonValue('net_45')
  net45,
  @JsonValue('net_60')
  net60,
  @JsonValue('net_90')
  net90,
  @JsonValue('custom')
  custom,
}

@freezed
class PurchaseBill with _$PurchaseBill {
  const factory PurchaseBill({
    required String id,
    required String organizationId,
    required String supplierId,
    String? purchaseOrderId,
    required String billNumber,
    required DateTime billDate,
    DateTime? dueDate,
    @Default(PurchaseBillStatus.draft) PurchaseBillStatus status,
    required double totalAmount,
    @Default(0) double paidAmount,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
    
    // Additional fields
    String? supplierBillNumber,
    String? referenceNumber,
    @Default([]) List<PurchaseBillItem> items,
    double? subtotal,
    double? taxAmount,
    double? discountAmount,
    String? discountType, // 'percentage' or 'fixed'
    double? discountValue,
    double? shippingAmount,
    double? otherCharges,
    String? currency,
    double? exchangeRate,
    @Default(PaymentTerm.net30) PaymentTerm paymentTerm,
    int? customPaymentDays,
    String? billingAddress,
    String? shippingAddress,
    @Default([]) List<String> attachmentUrls,
    String? approvedBy,
    DateTime? approvedAt,
    String? cancelledBy,
    DateTime? cancelledAt,
    String? cancellationReason,
    @Default({}) Map<String, dynamic> metadata,
    @Default([]) List<PurchaseBillPayment> payments,
    String? lastPaymentId,
    DateTime? lastPaymentDate,
  }) = _PurchaseBill;
  
  const PurchaseBill._();
  
  factory PurchaseBill.fromJson(Map<String, dynamic> json) => 
      _$PurchaseBillFromJson(json);
  
  // Helper methods
  double get remainingAmount => totalAmount - paidAmount;
  double get paidPercentage => totalAmount > 0 ? (paidAmount / totalAmount) * 100 : 0;
  
  bool get isDraft => status == PurchaseBillStatus.draft;
  bool get isPending => status == PurchaseBillStatus.pending;
  bool get isPartiallyPaid => status == PurchaseBillStatus.partial;
  bool get isFullyPaid => status == PurchaseBillStatus.paid;
  bool get isOverdue => status == PurchaseBillStatus.overdue;
  bool get isCancelled => status == PurchaseBillStatus.cancelled;
  bool get isDisputed => status == PurchaseBillStatus.disputed;
  
  bool get canEdit => isDraft && !isCancelled;
  bool get canPay => !isFullyPaid && !isDraft && !isCancelled;
  bool get canCancel => !isFullyPaid && !isCancelled;
  bool get canDelete => isDraft && payments.isEmpty;
  bool get canApprove => isDraft && totalAmount > 0;
  bool get canDispute => !isDraft && !isCancelled && !isFullyPaid;
  
  bool get hasPayments => payments.isNotEmpty;
  bool get hasAttachments => attachmentUrls.isNotEmpty;
  bool get hasDiscount => discountAmount != null && discountAmount! > 0;
  bool get hasTax => taxAmount != null && taxAmount! > 0;
  
  bool checkOverdue() {
    if (dueDate == null || isFullyPaid || isCancelled) return false;
    return DateTime.now().isAfter(dueDate!);
  }
  
  int get daysUntilDue {
    if (dueDate == null) return 0;
    final days = dueDate!.difference(DateTime.now()).inDays;
    return days > 0 ? days : 0;
  }
  
  int get daysOverdue {
    if (dueDate == null || !checkOverdue()) return 0;
    return DateTime.now().difference(dueDate!).inDays;
  }
  
  DateTime? calculateDueDate(DateTime billDate) {
    switch (paymentTerm) {
      case PaymentTerm.immediate:
        return billDate;
      case PaymentTerm.net7:
        return billDate.add(const Duration(days: 7));
      case PaymentTerm.net15:
        return billDate.add(const Duration(days: 15));
      case PaymentTerm.net30:
        return billDate.add(const Duration(days: 30));
      case PaymentTerm.net45:
        return billDate.add(const Duration(days: 45));
      case PaymentTerm.net60:
        return billDate.add(const Duration(days: 60));
      case PaymentTerm.net90:
        return billDate.add(const Duration(days: 90));
      case PaymentTerm.custom:
        if (customPaymentDays != null) {
          return billDate.add(Duration(days: customPaymentDays!));
        }
        return null;
    }
  }
  
  double get calculatedSubtotal {
    if (items.isEmpty) return subtotal ?? totalAmount;
    return items.fold(0.0, (sum, item) => sum + item.totalAmount);
  }
  
  double get calculatedTotalAmount {
    double amount = calculatedSubtotal;
    
    // Apply discount
    if (hasDiscount) {
      if (discountType == 'percentage' && discountValue != null) {
        amount -= amount * (discountValue! / 100);
      } else {
        amount -= discountAmount ?? 0;
      }
    }
    
    // Add tax
    amount += taxAmount ?? 0;
    
    // Add other charges
    amount += shippingAmount ?? 0;
    amount += otherCharges ?? 0;
    
    return amount;
  }
  
  String get statusDisplay {
    switch (status) {
      case PurchaseBillStatus.draft:
        return 'Draft';
      case PurchaseBillStatus.pending:
        return checkOverdue() ? 'Overdue' : 'Pending';
      case PurchaseBillStatus.partial:
        return checkOverdue() ? 'Partially Paid (Overdue)' : 'Partially Paid';
      case PurchaseBillStatus.paid:
        return 'Paid';
      case PurchaseBillStatus.overdue:
        return 'Overdue';
      case PurchaseBillStatus.cancelled:
        return 'Cancelled';
      case PurchaseBillStatus.disputed:
        return 'Disputed';
    }
  }
  
  String get paymentTermDisplay {
    switch (paymentTerm) {
      case PaymentTerm.immediate:
        return 'Due on Receipt';
      case PaymentTerm.net7:
        return 'Net 7 Days';
      case PaymentTerm.net15:
        return 'Net 15 Days';
      case PaymentTerm.net30:
        return 'Net 30 Days';
      case PaymentTerm.net45:
        return 'Net 45 Days';
      case PaymentTerm.net60:
        return 'Net 60 Days';
      case PaymentTerm.net90:
        return 'Net 90 Days';
      case PaymentTerm.custom:
        return customPaymentDays != null ? 'Net $customPaymentDays Days' : 'Custom';
    }
  }
}

@freezed
class PurchaseBillItem with _$PurchaseBillItem {
  const factory PurchaseBillItem({
    required String id,
    required String billId,
    required String productId,
    String? productName,
    String? productSku,
    required double quantity,
    required double unitPrice,
    required double totalAmount,
    String? description,
    double? taxRate,
    double? taxAmount,
    double? discountAmount,
    String? unit,
    @Default({}) Map<String, dynamic> metadata,
  }) = _PurchaseBillItem;
  
  const PurchaseBillItem._();
  
  factory PurchaseBillItem.fromJson(Map<String, dynamic> json) => 
      _$PurchaseBillItemFromJson(json);
  
  double get calculatedTotal => quantity * unitPrice;
  double get totalWithTax => totalAmount + (taxAmount ?? 0);
  double get totalAfterDiscount => totalAmount - (discountAmount ?? 0);
  double get netAmount => totalWithTax - (discountAmount ?? 0);
}

@freezed
class PurchaseBillPayment with _$PurchaseBillPayment {
  const factory PurchaseBillPayment({
    required String id,
    required String billId,
    required double amount,
    required DateTime paymentDate,
    required String paymentMethod,
    String? referenceNumber,
    String? notes,
    required DateTime createdAt,
    String? createdBy,
  }) = _PurchaseBillPayment;
  
  factory PurchaseBillPayment.fromJson(Map<String, dynamic> json) => 
      _$PurchaseBillPaymentFromJson(json);
}