// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SupplierImpl _$$SupplierImplFromJson(Map<String, dynamic> json) =>
    _$SupplierImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      name: json['name'] as String,
      code: json['code'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      mobile: json['mobile'] as String?,
      website: json['website'] as String?,
      taxNumber: json['taxNumber'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      postalCode: json['postalCode'] as String?,
      paymentTerms: (json['paymentTerms'] as num?)?.toInt() ?? 30,
      creditLimit: (json['creditLimit'] as num?)?.toDouble() ?? 0,
      currentBalance: (json['currentBalance'] as num?)?.toDouble() ?? 0,
      status: json['status'] as String? ?? 'active',
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      contactPerson: json['contactPerson'] as String?,
      contactPersonPhone: json['contactPersonPhone'] as String?,
      contactPersonEmail: json['contactPersonEmail'] as String?,
      bankName: json['bankName'] as String?,
      bankAccountNumber: json['bankAccountNumber'] as String?,
      bankRoutingNumber: json['bankRoutingNumber'] as String?,
      productIds: (json['productIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      preferredPaymentMethod: json['preferredPaymentMethod'] as String?,
      totalPurchases: (json['totalPurchases'] as num?)?.toDouble() ?? 0,
      lastPurchaseDate: json['lastPurchaseDate'] == null
          ? null
          : DateTime.parse(json['lastPurchaseDate'] as String),
      totalOrders: (json['totalOrders'] as num?)?.toInt() ?? 0,
      averageDeliveryTime:
          (json['averageDeliveryTime'] as num?)?.toDouble() ?? 0.0,
      qualityRating: (json['qualityRating'] as num?)?.toDouble() ?? 0.0,
      isPreferred: json['isPreferred'] as bool? ?? true,
    );

Map<String, dynamic> _$$SupplierImplToJson(_$SupplierImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'name': instance.name,
      'code': instance.code,
      'email': instance.email,
      'phone': instance.phone,
      'mobile': instance.mobile,
      'website': instance.website,
      'taxNumber': instance.taxNumber,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'postalCode': instance.postalCode,
      'paymentTerms': instance.paymentTerms,
      'creditLimit': instance.creditLimit,
      'currentBalance': instance.currentBalance,
      'status': instance.status,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'contactPerson': instance.contactPerson,
      'contactPersonPhone': instance.contactPersonPhone,
      'contactPersonEmail': instance.contactPersonEmail,
      'bankName': instance.bankName,
      'bankAccountNumber': instance.bankAccountNumber,
      'bankRoutingNumber': instance.bankRoutingNumber,
      'productIds': instance.productIds,
      'metadata': instance.metadata,
      'preferredPaymentMethod': instance.preferredPaymentMethod,
      'totalPurchases': instance.totalPurchases,
      'lastPurchaseDate': instance.lastPurchaseDate?.toIso8601String(),
      'totalOrders': instance.totalOrders,
      'averageDeliveryTime': instance.averageDeliveryTime,
      'qualityRating': instance.qualityRating,
      'isPreferred': instance.isPreferred,
    };
