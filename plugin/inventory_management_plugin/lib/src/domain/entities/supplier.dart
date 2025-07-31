import 'package:freezed_annotation/freezed_annotation.dart';

part 'supplier.freezed.dart';
part 'supplier.g.dart';

@freezed
class Supplier with _$Supplier {
  const factory Supplier({
    required String id,
    required String organizationId,
    required String name,
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
    @Default(30) int paymentTerms,
    @Default(0) double creditLimit,
    @Default(0) double currentBalance,
    @Default('active') String status,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
    
    // Additional fields for plugin
    String? contactPerson,
    String? contactPersonPhone,
    String? contactPersonEmail,
    String? bankName,
    String? bankAccountNumber,
    String? bankRoutingNumber,
    @Default([]) List<String> productIds,
    @Default({}) Map<String, dynamic> metadata,
    String? preferredPaymentMethod,
    @Default(0) double totalPurchases,
    DateTime? lastPurchaseDate,
    @Default(0) int totalOrders,
    @Default(0.0) double averageDeliveryTime, // in days
    @Default(0.0) double qualityRating, // 0-5
    @Default(true) bool isPreferred,
  }) = _Supplier;
  
  const Supplier._();
  
  factory Supplier.fromJson(Map<String, dynamic> json) => _$SupplierFromJson(json);
  
  // Helper methods
  bool get isActive => status == 'active';
  bool get hasOutstandingBalance => currentBalance > 0;
  double get availableCredit => creditLimit - currentBalance;
  
  bool canPurchase(double amount) {
    return currentBalance + amount <= creditLimit;
  }
  
  String get displayName {
    return code != null ? '$name ($code)' : name;
  }
  
  String get fullAddress {
    final parts = <String>[];
    if (address != null && address!.isNotEmpty) parts.add(address!);
    if (city != null && city!.isNotEmpty) parts.add(city!);
    if (state != null && state!.isNotEmpty) parts.add(state!);
    if (postalCode != null && postalCode!.isNotEmpty) parts.add(postalCode!);
    if (country != null && country!.isNotEmpty) parts.add(country!);
    return parts.join(', ');
  }
  
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    // Convert DateTime to Firestore Timestamp format
    json['created_at'] = createdAt.millisecondsSinceEpoch;
    json['updated_at'] = updatedAt.millisecondsSinceEpoch;
    if (syncedAt != null) {
      json['synced_at'] = syncedAt!.millisecondsSinceEpoch;
    }
    if (lastPurchaseDate != null) {
      json['last_purchase_date'] = lastPurchaseDate!.millisecondsSinceEpoch;
    }
    return json;
  }
  
  factory Supplier.fromFirestore(Map<String, dynamic> json) {
    // Convert Firestore Timestamp to DateTime
    if (json['created_at'] is int) {
      json['created_at'] = DateTime.fromMillisecondsSinceEpoch(json['created_at']).toIso8601String();
    }
    if (json['updated_at'] is int) {
      json['updated_at'] = DateTime.fromMillisecondsSinceEpoch(json['updated_at']).toIso8601String();
    }
    if (json['synced_at'] is int) {
      json['synced_at'] = DateTime.fromMillisecondsSinceEpoch(json['synced_at']).toIso8601String();
    }
    if (json['last_purchase_date'] is int) {
      json['last_purchase_date'] = DateTime.fromMillisecondsSinceEpoch(json['last_purchase_date']).toIso8601String();
    }
    return Supplier.fromJson(json);
  }
}

enum SupplierStatus {
  active,
  inactive,
  blocked,
  pending;
  
  String get displayName {
    switch (this) {
      case SupplierStatus.active:
        return 'Active';
      case SupplierStatus.inactive:
        return 'Inactive';
      case SupplierStatus.blocked:
        return 'Blocked';
      case SupplierStatus.pending:
        return 'Pending Approval';
    }
  }
}