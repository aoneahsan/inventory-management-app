import 'package:equatable/equatable.dart';

class TaxRate extends Equatable {
  final String id;
  final String organizationId;
  final String name;
  final String code;
  final double rate;
  final TaxType type;
  final bool isCompound;
  final bool isInclusive;
  final bool isActive;
  final double? cgstRate;
  final double? sgstRate;
  final double? igstRate;
  final double? cessRate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TaxRate({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.code,
    required this.rate,
    required this.type,
    required this.isCompound,
    required this.isInclusive,
    required this.isActive,
    this.cgstRate,
    this.sgstRate,
    this.igstRate,
    this.cessRate,
    required this.createdAt,
    required this.updatedAt,
  });

  TaxRate copyWith({
    String? id,
    String? organizationId,
    String? name,
    String? code,
    double? rate,
    TaxType? type,
    bool? isCompound,
    bool? isInclusive,
    bool? isActive,
    double? cgstRate,
    double? sgstRate,
    double? igstRate,
    double? cessRate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TaxRate(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      name: name ?? this.name,
      code: code ?? this.code,
      rate: rate ?? this.rate,
      type: type ?? this.type,
      isCompound: isCompound ?? this.isCompound,
      isInclusive: isInclusive ?? this.isInclusive,
      isActive: isActive ?? this.isActive,
      cgstRate: cgstRate ?? this.cgstRate,
      sgstRate: sgstRate ?? this.sgstRate,
      igstRate: igstRate ?? this.igstRate,
      cessRate: cessRate ?? this.cessRate,
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
      'rate': rate,
      'type': type.value,
      'is_compound': isCompound ? 1 : 0,
      'is_inclusive': isInclusive ? 1 : 0,
      'is_active': isActive ? 1 : 0,
      'cgst_rate': cgstRate,
      'sgst_rate': sgstRate,
      'igst_rate': igstRate,
      'cess_rate': cessRate,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory TaxRate.fromMap(Map<String, dynamic> map) {
    return TaxRate(
      id: map['id'],
      organizationId: map['organization_id'],
      name: map['name'],
      code: map['code'],
      rate: map['rate']?.toDouble() ?? 0.0,
      type: TaxType.fromString(map['type']),
      isCompound: map['is_compound'] == 1,
      isInclusive: map['is_inclusive'] == 1,
      isActive: map['is_active'] == 1,
      cgstRate: map['cgst_rate']?.toDouble(),
      sgstRate: map['sgst_rate']?.toDouble(),
      igstRate: map['igst_rate']?.toDouble(),
      cessRate: map['cess_rate']?.toDouble(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  double calculateTax(double amount, {double? previousTax}) {
    double baseAmount = amount;
    if (isCompound && previousTax != null) {
      baseAmount += previousTax;
    }
    return baseAmount * (rate / 100);
  }

  double calculateInclusiveAmount(double totalAmount) {
    if (!isInclusive) return totalAmount;
    return totalAmount / (1 + (rate / 100));
  }

  @override
  List<Object?> get props => [
        id,
        organizationId,
        name,
        code,
        rate,
        type,
        isCompound,
        isInclusive,
        isActive,
        cgstRate,
        sgstRate,
        igstRate,
        cessRate,
        createdAt,
        updatedAt,
      ];
}

enum TaxType {
  gst('GST'),
  vat('VAT'),
  salesTax('Sales Tax'),
  serviceTax('Service Tax'),
  other('Other');

  final String value;
  const TaxType(this.value);

  static TaxType fromString(String value) {
    return TaxType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => TaxType.other,
    );
  }
}

class HsnCode extends Equatable {
  final String id;
  final String organizationId;
  final String code;
  final String? description;
  final String? taxRateId;
  final DateTime createdAt;

  const HsnCode({
    required this.id,
    required this.organizationId,
    required this.code,
    this.description,
    this.taxRateId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'organization_id': organizationId,
      'code': code,
      'description': description,
      'tax_rate_id': taxRateId,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  factory HsnCode.fromMap(Map<String, dynamic> map) {
    return HsnCode(
      id: map['id'],
      organizationId: map['organization_id'],
      code: map['code'],
      description: map['description'],
      taxRateId: map['tax_rate_id'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        organizationId,
        code,
        description,
        taxRateId,
        createdAt,
      ];
}