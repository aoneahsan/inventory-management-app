"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
var _a;
Object.defineProperty(exports, "__esModule", { value: true });
exports.createBillingPortalSession = exports.manageSubscription = void 0;
const functions = __importStar(require("firebase-functions"));
const admin = __importStar(require("firebase-admin"));
const stripe_1 = __importDefault(require("stripe"));
// Initialize Stripe
const stripe = new stripe_1.default(((_a = functions.config().stripe) === null || _a === void 0 ? void 0 : _a.secret_key) || "", {
    apiVersion: "2023-10-16",
});
/**
 * Manages existing subscriptions (cancel, resume, change plan)
 */
exports.manageSubscription = functions.https.onCall(async (data, context) => {
    var _a;
    // Check if user is authenticated
    if (!context.auth) {
        throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
    }
    const { action, organizationId, newPriceId } = data;
    const userId = context.auth.uid;
    try {
        let subscriptionId = null;
        // Get subscription ID based on context
        if (organizationId) {
            // Organization subscription
            const orgDoc = await admin.firestore().collection("organizations").doc(organizationId).get();
            const orgData = orgDoc.data();
            if (!orgData || orgData.ownerId !== userId) {
                throw new functions.https.HttpsError("permission-denied", "Not authorized for this organization");
            }
            subscriptionId = (_a = orgData.subscription) === null || _a === void 0 ? void 0 : _a.stripeSubscriptionId;
        }
        else {
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
    }
    catch (error) {
        console.error("Error managing subscription:", error);
        if (error instanceof functions.https.HttpsError) {
            throw error;
        }
        throw new functions.https.HttpsError("internal", "Failed to manage subscription");
    }
});
async function cancelSubscription(subscriptionId) {
    try {
        // Cancel at period end (allows user to use subscription until end of billing period)
        const subscription = await stripe.subscriptions.update(subscriptionId, {
            cancel_at_period_end: true,
        });
        return {
            message: "Subscription will be canceled at the end of the current billing period",
            cancelAt: new Date(subscription.cancel_at * 1000).toISOString(),
        };
    }
    catch (error) {
        console.error("Error canceling subscription:", error);
        throw new functions.https.HttpsError("internal", "Failed to cancel subscription");
    }
}
async function resumeSubscription(subscriptionId) {
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
    }
    catch (error) {
        console.error("Error resuming subscription:", error);
        if (error instanceof functions.https.HttpsError) {
            throw error;
        }
        throw new functions.https.HttpsError("internal", "Failed to resume subscription");
    }
}
async function changePlan(subscriptionId, newPriceId) {
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
    }
    catch (error) {
        console.error("Error changing plan:", error);
        throw new functions.https.HttpsError("internal", "Failed to change plan");
    }
}
/**
 * Get customer portal session for managing billing
 */
exports.createBillingPortalSession = functions.https.onCall(async (data, context) => {
    // Check if user is authenticated
    if (!context.auth) {
        throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
    }
    const { returnUrl } = data;
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
    }
    catch (error) {
        console.error("Error creating billing portal session:", error);
        throw new functions.https.HttpsError("internal", "Failed to create billing portal session");
    }
});
//# sourceMappingURL=manageSubscription.js.map