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
exports.NotificationTemplates = exports.notifyOrganizationMembers = exports.sendEmailNotification = exports.createInAppNotification = exports.sendPushNotification = void 0;
const admin = __importStar(require("firebase-admin"));
/**
 * Sends a push notification to a user
 */
const sendPushNotification = async (notification) => {
    var _a, _b;
    try {
        // Get user's FCM tokens
        const userDoc = await admin.firestore()
            .collection("users")
            .doc(notification.userId)
            .get();
        if (!userDoc.exists) {
            console.log(`User ${notification.userId} not found`);
            return;
        }
        const userData = userDoc.data();
        const fcmTokens = userData.fcmTokens || [];
        if (fcmTokens.length === 0) {
            console.log(`No FCM tokens for user ${notification.userId}`);
            return;
        }
        // Check if user has enabled push notifications
        if (!((_b = (_a = userData.settings) === null || _a === void 0 ? void 0 : _a.notifications) === null || _b === void 0 ? void 0 : _b.push)) {
            console.log(`Push notifications disabled for user ${notification.userId}`);
            return;
        }
        // Create notification payload
        const payload = {
            tokens: fcmTokens,
            notification: {
                title: notification.title,
                body: notification.body,
            },
            data: Object.assign(Object.assign({}, notification.data), { organizationId: notification.organizationId || "", type: notification.type || "general", timestamp: new Date().toISOString() }),
            android: {
                priority: "high",
                notification: {
                    channelId: "default",
                    clickAction: "FLUTTER_NOTIFICATION_CLICK",
                },
            },
            apns: {
                payload: {
                    aps: {
                        badge: 1,
                        sound: "default",
                    },
                },
            },
        };
        // Send notification
        const response = await admin.messaging().sendMulticast(payload);
        // Handle failed tokens
        if (response.failureCount > 0) {
            const failedTokens = [];
            response.responses.forEach((resp, idx) => {
                if (!resp.success && resp.error) {
                    const errorCode = resp.error.code;
                    // Remove invalid tokens
                    if (errorCode === "messaging/invalid-registration-token" ||
                        errorCode === "messaging/registration-token-not-registered") {
                        failedTokens.push(fcmTokens[idx]);
                    }
                }
            });
            // Remove failed tokens from user document
            if (failedTokens.length > 0) {
                await admin.firestore()
                    .collection("users")
                    .doc(notification.userId)
                    .update({
                    fcmTokens: admin.firestore.FieldValue.arrayRemove(...failedTokens),
                });
            }
        }
        const msg = `Push notification sent to user ${notification.userId}.`;
        console.log(`${msg} Success: ${response.successCount}, Failure: ${response.failureCount}`);
    }
    catch (error) {
        console.error("Error sending push notification:", error);
    }
};
exports.sendPushNotification = sendPushNotification;
/**
 * Creates an in-app notification
 */
const createInAppNotification = async (notification) => {
    try {
        await admin.firestore().collection("notifications").add({
            userId: notification.userId,
            title: notification.title,
            message: notification.message,
            type: notification.type,
            data: notification.data || {},
            organizationId: notification.organizationId || null,
            read: false,
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });
    }
    catch (error) {
        console.error("Error creating in-app notification:", error);
    }
};
exports.createInAppNotification = createInAppNotification;
/**
 * Sends an email notification (requires email service configuration)
 */
const sendEmailNotification = async (email) => {
    // This is a placeholder - you would integrate with SendGrid, Mailgun, etc.
    // For now, we'll just log it
    console.log("Email notification would be sent:", {
        to: email.to,
        subject: email.subject,
    });
    // Example SendGrid integration:
    /*
    const sgMail = require('@sendgrid/mail');
    sgMail.setApiKey(functions.config().sendgrid.api_key);
  
    const msg = {
      to: email.to,
      from: 'noreply@yourinventoryapp.com',
      subject: email.subject,
      text: email.text || '',
      html: email.html,
    };
  
    await sgMail.send(msg);
    */
};
exports.sendEmailNotification = sendEmailNotification;
/**
 * Notifies organization members about an event
 */
const notifyOrganizationMembers = async (organizationId, notification) => {
    try {
        // Get organization members
        const orgDoc = await admin.firestore()
            .collection("organizations")
            .doc(organizationId)
            .get();
        if (!orgDoc.exists) {
            console.error(`Organization ${organizationId} not found`);
            return;
        }
        const orgData = orgDoc.data();
        const members = orgData.members || [];
        // Send notification to each member
        const promises = members
            .filter((memberId) => memberId !== notification.excludeUserId)
            .map((memberId) => Promise.all([
            (0, exports.createInAppNotification)({
                userId: memberId,
                title: notification.title,
                message: notification.message,
                type: notification.type,
                data: notification.data,
                organizationId,
            }),
            (0, exports.sendPushNotification)({
                userId: memberId,
                title: notification.title,
                body: notification.message,
                data: Object.assign({ type: notification.type }, notification.data),
                organizationId,
            }),
        ]));
        await Promise.all(promises);
        console.log(`Notified ${promises.length} members of organization ${organizationId}`);
    }
    catch (error) {
        console.error("Error notifying organization members:", error);
    }
};
exports.notifyOrganizationMembers = notifyOrganizationMembers;
/**
 * Notification templates
 */
exports.NotificationTemplates = {
    itemLowStock: (itemName, quantity) => ({
        title: "Low Stock Alert",
        message: `${itemName} is running low (${quantity} remaining)`,
    }),
    memberAdded: (memberName, orgName) => ({
        title: "New Member Added",
        message: `${memberName} has been added to ${orgName}`,
    }),
    memberRemoved: (memberName, orgName) => ({
        title: "Member Removed",
        message: `${memberName} has been removed from ${orgName}`,
    }),
    invitationReceived: (orgName) => ({
        title: "Organization Invitation",
        message: `You've been invited to join ${orgName}`,
    }),
    subscriptionExpiring: (daysLeft) => ({
        title: "Subscription Expiring Soon",
        message: `Your subscription will expire in ${daysLeft} days`,
    }),
    paymentFailed: () => ({
        title: "Payment Failed",
        message: "We were unable to process your payment. Please update your payment method.",
    }),
    exportReady: (exportType) => ({
        title: "Export Ready",
        message: `Your ${exportType} export is ready for download`,
    }),
};
//# sourceMappingURL=notifications.js.map