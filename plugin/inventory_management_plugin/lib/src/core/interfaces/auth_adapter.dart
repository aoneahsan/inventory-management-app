abstract class AuthAdapter {
  // Authentication state
  Stream<AuthUser?> get authStateChanges;
  AuthUser? get currentUser;
  bool get isAuthenticated;
  
  // Sign in methods
  Future<AuthResult> signInWithEmailPassword(String email, String password);
  Future<AuthResult> signInWithGoogle();
  Future<AuthResult> signInWithApple();
  Future<AuthResult> signInWithMicrosoft();
  Future<AuthResult> signInWithCustomToken(String token);
  Future<AuthResult> signInAnonymously();
  
  // Sign up
  Future<AuthResult> signUpWithEmailPassword({
    required String email,
    required String password,
    Map<String, dynamic>? additionalData,
  });
  
  // Sign out
  Future<void> signOut();
  
  // Password management
  Future<void> sendPasswordResetEmail(String email);
  Future<void> confirmPasswordReset(String code, String newPassword);
  Future<void> updatePassword(String newPassword);
  
  // Email verification
  Future<void> sendEmailVerification();
  Future<void> verifyEmail(String code);
  
  // User management
  Future<void> updateProfile({
    String? displayName,
    String? photoUrl,
    Map<String, dynamic>? customData,
  });
  Future<void> deleteAccount();
  
  // Token management
  Future<String?> getIdToken([bool forceRefresh = false]);
  Future<Map<String, dynamic>?> getCustomClaims();
  
  // Multi-factor authentication
  Future<void> enableMFA();
  Future<void> disableMFA();
  Future<bool> isMFAEnabled();
  Future<void> verifyMFA(String code);
}

class AuthUser {
  final String id;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final bool emailVerified;
  final bool isAnonymous;
  final DateTime? createdAt;
  final DateTime? lastSignInAt;
  final Map<String, dynamic>? customClaims;
  final Map<String, dynamic>? metadata;

  const AuthUser({
    required this.id,
    this.email,
    this.displayName,
    this.photoUrl,
    this.emailVerified = false,
    this.isAnonymous = false,
    this.createdAt,
    this.lastSignInAt,
    this.customClaims,
    this.metadata,
  });

  AuthUser copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    bool? emailVerified,
    bool? isAnonymous,
    DateTime? createdAt,
    DateTime? lastSignInAt,
    Map<String, dynamic>? customClaims,
    Map<String, dynamic>? metadata,
  }) {
    return AuthUser(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      emailVerified: emailVerified ?? this.emailVerified,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      createdAt: createdAt ?? this.createdAt,
      lastSignInAt: lastSignInAt ?? this.lastSignInAt,
      customClaims: customClaims ?? this.customClaims,
      metadata: metadata ?? this.metadata,
    );
  }
}

class AuthResult {
  final AuthUser? user;
  final String? error;
  final AuthResultStatus status;
  final Map<String, dynamic>? additionalData;

  const AuthResult({
    this.user,
    this.error,
    required this.status,
    this.additionalData,
  });

  bool get isSuccess => status == AuthResultStatus.success;
  bool get isError => status != AuthResultStatus.success;
}

enum AuthResultStatus {
  success,
  error,
  emailNotVerified,
  mfaRequired,
  accountDisabled,
  userNotFound,
  wrongPassword,
  emailAlreadyInUse,
  weakPassword,
  networkError,
  cancelled,
  unknown,
}