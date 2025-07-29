import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/auth/auth_service.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/organization.dart';

// Auth service provider
final authServiceProvider = Provider<AuthService>((ref) {
  final authService = AuthService();
  ref.onDispose(() => authService.dispose());
  return authService;
});

// Current user stream provider
final currentUserStreamProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.userStream;
});

// Current user provider
final currentUserProvider = Provider<User?>((ref) {
  final userAsyncValue = ref.watch(currentUserStreamProvider);
  return userAsyncValue.maybeWhen(
    data: (user) => user,
    orElse: () => null,
  );
});

// Current organization provider
final currentOrganizationProvider = Provider<Organization?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.currentOrganization;
});

// Auth state notifier for handling auth operations
class AuthNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(const AsyncValue.data(null));

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncValue.loading();
    try {
      await _authService.signIn(email: email, password: password);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _authService.register(
        email: email,
        password: password,
        name: name,
      );
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    try {
      await _authService.signOut();
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> resetPassword(String email) async {
    state = const AsyncValue.loading();
    try {
      await _authService.resetPassword(email);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

// Auth notifier provider
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<void>>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthNotifier(authService);
});

// Organization notifier for organization operations
class OrganizationNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthService _authService;

  OrganizationNotifier(this._authService) : super(const AsyncValue.data(null));

  Future<void> createOrganization({
    required String name,
    Map<String, dynamic>? settings,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _authService.createOrganization(name: name, settings: settings);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> joinOrganization(String inviteCode) async {
    state = const AsyncValue.loading();
    try {
      await _authService.joinOrganization(inviteCode);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

// Organization notifier provider
final organizationNotifierProvider =
    StateNotifierProvider<OrganizationNotifier, AsyncValue<void>>((ref) {
  final authService = ref.watch(authServiceProvider);
  return OrganizationNotifier(authService);
});

// Helper providers
final isAuthenticatedProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user != null;
});

final hasOrganizationProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.organizationId != null;
});

final isOrganizationOwnerProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.isOrganizationOwner ?? false;
});

final isSystemAdminProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.isSystemAdmin ?? false;
});

// Permission check provider
final hasPermissionProvider = Provider.family<bool, String>((ref, permission) {
  final user = ref.watch(currentUserProvider);
  return user?.hasPermission(permission) ?? false;
});