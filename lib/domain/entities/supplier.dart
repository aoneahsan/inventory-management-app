import 'package:equatable/equatable.dart';

class Supplier extends Equatable {
  final String id;
  final String organizationId;
  final String name;
  final String? code;
  final String? email;
  final String? phone;
  final String? mobile;
  final String? website;
  final String? taxNumber;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;
  final int paymentTerms;
  final double creditLimit;
  final double currentBalance;
  final String status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Supplier({
    required this.id,
    required this.organizationId,
    required this.name,
    this.code,
    this.email,
    this.phone,
    this.mobile,
    this.website,
    this.taxNumber,
    this.address,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.paymentTerms = 30,
    this.creditLimit = 0,
    this.currentBalance = 0,
    this.status = 'active',
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        organizationId,
        name,
        code,
        email,
        phone,
        mobile,
        website,
        taxNumber,
        address,
        city,
        state,
        country,
        postalCode,
        paymentTerms,
        creditLimit,
        currentBalance,
        status,
        notes,
        createdAt,
        updatedAt,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'organization_id': organizationId,
      'name': name,
      'code': code,
      'email': email,
      'phone': phone,
      'mobile': mobile,
      'website': website,
      'tax_number': taxNumber,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'postal_code': postalCode,
      'payment_terms': paymentTerms,
      'credit_limit': creditLimit,
      'current_balance': currentBalance,
      'status': status,
      'notes': notes,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(
      id: map['id'] as String,
      organizationId: map['organization_id'] as String,
      name: map['name'] as String,
      code: map['code'] as String?,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      mobile: map['mobile'] as String?,
      website: map['website'] as String?,
      taxNumber: map['tax_number'] as String?,
      address: map['address'] as String?,
      city: map['city'] as String?,
      state: map['state'] as String?,
      country: map['country'] as String?,
      postalCode: map['postal_code'] as String?,
      paymentTerms: (map['payment_terms'] ?? 30) as int,
      creditLimit: (map['credit_limit'] ?? 0).toDouble(),
      currentBalance: (map['current_balance'] ?? 0).toDouble(),
      status: map['status'] ?? 'active',
      notes: map['notes'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
    );
  }

  Supplier copyWith({
    String? id,
    String? organizationId,
    String? name,
    String? code,
    String? email,
    String? phone,
    String? mobile,
    String? website,
    String? taxNumber,
    String? address,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    int? paymentTerms,
    double? creditLimit,
    double? currentBalance,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Supplier(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      name: name ?? this.name,
      code: code ?? this.code,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      mobile: mobile ?? this.mobile,
      website: website ?? this.website,
      taxNumber: taxNumber ?? this.taxNumber,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      creditLimit: creditLimit ?? this.creditLimit,
      currentBalance: currentBalance ?? this.currentBalance,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Helper methods
  bool get isActive => status == 'active';
  
  bool canPurchase(double amount) {
    return currentBalance + amount <= creditLimit;
  }

  String get displayName {
    return code != null ? '$name ($code)' : name;
  }

  String get fullAddress {
    final parts = <String>[];
    if (address != null) parts.add(address!);
    if (city != null) parts.add(city!);
    if (state != null) parts.add(state!);
    if (country != null) parts.add(country!);
    if (postalCode != null) parts.add(postalCode!);
    return parts.join(', ');
  }
}