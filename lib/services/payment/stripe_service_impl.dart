import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/organization.dart';
import '../../core/errors/exceptions.dart';
import '../../core/config/environment.dart';

class StripeServiceImpl {
  final FirebaseFirestore _firestore;
  final FirebaseFunctions _functions;
  
  // Price IDs from Stripe Dashboard
  static Map<SubscriptionTier, String> get tierPriceIds => {
    SubscriptionTier.free: '',
    SubscriptionTier.basic: Environment.stripeBasicPriceId,
    SubscriptionTier.professional: Environment.stripeProfessionalPriceId,
    SubscriptionTier.enterprise: Environment.stripeEnterprisePriceId,
  };

  // Monthly prices in USD (for display)
  static const Map<SubscriptionTier, int> tierPrices = {
    SubscriptionTier.free: 0,
    SubscriptionTier.basic: 29,
    SubscriptionTier.professional: 99,
    SubscriptionTier.enterprise: 299,
  };

  StripeServiceImpl({
    FirebaseFirestore? firestore,
    FirebaseFunctions? functions,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _functions = functions ?? FirebaseFunctions.instance;

  Future<void> initializeStripe() async {
    Stripe.publishableKey = Environment.stripePublishableKey;
    
    if (!kIsWeb) {
      // Initialize Stripe for mobile platforms
      await Stripe.instance.applySettings();
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

    try {
      // Call Cloud Function to create checkout session
      final callable = _functions.httpsCallable('createStripeCheckoutSession');
      final result = await callable.call({
        'organizationId': organizationId,
        'userId': userId,
        'priceId': tierPriceIds[tier],
        'tier': tier.name,
        'successUrl': successUrl ?? '${Environment.appUrl}/billing/success',
        'cancelUrl': cancelUrl ?? '${Environment.appUrl}/billing',
      });

      final sessionUrl = result.data['url'] as String;
      
      // For web, redirect to Stripe checkout
      if (kIsWeb) {
        // Use url_launcher package to open checkout URL
        // This will be handled by the calling widget
        return sessionUrl;
      }
      
      return sessionUrl;
    } catch (e) {
      debugPrint('Error creating checkout session: $e');
      throw BusinessException(message: 'Failed to create checkout session');
    }
  }

  Future<void> createBillingPortalSession({
    required String organizationId,
    String? returnUrl,
  }) async {
    try {
      // Get organization's Stripe customer ID
      final orgDoc = await _firestore.collection('organizations').doc(organizationId).get();
      final stripeCustomerId = orgDoc.data()?['stripe_customer_id'] as String?;
      
      if (stripeCustomerId == null) {
        throw BusinessException(message: 'No billing account found');
      }

      // Call Cloud Function to create billing portal session
      final callable = _functions.httpsCallable('createStripeBillingPortalSession');
      final result = await callable.call({
        'customerId': stripeCustomerId,
        'returnUrl': returnUrl ?? Environment.appUrl,
      });

      final portalUrl = result.data['url'] as String;
      
      // Launch the billing portal URL
      final uri = Uri.parse(portalUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw BusinessException(message: 'Could not open billing portal');
      }
    } catch (e) {
      debugPrint('Error creating billing portal session: $e');
      if (e is BusinessException) rethrow;
      throw BusinessException(message: 'Failed to open billing portal');
    }
  }

  Future<void> cancelSubscription(String organizationId) async {
    try {
      // Call Cloud Function to cancel subscription
      final callable = _functions.httpsCallable('cancelStripeSubscription');
      await callable.call({
        'organizationId': organizationId,
      });
    } catch (e) {
      debugPrint('Error cancelling subscription: $e');
      throw BusinessException(message: 'Failed to cancel subscription');
    }
  }

  Future<Map<String, dynamic>> getSubscriptionDetails(String organizationId) async {
    try {
      // Get organization document
      final org = await _firestore.collection('organizations').doc(organizationId).get();
      if (!org.exists) {
        throw BusinessException(message: 'Organization not found');
      }

      final data = org.data()!;
      final tier = SubscriptionTier.values.firstWhere(
        (t) => t.name == data['subscription_tier'],
        orElse: () => SubscriptionTier.free,
      );
      
      final stripeSubscriptionId = data['stripe_subscription_id'] as String?;
      
      if (stripeSubscriptionId == null || tier == SubscriptionTier.free) {
        // Return free tier details
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

      // Call Cloud Function to get subscription details from Stripe
      final callable = _functions.httpsCallable('getStripeSubscription');
      final result = await callable.call({
        'subscriptionId': stripeSubscriptionId,
      });

      final subscription = result.data as Map<String, dynamic>;
      
      return {
        'organizationId': organizationId,
        'tier': tier.name,
        'status': subscription['status'],
        'currentPeriodEnd': DateTime.fromMillisecondsSinceEpoch(
          subscription['current_period_end'] * 1000,
        ).toIso8601String(),
        'cancelAtPeriodEnd': subscription['cancel_at_period_end'] ?? false,
        'amount': subscription['amount'] ?? tierPrices[tier],
        'currency': subscription['currency'] ?? 'usd',
        'interval': subscription['interval'] ?? 'month',
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
    try {
      // Get organization's Stripe customer ID
      final orgDoc = await _firestore.collection('organizations').doc(organizationId).get();
      final stripeCustomerId = orgDoc.data()?['stripe_customer_id'] as String?;
      
      if (stripeCustomerId == null) {
        return [];
      }

      // Call Cloud Function to get invoices from Stripe
      final callable = _functions.httpsCallable('getStripeInvoices');
      final result = await callable.call({
        'customerId': stripeCustomerId,
        'limit': 20,
      });

      final invoices = (result.data['invoices'] as List).cast<Map<String, dynamic>>();
      
      return invoices.map((invoice) => {
        'id': invoice['id'],
        'number': invoice['number'],
        'amount': invoice['amount_paid'],
        'currency': invoice['currency'],
        'status': invoice['status'],
        'created': invoice['created'],
        'paid': invoice['paid'],
        'invoicePdf': invoice['invoice_pdf'],
        'hostedInvoiceUrl': invoice['hosted_invoice_url'],
      }).toList();
    } catch (e) {
      debugPrint('Error getting invoices: $e');
      return [];
    }
  }

  Future<void> updatePaymentMethod({
    required String organizationId,
    required String paymentMethodId,
  }) async {
    try {
      // Call Cloud Function to update payment method
      final callable = _functions.httpsCallable('updateStripePaymentMethod');
      await callable.call({
        'organizationId': organizationId,
        'paymentMethodId': paymentMethodId,
      });
    } catch (e) {
      debugPrint('Error updating payment method: $e');
      throw BusinessException(message: 'Failed to update payment method');
    }
  }

  // Mobile-specific payment sheet methods
  Future<void> initPaymentSheet({
    required String organizationId,
    required SubscriptionTier tier,
  }) async {
    if (kIsWeb) {
      throw BusinessException(message: 'Payment sheet not supported on web');
    }

    try {
      // Call Cloud Function to create setup intent or payment intent
      final callable = _functions.httpsCallable('createStripePaymentIntent');
      final result = await callable.call({
        'organizationId': organizationId,
        'priceId': tierPriceIds[tier],
        'amount': tierPrices[tier]! * 100, // Convert to cents
      });

      final clientSecret = result.data['clientSecret'] as String;
      final ephemeralKey = result.data['ephemeralKey'] as String;
      final customerId = result.data['customerId'] as String;

      // Initialize payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Inventory Management',
          customerId: customerId,
          customerEphemeralKeySecret: ephemeralKey,
          paymentIntentClientSecret: clientSecret,
          style: ThemeMode.system,
          billingDetails: const BillingDetails(
            email: '',
            phone: '',
            address: Address(
              country: 'US',
              city: '',
              line1: '',
              line2: '',
              postalCode: '',
              state: '',
            ),
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error initializing payment sheet: $e');
      throw BusinessException(message: 'Failed to initialize payment');
    }
  }

  Future<void> presentPaymentSheet() async {
    if (kIsWeb) {
      throw BusinessException(message: 'Payment sheet not supported on web');
    }

    try {
      await Stripe.instance.presentPaymentSheet();
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        throw BusinessException(message: 'Payment cancelled');
      } else {
        throw BusinessException(message: 'Payment failed: ${e.error.message}');
      }
    }
  }

  // Webhook handler (called by Cloud Functions)
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
    
    // Ensure subscription is active
    await FirebaseFirestore.instance.collection('organizations').doc(organizationId).update({
      'subscription_status': SubscriptionStatus.active.name,
      'updated_at': DateTime.now().toIso8601String(),
    });
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