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
var _a, _b, _c;
Object.defineProperty(exports, "__esModule", { value: true });
exports.backupConfig = exports.securityConfig = exports.adminConfig = exports.firebaseConfig = void 0;
const functions = __importStar(require("firebase-functions"));
/**
 * Firebase configuration
 */
exports.firebaseConfig = {
    // Storage bucket for images and exports
    storageBucket: ((_a = functions.config().firebase) === null || _a === void 0 ? void 0 : _a.storage_bucket) || "your-project.appspot.com",
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
exports.adminConfig = {
    credential: (_b = functions.config().firebase) === null || _b === void 0 ? void 0 : _b.credential,
    databaseURL: (_c = functions.config().firebase) === null || _c === void 0 ? void 0 : _c.database_url,
    storageBucket: exports.firebaseConfig.storageBucket,
};
/**
 * Security rules configuration
 */
exports.securityConfig = {
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
exports.backupConfig = {
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
//# sourceMappingURL=firebase.js.map