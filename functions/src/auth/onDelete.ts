import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

/**
 * Triggered when a user is deleted
 * Cleans up user data and references
 */
export const onUserDelete = functions.auth.user().onDelete(async (user) => {
  const {uid} = user;

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
  } catch (error) {
    console.error("Error cleaning up user data:", error);
    throw new functions.https.HttpsError("internal", "Failed to clean up user data");
  }
});
