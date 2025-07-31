import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale.freezed.dart';
part 'sale.g.dart';

@freezed
class Sale with _$Sale {
  const factory Sale({
    required String id,
    required String organizationId,
    String? branchId,
    String? registerId,
    required String saleNumber,
    String? customerId,
    required DateTime saleDate,
    required double subtotal,
    @Default(0) double taxAmount,
    @Default(0) double discountAmount,
    required double totalAmount,
    @Default(0) double paidAmount,
    @Default(0) double changeAmount,
    @Default('pending') String paymentStatus,
    Map<String, double>? paymentMethods, // {"cash": 50, "card": 30}
    String? notes,
    required String cashierId,
    @Default(false) bool voided,
    String? voidedBy,
    DateTime? voidedAt,
    String? voidReason,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
    
    // Additional fields for plugin
    @Default([]) List<SaleItem> items,
    @Default('completed') String status,
    String? invoiceNumber,
    String? referenceNumber,
    @Default(false) bool isReturn,
    String? originalSaleId,
    @Default(false) bool isOffline,
    String? shippingAddress,
    @Default(0) double shippingCost,
    String? couponCode,
    @Default(0) double couponDiscount,
    @Default(0) int loyaltyPointsEarned,
    @Default(0) int loyaltyPointsRedeemed,
    @Default({}) Map<String, dynamic> metadata,
    String? salesPersonId,
    @Default(0) double tipAmount,
    @Default(0) double serviceCharge,
  }) = _Sale;
  
  const Sale._();
  
  factory Sale.fromJson(Map<String, dynamic> json) => _$SaleFromJson(json);
  
  // Helper methods
  double get balance => totalAmount - paidAmount;
  bool get isPaid => paymentStatus == 'paid' || balance <= 0;
  bool get isPartiallyPaid => paidAmount > 0 && paidAmount < totalAmount;
  bool get isPending => paymentStatus == 'pending';
  
  double get totalDiscount => discountAmount + couponDiscount;
  double get netAmount => subtotal - totalDiscount;
  double get finalAmount => netAmount + taxAmount + shippingCost + tipAmount + serviceCharge;
  
  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity.toInt());
  
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    // Convert DateTime to Firestore Timestamp format
    json['sale_date'] = saleDate.millisecondsSinceEpoch;
    json['created_at'] = createdAt.millisecondsSinceEpoch;
    json['updated_at'] = updatedAt.millisecondsSinceEpoch;
    if (syncedAt != null) {
      json['synced_at'] = syncedAt!.millisecondsSinceEpoch;
    }
    if (voidedAt != null) {
      json['voided_at'] = voidedAt!.millisecondsSinceEpoch;
    }
    // Convert items to JSON
    json['items'] = items.map((item) => item.toJson()).toList();
    return json;
  }
  
  factory Sale.fromFirestore(Map<String, dynamic> json) {
    // Convert Firestore Timestamp to DateTime
    if (json['sale_date'] is int) {
      json['sale_date'] = DateTime.fromMillisecondsSinceEpoch(json['sale_date']).toIso8601String();
    }
    if (json['created_at'] is int) {
      json['created_at'] = DateTime.fromMillisecondsSinceEpoch(json['created_at']).toIso8601String();
    }
    if (json['updated_at'] is int) {
      json['updated_at'] = DateTime.fromMillisecondsSinceEpoch(json['updated_at']).toIso8601String();
    }
    if (json['synced_at'] is int) {
      json['synced_at'] = DateTime.fromMillisecondsSinceEpoch(json['synced_at']).toIso8601String();
    }
    if (json['voided_at'] is int) {
      json['voided_at'] = DateTime.fromMillisecondsSinceEpoch(json['voided_at']).toIso8601String();
    }
    return Sale.fromJson(json);
  }
}

@freezed
class SaleItem with _$SaleItem {
  const factory SaleItem({
    required String id,
    required String saleId,
    required String productId,
    required double quantity,
    required double unitPrice,
    double? costPrice,
    @Default(0) double discountRate,
    @Default(0) double discountAmount,
    @Default(0) double taxRate,
    @Default(0) double taxAmount,
    required double totalAmount,
    String? notes,
    required DateTime createdAt,
    DateTime? syncedAt,
    
    // Additional fields for plugin
    required String productName,
    String? productSku,
    String? productBarcode,
    String? variantId,
    String? variantName,
    String? unitOfMeasure,
    String? serialNumber,
    String? batchNumber,
    @Default({}) Map<String, dynamic> metadata,
    @Default(false) bool isReturn,
    double? returnQuantity,
    String? returnReason,
  }) = _SaleItem;
  
  const SaleItem._();
  
  factory SaleItem.fromJson(Map<String, dynamic> json) => _$SaleItemFromJson(json);
  
  // Helper methods
  double get subtotal => quantity * unitPrice;
  double get netAmount => subtotal - discountAmount;
  double get profit => costPrice != null ? (unitPrice - costPrice!) * quantity : 0;
  double get profitMargin {
    if (costPrice == null || costPrice == 0) return 0;
    return (profit / (costPrice! * quantity)) * 100;
  }
}

enum SaleStatus {
  draft,
  pending,
  completed,
  voided,
  refunded,
  partial_refund;
  
  String get displayName {
    switch (this) {
      case SaleStatus.draft:
        return 'Draft';
      case SaleStatus.pending:
        return 'Pending';
      case SaleStatus.completed:
        return 'Completed';
      case SaleStatus.voided:
        return 'Voided';
      case SaleStatus.refunded:
        return 'Refunded';
      case SaleStatus.partial_refund:
        return 'Partially Refunded';
    }
  }
}

enum PaymentStatus {
  pending,
  partial,
  paid,
  overdue,
  refunded;
  
  String get displayName {
    switch (this) {
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.partial:
        return 'Partially Paid';
      case PaymentStatus.paid:
        return 'Paid';
      case PaymentStatus.overdue:
        return 'Overdue';
      case PaymentStatus.refunded:
        return 'Refunded';
    }
  }
}