import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../../../domain/entities/organization.dart';

class CheckoutSuccessPage extends ConsumerStatefulWidget {
  const CheckoutSuccessPage({super.key});

  @override
  ConsumerState<CheckoutSuccessPage> createState() => _CheckoutSuccessPageState();
}

class _CheckoutSuccessPageState extends ConsumerState<CheckoutSuccessPage> {
  bool _isLoading = true;
  bool _isSuccess = false;

  @override
  void initState() {
    super.initState();
    _checkSubscriptionStatus();
  }

  Future<void> _checkSubscriptionStatus() async {
    try {
      // Wait a moment for webhook to process
      await Future.delayed(const Duration(seconds: 2));
      
      // Invalidate providers to force refresh
      ref.invalidate(currentUserStreamProvider);
      ref.invalidate(currentOrganizationProvider);
      
      // Wait for providers to refresh
      await Future.delayed(const Duration(seconds: 1));
      
      final organization = ref.read(currentOrganizationProvider);
      if (organization != null && organization.tier != SubscriptionTier.free) {
        setState(() {
          _isSuccess = true;
          _isLoading = false;
        });
        
        // Auto-redirect after showing success
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            context.go('/subscription');
          }
        });
      } else {
        // Retry after a delay
        Future.delayed(const Duration(seconds: 2), _checkSubscriptionStatus);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isSuccess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading) ...[
                const CircularProgressIndicator(),
                const SizedBox(height: 24),
                const Text(
                  'Processing your subscription...',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please wait while we activate your subscription',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ] else if (_isSuccess) ...[
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green.shade700,
                    size: 48,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Payment Successful!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your subscription has been activated',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Redirecting to billing page...',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ] else ...[
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.warning,
                    color: Colors.orange.shade700,
                    size: 48,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Processing Delayed',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your payment is being processed. This may take a few moments.',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.go('/billing'),
                  child: const Text('Go to Billing'),
                ),
              ],
              const SizedBox(height: 48),
              TextButton(
                onPressed: () => context.go('/'),
                child: const Text('Return to Dashboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}