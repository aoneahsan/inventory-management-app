import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../services/onboarding/onboarding_service.dart';
import '../../providers/auth_provider.dart';
import '../../router/app_router.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    // Wait a bit for visual effect
    await Future.delayed(const Duration(seconds: 2));
    
    if (!mounted) return;

    // Check authentication status
    final userAsync = ref.read(currentUserStreamProvider);
    
    userAsync.when(
      loading: () {
        // Wait for auth state to load
        Future.delayed(const Duration(milliseconds: 100), _navigateToNext);
      },
      error: (error, stack) async {
        // Error loading auth state, check onboarding
        final isOnboardingCompleted = await OnboardingService.isOnboardingCompleted();
        if (mounted) {
          if (!isOnboardingCompleted) {
            context.go(AppRouter.onboarding);
          } else {
            context.go(AppRouter.login);
          }
        }
      },
      data: (user) async {
        if (user != null) {
          // User is authenticated
          if (user.organizationId != null) {
            // Has organization, go to home
            if (mounted) context.go(AppRouter.home);
          } else {
            // No organization, go to setup
            if (mounted) context.go(AppRouter.organizationSetup);
          }
        } else {
          // Not authenticated, check onboarding
          final isOnboardingCompleted = await OnboardingService.isOnboardingCompleted();
          if (mounted) {
            if (!isOnboardingCompleted) {
              context.go(AppRouter.onboarding);
            } else {
              context.go(AppRouter.login);
            }
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withValues(alpha: 0.8),
            ],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.inventory_2,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(height: 24),
              Text(
                'Inventory Management',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 32),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}