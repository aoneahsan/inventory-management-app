import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

/**
 * Updates user custom claims based on their role and organizations
 */
export const updateUserClaims = functions.https.onCall(async (data, context) => {
  // Check if user is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const {userId, role, organizationId} = data;
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
      } else {
        throw new functions.https.HttpsError("permission-denied", "Insufficient permissions");
      }
    }

    // Get current user claims
    const user = await admin.auth().getUser(userId);
    const currentClaims = user.customClaims || {};

    // Update claims
    const newClaims = {
      ...currentClaims,
      role: role || currentClaims.role || "user",
      organizations: currentClaims.organizations || [],
    };

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
  } catch (error) {
    console.error("Error updating user claims:", error);
    throw new functions.https.HttpsError("internal", "Failed to update user claims");
  }
});
