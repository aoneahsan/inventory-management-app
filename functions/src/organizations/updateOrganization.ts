import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

interface UpdateOrganizationData {
  organizationId: string;
  updates: {
    name?: string;
    description?: string;
    settings?: any;
  };
}

/**
 * Updates an organization's details
 */
export const updateOrganization = functions.https.onCall(async (data: UpdateOrganizationData, context) => {
  // Check if user is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const {organizationId, updates} = data;
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

    const orgData = orgDoc.data()!;

    // Check if user has permission to update
    if (orgData.ownerId !== userId && !orgData.admins?.includes(userId)) {
      throw new functions.https.HttpsError("permission-denied", "Insufficient permissions");
    }

    // Prepare update data
    const updateData: any = {
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
      updateData.settings = {
        ...orgData.settings,
        ...updates.settings,
      };
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
  } catch (error) {
    console.error("Error updating organization:", error);
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError("internal", "Failed to update organization");
  }
});
