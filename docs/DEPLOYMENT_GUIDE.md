# Deployment Guide - Inventory Management SaaS

## Prerequisites

1. **Flutter SDK** (3.32.4 or higher)
2. **Firebase CLI** installed and configured
3. **Node.js** (v22.x) for Firebase Functions
4. **Git** for version control
5. **Firebase Project** created in Firebase Console

## Environment Setup

### 1. Firebase Configuration

1. Create a Firebase project at https://console.firebase.google.com
2. Enable the following services:
   - Authentication (Email/Password, Google Sign-In)
   - Cloud Firestore
   - Cloud Storage
   - Cloud Functions
   - Analytics
   - Crashlytics
   - Performance Monitoring

3. Configure Firebase for your platforms:
   ```bash
   # Initialize Firebase in your project
   firebase init
   
   # Select: Firestore, Functions, Hosting, Storage, Emulators
   ```

### 2. Environment Variables

Create `.env` files for different environments:

```bash
# .env.development
ENV=dev
API_URL=http://localhost:5001/your-project/us-central1/api
STRIPE_PUBLISHABLE_KEY=pk_test_...

# .env.production
ENV=prod
API_URL=https://us-central1-your-project.cloudfunctions.net/api
STRIPE_PUBLISHABLE_KEY=pk_live_...
```

## Build Process

### Web Deployment

1. Build the web application:
   ```bash
   flutter build web --dart-define=ENV=prod --no-tree-shake-icons
   ```

2. Deploy to Firebase Hosting:
   ```bash
   # Deploy to production
   firebase deploy --only hosting:production
   
   # Deploy to staging
   firebase deploy --only hosting:staging
   ```

### Mobile Deployment

#### Android
1. Update version in `pubspec.yaml`
2. Build the APK/AAB:
   ```bash
   # APK for testing
   flutter build apk --release --dart-define=ENV=prod
   
   # AAB for Play Store
   flutter build appbundle --release --dart-define=ENV=prod
   ```

#### iOS
1. Update version in `pubspec.yaml`
2. Build for iOS:
   ```bash
   flutter build ios --release --dart-define=ENV=prod
   ```
3. Archive and upload via Xcode

## Firebase Deployment

### 1. Security Rules
Deploy Firestore security rules:
```bash
firebase deploy --only firestore:rules
```

### 2. Indexes
Deploy Firestore indexes:
```bash
firebase deploy --only firestore:indexes
```

### 3. Cloud Functions
Deploy Cloud Functions:
```bash
cd functions
npm install
npm run build
firebase deploy --only functions
```

### 4. Storage Rules
Deploy Storage security rules:
```bash
firebase deploy --only storage
```

## Post-Deployment Checklist

### 1. Verify Services
- [ ] Authentication is working
- [ ] Firestore read/write operations
- [ ] Cloud Functions are accessible
- [ ] Storage upload/download
- [ ] Payment processing (Stripe)
- [ ] Email notifications

### 2. Configure Production Settings
- [ ] Set up custom domain in Firebase Hosting
- [ ] Configure OAuth redirect URIs
- [ ] Set up monitoring alerts
- [ ] Configure backup schedules
- [ ] Enable budget alerts

### 3. Security Measures
- [ ] Review and test security rules
- [ ] Enable App Check for additional security
- [ ] Configure CORS policies
- [ ] Set up SSL certificates
- [ ] Review API key restrictions

## Monitoring & Maintenance

### 1. Firebase Console Monitoring
- **Analytics**: User engagement and behavior
- **Crashlytics**: Crash reports and stability
- **Performance**: App performance metrics
- **Functions Logs**: Cloud Functions execution

### 2. Regular Maintenance Tasks
- Database backups (automated via Firebase)
- Security rules updates
- Dependency updates
- Performance optimization
- User feedback review

## Rollback Procedures

### Web Rollback
```bash
# List hosting releases
firebase hosting:releases:list

# Rollback to previous version
firebase hosting:rollback
```

### Functions Rollback
```bash
# Deploy previous function version
git checkout <previous-tag>
cd functions
npm run build
firebase deploy --only functions
```

## Troubleshooting

### Common Issues

1. **Build Failures**
   - Clean build: `flutter clean`
   - Update dependencies: `flutter pub upgrade`
   - Check Flutter version: `flutter doctor`

2. **Firebase Deployment Errors**
   - Verify Firebase CLI login: `firebase login`
   - Check project selection: `firebase use <project-id>`
   - Review function logs: `firebase functions:log`

3. **Performance Issues**
   - Enable Firestore offline persistence
   - Implement proper caching strategies
   - Optimize image loading
   - Use pagination for large datasets

## Production Configuration

### 1. Stripe Integration
1. Add production API keys to environment
2. Configure webhooks in Stripe Dashboard
3. Set up product catalog and pricing

### 2. Email Service
1. Configure email templates
2. Set up SMTP credentials
3. Test email deliverability

### 3. Analytics & Monitoring
1. Set up custom events
2. Configure conversion tracking
3. Set up error alerting

## Support & Resources

- **Documentation**: `/docs` directory
- **Firebase Console**: https://console.firebase.google.com
- **Flutter Documentation**: https://docs.flutter.dev
- **Support Email**: support@inventory.zaions.com

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2024-12-29 | Initial release |

---

Last Updated: December 29, 2024