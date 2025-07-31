import 'package:freezed_annotation/freezed_annotation.dart';

part 'branch.freezed.dart';
part 'branch.g.dart';

@freezed
class Branch with _$Branch {
  const factory Branch({
    required String id,
    required String organizationId,
    required String name,
    String? code,
    @Default('store') String branchType,
    String? address,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    String? phone,
    String? email,
    String? managerId,
    @Default(true) bool isActive,
    Map<String, dynamic>? settings,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
    
    // Additional fields for plugin
    @Default(false) bool isDefault,
    @Default(false) bool isWarehouse,
    String? timezone,
    @Default({}) Map<String, String> operatingHours, // {"monday": "9:00-18:00"}
    @Default([]) List<String> staffIds,
    @Default(0) double latitude,
    @Default(0) double longitude,
    String? imageUrl,
    @Default({}) Map<String, dynamic> metadata,
    @Default(true) bool allowPOS,
    @Default(true) bool allowOnlineOrders,
    @Default(true) bool allowPickup,
    @Default(true) bool allowDelivery,
    @Default(0) double deliveryRadius, // in km
    @Default(0) double minimumOrderAmount,
    @Default(0) double deliveryFee,
    String? taxRegistrationNumber,
    @Default([]) List<String> paymentMethods,
    @Default({}) Map<String, bool> features, // feature flags specific to branch
  }) = _Branch;
  
  const Branch._();
  
  factory Branch.fromJson(Map<String, dynamic> json) => _$BranchFromJson(json);
  
  // Helper methods
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
  
  bool get hasLocation => latitude != 0 && longitude != 0;
  
  bool isOpenAt(DateTime dateTime) {
    final dayName = _getDayName(dateTime.weekday);
    final hours = operatingHours[dayName];
    if (hours == null || hours.isEmpty) return false;
    
    final parts = hours.split('-');
    if (parts.length != 2) return false;
    
    final openTime = _parseTime(parts[0]);
    final closeTime = _parseTime(parts[1]);
    final currentMinutes = dateTime.hour * 60 + dateTime.minute;
    
    return currentMinutes >= openTime && currentMinutes <= closeTime;
  }
  
  String _getDayName(int weekday) {
    switch (weekday) {
      case 1: return 'monday';
      case 2: return 'tuesday';
      case 3: return 'wednesday';
      case 4: return 'thursday';
      case 5: return 'friday';
      case 6: return 'saturday';
      case 7: return 'sunday';
      default: return 'monday';
    }
  }
  
  int _parseTime(String time) {
    final parts = time.trim().split(':');
    if (parts.length != 2) return 0;
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;
    return hour * 60 + minute;
  }
  
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    // Convert DateTime to Firestore Timestamp format
    json['created_at'] = createdAt.millisecondsSinceEpoch;
    json['updated_at'] = updatedAt.millisecondsSinceEpoch;
    if (syncedAt != null) {
      json['synced_at'] = syncedAt!.millisecondsSinceEpoch;
    }
    return json;
  }
  
  factory Branch.fromFirestore(Map<String, dynamic> json) {
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
    return Branch.fromJson(json);
  }
}

enum BranchType {
  store,
  warehouse,
  distribution_center,
  outlet,
  kiosk,
  online_only;
  
  String get displayName {
    switch (this) {
      case BranchType.store:
        return 'Store';
      case BranchType.warehouse:
        return 'Warehouse';
      case BranchType.distribution_center:
        return 'Distribution Center';
      case BranchType.outlet:
        return 'Outlet';
      case BranchType.kiosk:
        return 'Kiosk';
      case BranchType.online_only:
        return 'Online Only';
    }
  }
}