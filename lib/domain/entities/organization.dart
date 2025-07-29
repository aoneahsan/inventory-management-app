import 'package:equatable/equatable.dart';

enum SubscriptionTier {
  free,
  basic,
  professional,
  enterprise,
}

enum SubscriptionStatus {
  active,
  inactive,
  suspended,
  cancelled,
  expired,
}

class Organization extends Equatable {
  final String id;
  final String name;
  final String ownerId;
  final SubscriptionTier tier;
  final SubscriptionStatus status;
  final int memberCount;
  final Map<String, dynamic> settings;
  final DateTime? subscriptionExpiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Organization({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.tier,
    required this.status,
    this.memberCount = 1,
    this.settings = const {},
    this.subscriptionExpiresAt,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isActive => status == SubscriptionStatus.active;
  bool get isFree => tier == SubscriptionTier.free;
  
  int get maxMembers {
    switch (tier) {
      case SubscriptionTier.free:
        return 3;
      case SubscriptionTier.basic:
        return 10;
      case SubscriptionTier.professional:
        return 50;
      case SubscriptionTier.enterprise:
        return 999999; // Unlimited
    }
  }

  int get maxProducts {
    switch (tier) {
      case SubscriptionTier.free:
        return 100;
      case SubscriptionTier.basic:
        return 1000;
      case SubscriptionTier.professional:
        return 10000;
      case SubscriptionTier.enterprise:
        return 999999; // Unlimited
    }
  }

  Organization copyWith({
    String? id,
    String? name,
    String? ownerId,
    SubscriptionTier? tier,
    SubscriptionStatus? status,
    int? memberCount,
    Map<String, dynamic>? settings,
    DateTime? subscriptionExpiresAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Organization(
      id: id ?? this.id,
      name: name ?? this.name,
      ownerId: ownerId ?? this.ownerId,
      tier: tier ?? this.tier,
      status: status ?? this.status,
      memberCount: memberCount ?? this.memberCount,
      settings: settings ?? this.settings,
      subscriptionExpiresAt: subscriptionExpiresAt ?? this.subscriptionExpiresAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'owner_id': ownerId,
      'subscription_tier': tier.name,
      'subscription_status': status.name,
      'member_count': memberCount,
      'settings': settings,
      'subscription_expires_at': subscriptionExpiresAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'] as String,
      name: json['name'] as String,
      ownerId: json['owner_id'] as String,
      tier: SubscriptionTier.values.firstWhere(
        (t) => t.name == json['subscription_tier'],
        orElse: () => SubscriptionTier.free,
      ),
      status: SubscriptionStatus.values.firstWhere(
        (s) => s.name == json['subscription_status'],
        orElse: () => SubscriptionStatus.active,
      ),
      memberCount: json['member_count'] as int? ?? 1,
      settings: json['settings'] as Map<String, dynamic>? ?? {},
      subscriptionExpiresAt: json['subscription_expires_at'] != null
          ? DateTime.parse(json['subscription_expires_at'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        ownerId,
        tier,
        status,
        memberCount,
        settings,
        subscriptionExpiresAt,
        createdAt,
        updatedAt,
      ];
}