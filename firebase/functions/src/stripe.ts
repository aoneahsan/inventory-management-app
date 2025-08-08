import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import Stripe from 'stripe';

// Initialize Stripe with secret key from environment
const stripe = new Stripe(functions.config().stripe.secret_key, {
  apiVersion: '2024-11-20.acacia',
});

const db = admin.firestore();

// Create Stripe checkout session
export const createStripeCheckoutSession = functions.https.onCall(async (data, context) => {
  // Verify user is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }

  const { organizationId, userId, priceId, tier, successUrl, cancelUrl } = data;

  try {
    // Get or create Stripe customer
    const orgDoc = await db.collection('organizations').doc(organizationId).get();
    const orgData = orgDoc.data();
    
    let customerId = orgData?.stripe_customer_id;
    
    if (!customerId) {
      // Create new Stripe customer
      const customer = await stripe.customers.create({
        metadata: {
          organizationId,
          userId,
        },
        email: context.auth.token.email,
      });
      
      customerId = customer.id;
      
      // Save customer ID to organization
      await db.collection('organizations').doc(organizationId).update({
        stripe_customer_id: customerId,
      });
    }

    // Create checkout session
    const session = await stripe.checkout.sessions.create({
      customer: customerId,
      payment_method_types: ['card'],
      line_items: [{
        price: priceId,
        quantity: 1,
      }],
      mode: 'subscription',
      success_url: successUrl,
      cancel_url: cancelUrl,
      metadata: {
        organizationId,
        tier,
      },
      subscription_data: {
        metadata: {
          organizationId,
          tier,
        },
      },
    });

    return { url: session.url };
  } catch (error) {
    console.error('Error creating checkout session:', error);
    throw new functions.https.HttpsError('internal', 'Failed to create checkout session');
  }
});

// Create billing portal session
export const createStripeBillingPortalSession = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }

  const { customerId, returnUrl } = data;

  try {
    const session = await stripe.billingPortal.sessions.create({
      customer: customerId,
      return_url: returnUrl,
    });

    return { url: session.url };
  } catch (error) {
    console.error('Error creating billing portal session:', error);
    throw new functions.https.HttpsError('internal', 'Failed to create billing portal session');
  }
});

// Cancel subscription
export const cancelStripeSubscription = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }

  const { organizationId } = data;

  try {
    // Get organization's subscription ID
    const orgDoc = await db.collection('organizations').doc(organizationId).get();
    const subscriptionId = orgDoc.data()?.stripe_subscription_id;
    
    if (!subscriptionId) {
      throw new functions.https.HttpsError('not-found', 'No active subscription found');
    }

    // Cancel subscription at period end
    await stripe.subscriptions.update(subscriptionId, {
      cancel_at_period_end: true,
    });

    return { success: true };
  } catch (error) {
    console.error('Error cancelling subscription:', error);
    throw new functions.https.HttpsError('internal', 'Failed to cancel subscription');
  }
});

// Get subscription details
export const getStripeSubscription = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }

  const { subscriptionId } = data;

  try {
    const subscription = await stripe.subscriptions.retrieve(subscriptionId);
    
    return {
      status: subscription.status,
      current_period_end: subscription.current_period_end,
      cancel_at_period_end: subscription.cancel_at_period_end,
      amount: subscription.items.data[0]?.price.unit_amount,
      currency: subscription.currency,
      interval: subscription.items.data[0]?.price.recurring?.interval,
    };
  } catch (error) {
    console.error('Error getting subscription:', error);
    throw new functions.https.HttpsError('internal', 'Failed to get subscription details');
  }
});

// Get invoices
export const getStripeInvoices = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }

  const { customerId, limit = 20 } = data;

  try {
    const invoices = await stripe.invoices.list({
      customer: customerId,
      limit,
    });

    return {
      invoices: invoices.data.map(invoice => ({
        id: invoice.id,
        number: invoice.number,
        amount_paid: invoice.amount_paid,
        currency: invoice.currency,
        status: invoice.status,
        created: invoice.created,
        paid: invoice.paid,
        invoice_pdf: invoice.invoice_pdf,
        hosted_invoice_url: invoice.hosted_invoice_url,
      })),
    };
  } catch (error) {
    console.error('Error getting invoices:', error);
    throw new functions.https.HttpsError('internal', 'Failed to get invoices');
  }
});

// Update payment method
export const updateStripePaymentMethod = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }

  const { organizationId, paymentMethodId } = data;

  try {
    // Get organization's customer ID
    const orgDoc = await db.collection('organizations').doc(organizationId).get();
    const customerId = orgDoc.data()?.stripe_customer_id;
    
    if (!customerId) {
      throw new functions.https.HttpsError('not-found', 'No customer found');
    }

    // Attach payment method to customer
    await stripe.paymentMethods.attach(paymentMethodId, {
      customer: customerId,
    });

    // Set as default payment method
    await stripe.customers.update(customerId, {
      invoice_settings: {
        default_payment_method: paymentMethodId,
      },
    });

    return { success: true };
  } catch (error) {
    console.error('Error updating payment method:', error);
    throw new functions.https.HttpsError('internal', 'Failed to update payment method');
  }
});

// Create payment intent for mobile payment sheet
export const createStripePaymentIntent = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }

  const { organizationId, amount } = data;

  try {
    // Get or create customer
    const orgDoc = await db.collection('organizations').doc(organizationId).get();
    let customerId = orgDoc.data()?.stripe_customer_id;
    
    if (!customerId) {
      const customer = await stripe.customers.create({
        metadata: { organizationId },
        email: context.auth.token.email,
      });
      customerId = customer.id;
      
      await db.collection('organizations').doc(organizationId).update({
        stripe_customer_id: customerId,
      });
    }

    // Create payment intent
    const paymentIntent = await stripe.paymentIntents.create({
      amount,
      currency: 'usd',
      customer: customerId,
      metadata: { organizationId },
    });

    // Create ephemeral key for mobile SDK
    const ephemeralKey = await stripe.ephemeralKeys.create(
      { customer: customerId },
      { apiVersion: '2024-11-20.acacia' }
    );

    return {
      clientSecret: paymentIntent.client_secret,
      ephemeralKey: ephemeralKey.secret,
      customerId,
    };
  } catch (error) {
    console.error('Error creating payment intent:', error);
    throw new functions.https.HttpsError('internal', 'Failed to create payment intent');
  }
});

// Stripe webhook handler
export const stripeWebhook = functions.https.onRequest(async (req, res) => {
  const sig = req.headers['stripe-signature'] as string;
  const endpointSecret = functions.config().stripe.webhook_secret;

  let event: Stripe.Event;

  try {
    event = stripe.webhooks.constructEvent(req.rawBody, sig, endpointSecret);
  } catch (err: any) {
    console.error('Webhook signature verification failed:', err.message);
    res.status(400).send(`Webhook Error: ${err.message}`);
    return;
  }

  // Handle the event
  try {
    switch (event.type) {
      case 'checkout.session.completed': {
        const session = event.data.object as Stripe.Checkout.Session;
        await handleCheckoutCompleted(session);
        break;
      }
      
      case 'customer.subscription.updated': {
        const subscription = event.data.object as Stripe.Subscription;
        await handleSubscriptionUpdated(subscription);
        break;
      }
      
      case 'customer.subscription.deleted': {
        const subscription = event.data.object as Stripe.Subscription;
        await handleSubscriptionDeleted(subscription);
        break;
      }
      
      case 'invoice.payment_succeeded': {
        const invoice = event.data.object as Stripe.Invoice;
        await handlePaymentSucceeded(invoice);
        break;
      }
      
      case 'invoice.payment_failed': {
        const invoice = event.data.object as Stripe.Invoice;
        await handlePaymentFailed(invoice);
        break;
      }
    }

    res.json({ received: true });
  } catch (error) {
    console.error('Error handling webhook:', error);
    res.status(500).send('Webhook handler error');
  }
});

// Webhook handlers
async function handleCheckoutCompleted(session: Stripe.Checkout.Session) {
  const organizationId = session.metadata?.organizationId;
  const tier = session.metadata?.tier;
  
  if (!organizationId || !tier) return;

  await db.collection('organizations').doc(organizationId).update({
    subscription_tier: tier,
    subscription_status: 'active',
    subscription_expires_at: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString(),
    stripe_customer_id: session.customer,
    stripe_subscription_id: session.subscription,
    updated_at: new Date().toISOString(),
  });
}

async function handleSubscriptionUpdated(subscription: Stripe.Subscription) {
  const organizationId = subscription.metadata?.organizationId;
  if (!organizationId) return;

  let status = 'inactive';
  switch (subscription.status) {
    case 'active':
      status = 'active';
      break;
    case 'past_due':
      status = 'suspended';
      break;
    case 'canceled':
      status = 'cancelled';
      break;
  }

  await db.collection('organizations').doc(organizationId).update({
    subscription_status: status,
    subscription_expires_at: new Date(subscription.current_period_end * 1000).toISOString(),
    updated_at: new Date().toISOString(),
  });
}

async function handleSubscriptionDeleted(subscription: Stripe.Subscription) {
  const organizationId = subscription.metadata?.organizationId;
  if (!organizationId) return;

  await db.collection('organizations').doc(organizationId).update({
    subscription_tier: 'free',
    subscription_status: 'cancelled',
    stripe_subscription_id: null,
    updated_at: new Date().toISOString(),
  });
}

async function handlePaymentSucceeded(invoice: Stripe.Invoice) {
  const organizationId = invoice.subscription_details?.metadata?.organizationId;
  if (!organizationId) return;

  console.log(`Payment succeeded for organization: ${organizationId}`);
  
  await db.collection('organizations').doc(organizationId).update({
    subscription_status: 'active',
    updated_at: new Date().toISOString(),
  });
}

async function handlePaymentFailed(invoice: Stripe.Invoice) {
  const organizationId = invoice.subscription_details?.metadata?.organizationId;
  if (!organizationId) return;

  console.log(`Payment failed for organization: ${organizationId}`);
  
  await db.collection('organizations').doc(organizationId).update({
    subscription_status: 'suspended',
    updated_at: new Date().toISOString(),
  });
}