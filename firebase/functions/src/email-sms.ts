import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import * as sgMail from '@sendgrid/mail';
import * as twilio from 'twilio';

// Initialize SendGrid
const sendgridApiKey = functions.config().sendgrid?.api_key;
if (sendgridApiKey) {
  sgMail.setApiKey(sendgridApiKey);
}

// Initialize Twilio
const twilioAccountSid = functions.config().twilio?.account_sid;
const twilioAuthToken = functions.config().twilio?.auth_token;
const twilioFromNumber = functions.config().twilio?.from_number;
const twilioClient = twilioAccountSid && twilioAuthToken 
  ? twilio(twilioAccountSid, twilioAuthToken) 
  : null;

// Email notification templates
const emailTemplates = {
  welcome: (name: string, organizationName: string) => ({
    subject: 'Welcome to Inventory Management',
    html: `
      <h2>Welcome ${name}!</h2>
      <p>Thank you for joining ${organizationName} on our Inventory Management platform.</p>
      <p>You can now:</p>
      <ul>
        <li>Track inventory levels in real-time</li>
        <li>Manage products and categories</li>
        <li>Generate detailed reports</li>
        <li>Collaborate with your team</li>
      </ul>
      <p>If you have any questions, please don't hesitate to contact our support team.</p>
      <p>Best regards,<br>Inventory Management Team</p>
    `,
  }),
  
  lowStock: (productName: string, currentStock: number, threshold: number) => ({
    subject: `Low Stock Alert: ${productName}`,
    html: `
      <h2>Low Stock Alert</h2>
      <p><strong>${productName}</strong> is running low on stock.</p>
      <p>Current stock: <strong>${currentStock}</strong> units</p>
      <p>Minimum threshold: <strong>${threshold}</strong> units</p>
      <p>Please reorder soon to avoid stockouts.</p>
      <p>Best regards,<br>Inventory Management Team</p>
    `,
  }),
  
  orderShipped: (orderNumber: string, trackingNumber?: string) => ({
    subject: `Order #${orderNumber} has been shipped`,
    html: `
      <h2>Your order has been shipped!</h2>
      <p>Order #${orderNumber} is on its way.</p>
      ${trackingNumber ? `<p>Tracking number: <strong>${trackingNumber}</strong></p>` : ''}
      <p>You'll receive another notification when your order is delivered.</p>
      <p>Best regards,<br>Inventory Management Team</p>
    `,
  }),
  
  invoiceGenerated: (invoiceNumber: string, amount: number, dueDate: string) => ({
    subject: `Invoice #${invoiceNumber} Generated`,
    html: `
      <h2>New Invoice Generated</h2>
      <p>Invoice #${invoiceNumber} has been generated.</p>
      <p>Amount: <strong>$${amount.toFixed(2)}</strong></p>
      <p>Due date: <strong>${dueDate}</strong></p>
      <p>You can view and download the invoice from your dashboard.</p>
      <p>Best regards,<br>Inventory Management Team</p>
    `,
  }),
  
  subscriptionUpgraded: (planName: string) => ({
    subject: `Subscription Upgraded to ${planName}`,
    html: `
      <h2>Subscription Successfully Upgraded!</h2>
      <p>Your subscription has been upgraded to the <strong>${planName}</strong> plan.</p>
      <p>You now have access to additional features and increased limits.</p>
      <p>Thank you for choosing to grow with us!</p>
      <p>Best regards,<br>Inventory Management Team</p>
    `,
  }),
};

// SMS templates
const smsTemplates = {
  lowStock: (productName: string, currentStock: number) => 
    `Low Stock Alert: ${productName} has only ${currentStock} units remaining. Please reorder soon.`,
  
  orderShipped: (orderNumber: string) => 
    `Your order #${orderNumber} has been shipped and is on its way!`,
  
  verificationCode: (code: string) => 
    `Your Inventory Management verification code is: ${code}. Valid for 10 minutes.`,
};

// Send email notification
export const sendEmailNotification = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }

  if (!sendgridApiKey) {
    throw new functions.https.HttpsError('failed-precondition', 'SendGrid is not configured');
  }

  const { to, template, templateData } = data;

  try {
    // Get email template
    let emailContent;
    switch (template) {
      case 'welcome':
        emailContent = emailTemplates.welcome(templateData.name, templateData.organizationName);
        break;
      case 'lowStock':
        emailContent = emailTemplates.lowStock(
          templateData.productName, 
          templateData.currentStock, 
          templateData.threshold
        );
        break;
      case 'orderShipped':
        emailContent = emailTemplates.orderShipped(
          templateData.orderNumber, 
          templateData.trackingNumber
        );
        break;
      case 'invoiceGenerated':
        emailContent = emailTemplates.invoiceGenerated(
          templateData.invoiceNumber,
          templateData.amount,
          templateData.dueDate
        );
        break;
      case 'subscriptionUpgraded':
        emailContent = emailTemplates.subscriptionUpgraded(templateData.planName);
        break;
      default:
        throw new functions.https.HttpsError('invalid-argument', 'Invalid email template');
    }

    const msg = {
      to,
      from: functions.config().sendgrid?.from_email || 'noreply@inventory-management.com',
      subject: emailContent.subject,
      html: emailContent.html,
    };

    await sgMail.send(msg);
    
    // Log email sent
    await admin.firestore().collection('email_logs').add({
      to,
      template,
      templateData,
      sentAt: new Date().toISOString(),
      status: 'sent',
    });

    return { success: true, message: 'Email sent successfully' };
  } catch (error) {
    console.error('Error sending email:', error);
    
    // Log failed email
    await admin.firestore().collection('email_logs').add({
      to,
      template,
      templateData,
      sentAt: new Date().toISOString(),
      status: 'failed',
      error: error.toString(),
    });
    
    throw new functions.https.HttpsError('internal', 'Failed to send email');
  }
});

// Send SMS notification
export const sendSmsNotification = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }

  if (!twilioClient || !twilioFromNumber) {
    throw new functions.https.HttpsError('failed-precondition', 'Twilio is not configured');
  }

  const { to, template, templateData } = data;

  try {
    // Get SMS template
    let message;
    switch (template) {
      case 'lowStock':
        message = smsTemplates.lowStock(templateData.productName, templateData.currentStock);
        break;
      case 'orderShipped':
        message = smsTemplates.orderShipped(templateData.orderNumber);
        break;
      case 'verificationCode':
        message = smsTemplates.verificationCode(templateData.code);
        break;
      default:
        throw new functions.https.HttpsError('invalid-argument', 'Invalid SMS template');
    }

    const result = await twilioClient.messages.create({
      body: message,
      to,
      from: twilioFromNumber,
    });

    // Log SMS sent
    await admin.firestore().collection('sms_logs').add({
      to,
      template,
      templateData,
      sentAt: new Date().toISOString(),
      status: 'sent',
      messageId: result.sid,
    });

    return { success: true, messageId: result.sid };
  } catch (error) {
    console.error('Error sending SMS:', error);
    
    // Log failed SMS
    await admin.firestore().collection('sms_logs').add({
      to,
      template,
      templateData,
      sentAt: new Date().toISOString(),
      status: 'failed',
      error: error.toString(),
    });
    
    throw new functions.https.HttpsError('internal', 'Failed to send SMS');
  }
});

// Batch email notifications
export const sendBatchEmails = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }

  if (!sendgridApiKey) {
    throw new functions.https.HttpsError('failed-precondition', 'SendGrid is not configured');
  }

  const { emails } = data; // Array of { to, template, templateData }

  const results = [];
  
  for (const emailData of emails) {
    try {
      await sendEmailNotification(emailData, context);
      results.push({ success: true, to: emailData.to });
    } catch (error) {
      results.push({ success: false, to: emailData.to, error: error.toString() });
    }
  }

  return { results };
});

// Notification preferences
export const updateNotificationPreferences = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }

  const { preferences } = data;
  const userId = context.auth.uid;

  try {
    await admin.firestore().collection('users').doc(userId).update({
      notificationPreferences: preferences,
      updatedAt: new Date().toISOString(),
    });

    return { success: true };
  } catch (error) {
    console.error('Error updating notification preferences:', error);
    throw new functions.https.HttpsError('internal', 'Failed to update preferences');
  }
});

// Automated notifications based on events
export const onLowStockDetected = functions.firestore
  .document('products/{productId}')
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();
    
    // Check if stock went below threshold
    if (after.currentStock <= after.minStock && before.currentStock > before.minStock) {
      // Get organization users with notification preferences
      const users = await admin.firestore()
        .collection('users')
        .where('organizationId', '==', after.organizationId)
        .where('notificationPreferences.lowStock.enabled', '==', true)
        .get();
      
      const notifications = [];
      
      for (const userDoc of users.docs) {
        const user = userDoc.data();
        const prefs = user.notificationPreferences?.lowStock;
        
        if (prefs?.email && user.email) {
          notifications.push({
            type: 'email',
            to: user.email,
            template: 'lowStock',
            templateData: {
              productName: after.name,
              currentStock: after.currentStock,
              threshold: after.minStock,
            },
          });
        }
        
        if (prefs?.sms && user.phoneNumber) {
          notifications.push({
            type: 'sms',
            to: user.phoneNumber,
            template: 'lowStock',
            templateData: {
              productName: after.name,
              currentStock: after.currentStock,
            },
          });
        }
        
        if (prefs?.push && user.fcm_token) {
          notifications.push({
            type: 'push',
            token: user.fcm_token,
            title: 'Low Stock Alert',
            body: `${after.name} is running low (${after.currentStock} units)`,
            data: {
              type: 'low_stock',
              target_id: context.params.productId,
            },
          });
        }
      }
      
      // Send all notifications
      await Promise.all(notifications.map(async (notification) => {
        try {
          if (notification.type === 'email') {
            await sendEmailNotification(notification, { auth: { uid: 'system' } });
          } else if (notification.type === 'sms') {
            await sendSmsNotification(notification, { auth: { uid: 'system' } });
          } else if (notification.type === 'push') {
            await admin.messaging().send({
              token: notification.token,
              notification: {
                title: notification.title,
                body: notification.body,
              },
              data: notification.data,
            });
          }
        } catch (error) {
          console.error('Error sending notification:', error);
        }
      }));
    }
  });

// Send welcome email when user joins organization
export const onUserJoinedOrganization = functions.firestore
  .document('users/{userId}')
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();
    
    // Check if user just joined an organization
    if (!before.organizationId && after.organizationId) {
      // Get organization details
      const orgDoc = await admin.firestore()
        .collection('organizations')
        .doc(after.organizationId)
        .get();
      
      const organization = orgDoc.data();
      
      if (after.email && organization) {
        try {
          await sendEmailNotification({
            to: after.email,
            template: 'welcome',
            templateData: {
              name: after.name,
              organizationName: organization.name,
            },
          }, { auth: { uid: 'system' } });
        } catch (error) {
          console.error('Error sending welcome email:', error);
        }
      }
    }
  });