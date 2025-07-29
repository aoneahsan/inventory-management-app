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
exports.updateOrganization = void 0;
const functions = __importStar(require("firebase-functions"));
const admin = __importStar(require("firebase-admin"));
/**
 * Updates an organization's details
 */
exports.updateOrganization = functions.https.onCall(async (data, context) => {
    var _a;
    // Check if user is authenticated
    if (!context.auth) {
        throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
    }
    const { organizationId, updates } = data;
    const userId = context.auth.uid;
    // Validate input
    if (!organizationId || !updates) {
        throw new functions.https.HttpsError("invalid-argument", "Organization ID and updates are required");
    }
    try {
        // Get organization document
        const orgRef = admin.firestore().collection("organizations").doc(organizationId);
        const orgDoc = await orgRef.get();
        if (!orgDoc.exists) {
            throw new functions.https.HttpsError("not-found", "Organization not found");
        }
        const orgData = orgDoc.data();
        // Check if user has permission to update
        if (orgData.ownerId !== userId && !((_a = orgData.admins) === null || _a === void 0 ? void 0 : _a.includes(userId))) {
            throw new functions.https.HttpsError("permission-denied", "Insufficient permissions");
        }
        // Prepare update data
        const updateData = {
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        };
        // Add allowed fields to update
        if (updates.name) {
            updateData.name = updates.name;
        }
        if (updates.description !== undefined) {
            updateData.description = updates.description;
        }
        if (updates.settings) {
            updateData.settings = Object.assign(Object.assign({}, orgData.settings), updates.settings);
        }
        // Update organization
        await orgRef.update(updateData);
        // Log activity
        await admin.firestore().collection("organizations").doc(organizationId)
            .collection("activities").add({
            type: "organization_updated",
            userId,
            changes: updates,
            timestamp: admin.firestore.FieldValue.serverTimestamp(),
        });
        return {
            success: true,
            message: "Organization updated successfully",
        };
    }
    catch (error) {
        console.error("Error updating organization:", error);
        if (error instanceof functions.https.HttpsError) {
            throw error;
        }
        throw new functions.https.HttpsError("internal", "Failed to update organization");
    }
});
//# sourceMappingURL=updateOrganization.js.map