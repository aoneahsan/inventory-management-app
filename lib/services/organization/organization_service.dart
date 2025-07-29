import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/organization.dart';
import '../../core/errors/exceptions.dart';
import '../database/database.dart';

class OrganizationService {
  final FirebaseFirestore _firestore;
  final AppDatabase _database;

  OrganizationService({
    FirebaseFirestore? firestore,
    AppDatabase? database,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _database = database ?? AppDatabase.instance;

  Future<List<User>> getOrganizationMembers(String organizationId) async {
    try {
      final query = await _firestore
          .collection('users')
          .where('organization_id', isEqualTo: organizationId)
          .get();

      return query.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return User.fromJson(data);
      }).toList();
    } catch (e) {
      throw BusinessException(message: 'Failed to get organization members: $e');
    }
  }

  Future<void> updateMemberRole({
    required String userId,
    required UserRole newRole,
    required String updatedBy,
  }) async {
    try {
      // Check permissions
      final updaterDoc = await _firestore.collection('users').doc(updatedBy).get();
      if (!updaterDoc.exists) {
        throw BusinessException(message: 'Updater not found');
      }

      final updater = User.fromJson({...updaterDoc.data()!, 'id': updatedBy});
      if (!updater.isOrganizationOwner && !updater.hasPermission('manage_members')) {
        throw BusinessException(message: 'Insufficient permissions to update member roles');
      }

      // Update role
      await _firestore.collection('users').doc(userId).update({
        'role': newRole.name,
        'updated_at': DateTime.now().toIso8601String(),
      });

      // Update local database
      await _database.updateUser(userId, {'role': newRole.name});
    } catch (e) {
      if (e is BusinessException) rethrow;
      throw BusinessException(message: 'Failed to update member role: $e');
    }
  }

  Future<void> removeMember({
    required String userId,
    required String organizationId,
    required String removedBy,
  }) async {
    try {
      // Check permissions
      final removerDoc = await _firestore.collection('users').doc(removedBy).get();
      if (!removerDoc.exists) {
        throw BusinessException(message: 'Remover not found');
      }

      final remover = User.fromJson({...removerDoc.data()!, 'id': removedBy});
      if (!remover.isOrganizationOwner && !remover.hasPermission('manage_members')) {
        throw BusinessException(message: 'Insufficient permissions to remove members');
      }

      // Cannot remove organization owner
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        final user = User.fromJson({...userDoc.data()!, 'id': userId});
        if (user.isOrganizationOwner) {
          throw BusinessException(message: 'Cannot remove organization owner');
        }
      }

      // Remove from organization
      await _firestore.collection('users').doc(userId).update({
        'organization_id': null,
        'role': UserRole.viewer.name,
        'permissions': [],
        'updated_at': DateTime.now().toIso8601String(),
      });

      // Update organization member count
      await _firestore.collection('organizations').doc(organizationId).update({
        'member_count': FieldValue.increment(-1),
        'updated_at': DateTime.now().toIso8601String(),
      });

      // Update local database
      await _database.updateUser(userId, {
        'organization_id': null,
        'role': UserRole.viewer.name,
        'permissions': [],
      });
    } catch (e) {
      if (e is BusinessException) rethrow;
      throw BusinessException(message: 'Failed to remove member: $e');
    }
  }

  Future<void> updateOrganizationSettings({
    required String organizationId,
    required Map<String, dynamic> settings,
    required String updatedBy,
  }) async {
    try {
      // Check permissions
      final updaterDoc = await _firestore.collection('users').doc(updatedBy).get();
      if (!updaterDoc.exists) {
        throw BusinessException(message: 'Updater not found');
      }

      final updater = User.fromJson({...updaterDoc.data()!, 'id': updatedBy});
      if (!updater.isOrganizationOwner && !updater.hasPermission('manage_settings')) {
        throw BusinessException(message: 'Insufficient permissions to update settings');
      }

      // Update settings
      await _firestore.collection('organizations').doc(organizationId).update({
        'settings': settings,
        'updated_at': DateTime.now().toIso8601String(),
      });

      // Update local database
      await _database.getOrganization(organizationId).then((org) async {
        if (org != null) {
          org['settings'] = settings;
          await _database.createOrganization(org); // This will update existing
        }
      });
    } catch (e) {
      if (e is BusinessException) rethrow;
      throw BusinessException(message: 'Failed to update organization settings: $e');
    }
  }

  Future<Map<String, dynamic>> getOrganizationStats(String organizationId) async {
    try {
      // Get from local database first for offline support
      final stats = await _database.getDashboardStats(organizationId);
      
      // Get member count from Firestore
      final memberQuery = await _firestore
          .collection('users')
          .where('organization_id', isEqualTo: organizationId)
          .count()
          .get();
      
      stats['member_count'] = memberQuery.count;
      
      return stats;
    } catch (e) {
      // Fallback to local data if Firestore fails
      return await _database.getDashboardStats(organizationId);
    }
  }

  Future<void> transferOwnership({
    required String organizationId,
    required String newOwnerId,
    required String currentOwnerId,
  }) async {
    try {
      // Verify current owner
      final currentOwnerDoc = await _firestore.collection('users').doc(currentOwnerId).get();
      if (!currentOwnerDoc.exists) {
        throw BusinessException(message: 'Current owner not found');
      }

      final currentOwner = User.fromJson({...currentOwnerDoc.data()!, 'id': currentOwnerId});
      if (!currentOwner.isOrganizationOwner || currentOwner.organizationId != organizationId) {
        throw BusinessException(message: 'Only the current owner can transfer ownership');
      }

      // Update organization owner
      await _firestore.collection('organizations').doc(organizationId).update({
        'owner_id': newOwnerId,
        'updated_at': DateTime.now().toIso8601String(),
      });

      // Update user roles
      await Future.wait([
        // New owner becomes organization owner
        _firestore.collection('users').doc(newOwnerId).update({
          'role': UserRole.organizationOwner.name,
          'updated_at': DateTime.now().toIso8601String(),
        }),
        // Previous owner becomes admin
        _firestore.collection('users').doc(currentOwnerId).update({
          'role': UserRole.admin.name,
          'updated_at': DateTime.now().toIso8601String(),
        }),
      ]);

      // Update local database
      await Future.wait([
        _database.updateUser(newOwnerId, {'role': UserRole.organizationOwner.name}),
        _database.updateUser(currentOwnerId, {'role': UserRole.admin.name}),
      ]);
    } catch (e) {
      if (e is BusinessException) rethrow;
      throw BusinessException(message: 'Failed to transfer ownership: $e');
    }
  }

  // System Admin methods
  Future<List<Organization>> getAllOrganizations() async {
    try {
      final organizations = await _database.getAllOrganizations();
      return organizations.map((o) => Organization.fromJson(o)).toList();
    } catch (e) {
      throw BusinessException(message: 'Failed to load all organizations: $e');
    }
  }

  Future<Map<String, dynamic>> getSystemStats() async {
    try {
      final organizations = await getAllOrganizations();
      final totalOrgs = organizations.length;
      final activeOrgs = organizations.where((o) => o.isActive).length;
      
      // Get total users count from all organizations
      int totalUsers = 0;
      int totalProducts = 0;
      
      for (final org in organizations) {
        final users = await _database.getUsers(org.id);
        totalUsers += users.length;
        
        final products = await _database.getProducts(org.id);
        totalProducts += products.length;
      }

      return {
        'total_organizations': totalOrgs,
        'active_organizations': activeOrgs,
        'total_users': totalUsers,
        'total_products': totalProducts,
        'recent_activities': [
          {
            'type': 'organization_created',
            'description': 'New organization created',
            'timestamp': DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
          },
          {
            'type': 'user_created',
            'description': 'New user registered',
            'timestamp': DateTime.now().subtract(const Duration(hours: 5)).toIso8601String(),
          },
        ],
      };
    } catch (e) {
      throw BusinessException(message: 'Failed to get system stats: $e');
    }
  }

  Future<void> createSystemOrganization({
    required String name,
    String? description,
    required String ownerId,
  }) async {
    try {
      final now = DateTime.now();
      final organizationData = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'name': name,
        'description': description,
        'owner_id': ownerId,
        'subscription_tier': SubscriptionTier.free.name,
        'member_count': 1,
        'is_active': true,
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      };

      await _database.createOrganization(organizationData);
    } catch (e) {
      throw BusinessException(message: 'Failed to create organization: $e');
    }
  }

  Future<void> deleteSystemOrganization(String organizationId) async {
    try {
      // Check if organization has users
      final users = await _database.getUsers(organizationId);
      if (users.isNotEmpty) {
        throw BusinessException(message: 'Cannot delete organization with users. Please transfer or remove users first.');
      }

      await _database.deleteOrganization(organizationId);
    } catch (e) {
      if (e is BusinessException) rethrow;
      throw BusinessException(message: 'Failed to delete organization: $e');
    }
  }
}