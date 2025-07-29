# Setup Instructions

This guide will help you set up the Inventory Management SaaS project from scratch.

## Prerequisites

Ensure you have the following installed:
- Flutter SDK 3.32.4 or higher
- Node.js v22.x (for Firebase Functions)
- Firebase CLI (`npm install -g firebase-tools`)
- Git

## Step 1: Clone the Repository

```bash
git clone <repository-url>
cd inventory-management
```

## Step 2: Install Dependencies

### Flutter Dependencies
```bash
flutter pub get
```

### Firebase Functions Dependencies
```bash
cd functions
npm install
cd ..
```

## Step 3: Firebase Project Setup

### 3.1 Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com)
2. Click "Create Project"
3. Enter project name (e.g., "inventory-management-prod")
4. Enable Google Analytics (optional)

### 3.2 Enable Firebase Services
In your Firebase project, enable:
- **Authentication**
  - Email/Password
  - Google Sign-In
- **Cloud Firestore**
  - Create database in production mode
- **Cloud Storage**
  - Create default bucket
- **Cloud Functions**
  - Upgrade to Blaze plan (required for functions)

### 3.3 Configure Firebase CLI
```bash
# Login to Firebase
firebase login

# Initialize Firebase in your project
firebase init

# Select the following options:
# - Firestore
# - Functions
# - Hosting
# - Storage
# - Emulators (for local development)

# When asked about overwriting files, choose 'No' to keep existing configurations
```

### 3.4 Generate Firebase Configuration
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase for your Flutter app
flutterfire configure

# Select your Firebase project and platforms (Web, Android, iOS)
# This will generate/update lib/firebase_options.dart
```

## Step 4: Environment Configuration

### 4.1 Create Environment Files
```bash
# Copy the example file
cp .env.example .env.development
cp .env.example .env.production

# Edit the files with your actual values
# Important: Never commit .env files to version control
```

### 4.2 Update Firebase Project ID
```bash
# Copy the example file
cp .firebaserc.example .firebaserc

# Edit .firebaserc with your actual project IDs
```

## Step 5: Deploy Firebase Backend

### 5.1 Deploy Security Rules
```bash
firebase deploy --only firestore:rules
```

### 5.2 Deploy Indexes
```bash
firebase deploy --only firestore:indexes
```

### 5.3 Build and Deploy Functions
```bash
cd functions
npm run build
firebase deploy --only functions
cd ..
```

### 5.4 Deploy Storage Rules
```bash
firebase deploy --only storage
```

## Step 6: Configure Stripe (Optional)

1. Create a [Stripe account](https://stripe.com)
2. Get your API keys from Stripe Dashboard
3. Add keys to your `.env` files:
   ```
   STRIPE_PUBLISHABLE_KEY=pk_test_...
   STRIPE_SECRET_KEY=sk_test_...
   ```
4. Set up webhooks in Stripe Dashboard pointing to your Cloud Function endpoint

## Step 7: Run the Application

### Development with Emulators
```bash
# Start Firebase emulators
firebase emulators:start

# In a new terminal, run the app
flutter run -d chrome --dart-define=ENV=dev --dart-define=USE_FIREBASE_EMULATOR=true
```

### Development without Emulators
```bash
flutter run -d chrome --dart-define=ENV=dev
```

## Step 8: Build for Production

### Web
```bash
flutter build web --dart-define=ENV=prod --no-tree-shake-icons
```

### Deploy to Firebase Hosting
```bash
firebase deploy --only hosting
```

### Mobile (Android)
```bash
# First, uncomment mobile_scanner in pubspec.yaml
flutter build apk --release --dart-define=ENV=prod
```

### Mobile (iOS)
```bash
# First, uncomment mobile_scanner in pubspec.yaml
flutter build ios --release --dart-define=ENV=prod
```

## Troubleshooting

### Build Errors
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter build web --dart-define=ENV=prod --no-tree-shake-icons
```

### Firebase Errors
- Ensure you're logged in: `firebase login`
- Check project selection: `firebase use --add`
- Verify Blaze plan is active for Cloud Functions

### Dependencies Issues
```bash
# Update all dependencies
flutter pub upgrade --major-versions
```

## Next Steps

1. Set up monitoring in Firebase Console
2. Configure custom domain for hosting
3. Set up CI/CD pipeline
4. Configure backups for Firestore
5. Set up error tracking (Sentry/Crashlytics)

## Support

For issues or questions:
1. Check the [documentation](docs/)
2. Review [common issues](docs/TROUBLESHOOTING.md)
3. Contact support@inventorypro.com

---

Last Updated: December 29, 2024