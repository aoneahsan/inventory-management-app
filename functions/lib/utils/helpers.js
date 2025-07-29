"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.arrayToCSV = exports.docToObject = exports.groupBy = exports.getNestedProperty = exports.createSearchIndex = exports.extractSearchKeywords = exports.generateSlug = exports.calculateStorageSize = exports.deepMerge = exports.retryWithBackoff = exports.batchProcess = exports.formatTimestamp = exports.generateUniqueCode = void 0;
/**
 * Generates a unique code for various purposes (invitations, items, etc.)
 */
const generateUniqueCode = (prefix = "", length = 8) => {
    const characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    let code = prefix;
    for (let i = 0; i < length; i++) {
        code += characters.charAt(Math.floor(Math.random() * characters.length));
    }
    return code;
};
exports.generateUniqueCode = generateUniqueCode;
/**
 * Formats a Firestore timestamp to ISO string
 */
const formatTimestamp = (timestamp) => {
    if (!timestamp)
        return "";
    if (timestamp.toDate) {
        return timestamp.toDate().toISOString();
    }
    if (timestamp instanceof Date) {
        return timestamp.toISOString();
    }
    return new Date(timestamp).toISOString();
};
exports.formatTimestamp = formatTimestamp;
/**
 * Batch processes an array in chunks
 */
const batchProcess = async (items, batchSize, processor) => {
    for (let i = 0; i < items.length; i += batchSize) {
        const batch = items.slice(i, i + batchSize);
        await processor(batch);
    }
};
exports.batchProcess = batchProcess;
/**
 * Retries a function with exponential backoff
 */
const retryWithBackoff = async (fn, maxRetries = 3, baseDelay = 1000) => {
    let lastError;
    for (let i = 0; i < maxRetries; i++) {
        try {
            return await fn();
        }
        catch (error) {
            lastError = error;
            if (i < maxRetries - 1) {
                const delay = baseDelay * Math.pow(2, i);
                await new Promise((resolve) => setTimeout(resolve, delay));
            }
        }
    }
    throw lastError;
};
exports.retryWithBackoff = retryWithBackoff;
/**
 * Deep merges two objects
 */
const deepMerge = (target, source) => {
    const output = Object.assign({}, target);
    if (isObject(target) && isObject(source)) {
        Object.keys(source).forEach((key) => {
            if (isObject(source[key])) {
                if (!(key in target)) {
                    Object.assign(output, { [key]: source[key] });
                }
                else {
                    output[key] = (0, exports.deepMerge)(target[key], source[key]);
                }
            }
            else {
                Object.assign(output, { [key]: source[key] });
            }
        });
    }
    return output;
};
exports.deepMerge = deepMerge;
const isObject = (item) => {
    return item && typeof item === "object" && !Array.isArray(item);
};
/**
 * Calculates storage size for an object (rough estimate)
 */
const calculateStorageSize = (obj) => {
    const jsonString = JSON.stringify(obj);
    return new Blob([jsonString]).size;
};
exports.calculateStorageSize = calculateStorageSize;
/**
 * Generates a slug from a string
 */
const generateSlug = (text) => {
    return text
        .toLowerCase()
        .replace(/[^\w\s-]/g, "") // Remove non-word chars
        .replace(/\s+/g, "-") // Replace spaces with -
        .replace(/-+/g, "-") // Replace multiple - with single -
        .trim();
};
exports.generateSlug = generateSlug;
/**
 * Extracts search keywords from text
 */
const extractSearchKeywords = (text) => {
    if (!text)
        return [];
    return text
        .toLowerCase()
        .split(/\s+/)
        .filter((word) => word.length > 2) // Filter out short words
        .filter((word, index, self) => self.indexOf(word) === index); // Remove duplicates
};
exports.extractSearchKeywords = extractSearchKeywords;
/**
 * Creates a Firestore-compatible search index
 */
const createSearchIndex = (text) => {
    if (!text)
        return [];
    const words = (0, exports.extractSearchKeywords)(text);
    const searchTerms = [];
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
exports.createSearchIndex = createSearchIndex;
/**
 * Safely gets nested property from object
 */
const getNestedProperty = (obj, path, defaultValue = null) => {
    const keys = path.split(".");
    let result = obj;
    for (const key of keys) {
        if (result && typeof result === "object" && key in result) {
            result = result[key];
        }
        else {
            return defaultValue;
        }
    }
    return result;
};
exports.getNestedProperty = getNestedProperty;
/**
 * Groups array items by a key
 */
const groupBy = (array, key) => {
    return array.reduce((result, item) => {
        const group = String(item[key]);
        if (!result[group]) {
            result[group] = [];
        }
        result[group].push(item);
        return result;
    }, {});
};
exports.groupBy = groupBy;
/**
 * Converts Firestore document to plain object with ID
 */
const docToObject = (doc) => {
    if (!doc.exists) {
        return null;
    }
    return Object.assign({ id: doc.id }, doc.data());
};
exports.docToObject = docToObject;
/**
 * Creates a CSV string from an array of objects
 */
const arrayToCSV = (data, headers) => {
    if (data.length === 0)
        return "";
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
exports.arrayToCSV = arrayToCSV;
//# sourceMappingURL=helpers.js.map