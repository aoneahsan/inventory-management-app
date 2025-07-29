import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

interface DeleteOrganizationData {
  organizationId: string;
  confirmDelete: boolean;
}

/**
 * Deletes an organization and all related data
 */
export const deleteOrganization = functions.https.onCall(async (data: DeleteOrganizationData, context) => {
  // Check if user is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const {organizationId, confirmDelete} = data;
  const userId = context.auth.uid;

  // Validate input
  if (!organizationId || !confirmDelete) {
    throw new functions.https.HttpsError("invalid-argument", "Organization ID and confirmation are required");
  }

  try {
    // Get organization document
    const orgRef = admin.firestore().collection("organizations").doc(organizationId);
    const orgDoc = await orgRef.get();

    if (!orgDoc.exists) {
      throw new functions.https.HttpsError("not-found", "Organization not found");
    }

    const orgData = orgDoc.data()!;

    // Check if user is the owner
    if (orgData.ownerId !== userId) {
      throw new functions.https.HttpsError("permission-denied", "Only the owner can delete the organization");
    }

    // Start batch deletion
    const batch = admin.firestore().batch();

    // Delete all items in the organization
    const itemsSnapshot = await admin.firestore()
      .collection("items")
      .where("organizationId", "==", organizationId)
      .get();

    itemsSnapshot.forEach((doc) => {
      batch.delete(doc.ref);
    });

    // Delete all categories
    const categoriesSnapshot = await admin.firestore()
      .collection("organizations")
      .doc(organizationId)
      .collection("categories")
      .get();

    categoriesSnapshot.forEach((doc) => {
      batch.delete(doc.ref);
    });

    // Delete all locations
    const locationsSnapshot = await admin.firestore()
      .collection("organizations")
      .doc(organizationId)
      .collection("locations")
      .get();

    locationsSnapshot.forEach((doc) => {
      batch.delete(doc.ref);
    });

    // Delete all activities
    const activitiesSnapshot = await admin.firestore()
      .collection("organizations")
      .doc(organizationId)
      .collection("activities")
      .get();

    activitiesSnapshot.forEach((doc) => {
      batch.delete(doc.ref);
    });

    // Remove organization from all members
    const members = orgData.members || [];
    for (const memberId of members) {
      const memberRef = admin.firestore().collection("users").doc(memberId);
      batch.update(memberRef, {
        organizations: admin.firestore.FieldValue.arrayRemove(organizationId),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      // Update custom claims
      try {
        const user = await admin.auth().getUser(memberId);
        const currentClaims = user.customClaims || {};
        const updatedOrgs = (currentClaims.organizations || []).filter(
          (orgId: string) => orgId !== organizationId
        );
        await admin.auth().setCustomUserClaims(memberId, {
          ...currentClaims,
          organizations: updatedOrgs,
        });
      } catch (claimError) {
        console.error(`Error updating claims for user ${memberId}:`, claimError);
      }
    }

    // Delete the organization document
    batch.delete(orgRef);

    // Commit all deletions
    await batch.commit();

    return {
      success: true,
      message: "Organization deleted successfully",
    };
  } catch (error) {
    console.error("Error deleting organization:", error);
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError("internal", "Failed to delete organization");
  }
});
