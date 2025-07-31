// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerImpl _$$CustomerImplFromJson(Map<String, dynamic> json) =>
    _$CustomerImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      name: json['name'] as String,
      code: json['code'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      mobile: json['mobile'] as String?,
      taxNumber: json['taxNumber'] as String?,
      customerType: json['customerType'] as String? ?? 'retail',
      priceListId: json['priceListId'] as String?,
      creditLimit: (json['creditLimit'] as num?)?.toDouble() ?? 0,
      currentBalance: (json['currentBalance'] as num?)?.toDouble() ?? 0,
      loyaltyPoints: (json['loyaltyPoints'] as num?)?.toInt() ?? 0,
      address: json['address'] as String?,
      shippingAddress: json['shippingAddress'] as String?,
      status: json['status'] as String? ?? 'active',
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      postalCode: json['postalCode'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      gender: json['gender'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      totalPurchases: (json['totalPurchases'] as num?)?.toDouble() ?? 0,
      totalOrders: (json['totalOrders'] as num?)?.toInt() ?? 0,
      lastPurchaseDate: json['lastPurchaseDate'] == null
          ? null
          : DateTime.parse(json['lastPurchaseDate'] as String),
      favoriteProductIds: (json['favoriteProductIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      referredBy: json['referredBy'] as String?,
      referralCount: (json['referralCount'] as num?)?.toInt() ?? 0,
      preferences: json['preferences'] == null
          ? null
          : CustomerPreferences.fromJson(
              json['preferences'] as Map<String, dynamic>),
      customFields: (json['customFields'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      isVip: json['isVip'] as bool? ?? false,
      membershipTier: json['membershipTier'] as String?,
      membershipExpiryDate: json['membershipExpiryDate'] == null
          ? null
          : DateTime.parse(json['membershipExpiryDate'] as String),
    );

Map<String, dynamic> _$$CustomerImplToJson(_$CustomerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'name': instance.name,
      'code': instance.code,
      'email': instance.email,
      'phone': instance.phone,
      'mobile': instance.mobile,
      'taxNumber': instance.taxNumber,
      'customerType': instance.customerType,
      'priceListId': instance.priceListId,
      'creditLimit': instance.creditLimit,
      'currentBalance': instance.currentBalance,
      'loyaltyPoints': instance.loyaltyPoints,
      'address': instance.address,
      'shippingAddress': instance.shippingAddress,
      'status': instance.status,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'postalCode': instance.postalCode,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'gender': instance.gender,
      'metadata': instance.metadata,
      'totalPurchases': instance.totalPurchases,
      'totalOrders': instance.totalOrders,
      'lastPurchaseDate': instance.lastPurchaseDate?.toIso8601String(),
      'favoriteProductIds': instance.favoriteProductIds,
      'referredBy': instance.referredBy,
      'referralCount': instance.referralCount,
      'preferences': instance.preferences,
      'customFields': instance.customFields,
      'isVip': instance.isVip,
      'membershipTier': instance.membershipTier,
      'membershipExpiryDate': instance.membershipExpiryDate?.toIso8601String(),
    };

_$CustomerPreferencesImpl _$$CustomerPreferencesImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomerPreferencesImpl(
      emailNotifications: json['emailNotifications'] as bool? ?? true,
      smsNotifications: json['smsNotifications'] as bool? ?? true,
      whatsappNotifications: json['whatsappNotifications'] as bool? ?? false,
      preferredContactMethod:
          json['preferredContactMethod'] as String? ?? 'email',
      preferredLanguage: json['preferredLanguage'] as String?,
      productCategories: (json['productCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      customPreferences:
          json['customPreferences'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$CustomerPreferencesImplToJson(
        _$CustomerPreferencesImpl instance) =>
    <String, dynamic>{
      'emailNotifications': instance.emailNotifications,
      'smsNotifications': instance.smsNotifications,
      'whatsappNotifications': instance.whatsappNotifications,
      'preferredContactMethod': instance.preferredContactMethod,
      'preferredLanguage': instance.preferredLanguage,
      'productCategories': instance.productCategories,
      'customPreferences': instance.customPreferences,
    };
