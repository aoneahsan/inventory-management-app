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
exports.updateUsageStats = exports.enforceSubscriptionLimits = exports.checkSubscriptionLimits = void 0;
const functions = __importStar(require("firebase-functions"));
const admin = __importStar(require("firebase-admin"));
/**
 * Checks if organization has reached subscription limits
 */
exports.checkSubscriptionLimits = functions.https.onCall(async (data, context) => {
    var _a, _b, _c, _d;
    // Check if user is authenticated
    if (!context.auth) {
        throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
    }
    const { organizationId, limitType, currentCount } = data;
    const userId = context.auth.uid;
    // Validate input
    if (!organizationId || !limitType) {
        throw new functions.https.HttpsError("invalid-argument", "Organization ID and limit type are required");
    }
    try {
        // Get organization data
        const orgDoc = await admin.firestore().collection("organizations").doc(organizationId).get();
        if (!orgDoc.exists) {
            throw new functions.https.HttpsError("not-found", "Organization not found");
        }
        const orgData = orgDoc.data();
        // Verify user is a member
        if (!((_a = orgData.members) === null || _a === void 0 ? void 0 : _a.includes(userId))) {
            throw new functions.https.HttpsError("permission-denied", "Not a member of this organization");
        }
        const subscription = orgData.subscription || {
            plan: "free",
            itemLimit: 100,
            memberLimit: 3,
            storageLimit: 1, // GB
        };
        let limit;
        let current;
        let usage;
        switch (limitType) {
            case "items":
                limit = subscription.itemLimit || 100;
                current = currentCount !== undefined ? currentCount : (((_b = orgData.stats) === null || _b === void 0 ? void 0 : _b.itemCount) || 0);
                break;
            case "members":
                limit = subscription.memberLimit || 3;
                current = currentCount !== undefined ? currentCount : (((_c = orgData.stats) === null || _c === void 0 ? void 0 : _c.memberCount) || 0);
                break;
            case "storage":
                limit = subscription.storageLimit || 1;
                current = currentCount !== undefined ? currentCount : (((_d = orgData.stats) === null || _d === void 0 ? void 0 : _d.storageUsed) || 0);
                break;
            default:
                throw new functions.https.HttpsError("invalid-argument", "Invalid limit type");
        }
        // Calculate usage percentage
        const usage = limit === -1 ? 0 : (current / limit) * 100;
        // Check if limit is reached
        const isLimitReached = limit !== -1 && current >= limit;
        const isNearLimit = limit !== -1 && usage >= 80;
        return {
            limitType,
            current,
            limit: limit === -1 ? "unlimited" : limit,
            usage: Math.round(usage),
            isLimitReached,
            isNearLimit,
            plan: subscription.plan,
            message: isLimitReached ?
                `You've reached your ${limitType} limit. Upgrade to add more.` :
                isNearLimit ?
                    `You're at ${Math.round(usage)}% of your ${limitType} limit.` :
                    null,
        };
    }
    catch (error) {
        console.error("Error checking limits:", error);
        if (error instanceof functions.https.HttpsError) {
            throw error;
        }
        throw new functions.https.HttpsError("internal", "Failed to check limits");
    }
});
/**
 * Enforces subscription limits before allowing operations
 */
const enforceSubscriptionLimits = async (organizationId, limitType, incrementBy = 1) => {
    var _a, _b, _c;
    try {
        const orgDoc = await admin.firestore().collection("organizations").doc(organizationId).get();
        if (!orgDoc.exists) {
            return { allowed: false, message: "Organization not found" };
        }
        const orgData = orgDoc.data();
        const subscription = orgData.subscription || {
            plan: "free",
            itemLimit: 100,
            memberLimit: 3,
            storageLimit: 1,
        };
        let limit;
        let current;
        switch (limitType) {
            case "items":
                limit = subscription.itemLimit || 100;
                current = ((_a = orgData.stats) === null || _a === void 0 ? void 0 : _a.itemCount) || 0;
                break;
            case "members":
                limit = subscription.memberLimit || 3;
                current = ((_b = orgData.stats) === null || _b === void 0 ? void 0 : _b.memberCount) || 0;
                break;
            case "storage":
                limit = subscription.storageLimit || 1;
                current = ((_c = orgData.stats) === null || _c === void 0 ? void 0 : _c.storageUsed) || 0;
                break;
            default:
                return { allowed: false, message: "Invalid limit type" };
        }
        // Check if adding would exceed limit
        if (limit !== -1 && (current + incrementBy) > limit) {
            const msg = `Adding ${incrementBy} ${limitType} would exceed your plan limit of ${limit}.`;
            return {
                allowed: false,
                message: `${msg} Please upgrade your subscription.`,
            };
        }
        return { allowed: true };
    }
    catch (error) {
        console.error("Error enforcing limits:", error);
        return { allowed: false, message: "Failed to check limits" };
    }
};
exports.enforceSubscriptionLimits = enforceSubscriptionLimits;
/**
 * Updates usage statistics for an organization
 */
exports.updateUsageStats = functions.https.onCall(async (data, context) => {
    var _a;
    // Check if user is authenticated
    if (!context.auth) {
        throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
    }
    const { organizationId, statType, increment } = data;
    const userId = context.auth.uid;
    // Validate input
    if (!organizationId || !statType || increment === undefined) {
        throw new functions.https.HttpsError("invalid-argument", "Required parameters missing");
    }
    try {
        // Verify user is a member
        const orgDoc = await admin.firestore().collection("organizations").doc(organizationId).get();
        if (!orgDoc.exists) {
            throw new functions.https.HttpsError("not-found", "Organization not found");
        }
        const orgData = orgDoc.data();
        if (!((_a = orgData.members) === null || _a === void 0 ? void 0 : _a.includes(userId))) {
            throw new functions.https.HttpsError("permission-denied", "Not a member of this organization");
        }
        // Update the stat
        const statField = `stats.${statType}`;
        await admin.firestore().collection("organizations").doc(organizationId).update({
            [statField]: admin.firestore.FieldValue.increment(increment),
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        return { success: true };
    }
    catch (error) {
        console.error("Error updating usage stats:", error);
        if (error instanceof functions.https.HttpsError) {
            throw error;
        }
        throw new functions.https.HttpsError("internal", "Failed to update usage stats");
    }
});
//# sourceMappingURL=checkLimits.js.map