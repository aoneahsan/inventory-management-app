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
var _a, _b, _c, _d, _e, _f;
Object.defineProperty(exports, "__esModule", { value: true });
exports.planFeatures = exports.stripeConfig = void 0;
const functions = __importStar(require("firebase-functions"));
/**
 * Stripe configuration
 */
exports.stripeConfig = {
    // API Keys (stored in Firebase Functions config)
    secretKey: ((_a = functions.config().stripe) === null || _a === void 0 ? void 0 : _a.secret_key) || "",
    webhookSecret: ((_b = functions.config().stripe) === null || _b === void 0 ? void 0 : _b.webhook_secret) || "",
    // Price IDs for subscription plans
    prices: {
        pro: ((_c = functions.config().stripe) === null || _c === void 0 ? void 0 : _c.price_pro) || "price_pro_monthly",
        enterprise: ((_d = functions.config().stripe) === null || _d === void 0 ? void 0 : _d.price_enterprise) || "price_enterprise_monthly",
    },
    // Product IDs
    products: {
        pro: ((_e = functions.config().stripe) === null || _e === void 0 ? void 0 : _e.product_pro) || "prod_pro",
        enterprise: ((_f = functions.config().stripe) === null || _f === void 0 ? void 0 : _f.product_enterprise) || "prod_enterprise",
    },
    // Subscription settings
    subscription: {
        // Trial period in days
        trialPeriodDays: 14,
        // Grace period for failed payments (days)
        gracePeriodDays: 7,
        // Enable proration on plan changes
        enableProration: true,
        // Cancel at period end by default
        cancelAtPeriodEnd: true,
    },
    // Payment settings
    payment: {
        // Accepted payment methods
        paymentMethods: ["card"],
        // Currency
        currency: "usd",
        // Automatic tax collection
        automaticTax: false,
        // Invoice settings
        invoice: {
            daysUntilDue: 7,
            footer: "Thank you for your business!",
        },
    },
    // Webhook endpoints
    webhooks: {
        endpoint: "/stripe-webhook",
        events: [
            "checkout.session.completed",
            "customer.subscription.created",
            "customer.subscription.updated",
            "customer.subscription.deleted",
            "invoice.payment_succeeded",
            "invoice.payment_failed",
            "customer.updated",
            "payment_method.attached",
            "payment_method.detached",
        ],
    },
    // Customer portal configuration
    customerPortal: {
        enabled: true,
        features: {
            invoiceHistory: true,
            paymentMethodUpdate: true,
            subscriptionCancel: true,
            subscriptionUpdate: true,
        },
    },
};
/**
 * Plan features and limits
 */
exports.planFeatures = {
    free: {
        name: "Free",
        price: 0,
        features: [
            "1 Organization",
            "Up to 100 items",
            "Up to 3 team members",
            "Basic categories & locations",
            "Activity tracking",
            "Mobile app access",
        ],
        limits: {
            organizations: 1,
            itemsPerOrg: 100,
            membersPerOrg: 3,
            categoriesPerOrg: 10,
            locationsPerOrg: 5,
            storageGB: 1,
            apiCallsPerHour: 100,
        },
    },
    pro: {
        name: "Pro",
        price: 29.99,
        priceId: exports.stripeConfig.prices.pro,
        features: [
            "5 Organizations",
            "Up to 1,000 items per org",
            "Up to 10 team members per org",
            "Unlimited categories & locations",
            "Advanced reporting",
            "Barcode scanning",
            "Email support",
            "Data export (CSV/Excel)",
            "Custom fields",
        ],
        limits: {
            organizations: 5,
            itemsPerOrg: 1000,
            membersPerOrg: 10,
            categoriesPerOrg: -1, // unlimited
            locationsPerOrg: -1, // unlimited
            storageGB: 10,
            apiCallsPerHour: 1000,
        },
    },
    enterprise: {
        name: "Enterprise",
        price: 99.99,
        priceId: exports.stripeConfig.prices.enterprise,
        features: [
            "Unlimited Organizations",
            "Unlimited items",
            "Unlimited team members",
            "Unlimited categories & locations",
            "Advanced analytics",
            "API access",
            "Priority support",
            "Custom integrations",
            "Audit logs",
            "Single Sign-On (SSO)",
            "Advanced permissions",
            "Dedicated account manager",
        ],
        limits: {
            organizations: -1, // unlimited
            itemsPerOrg: -1, // unlimited
            membersPerOrg: -1, // unlimited
            categoriesPerOrg: -1, // unlimited
            locationsPerOrg: -1, // unlimited
            storageGB: 100,
            apiCallsPerHour: 10000,
        },
    },
};
//# sourceMappingURL=stripe.js.map