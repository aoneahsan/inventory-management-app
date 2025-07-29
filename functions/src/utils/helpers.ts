import * as admin from "firebase-admin";

/**
 * Generates a unique code for various purposes (invitations, items, etc.)
 */
export const generateUniqueCode = (prefix: string = "", length: number = 8): string => {
  const characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  let code = prefix;

  for (let i = 0; i < length; i++) {
    code += characters.charAt(Math.floor(Math.random() * characters.length));
  }

  return code;
};

/**
 * Formats a Firestore timestamp to ISO string
 */
export const formatTimestamp = (timestamp: any): string => {
  if (!timestamp) return "";

  if (timestamp.toDate) {
    return timestamp.toDate().toISOString();
  }

  if (timestamp instanceof Date) {
    return timestamp.toISOString();
  }

  return new Date(timestamp).toISOString();
};

/**
 * Batch processes an array in chunks
 */
export const batchProcess = async <T>(
  items: T[],
  batchSize: number,
  processor: (batch: T[]) => Promise<void>
): Promise<void> => {
  for (let i = 0; i < items.length; i += batchSize) {
    const batch = items.slice(i, i + batchSize);
    await processor(batch);
  }
};

/**
 * Retries a function with exponential backoff
 */
export const retryWithBackoff = async <T>(
  fn: () => Promise<T>,
  maxRetries: number = 3,
  baseDelay: number = 1000
): Promise<T> => {
  let lastError: any;

  for (let i = 0; i < maxRetries; i++) {
    try {
      return await fn();
    } catch (error) {
      lastError = error;

      if (i < maxRetries - 1) {
        const delay = baseDelay * Math.pow(2, i);
        await new Promise((resolve) => setTimeout(resolve, delay));
      }
    }
  }

  throw lastError;
};

/**
 * Deep merges two objects
 */
export const deepMerge = (target: any, source: any): any => {
  const output = {...target};

  if (isObject(target) && isObject(source)) {
    Object.keys(source).forEach((key) => {
      if (isObject(source[key])) {
        if (!(key in target)) {
          Object.assign(output, {[key]: source[key]});
        } else {
          output[key] = deepMerge(target[key], source[key]);
        }
      } else {
        Object.assign(output, {[key]: source[key]});
      }
    });
  }

  return output;
};

const isObject = (item: any): boolean => {
  return item && typeof item === "object" && !Array.isArray(item);
};

/**
 * Calculates storage size for an object (rough estimate)
 */
export const calculateStorageSize = (obj: any): number => {
  const jsonString = JSON.stringify(obj);
  return new Blob([jsonString]).size;
};

/**
 * Generates a slug from a string
 */
export const generateSlug = (text: string): string => {
  return text
    .toLowerCase()
    .replace(/[^\w\s-]/g, "") // Remove non-word chars
    .replace(/\s+/g, "-") // Replace spaces with -
    .replace(/-+/g, "-") // Replace multiple - with single -
    .trim();
};

/**
 * Extracts search keywords from text
 */
export const extractSearchKeywords = (text: string): string[] => {
  if (!text) return [];

  return text
    .toLowerCase()
    .split(/\s+/)
    .filter((word) => word.length > 2) // Filter out short words
    .filter((word, index, self) => self.indexOf(word) === index); // Remove duplicates
};

/**
 * Creates a Firestore-compatible search index
 */
export const createSearchIndex = (text: string): string[] => {
  if (!text) return [];

  const words = extractSearchKeywords(text);
  const searchTerms: string[] = [];

  // Add full text
  searchTerms.push(text.toLowerCase());

  // Add individual words
  words.forEach((word) => {
    searchTerms.push(word);

    // Add prefixes for partial matching
    for (let i = 1; i <= word.length; i++) {
      searchTerms.push(word.substring(0, i));
    }
  });

  return [...new Set(searchTerms)]; // Remove duplicates
};

/**
 * Safely gets nested property from object
 */
export const getNestedProperty = (obj: any, path: string, defaultValue: any = null): any => {
  const keys = path.split(".");
  let result = obj;

  for (const key of keys) {
    if (result && typeof result === "object" && key in result) {
      result = result[key];
    } else {
      return defaultValue;
    }
  }

  return result;
};

/**
 * Groups array items by a key
 */
export const groupBy = <T>(array: T[], key: keyof T): { [key: string]: T[] } => {
  return array.reduce((result, item) => {
    const group = String(item[key]);
    if (!result[group]) {
      result[group] = [];
    }
    result[group].push(item);
    return result;
  }, {} as { [key: string]: T[] });
};

/**
 * Converts Firestore document to plain object with ID
 */
export const docToObject = (doc: admin.firestore.DocumentSnapshot): any => {
  if (!doc.exists) {
    return null;
  }

  return {
    id: doc.id,
    ...doc.data(),
  };
};

/**
 * Creates a CSV string from an array of objects
 */
export const arrayToCSV = (data: any[], headers?: string[]): string => {
  if (data.length === 0) return "";

  // Get headers from first object if not provided
  if (!headers) {
    headers = Object.keys(data[0]);
  }

  // Create header row
  const csvRows = [headers.join(",")];

  // Create data rows
  for (const row of data) {
    const values = headers.map((header) => {
      const value = row[header];
      // Escape values containing commas or quotes
      if (typeof value === "string" && (value.includes(",") || value.includes("\""))) {
        return `"${value.replace(/"/g, "\"\"")}"`;
      }
      return value;
    });
    csvRows.push(values.join(","));
  }

  return csvRows.join("\n");
};
