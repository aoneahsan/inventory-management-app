import 'package:equatable/equatable.dart';

class Branch extends Equatable {
  final String id;
  final String organizationId;
  final String name;
  final String code;
  final BranchType type;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;
  final String? phone;
  final String? email;
  final String? managerId;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Branch({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.code,
    required this.type,
    this.address,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.phone,
    this.email,
    this.managerId,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  Branch copyWith({
    String? id,
    String? organizationId,
    String? name,
    String? code,
    BranchType? type,
    String? address,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    String? phone,
    String? email,
    String? managerId,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Branch(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      name: name ?? this.name,
      code: code ?? this.code,
      type: type ?? this.type,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      managerId: managerId ?? this.managerId,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'organization_id': organizationId,
      'name': name,
      'code': code,
      'type': type.value,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'postal_code': postalCode,
      'phone': phone,
      'email': email,
      'manager_id': managerId,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Branch.fromMap(Map<String, dynamic> map) {
    return Branch(
      id: map['id'],
      organizationId: map['organization_id'],
      name: map['name'],
      code: map['code'],
      type: BranchType.fromString(map['type']),
      address: map['address'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      postalCode: map['postal_code'],
      phone: map['phone'],
      email: map['email'],
      managerId: map['manager_id'],
      isActive: map['is_active'] == 1,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        organizationId,
        name,
        code,
        type,
        address,
        city,
        state,
        country,
        postalCode,
        phone,
        email,
        managerId,
        isActive,
        createdAt,
        updatedAt,
      ];
}

enum BranchType {
  store('store'),
  warehouse('warehouse'),
  both('both');

  final String value;
  const BranchType(this.value);

  static BranchType fromString(String value) {
    return BranchType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => BranchType.store,
    );
  }
}