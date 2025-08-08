import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import '../../core/errors/exceptions.dart';

enum AuditAction {
  // Authentication
  login,
  logout,
  passwordChange,
  passwordReset,
  
  // User Management
  userCreate,
  userUpdate,
  userDelete,
  roleChange,
  
  // Financial
  paymentProcess,
  refundProcess,
  subscriptionChange,
  
  // Data Access
  dataExport,
  dataImport,
  dataDelete,
  
  // Security
  apiKeyCreate,
  apiKeyRevoke,
  permissionChange,
  settingsChange,
  
  // Inventory
  stockAdjustment,
  priceChange,
  bulkUpdate,
}

class AuditLog {
  final String id;
  final String organizationId;
  final String userId;
  final String userEmail;
  final AuditAction action;
  final String actionDescription;
  final Map<String, dynamic>? metadata;
  final String ipAddress;
  final String userAgent;
  final String? deviceId;
  final DateTime timestamp;

  AuditLog({
    required this.id,
    required this.organizationId,
    required this.userId,
    required this.userEmail,
    required this.action,
    required this.actionDescription,
    this.metadata,
    required this.ipAddress,
    required this.userAgent,
    this.deviceId,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organizationId': organizationId,
      'userId': userId,
      'userEmail': userEmail,
      'action': action.toString().split('.').last,
      'actionDescription': actionDescription,
      'metadata': metadata,
      'ipAddress': ipAddress,
      'userAgent': userAgent,
      'deviceId': deviceId,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory AuditLog.fromJson(Map<String, dynamic> json) {
    return AuditLog(
      id: json['id'],
      organizationId: json['organizationId'],
      userId: json['userId'],
      userEmail: json['userEmail'],
      action: AuditAction.values.firstWhere(
        (e) => e.toString().split('.').last == json['action'],
      ),
      actionDescription: json['actionDescription'],
      metadata: json['metadata'],
      ipAddress: json['ipAddress'],
      userAgent: json['userAgent'],
      deviceId: json['deviceId'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

class AuditService {
  final FirebaseFirestore _firestore;
  static const String _collection = 'auditLogs';
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  AuditService({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  // Log an audit event
  Future<void> logEvent({
    required String organizationId,
    required String userId,
    required String userEmail,
    required AuditAction action,
    required String actionDescription,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final deviceId = await _getDeviceId();
      final ipAddress = await _getIpAddress();
      final userAgent = await _getUserAgent();
      
      final docRef = _firestore.collection(_collection).doc();
      final auditLog = AuditLog(
        id: docRef.id,
        organizationId: organizationId,
        userId: userId,
        userEmail: userEmail,
        action: action,
        actionDescription: actionDescription,
        metadata: metadata,
        ipAddress: ipAddress,
        userAgent: userAgent,
        deviceId: deviceId,
        timestamp: DateTime.now(),
      );

      await docRef.set(auditLog.toJson());
    } catch (e) {
      // Don't throw - audit logging should not break the app
      print('Failed to log audit event: $e');
    }
  }

  // Get audit logs for organization
  Stream<List<AuditLog>> getAuditLogs({
    required String organizationId,
    String? userId,
    AuditAction? action,
    DateTime? startDate,
    DateTime? endDate,
    int limit = 100,
  }) {
    Query query = _firestore
        .collection(_collection)
        .where('organizationId', isEqualTo: organizationId);

    if (userId != null) {
      query = query.where('userId', isEqualTo: userId);
    }

    if (action != null) {
      query = query.where('action', isEqualTo: action.toString().split('.').last);
    }

    if (startDate != null) {
      query = query.where('timestamp', isGreaterThanOrEqualTo: startDate.toIso8601String());
    }

    if (endDate != null) {
      query = query.where('timestamp', isLessThanOrEqualTo: endDate.toIso8601String());
    }

    return query
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return AuditLog.fromJson({
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        });
      }).toList();
    });
  }

  // Search audit logs
  Future<List<AuditLog>> searchAuditLogs({
    required String organizationId,
    required String searchQuery,
    int limit = 50,
  }) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('organizationId', isEqualTo: organizationId)
          .orderBy('timestamp', descending: true)
          .limit(500) // Get more to filter
          .get();

      final logs = snapshot.docs.map((doc) {
        return AuditLog.fromJson({
          'id': doc.id,
          ...doc.data(),
        });
      }).toList();

      // Filter by search query
      final query = searchQuery.toLowerCase();
      final filtered = logs.where((log) {
        return log.actionDescription.toLowerCase().contains(query) ||
               log.userEmail.toLowerCase().contains(query) ||
               log.action.toString().toLowerCase().contains(query);
      }).take(limit).toList();

      return filtered;
    } catch (e) {
      throw BusinessException(message: 'Failed to search audit logs: $e');
    }
  }

  // Get audit statistics
  Future<Map<String, dynamic>> getAuditStats({
    required String organizationId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('organizationId', isEqualTo: organizationId)
          .where('timestamp', isGreaterThanOrEqualTo: startDate.toIso8601String())
          .where('timestamp', isLessThanOrEqualTo: endDate.toIso8601String())
          .get();

      final logs = snapshot.docs.map((doc) {
        return AuditLog.fromJson({
          'id': doc.id,
          ...doc.data(),
        });
      }).toList();

      // Calculate statistics
      final actionCounts = <String, int>{};
      final userCounts = <String, int>{};
      
      for (final log in logs) {
        final actionName = log.action.toString().split('.').last;
        actionCounts[actionName] = (actionCounts[actionName] ?? 0) + 1;
        userCounts[log.userEmail] = (userCounts[log.userEmail] ?? 0) + 1;
      }

      return {
        'totalEvents': logs.length,
        'uniqueUsers': userCounts.length,
        'actionCounts': actionCounts,
        'topUsers': userCounts.entries
            .toList()
            ..sort((a, b) => b.value.compareTo(a.value))
            ..take(10),
        'recentEvents': logs.take(10).map((log) => log.toJson()).toList(),
      };
    } catch (e) {
      throw BusinessException(message: 'Failed to get audit statistics: $e');
    }
  }

  // Helper methods
  Future<String> _getDeviceId() async {
    try {
      if (kIsWeb) {
        final webInfo = await _deviceInfo.webBrowserInfo;
        return '${webInfo.vendor}-${webInfo.userAgent?.hashCode}';
      } else if (defaultTargetPlatform == TargetPlatform.android) {
        final androidInfo = await _deviceInfo.androidInfo;
        return androidInfo.id;
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        final iosInfo = await _deviceInfo.iosInfo;
        return iosInfo.identifierForVendor ?? 'unknown';
      }
      return 'unknown';
    } catch (e) {
      return 'unknown';
    }
  }

  Future<String> _getIpAddress() async {
    // In a real app, you would get this from the server
    return '0.0.0.0';
  }

  Future<String> _getUserAgent() async {
    try {
      if (kIsWeb) {
        final webInfo = await _deviceInfo.webBrowserInfo;
        return webInfo.userAgent ?? 'unknown';
      }
      return '${defaultTargetPlatform.toString()} App';
    } catch (e) {
      return 'unknown';
    }
  }

  // Convenience methods for common audit actions
  Future<void> logLogin({
    required String organizationId,
    required String userId,
    required String userEmail,
  }) async {
    await logEvent(
      organizationId: organizationId,
      userId: userId,
      userEmail: userEmail,
      action: AuditAction.login,
      actionDescription: 'User logged in',
    );
  }

  Future<void> logDataExport({
    required String organizationId,
    required String userId,
    required String userEmail,
    required String exportType,
    required int recordCount,
  }) async {
    await logEvent(
      organizationId: organizationId,
      userId: userId,
      userEmail: userEmail,
      action: AuditAction.dataExport,
      actionDescription: 'Exported $recordCount $exportType records',
      metadata: {
        'exportType': exportType,
        'recordCount': recordCount,
      },
    );
  }

  Future<void> logSettingsChange({
    required String organizationId,
    required String userId,
    required String userEmail,
    required String settingName,
    required dynamic oldValue,
    required dynamic newValue,
  }) async {
    await logEvent(
      organizationId: organizationId,
      userId: userId,
      userEmail: userEmail,
      action: AuditAction.settingsChange,
      actionDescription: 'Changed $settingName setting',
      metadata: {
        'settingName': settingName,
        'oldValue': oldValue,
        'newValue': newValue,
      },
    );
  }
}