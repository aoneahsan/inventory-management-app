import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  static const String _onboardingKey = 'app_onboarding_completed';
  static const String _tourStepsKey = 'tour_steps_completed';
  
  static SharedPreferences? _prefs;
  
  static Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Check if onboarding has been completed
  static Future<bool> isOnboardingCompleted() async {
    await _initPrefs();
    return _prefs!.getBool(_onboardingKey) ?? false;
  }

  // Mark onboarding as completed
  static Future<void> completeOnboarding() async {
    await _initPrefs();
    await _prefs!.setBool(_onboardingKey, true);
  }

  // Reset onboarding (for testing or re-showing)
  static Future<void> resetOnboarding() async {
    await _initPrefs();
    await _prefs!.remove(_onboardingKey);
    await _prefs!.remove(_tourStepsKey);
  }

  // Check if specific tour step has been completed
  static Future<bool> isTourStepCompleted(String stepId) async {
    await _initPrefs();
    final completedSteps = _prefs!.getStringList(_tourStepsKey) ?? [];
    return completedSteps.contains(stepId);
  }

  // Mark tour step as completed
  static Future<void> completeTourStep(String stepId) async {
    await _initPrefs();
    final completedSteps = _prefs!.getStringList(_tourStepsKey) ?? [];
    if (!completedSteps.contains(stepId)) {
      completedSteps.add(stepId);
      await _prefs!.setStringList(_tourStepsKey, completedSteps);
    }
  }

  // Get all completed tour steps
  static Future<List<String>> getCompletedTourSteps() async {
    await _initPrefs();
    return _prefs!.getStringList(_tourStepsKey) ?? [];
  }

  // Get onboarding steps for new users
  static List<OnboardingStep> getOnboardingSteps() {
    return [
      OnboardingStep(
        id: 'welcome',
        title: 'Welcome to Inventory Management',
        description: 'Manage your inventory efficiently with our powerful tools',
        icon: Icons.inventory_2,
        color: Colors.blue,
      ),
      OnboardingStep(
        id: 'organization',
        title: 'Organization Setup',
        description: 'Create or join an organization to start managing inventory',
        icon: Icons.business,
        color: Colors.green,
      ),
      OnboardingStep(
        id: 'products',
        title: 'Product Management',
        description: 'Add, edit, and track your products with detailed information',
        icon: Icons.shopping_bag,
        color: Colors.orange,
      ),
      OnboardingStep(
        id: 'categories',
        title: 'Category Organization',
        description: 'Organize products into categories for better management',
        icon: Icons.category,
        color: Colors.purple,
      ),
      OnboardingStep(
        id: 'analytics',
        title: 'Analytics & Reports',
        description: 'Get insights into your inventory with powerful analytics',
        icon: Icons.analytics,
        color: Colors.teal,
      ),
      OnboardingStep(
        id: 'team',
        title: 'Team Collaboration',
        description: 'Invite team members and manage roles and permissions',
        icon: Icons.people,
        color: Colors.indigo,
      ),
    ];
  }

  // Get feature tour steps for existing users
  static List<TourStep> getFeatureTourSteps() {
    return [
      TourStep(
        id: 'dashboard_overview',
        title: 'Dashboard Overview',
        description: 'View key metrics and recent activities at a glance',
        targetKey: 'dashboard_cards',
        position: TourStepPosition.bottom,
      ),
      TourStep(
        id: 'add_product',
        title: 'Add New Product',
        description: 'Tap here to add new products to your inventory',
        targetKey: 'add_product_button',
        position: TourStepPosition.bottom,
      ),
      TourStep(
        id: 'search_filter',
        title: 'Search & Filter',
        description: 'Use search and filters to find products quickly',
        targetKey: 'search_bar',
        position: TourStepPosition.bottom,
      ),
      TourStep(
        id: 'product_actions',
        title: 'Product Actions',
        description: 'Swipe or tap to edit, delete, or view product details',
        targetKey: 'product_list_item',
        position: TourStepPosition.top,
      ),
      TourStep(
        id: 'organization_settings',
        title: 'Organization Settings',
        description: 'Manage your organization settings and team members',
        targetKey: 'organization_button',
        position: TourStepPosition.bottom,
      ),
      TourStep(
        id: 'analytics_reports',
        title: 'Analytics & Reports',
        description: 'Generate reports and view detailed analytics',
        targetKey: 'analytics_tab',
        position: TourStepPosition.top,
      ),
    ];
  }

  // Show feature highlight for specific element
  static void showFeatureHighlight(
    BuildContext context,
    String stepId,
    String title,
    String description,
    GlobalKey targetKey,
  ) {
    // This would typically use a package like showcaseview
    // For now, we'll show a simple dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              completeTourStep(stepId);
            },
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }
}

class OnboardingStep {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String? imageAsset;

  const OnboardingStep({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    this.imageAsset,
  });
}

class TourStep {
  final String id;
  final String title;
  final String description;
  final String targetKey;
  final TourStepPosition position;
  final Duration delay;

  const TourStep({
    required this.id,
    required this.title,
    required this.description,
    required this.targetKey,
    required this.position,
    this.delay = const Duration(milliseconds: 500),
  });
}

enum TourStepPosition {
  top,
  bottom,
  left,
  right,
  center,
}

// Tour manager for handling feature tours
class TourManager {
  static bool _isTourActive = false;
  static int _currentStepIndex = 0;
  static List<TourStep> _currentTour = [];
  static VoidCallback? _onTourComplete;

  static bool get isTourActive => _isTourActive;

  static Future<void> startTour(
    List<TourStep> steps, {
    VoidCallback? onComplete,
  }) async {
    if (_isTourActive) return;

    _isTourActive = true;
    _currentStepIndex = 0;
    _currentTour = steps;
    _onTourComplete = onComplete;

    await _showNextStep();
  }

  static Future<void> _showNextStep() async {
    if (_currentStepIndex >= _currentTour.length) {
      await _completeTour();
      return;
    }

    final step = _currentTour[_currentStepIndex];
    
    // Mark step as completed
    await OnboardingService.completeTourStep(step.id);
    
    // Wait for delay
    await Future.delayed(step.delay);
    
    _currentStepIndex++;
    await _showNextStep();
  }

  static Future<void> _completeTour() async {
    _isTourActive = false;
    _currentStepIndex = 0;
    _currentTour.clear();
    
    _onTourComplete?.call();
    _onTourComplete = null;
  }

  static void stopTour() {
    _isTourActive = false;
    _currentStepIndex = 0;
    _currentTour.clear();
    _onTourComplete = null;
  }

  static void nextStep() {
    if (_isTourActive && _currentStepIndex < _currentTour.length) {
      _showNextStep();
    }
  }

  static void previousStep() {
    if (_isTourActive && _currentStepIndex > 0) {
      _currentStepIndex -= 2; // Go back two steps, then forward one
      _showNextStep();
    }
  }
}