import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/auth/auth_service.dart';
import 'auth_provider.dart';

final currentOrganizationIdProvider = Provider<String?>((ref) {
  final authService = ref.watch(authServiceProvider);
  final user = authService.currentUser;
  return user?.organizationId;
});