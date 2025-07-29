# Firebase Setup Guide

## Prerequisites
- Firebase CLI installed (`npm install -g firebase-tools`)
- A Google account
- Flutter project initialized

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project"
3. Enter project name: `inventory-saas` (or your preferred name)
4. Enable Google Analytics (optional)
5. Wait for project creation

## Step 2: Configure Flutter App

1. Install FlutterFire CLI:
```bash
dart pub global activate flutterfire_cli
```

2. Configure your Flutter app:
```bash
flutterfire configure
```

3. Select your Firebase project
4. Select platforms: iOS, Android, Web
5. This will generate `lib/firebase_options.dart` with your configuration

## Step 3: Enable Firebase Services

In Firebase Console, enable these services:

### Authentication
1. Go to Authentication > Sign-in method
2. Enable:
   - Email/Password
   - Google Sign-In
   - Apple Sign-In (for iOS)

### Firestore Database
1. Go to Firestore Database
2. Click "Create database"
3. Choose production mode
4. Select your region
5. Deploy security rules:
```bash
firebase deploy --only firestore:rules
```

### Cloud Storage
1. Go to Storage
2. Click "Get started"
3. Choose production mode
4. Select your region
5. Deploy storage rules:
```bash
firebase deploy --only storage:rules
```

### Cloud Functions
1. Upgrade to Blaze plan (required for Functions)
2. Install dependencies:
```bash
cd functions
npm install
```
3. Deploy functions:
```bash
firebase deploy --only functions
```

## Step 4: Configure Stripe (for subscriptions)

1. Create a [Stripe account](https://stripe.com)
2. Get your API keys from Stripe Dashboard
3. Set Firebase Functions config:
```bash
firebase functions:config:set stripe.secret_key="sk_test_..." 
firebase functions:config:set stripe.webhook_secret="whsec_..."
firebase functions:config:set stripe.price_free="price_free_id"
firebase functions:config:set stripe.price_pro="price_pro_id"
firebase functions:config:set stripe.price_enterprise="price_enterprise_id"
```

## Step 5: Configure Email Service

1. Set up SendGrid or another email service
2. Set Firebase Functions config:
```bash
firebase functions:config:set email.api_key="your_sendgrid_api_key"
firebase functions:config:set email.from="noreply@yourdomain.com"
```

## Step 6: Set Up Firebase Hosting

1. Deploy to different environments:

### Development
```bash
firebase use --add
# Select your project and alias it as "development"
firebase deploy --only hosting:inventory-saas-dev
```

### Staging
```bash
firebase hosting:sites:create inventory-saas-staging
firebase deploy --only hosting:inventory-saas-staging
```

### Production
```bash
firebase hosting:sites:create inventory-saas-prod
firebase deploy --only hosting:inventory-saas-prod
```

## Step 7: Update Environment Configuration

1. Update `lib/core/config/env_config.dart` with your Firebase project details
2. Update `lib/firebase_options.dart` with the generated configuration
3. Update web/index.html with Firebase config for web

## Step 8: Configure Firebase Emulators (for local development)

1. Initialize emulators:
```bash
firebase init emulators
```

2. Select: Authentication, Firestore, Functions, Storage, Hosting
3. Use default ports or customize
4. Start emulators:
```bash
firebase emulators:start
```

## Step 9: Security Considerations

1. Enable App Check for additional security
2. Configure domain restrictions in Firebase Console
3. Set up budget alerts to avoid unexpected charges
4. Enable audit logging

## Step 10: Testing

1. Test authentication flow
2. Test Firestore read/write permissions
3. Test Cloud Functions locally with emulators
4. Test file uploads to Storage

## Common Issues

### Issue: Functions deployment fails
- Ensure you're on the Blaze plan
- Check Node.js version matches functions requirement

### Issue: Permission denied in Firestore
- Check security rules
- Ensure user is authenticated
- Verify user has correct role

### Issue: CORS errors in web
- Add your domain to authorized domains in Firebase Console
- Check Storage CORS configuration

## Next Steps

1. Implement authentication in Flutter app
2. Create data models for Firestore
3. Implement Cloud Functions for business logic
4. Set up CI/CD pipeline
5. Configure monitoring and alerts