import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

interface CreateOrganizationData {
  name: string;
  description?: string;
  type: "business" | "personal" | "enterprise";
  settings?: {
    allowGuestAccess?: boolean;
    requireApproval?: boolean;
  };
}

/**
 * Creates a new organization
 */
export const createOrganization = functions.https.onCall(async (data: CreateOrganizationData, context) => {
  // Check if user is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const {name, description, type, settings} = data;
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

    if (limits[subscription] !== -1 && existingOrgs.data().count >= limits[subscription]) {
      throw new functions.https.HttpsError(
        "resource-exhausted",
        `Organization limit reached for ${subscription} plan`
      );
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
      settings: {
        allowGuestAccess: settings?.allowGuestAccess || false,
        requireApproval: settings?.requireApproval || false,
        ...settings,
      },
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
    await admin.auth().setCustomUserClaims(userId, {
      ...currentClaims,
      organizations: [...(currentClaims.organizations || []), organizationId],
    });

    return {
      success: true,
      organizationId,
      organization: organizationData,
    };
  } catch (error) {
    console.error("Error creating organization:", error);
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError("internal", "Failed to create organization");
  }
});
