import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import 'app_router.dart';

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  bool _isAuth = false;
  bool _hasOrganization = false;

  RouterNotifier(this._ref) {
    _ref.listen(
      currentUserStreamProvider,
      (previous, next) {
        next.when(
          loading: () {},
          error: (error, stack) {
            _isAuth = false;
            _hasOrganization = false;
            notifyListeners();
          },
          data: (user) {
            _isAuth = user != null;
            _hasOrganization = user?.organizationId != null;
            notifyListeners();
          },
        );
      },
    );
  }

  String? redirect(BuildContext context, GoRouterState state) {
    final isLoading = _ref.read(currentUserStreamProvider).isLoading;
    if (isLoading || state.matchedLocation == AppRouter.splash) {
      return null;
    }

    final isSplash = state.matchedLocation == AppRouter.splash;
    final isOnboarding = state.matchedLocation == AppRouter.onboarding;
    final isAuthRoute = _isAuthRoute(state.matchedLocation);
    
    // If we're not authenticated and trying to access protected routes
    if (!_isAuth && !isAuthRoute && !isSplash && !isOnboarding) {
      return AppRouter.login;
    }

    // If we're authenticated but don't have an organization
    if (_isAuth && !_hasOrganization && !_isOrganizationRoute(state.matchedLocation)) {
      if (state.matchedLocation != AppRouter.organizationSetup) {
        return AppRouter.organizationSetup;
      }
    }

    // If we're authenticated and have organization, redirect from auth pages to home
    if (_isAuth && _hasOrganization && isAuthRoute) {
      return AppRouter.home;
    }

    // No redirect needed
    return null;
  }

  bool _isAuthRoute(String location) {
    return location == AppRouter.login ||
           location == AppRouter.register ||
           location == AppRouter.forgotPassword;
  }

  bool _isOrganizationRoute(String location) {
    return location == AppRouter.organizationSetup ||
           location == AppRouter.organizationSettings ||
           location.startsWith('/organization');
  }
}

final routerNotifierProvider = Provider<RouterNotifier>((ref) {
  return RouterNotifier(ref);
});