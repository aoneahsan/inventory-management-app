import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import '../../core/errors/exceptions.dart';

class EmailSmsService {
  final FirebaseFunctions _functions;

  EmailSmsService({
    FirebaseFunctions? functions,
  }) : _functions = functions ?? FirebaseFunctions.instance;

  // Email templates
  static const String templateWelcome = 'welcome';
  static const String templateLowStock = 'lowStock';
  static const String templateOrderShipped = 'orderShipped';
  static const String templateInvoiceGenerated = 'invoiceGenerated';
  static const String templateSubscriptionUpgraded = 'subscriptionUpgraded';

  // SMS templates
  static const String smsTemplateLowStock = 'lowStock';
  static const String smsTemplateOrderShipped = 'orderShipped';
  static const String smsTemplateVerificationCode = 'verificationCode';

  Future<void> sendEmail({
    required String to,
    required String template,
    required Map<String, dynamic> templateData,
  }) async {
    try {
      final callable = _functions.httpsCallable('sendEmailNotification');
      await callable.call({
        'to': to,
        'template': template,
        'templateData': templateData,
      });
    } catch (e) {
      debugPrint('Error sending email: $e');
      throw BusinessException(message: 'Failed to send email notification');
    }
  }

  Future<void> sendSms({
    required String to,
    required String template,
    required Map<String, dynamic> templateData,
  }) async {
    try {
      final callable = _functions.httpsCallable('sendSmsNotification');
      await callable.call({
        'to': to,
        'template': template,
        'templateData': templateData,
      });
    } catch (e) {
      debugPrint('Error sending SMS: $e');
      throw BusinessException(message: 'Failed to send SMS notification');
    }
  }

  Future<void> sendBatchEmails({
    required List<EmailData> emails,
  }) async {
    try {
      final callable = _functions.httpsCallable('sendBatchEmails');
      final emailsData = emails.map((e) => {
        'to': e.to,
        'template': e.template,
        'templateData': e.templateData,
      }).toList();

      await callable.call({'emails': emailsData});
    } catch (e) {
      debugPrint('Error sending batch emails: $e');
      throw BusinessException(message: 'Failed to send batch emails');
    }
  }

  Future<void> updateNotificationPreferences({
    required NotificationPreferences preferences,
  }) async {
    try {
      final callable = _functions.httpsCallable('updateNotificationPreferences');
      await callable.call({
        'preferences': preferences.toJson(),
      });
    } catch (e) {
      debugPrint('Error updating notification preferences: $e');
      throw BusinessException(message: 'Failed to update notification preferences');
    }
  }

  // Convenience methods for common notifications
  Future<void> sendWelcomeEmail({
    required String to,
    required String userName,
    required String organizationName,
  }) async {
    await sendEmail(
      to: to,
      template: templateWelcome,
      templateData: {
        'name': userName,
        'organizationName': organizationName,
      },
    );
  }

  Future<void> sendLowStockAlert({
    String? email,
    String? phoneNumber,
    required String productName,
    required int currentStock,
    required int threshold,
  }) async {
    final futures = <Future>[];

    if (email != null) {
      futures.add(sendEmail(
        to: email,
        template: templateLowStock,
        templateData: {
          'productName': productName,
          'currentStock': currentStock,
          'threshold': threshold,
        },
      ));
    }

    if (phoneNumber != null) {
      futures.add(sendSms(
        to: phoneNumber,
        template: smsTemplateLowStock,
        templateData: {
          'productName': productName,
          'currentStock': currentStock,
        },
      ));
    }

    await Future.wait(futures);
  }

  Future<void> sendOrderShippedNotification({
    String? email,
    String? phoneNumber,
    required String orderNumber,
    String? trackingNumber,
  }) async {
    final futures = <Future>[];

    if (email != null) {
      futures.add(sendEmail(
        to: email,
        template: templateOrderShipped,
        templateData: {
          'orderNumber': orderNumber,
          'trackingNumber': trackingNumber,
        },
      ));
    }

    if (phoneNumber != null) {
      futures.add(sendSms(
        to: phoneNumber,
        template: smsTemplateOrderShipped,
        templateData: {
          'orderNumber': orderNumber,
        },
      ));
    }

    await Future.wait(futures);
  }

  Future<void> sendInvoiceGeneratedEmail({
    required String to,
    required String invoiceNumber,
    required double amount,
    required DateTime dueDate,
  }) async {
    await sendEmail(
      to: to,
      template: templateInvoiceGenerated,
      templateData: {
        'invoiceNumber': invoiceNumber,
        'amount': amount,
        'dueDate': '${dueDate.day}/${dueDate.month}/${dueDate.year}',
      },
    );
  }

  Future<void> sendSubscriptionUpgradedEmail({
    required String to,
    required String planName,
  }) async {
    await sendEmail(
      to: to,
      template: templateSubscriptionUpgraded,
      templateData: {
        'planName': planName,
      },
    );
  }

  Future<void> sendVerificationSms({
    required String to,
    required String code,
  }) async {
    await sendSms(
      to: to,
      template: smsTemplateVerificationCode,
      templateData: {
        'code': code,
      },
    );
  }
}

class EmailData {
  final String to;
  final String template;
  final Map<String, dynamic> templateData;

  EmailData({
    required this.to,
    required this.template,
    required this.templateData,
  });
}

class NotificationPreferences {
  final NotificationChannelPrefs lowStock;
  final NotificationChannelPrefs orderUpdates;
  final NotificationChannelPrefs invoices;
  final NotificationChannelPrefs systemAlerts;

  NotificationPreferences({
    required this.lowStock,
    required this.orderUpdates,
    required this.invoices,
    required this.systemAlerts,
  });

  Map<String, dynamic> toJson() => {
    'lowStock': lowStock.toJson(),
    'orderUpdates': orderUpdates.toJson(),
    'invoices': invoices.toJson(),
    'systemAlerts': systemAlerts.toJson(),
  };

  factory NotificationPreferences.fromJson(Map<String, dynamic> json) {
    return NotificationPreferences(
      lowStock: NotificationChannelPrefs.fromJson(json['lowStock'] ?? {}),
      orderUpdates: NotificationChannelPrefs.fromJson(json['orderUpdates'] ?? {}),
      invoices: NotificationChannelPrefs.fromJson(json['invoices'] ?? {}),
      systemAlerts: NotificationChannelPrefs.fromJson(json['systemAlerts'] ?? {}),
    );
  }

  factory NotificationPreferences.defaultPrefs() {
    return NotificationPreferences(
      lowStock: NotificationChannelPrefs(
        enabled: true,
        email: true,
        sms: false,
        push: true,
      ),
      orderUpdates: NotificationChannelPrefs(
        enabled: true,
        email: true,
        sms: true,
        push: true,
      ),
      invoices: NotificationChannelPrefs(
        enabled: true,
        email: true,
        sms: false,
        push: false,
      ),
      systemAlerts: NotificationChannelPrefs(
        enabled: true,
        email: true,
        sms: false,
        push: true,
      ),
    );
  }
}

class NotificationChannelPrefs {
  final bool enabled;
  final bool email;
  final bool sms;
  final bool push;

  NotificationChannelPrefs({
    required this.enabled,
    required this.email,
    required this.sms,
    required this.push,
  });

  Map<String, dynamic> toJson() => {
    'enabled': enabled,
    'email': email,
    'sms': sms,
    'push': push,
  };

  factory NotificationChannelPrefs.fromJson(Map<String, dynamic> json) {
    return NotificationChannelPrefs(
      enabled: json['enabled'] ?? true,
      email: json['email'] ?? true,
      sms: json['sms'] ?? false,
      push: json['push'] ?? true,
    );
  }
}