import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../services/onboarding/onboarding_service.dart';

class FeatureTourPage extends ConsumerStatefulWidget {
  const FeatureTourPage({super.key});

  @override
  ConsumerState<FeatureTourPage> createState() => _FeatureTourPageState();
}

class _FeatureTourPageState extends ConsumerState<FeatureTourPage> {
  late List<TourStep> _tourSteps;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _tourSteps = OnboardingService.getFeatureTourSteps();
    _checkCompletedSteps();
  }

  Future<void> _checkCompletedSteps() async {
    final completedSteps = await OnboardingService.getCompletedTourSteps();
    setState(() {
      _isCompleted = completedSteps.length >= _tourSteps.length;
    });
  }

  void _startTour() {
    TourManager.startTour(
      _tourSteps,
      onComplete: () {
        setState(() {
          _isCompleted = true;
        });
        _showTourCompletedDialog();
      },
    );
    context.pop(); // Return to main app
  }

  void _showTourCompletedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tour Completed!'),
        content: const Text('You\'ve successfully completed the feature tour. You\'re now ready to make the most of the app!'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Great!'),
          ),
        ],
      ),
    );
  }

  void _resetTour() async {
    await OnboardingService.resetOnboarding();
    setState(() {
      _isCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feature Tour'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.explore,
                          size: 48,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'App Feature Tour',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Take a guided tour to discover all the powerful features',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    if (_isCompleted)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green),
                            const SizedBox(width: 12),
                            Text(
                              'Tour completed!',
                              style: TextStyle(
                                color: Colors.green[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline, color: Colors.blue),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'The tour will guide you through the app while you use it',
                                style: TextStyle(
                                  color: Colors.blue[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Tour steps list
            Text(
              'Tour Steps',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            FutureBuilder<List<String>>(
              future: OnboardingService.getCompletedTourSteps(),
              builder: (context, snapshot) {
                final completedSteps = snapshot.data ?? [];
                
                return Column(
                  children: _tourSteps.asMap().entries.map((entry) {
                    final index = entry.key;
                    final step = entry.value;
                    final isCompleted = completedSteps.contains(step.id);
                    
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: isCompleted 
                              ? Colors.green 
                              : Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                          child: isCompleted
                              ? const Icon(Icons.check, color: Colors.white)
                              : Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                        title: Text(
                          step.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            decoration: isCompleted ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        subtitle: Text(step.description),
                        trailing: isCompleted 
                            ? Icon(Icons.check_circle, color: Colors.green)
                            : Icon(Icons.radio_button_unchecked, color: Colors.grey),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            
            const SizedBox(height: 32),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isCompleted ? null : _startTour,
                    icon: Icon(_isCompleted ? Icons.check : Icons.play_arrow),
                    label: Text(_isCompleted ? 'Tour Completed' : 'Start Tour'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  onPressed: _resetTour,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Additional information
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb_outline, color: Colors.amber),
                        const SizedBox(width: 12),
                        Text(
                          'Tips',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('• The tour will highlight important features as you navigate'),
                    const SizedBox(height: 4),
                    const Text('• You can skip or restart the tour at any time'),
                    const SizedBox(height: 4),
                    const Text('• Each step will be marked as completed automatically'),
                    const SizedBox(height: 4),
                    const Text('• Access this page anytime from Settings > Help & Support'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}