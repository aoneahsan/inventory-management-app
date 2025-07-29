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
Object.defineProperty(exports, "__esModule", { value: true });
exports.createOrganization = void 0;
const functions = __importStar(require("firebase-functions"));
const admin = __importStar(require("firebase-admin"));
/**
 * Creates a new organization
 */
exports.createOrganization = functions.https.onCall(async (data, context) => {
    // Check if user is authenticated
    if (!context.auth) {
        throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
    }
    const { name, description, type, settings } = data;
    const userId = context.auth.uid;
    // Validate input
    if (!name || !type) {
        throw new functions.https.HttpsError("invalid-argument", "Name and type are required");
    }
    try {
        // Check user's subscription limits
        const userDoc = await admin.firestore().collection("users").doc(userId).get();
        const userData = userDoc.data();
        if (!userData) {
            throw new functions.https.HttpsError("not-found", "User not found");
        }
        // Count existing organizations
        const existingOrgs = await admin.firestore()
            .collection("organizations")
            .where("ownerId", "==", userId)
            .count()
            .get();
        // Check limits based on subscription
        const subscription = userData.subscription || "free";
        const limits = {
            free: 1,
            pro: 5,
            enterprise: -1, // unlimited
        };
        const subscriptionLimit = limits[subscription];
        if (subscriptionLimit !== -1 && existingOrgs.data().count >= subscriptionLimit) {
            throw new functions.https.HttpsError("resource-exhausted", `Organization limit reached for ${subscription} plan`);
        }
        // Create organization document
        const organizationRef = admin.firestore().collection("organizations").doc();
        const organizationId = organizationRef.id;
        const organizationData = {
            id: organizationId,
            name,
            description: description || "",
            type,
            ownerId: userId,
            members: [userId],
            settings: Object.assign({ allowGuestAccess: (settings === null || settings === void 0 ? void 0 : settings.allowGuestAccess) || false, requireApproval: (settings === null || settings === void 0 ? void 0 : settings.requireApproval) || false }, settings),
            subscription: {
                plan: subscription,
                status: "active",
                itemLimit: subscription === "free" ? 100 : subscription === "pro" ? 1000 : -1,
                memberLimit: subscription === "free" ? 3 : subscription === "pro" ? 10 : -1,
            },
            stats: {
                itemCount: 0,
                memberCount: 1,
                categoryCount: 0,
                locationCount: 0,
            },
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        };
        await organizationRef.set(organizationData);
        // Update user's organizations
        await admin.firestore().collection("users").doc(userId).update({
            organizations: admin.firestore.FieldValue.arrayUnion(organizationId),
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        // Update user's custom claims
        const user = await admin.auth().getUser(userId);
        const currentClaims = user.customClaims || {};
        await admin.auth().setCustomUserClaims(userId, Object.assign(Object.assign({}, currentClaims), { organizations: [...(currentClaims.organizations || []), organizationId] }));
        return {
            success: true,
            organizationId,
            organization: organizationData,
        };
    }
    catch (error) {
        console.error("Error creating organization:", error);
        if (error instanceof functions.https.HttpsError) {
            throw error;
        }
        throw new functions.https.HttpsError("internal", "Failed to create organization");
    }
});
//# sourceMappingURL=createOrganization.js.map