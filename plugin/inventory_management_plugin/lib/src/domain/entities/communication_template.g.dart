// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communication_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommunicationTemplateImpl _$$CommunicationTemplateImplFromJson(
        Map<String, dynamic> json) =>
    _$CommunicationTemplateImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$CommunicationTypeEnumMap, json['type']),
      trigger: $enumDecode(_$CommunicationTriggerEnumMap, json['trigger']),
      subject: json['subject'] as String?,
      content: json['content'] as String,
      variables: (json['variables'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      description: json['description'] as String?,
      categoryId: json['categoryId'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      languageCode: json['languageCode'] as String?,
      priority: (json['priority'] as num?)?.toInt() ?? 0,
      senderName: json['senderName'] as String?,
      senderEmail: json['senderEmail'] as String?,
      senderPhone: json['senderPhone'] as String?,
      attachmentUrls: (json['attachmentUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      requiresApproval: json['requiresApproval'] as bool? ?? false,
      approvedBy: json['approvedBy'] as String?,
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      delayMinutes: (json['delayMinutes'] as num?)?.toInt() ?? 0,
      scheduleCron: json['scheduleCron'] as String?,
      trackOpens: json['trackOpens'] as bool? ?? true,
      trackClicks: json['trackClicks'] as bool? ?? true,
      isTransactional: json['isTransactional'] as bool? ?? false,
      replyTo: json['replyTo'] as String?,
      ccEmails: (json['ccEmails'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      bccEmails: (json['bccEmails'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CommunicationTemplateImplToJson(
        _$CommunicationTemplateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'name': instance.name,
      'type': _$CommunicationTypeEnumMap[instance.type]!,
      'trigger': _$CommunicationTriggerEnumMap[instance.trigger]!,
      'subject': instance.subject,
      'content': instance.content,
      'variables': instance.variables,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'description': instance.description,
      'categoryId': instance.categoryId,
      'metadata': instance.metadata,
      'languageCode': instance.languageCode,
      'priority': instance.priority,
      'senderName': instance.senderName,
      'senderEmail': instance.senderEmail,
      'senderPhone': instance.senderPhone,
      'attachmentUrls': instance.attachmentUrls,
      'headers': instance.headers,
      'requiresApproval': instance.requiresApproval,
      'approvedBy': instance.approvedBy,
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'delayMinutes': instance.delayMinutes,
      'scheduleCron': instance.scheduleCron,
      'trackOpens': instance.trackOpens,
      'trackClicks': instance.trackClicks,
      'isTransactional': instance.isTransactional,
      'replyTo': instance.replyTo,
      'ccEmails': instance.ccEmails,
      'bccEmails': instance.bccEmails,
    };

const _$CommunicationTypeEnumMap = {
  CommunicationType.sms: 'sms',
  CommunicationType.email: 'email',
  CommunicationType.whatsapp: 'whatsapp',
  CommunicationType.pushNotification: 'push_notification',
  CommunicationType.inApp: 'in_app',
};

const _$CommunicationTriggerEnumMap = {
  CommunicationTrigger.orderPlaced: 'order_placed',
  CommunicationTrigger.paymentReceived: 'payment_received',
  CommunicationTrigger.orderShipped: 'order_shipped',
  CommunicationTrigger.orderDelivered: 'order_delivered',
  CommunicationTrigger.lowStock: 'low_stock',
  CommunicationTrigger.customerRegistration: 'customer_registration',
  CommunicationTrigger.invoiceGenerated: 'invoice_generated',
  CommunicationTrigger.purchaseOrderCreated: 'purchase_order_created',
  CommunicationTrigger.purchaseOrderApproved: 'purchase_order_approved',
  CommunicationTrigger.stockTransferInitiated: 'stock_transfer_initiated',
  CommunicationTrigger.stockTransferCompleted: 'stock_transfer_completed',
  CommunicationTrigger.paymentReminder: 'payment_reminder',
  CommunicationTrigger.birthdayWish: 'birthday_wish',
  CommunicationTrigger.loyaltyPointsEarned: 'loyalty_points_earned',
  CommunicationTrigger.custom: 'custom',
};

_$CommunicationLogImpl _$$CommunicationLogImplFromJson(
        Map<String, dynamic> json) =>
    _$CommunicationLogImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      templateId: json['templateId'] as String?,
      customerId: json['customerId'] as String?,
      supplierId: json['supplierId'] as String?,
      userId: json['userId'] as String?,
      type: $enumDecode(_$CommunicationTypeEnumMap, json['type']),
      recipient: json['recipient'] as String,
      subject: json['subject'] as String?,
      content: json['content'] as String,
      status:
          $enumDecodeNullable(_$CommunicationStatusEnumMap, json['status']) ??
              CommunicationStatus.pending,
      errorMessage: json['errorMessage'] as String?,
      sentAt: json['sentAt'] == null
          ? null
          : DateTime.parse(json['sentAt'] as String),
      deliveredAt: json['deliveredAt'] == null
          ? null
          : DateTime.parse(json['deliveredAt'] as String),
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      messageId: json['messageId'] as String?,
      conversationId: json['conversationId'] as String?,
      cost: (json['cost'] as num?)?.toDouble() ?? 0,
      provider: json['provider'] as String?,
      retryCount: (json['retryCount'] as num?)?.toInt() ?? 0,
      nextRetryAt: json['nextRetryAt'] == null
          ? null
          : DateTime.parse(json['nextRetryAt'] as String),
      attachmentUrls: (json['attachmentUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      direction: json['direction'] as String?,
      replyToId: json['replyToId'] as String?,
      providerResponse:
          json['providerResponse'] as Map<String, dynamic>? ?? const {},
      campaignId: json['campaignId'] as String?,
      events: (json['events'] as List<dynamic>?)
              ?.map(
                  (e) => CommunicationEvent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CommunicationLogImplToJson(
        _$CommunicationLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'templateId': instance.templateId,
      'customerId': instance.customerId,
      'supplierId': instance.supplierId,
      'userId': instance.userId,
      'type': _$CommunicationTypeEnumMap[instance.type]!,
      'recipient': instance.recipient,
      'subject': instance.subject,
      'content': instance.content,
      'status': _$CommunicationStatusEnumMap[instance.status]!,
      'errorMessage': instance.errorMessage,
      'sentAt': instance.sentAt?.toIso8601String(),
      'deliveredAt': instance.deliveredAt?.toIso8601String(),
      'readAt': instance.readAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'metadata': instance.metadata,
      'messageId': instance.messageId,
      'conversationId': instance.conversationId,
      'cost': instance.cost,
      'provider': instance.provider,
      'retryCount': instance.retryCount,
      'nextRetryAt': instance.nextRetryAt?.toIso8601String(),
      'attachmentUrls': instance.attachmentUrls,
      'direction': instance.direction,
      'replyToId': instance.replyToId,
      'providerResponse': instance.providerResponse,
      'campaignId': instance.campaignId,
      'events': instance.events,
    };

const _$CommunicationStatusEnumMap = {
  CommunicationStatus.pending: 'pending',
  CommunicationStatus.sent: 'sent',
  CommunicationStatus.delivered: 'delivered',
  CommunicationStatus.read: 'read',
  CommunicationStatus.failed: 'failed',
  CommunicationStatus.bounced: 'bounced',
};

_$CommunicationEventImpl _$$CommunicationEventImplFromJson(
        Map<String, dynamic> json) =>
    _$CommunicationEventImpl(
      type: json['type'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      data: json['data'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$CommunicationEventImplToJson(
        _$CommunicationEventImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'timestamp': instance.timestamp.toIso8601String(),
      'data': instance.data,
    };
