import * as functions from "firebase-functions";

/**
 * Firebase configuration
 */
export const firebaseConfig = {
  // Storage bucket for images and exports
  storageBucket: functions.config().firebase?.storage_bucket || "your-project.appspot.com",

  // Firestore settings
  firestore: {
    // Collection names
    collections: {
      users: "users",
      organizations: "organizations",
      items: "items",
      invitations: "invitations",
      notifications: "notifications",
      checkoutSessions: "checkoutSessions",
      payments: "payments",
      archivedActivities: "archivedActivities",
    },

    // Subcollection names
    subcollections: {
      categories: "categories",
      locations: "locations",
      activities: "activities",
      members: "members",
      dailySummaries: "dailySummaries",
    },
  },

  // Cloud Functions regions
  region: "us-central1",

  // Function timeouts (in seconds)
  timeouts: {
    default: 60,
    longRunning: 540, // 9 minutes
  },

  // Function memory allocations
  memory: {
    default: "256MB",
    intensive: "1GB",
  },
};

/**
 * Firebase Admin SDK initialization options
 */
export const adminConfig = {
  credential: functions.config().firebase?.credential,
  databaseURL: functions.config().firebase?.database_url,
  storageBucket: firebaseConfig.storageBucket,
};

/**
 * Security rules configuration
 */
export const securityConfig = {
  // Maximum file upload size (in bytes)
  maxFileSize: 5 * 1024 * 1024, // 5MB

  // Allowed file types for uploads
  allowedFileTypes: [
    "image/jpeg",
    "image/png",
    "image/gif",
    "image/webp",
  ],

  // Rate limiting
  rateLimits: {
    // API calls per user per hour
    apiCallsPerHour: 1000,

    // Export requests per organization per day
    exportsPerDay: 10,

    // Invitation sends per organization per day
    invitationsPerDay: 50,
  },
};

/**
 * Backup configuration
 */
export const backupConfig = {
  // Enable automatic backups
  enabled: true,

  // Backup schedule (cron format)
  schedule: "0 3 * * *", // Daily at 3 AM

  // Retention period (days)
  retentionDays: 30,

  // Collections to backup
  collections: [
    "users",
    "organizations",
    "items",
  ],
};
