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
exports.throwError = exports.validatePaginationParams = exports.validateImageUpload = exports.sanitizeInput = exports.validateUserPermission = exports.validateItemData = exports.isValidOrganizationName = exports.isValidEmail = void 0;
const functions = __importStar(require("firebase-functions"));
/**
 * Validates email format
 */
const isValidEmail = (email) => {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
};
exports.isValidEmail = isValidEmail;
/**
 * Validates organization name
 */
const isValidOrganizationName = (name) => {
    return name.length >= 3 && name.length <= 50 && /^[a-zA-Z0-9\s\-_]+$/.test(name);
};
exports.isValidOrganizationName = isValidOrganizationName;
/**
 * Validates item data
 */
const validateItemData = (data) => {
    const errors = [];
    if (!data.name || typeof data.name !== "string" || data.name.trim().length === 0) {
        errors.push("Item name is required");
    }
    if (data.name && data.name.length > 100) {
        errors.push("Item name must be less than 100 characters");
    }
    if (data.quantity !== undefined && (typeof data.quantity !== "number" || data.quantity < 0)) {
        errors.push("Quantity must be a non-negative number");
    }
    if (data.price !== undefined && (typeof data.price !== "number" || data.price < 0)) {
        errors.push("Price must be a non-negative number");
    }
    if (data.sku && (typeof data.sku !== "string" || data.sku.length > 50)) {
        errors.push("SKU must be a string with maximum 50 characters");
    }
    if (data.barcode && (typeof data.barcode !== "string" || data.barcode.length > 50)) {
        errors.push("Barcode must be a string with maximum 50 characters");
    }
    return {
        valid: errors.length === 0,
        errors,
    };
};
exports.validateItemData = validateItemData;
/**
 * Validates user permissions for an organization
 */
const validateUserPermission = async (userId, organizationId, requiredRole, admin) => {
    var _a, _b;
    try {
        const orgDoc = await admin.firestore()
            .collection("organizations")
            .doc(organizationId)
            .get();
        if (!orgDoc.exists) {
            return false;
        }
        const orgData = orgDoc.data();
        // Check ownership
        if (requiredRole === "owner") {
            return orgData.ownerId === userId;
        }
        // Check membership
        if (!((_a = orgData.members) === null || _a === void 0 ? void 0 : _a.includes(userId))) {
            return false;
        }
        // Check role hierarchy
        if (requiredRole === "admin") {
            return orgData.ownerId === userId || ((_b = orgData.admins) === null || _b === void 0 ? void 0 : _b.includes(userId));
        }
        // For member and viewer, being in the members array is sufficient
        return true;
    }
    catch (error) {
        console.error("Error validating user permission:", error);
        return false;
    }
};
exports.validateUserPermission = validateUserPermission;
/**
 * Sanitizes user input to prevent XSS
 */
const sanitizeInput = (input) => {
    return input
        .replace(/[<>]/g, "") // Remove angle brackets
        .replace(/javascript:/gi, "") // Remove javascript: protocol
        .replace(/on\w+=/gi, "") // Remove event handlers
        .trim();
};
exports.sanitizeInput = sanitizeInput;
/**
 * Validates image upload
 */
const validateImageUpload = (file) => {
    const maxSize = 5 * 1024 * 1024; // 5MB
    const allowedTypes = ["image/jpeg", "image/png", "image/gif", "image/webp"];
    if (!file) {
        return { valid: false, error: "No file provided" };
    }
    if (file.size > maxSize) {
        return { valid: false, error: "File size must be less than 5MB" };
    }
    if (!allowedTypes.includes(file.contentType)) {
        return { valid: false, error: "File must be JPEG, PNG, GIF, or WebP" };
    }
    return { valid: true };
};
exports.validateImageUpload = validateImageUpload;
/**
 * Validates pagination parameters
 */
const validatePaginationParams = (params) => {
    let limit = parseInt(params.limit) || 20;
    let offset = parseInt(params.offset) || 0;
    // Enforce reasonable limits
    limit = Math.min(Math.max(1, limit), 100);
    offset = Math.max(0, offset);
    return { limit, offset };
};
exports.validatePaginationParams = validatePaginationParams;
/**
 * Throws a standardized error
 */
const throwError = (code, message, details) => {
    console.error(`Error [${code}]: ${message}`, details);
    throw new functions.https.HttpsError(code, message, details);
};
exports.throwError = throwError;
//# sourceMappingURL=validation.js.map