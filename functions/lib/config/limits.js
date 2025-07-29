"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.validationMessages = exports.appLimits = void 0;
/**
 * Application limits and constraints
 */
exports.appLimits = {
    // Item limits
    item: {
        nameMaxLength: 100,
        descriptionMaxLength: 500,
        skuMaxLength: 50,
        barcodeMaxLength: 50,
        customFieldsMax: 20,
        imagesMax: 5,
        tagsMax: 10,
    },
    // Organization limits
    organization: {
        nameMaxLength: 50,
        descriptionMaxLength: 200,
        invitationExpiryDays: 7,
        maxPendingInvitations: 50,
    },
    // Category limits
    category: {
        nameMaxLength: 50,
        descriptionMaxLength: 200,
        maxNestingLevel: 3,
    },
    // Location limits
    location: {
        nameMaxLength: 50,
        addressMaxLength: 200,
        notesMaxLength: 500,
    },
    // Search limits
    search: {
        minQueryLength: 2,
        maxResults: 100,
        maxSuggestions: 10,
    },
    // Export limits
    export: {
        maxItemsPerExport: 10000,
        maxFileSizeMB: 50,
        formatOptions: ["csv", "xlsx", "json"],
    },
    // Activity log limits
    activity: {
        retentionDays: 90,
        maxLogsPerQuery: 1000,
        archiveAfterDays: 90,
    },
    // Notification limits
    notification: {
        maxPerUser: 100,
        retentionDays: 30,
        batchSize: 500,
    },
    // API rate limits (per hour)
    rateLimit: {
        free: {
            reads: 1000,
            writes: 100,
            deletes: 50,
        },
        pro: {
            reads: 10000,
            writes: 1000,
            deletes: 500,
        },
        enterprise: {
            reads: 100000,
            writes: 10000,
            deletes: 5000,
        },
    },
    // Pagination defaults
    pagination: {
        defaultLimit: 20,
        maxLimit: 100,
    },
    // File upload limits
    fileUpload: {
        maxSizeMB: 5,
        allowedMimeTypes: [
            "image/jpeg",
            "image/jpg",
            "image/png",
            "image/gif",
            "image/webp",
        ],
        imageMaxDimension: 2048,
    },
    // Batch operation limits
    batchOperation: {
        maxItemsPerBatch: 500,
        maxConcurrentBatches: 5,
    },
};
/**
 * Validation messages
 */
exports.validationMessages = {
    item: {
        nameRequired: "Item name is required",
        nameTooLong: `Item name must be less than ${exports.appLimits.item.nameMaxLength} characters`,
        invalidQuantity: "Quantity must be a non-negative number",
        invalidPrice: "Price must be a non-negative number",
        tooManyImages: `Maximum ${exports.appLimits.item.imagesMax} images allowed`,
        tooManyTags: `Maximum ${exports.appLimits.item.tagsMax} tags allowed`,
    },
    organization: {
        nameRequired: "Organization name is required",
        nameTooLong: `Organization name must be less than ${exports.appLimits.organization.nameMaxLength} characters`,
        invalidType: "Invalid organization type",
        limitReached: "Organization limit reached for your subscription plan",
    },
    subscription: {
        itemLimitReached: "Item limit reached for your subscription plan",
        memberLimitReached: "Member limit reached for your subscription plan",
        storageLimitReached: "Storage limit reached for your subscription plan",
        upgradeRequired: "Please upgrade your subscription to continue",
    },
    general: {
        unauthorized: "You are not authorized to perform this action",
        notFound: "Resource not found",
        invalidInput: "Invalid input provided",
        serverError: "An error occurred. Please try again later",
    },
};
//# sourceMappingURL=limits.js.map