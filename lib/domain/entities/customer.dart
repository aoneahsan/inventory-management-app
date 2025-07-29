class Customer {
  final String id;
  final String organizationId;
  final String name;
  final String? code;
  final String? email;
  final String? phone;
  final String? mobile;
  final String? taxNumber;
  final String customerType;
  final String? priceListId;
  final double creditLimit;
  final double currentBalance;
  final int loyaltyPoints;
  final String? address;
  final String? shippingAddress;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Customer({
    required this.id,
    required this.organizationId,
    required this.name,
    this.code,
    this.email,
    this.phone,
    this.mobile,
    this.taxNumber,
    this.customerType = 'retail',
    this.priceListId,
    this.creditLimit = 0,
    this.currentBalance = 0,
    this.loyaltyPoints = 0,
    this.address,
    this.shippingAddress,
    this.status = 'active',
    required this.createdAt,
    required this.updatedAt,
  });

  Customer copyWith({
    String? id,
    String? organizationId,
    String? name,
    String? code,
    String? email,
    String? phone,
    String? mobile,
    String? taxNumber,
    String? customerType,
    String? priceListId,
    double? creditLimit,
    double? currentBalance,
    int? loyaltyPoints,
    String? address,
    String? shippingAddress,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Customer(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      name: name ?? this.name,
      code: code ?? this.code,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      mobile: mobile ?? this.mobile,
      taxNumber: taxNumber ?? this.taxNumber,
      customerType: customerType ?? this.customerType,
      priceListId: priceListId ?? this.priceListId,
      creditLimit: creditLimit ?? this.creditLimit,
      currentBalance: currentBalance ?? this.currentBalance,
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
      address: address ?? this.address,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organizationId': organizationId,
      'name': name,
      'code': code,
      'email': email,
      'phone': phone,
      'mobile': mobile,
      'taxNumber': taxNumber,
      'customerType': customerType,
      'priceListId': priceListId,
      'creditLimit': creditLimit,
      'currentBalance': currentBalance,
      'loyaltyPoints': loyaltyPoints,
      'address': address,
      'shippingAddress': shippingAddress,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      organizationId: json['organizationId'],
      name: json['name'],
      code: json['code'],
      email: json['email'],
      phone: json['phone'],
      mobile: json['mobile'],
      taxNumber: json['taxNumber'],
      customerType: json['customerType'] ?? 'retail',
      priceListId: json['priceListId'],
      creditLimit: json['creditLimit'] != null ? (json['creditLimit'] as num).toDouble() : 0,
      currentBalance: json['currentBalance'] != null ? (json['currentBalance'] as num).toDouble() : 0,
      loyaltyPoints: json['loyaltyPoints'] ?? 0,
      address: json['address'],
      shippingAddress: json['shippingAddress'],
      status: json['status'] ?? 'active',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  double get availableCredit => creditLimit - currentBalance;
  bool get hasCredit => creditLimit > 0;
  bool get isOverLimit => currentBalance > creditLimit;
  bool get isActive => status == 'active';
}

class CustomerCredit {
  final String id;
  final String organizationId;
  final String customerId;
  final double creditLimit;
  final double currentBalance;
  final DateTime? lastPaymentDate;
  final double? lastPaymentAmount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CustomerCredit({
    required this.id,
    required this.organizationId,
    required this.customerId,
    this.creditLimit = 0,
    this.currentBalance = 0,
    this.lastPaymentDate,
    this.lastPaymentAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  double get availableCredit => creditLimit - currentBalance;
  bool get hasCredit => creditLimit > 0;
  bool get isOverLimit => currentBalance > creditLimit;

  CustomerCredit copyWith({
    String? id,
    String? organizationId,
    String? customerId,
    double? creditLimit,
    double? currentBalance,
    DateTime? lastPaymentDate,
    double? lastPaymentAmount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CustomerCredit(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      customerId: customerId ?? this.customerId,
      creditLimit: creditLimit ?? this.creditLimit,
      currentBalance: currentBalance ?? this.currentBalance,
      lastPaymentDate: lastPaymentDate ?? this.lastPaymentDate,
      lastPaymentAmount: lastPaymentAmount ?? this.lastPaymentAmount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organizationId': organizationId,
      'customerId': customerId,
      'creditLimit': creditLimit,
      'currentBalance': currentBalance,
      'lastPaymentDate': lastPaymentDate?.toIso8601String(),
      'lastPaymentAmount': lastPaymentAmount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory CustomerCredit.fromJson(Map<String, dynamic> json) {
    return CustomerCredit(
      id: json['id'],
      organizationId: json['organizationId'],
      customerId: json['customerId'],
      creditLimit: (json['creditLimit'] as num).toDouble(),
      currentBalance: (json['currentBalance'] as num).toDouble(),
      lastPaymentDate: json['lastPaymentDate'] != null
          ? DateTime.parse(json['lastPaymentDate'])
          : null,
      lastPaymentAmount: json['lastPaymentAmount'] != null
          ? (json['lastPaymentAmount'] as num).toDouble()
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class LoyaltyPoints {
  final String id;
  final String organizationId;
  final String customerId;
  final int pointsBalance;
  final int lifetimePoints;
  final DateTime? lastEarnedDate;
  final DateTime? lastRedeemedDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const LoyaltyPoints({
    required this.id,
    required this.organizationId,
    required this.customerId,
    this.pointsBalance = 0,
    this.lifetimePoints = 0,
    this.lastEarnedDate,
    this.lastRedeemedDate,
    required this.createdAt,
    required this.updatedAt,
  });

  LoyaltyPoints copyWith({
    String? id,
    String? organizationId,
    String? customerId,
    int? pointsBalance,
    int? lifetimePoints,
    DateTime? lastEarnedDate,
    DateTime? lastRedeemedDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LoyaltyPoints(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      customerId: customerId ?? this.customerId,
      pointsBalance: pointsBalance ?? this.pointsBalance,
      lifetimePoints: lifetimePoints ?? this.lifetimePoints,
      lastEarnedDate: lastEarnedDate ?? this.lastEarnedDate,
      lastRedeemedDate: lastRedeemedDate ?? this.lastRedeemedDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organizationId': organizationId,
      'customerId': customerId,
      'pointsBalance': pointsBalance,
      'lifetimePoints': lifetimePoints,
      'lastEarnedDate': lastEarnedDate?.toIso8601String(),
      'lastRedeemedDate': lastRedeemedDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory LoyaltyPoints.fromJson(Map<String, dynamic> json) {
    return LoyaltyPoints(
      id: json['id'],
      organizationId: json['organizationId'],
      customerId: json['customerId'],
      pointsBalance: json['pointsBalance'] ?? 0,
      lifetimePoints: json['lifetimePoints'] ?? 0,
      lastEarnedDate: json['lastEarnedDate'] != null
          ? DateTime.parse(json['lastEarnedDate'])
          : null,
      lastRedeemedDate: json['lastRedeemedDate'] != null
          ? DateTime.parse(json['lastRedeemedDate'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}