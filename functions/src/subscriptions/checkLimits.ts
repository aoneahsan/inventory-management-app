import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

interface CheckLimitsData {
  organizationId: string;
  limitType: "items" | "members" | "storage";
  currentCount?: number;
}

/**
 * Checks if organization has reached subscription limits
 */
export const checkSubscriptionLimits = functions.https.onCall(async (data: CheckLimitsData, context) => {
  // Check if user is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const {organizationId, limitType, currentCount} = data;
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

    const orgData = orgDoc.data()!;

    // Verify user is a member
    if (!orgData.members?.includes(userId)) {
      throw new functions.https.HttpsError("permission-denied", "Not a member of this organization");
    }

    const subscription = orgData.subscription || {
      plan: "free",
      itemLimit: 100,
      memberLimit: 3,
      storageLimit: 1, // GB
    };

    let limit: number;
    let current: number;

    switch (limitType) {
    case "items":
      limit = subscription.itemLimit || 100;
      current = currentCount !== undefined ? currentCount : (orgData.stats?.itemCount || 0);
      break;

    case "members":
      limit = subscription.memberLimit || 3;
      current = currentCount !== undefined ? currentCount : (orgData.stats?.memberCount || 0);
      break;

    case "storage":
      limit = subscription.storageLimit || 1;
      current = currentCount !== undefined ? currentCount : (orgData.stats?.storageUsed || 0);
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
  } catch (error) {
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
export const enforceSubscriptionLimits = async (
  organizationId: string,
  limitType: "items" | "members" | "storage",
  incrementBy: number = 1
): Promise<{ allowed: boolean; message?: string }> => {
  try {
    const orgDoc = await admin.firestore().collection("organizations").doc(organizationId).get();

    if (!orgDoc.exists) {
      return {allowed: false, message: "Organization not found"};
    }

    const orgData = orgDoc.data()!;
    const subscription = orgData.subscription || {
      plan: "free",
      itemLimit: 100,
      memberLimit: 3,
      storageLimit: 1,
    };

    let limit: number;
    let current: number;

    switch (limitType) {
    case "items":
      limit = subscription.itemLimit || 100;
      current = orgData.stats?.itemCount || 0;
      break;

    case "members":
      limit = subscription.memberLimit || 3;
      current = orgData.stats?.memberCount || 0;
      break;

    case "storage":
      limit = subscription.storageLimit || 1;
      current = orgData.stats?.storageUsed || 0;
      break;

    default:
      return {allowed: false, message: "Invalid limit type"};
    }

    // Check if adding would exceed limit
    if (limit !== -1 && (current + incrementBy) > limit) {
      const msg = `Adding ${incrementBy} ${limitType} would exceed your plan limit of ${limit}.`;
      return {
        allowed: false,
        message: `${msg} Please upgrade your subscription.`,
      };
    }

    return {allowed: true};
  } catch (error) {
    console.error("Error enforcing limits:", error);
    return {allowed: false, message: "Failed to check limits"};
  }
};

/**
 * Updates usage statistics for an organization
 */
export const updateUsageStats = functions.https.onCall(async (data, context) => {
  // Check if user is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const {organizationId, statType, increment} = data;
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

    const orgData = orgDoc.data()!;

    if (!orgData.members?.includes(userId)) {
      throw new functions.https.HttpsError("permission-denied", "Not a member of this organization");
    }

    // Update the stat
    const statField = `stats.${statType}`;
    await admin.firestore().collection("organizations").doc(organizationId).update({
      [statField]: admin.firestore.FieldValue.increment(increment),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return {success: true};
  } catch (error) {
    console.error("Error updating usage stats:", error);
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError("internal", "Failed to update usage stats");
  }
});
