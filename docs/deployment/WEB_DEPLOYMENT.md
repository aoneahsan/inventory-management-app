# Web Deployment Guide

## Overview

This guide explains how to deploy the Inventory Management web application to Firebase Hosting.

## Prerequisites

1. Flutter SDK installed
2. Firebase CLI installed (`npm install -g firebase-tools`)
3. Access to Firebase projects (dev, staging, prod)
4. Proper environment variables configured

## Fixing 403 Forbidden Issues

If you encounter a 403 Forbidden error when accessing the deployed site, follow these steps:

### 1. Verify Firebase Project Configuration

Ensure your Firebase project is properly configured:

```bash
# Login to Firebase
firebase login

# List your projects
firebase projects:list

# Select the correct project
firebase use dev  # or staging/prod
```

### 2. Check Firebase Hosting Sites

Verify that the hosting sites are created in Firebase Console:
- `inventory-management-dev`
- `inventory-management-staging`
- `inventory-management-prod`

### 3. Build and Deploy

Use the provided deployment script:

```bash
# Deploy to development
./scripts/deploy-web.sh dev

# Deploy to staging
./scripts/deploy-web.sh staging

# Deploy to production
./scripts/deploy-web.sh prod
```

### 4. Manual Deployment Steps

If the script doesn't work, follow these manual steps:

```bash
# 1. Clean previous builds
flutter clean

# 2. Build for web with correct environment
flutter build web --dart-define=ENV=dev --base-href="/"

# 3. Deploy to Firebase
firebase deploy --only hosting:inventory-management-dev
```

### 5. Verify Deployment

After deployment:
1. Visit: `https://inventory-management-dev.web.app`
2. Check browser console for errors
3. Verify network requests in Developer Tools

## Common Issues and Solutions

### 403 Forbidden Error

**Causes:**
1. Missing Firebase hosting site configuration
2. Incorrect project permissions
3. Misconfigured firebase.json
4. Wrong public directory

**Solutions:**
1. Ensure the hosting site exists in Firebase Console
2. Check IAM permissions for your Google account
3. Verify `firebase.json` has correct site names
4. Confirm `public: "build/web"` in firebase.json

### Base HREF Issues

If the app loads but routing doesn't work:
1. Ensure `--base-href="/"` is used during build
2. Check that `index.html` has `<base href="$FLUTTER_BASE_HREF">`
3. Verify rewrites in `firebase.json`

### CORS Issues

If you see CORS errors:
1. Check the headers configuration in `firebase.json`
2. Ensure Firebase Functions allow CORS
3. Verify API endpoints are correctly configured

## Local Testing

Before deploying, test locally:

```bash
# Build and serve locally
./scripts/serve-local.sh

# Visit http://localhost:8000
```

## Environment Configuration

The app uses different configurations based on environment:

- **Development**: Uses test Stripe keys, Firebase emulators optional
- **Staging**: Uses test Stripe keys, real Firebase services
- **Production**: Uses live Stripe keys, real Firebase services

## Monitoring Deployment

After deployment:
1. Check Firebase Console > Hosting for deployment status
2. Monitor Firebase Console > Functions for any errors
3. Review browser console for client-side errors
4. Check Network tab for failed requests

## Rollback Procedure

If issues occur after deployment:

```bash
# List recent deployments
firebase hosting:releases:list

# Rollback to previous version
firebase hosting:rollback
```

## Security Headers

Production deployments include security headers:
- X-Content-Type-Options: nosniff
- X-Frame-Options: SAMEORIGIN
- X-XSS-Protection: 1; mode=block

These are configured in `firebase.json` for the production environment.

## Troubleshooting Commands

```bash
# Check Firebase CLI version
firebase --version

# Update Firebase CLI
npm update -g firebase-tools

# Debug deployment
firebase deploy --only hosting --debug

# Check current project
firebase use

# View hosting configuration
firebase hosting:sites:list
```

## Support

If issues persist:
1. Check Firebase Status: https://status.firebase.google.com/
2. Review Firebase Hosting docs: https://firebase.google.com/docs/hosting
3. Check Flutter Web docs: https://flutter.dev/web