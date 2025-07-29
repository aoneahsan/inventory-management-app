import 'dart:convert';
import 'package:equatable/equatable.dart';

class CommunicationTemplate extends Equatable {
  final String id;
  final String organizationId;
  final String name;
  final CommunicationType type;
  final CommunicationTrigger trigger;
  final String? subject;
  final String content;
  final List<String> variables;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CommunicationTemplate({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.type,
    required this.trigger,
    this.subject,
    required this.content,
    required this.variables,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  CommunicationTemplate copyWith({
    String? id,
    String? organizationId,
    String? name,
    CommunicationType? type,
    CommunicationTrigger? trigger,
    String? subject,
    String? content,
    List<String>? variables,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CommunicationTemplate(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      name: name ?? this.name,
      type: type ?? this.type,
      trigger: trigger ?? this.trigger,
      subject: subject ?? this.subject,
      content: content ?? this.content,
      variables: variables ?? this.variables,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'organization_id': organizationId,
      'name': name,
      'type': type.value,
      'trigger': trigger.value,
      'subject': subject,
      'content': content,
      'variables': jsonEncode(variables),
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory CommunicationTemplate.fromMap(Map<String, dynamic> map) {
    return CommunicationTemplate(
      id: map['id'],
      organizationId: map['organization_id'],
      name: map['name'],
      type: CommunicationType.fromString(map['type']),
      trigger: CommunicationTrigger.fromString(map['trigger']),
      subject: map['subject'],
      content: map['content'],
      variables: map['variables'] != null
          ? List<String>.from(jsonDecode(map['variables']))
          : [],
      isActive: map['is_active'] == 1,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  String renderContent(Map<String, dynamic> data) {
    String rendered = content;
    for (final variable in variables) {
      if (data.containsKey(variable)) {
        rendered = rendered.replaceAll('{{$variable}}', data[variable].toString());
      }
    }
    return rendered;
  }

  String? renderSubject(Map<String, dynamic> data) {
    if (subject == null) return null;
    String rendered = subject!;
    for (final variable in variables) {
      if (data.containsKey(variable)) {
        rendered = rendered.replaceAll('{{$variable}}', data[variable].toString());
      }
    }
    return rendered;
  }

  @override
  List<Object?> get props => [
        id,
        organizationId,
        name,
        type,
        trigger,
        subject,
        content,
        variables,
        isActive,
        createdAt,
        updatedAt,
      ];
}

enum CommunicationType {
  sms('sms'),
  email('email'),
  whatsapp('whatsapp');

  final String value;
  const CommunicationType(this.value);

  static CommunicationType fromString(String value) {
    return CommunicationType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => CommunicationType.email,
    );
  }
}

enum CommunicationTrigger {
  orderPlaced('order_placed'),
  paymentReceived('payment_received'),
  orderShipped('order_shipped'),
  orderDelivered('order_delivered'),
  lowStock('low_stock'),
  customerRegistration('customer_registration'),
  invoiceGenerated('invoice_generated'),
  custom('custom');

  final String value;
  const CommunicationTrigger(this.value);

  static CommunicationTrigger fromString(String value) {
    return CommunicationTrigger.values.firstWhere(
      (trigger) => trigger.value == value,
      orElse: () => CommunicationTrigger.custom,
    );
  }
}

class CommunicationLog extends Equatable {
  final String id;
  final String organizationId;
  final String? customerId;
  final String? supplierId;
  final CommunicationType type;
  final String recipient;
  final String? subject;
  final String content;
  final CommunicationStatus status;
  final String? errorMessage;
  final DateTime? sentAt;
  final DateTime createdAt;

  const CommunicationLog({
    required this.id,
    required this.organizationId,
    this.customerId,
    this.supplierId,
    required this.type,
    required this.recipient,
    this.subject,
    required this.content,
    required this.status,
    this.errorMessage,
    this.sentAt,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'organization_id': organizationId,
      'customer_id': customerId,
      'supplier_id': supplierId,
      'type': type.value,
      'recipient': recipient,
      'subject': subject,
      'content': content,
      'status': status.value,
      'error_message': errorMessage,
      'sent_at': sentAt?.millisecondsSinceEpoch,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  factory CommunicationLog.fromMap(Map<String, dynamic> map) {
    return CommunicationLog(
      id: map['id'],
      organizationId: map['organization_id'],
      customerId: map['customer_id'],
      supplierId: map['supplier_id'],
      type: CommunicationType.fromString(map['type']),
      recipient: map['recipient'],
      subject: map['subject'],
      content: map['content'],
      status: CommunicationStatus.fromString(map['status']),
      errorMessage: map['error_message'],
      sentAt: map['sent_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['sent_at'])
          : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        organizationId,
        customerId,
        supplierId,
        type,
        recipient,
        subject,
        content,
        status,
        errorMessage,
        sentAt,
        createdAt,
      ];
}

enum CommunicationStatus {
  pending('pending'),
  sent('sent'),
  failed('failed');

  final String value;
  const CommunicationStatus(this.value);

  static CommunicationStatus fromString(String value) {
    return CommunicationStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => CommunicationStatus.pending,
    );
  }
}