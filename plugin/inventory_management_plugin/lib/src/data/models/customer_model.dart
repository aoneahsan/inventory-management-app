import 'dart:convert';

import '../../domain/entities/customer.dart';
import '../database/database_schema.dart';
import 'base_model.dart';

/// Database model for Customer entity
class CustomerModel extends BaseModel {
  final Customer customer;
  
  CustomerModel(this.customer);
  
  @override
  String get tableName => DatabaseSchema.customersTable;
  
  @override
  Map<String, dynamic> toDatabase() {
    return {
      DatabaseSchema.id: customer.id,
      DatabaseSchema.organizationId: customer.organizationId,
      'name': customer.name,
      'code': customer.code,
      'email': customer.email,
      'phone': customer.phone,
      'address': customer.address,
      'city': customer.city,
      'state': customer.state,
      'country': customer.country,
      'postal_code': customer.postalCode,
      'tax_number': customer.taxNumber,
      'customer_type': customer.customerType?.name,
      'credit_limit': customer.creditLimit,
      'current_balance': customer.currentBalance,
      'loyalty_points': customer.loyaltyPoints,
      'discount_percentage': customer.discountPercentage,
      'payment_terms': customer.paymentTerms,
      DatabaseSchema.isActive: boolToInt(customer.isActive),
      DatabaseSchema.metadata: encodeMetadata(customer.metadata),
      DatabaseSchema.createdAt: dateTimeToMillis(customer.createdAt),
      DatabaseSchema.updatedAt: dateTimeToMillis(customer.updatedAt),
      DatabaseSchema.syncedAt: dateTimeToMillis(customer.syncedAt),
    };
  }
  
  /// Create Customer from database map
  factory CustomerModel.fromDatabase(Map<String, dynamic> map) {
    final customer = _fromMap(map);
    return CustomerModel(customer);
  }
  
  static Customer _fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map[DatabaseSchema.id] as String,
      organizationId: map[DatabaseSchema.organizationId] as String,
      name: map['name'] as String,
      code: map['code'] as String?,
      email: map['email'] as String?,
      phone: map['phone'] as String,
      address: map['address'] as String?,
      city: map['city'] as String?,
      state: map['state'] as String?,
      country: map['country'] as String?,
      postalCode: map['postal_code'] as String?,
      taxNumber: map['tax_number'] as String?,
      customerType: _parseCustomerType(map['customer_type'] as String?),
      creditLimit: (map['credit_limit'] as num?)?.toDouble() ?? 0,
      currentBalance: (map['current_balance'] as num?)?.toDouble() ?? 0,
      loyaltyPoints: map['loyalty_points'] as int? ?? 0,
      discountPercentage: (map['discount_percentage'] as num?)?.toDouble() ?? 0,
      paymentTerms: map['payment_terms'] as String?,
      isActive: map[DatabaseSchema.isActive] == 1,
      metadata: _decodeMetadata(map[DatabaseSchema.metadata] as String?),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.createdAt] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.updatedAt] as int),
      syncedAt: map[DatabaseSchema.syncedAt] != null
          ? DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.syncedAt] as int)
          : null,
    );
  }
  
  static CustomerType? _parseCustomerType(String? type) {
    if (type == null) return null;
    try {
      return CustomerType.values.firstWhere((e) => e.name == type);
    } catch (_) {
      return CustomerType.retail;
    }
  }
  
  static Map<String, dynamic> _decodeMetadata(String? metadata) {
    if (metadata == null || metadata.isEmpty) return {};
    try {
      return Map<String, dynamic>.from(json.decode(metadata));
    } catch (_) {
      return {};
    }
  }
}