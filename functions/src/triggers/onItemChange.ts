import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

/**
 * Triggered when an item is created, updated, or deleted
 * Updates organization statistics and logs activity
 */
export const onItemWrite = functions.firestore
  .document("items/{itemId}")
  .onWrite(async (change, context) => {
    const itemId = context.params.itemId;
    const beforeData = change.before.exists ? change.before.data() : null;
    const afterData = change.after.exists ? change.after.data() : null;

    // Determine the type of change
    let activityType: string;
    let organizationId: string | null = null;
    let userId: string | null = null;

    if (!beforeData && afterData) {
      // Created
      activityType = "item_created";
      organizationId = afterData.organizationId;
      userId = afterData.createdBy;
    } else if (beforeData && !afterData) {
      // Deleted
      activityType = "item_deleted";
      organizationId = beforeData.organizationId;
      userId = beforeData.deletedBy || beforeData.createdBy;
    } else if (beforeData && afterData) {
      // Updated
      activityType = "item_updated";
      organizationId = afterData.organizationId;
      userId = afterData.updatedBy || afterData.createdBy;
    } else {
      // Shouldn't happen
      console.error("Invalid state in onItemWrite trigger");
      return;
    }

    if (!organizationId) {
      console.error("No organization ID found for item");
      return;
    }

    try {
      const batch = admin.firestore().batch();

      // Update organization stats
      const orgRef = admin.firestore().collection("organizations").doc(organizationId);

      if (activityType === "item_created") {
        batch.update(orgRef, {
          "stats.itemCount": admin.firestore.FieldValue.increment(1),
          "updatedAt": admin.firestore.FieldValue.serverTimestamp(),
        });

        // Update category count if new category
        if (afterData!.categoryId) {
          const categoryRef = orgRef.collection("categories").doc(afterData!.categoryId);
          batch.update(categoryRef, {
            itemCount: admin.firestore.FieldValue.increment(1),
          });
        }
      } else if (activityType === "item_deleted") {
        batch.update(orgRef, {
          "stats.itemCount": admin.firestore.FieldValue.increment(-1),
          "updatedAt": admin.firestore.FieldValue.serverTimestamp(),
        });

        // Update category count
        if (beforeData!.categoryId) {
          const categoryRef = orgRef.collection("categories").doc(beforeData!.categoryId);
          batch.update(categoryRef, {
            itemCount: admin.firestore.FieldValue.increment(-1),
          });
        }
      } else if (activityType === "item_updated") {
        // Handle category changes
        const oldCategoryId = beforeData!.categoryId;
        const newCategoryId = afterData!.categoryId;

        if (oldCategoryId !== newCategoryId) {
          if (oldCategoryId) {
            const oldCategoryRef = orgRef.collection("categories").doc(oldCategoryId);
            batch.update(oldCategoryRef, {
              itemCount: admin.firestore.FieldValue.increment(-1),
            });
          }
          if (newCategoryId) {
            const newCategoryRef = orgRef.collection("categories").doc(newCategoryId);
            batch.update(newCategoryRef, {
              itemCount: admin.firestore.FieldValue.increment(1),
            });
          }
        }
      }

      // Log activity
      const activityRef = orgRef.collection("activities").doc();
      const activityData: any = {
        id: activityRef.id,
        type: activityType,
        itemId,
        userId,
        timestamp: admin.firestore.FieldValue.serverTimestamp(),
        metadata: {},
      };

      // Add relevant metadata
      if (activityType === "item_created") {
        activityData.metadata = {
          itemName: afterData!.name,
          categoryId: afterData!.categoryId || null,
          quantity: afterData!.quantity || 0,
        };
      } else if (activityType === "item_deleted") {
        activityData.metadata = {
          itemName: beforeData!.name,
        };
      } else if (activityType === "item_updated") {
        // Track what changed
        const changes: any = {};

        if (beforeData!.name !== afterData!.name) {
          changes.name = {from: beforeData!.name, to: afterData!.name};
        }
        if (beforeData!.quantity !== afterData!.quantity) {
          changes.quantity = {from: beforeData!.quantity, to: afterData!.quantity};
        }
        if (beforeData!.categoryId !== afterData!.categoryId) {
          changes.categoryId = {from: beforeData!.categoryId, to: afterData!.categoryId};
        }
        if (beforeData!.locationId !== afterData!.locationId) {
          changes.locationId = {from: beforeData!.locationId, to: afterData!.locationId};
        }

        activityData.metadata = {
          itemName: afterData!.name,
          changes,
        };
      }

      batch.set(activityRef, activityData);

      // Commit all changes
      await batch.commit();

      console.log(`Processed ${activityType} for item ${itemId}`);
    } catch (error) {
      console.error("Error processing item change:", error);
    }
  });

/**
 * Monitors low stock items and sends notifications
 */
export const checkLowStock = functions.pubsub
  .schedule("every 12 hours")
  .onRun(async () => {
    try {
      // Query all items with low stock
      const lowStockItems = await admin.firestore()
        .collection("items")
        .where("quantity", "<=", 5)
        .where("trackStock", "==", true)
        .get();

      if (lowStockItems.empty) {
        console.log("No low stock items found");
        return;
      }

      // Group by organization
      const itemsByOrg: { [orgId: string]: any[] } = {};

      lowStockItems.forEach((doc) => {
        const item = doc.data();
        const orgId = item.organizationId;

        if (!itemsByOrg[orgId]) {
          itemsByOrg[orgId] = [];
        }

        itemsByOrg[orgId].push({
          id: doc.id,
          name: item.name,
          quantity: item.quantity,
          minQuantity: item.minQuantity || 5,
        });
      });

      // Process each organization
      for (const [orgId, items] of Object.entries(itemsByOrg)) {
        // Get organization data
        const orgDoc = await admin.firestore().collection("organizations").doc(orgId).get();

        if (!orgDoc.exists) {
          continue;
        }

        const orgData = orgDoc.data()!;

        // Create notification for organization owner
        await admin.firestore().collection("notifications").add({
          userId: orgData.ownerId,
          organizationId: orgId,
          type: "low_stock_alert",
          title: "Low Stock Alert",
          message: `${items.length} items are running low on stock`,
          data: {
            items: items.slice(0, 5), // Show first 5 items
            totalCount: items.length,
          },
          read: false,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });

        // Log activity
        await admin.firestore()
          .collection("organizations")
          .doc(orgId)
          .collection("activities")
          .add({
            type: "low_stock_alert",
            itemCount: items.length,
            timestamp: admin.firestore.FieldValue.serverTimestamp(),
            metadata: {
              items: items.map((i) => ({id: i.id, name: i.name, quantity: i.quantity})),
            },
          });
      }

      console.log(`Processed low stock alerts for ${Object.keys(itemsByOrg).length} organizations`);
    } catch (error) {
      console.error("Error checking low stock:", error);
    }
  });
