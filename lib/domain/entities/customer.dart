class Customer {
  final String id;
  final String organizationId;
  final String name;
  final String? email;
  final String? phone;
  final String? address;
  final String? taxId;
  final CustomerCredit? credit;
  final LoyaltyPoints? loyaltyPoints;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Customer({
    required this.id,
    required this.organizationId,
    required this.name,
    this.email,
    this.phone,
    this.address,
    this.taxId,
    this.credit,
    this.loyaltyPoints,
    required this.createdAt,
    required this.updatedAt,
  });

  Customer copyWith({
    String? id,
    String? organizationId,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? taxId,
    CustomerCredit? credit,
    LoyaltyPoints? loyaltyPoints,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Customer(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      taxId: taxId ?? this.taxId,
      credit: credit ?? this.credit,
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organizationId': organizationId,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'taxId': taxId,
      'credit': credit?.toJson(),
      'loyaltyPoints': loyaltyPoints?.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      organizationId: json['organizationId'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      taxId: json['taxId'],
      credit: json['credit'] != null
          ? CustomerCredit.fromJson(json['credit'])
          : null,
      loyaltyPoints: json['loyaltyPoints'] != null
          ? LoyaltyPoints.fromJson(json['loyaltyPoints'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
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