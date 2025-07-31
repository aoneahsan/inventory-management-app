import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class Customer with _$Customer {
  const factory Customer({
    required String id,
    required String organizationId,
    required String name,
    String? code,
    String? email,
    String? phone,
    String? mobile,
    String? taxNumber,
    @Default('retail') String customerType,
    String? priceListId,
    @Default(0) double creditLimit,
    @Default(0) double currentBalance,
    @Default(0) int loyaltyPoints,
    String? address,
    String? shippingAddress,
    @Default('active') String status,
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
    
    // Additional fields for plugin
    String? city,
    String? state,
    String? country,
    String? postalCode,
    DateTime? dateOfBirth,
    String? gender,
    @Default({}) Map<String, dynamic> metadata,
    @Default(0) double totalPurchases,
    @Default(0) int totalOrders,
    DateTime? lastPurchaseDate,
    @Default([]) List<String> favoriteProductIds,
    String? referredBy,
    @Default(0) int referralCount,
    CustomerPreferences? preferences,
    @Default({}) Map<String, String> customFields,
    @Default(false) bool isVip,
    String? membershipTier,
    DateTime? membershipExpiryDate,
  }) = _Customer;
  
  const Customer._();
  
  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);
  
  // Helper methods
  double get availableCredit => creditLimit - currentBalance;
  bool get hasCredit => creditLimit > 0;
  bool get isOverLimit => currentBalance > creditLimit;
  bool get isActive => status == 'active';
  
  bool canPurchase(double amount) {
    if (!hasCredit) return true; // No credit limit means can purchase
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
  
  String get fullShippingAddress {
    if (shippingAddress == null || shippingAddress!.isEmpty) {
      return fullAddress;
    }
    return shippingAddress!;
  }
  
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    // Convert DateTime to Firestore Timestamp format
    json['created_at'] = createdAt.millisecondsSinceEpoch;
    json['updated_at'] = updatedAt.millisecondsSinceEpoch;
    if (syncedAt != null) {
      json['synced_at'] = syncedAt!.millisecondsSinceEpoch;
    }
    if (dateOfBirth != null) {
      json['date_of_birth'] = dateOfBirth!.millisecondsSinceEpoch;
    }
    if (lastPurchaseDate != null) {
      json['last_purchase_date'] = lastPurchaseDate!.millisecondsSinceEpoch;
    }
    if (membershipExpiryDate != null) {
      json['membership_expiry_date'] = membershipExpiryDate!.millisecondsSinceEpoch;
    }
    return json;
  }
  
  factory Customer.fromFirestore(Map<String, dynamic> json) {
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
    if (json['date_of_birth'] is int) {
      json['date_of_birth'] = DateTime.fromMillisecondsSinceEpoch(json['date_of_birth']).toIso8601String();
    }
    if (json['last_purchase_date'] is int) {
      json['last_purchase_date'] = DateTime.fromMillisecondsSinceEpoch(json['last_purchase_date']).toIso8601String();
    }
    if (json['membership_expiry_date'] is int) {
      json['membership_expiry_date'] = DateTime.fromMillisecondsSinceEpoch(json['membership_expiry_date']).toIso8601String();
    }
    return Customer.fromJson(json);
  }
}

@freezed
class CustomerPreferences with _$CustomerPreferences {
  const factory CustomerPreferences({
    @Default(true) bool emailNotifications,
    @Default(true) bool smsNotifications,
    @Default(false) bool whatsappNotifications,
    @Default('email') String preferredContactMethod,
    String? preferredLanguage,
    @Default([]) List<String> productCategories,
    @Default({}) Map<String, dynamic> customPreferences,
  }) = _CustomerPreferences;
  
  factory CustomerPreferences.fromJson(Map<String, dynamic> json) =>
      _$CustomerPreferencesFromJson(json);
}

enum CustomerType {
  retail,
  wholesale,
  distributor,
  corporate,
  vip;
  
  String get displayName {
    switch (this) {
      case CustomerType.retail:
        return 'Retail';
      case CustomerType.wholesale:
        return 'Wholesale';
      case CustomerType.distributor:
        return 'Distributor';
      case CustomerType.corporate:
        return 'Corporate';
      case CustomerType.vip:
        return 'VIP';
    }
  }
}

enum CustomerStatus {
  active,
  inactive,
  blocked,
  pending;
  
  String get displayName {
    switch (this) {
      case CustomerStatus.active:
        return 'Active';
      case CustomerStatus.inactive:
        return 'Inactive';
      case CustomerStatus.blocked:
        return 'Blocked';
      case CustomerStatus.pending:
        return 'Pending Approval';
    }
  }
}