import 'package:equatable/equatable.dart';

class AuditLog extends Equatable {
  final String id;
  final String userId;
  final String userName;
  final String organizationId;
  final String action;
  final String entityType;
  final String? entityId;
  final Map<String, dynamic>? oldData;
  final Map<String, dynamic>? newData;
  final String? ipAddress;
  final String? userAgent;
  final DateTime timestamp;

  const AuditLog({
    required this.id,
    required this.userId,
    required this.userName,
    required this.organizationId,
    required this.action,
    required this.entityType,
    this.entityId,
    this.oldData,
    this.newData,
    this.ipAddress,
    this.userAgent,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'user_name': userName,
      'organization_id': organizationId,
      'action': action,
      'entity_type': entityType,
      'entity_id': entityId,
      'old_data': oldData,
      'new_data': newData,
      'ip_address': ipAddress,
      'user_agent': userAgent,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory AuditLog.fromJson(Map<String, dynamic> json) {
    return AuditLog(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      userName: json['user_name'] as String,
      organizationId: json['organization_id'] as String,
      action: json['action'] as String,
      entityType: json['entity_type'] as String,
      entityId: json['entity_id'] as String?,
      oldData: json['old_data'] as Map<String, dynamic>?,
      newData: json['new_data'] as Map<String, dynamic>?,
      ipAddress: json['ip_address'] as String?,
      userAgent: json['user_agent'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        userName,
        organizationId,
        action,
        entityType,
        entityId,
        oldData,
        newData,
        ipAddress,
        userAgent,
        timestamp,
      ];
}

class AuditAction {
  static const String create = 'CREATE';
  static const String update = 'UPDATE';
  static const String delete = 'DELETE';
  static const String login = 'LOGIN';
  static const String logout = 'LOGOUT';
  static const String export = 'EXPORT';
  static const String import = 'IMPORT';
  static const String backup = 'BACKUP';
  static const String restore = 'RESTORE';
}