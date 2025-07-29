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
exports.manageMembership = void 0;
const functions = __importStar(require("firebase-functions"));
const admin = __importStar(require("firebase-admin"));
/**
 * Manages organization membership (add/remove members, update roles)
 */
exports.manageMembership = functions.https.onCall(async (data, context) => {
    var _a, _b, _c;
    // Check if user is authenticated
    if (!context.auth) {
        throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
    }
    const { organizationId, action, targetUserId, targetEmail, role } = data;
    const userId = context.auth.uid;
    // Validate input
    if (!organizationId || !action) {
        throw new functions.https.HttpsError("invalid-argument", "Organization ID and action are required");
    }
    try {
        // Get organization document
        const orgRef = admin.firestore().collection("organizations").doc(organizationId);
        const orgDoc = await orgRef.get();
        if (!orgDoc.exists) {
            throw new functions.https.HttpsError("not-found", "Organization not found");
        }
        const orgData = orgDoc.data();
        // Check if user has permission
        if (orgData.ownerId !== userId && !((_a = orgData.admins) === null || _a === void 0 ? void 0 : _a.includes(userId))) {
            throw new functions.https.HttpsError("permission-denied", "Insufficient permissions");
        }
        let targetId = targetUserId;
        // If email provided, find user by email
        if (!targetId && targetEmail) {
            try {
                const userRecord = await admin.auth().getUserByEmail(targetEmail);
                targetId = userRecord.uid;
            }
            catch (error) {
                throw new functions.https.HttpsError("not-found", "User not found with provided email");
            }
        }
        if (!targetId) {
            throw new functions.https.HttpsError("invalid-argument", "Target user ID or email is required");
        }
        // Check member limits
        const currentMemberCount = ((_b = orgData.members) === null || _b === void 0 ? void 0 : _b.length) || 0;
        const memberLimit = ((_c = orgData.subscription) === null || _c === void 0 ? void 0 : _c.memberLimit) || 3;
        if (action === "add" && memberLimit !== -1 && currentMemberCount >= memberLimit) {
            throw new functions.https.HttpsError("resource-exhausted", "Member limit reached for current subscription plan");
        }
        // Perform the action
        switch (action) {
            case "add":
                await addMember(orgRef, orgData, targetId, role || "member");
                break;
            case "remove":
                await removeMember(orgRef, orgData, targetId, userId);
                break;
            case "updateRole":
                if (!role) {
                    throw new functions.https.HttpsError("invalid-argument", "Role is required for updateRole action");
                }
                await updateMemberRole(orgRef, orgData, targetId, role);
                break;
        }
        // Log activity
        await admin.firestore().collection("organizations").doc(organizationId)
            .collection("activities").add({
            type: `member_${action}`,
            userId,
            targetUserId: targetId,
            role,
            timestamp: admin.firestore.FieldValue.serverTimestamp(),
        });
        return {
            success: true,
            message: `Member ${action} successful`,
        };
    }
    catch (error) {
        console.error("Error managing membership:", error);
        if (error instanceof functions.https.HttpsError) {
            throw error;
        }
        throw new functions.https.HttpsError("internal", "Failed to manage membership");
    }
});
async function addMember(orgRef, orgData, userId, role) {
    var _a;
    // Check if user is already a member
    if ((_a = orgData.members) === null || _a === void 0 ? void 0 : _a.includes(userId)) {
        throw new functions.https.HttpsError("already-exists", "User is already a member");
    }
    // Update organization
    const updateData = {
        "members": admin.firestore.FieldValue.arrayUnion(userId),
        "updatedAt": admin.firestore.FieldValue.serverTimestamp(),
        "stats.memberCount": admin.firestore.FieldValue.increment(1),
    };
    if (role === "admin") {
        updateData.admins = admin.firestore.FieldValue.arrayUnion(userId);
    }
    await orgRef.update(updateData);
    // Update user document
    await admin.firestore().collection("users").doc(userId).update({
        organizations: admin.firestore.FieldValue.arrayUnion(orgRef.id),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    // Update user claims
    try {
        const user = await admin.auth().getUser(userId);
        const currentClaims = user.customClaims || {};
        await admin.auth().setCustomUserClaims(userId, Object.assign(Object.assign({}, currentClaims), { organizations: [...(currentClaims.organizations || []), orgRef.id] }));
    }
    catch (error) {
        console.error("Error updating user claims:", error);
    }
}
async function removeMember(orgRef, orgData, targetUserId) {
    var _a, _b;
    // Cannot remove the owner
    if (targetUserId === orgData.ownerId) {
        throw new functions.https.HttpsError("failed-precondition", "Cannot remove the organization owner");
    }
    // Check if user is a member
    if (!((_a = orgData.members) === null || _a === void 0 ? void 0 : _a.includes(targetUserId))) {
        throw new functions.https.HttpsError("not-found", "User is not a member");
    }
    // Update organization
    const updateData = {
        "members": admin.firestore.FieldValue.arrayRemove(targetUserId),
        "updatedAt": admin.firestore.FieldValue.serverTimestamp(),
        "stats.memberCount": admin.firestore.FieldValue.increment(-1),
    };
    if ((_b = orgData.admins) === null || _b === void 0 ? void 0 : _b.includes(targetUserId)) {
        updateData.admins = admin.firestore.FieldValue.arrayRemove(targetUserId);
    }
    await orgRef.update(updateData);
    // Update user document
    await admin.firestore().collection("users").doc(targetUserId).update({
        organizations: admin.firestore.FieldValue.arrayRemove(orgRef.id),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    // Update user claims
    try {
        const user = await admin.auth().getUser(targetUserId);
        const currentClaims = user.customClaims || {};
        const updatedOrgs = (currentClaims.organizations || []).filter((orgId) => orgId !== orgRef.id);
        await admin.auth().setCustomUserClaims(targetUserId, Object.assign(Object.assign({}, currentClaims), { organizations: updatedOrgs }));
    }
    catch (error) {
        console.error("Error updating user claims:", error);
    }
}
async function updateMemberRole(orgRef, orgData, userId, newRole) {
    var _a, _b, _c;
    // Check if user is a member
    if (!((_a = orgData.members) === null || _a === void 0 ? void 0 : _a.includes(userId))) {
        throw new functions.https.HttpsError("not-found", "User is not a member");
    }
    // Cannot change owner's role
    if (userId === orgData.ownerId) {
        throw new functions.https.HttpsError("failed-precondition", "Cannot change the owner role");
    }
    const updateData = {
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };
    // Update admin status based on new role
    if (newRole === "admin" && !((_b = orgData.admins) === null || _b === void 0 ? void 0 : _b.includes(userId))) {
        updateData.admins = admin.firestore.FieldValue.arrayUnion(userId);
    }
    else if (newRole !== "admin" && ((_c = orgData.admins) === null || _c === void 0 ? void 0 : _c.includes(userId))) {
        updateData.admins = admin.firestore.FieldValue.arrayRemove(userId);
    }
    await orgRef.update(updateData);
    // Store role in organization member subcollection
    await orgRef.collection("members").doc(userId).set({
        role: newRole,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    }, { merge: true });
}
//# sourceMappingURL=manageMembership.js.map