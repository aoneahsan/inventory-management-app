import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../../domain/entities/organization.dart';
import '../../core/errors/exceptions.dart';

// Mock Stripe service for development
// TODO: Replace with actual Stripe SDK integration
class StripeService {
  final FirebaseFirestore _firestore;
  final FirebaseFunctions _functions;
  
  // Price IDs for different tiers (would come from Stripe dashboard)
  static const Map<SubscriptionTier, String> _priceIds = {
    SubscriptionTier.basic: 'price_basic_monthly',
    SubscriptionTier.professional: 'price_professional_monthly',
    SubscriptionTier.enterprise: 'price_enterprise_monthly',
  };

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
        _functions = functions ?? FirebaseFunctions.instance;

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

    try {
      // In production, this would call a Cloud Function that creates a Stripe checkout session
      final callable = _functions.httpsCallable('createCheckoutSession');
      final result = await callable.call({
        'organizationId': organizationId,
        'userId': userId,
        'priceId': _priceIds[tier],
        'successUrl': successUrl ?? 'https://app.aoneahsan.com/subscription/success',
        'cancelUrl': cancelUrl ?? 'https://app.aoneahsan.com/subscription/cancel',
      });

      return result.data['sessionUrl'] as String;
    } catch (e) {
      // For development, return a mock URL
      debugPrint('Mock Stripe: Creating checkout session for $tier');
      return 'https://checkout.stripe.com/mock-session-${DateTime.now().millisecondsSinceEpoch}';
    }
  }

  Future<void> cancelSubscription(String organizationId) async {
    try {
      // In production, this would call a Cloud Function to cancel the Stripe subscription
      final callable = _functions.httpsCallable('cancelSubscription');
      await callable.call({
        'organizationId': organizationId,
      });
    } catch (e) {
      // For development, just update the organization status
      debugPrint('Mock Stripe: Cancelling subscription for $organizationId');
      await _firestore.collection('organizations').doc(organizationId).update({
        'subscription_status': SubscriptionStatus.cancelled.name,
        'subscription_expires_at': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    }
  }

  Future<Map<String, dynamic>> getSubscriptionDetails(String organizationId) async {
    try {
      // In production, this would fetch from Stripe via Cloud Function
      final callable = _functions.httpsCallable('getSubscriptionDetails');
      final result = await callable.call({
        'organizationId': organizationId,
      });
      
      return result.data as Map<String, dynamic>;
    } catch (e) {
      // For development, return mock data
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
        'status': data['subscription_status'],
        'currentPeriodEnd': data['subscription_expires_at'],
        'cancelAtPeriodEnd': false,
        'amount': tierPrices[tier],
        'currency': 'usd',
        'interval': 'month',
      };
    }
  }

  Future<List<Map<String, dynamic>>> getInvoices(String organizationId) async {
    try {
      // In production, this would fetch from Stripe via Cloud Function
      final callable = _functions.httpsCallable('getInvoices');
      final result = await callable.call({
        'organizationId': organizationId,
      });
      
      return (result.data as List).cast<Map<String, dynamic>>();
    } catch (e) {
      // For development, return mock invoices
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
  }

  Future<void> updatePaymentMethod({
    required String organizationId,
    required String paymentMethodId,
  }) async {
    try {
      // In production, this would update the payment method in Stripe
      final callable = _functions.httpsCallable('updatePaymentMethod');
      await callable.call({
        'organizationId': organizationId,
        'paymentMethodId': paymentMethodId,
      });
    } catch (e) {
      // For development, just log
      debugPrint('Mock Stripe: Updating payment method for $organizationId');
    }
  }

  // Webhook handler (would be called by Cloud Functions)
  static Future<void> handleWebhook(Map<String, dynamic> event) async {
    final eventType = event['type'] as String;
    final data = event['data']['object'] as Map<String, dynamic>;

    switch (eventType) {
      case 'checkout.session.completed':
        await _handleCheckoutCompleted(data);
        break;
      case 'customer.subscription.updated':
        await _handleSubscriptionUpdated(data);
        break;
      case 'customer.subscription.deleted':
        await _handleSubscriptionDeleted(data);
        break;
      case 'invoice.payment_succeeded':
        await _handlePaymentSucceeded(data);
        break;
      case 'invoice.payment_failed':
        await _handlePaymentFailed(data);
        break;
    }
  }

  static Future<void> _handleCheckoutCompleted(Map<String, dynamic> session) async {
    // Update organization with new subscription
    final organizationId = session['metadata']['organizationId'] as String;
    final tier = session['metadata']['tier'] as String;
    
    await FirebaseFirestore.instance.collection('organizations').doc(organizationId).update({
      'subscription_tier': tier,
      'subscription_status': SubscriptionStatus.active.name,
      'subscription_expires_at': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
      'stripe_customer_id': session['customer'],
      'stripe_subscription_id': session['subscription'],
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  static Future<void> _handleSubscriptionUpdated(Map<String, dynamic> subscription) async {
    // Update organization subscription details
    final organizationId = subscription['metadata']['organizationId'] as String;
    final status = subscription['status'] as String;
    
    SubscriptionStatus subStatus;
    switch (status) {
      case 'active':
        subStatus = SubscriptionStatus.active;
        break;
      case 'past_due':
        subStatus = SubscriptionStatus.suspended;
        break;
      case 'canceled':
        subStatus = SubscriptionStatus.cancelled;
        break;
      default:
        subStatus = SubscriptionStatus.inactive;
    }
    
    await FirebaseFirestore.instance.collection('organizations').doc(organizationId).update({
      'subscription_status': subStatus.name,
      'subscription_expires_at': DateTime.fromMillisecondsSinceEpoch(
        subscription['current_period_end'] * 1000,
      ).toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  static Future<void> _handleSubscriptionDeleted(Map<String, dynamic> subscription) async {
    final organizationId = subscription['metadata']['organizationId'] as String;
    
    await FirebaseFirestore.instance.collection('organizations').doc(organizationId).update({
      'subscription_tier': SubscriptionTier.free.name,
      'subscription_status': SubscriptionStatus.cancelled.name,
      'stripe_subscription_id': null,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  static Future<void> _handlePaymentSucceeded(Map<String, dynamic> invoice) async {
    // Log successful payment
    final organizationId = invoice['metadata']['organizationId'] as String;
    debugPrint('Payment succeeded for organization: $organizationId');
  }

  static Future<void> _handlePaymentFailed(Map<String, dynamic> invoice) async {
    // Handle failed payment
    final organizationId = invoice['metadata']['organizationId'] as String;
    
    // Suspend organization after failed payment
    await FirebaseFirestore.instance.collection('organizations').doc(organizationId).update({
      'subscription_status': SubscriptionStatus.suspended.name,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }
}