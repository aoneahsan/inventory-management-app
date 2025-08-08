import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

export const sendNotification = functions.https.onCall(async (data, context) => {
  // Check authentication
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }

  const { userId, title, body, data: notificationData } = data;

  try {
    // Get user's FCM token
    const userDoc = await admin.firestore().collection('users').doc(userId).get();
    const fcmToken = userDoc.data()?.fcm_token;

    if (!fcmToken) {
      console.log('No FCM token found for user:', userId);
      return { success: false, message: 'No FCM token found' };
    }

    // Send notification
    const message = {
      token: fcmToken,
      notification: {
        title,
        body,
      },
      data: notificationData || {},
    };

    const response = await admin.messaging().send(message);
    console.log('Notification sent successfully:', response);

    return { success: true, messageId: response };
  } catch (error) {
    console.error('Error sending notification:', error);
    throw new functions.https.HttpsError('internal', 'Failed to send notification');
  }
});

export const sendLowStockNotifications = functions.pubsub
  .schedule('every 1 hours')
  .onRun(async () => {
    const lowStockProducts = await admin.firestore()
      .collection('products')
      .where('currentStock', '<=', 'minStockLevel')
      .get();

    const notifications = [];

    for (const doc of lowStockProducts.docs) {
      const product = doc.data();
      const orgUsers = await admin.firestore()
        .collection('users')
        .where('organizationId', '==', product.organizationId)
        .get();

      for (const userDoc of orgUsers.docs) {
        const user = userDoc.data();
        if (user.fcm_token) {
          notifications.push({
            token: user.fcm_token,
            notification: {
              title: 'Low Stock Alert',
              body: `${product.name} is running low (${product.currentStock} units remaining)`,
            },
            data: {
              type: 'low_stock',
              target_id: doc.id,
              product_name: product.name,
            },
          });
        }
      }
    }

    // Send notifications in batches
    if (notifications.length > 0) {
      const response = await admin.messaging().sendAll(notifications);
      console.log(`Sent ${response.successCount} low stock notifications`);
    }
  });