import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/onboarding/onboarding_service.dart';
import '../../router/app_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    // Simulate loading time
    await Future.delayed(const Duration(seconds: 2));
    
    // Check if onboarding has been completed
    final isOnboardingCompleted = await OnboardingService.isOnboardingCompleted();
    
    if (mounted) {
      if (!isOnboardingCompleted) {
        // Show onboarding for new users
        context.go(AppRouter.onboarding);
      } else {
        // TODO: Check authentication status here
        // For now, navigate to login for existing users
        context.go(AppRouter.login);
      }
    }
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