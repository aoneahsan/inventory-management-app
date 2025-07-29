import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

/**
 * Triggered when an organization is deleted
 * Ensures proper cleanup of all related data
 */
export const onOrganizationDelete = functions.firestore
  .document("organizations/{organizationId}")
  .onDelete(async (snapshot, context) => {
    const organizationId = context.params.organizationId;
    const orgData = snapshot.data();

    console.log(`Starting cleanup for deleted organization: ${organizationId}`);

    try {
      const batch = admin.firestore().batch();

      // Delete all items
      const itemsSnapshot = await admin.firestore()
        .collection("items")
        .where("organizationId", "==", organizationId)
        .get();

      itemsSnapshot.forEach((doc) => {
        batch.delete(doc.ref);
      });

      // Delete all invitations
      const invitationsSnapshot = await admin.firestore()
        .collection("invitations")
        .where("organizationId", "==", organizationId)
        .get();

      invitationsSnapshot.forEach((doc) => {
        batch.delete(doc.ref);
      });

      // Remove organization from all user profiles
      const members = orgData.members || [];
      for (const memberId of members) {
        const userRef = admin.firestore().collection("users").doc(memberId);
        batch.update(userRef, {
          organizations: admin.firestore.FieldValue.arrayRemove(organizationId),
        });
      }

      await batch.commit();

      console.log(`Cleanup completed for organization: ${organizationId}`);
    } catch (error) {
      console.error("Error cleaning up organization data:", error);
    }
  });

/**
 * Triggered when category is created or updated
 * Updates organization category count
 */
export const onCategoryWrite = functions.firestore
  .document("organizations/{organizationId}/categories/{categoryId}")
  .onWrite(async (change, context) => {
    const {organizationId, categoryId} = context.params;
    const beforeExists = change.before.exists;
    const afterExists = change.after.exists;

    try {
      const orgRef = admin.firestore().collection("organizations").doc(organizationId);

      if (!beforeExists && afterExists) {
        // Category created
        await orgRef.update({
          "stats.categoryCount": admin.firestore.FieldValue.increment(1),
          "updatedAt": admin.firestore.FieldValue.serverTimestamp(),
        });

        // Log activity
        await orgRef.collection("activities").add({
          type: "category_created",
          categoryId,
          userId: change.after.data()!.createdBy,
          timestamp: admin.firestore.FieldValue.serverTimestamp(),
          metadata: {
            categoryName: change.after.data()!.name,
          },
        });
      } else if (beforeExists && !afterExists) {
        // Category deleted
        await orgRef.update({
          "stats.categoryCount": admin.firestore.FieldValue.increment(-1),
          "updatedAt": admin.firestore.FieldValue.serverTimestamp(),
        });

        // Move items from deleted category to uncategorized
        const itemsInCategory = await admin.firestore()
          .collection("items")
          .where("organizationId", "==", organizationId)
          .where("categoryId", "==", categoryId)
          .get();

        const batch = admin.firestore().batch();
        itemsInCategory.forEach((doc) => {
          batch.update(doc.ref, {
            categoryId: null,
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          });
        });
        await batch.commit();

        // Log activity
        await orgRef.collection("activities").add({
          type: "category_deleted",
          categoryId,
          timestamp: admin.firestore.FieldValue.serverTimestamp(),
          metadata: {
            categoryName: change.before.data()!.name,
            affectedItems: itemsInCategory.size,
          },
        });
      }
    } catch (error) {
      console.error("Error processing category change:", error);
    }
  });

/**
 * Triggered when location is created or updated
 * Updates organization location count
 */
export const onLocationWrite = functions.firestore
  .document("organizations/{organizationId}/locations/{locationId}")
  .onWrite(async (change, context) => {
    const {organizationId, locationId} = context.params;
    const beforeExists = change.before.exists;
    const afterExists = change.after.exists;

    try {
      const orgRef = admin.firestore().collection("organizations").doc(organizationId);

      if (!beforeExists && afterExists) {
        // Location created
        await orgRef.update({
          "stats.locationCount": admin.firestore.FieldValue.increment(1),
          "updatedAt": admin.firestore.FieldValue.serverTimestamp(),
        });

        // Log activity
        await orgRef.collection("activities").add({
          type: "location_created",
          locationId,
          userId: change.after.data()!.createdBy,
          timestamp: admin.firestore.FieldValue.serverTimestamp(),
          metadata: {
            locationName: change.after.data()!.name,
          },
        });
      } else if (beforeExists && !afterExists) {
        // Location deleted
        await orgRef.update({
          "stats.locationCount": admin.firestore.FieldValue.increment(-1),
          "updatedAt": admin.firestore.FieldValue.serverTimestamp(),
        });

        // Move items from deleted location to unassigned
        const itemsInLocation = await admin.firestore()
          .collection("items")
          .where("organizationId", "==", organizationId)
          .where("locationId", "==", locationId)
          .get();

        const batch = admin.firestore().batch();
        itemsInLocation.forEach((doc) => {
          batch.update(doc.ref, {
            locationId: null,
            updatedAt: admin.firestore.FieldValue.serverTimestamp(),
          });
        });
        await batch.commit();

        // Log activity
        await orgRef.collection("activities").add({
          type: "location_deleted",
          locationId,
          timestamp: admin.firestore.FieldValue.serverTimestamp(),
          metadata: {
            locationName: change.before.data()!.name,
            affectedItems: itemsInLocation.size,
          },
        });
      }
    } catch (error) {
      console.error("Error processing location change:", error);
    }
  });
