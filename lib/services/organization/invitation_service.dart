import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user.dart';
import '../../core/errors/exceptions.dart';

class InvitationService {
  final FirebaseFirestore _firestore;
  
  InvitationService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Generate a unique invite code
  String _generateInviteCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(8, (index) => chars[random.nextInt(chars.length)]).join();
  }

  Future<String> createInvitation({
    required String organizationId,
    required UserRole role,
    required String createdBy,
    bool singleUse = true,
    DateTime? expiresAt,
  }) async {
    try {
      final code = _generateInviteCode();
      final now = DateTime.now();
      
      final invitationData = {
        'code': code,
        'organization_id': organizationId,
        'role': role.name,
        'created_by': createdBy,
        'single_use': singleUse,
        'is_active': true,
        'used_count': 0,
        'expires_at': expiresAt?.toIso8601String(),
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      };

      await _firestore.collection('invites').add(invitationData);
      
      return code;
    } catch (e) {
      throw BusinessException(message: 'Failed to create invitation: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getOrganizationInvitations(
    String organizationId,
  ) async {
    try {
      final query = await _firestore
          .collection('invites')
          .where('organization_id', isEqualTo: organizationId)
          .orderBy('created_at', descending: true)
          .get();

      return query.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      throw BusinessException(message: 'Failed to get invitations: $e');
    }
  }

  Future<void> deactivateInvitation(String invitationId) async {
    try {
      await _firestore.collection('invites').doc(invitationId).update({
        'is_active': false,
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw BusinessException(message: 'Failed to deactivate invitation: $e');
    }
  }

  Future<Map<String, dynamic>?> validateInvitation(String code) async {
    try {
      final query = await _firestore
          .collection('invites')
          .where('code', isEqualTo: code)
          .where('is_active', isEqualTo: true)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        return null;
      }

      final invitation = query.docs.first.data();
      invitation['id'] = query.docs.first.id;

      // Check if expired
      if (invitation['expires_at'] != null) {
        final expiresAt = DateTime.parse(invitation['expires_at']);
        if (DateTime.now().isAfter(expiresAt)) {
          return null;
        }
      }

      return invitation;
    } catch (e) {
      throw BusinessException(message: 'Failed to validate invitation: $e');
    }
  }

  Future<void> useInvitation(String invitationId) async {
    try {
      await _firestore.collection('invites').doc(invitationId).update({
        'used_count': FieldValue.increment(1),
        'last_used_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw BusinessException(message: 'Failed to use invitation: $e');
    }
  }
}