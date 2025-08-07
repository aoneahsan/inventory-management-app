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
  })  : _firestore = firestore ?? FirebaseFirestore.instance;

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

    // Mock implementation - always return success for development
    // TODO: Implement actual Stripe integration
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

  Future<void> cancelSubscription(String organizationId) async {
    // Mock implementation - always update status for development
    // TODO: Implement actual Stripe integration
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
    // Mock implementation - fetch from Firestore for development
    // TODO: Implement actual Stripe integration
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
    // Mock implementation - return sample invoices for development
    // TODO: Implement actual Stripe integration
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
    // Mock implementation - just log for development
    // TODO: Implement actual Stripe integration
    debugPrint('Mock Stripe: Updating payment method for $organizationId');
    
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    // In production, this would update the payment method in Stripe
    // For now, we just simulate success
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