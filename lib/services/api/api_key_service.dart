import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import '../../core/errors/exceptions.dart';

class ApiKey {
  final String id;
  final String organizationId;
  final String name;
  final String key;
  final bool active;
  final DateTime createdAt;
  final DateTime? expiresAt;
  final DateTime? lastUsedAt;
  final int usageCount;
  final List<String> permissions;

  ApiKey({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.key,
    this.active = true,
    required this.createdAt,
    this.expiresAt,
    this.lastUsedAt,
    this.usageCount = 0,
    this.permissions = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organizationId': organizationId,
      'name': name,
      'key': key,
      'active': active,
      'createdAt': createdAt.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'lastUsedAt': lastUsedAt?.toIso8601String(),
      'usageCount': usageCount,
      'permissions': permissions,
    };
  }

  factory ApiKey.fromJson(Map<String, dynamic> json) {
    return ApiKey(
      id: json['id'],
      organizationId: json['organizationId'],
      name: json['name'],
      key: json['key'],
      active: json['active'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
      expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
      lastUsedAt: json['lastUsedAt'] != null ? DateTime.parse(json['lastUsedAt']) : null,
      usageCount: json['usageCount'] ?? 0,
      permissions: List<String>.from(json['permissions'] ?? []),
    );
  }
}

class ApiKeyService {
  final FirebaseFirestore _firestore;
  static const String _collection = 'apiKeys';

  ApiKeyService({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  // Generate a new API key
  String _generateApiKey() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random.secure();
    final prefix = 'sk_live_'; // Stripe-like format
    final key = List.generate(32, (index) => chars[random.nextInt(chars.length)]).join();
    return '$prefix$key';
  }

  // Create a new API key
  Future<ApiKey> createApiKey({
    required String organizationId,
    required String name,
    DateTime? expiresAt,
    List<String> permissions = const [],
  }) async {
    try {
      final now = DateTime.now();
      final key = _generateApiKey();
      final docRef = _firestore.collection(_collection).doc();

      final apiKey = ApiKey(
        id: docRef.id,
        organizationId: organizationId,
        name: name,
        key: key,
        createdAt: now,
        expiresAt: expiresAt,
        permissions: permissions,
      );

      await docRef.set(apiKey.toJson());
      return apiKey;
    } catch (e) {
      throw BusinessException(message: 'Failed to create API key: $e');
    }
  }

  // Get all API keys for an organization
  Stream<List<ApiKey>> getApiKeys(String organizationId) {
    return _firestore
        .collection(_collection)
        .where('organizationId', isEqualTo: organizationId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ApiKey.fromJson({
          'id': doc.id,
          ...doc.data(),
        });
      }).toList();
    });
  }

  // Revoke an API key
  Future<void> revokeApiKey(String keyId) async {
    try {
      await _firestore.collection(_collection).doc(keyId).update({
        'active': false,
        'revokedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw BusinessException(message: 'Failed to revoke API key: $e');
    }
  }

  // Delete an API key
  Future<void> deleteApiKey(String keyId) async {
    try {
      await _firestore.collection(_collection).doc(keyId).delete();
    } catch (e) {
      throw BusinessException(message: 'Failed to delete API key: $e');
    }
  }

  // Update API key permissions
  Future<void> updateApiKeyPermissions({
    required String keyId,
    required List<String> permissions,
  }) async {
    try {
      await _firestore.collection(_collection).doc(keyId).update({
        'permissions': permissions,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw BusinessException(message: 'Failed to update API key permissions: $e');
    }
  }

  // Get API usage statistics
  Future<Map<String, dynamic>> getApiKeyStats(String keyId) async {
    try {
      final doc = await _firestore.collection(_collection).doc(keyId).get();
      if (!doc.exists) {
        throw BusinessException(message: 'API key not found');
      }

      final data = doc.data()!;
      final now = DateTime.now();
      final createdAt = DateTime.parse(data['createdAt']);
      final lastUsedAt = data['lastUsedAt'] != null 
          ? DateTime.parse(data['lastUsedAt']) 
          : null;

      return {
        'usageCount': data['usageCount'] ?? 0,
        'lastUsedAt': lastUsedAt?.toIso8601String(),
        'daysActive': now.difference(createdAt).inDays,
        'isActive': data['active'] ?? true,
        'isExpired': data['expiresAt'] != null && 
            DateTime.parse(data['expiresAt']).isBefore(now),
      };
    } catch (e) {
      throw BusinessException(message: 'Failed to get API key stats: $e');
    }
  }
}