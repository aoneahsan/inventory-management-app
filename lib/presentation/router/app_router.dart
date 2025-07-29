import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/organization.dart';
import '../pages/auth/login_page.dart';
import '../pages/auth/register_page.dart';
import '../pages/auth/forgot_password_page.dart';
import '../pages/organization/organization_setup_page.dart';
import '../pages/organization/organization_settings_page.dart';
import '../pages/subscription/subscription_page.dart';
import '../pages/inventory/product_details_page.dart';
import '../pages/inventory/product_form_page.dart';
import '../pages/home/home_page.dart';
import '../pages/splash/splash_page.dart';
import '../pages/onboarding/onboarding_page.dart';
import '../pages/onboarding/feature_tour_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String organizationSetup = '/organization/setup';
  static const String organizationSettings = '/organization/settings';
  static const String subscription = '/subscription';
  static const String home = '/home';
  static const String onboarding = '/onboarding';
  static const String featureTour = '/feature-tour';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: register,
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: forgotPassword,
        name: 'forgotPassword',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: organizationSetup,
        name: 'organizationSetup',
        builder: (context, state) => const OrganizationSetupPage(),
      ),
      GoRoute(
        path: organizationSettings,
        name: 'organizationSettings',
        builder: (context, state) => const OrganizationSettingsPage(),
      ),
      GoRoute(
        path: subscription,
        name: 'subscription',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return SubscriptionPage(
            targetTier: extra?['targetTier'] as SubscriptionTier?,
          );
        },
      ),
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: featureTour,
        name: 'featureTour',
        builder: (context, state) => const FeatureTourPage(),
      ),
      GoRoute(
        path: '/products/new',
        name: 'createProduct',
        builder: (context, state) => const ProductFormPage(),
      ),
      GoRoute(
        path: '/products/:id',
        name: 'productDetails',
        builder: (context, state) {
          final productId = state.pathParameters['id']!;
          return ProductDetailsPage(productId: productId);
        },
      ),
      GoRoute(
        path: '/products/:id/edit',
        name: 'editProduct',
        builder: (context, state) {
          final productId = state.pathParameters['id']!;
          return ProductFormPage(productId: productId);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(
          'Page not found: ${state.uri.path}',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    ),
  );
}