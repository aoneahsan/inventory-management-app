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
exports.updateUserClaims = void 0;
const functions = __importStar(require("firebase-functions"));
const admin = __importStar(require("firebase-admin"));
/**
 * Updates user custom claims based on their role and organizations
 */
exports.updateUserClaims = functions.https.onCall(async (data, context) => {
    // Check if user is authenticated
    if (!context.auth) {
        throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
    }
    const { userId, role, organizationId } = data;
    const requestingUserId = context.auth.uid;
    try {
        // Verify the requesting user has permission to update claims
        const requestingUserDoc = await admin.firestore()
            .collection("users")
            .doc(requestingUserId)
            .get();
        const requestingUserData = requestingUserDoc.data();
        if (!requestingUserData || requestingUserData.role !== "admin") {
            // Check if user is an organization admin
            if (organizationId) {
                const orgDoc = await admin.firestore()
                    .collection("organizations")
                    .doc(organizationId)
                    .get();
                const orgData = orgDoc.data();
                if (!orgData || orgData.ownerId !== requestingUserId) {
                    throw new functions.https.HttpsError("permission-denied", "Insufficient permissions");
                }
            }
            else {
                throw new functions.https.HttpsError("permission-denied", "Insufficient permissions");
            }
        }
        // Get current user claims
        const user = await admin.auth().getUser(userId);
        const currentClaims = user.customClaims || {};
        // Update claims
        const newClaims = Object.assign(Object.assign({}, currentClaims), { role: role || currentClaims.role || "user", organizations: currentClaims.organizations || [] });
        // Add organization if specified
        if (organizationId && !newClaims.organizations.includes(organizationId)) {
            newClaims.organizations.push(organizationId);
        }
        await admin.auth().setCustomUserClaims(userId, newClaims);
        // Update user document
        await admin.firestore().collection("users").doc(userId).update({
            role: newClaims.role,
            organizations: newClaims.organizations,
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        return {
            success: true,
            claims: newClaims,
        };
    }
    catch (error) {
        console.error("Error updating user claims:", error);
        throw new functions.https.HttpsError("internal", "Failed to update user claims");
    }
});
//# sourceMappingURL=customClaims.js.map