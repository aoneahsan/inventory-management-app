"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
exports.cleanupOldNotifications = exports.generateDailySummary = exports.archiveOldActivities = void 0;
const functions = __importStar(require("firebase-functions"));
const admin = __importStar(require("firebase-admin"));
/**
 * Archives old activity logs to keep the collection size manageable
 * Runs monthly to move activities older than 90 days to an archive collection
 */
exports.archiveOldActivities = functions.pubsub
    .schedule("0 0 1 * *") // Run at midnight on the 1st of every month
    .timeZone("UTC")
    .onRun(async () => {
    console.log("Starting activity log archival process");
    try {
        const cutoffDate = new Date();
        cutoffDate.setDate(cutoffDate.getDate() - 90); // 90 days ago
        // Get all organizations
        const organizationsSnapshot = await admin.firestore()
            .collection("organizations")
            .get();
        let totalArchived = 0;
        for (const orgDoc of organizationsSnapshot.docs) {
            const organizationId = orgDoc.id;
            // Query old activities
            const oldActivitiesSnapshot = await admin.firestore()
                .collection("organizations")
                .doc(organizationId)
                .collection("activities")
                .where("timestamp", "<", cutoffDate)
                .limit(500) // Process in batches
                .get();
            if (oldActivitiesSnapshot.empty) {
                continue;
            }
            const batch = admin.firestore().batch();
            const archiveBatch = admin.firestore().batch();
            // Move activities to archive
            for (const activityDoc of oldActivitiesSnapshot.docs) {
                const activityData = activityDoc.data();
                // Add to archive collection
                const archiveRef = admin.firestore()
                    .collection("archivedActivities")
                    .doc(organizationId)
                    .collection("activities")
                    .doc(activityDoc.id);
                archiveBatch.set(archiveRef, Object.assign(Object.assign({}, activityData), { archivedAt: admin.firestore.FieldValue.serverTimestamp() }));
                // Delete from main collection
                batch.delete(activityDoc.ref);
            }
            // Commit both batches
            await archiveBatch.commit();
            await batch.commit();
            totalArchived += oldActivitiesSnapshot.size;
            console.log(`Archived ${oldActivitiesSnapshot.size} activities for organization ${organizationId}`);
        }
        console.log(`Activity archival completed. Total archived: ${totalArchived}`);
    }
    catch (error) {
        console.error("Error archiving activities:", error);
    }
});
/**
 * Generates daily summary reports for organizations
 */
exports.generateDailySummary = functions.pubsub
    .schedule("0 23 * * *") // Run at 11 PM daily
    .timeZone("UTC")
    .onRun(async () => {
    var _a;
    console.log("Starting daily summary generation");
    try {
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        const tomorrow = new Date(today);
        tomorrow.setDate(tomorrow.getDate() + 1);
        // Get all organizations
        const organizationsSnapshot = await admin.firestore()
            .collection("organizations")
            .get();
        for (const orgDoc of organizationsSnapshot.docs) {
            const organizationId = orgDoc.id;
            const orgData = orgDoc.data();
            // Skip if organization has disabled daily summaries
            if ((_a = orgData.settings) === null || _a === void 0 ? void 0 : _a.disableDailySummary) {
                continue;
            }
            // Get today's activities
            const activitiesSnapshot = await admin.firestore()
                .collection("organizations")
                .doc(organizationId)
                .collection("activities")
                .where("timestamp", ">=", today)
                .where("timestamp", "<", tomorrow)
                .get();
            if (activitiesSnapshot.empty) {
                continue;
            }
            // Analyze activities
            const summary = {
                date: today.toISOString(),
                organizationId,
                totalActivities: activitiesSnapshot.size,
                itemsCreated: 0,
                itemsUpdated: 0,
                itemsDeleted: 0,
                membersAdded: 0,
                categoriesCreated: 0,
                locationsCreated: 0,
                uniqueUsers: new Set(),
            };
            activitiesSnapshot.forEach((doc) => {
                const activity = doc.data();
                if (activity.userId) {
                    summary.uniqueUsers.add(activity.userId);
                }
                switch (activity.type) {
                    case "item_created":
                        summary.itemsCreated++;
                        break;
                    case "item_updated":
                        summary.itemsUpdated++;
                        break;
                    case "item_deleted":
                        summary.itemsDeleted++;
                        break;
                    case "member_add":
                        summary.membersAdded++;
                        break;
                    case "category_created":
                        summary.categoriesCreated++;
                        break;
                    case "location_created":
                        summary.locationsCreated++;
                        break;
                }
            });
            // Save summary
            await admin.firestore()
                .collection("organizations")
                .doc(organizationId)
                .collection("dailySummaries")
                .doc(today.toISOString().split("T")[0])
                .set(Object.assign(Object.assign({}, summary), { uniqueUsers: Array.from(summary.uniqueUsers), generatedAt: admin.firestore.FieldValue.serverTimestamp() }));
            // Create notification for organization owner
            if (summary.totalActivities > 0) {
                await admin.firestore().collection("notifications").add({
                    userId: orgData.ownerId,
                    organizationId,
                    type: "daily_summary",
                    title: "Daily Activity Summary",
                    message: `${summary.totalActivities} activities today by ${summary.uniqueUsers.size} users`,
                    data: {
                        itemsCreated: summary.itemsCreated,
                        itemsUpdated: summary.itemsUpdated,
                        itemsDeleted: summary.itemsDeleted,
                    },
                    read: false,
                    createdAt: admin.firestore.FieldValue.serverTimestamp(),
                });
            }
            console.log(`Generated daily summary for organization ${organizationId}`);
        }
        console.log("Daily summary generation completed");
    }
    catch (error) {
        console.error("Error generating daily summaries:", error);
    }
});
/**
 * Cleans up old notifications (older than 30 days)
 */
exports.cleanupOldNotifications = functions.pubsub
    .schedule("0 2 * * 0") // Run at 2 AM every Sunday
    .timeZone("UTC")
    .onRun(async () => {
    console.log("Starting notification cleanup");
    try {
        const cutoffDate = new Date();
        cutoffDate.setDate(cutoffDate.getDate() - 30); // 30 days ago
        // Query old read notifications
        const oldNotificationsSnapshot = await admin.firestore()
            .collection("notifications")
            .where("read", "==", true)
            .where("createdAt", "<", cutoffDate)
            .limit(500) // Process in batches
            .get();
        if (oldNotificationsSnapshot.empty) {
            console.log("No old notifications to clean up");
            return;
        }
        const batch = admin.firestore().batch();
        oldNotificationsSnapshot.forEach((doc) => {
            batch.delete(doc.ref);
        });
        await batch.commit();
        console.log(`Deleted ${oldNotificationsSnapshot.size} old notifications`);
    }
    catch (error) {
        console.error("Error cleaning up notifications:", error);
    }
});
//# sourceMappingURL=onActivityLog.js.map