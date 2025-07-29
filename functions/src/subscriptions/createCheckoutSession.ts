import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import Stripe from "stripe";

// Initialize Stripe with your secret key from Firebase config
const stripe = new Stripe(functions.config().stripe?.secret_key || "", {
  apiVersion: "2023-10-16",
});

interface CreateCheckoutSessionData {
  priceId: string;
  organizationId?: string;
  successUrl: string;
  cancelUrl: string;
}

/**
 * Creates a Stripe checkout session for subscription
 */
export const createCheckoutSession = functions.https.onCall(async (data: CreateCheckoutSessionData, context) => {
  // Check if user is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const {priceId, organizationId, successUrl, cancelUrl} = data;
  const userId = context.auth.uid;

  // Validate input
  if (!priceId || !successUrl || !cancelUrl) {
    throw new functions.https.HttpsError("invalid-argument", "Required parameters missing");
  }

  try {
    // Get user data
    const userDoc = await admin.firestore().collection("users").doc(userId).get();
    const userData = userDoc.data();

    if (!userData) {
      throw new functions.https.HttpsError("not-found", "User not found");
    }

    // If organization specified, verify ownership
    if (organizationId) {
      const orgDoc = await admin.firestore().collection("organizations").doc(organizationId).get();
      const orgData = orgDoc.data();

      if (!orgData || orgData.ownerId !== userId) {
        throw new functions.https.HttpsError("permission-denied", "Not authorized for this organization");
      }
    }

    // Create or get Stripe customer
    let customerId = userData.stripeCustomerId;

    if (!customerId) {
      const customer = await stripe.customers.create({
        email: userData.email,
        name: userData.displayName || undefined,
        metadata: {
          firebaseUID: userId,
          organizationId: organizationId || "",
        },
      });

      customerId = customer.id;

      // Save customer ID to user document
      await admin.firestore().collection("users").doc(userId).update({
        stripeCustomerId: customerId,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }

    // Create checkout session
    const session = await stripe.checkout.sessions.create({
      customer: customerId,
      payment_method_types: ["card"],
      line_items: [
        {
          price: priceId,
          quantity: 1,
        },
      ],
      mode: "subscription",
      success_url: successUrl,
      cancel_url: cancelUrl,
      metadata: {
        firebaseUID: userId,
        organizationId: organizationId || "",
      },
      subscription_data: {
        metadata: {
          firebaseUID: userId,
          organizationId: organizationId || "",
        },
      },
      allow_promotion_codes: true,
      billing_address_collection: "auto",
    });

    // Log the checkout session creation
    await admin.firestore().collection("checkoutSessions").add({
      sessionId: session.id,
      userId,
      organizationId: organizationId || null,
      priceId,
      status: "pending",
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return {
      sessionId: session.id,
      url: session.url,
    };
  } catch (error) {
    console.error("Error creating checkout session:", error);
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError("internal", "Failed to create checkout session");
  }
});
