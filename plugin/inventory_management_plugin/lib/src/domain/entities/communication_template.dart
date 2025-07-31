import 'package:freezed_annotation/freezed_annotation.dart';

part 'communication_template.freezed.dart';
part 'communication_template.g.dart';

enum CommunicationType {
  @JsonValue('sms')
  sms,
  @JsonValue('email')
  email,
  @JsonValue('whatsapp')
  whatsapp,
  @JsonValue('push_notification')
  pushNotification,
  @JsonValue('in_app')
  inApp,
}

enum CommunicationTrigger {
  @JsonValue('order_placed')
  orderPlaced,
  @JsonValue('payment_received')
  paymentReceived,
  @JsonValue('order_shipped')
  orderShipped,
  @JsonValue('order_delivered')
  orderDelivered,
  @JsonValue('low_stock')
  lowStock,
  @JsonValue('customer_registration')
  customerRegistration,
  @JsonValue('invoice_generated')
  invoiceGenerated,
  @JsonValue('purchase_order_created')
  purchaseOrderCreated,
  @JsonValue('purchase_order_approved')
  purchaseOrderApproved,
  @JsonValue('stock_transfer_initiated')
  stockTransferInitiated,
  @JsonValue('stock_transfer_completed')
  stockTransferCompleted,
  @JsonValue('payment_reminder')
  paymentReminder,
  @JsonValue('birthday_wish')
  birthdayWish,
  @JsonValue('loyalty_points_earned')
  loyaltyPointsEarned,
  @JsonValue('custom')
  custom,
}

enum CommunicationStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('sent')
  sent,
  @JsonValue('delivered')
  delivered,
  @JsonValue('read')
  read,
  @JsonValue('failed')
  failed,
  @JsonValue('bounced')
  bounced,
}

@freezed
class CommunicationTemplate with _$CommunicationTemplate {
  const factory CommunicationTemplate({
    required String id,
    required String organizationId,
    required String name,
    required CommunicationType type,
    required CommunicationTrigger trigger,
    String? subject,
    required String content,
    @Default([]) List<String> variables,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? syncedAt,
    
    // Additional fields
    String? description,
    String? categoryId,
    @Default({}) Map<String, dynamic> metadata,
    String? languageCode,
    @Default(0) int priority,
    String? senderName,
    String? senderEmail,
    String? senderPhone,
    @Default([]) List<String> attachmentUrls,
    @Default({}) Map<String, String> headers,
    @Default(false) bool requiresApproval,
    String? approvedBy,
    DateTime? approvedAt,
    @Default(0) int delayMinutes,
    String? scheduleCron,
    @Default(true) bool trackOpens,
    @Default(true) bool trackClicks,
    @Default(false) bool isTransactional,
    String? replyTo,
    @Default([]) List<String> ccEmails,
    @Default([]) List<String> bccEmails,
  }) = _CommunicationTemplate;
  
  const CommunicationTemplate._();
  
  factory CommunicationTemplate.fromJson(Map<String, dynamic> json) => 
      _$CommunicationTemplateFromJson(json);
  
  // Helper methods
  String renderContent(Map<String, dynamic> data) {
    String rendered = content;
    for (final variable in variables) {
      if (data.containsKey(variable)) {
        final value = data[variable]?.toString() ?? '';
        rendered = rendered.replaceAll('{{$variable}}', value);
      }
    }
    return rendered;
  }
  
  String? renderSubject(Map<String, dynamic> data) {
    if (subject == null) return null;
    String rendered = subject!;
    for (final variable in variables) {
      if (data.containsKey(variable)) {
        final value = data[variable]?.toString() ?? '';
        rendered = rendered.replaceAll('{{$variable}}', value);
      }
    }
    return rendered;
  }
  
  List<String> extractVariables() {
    final regex = RegExp(r'\{\{(\w+)\}\}');
    final Set<String> foundVariables = {};
    
    // Extract from content
    final contentMatches = regex.allMatches(content);
    for (final match in contentMatches) {
      if (match.group(1) != null) {
        foundVariables.add(match.group(1)!);
      }
    }
    
    // Extract from subject
    if (subject != null) {
      final subjectMatches = regex.allMatches(subject!);
      for (final match in subjectMatches) {
        if (match.group(1) != null) {
          foundVariables.add(match.group(1)!);
        }
      }
    }
    
    return foundVariables.toList()..sort();
  }
  
  bool get needsApproval => requiresApproval && approvedAt == null;
  bool get isApproved => requiresApproval && approvedAt != null;
  bool get isScheduled => scheduleCron != null && scheduleCron!.isNotEmpty;
  bool get hasDelay => delayMinutes > 0;
  bool get hasAttachments => attachmentUrls.isNotEmpty;
  
  String get typeDisplay {
    switch (type) {
      case CommunicationType.sms:
        return 'SMS';
      case CommunicationType.email:
        return 'Email';
      case CommunicationType.whatsapp:
        return 'WhatsApp';
      case CommunicationType.pushNotification:
        return 'Push Notification';
      case CommunicationType.inApp:
        return 'In-App Message';
    }
  }
  
  String get triggerDisplay {
    switch (trigger) {
      case CommunicationTrigger.orderPlaced:
        return 'Order Placed';
      case CommunicationTrigger.paymentReceived:
        return 'Payment Received';
      case CommunicationTrigger.orderShipped:
        return 'Order Shipped';
      case CommunicationTrigger.orderDelivered:
        return 'Order Delivered';
      case CommunicationTrigger.lowStock:
        return 'Low Stock Alert';
      case CommunicationTrigger.customerRegistration:
        return 'Customer Registration';
      case CommunicationTrigger.invoiceGenerated:
        return 'Invoice Generated';
      case CommunicationTrigger.purchaseOrderCreated:
        return 'Purchase Order Created';
      case CommunicationTrigger.purchaseOrderApproved:
        return 'Purchase Order Approved';
      case CommunicationTrigger.stockTransferInitiated:
        return 'Stock Transfer Initiated';
      case CommunicationTrigger.stockTransferCompleted:
        return 'Stock Transfer Completed';
      case CommunicationTrigger.paymentReminder:
        return 'Payment Reminder';
      case CommunicationTrigger.birthdayWish:
        return 'Birthday Wish';
      case CommunicationTrigger.loyaltyPointsEarned:
        return 'Loyalty Points Earned';
      case CommunicationTrigger.custom:
        return 'Custom';
    }
  }
}

@freezed
class CommunicationLog with _$CommunicationLog {
  const factory CommunicationLog({
    required String id,
    required String organizationId,
    String? templateId,
    String? customerId,
    String? supplierId,
    String? userId,
    required CommunicationType type,
    required String recipient,
    String? subject,
    required String content,
    @Default(CommunicationStatus.pending) CommunicationStatus status,
    String? errorMessage,
    DateTime? sentAt,
    DateTime? deliveredAt,
    DateTime? readAt,
    required DateTime createdAt,
    DateTime? syncedAt,
    
    // Additional fields
    @Default({}) Map<String, dynamic> metadata,
    String? messageId,
    String? conversationId,
    @Default(0) double cost,
    String? provider,
    @Default(0) int retryCount,
    DateTime? nextRetryAt,
    @Default([]) List<String> attachmentUrls,
    String? direction, // 'inbound' or 'outbound'
    String? replyToId,
    @Default({}) Map<String, dynamic> providerResponse,
    String? campaignId,
    @Default([]) List<CommunicationEvent> events,
  }) = _CommunicationLog;
  
  const CommunicationLog._();
  
  factory CommunicationLog.fromJson(Map<String, dynamic> json) => 
      _$CommunicationLogFromJson(json);
  
  // Helper methods
  bool get isPending => status == CommunicationStatus.pending;
  bool get isSent => status == CommunicationStatus.sent;
  bool get isDelivered => status == CommunicationStatus.delivered;
  bool get isRead => status == CommunicationStatus.read;
  bool get isFailed => status == CommunicationStatus.failed;
  bool get isBounced => status == CommunicationStatus.bounced;
  
  bool get isInbound => direction == 'inbound';
  bool get isOutbound => direction == 'outbound' || direction == null;
  
  bool get hasAttachments => attachmentUrls.isNotEmpty;
  bool get isReply => replyToId != null;
  bool get canRetry => isFailed && retryCount < 3;
  
  Duration? get deliveryTime {
    if (sentAt == null || deliveredAt == null) return null;
    return deliveredAt!.difference(sentAt!);
  }
  
  Duration? get readTime {
    if (deliveredAt == null || readAt == null) return null;
    return readAt!.difference(deliveredAt!);
  }
  
  String get statusDisplay {
    switch (status) {
      case CommunicationStatus.pending:
        return 'Pending';
      case CommunicationStatus.sent:
        return 'Sent';
      case CommunicationStatus.delivered:
        return 'Delivered';
      case CommunicationStatus.read:
        return 'Read';
      case CommunicationStatus.failed:
        return 'Failed';
      case CommunicationStatus.bounced:
        return 'Bounced';
    }
  }
}

@freezed
class CommunicationEvent with _$CommunicationEvent {
  const factory CommunicationEvent({
    required String type,
    required DateTime timestamp,
    @Default({}) Map<String, dynamic> data,
  }) = _CommunicationEvent;
  
  factory CommunicationEvent.fromJson(Map<String, dynamic> json) => 
      _$CommunicationEventFromJson(json);
}

// Template builders for common scenarios
class CommunicationTemplateBuilders {
  static CommunicationTemplate orderConfirmation({
    required String organizationId,
    required CommunicationType type,
  }) {
    final now = DateTime.now();
    return CommunicationTemplate(
      id: 'order_confirmation_${type.name}',
      organizationId: organizationId,
      name: 'Order Confirmation',
      type: type,
      trigger: CommunicationTrigger.orderPlaced,
      subject: type == CommunicationType.email ? 'Order Confirmation - {{orderNumber}}' : null,
      content: _getOrderConfirmationContent(type),
      variables: ['customerName', 'orderNumber', 'orderDate', 'totalAmount', 'items'],
      isTransactional: true,
      createdAt: now,
      updatedAt: now,
    );
  }
  
  static CommunicationTemplate lowStockAlert({
    required String organizationId,
    required CommunicationType type,
  }) {
    final now = DateTime.now();
    return CommunicationTemplate(
      id: 'low_stock_alert_${type.name}',
      organizationId: organizationId,
      name: 'Low Stock Alert',
      type: type,
      trigger: CommunicationTrigger.lowStock,
      subject: type == CommunicationType.email ? 'Low Stock Alert - {{productName}}' : null,
      content: _getLowStockContent(type),
      variables: ['productName', 'currentStock', 'minStock', 'branchName'],
      priority: 1,
      createdAt: now,
      updatedAt: now,
    );
  }
  
  static String _getOrderConfirmationContent(CommunicationType type) {
    if (type == CommunicationType.sms) {
      return 'Hi {{customerName}}, your order {{orderNumber}} has been confirmed. Total: {{totalAmount}}. Thank you!';
    }
    return '''
Hi {{customerName}},

Thank you for your order!

Order Number: {{orderNumber}}
Order Date: {{orderDate}}
Total Amount: {{totalAmount}}

Items:
{{items}}

We'll notify you when your order is ready.

Best regards,
Your Store Team
''';
  }
  
  static String _getLowStockContent(CommunicationType type) {
    if (type == CommunicationType.sms) {
      return 'Low Stock Alert: {{productName}} at {{branchName}} - Current: {{currentStock}}, Min: {{minStock}}';
    }
    return '''
Low Stock Alert

Product: {{productName}}
Branch: {{branchName}}
Current Stock: {{currentStock}}
Minimum Stock: {{minStock}}

Please reorder this product to avoid stockout.
''';
  }
}