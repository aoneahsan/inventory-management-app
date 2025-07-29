import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import Stripe from "stripe";

// Initialize Stripe
const stripe = new Stripe(functions.config().stripe?.secret_key || "", {
  apiVersion: "2023-10-16",
});

interface ManageSubscriptionData {
  action: "cancel" | "resume" | "changePlan";
  organizationId?: string;
  newPriceId?: string; // For plan changes
}

/**
 * Manages existing subscriptions (cancel, resume, change plan)
 */
export const manageSubscription = functions.https.onCall(async (data: ManageSubscriptionData, context) => {
  // Check if user is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const {action, organizationId, newPriceId} = data;
  const userId = context.auth.uid;

  try {
    let subscriptionId: string | null = null;

    // Get subscription ID based on context
    if (organizationId) {
      // Organization subscription
      const orgDoc = await admin.firestore().collection("organizations").doc(organizationId).get();
      const orgData = orgDoc.data();

      if (!orgData || orgData.ownerId !== userId) {
        throw new functions.https.HttpsError("permission-denied", "Not authorized for this organization");
      }

      subscriptionId = orgData.subscription?.stripeSubscriptionId;
    } else {
      // Personal subscription
      const userDoc = await admin.firestore().collection("users").doc(userId).get();
      const userData = userDoc.data();

      if (!userData) {
        throw new functions.https.HttpsError("not-found", "User not found");
      }

      subscriptionId = userData.stripeSubscriptionId;
    }

    if (!subscriptionId) {
      throw new functions.https.HttpsError("not-found", "No active subscription found");
    }

    let result;

    switch (action) {
    case "cancel":
      result = await cancelSubscription(subscriptionId);
      break;

    case "resume":
      result = await resumeSubscription(subscriptionId);
      break;

    case "changePlan":
      if (!newPriceId) {
        throw new functions.https.HttpsError("invalid-argument", "New price ID required for plan change");
      }
      result = await changePlan(subscriptionId, newPriceId);
      break;

    default:
      throw new functions.https.HttpsError("invalid-argument", "Invalid action");
    }

    // Log the action
    await admin.firestore().collection("subscriptionActions").add({
      userId,
      organizationId: organizationId || null,
      action,
      subscriptionId,
      newPriceId: newPriceId || null,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });

    return {
      success: true,
      action,
      result,
    };
  } catch (error) {
    console.error("Error managing subscription:", error);
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError("internal", "Failed to manage subscription");
  }
});

async function cancelSubscription(subscriptionId: string) {
  try {
    // Cancel at period end (allows user to use subscription until end of billing period)
    const subscription = await stripe.subscriptions.update(subscriptionId, {
      cancel_at_period_end: true,
    });

    return {
      message: "Subscription will be canceled at the end of the current billing period",
      cancelAt: new Date(subscription.cancel_at! * 1000).toISOString(),
    };
  } catch (error) {
    console.error("Error canceling subscription:", error);
    throw new functions.https.HttpsError("internal", "Failed to cancel subscription");
  }
}

async function resumeSubscription(subscriptionId: string) {
  try {
    // Check if subscription is set to cancel
    const subscription = await stripe.subscriptions.retrieve(subscriptionId);

    if (!subscription.cancel_at_period_end) {
      throw new functions.https.HttpsError("failed-precondition", "Subscription is not set to cancel");
    }

    // Resume subscription
    const updated = await stripe.subscriptions.update(subscriptionId, {
      cancel_at_period_end: false,
    });

    return {
      message: "Subscription resumed successfully",
      status: updated.status,
    };
  } catch (error) {
    console.error("Error resuming subscription:", error);
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError("internal", "Failed to resume subscription");
  }
}

async function changePlan(subscriptionId: string, newPriceId: string) {
  try {
    // Retrieve current subscription
    const subscription = await stripe.subscriptions.retrieve(subscriptionId);

    if (subscription.items.data.length === 0) {
      throw new functions.https.HttpsError("failed-precondition", "No subscription items found");
    }

    const currentItem = subscription.items.data[0];

    // Update subscription with new price
    const updated = await stripe.subscriptions.update(subscriptionId, {
      items: [
        {
          id: currentItem.id,
          price: newPriceId,
        },
      ],
      proration_behavior: "create_prorations", // Create prorations for immediate change
    });

    return {
      message: "Plan changed successfully",
      newPlan: updated.items.data[0].price.id,
      nextBillingDate: new Date(updated.current_period_end * 1000).toISOString(),
    };
  } catch (error) {
    console.error("Error changing plan:", error);
    throw new functions.https.HttpsError("internal", "Failed to change plan");
  }
}

/**
 * Get customer portal session for managing billing
 */
export const createBillingPortalSession = functions.https.onCall(async (data, context) => {
  // Check if user is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const {returnUrl} = data;
  const userId = context.auth.uid;

  if (!returnUrl) {
    throw new functions.https.HttpsError("invalid-argument", "Return URL is required");
  }

  try {
    // Get user's Stripe customer ID
    const userDoc = await admin.firestore().collection("users").doc(userId).get();
    const userData = userDoc.data();

    if (!userData || !userData.stripeCustomerId) {
      throw new functions.https.HttpsError("not-found", "No customer record found");
    }

    // Create billing portal session
    const session = await stripe.billingPortal.sessions.create({
      customer: userData.stripeCustomerId,
      return_url: returnUrl,
    });

    return {
      url: session.url,
    };
  } catch (error) {
    console.error("Error creating billing portal session:", error);
    throw new functions.https.HttpsError("internal", "Failed to create billing portal session");
  }
});
