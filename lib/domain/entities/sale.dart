class Sale {
  final String id;
  final String organizationId;
  final String registerId;
  final String userId;
  final String? customerId;
  final String receiptNumber;
  final double subtotal;
  final double taxAmount;
  final double discountAmount;
  final double totalAmount;
  final String paymentMethod;
  final Map<String, double>? splitPayments;
  final String status;
  final String? refundReason;
  final bool isOfflineSale;
  final String? notes;
  final DateTime createdAt;
  final DateTime? syncedAt;
  final List<SaleItem> items;

  const Sale({
    required this.id,
    required this.organizationId,
    required this.registerId,
    required this.userId,
    this.customerId,
    required this.receiptNumber,
    required this.subtotal,
    required this.taxAmount,
    required this.discountAmount,
    required this.totalAmount,
    required this.paymentMethod,
    this.splitPayments,
    required this.status,
    this.refundReason,
    this.isOfflineSale = false,
    this.notes,
    required this.createdAt,
    this.syncedAt,
    required this.items,
  });

  Sale copyWith({
    String? id,
    String? organizationId,
    String? registerId,
    String? userId,
    String? customerId,
    String? receiptNumber,
    double? subtotal,
    double? taxAmount,
    double? discountAmount,
    double? totalAmount,
    String? paymentMethod,
    Map<String, double>? splitPayments,
    String? status,
    String? refundReason,
    bool? isOfflineSale,
    String? notes,
    DateTime? createdAt,
    DateTime? syncedAt,
    List<SaleItem>? items,
  }) {
    return Sale(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      registerId: registerId ?? this.registerId,
      userId: userId ?? this.userId,
      customerId: customerId ?? this.customerId,
      receiptNumber: receiptNumber ?? this.receiptNumber,
      subtotal: subtotal ?? this.subtotal,
      taxAmount: taxAmount ?? this.taxAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      splitPayments: splitPayments ?? this.splitPayments,
      status: status ?? this.status,
      refundReason: refundReason ?? this.refundReason,
      isOfflineSale: isOfflineSale ?? this.isOfflineSale,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      syncedAt: syncedAt ?? this.syncedAt,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organizationId': organizationId,
      'registerId': registerId,
      'userId': userId,
      'customerId': customerId,
      'receiptNumber': receiptNumber,
      'subtotal': subtotal,
      'taxAmount': taxAmount,
      'discountAmount': discountAmount,
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'splitPayments': splitPayments,
      'status': status,
      'refundReason': refundReason,
      'isOfflineSale': isOfflineSale,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'syncedAt': syncedAt?.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      id: json['id'],
      organizationId: json['organizationId'],
      registerId: json['registerId'],
      userId: json['userId'],
      customerId: json['customerId'],
      receiptNumber: json['receiptNumber'],
      subtotal: (json['subtotal'] as num).toDouble(),
      taxAmount: (json['taxAmount'] as num).toDouble(),
      discountAmount: (json['discountAmount'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      paymentMethod: json['paymentMethod'],
      splitPayments: json['splitPayments'] != null
          ? Map<String, double>.from(json['splitPayments'])
          : null,
      status: json['status'],
      refundReason: json['refundReason'],
      isOfflineSale: json['isOfflineSale'] ?? false,
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
      syncedAt: json['syncedAt'] != null ? DateTime.parse(json['syncedAt']) : null,
      items: (json['items'] as List<dynamic>)
          .map((item) => SaleItem.fromJson(item))
          .toList(),
    );
  }
}

class SaleItem {
  final String id;
  final String saleId;
  final String productId;
  final String productName;
  final String? variantId;
  final double quantity;
  final double unitPrice;
  final double discountAmount;
  final double discountPercent;
  final double taxAmount;
  final double taxPercent;
  final double totalAmount;
  final String? notes;
  final DateTime createdAt;

  const SaleItem({
    required this.id,
    required this.saleId,
    required this.productId,
    required this.productName,
    this.variantId,
    required this.quantity,
    required this.unitPrice,
    required this.discountAmount,
    required this.discountPercent,
    required this.taxAmount,
    required this.taxPercent,
    required this.totalAmount,
    this.notes,
    required this.createdAt,
  });

  SaleItem copyWith({
    String? id,
    String? saleId,
    String? productId,
    String? productName,
    String? variantId,
    double? quantity,
    double? unitPrice,
    double? discountAmount,
    double? discountPercent,
    double? taxAmount,
    double? taxPercent,
    double? totalAmount,
    String? notes,
    DateTime? createdAt,
  }) {
    return SaleItem(
      id: id ?? this.id,
      saleId: saleId ?? this.saleId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      variantId: variantId ?? this.variantId,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      discountAmount: discountAmount ?? this.discountAmount,
      discountPercent: discountPercent ?? this.discountPercent,
      taxAmount: taxAmount ?? this.taxAmount,
      taxPercent: taxPercent ?? this.taxPercent,
      totalAmount: totalAmount ?? this.totalAmount,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'saleId': saleId,
      'productId': productId,
      'productName': productName,
      'variantId': variantId,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'discountAmount': discountAmount,
      'discountPercent': discountPercent,
      'taxAmount': taxAmount,
      'taxPercent': taxPercent,
      'totalAmount': totalAmount,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory SaleItem.fromJson(Map<String, dynamic> json) {
    return SaleItem(
      id: json['id'],
      saleId: json['saleId'],
      productId: json['productId'],
      productName: json['productName'],
      variantId: json['variantId'],
      quantity: (json['quantity'] as num).toDouble(),
      unitPrice: (json['unitPrice'] as num).toDouble(),
      discountAmount: (json['discountAmount'] as num).toDouble(),
      discountPercent: (json['discountPercent'] as num).toDouble(),
      taxAmount: (json['taxAmount'] as num).toDouble(),
      taxPercent: (json['taxPercent'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}