import * as admin from "firebase-admin";

interface NotificationData {
  userId: string;
  title: string;
  body: string;
  data?: { [key: string]: string };
  organizationId?: string;
  type?: string;
}

/**
 * Sends a push notification to a user
 */
export const sendPushNotification = async (notification: NotificationData): Promise<void> => {
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

    const userData = userDoc.data()!;
    const fcmTokens = userData.fcmTokens || [];

    if (fcmTokens.length === 0) {
      console.log(`No FCM tokens for user ${notification.userId}`);
      return;
    }

    // Check if user has enabled push notifications
    if (!userData.settings?.notifications?.push) {
      console.log(`Push notifications disabled for user ${notification.userId}`);
      return;
    }

    // Create notification payload
    const payload: admin.messaging.MulticastMessage = {
      tokens: fcmTokens,
      notification: {
        title: notification.title,
        body: notification.body,
      },
      data: {
        ...notification.data,
        organizationId: notification.organizationId || "",
        type: notification.type || "general",
        timestamp: new Date().toISOString(),
      },
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
      const failedTokens: string[] = [];

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
  } catch (error) {
    console.error("Error sending push notification:", error);
  }
};

/**
 * Creates an in-app notification
 */
export const createInAppNotification = async (notification: {
  userId: string;
  title: string;
  message: string;
  type: string;
  data?: any;
  organizationId?: string;
}): Promise<void> => {
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
  } catch (error) {
    console.error("Error creating in-app notification:", error);
  }
};

/**
 * Sends an email notification (requires email service configuration)
 */
export const sendEmailNotification = async (email: {
  to: string;
  subject: string;
  html: string;
  text?: string;
}): Promise<void> => {
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

/**
 * Notifies organization members about an event
 */
export const notifyOrganizationMembers = async (
  organizationId: string,
  notification: {
    title: string;
    message: string;
    type: string;
    data?: any;
    excludeUserId?: string;
  }
): Promise<void> => {
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

    const orgData = orgDoc.data()!;
    const members = orgData.members || [];

    // Send notification to each member
    const promises = members
      .filter((memberId: string) => memberId !== notification.excludeUserId)
      .map((memberId: string) =>
        Promise.all([
          createInAppNotification({
            userId: memberId,
            title: notification.title,
            message: notification.message,
            type: notification.type,
            data: notification.data,
            organizationId,
          }),
          sendPushNotification({
            userId: memberId,
            title: notification.title,
            body: notification.message,
            data: {
              type: notification.type,
              ...notification.data,
            },
            organizationId,
          }),
        ])
      );

    await Promise.all(promises);

    console.log(`Notified ${promises.length} members of organization ${organizationId}`);
  } catch (error) {
    console.error("Error notifying organization members:", error);
  }
};

/**
 * Notification templates
 */
export const NotificationTemplates = {
  itemLowStock: (itemName: string, quantity: number) => ({
    title: "Low Stock Alert",
    message: `${itemName} is running low (${quantity} remaining)`,
  }),

  memberAdded: (memberName: string, orgName: string) => ({
    title: "New Member Added",
    message: `${memberName} has been added to ${orgName}`,
  }),

  memberRemoved: (memberName: string, orgName: string) => ({
    title: "Member Removed",
    message: `${memberName} has been removed from ${orgName}`,
  }),

  invitationReceived: (orgName: string) => ({
    title: "Organization Invitation",
    message: `You've been invited to join ${orgName}`,
  }),

  subscriptionExpiring: (daysLeft: number) => ({
    title: "Subscription Expiring Soon",
    message: `Your subscription will expire in ${daysLeft} days`,
  }),

  paymentFailed: () => ({
    title: "Payment Failed",
    message: "We were unable to process your payment. Please update your payment method.",
  }),

  exportReady: (exportType: string) => ({
    title: "Export Ready",
    message: `Your ${exportType} export is ready for download`,
  }),
};
