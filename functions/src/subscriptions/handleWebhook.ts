import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import Stripe from "stripe";

// Initialize Stripe
const stripe = new Stripe(functions.config().stripe?.secret_key || "", {
  apiVersion: "2023-10-16",
});

/**
 * Handles Stripe webhook events
 */
export const handleStripeWebhook = functions.https.onRequest(async (req, res) => {
  // Only accept POST requests
  if (req.method !== "POST") {
    res.status(405).send("Method Not Allowed");
    return;
  }

  const sig = req.headers["stripe-signature"];
  const webhookSecret = functions.config().stripe?.webhook_secret;

  if (!sig || !webhookSecret) {
    console.error("Missing stripe signature or webhook secret");
    res.status(400).send("Webhook Error: Missing signature or secret");
    return;
  }

  let event: Stripe.Event;

  try {
    // Verify webhook signature
    event = stripe.webhooks.constructEvent(req.rawBody, sig, webhookSecret);
  } catch (err) {
    console.error("Webhook signature verification failed:", err);
    res.status(400).send(`Webhook Error: ${err.message}`);
    return;
  }

  // Handle the event
  try {
    switch (event.type) {
    case "checkout.session.completed":
      await handleCheckoutSessionCompleted(event.data.object as Stripe.Checkout.Session);
      break;

    case "customer.subscription.created":
    case "customer.subscription.updated":
      await handleSubscriptionUpdate(event.data.object as Stripe.Subscription);
      break;

    case "customer.subscription.deleted":
      await handleSubscriptionDeleted(event.data.object as Stripe.Subscription);
      break;

    case "invoice.payment_succeeded":
      await handleInvoicePaymentSucceeded(event.data.object as Stripe.Invoice);
      break;

    case "invoice.payment_failed":
      await handleInvoicePaymentFailed(event.data.object as Stripe.Invoice);
      break;

    default:
      console.log(`Unhandled event type: ${event.type}`);
    }

    res.status(200).json({received: true});
  } catch (error) {
    console.error("Error processing webhook:", error);
    res.status(500).send("Webhook processing failed");
  }
});

async function handleCheckoutSessionCompleted(session: Stripe.Checkout.Session) {
  const {subscription, metadata} = session;
  const userId = metadata?.firebaseUID;
  const organizationId = metadata?.organizationId;

  if (!userId) {
    console.error("No user ID in session metadata");
    return;
  }

  // Update checkout session record
  const checkoutQuery = await admin.firestore()
    .collection("checkoutSessions")
    .where("sessionId", "==", session.id)
    .limit(1)
    .get();

  if (!checkoutQuery.empty) {
    await checkoutQuery.docs[0].ref.update({
      status: "completed",
      subscriptionId: subscription,
      completedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
  }

  // Get subscription details
  if (typeof subscription === "string") {
    const sub = await stripe.subscriptions.retrieve(subscription);
    await updateUserSubscription(userId, sub, organizationId);
  }
}

async function handleSubscriptionUpdate(subscription: Stripe.Subscription) {
  const userId = subscription.metadata?.firebaseUID;
  const organizationId = subscription.metadata?.organizationId;

  if (!userId) {
    console.error("No user ID in subscription metadata");
    return;
  }

  await updateUserSubscription(userId, subscription, organizationId);
}

async function handleSubscriptionDeleted(subscription: Stripe.Subscription) {
  const userId = subscription.metadata?.firebaseUID;
  const organizationId = subscription.metadata?.organizationId;

  if (!userId) {
    console.error("No user ID in subscription metadata");
    return;
  }

  // Update user or organization to free plan
  if (organizationId) {
    await admin.firestore().collection("organizations").doc(organizationId).update({
      "subscription.plan": "free",
      "subscription.status": "canceled",
      "subscription.stripeSubscriptionId": null,
      "subscription.currentPeriodEnd": null,
      "subscription.itemLimit": 100,
      "subscription.memberLimit": 3,
      "updatedAt": admin.firestore.FieldValue.serverTimestamp(),
    });
  } else {
    await admin.firestore().collection("users").doc(userId).update({
      subscription: "free",
      stripeSubscriptionId: null,
      subscriptionStatus: "canceled",
      currentPeriodEnd: null,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
  }

  console.log(`Subscription canceled for user ${userId}`);
}

async function handleInvoicePaymentSucceeded(invoice: Stripe.Invoice) {
  const subscriptionId = invoice.subscription;

  if (!subscriptionId || typeof subscriptionId !== "string") {
    return;
  }

  // Log successful payment
  await admin.firestore().collection("payments").add({
    invoiceId: invoice.id,
    subscriptionId,
    amount: invoice.amount_paid,
    currency: invoice.currency,
    status: "succeeded",
    paidAt: new Date(invoice.created * 1000),
    metadata: invoice.metadata,
  });
}

async function handleInvoicePaymentFailed(invoice: Stripe.Invoice) {
  const customerId = invoice.customer;

  if (!customerId || typeof customerId !== "string") {
    return;
  }

  // Find user by Stripe customer ID
  const userQuery = await admin.firestore()
    .collection("users")
    .where("stripeCustomerId", "==", customerId)
    .limit(1)
    .get();

  if (!userQuery.empty) {
    const userId = userQuery.docs[0].id;

    // Send notification or email about failed payment
    console.log(`Payment failed for user ${userId}`);

    // Log failed payment
    await admin.firestore().collection("payments").add({
      invoiceId: invoice.id,
      userId,
      amount: invoice.amount_due,
      currency: invoice.currency,
      status: "failed",
      failedAt: new Date(invoice.created * 1000),
      metadata: invoice.metadata,
    });
  }
}

async function updateUserSubscription(
  userId: string,
  subscription: Stripe.Subscription,
  organizationId?: string
) {
  const item = subscription.items.data[0];
  const priceId = item.price.id;

  // Map price IDs to plan names
  const planMap: { [key: string]: string } = {
    [functions.config().stripe?.price_pro || ""]: "pro",
    [functions.config().stripe?.price_enterprise || ""]: "enterprise",
  };

  const plan = planMap[priceId] || "free";
  const currentPeriodEnd = new Date(subscription.current_period_end * 1000);

  // Define plan limits
  const planLimits = {
    free: {itemLimit: 100, memberLimit: 3},
    pro: {itemLimit: 1000, memberLimit: 10},
    enterprise: {itemLimit: -1, memberLimit: -1}, // unlimited
  };

  const limits = planLimits[plan] || planLimits.free;

  if (organizationId) {
    // Update organization subscription
    await admin.firestore().collection("organizations").doc(organizationId).update({
      "subscription.plan": plan,
      "subscription.status": subscription.status,
      "subscription.stripeSubscriptionId": subscription.id,
      "subscription.currentPeriodEnd": currentPeriodEnd,
      "subscription.itemLimit": limits.itemLimit,
      "subscription.memberLimit": limits.memberLimit,
      "updatedAt": admin.firestore.FieldValue.serverTimestamp(),
    });
  } else {
    // Update user subscription
    await admin.firestore().collection("users").doc(userId).update({
      subscription: plan,
      stripeSubscriptionId: subscription.id,
      subscriptionStatus: subscription.status,
      currentPeriodEnd,
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Update all user's organizations to the new plan
    const userDoc = await admin.firestore().collection("users").doc(userId).get();
    const userData = userDoc.data();

    if (userData?.organizations) {
      const batch = admin.firestore().batch();

      for (const orgId of userData.organizations) {
        const orgRef = admin.firestore().collection("organizations").doc(orgId);
        batch.update(orgRef, {
          "subscription.plan": plan,
          "subscription.itemLimit": limits.itemLimit,
          "subscription.memberLimit": limits.memberLimit,
          "updatedAt": admin.firestore.FieldValue.serverTimestamp(),
        });
      }

      await batch.commit();
    }
  }

  console.log(`Updated subscription for user ${userId} to plan: ${plan}`);
}
