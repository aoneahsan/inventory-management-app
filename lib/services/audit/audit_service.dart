import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/audit_log.dart';
import '../../domain/entities/user.dart';

class AuditService {
  final _firestore = FirebaseFirestore.instance;
  
  Future<void> logAction({
    required User user,
    required String action,
    required String entityType,
    String? entityId,
    Map<String, dynamic>? oldData,
    Map<String, dynamic>? newData,
  }) async {
    try {
      final log = AuditLog(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: user.id,
        userName: user.name,
        organizationId: user.organizationId ?? '',
        action: action,
        entityType: entityType,
        entityId: entityId,
        oldData: oldData,
        newData: newData,
        timestamp: DateTime.now(),
      );

      await _firestore
          .collection('audit_logs')
          .doc(log.id)
          .set(log.toJson());
    } catch (e) {
      // Don't throw - audit logging should not break operations
      // Failed to log audit: $e
    }
  }

  Future<List<AuditLog>> getAuditLogs({
    required String organizationId,
    String? userId,
    String? entityType,
    String? action,
    DateTime? startDate,
    DateTime? endDate,
    int limit = 100,
  }) async {
    try {
      Query query = _firestore
          .collection('audit_logs')
          .where('organization_id', isEqualTo: organizationId);

      if (userId != null) {
        query = query.where('user_id', isEqualTo: userId);
      }
      if (entityType != null) {
        query = query.where('entity_type', isEqualTo: entityType);
      }
      if (action != null) {
        query = query.where('action', isEqualTo: action);
      }
      if (startDate != null) {
        query = query.where('timestamp', isGreaterThanOrEqualTo: startDate.toIso8601String());
      }
      if (endDate != null) {
        query = query.where('timestamp', isLessThanOrEqualTo: endDate.toIso8601String());
      }

      query = query.orderBy('timestamp', descending: true).limit(limit);

      final snapshot = await query.get();
      return snapshot.docs
          .map((doc) => AuditLog.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // Failed to get audit logs: $e
      return [];
    }
  }

  Stream<List<AuditLog>> streamAuditLogs({
    required String organizationId,
    int limit = 50,
  }) {
    return _firestore
        .collection('audit_logs')
        .where('organization_id', isEqualTo: organizationId)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AuditLog.fromJson(doc.data()))
            .toList());
  }
}