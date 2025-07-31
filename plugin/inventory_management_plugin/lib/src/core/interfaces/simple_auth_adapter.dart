/// Simplified auth adapter interface for the inventory plugin
abstract class AuthAdapter {
  // Core authentication methods
  Future<Map<String, dynamic>> signInWithEmail(String email, String password);
  Future<Map<String, dynamic>> signUpWithEmail(String email, String password, {Map<String, dynamic>? additionalData});
  Future<Map<String, dynamic>> signInWithProvider(String provider);
  Future<void> signOut();
  
  // Session management
  Future<bool> hasValidSession();
  Future<Map<String, dynamic>?> getCurrentUser();
  Future<Map<String, dynamic>> refreshSession();
  
  // Password management
  Future<Map<String, dynamic>> resetPassword(String email);
  Future<Map<String, dynamic>> changePassword(String currentPassword, String newPassword);
  
  // User management
  Future<Map<String, dynamic>> updateUser(Map<String, dynamic> updates);
  
  // Optional organization support
  Future<Map<String, dynamic>?>? getOrganization;
}