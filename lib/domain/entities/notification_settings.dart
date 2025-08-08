import 'package:equatable/equatable.dart';

class NotificationSettings extends Equatable {
  final String userId;
  final bool enabled;
  final bool lowStockAlerts;
  final bool orderUpdates;
  final bool stockTransferAlerts;
  final bool systemAnnouncements;
  final bool emailNotifications;
  final bool pushNotifications;
  final int lowStockThreshold;
  final String? quietHoursStart;
  final String? quietHoursEnd;
  final DateTime? updatedAt;

  const NotificationSettings({
    required this.userId,
    this.enabled = true,
    this.lowStockAlerts = true,
    this.orderUpdates = true,
    this.stockTransferAlerts = true,
    this.systemAnnouncements = true,
    this.emailNotifications = true,
    this.pushNotifications = true,
    this.lowStockThreshold = 10,
    this.quietHoursStart,
    this.quietHoursEnd,
    this.updatedAt,
  });

  NotificationSettings copyWith({
    String? userId,
    bool? enabled,
    bool? lowStockAlerts,
    bool? orderUpdates,
    bool? stockTransferAlerts,
    bool? systemAnnouncements,
    bool? emailNotifications,
    bool? pushNotifications,
    int? lowStockThreshold,
    String? quietHoursStart,
    String? quietHoursEnd,
    DateTime? updatedAt,
  }) {
    return NotificationSettings(
      userId: userId ?? this.userId,
      enabled: enabled ?? this.enabled,
      lowStockAlerts: lowStockAlerts ?? this.lowStockAlerts,
      orderUpdates: orderUpdates ?? this.orderUpdates,
      stockTransferAlerts: stockTransferAlerts ?? this.stockTransferAlerts,
      systemAnnouncements: systemAnnouncements ?? this.systemAnnouncements,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      lowStockThreshold: lowStockThreshold ?? this.lowStockThreshold,
      quietHoursStart: quietHoursStart ?? this.quietHoursStart,
      quietHoursEnd: quietHoursEnd ?? this.quietHoursEnd,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'enabled': enabled,
      'low_stock_alerts': lowStockAlerts,
      'order_updates': orderUpdates,
      'stock_transfer_alerts': stockTransferAlerts,
      'system_announcements': systemAnnouncements,
      'email_notifications': emailNotifications,
      'push_notifications': pushNotifications,
      'low_stock_threshold': lowStockThreshold,
      'quiet_hours_start': quietHoursStart,
      'quiet_hours_end': quietHoursEnd,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory NotificationSettings.fromJson(Map<String, dynamic> json) {
    return NotificationSettings(
      userId: json['user_id'] as String,
      enabled: json['enabled'] as bool? ?? true,
      lowStockAlerts: json['low_stock_alerts'] as bool? ?? true,
      orderUpdates: json['order_updates'] as bool? ?? true,
      stockTransferAlerts: json['stock_transfer_alerts'] as bool? ?? true,
      systemAnnouncements: json['system_announcements'] as bool? ?? true,
      emailNotifications: json['email_notifications'] as bool? ?? true,
      pushNotifications: json['push_notifications'] as bool? ?? true,
      lowStockThreshold: json['low_stock_threshold'] as int? ?? 10,
      quietHoursStart: json['quiet_hours_start'] as String?,
      quietHoursEnd: json['quiet_hours_end'] as String?,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        enabled,
        lowStockAlerts,
        orderUpdates,
        stockTransferAlerts,
        systemAnnouncements,
        emailNotifications,
        pushNotifications,
        lowStockThreshold,
        quietHoursStart,
        quietHoursEnd,
        updatedAt,
      ];
}