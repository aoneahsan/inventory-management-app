import 'package:equatable/equatable.dart';

class RepackagingRule extends Equatable {
  final String id;
  final String organizationId;
  final String fromProductId;
  final String toProductId;
  final double conversionRate;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RepackagingRule({
    required this.id,
    required this.organizationId,
    required this.fromProductId,
    required this.toProductId,
    required this.conversionRate,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  RepackagingRule copyWith({
    String? id,
    String? organizationId,
    String? fromProductId,
    String? toProductId,
    double? conversionRate,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RepackagingRule(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      fromProductId: fromProductId ?? this.fromProductId,
      toProductId: toProductId ?? this.toProductId,
      conversionRate: conversionRate ?? this.conversionRate,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'organization_id': organizationId,
      'from_product_id': fromProductId,
      'to_product_id': toProductId,
      'conversion_rate': conversionRate,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory RepackagingRule.fromMap(Map<String, dynamic> map) {
    return RepackagingRule(
      id: map['id'],
      organizationId: map['organization_id'],
      fromProductId: map['from_product_id'],
      toProductId: map['to_product_id'],
      conversionRate: map['conversion_rate']?.toDouble() ?? 1.0,
      isActive: map['is_active'] == 1,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  double calculateOutputQuantity(double inputQuantity) {
    return inputQuantity * conversionRate;
  }

  double calculateInputQuantity(double outputQuantity) {
    return outputQuantity / conversionRate;
  }

  @override
  List<Object> get props => [
        id,
        organizationId,
        fromProductId,
        toProductId,
        conversionRate,
        isActive,
        createdAt,
        updatedAt,
      ];
}