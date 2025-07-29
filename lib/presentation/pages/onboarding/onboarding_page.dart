import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../services/onboarding/onboarding_service.dart';
import '../../../services/localization/localization_service.dart';
import '../../router/app_router.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  late List<OnboardingStep> _steps;

  @override
  void initState() {
    super.initState();
    _steps = OnboardingService.getOnboardingSteps();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < _steps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _completeOnboarding() async {
    await OnboardingService.completeOnboarding();
    if (mounted) {
      context.go(AppRouter.home);
    }
  }

  void _skipOnboarding() async {
    await OnboardingService.completeOnboarding();
    if (mounted) {
      context.go(AppRouter.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Header with skip button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'app_name'.tr(),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: _skipOnboarding,
                    child: Text('skip'.onboardingTr()),
                  ),
                ],
              ),
            ),
            
            // Progress indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: LinearProgressIndicator(
                value: (_currentIndex + 1) / _steps.length,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            
            // Page view
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemCount: _steps.length,
                itemBuilder: (context, index) {
                  final step = _steps[index];
                  return _OnboardingStepWidget(step: step);
                },
              ),
            ),
            
            // Navigation buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Previous button
                  if (_currentIndex > 0)
                    OutlinedButton(
                      onPressed: _previousPage,
                      child: Text('previous'.onboardingTr()),
                    )
                  else
                    const SizedBox.shrink(),
                  
                  // Page indicators
                  Row(
                    children: List.generate(
                      _steps.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == _currentIndex
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                  
                  // Next/Complete button
                  ElevatedButton(
                    onPressed: _nextPage,
                    child: Text(
                      _currentIndex == _steps.length - 1
                          ? 'get_started'.onboardingTr()
                          : 'next'.onboardingTr(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingStepWidget extends StatelessWidget {
  final OnboardingStep step;

  const _OnboardingStepWidget({required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon or image
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: step.color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              step.icon,
              size: 60,
              color: step.color,
            ),
          ),
          
          const SizedBox(height: 48),
          
          // Title
          Text(
            step.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 24),
          
          // Description
          Text(
            step.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 48),
          
          // Additional content based on step
          _buildStepSpecificContent(context),
        ],
      ),
    );
  }

  Widget _buildStepSpecificContent(BuildContext context) {
    switch (step.id) {
      case 'welcome':
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 32,
                ),
                const SizedBox(height: 12),
                Text(
                  'Secure & Reliable',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your data is protected with enterprise-level security',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      
      case 'organization':
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Icon(
                  Icons.groups,
                  color: Colors.blue,
                  size: 32,
                ),
                const SizedBox(height: 12),
                Text(
                  'Team Collaboration',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Invite team members and assign roles',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      
      case 'products':
        return Row(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Icon(Icons.qr_code, color: Colors.orange),
                      const SizedBox(height: 8),
                      Text(
                        'Barcode Scanning',
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Icon(Icons.inventory, color: Colors.green),
                      const SizedBox(height: 8),
                      Text(
                        'Stock Tracking',
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Icon(Icons.warning, color: Colors.red),
                      const SizedBox(height: 8),
                      Text(
                        'Low Stock Alerts',
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      
      default:
        return const SizedBox.shrink();
    }
  }
}

// Extension for additional onboarding translations
extension OnboardingTranslations on String {
  String onboardingTr() {
    final additionalTranslations = {
      'skip': LocalizationService.translate('skip'),
      'previous': LocalizationService.translate('previous'),
      'next': LocalizationService.translate('next'),
      'get_started': LocalizationService.translate('get_started'),
    };
    
    return additionalTranslations[this] ?? LocalizationService.translate(this);
  }
}