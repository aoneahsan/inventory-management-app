import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../../domain/entities/organization.dart';
import '../../core/errors/exceptions.dart';
import '../../core/config/environment.dart';
import 'stripe_service_impl.dart';

// Stripe service that uses real implementation in production
// and mock implementation in development
class StripeService {
  final FirebaseFirestore _firestore;
  final FirebaseFunctions _functions;
  final StripeServiceImpl? _realService;
  
  // Price IDs for different tiers (would come from Stripe dashboard)
  // Monthly prices in USD
  static const Map<SubscriptionTier, int> tierPrices = {
    SubscriptionTier.free: 0,
    SubscriptionTier.basic: 29,
    SubscriptionTier.professional: 99,
    SubscriptionTier.enterprise: 299,
  };

  StripeService({
    FirebaseFirestore? firestore,
    FirebaseFunctions? functions,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _functions = functions ?? FirebaseFunctions.instance,
        _realService = Environment.isDevelopment && !kIsWeb
            ? null
            : StripeServiceImpl(firestore: firestore, functions: functions);

  Future<void> initializeStripe() async {
    if (_realService != null) {
      await _realService!.initializeStripe();
    }
  }

  Future<String> createCheckoutSession({
    required String organizationId,
    required String userId,
    required SubscriptionTier tier,
    String? successUrl,
    String? cancelUrl,
  }) async {
    if (tier == SubscriptionTier.free) {
      throw BusinessException(message: 'Cannot create checkout session for free tier');
    }

    // Use real Stripe in production or when explicitly enabled
    if (_realService != null) {
      return _realService!.createCheckoutSession(
        organizationId: organizationId,
        userId: userId,
        tier: tier,
        successUrl: successUrl,
        cancelUrl: cancelUrl,
      );
    }

    // Mock implementation for development
    debugPrint('Mock Stripe: Creating checkout session for $tier');
    
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Update organization subscription in Firestore (mock payment success)
    try {
      await _firestore.collection('organizations').doc(organizationId).update({
        'subscription_tier': tier.name,
        'subscription_status': SubscriptionStatus.active.name,
        'subscription_expires_at': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      debugPrint('Error updating organization subscription: $e');
    }
    
    // Return mock checkout URL
    return 'https://checkout.stripe.com/mock-session-${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<void> createBillingPortalSession({
    required String organizationId,
    String? returnUrl,
  }) async {
    if (_realService != null) {
      return _realService!.createBillingPortalSession(
        organizationId: organizationId,
        returnUrl: returnUrl,
      );
    }

    // Mock implementation
    debugPrint('Mock Stripe: Opening billing portal for $organizationId');
    throw BusinessException(message: 'Billing portal not available in development mode');
  }

  Future<void> cancelSubscription(String organizationId) async {
    if (_realService != null) {
      return _realService!.cancelSubscription(organizationId);
    }

    // Mock implementation
    debugPrint('Mock Stripe: Cancelling subscription for $organizationId');
    
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    try {
      await _firestore.collection('organizations').doc(organizationId).update({
        'subscription_status': SubscriptionStatus.cancelled.name,
        'subscription_expires_at': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      debugPrint('Error cancelling subscription: $e');
      throw BusinessException(message: 'Failed to cancel subscription');
    }
  }

  Future<Map<String, dynamic>> getSubscriptionDetails(String organizationId) async {
    if (_realService != null) {
      return _realService!.getSubscriptionDetails(organizationId);
    }

    // Mock implementation
    debugPrint('Mock Stripe: Getting subscription details for $organizationId');
    
    try {
      final org = await _firestore.collection('organizations').doc(organizationId).get();
      if (!org.exists) {
        throw BusinessException(message: 'Organization not found');
      }

      final data = org.data()!;
      final tier = SubscriptionTier.values.firstWhere(
        (t) => t.name == data['subscription_tier'],
        orElse: () => SubscriptionTier.free,
      );

      return {
        'organizationId': organizationId,
        'tier': tier.name,
        'status': data['subscription_status'] ?? SubscriptionStatus.active.name,
        'currentPeriodEnd': data['subscription_expires_at'] ?? DateTime.now().add(const Duration(days: 30)).toIso8601String(),
        'cancelAtPeriodEnd': false,
        'amount': tierPrices[tier] ?? 0,
        'currency': 'usd',
        'interval': 'month',
      };
    } catch (e) {
      debugPrint('Error getting subscription details: $e');
      // Return default free tier data
      return {
        'organizationId': organizationId,
        'tier': SubscriptionTier.free.name,
        'status': SubscriptionStatus.active.name,
        'currentPeriodEnd': DateTime.now().add(const Duration(days: 365)).toIso8601String(),
        'cancelAtPeriodEnd': false,
        'amount': 0,
        'currency': 'usd',
        'interval': 'month',
      };
    }
  }

  Future<List<Map<String, dynamic>>> getInvoices(String organizationId) async {
    if (_realService != null) {
      return _realService!.getInvoices(organizationId);
    }

    // Mock implementation
    debugPrint('Mock Stripe: Getting invoices for $organizationId');
    
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Return mock invoices
    final now = DateTime.now();
    return List.generate(3, (index) {
      final date = now.subtract(Duration(days: 30 * (index + 1)));
      return {
        'id': 'inv_mock_${date.millisecondsSinceEpoch}',
        'number': 'INV-${date.year}${date.month.toString().padLeft(2, '0')}-${index + 1}',
        'amount': 2900, // $29.00 in cents
        'currency': 'usd',
        'status': 'paid',
        'created': date.millisecondsSinceEpoch ~/ 1000,
        'paid': true,
        'invoicePdf': 'https://stripe.com/mock-invoice.pdf',
      };
    });
  }

  Future<void> updatePaymentMethod({
    required String organizationId,
    required String paymentMethodId,
  }) async {
    if (_realService != null) {
      return _realService!.updatePaymentMethod(
        organizationId: organizationId,
        paymentMethodId: paymentMethodId,
      );
    }

    // Mock implementation
    debugPrint('Mock Stripe: Updating payment method for $organizationId');
    
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
  }

  // Mobile-specific payment sheet methods
  Future<void> initPaymentSheet({
    required String organizationId,
    required SubscriptionTier tier,
  }) async {
    if (_realService != null) {
      return _realService!.initPaymentSheet(
        organizationId: organizationId,
        tier: tier,
      );
    }

    // Mock implementation
    debugPrint('Mock Stripe: Initializing payment sheet for $tier');
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<void> presentPaymentSheet() async {
    if (_realService != null) {
      return _realService!.presentPaymentSheet();
    }

    // Mock implementation
    debugPrint('Mock Stripe: Presenting payment sheet');
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Simulate successful payment in development
    debugPrint('Mock Stripe: Payment successful');
  }

  // Webhook handler (would be called by Cloud Functions)
  static Future<void> handleWebhook(Map<String, dynamic> event) async {
    if (!Environment.isDevelopment) {
      return StripeServiceImpl.handleWebhook(event);
    }

    // Mock webhook handling
    final eventType = event['type'] as String;
    debugPrint('Mock Stripe: Handling webhook event: $eventType');
  }
}