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
exports.handleStripeWebhook = void 0;
const functions = __importStar(require("firebase-functions"));
const admin = __importStar(require("firebase-admin"));
const stripe_1 = __importDefault(require("stripe"));
// Initialize Stripe
const stripe = new stripe_1.default(((_a = functions.config().stripe) === null || _a === void 0 ? void 0 : _a.secret_key) || "", {
    apiVersion: "2023-10-16",
});
/**
 * Handles Stripe webhook events
 */
exports.handleStripeWebhook = functions.https.onRequest(async (req, res) => {
    var _a;
    // Only accept POST requests
    if (req.method !== "POST") {
        res.status(405).send("Method Not Allowed");
        return;
    }
    const sig = req.headers["stripe-signature"];
    const webhookSecret = (_a = functions.config().stripe) === null || _a === void 0 ? void 0 : _a.webhook_secret;
    if (!sig || !webhookSecret) {
        console.error("Missing stripe signature or webhook secret");
        res.status(400).send("Webhook Error: Missing signature or secret");
        return;
    }
    let event;
    try {
        // Verify webhook signature
        event = stripe.webhooks.constructEvent(req.rawBody, sig, webhookSecret);
    }
    catch (err) {
        console.error("Webhook signature verification failed:", err);
        const errMsg = err instanceof Error ? err.message : "Unknown error";
        res.status(400).send(`Webhook Error: ${errMsg}`);
        return;
    }
    // Handle the event
    try {
        switch (event.type) {
            case "checkout.session.completed":
                await handleCheckoutSessionCompleted(event.data.object);
                break;
            case "customer.subscription.created":
            case "customer.subscription.updated":
                await handleSubscriptionUpdate(event.data.object);
                break;
            case "customer.subscription.deleted":
                await handleSubscriptionDeleted(event.data.object);
                break;
            case "invoice.payment_succeeded":
                await handleInvoicePaymentSucceeded(event.data.object);
                break;
            case "invoice.payment_failed":
                await handleInvoicePaymentFailed(event.data.object);
                break;
            default:
                console.log(`Unhandled event type: ${event.type}`);
        }
        res.status(200).json({ received: true });
    }
    catch (error) {
        console.error("Error processing webhook:", error);
        res.status(500).send("Webhook processing failed");
    }
});
async function handleCheckoutSessionCompleted(session) {
    const { subscription, metadata } = session;
    const userId = metadata === null || metadata === void 0 ? void 0 : metadata.firebaseUID;
    const organizationId = metadata === null || metadata === void 0 ? void 0 : metadata.organizationId;
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
async function handleSubscriptionUpdate(subscription) {
    var _a, _b;
    const userId = (_a = subscription.metadata) === null || _a === void 0 ? void 0 : _a.firebaseUID;
    const organizationId = (_b = subscription.metadata) === null || _b === void 0 ? void 0 : _b.organizationId;
    if (!userId) {
        console.error("No user ID in subscription metadata");
        return;
    }
    await updateUserSubscription(userId, subscription, organizationId);
}
async function handleSubscriptionDeleted(subscription) {
    var _a, _b;
    const userId = (_a = subscription.metadata) === null || _a === void 0 ? void 0 : _a.firebaseUID;
    const organizationId = (_b = subscription.metadata) === null || _b === void 0 ? void 0 : _b.organizationId;
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
    }
    else {
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
async function handleInvoicePaymentSucceeded(invoice) {
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
async function handleInvoicePaymentFailed(invoice) {
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
async function updateUserSubscription(userId, subscription, organizationId) {
    var _a, _b;
    const item = subscription.items.data[0];
    const priceId = item.price.id;
    // Map price IDs to plan names
    const planMap = {
        [((_a = functions.config().stripe) === null || _a === void 0 ? void 0 : _a.price_pro) || ""]: "pro",
        [((_b = functions.config().stripe) === null || _b === void 0 ? void 0 : _b.price_enterprise) || ""]: "enterprise",
    };
    const plan = planMap[priceId] || "free";
    const currentPeriodEnd = new Date(subscription.current_period_end * 1000);
    // Define plan limits
    const planLimits = {
        free: { itemLimit: 100, memberLimit: 3 },
        pro: { itemLimit: 1000, memberLimit: 10 },
        enterprise: { itemLimit: -1, memberLimit: -1 }, // unlimited
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
    }
    else {
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
        if (userData === null || userData === void 0 ? void 0 : userData.organizations) {
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
//# sourceMappingURL=handleWebhook.js.map