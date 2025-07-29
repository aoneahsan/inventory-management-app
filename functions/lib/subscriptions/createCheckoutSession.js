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
exports.createCheckoutSession = void 0;
const functions = __importStar(require("firebase-functions"));
const admin = __importStar(require("firebase-admin"));
const stripe_1 = __importDefault(require("stripe"));
// Initialize Stripe with your secret key from Firebase config
const stripe = new stripe_1.default(((_a = functions.config().stripe) === null || _a === void 0 ? void 0 : _a.secret_key) || "", {
    apiVersion: "2023-10-16",
});
/**
 * Creates a Stripe checkout session for subscription
 */
exports.createCheckoutSession = functions.https.onCall(async (data, context) => {
    // Check if user is authenticated
    if (!context.auth) {
        throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
    }
    const { priceId, organizationId, successUrl, cancelUrl } = data;
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
    }
    catch (error) {
        console.error("Error creating checkout session:", error);
        if (error instanceof functions.https.HttpsError) {
            throw error;
        }
        throw new functions.https.HttpsError("internal", "Failed to create checkout session");
    }
});
//# sourceMappingURL=createCheckoutSession.js.map