import 'dart:convert';

import '../../domain/entities/supplier.dart';
import '../database/database_schema.dart';
import 'base_model.dart';

/// Database model for Supplier entity
class SupplierModel extends BaseModel {
  final Supplier supplier;
  
  SupplierModel(this.supplier);
  
  @override
  String get tableName => DatabaseSchema.suppliersTable;
  
  @override
  Map<String, dynamic> toDatabase() {
    return {
      DatabaseSchema.id: supplier.id,
      DatabaseSchema.organizationId: supplier.organizationId,
      'name': supplier.name,
      'code': supplier.code,
      'contact_person': supplier.contactPerson,
      'email': supplier.email,
      'phone': supplier.phone,
      'address': supplier.address,
      'city': supplier.city,
      'state': supplier.state,
      'country': supplier.country,
      'postal_code': supplier.postalCode,
      'tax_number': supplier.taxNumber,
      'payment_terms': supplier.paymentTerms,
      'credit_limit': supplier.creditLimit,
      'current_balance': supplier.currentBalance,
      'bank_name': supplier.bankName,
      'bank_account': supplier.bankAccount,
      'bank_routing': supplier.bankRouting,
      DatabaseSchema.isActive: boolToInt(supplier.isActive),
      DatabaseSchema.metadata: encodeMetadata(supplier.metadata),
      DatabaseSchema.createdAt: dateTimeToMillis(supplier.createdAt),
      DatabaseSchema.updatedAt: dateTimeToMillis(supplier.updatedAt),
      DatabaseSchema.syncedAt: dateTimeToMillis(supplier.syncedAt),
    };
  }
  
  /// Create Supplier from database map
  factory SupplierModel.fromDatabase(Map<String, dynamic> map) {
    final supplier = _fromMap(map);
    return SupplierModel(supplier);
  }
  
  static Supplier _fromMap(Map<String, dynamic> map) {
    return Supplier(
      id: map[DatabaseSchema.id] as String,
      organizationId: map[DatabaseSchema.organizationId] as String,
      name: map['name'] as String,
      code: map['code'] as String?,
      contactPerson: map['contact_person'] as String?,
      email: map['email'] as String?,
      phone: map['phone'] as String,
      address: map['address'] as String?,
      city: map['city'] as String?,
      state: map['state'] as String?,
      country: map['country'] as String?,
      postalCode: map['postal_code'] as String?,
      taxNumber: map['tax_number'] as String?,
      paymentTerms: map['payment_terms'] as String?,
      creditLimit: (map['credit_limit'] as num?)?.toDouble() ?? 0,
      currentBalance: (map['current_balance'] as num?)?.toDouble() ?? 0,
      bankName: map['bank_name'] as String?,
      bankAccount: map['bank_account'] as String?,
      bankRouting: map['bank_routing'] as String?,
      isActive: map[DatabaseSchema.isActive] == 1,
      metadata: _decodeMetadata(map[DatabaseSchema.metadata] as String?),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.createdAt] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.updatedAt] as int),
      syncedAt: map[DatabaseSchema.syncedAt] != null
          ? DateTime.fromMillisecondsSinceEpoch(map[DatabaseSchema.syncedAt] as int)
          : null,
    );
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