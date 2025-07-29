import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// Initialize Firebase Admin
admin.initializeApp();

// Export authentication functions
export * from "./auth";

// Export organization management functions
export * from "./organizations";

// Export subscription functions
export * from "./subscriptions";

// Export Firestore triggers
export * from "./triggers";

// Health check endpoint
export const healthCheck = functions.https.onRequest(async (req, res) => {
  res.status(200).json({
    status: "healthy",
    timestamp: new Date().toISOString(),
    version: "1.0.0",
  });
});
