// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BranchImpl _$$BranchImplFromJson(Map<String, dynamic> json) => _$BranchImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      name: json['name'] as String,
      code: json['code'] as String?,
      branchType: json['branchType'] as String? ?? 'store',
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      postalCode: json['postalCode'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      managerId: json['managerId'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      settings: json['settings'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      isDefault: json['isDefault'] as bool? ?? false,
      isWarehouse: json['isWarehouse'] as bool? ?? false,
      timezone: json['timezone'] as String?,
      operatingHours: (json['operatingHours'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      staffIds: (json['staffIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      imageUrl: json['imageUrl'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      allowPOS: json['allowPOS'] as bool? ?? true,
      allowOnlineOrders: json['allowOnlineOrders'] as bool? ?? true,
      allowPickup: json['allowPickup'] as bool? ?? true,
      allowDelivery: json['allowDelivery'] as bool? ?? true,
      deliveryRadius: (json['deliveryRadius'] as num?)?.toDouble() ?? 0,
      minimumOrderAmount: (json['minimumOrderAmount'] as num?)?.toDouble() ?? 0,
      deliveryFee: (json['deliveryFee'] as num?)?.toDouble() ?? 0,
      taxRegistrationNumber: json['taxRegistrationNumber'] as String?,
      paymentMethods: (json['paymentMethods'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      features: (json['features'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as bool),
          ) ??
          const {},
    );

Map<String, dynamic> _$$BranchImplToJson(_$BranchImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'name': instance.name,
      'code': instance.code,
      'branchType': instance.branchType,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'postalCode': instance.postalCode,
      'phone': instance.phone,
      'email': instance.email,
      'managerId': instance.managerId,
      'isActive': instance.isActive,
      'settings': instance.settings,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'isDefault': instance.isDefault,
      'isWarehouse': instance.isWarehouse,
      'timezone': instance.timezone,
      'operatingHours': instance.operatingHours,
      'staffIds': instance.staffIds,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'imageUrl': instance.imageUrl,
      'metadata': instance.metadata,
      'allowPOS': instance.allowPOS,
      'allowOnlineOrders': instance.allowOnlineOrders,
      'allowPickup': instance.allowPickup,
      'allowDelivery': instance.allowDelivery,
      'deliveryRadius': instance.deliveryRadius,
      'minimumOrderAmount': instance.minimumOrderAmount,
      'deliveryFee': instance.deliveryFee,
      'taxRegistrationNumber': instance.taxRegistrationNumber,
      'paymentMethods': instance.paymentMethods,
      'features': instance.features,
    };
