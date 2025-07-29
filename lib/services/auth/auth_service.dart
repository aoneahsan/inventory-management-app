import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/organization.dart';
import '../../core/errors/exceptions.dart';
import '../database/database.dart';

class AuthService {
  final fb.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final FlutterSecureStorage _secureStorage;
  final AppDatabase _database;

  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'current_user';
  
  final StreamController<User?> _userController = StreamController<User?>.broadcast();
  User? _currentUser;
  Organization? _currentOrganization;

  AuthService({
    fb.FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
    FlutterSecureStorage? secureStorage,
    AppDatabase? database,
  })  : _firebaseAuth = firebaseAuth ?? fb.FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _secureStorage = secureStorage ?? const FlutterSecureStorage(),
        _database = database ?? AppDatabase.instance {
    _initAuthListener();
  }

  Stream<User?> get userStream => _userController.stream;
  User? get currentUser => _currentUser;
  Organization? get currentOrganization => _currentOrganization;
  bool get isAuthenticated => _currentUser != null;

  void _initAuthListener() {
    _firebaseAuth.authStateChanges().listen((fbUser) async {
      if (fbUser != null) {
        await _loadUserData(fbUser.uid);
      } else {
        await _clearUserData();
      }
    });
  }

  Future<void> _loadUserData(String userId) async {
    try {
      // Load from Firestore
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (!userDoc.exists) {
        throw AuthException(message: 'User data not found');
      }

      final userData = userDoc.data()!;
      _currentUser = User.fromJson({...userData, 'id': userId});
      
      // Save to local database
      await _database.createUser(_currentUser!.toJson());
      
      // Load organization if user has one
      if (_currentUser!.organizationId != null) {
        final orgDoc = await _firestore
            .collection('organizations')
            .doc(_currentUser!.organizationId)
            .get();
        
        if (orgDoc.exists) {
          _currentOrganization = Organization.fromJson({
            ...orgDoc.data()!,
            'id': orgDoc.id,
          });
          await _database.createOrganization(_currentOrganization!.toJson());
        }
      }
      
      _userController.add(_currentUser);
    } catch (e) {
      debugPrint('Error loading user data: $e');
      await _clearUserData();
    }
  }

  Future<void> _clearUserData() async {
    _currentUser = null;
    _currentOrganization = null;
    _userController.add(null);
    await _secureStorage.delete(key: _tokenKey);
    await _secureStorage.delete(key: _userKey);
    await _database.clearAllData();
  }

  Future<User> signIn({required String email, required String password}) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw AuthException(message: 'Sign in failed');
      }

      // User data will be loaded by the auth listener
      await _loadUserData(credential.user!.uid);
      
      if (_currentUser == null) {
        throw AuthException(message: 'Failed to load user data');
      }

      return _currentUser!;
    } on fb.FirebaseAuthException catch (e) {
      throw AuthException(message: _getAuthErrorMessage(e.code));
    } catch (e) {
      throw AuthException(message: 'Sign in failed: $e');
    }
  }

  Future<User> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // Create Firebase Auth user
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw AuthException(message: 'Registration failed');
      }

      // Update display name
      await credential.user!.updateDisplayName(name);

      // Create user document in Firestore
      final now = DateTime.now();
      final userData = {
        'email': email,
        'name': name,
        'role': UserRole.viewer.name,
        'organization_id': null,
        'permissions': <String>[],
        'photo_url': null,
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      };

      await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .set(userData);

      // Load the created user
      await _loadUserData(credential.user!.uid);
      
      if (_currentUser == null) {
        throw AuthException(message: 'Failed to load user data');
      }

      return _currentUser!;
    } on fb.FirebaseAuthException catch (e) {
      throw AuthException(message: _getAuthErrorMessage(e.code));
    } catch (e) {
      throw AuthException(message: 'Registration failed: $e');
    }
  }

  Future<Organization> createOrganization({
    required String name,
    Map<String, dynamic>? settings,
  }) async {
    if (_currentUser == null) {
      throw AuthException(message: 'User not authenticated');
    }

    if (_currentUser!.organizationId != null) {
      throw BusinessException(message: 'User already belongs to an organization');
    }

    try {
      final now = DateTime.now();
      final organizationData = {
        'name': name,
        'owner_id': _currentUser!.id,
        'subscription_tier': SubscriptionTier.free.name,
        'subscription_status': SubscriptionStatus.active.name,
        'member_count': 1,
        'settings': settings ?? {},
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      };

      // Create organization in Firestore
      final orgRef = await _firestore
          .collection('organizations')
          .add(organizationData);

      // Update user with organization ID and owner role
      await _firestore.collection('users').doc(_currentUser!.id).update({
        'organization_id': orgRef.id,
        'role': UserRole.organizationOwner.name,
        'updated_at': now.toIso8601String(),
      });

      // Reload user data
      await _loadUserData(_currentUser!.id);

      if (_currentOrganization == null) {
        throw AuthException(message: 'Failed to load organization data');
      }

      return _currentOrganization!;
    } catch (e) {
      throw AuthException(message: 'Failed to create organization: $e');
    }
  }

  Future<void> joinOrganization(String inviteCode) async {
    if (_currentUser == null) {
      throw AuthException(message: 'User not authenticated');
    }

    if (_currentUser!.organizationId != null) {
      throw BusinessException(message: 'User already belongs to an organization');
    }

    try {
      // Query for organization with invite code
      final inviteQuery = await _firestore
          .collection('invites')
          .where('code', isEqualTo: inviteCode)
          .where('is_active', isEqualTo: true)
          .limit(1)
          .get();

      if (inviteQuery.docs.isEmpty) {
        throw BusinessException(message: 'Invalid or expired invite code');
      }

      final invite = inviteQuery.docs.first;
      final organizationId = invite.data()['organization_id'] as String;
      final role = invite.data()['role'] as String;

      // Check organization exists and is active
      final orgDoc = await _firestore
          .collection('organizations')
          .doc(organizationId)
          .get();

      if (!orgDoc.exists) {
        throw BusinessException(message: 'Organization not found');
      }

      final org = Organization.fromJson({...orgDoc.data()!, 'id': orgDoc.id});
      
      if (!org.isActive) {
        throw BusinessException(message: 'Organization is not active');
      }

      if (org.memberCount >= org.maxMembers) {
        throw BusinessException(message: 'Organization has reached maximum member limit');
      }

      // Update user with organization
      final now = DateTime.now();
      await _firestore.collection('users').doc(_currentUser!.id).update({
        'organization_id': organizationId,
        'role': role,
        'updated_at': now.toIso8601String(),
      });

      // Increment organization member count
      await _firestore.collection('organizations').doc(organizationId).update({
        'member_count': FieldValue.increment(1),
        'updated_at': now.toIso8601String(),
      });

      // Deactivate invite if single use
      if (invite.data()['single_use'] == true) {
        await invite.reference.update({'is_active': false});
      }

      // Reload user data
      await _loadUserData(_currentUser!.id);
    } catch (e) {
      if (e is BusinessException) rethrow;
      throw AuthException(message: 'Failed to join organization: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _clearUserData();
    } catch (e) {
      throw AuthException(message: 'Sign out failed: $e');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on fb.FirebaseAuthException catch (e) {
      throw AuthException(message: _getAuthErrorMessage(e.code));
    } catch (e) {
      throw AuthException(message: 'Password reset failed: $e');
    }
  }

  Future<void> updateProfile({
    String? name,
    String? photoUrl,
  }) async {
    if (_currentUser == null) {
      throw AuthException(message: 'User not authenticated');
    }

    try {
      final updates = <String, dynamic>{
        'updated_at': DateTime.now().toIso8601String(),
      };

      if (name != null) {
        updates['name'] = name;
        await _firebaseAuth.currentUser?.updateDisplayName(name);
      }

      if (photoUrl != null) {
        updates['photo_url'] = photoUrl;
        await _firebaseAuth.currentUser?.updatePhotoURL(photoUrl);
      }

      await _firestore
          .collection('users')
          .doc(_currentUser!.id)
          .update(updates);

      // Reload user data
      await _loadUserData(_currentUser!.id);
    } catch (e) {
      throw AuthException(message: 'Failed to update profile: $e');
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = _firebaseAuth.currentUser;
    if (user == null || user.email == null) {
      throw AuthException(message: 'User not authenticated');
    }

    try {
      // Re-authenticate user
      final credential = fb.EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);

      // Update password
      await user.updatePassword(newPassword);
    } on fb.FirebaseAuthException catch (e) {
      throw AuthException(message: _getAuthErrorMessage(e.code));
    } catch (e) {
      throw AuthException(message: 'Failed to change password: $e');
    }
  }

  Future<void> deleteAccount(String password) async {
    final user = _firebaseAuth.currentUser;
    if (user == null || user.email == null) {
      throw AuthException(message: 'User not authenticated');
    }

    try {
      // Re-authenticate user
      final credential = fb.EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);

      // Delete user data from Firestore
      await _firestore.collection('users').doc(user.uid).delete();

      // Delete Firebase Auth account
      await user.delete();

      // Clear local data
      await _clearUserData();
    } on fb.FirebaseAuthException catch (e) {
      throw AuthException(message: _getAuthErrorMessage(e.code));
    } catch (e) {
      throw AuthException(message: 'Failed to delete account: $e');
    }
  }

  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found with this email address';
      case 'wrong-password':
        return 'Invalid password';
      case 'email-already-in-use':
        return 'Email address is already registered';
      case 'invalid-email':
        return 'Invalid email address';
      case 'weak-password':
        return 'Password is too weak';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later';
      case 'network-request-failed':
        return 'Network error. Please check your connection';
      default:
        return 'Authentication failed. Please try again';
    }
  }

  // System Admin methods
  Future<List<User>> getAllUsers() async {
    try {
      final users = await _database.getAllUsers();
      return users.map((u) => User.fromJson(u)).toList();
    } catch (e) {
      throw AuthException(message: 'Failed to load all users: $e');
    }
  }

  Future<void> createSystemUser({
    required String email,
    required String name,
    required UserRole role,
    String? organizationId,
  }) async {
    try {
      // This would typically create a user in Firebase Auth
      // For now, we'll create a placeholder user in the database
      final userId = DateTime.now().millisecondsSinceEpoch.toString();
      final now = DateTime.now();
      
      final userData = {
        'id': userId,
        'email': email,
        'name': name,
        'role': role.name,
        'organization_id': organizationId,
        'permissions': <String>[],
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      };

      await _database.createUser(userData);
    } catch (e) {
      throw AuthException(message: 'Failed to create user: $e');
    }
  }

  Future<void> deleteSystemUser(String userId) async {
    try {
      await _database.deleteUser(userId);
    } catch (e) {
      throw AuthException(message: 'Failed to delete user: $e');
    }
  }

  void dispose() {
    _userController.close();
  }
}