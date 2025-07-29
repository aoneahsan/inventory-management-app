import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

/**
 * Triggered when a new user is created
 * Sets up initial user profile and permissions
 */
export const onUserCreate = functions.auth.user().onCreate(async (user) => {
  const {uid, email, displayName, photoURL} = user;

  try {
    // Create user profile document
    await admin.firestore().collection("users").doc(uid).set({
      uid,
      email,
      displayName: displayName || null,
      photoURL: photoURL || null,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      role: "user",
      organizations: [],
      settings: {
        notifications: {
          email: true,
          push: true,
        },
        theme: "light",
      },
    });

    // Set default custom claims
    await admin.auth().setCustomUserClaims(uid, {
      role: "user",
      organizations: [],
    });

    console.log(`User profile created for ${uid}`);
  } catch (error) {
    console.error("Error creating user profile:", error);
    throw new functions.https.HttpsError("internal", "Failed to create user profile");
  }
});
