import * as functions from "firebase-functions";

/**
 * Validates email format
 */
export const isValidEmail = (email: string): boolean => {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
};

/**
 * Validates organization name
 */
export const isValidOrganizationName = (name: string): boolean => {
  return name.length >= 3 && name.length <= 50 && /^[a-zA-Z0-9\s\-_]+$/.test(name);
};

/**
 * Validates item data
 */
export const validateItemData = (data: any): { valid: boolean; errors: string[] } => {
  const errors: string[] = [];

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

/**
 * Validates user permissions for an organization
 */
export const validateUserPermission = async (
  userId: string,
  organizationId: string,
  requiredRole: "owner" | "admin" | "member" | "viewer",
  admin: any
): Promise<boolean> => {
  try {
    const orgDoc = await admin.firestore()
      .collection("organizations")
      .doc(organizationId)
      .get();

    if (!orgDoc.exists) {
      return false;
    }

    const orgData = orgDoc.data()!;

    // Check ownership
    if (requiredRole === "owner") {
      return orgData.ownerId === userId;
    }

    // Check membership
    if (!orgData.members?.includes(userId)) {
      return false;
    }

    // Check role hierarchy
    if (requiredRole === "admin") {
      return orgData.ownerId === userId || orgData.admins?.includes(userId);
    }

    // For member and viewer, being in the members array is sufficient
    return true;
  } catch (error) {
    console.error("Error validating user permission:", error);
    return false;
  }
};

/**
 * Sanitizes user input to prevent XSS
 */
export const sanitizeInput = (input: string): string => {
  return input
    .replace(/[<>]/g, "") // Remove angle brackets
    .replace(/javascript:/gi, "") // Remove javascript: protocol
    .replace(/on\w+=/gi, "") // Remove event handlers
    .trim();
};

/**
 * Validates image upload
 */
export const validateImageUpload = (
  file: any
): { valid: boolean; error?: string } => {
  const maxSize = 5 * 1024 * 1024; // 5MB
  const allowedTypes = ["image/jpeg", "image/png", "image/gif", "image/webp"];

  if (!file) {
    return {valid: false, error: "No file provided"};
  }

  if (file.size > maxSize) {
    return {valid: false, error: "File size must be less than 5MB"};
  }

  if (!allowedTypes.includes(file.contentType)) {
    return {valid: false, error: "File must be JPEG, PNG, GIF, or WebP"};
  }

  return {valid: true};
};

/**
 * Validates pagination parameters
 */
export const validatePaginationParams = (
  params: any
): { limit: number; offset: number } => {
  let limit = parseInt(params.limit) || 20;
  let offset = parseInt(params.offset) || 0;

  // Enforce reasonable limits
  limit = Math.min(Math.max(1, limit), 100);
  offset = Math.max(0, offset);

  return {limit, offset};
};

/**
 * Throws a standardized error
 */
export const throwError = (
  code: functions.https.FunctionsErrorCode,
  message: string,
  details?: any
): never => {
  console.error(`Error [${code}]: ${message}`, details);
  throw new functions.https.HttpsError(code, message, details);
};
