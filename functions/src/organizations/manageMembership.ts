import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

interface ManageMembershipData {
  organizationId: string;
  action: "add" | "remove" | "updateRole";
  targetUserId?: string;
  targetEmail?: string;
  role?: "member" | "admin" | "viewer";
}

/**
 * Manages organization membership (add/remove members, update roles)
 */
export const manageMembership = functions.https.onCall(async (data: ManageMembershipData, context) => {
  // Check if user is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "User must be authenticated");
  }

  const {organizationId, action, targetUserId, targetEmail, role} = data;
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

    const orgData = orgDoc.data()!;

    // Check if user has permission
    if (orgData.ownerId !== userId && !orgData.admins?.includes(userId)) {
      throw new functions.https.HttpsError("permission-denied", "Insufficient permissions");
    }

    let targetId = targetUserId;

    // If email provided, find user by email
    if (!targetId && targetEmail) {
      try {
        const userRecord = await admin.auth().getUserByEmail(targetEmail);
        targetId = userRecord.uid;
      } catch (error) {
        throw new functions.https.HttpsError("not-found", "User not found with provided email");
      }
    }

    if (!targetId) {
      throw new functions.https.HttpsError("invalid-argument", "Target user ID or email is required");
    }

    // Check member limits
    const currentMemberCount = orgData.members?.length || 0;
    const memberLimit = orgData.subscription?.memberLimit || 3;

    if (action === "add" && memberLimit !== -1 && currentMemberCount >= memberLimit) {
      throw new functions.https.HttpsError(
        "resource-exhausted",
        "Member limit reached for current subscription plan"
      );
    }

    // Perform the action
    switch (action) {
    case "add":
      await addMember(orgRef, orgData, targetId, role || "member");
      break;
    case "remove":
      await removeMember(orgRef, orgData, targetId);
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
  } catch (error) {
    console.error("Error managing membership:", error);
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError("internal", "Failed to manage membership");
  }
});

async function addMember(
  orgRef: admin.firestore.DocumentReference,
  orgData: any,
  userId: string,
  role: string
) {
  // Check if user is already a member
  if (orgData.members?.includes(userId)) {
    throw new functions.https.HttpsError("already-exists", "User is already a member");
  }

  // Update organization
  const updateData: any = {
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
    await admin.auth().setCustomUserClaims(userId, {
      ...currentClaims,
      organizations: [...(currentClaims.organizations || []), orgRef.id],
    });
  } catch (error) {
    console.error("Error updating user claims:", error);
  }
}

async function removeMember(
  orgRef: admin.firestore.DocumentReference,
  orgData: any,
  targetUserId: string
) {
  // Cannot remove the owner
  if (targetUserId === orgData.ownerId) {
    throw new functions.https.HttpsError("failed-precondition", "Cannot remove the organization owner");
  }

  // Check if user is a member
  if (!orgData.members?.includes(targetUserId)) {
    throw new functions.https.HttpsError("not-found", "User is not a member");
  }

  // Update organization
  const updateData: any = {
    "members": admin.firestore.FieldValue.arrayRemove(targetUserId),
    "updatedAt": admin.firestore.FieldValue.serverTimestamp(),
    "stats.memberCount": admin.firestore.FieldValue.increment(-1),
  };

  if (orgData.admins?.includes(targetUserId)) {
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
    const updatedOrgs = (currentClaims.organizations || []).filter(
      (orgId: string) => orgId !== orgRef.id
    );
    await admin.auth().setCustomUserClaims(targetUserId, {
      ...currentClaims,
      organizations: updatedOrgs,
    });
  } catch (error) {
    console.error("Error updating user claims:", error);
  }
}

async function updateMemberRole(
  orgRef: admin.firestore.DocumentReference,
  orgData: any,
  userId: string,
  newRole: string
) {
  // Check if user is a member
  if (!orgData.members?.includes(userId)) {
    throw new functions.https.HttpsError("not-found", "User is not a member");
  }

  // Cannot change owner's role
  if (userId === orgData.ownerId) {
    throw new functions.https.HttpsError("failed-precondition", "Cannot change the owner role");
  }

  const updateData: any = {
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  };

  // Update admin status based on new role
  if (newRole === "admin" && !orgData.admins?.includes(userId)) {
    updateData.admins = admin.firestore.FieldValue.arrayUnion(userId);
  } else if (newRole !== "admin" && orgData.admins?.includes(userId)) {
    updateData.admins = admin.firestore.FieldValue.arrayRemove(userId);
  }

  await orgRef.update(updateData);

  // Store role in organization member subcollection
  await orgRef.collection("members").doc(userId).set({
    role: newRole,
    updatedAt: admin.firestore.FieldValue.serverTimestamp(),
  }, {merge: true});
}
