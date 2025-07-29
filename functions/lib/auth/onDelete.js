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
exports.onUserDelete = void 0;
const functions = __importStar(require("firebase-functions"));
const admin = __importStar(require("firebase-admin"));
/**
 * Triggered when a user is deleted
 * Cleans up user data and references
 */
exports.onUserDelete = functions.auth.user().onDelete(async (user) => {
    const { uid } = user;
    try {
        const batch = admin.firestore().batch();
        // Delete user profile
        const userRef = admin.firestore().collection("users").doc(uid);
        batch.delete(userRef);
        // Remove user from all organizations
        const organizationsSnapshot = await admin.firestore()
            .collection("organizations")
            .where("members", "array-contains", uid)
            .get();
        organizationsSnapshot.forEach((doc) => {
            batch.update(doc.ref, {
                members: admin.firestore.FieldValue.arrayRemove(uid),
                updatedAt: admin.firestore.FieldValue.serverTimestamp(),
            });
        });
        // Delete user's created items (optional - depends on business logic)
        // You might want to transfer ownership instead
        const itemsSnapshot = await admin.firestore()
            .collection("items")
            .where("createdBy", "==", uid)
            .get();
        itemsSnapshot.forEach((doc) => {
            batch.update(doc.ref, {
                deletedBy: uid,
                deletedAt: admin.firestore.FieldValue.serverTimestamp(),
                isDeleted: true,
            });
        });
        await batch.commit();
        console.log(`User data cleaned up for ${uid}`);
    }
    catch (error) {
        console.error("Error cleaning up user data:", error);
        throw new functions.https.HttpsError("internal", "Failed to clean up user data");
    }
});
//# sourceMappingURL=onDelete.js.map