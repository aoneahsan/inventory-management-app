class Register {
  final String id;
  final String organizationId;
  final String name;
  final String? location;
  final double openingBalance;
  final double currentBalance;
  final double expectedBalance;
  final String status;
  final String openedBy;
  final DateTime openedAt;
  final String? closedBy;
  final DateTime? closedAt;
  final Map<String, int>? denominations;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Register({
    required this.id,
    required this.organizationId,
    required this.name,
    this.location,
    required this.openingBalance,
    required this.currentBalance,
    required this.expectedBalance,
    required this.status,
    required this.openedBy,
    required this.openedAt,
    this.closedBy,
    this.closedAt,
    this.denominations,
    required this.createdAt,
    required this.updatedAt,
  });

  Register copyWith({
    String? id,
    String? organizationId,
    String? name,
    String? location,
    double? openingBalance,
    double? currentBalance,
    double? expectedBalance,
    String? status,
    String? openedBy,
    DateTime? openedAt,
    String? closedBy,
    DateTime? closedAt,
    Map<String, int>? denominations,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Register(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      name: name ?? this.name,
      location: location ?? this.location,
      openingBalance: openingBalance ?? this.openingBalance,
      currentBalance: currentBalance ?? this.currentBalance,
      expectedBalance: expectedBalance ?? this.expectedBalance,
      status: status ?? this.status,
      openedBy: openedBy ?? this.openedBy,
      openedAt: openedAt ?? this.openedAt,
      closedBy: closedBy ?? this.closedBy,
      closedAt: closedAt ?? this.closedAt,
      denominations: denominations ?? this.denominations,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organizationId': organizationId,
      'name': name,
      'location': location,
      'openingBalance': openingBalance,
      'currentBalance': currentBalance,
      'expectedBalance': expectedBalance,
      'status': status,
      'openedBy': openedBy,
      'openedAt': openedAt.toIso8601String(),
      'closedBy': closedBy,
      'closedAt': closedAt?.toIso8601String(),
      'denominations': denominations,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      id: json['id'],
      organizationId: json['organizationId'],
      name: json['name'],
      location: json['location'],
      openingBalance: (json['openingBalance'] as num).toDouble(),
      currentBalance: (json['currentBalance'] as num).toDouble(),
      expectedBalance: (json['expectedBalance'] as num).toDouble(),
      status: json['status'],
      openedBy: json['openedBy'],
      openedAt: DateTime.parse(json['openedAt']),
      closedBy: json['closedBy'],
      closedAt: json['closedAt'] != null ? DateTime.parse(json['closedAt']) : null,
      denominations: json['denominations'] != null
          ? Map<String, int>.from(json['denominations'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  double calculateCashDifference() {
    return currentBalance - expectedBalance;
  }

  bool get isOpen => status == RegisterStatus.open;
  bool get isClosed => status == RegisterStatus.closed;
  bool get isSuspended => status == RegisterStatus.suspended;
}

class RegisterTransaction {
  final String id;
  final String registerId;
  final String type;
  final double amount;
  final String? reason;
  final String performedBy;
  final DateTime createdAt;

  const RegisterTransaction({
    required this.id,
    required this.registerId,
    required this.type,
    required this.amount,
    this.reason,
    required this.performedBy,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'registerId': registerId,
      'type': type,
      'amount': amount,
      'reason': reason,
      'performedBy': performedBy,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory RegisterTransaction.fromJson(Map<String, dynamic> json) {
    return RegisterTransaction(
      id: json['id'],
      registerId: json['registerId'],
      type: json['type'],
      amount: (json['amount'] as num).toDouble(),
      reason: json['reason'],
      performedBy: json['performedBy'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class RegisterStatus {
  static const String open = 'open';
  static const String closed = 'closed';
  static const String suspended = 'suspended';
}

class RegisterTransactionType {
  static const String sale = 'sale';
  static const String refund = 'refund';
  static const String cashIn = 'cash_in';
  static const String cashOut = 'cash_out';
  static const String adjustment = 'adjustment';
}