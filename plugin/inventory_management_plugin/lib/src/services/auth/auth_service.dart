import 'dart:async';
import '../../core/interfaces/simple_auth_adapter.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/organization.dart';
import '../database/database_service.dart';

class AuthService {
  final AuthAdapter adapter;
  final _authStateController = StreamController<AuthState>.broadcast();
  
  User? _currentUser;
  Organization? _currentOrganization;
  Timer? _sessionTimer;
  
  AuthService({required this.adapter});
  
  // Getters
  User? get currentUser => _currentUser;
  Organization? get currentOrganization => _currentOrganization;
  bool get isAuthenticated => _currentUser != null;
  Stream<AuthState> get authState => _authStateController.stream;
  
  Future<void> initialize() async {
    // Check if user has existing session
    final hasSession = await adapter.hasValidSession();
    if (hasSession) {
      final user = await adapter.getCurrentUser();
      if (user != null) {
        _currentUser = User.fromJson(user);
        _authStateController.add(AuthState.authenticated(_currentUser!));
        _startSessionTimer();
        
        // Load organization if user has one
        if (_currentUser!.organizationId != null) {
          await _loadOrganization(_currentUser!.organizationId!);
        }
      }
    } else {
      _authStateController.add(AuthState.unauthenticated());
    }
  }
  
  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await adapter.signInWithEmail(email, password);
      
      if (result['success'] == true && result['user'] != null) {
        _currentUser = User.fromJson(result['user']);
        _authStateController.add(AuthState.authenticated(_currentUser!));
        _startSessionTimer();
        
        // Load organization if user has one
        if (_currentUser!.organizationId != null) {
          await _loadOrganization(_currentUser!.organizationId!);
        }
        
        return AuthResult.success(user: _currentUser!);
      } else {
        return AuthResult.failure(
          message: result['message'] ?? 'Invalid credentials',
        );
      }
    } catch (e) {
      return AuthResult.failure(message: e.toString());
    }
  }
  
  Future<AuthResult> signUp({
    required String email,
    required String password,
    required String name,
    String? organizationName,
  }) async {
    try {
      final result = await adapter.signUpWithEmail(
        email,
        password,
        additionalData: {
          'name': name,
          'organizationName': organizationName,
        },
      );
      
      if (result['success'] == true && result['user'] != null) {
        _currentUser = User.fromJson(result['user']);
        _authStateController.add(AuthState.authenticated(_currentUser!));
        _startSessionTimer();
        
        // Create organization if name provided
        if (organizationName != null && result['organization'] != null) {
          _currentOrganization = Organization.fromJson(result['organization']);
        }
        
        return AuthResult.success(user: _currentUser!);
      } else {
        return AuthResult.failure(
          message: result['message'] ?? 'Failed to create account',
        );
      }
    } catch (e) {
      return AuthResult.failure(message: e.toString());
    }
  }
  
  Future<AuthResult> signInWithProvider(String provider) async {
    try {
      final result = await adapter.signInWithProvider(provider);
      
      if (result['success'] == true && result['user'] != null) {
        _currentUser = User.fromJson(result['user']);
        _authStateController.add(AuthState.authenticated(_currentUser!));
        _startSessionTimer();
        
        // Load organization if user has one
        if (_currentUser!.organizationId != null) {
          await _loadOrganization(_currentUser!.organizationId!);
        }
        
        return AuthResult.success(user: _currentUser!);
      } else {
        return AuthResult.failure(
          message: result['message'] ?? 'Failed to sign in with provider',
        );
      }
    } catch (e) {
      return AuthResult.failure(message: e.toString());
    }
  }
  
  Future<void> signOut() async {
    try {
      await adapter.signOut();
    } finally {
      _currentUser = null;
      _currentOrganization = null;
      _sessionTimer?.cancel();
      _authStateController.add(AuthState.unauthenticated());
    }
  }
  
  Future<AuthResult> resetPassword(String email) async {
    try {
      final result = await adapter.resetPassword(email);
      
      if (result['success'] == true) {
        return AuthResult.success(
          message: result['message'] ?? 'Password reset email sent',
        );
      } else {
        return AuthResult.failure(
          message: result['message'] ?? 'Failed to send reset email',
        );
      }
    } catch (e) {
      return AuthResult.failure(message: e.toString());
    }
  }
  
  Future<AuthResult> updateProfile({
    String? name,
    String? email,
    String? photoUrl,
  }) async {
    if (!isAuthenticated) {
      return AuthResult.failure(message: 'Not authenticated');
    }
    
    try {
      final updates = <String, dynamic>{};
      if (name != null) updates['name'] = name;
      if (email != null) updates['email'] = email;
      if (photoUrl != null) updates['photoUrl'] = photoUrl;
      
      final result = await adapter.updateUser(updates);
      
      if (result['success'] == true && result['user'] != null) {
        _currentUser = User.fromJson(result['user']);
        _authStateController.add(AuthState.authenticated(_currentUser!));
        return AuthResult.success(user: _currentUser!);
      } else {
        return AuthResult.failure(
          message: result['message'] ?? 'Failed to update profile',
        );
      }
    } catch (e) {
      return AuthResult.failure(message: e.toString());
    }
  }
  
  Future<AuthResult> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (!isAuthenticated) {
      return AuthResult.failure(message: 'Not authenticated');
    }
    
    try {
      final result = await adapter.changePassword(currentPassword, newPassword);
      
      if (result['success'] == true) {
        return AuthResult.success(
          message: result['message'] ?? 'Password changed successfully',
        );
      } else {
        return AuthResult.failure(
          message: result['message'] ?? 'Failed to change password',
        );
      }
    } catch (e) {
      return AuthResult.failure(message: e.toString());
    }
  }
  
  Future<void> refreshSession() async {
    if (!isAuthenticated) return;
    
    try {
      final result = await adapter.refreshSession();
      if (result['success'] == true && result['user'] != null) {
        _currentUser = User.fromJson(result['user']);
        _authStateController.add(AuthState.authenticated(_currentUser!));
      } else {
        await signOut();
      }
    } catch (e) {
      await signOut();
    }
  }
  
  Future<bool> checkPermission(String permission) async {
    if (!isAuthenticated) return false;
    
    // Check user role permissions
    return _currentUser!.hasPermission(permission);
  }
  
  Future<void> _loadOrganization(String organizationId) async {
    // This would typically load from database or API
    // For now, we'll use the adapter if it supports organization data
    final result = await adapter.getOrganization?.call(organizationId);
    if (result != null && result['organization'] != null) {
      _currentOrganization = Organization.fromJson(result['organization']);
    }
  }
  
  void _startSessionTimer() {
    _sessionTimer?.cancel();
    _sessionTimer = Timer.periodic(
      const Duration(minutes: 15),
      (_) => refreshSession(),
    );
  }
  
  void dispose() {
    _sessionTimer?.cancel();
    _authStateController.close();
  }
}

// Auth state classes
abstract class AuthState {
  const AuthState();
  
  factory AuthState.authenticated(User user) = AuthenticatedState;
  factory AuthState.unauthenticated() = UnauthenticatedState;
  factory AuthState.loading() = LoadingState;
}

class AuthenticatedState extends AuthState {
  final User user;
  const AuthenticatedState(this.user);
}

class UnauthenticatedState extends AuthState {
  const UnauthenticatedState();
}

class LoadingState extends AuthState {
  const LoadingState();
}

// Auth result class
class AuthResult {
  final bool success;
  final String? message;
  final User? user;
  
  const AuthResult({
    required this.success,
    this.message,
    this.user,
  });
  
  factory AuthResult.success({String? message, User? user}) {
    return AuthResult(
      success: true,
      message: message,
      user: user,
    );
  }
  
  factory AuthResult.failure({required String message}) {
    return AuthResult(
      success: false,
      message: message,
    );
  }
}