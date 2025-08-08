# Developer Guide - Inventory Management System

## Table of Contents

1. [Architecture Overview](#architecture-overview)
2. [Development Setup](#development-setup)
3. [Project Structure](#project-structure)
4. [Technology Stack](#technology-stack)
5. [Core Concepts](#core-concepts)
6. [Development Workflow](#development-workflow)
7. [Testing](#testing)
8. [Deployment](#deployment)
9. [Best Practices](#best-practices)
10. [Troubleshooting](#troubleshooting)

## Architecture Overview

The Inventory Management System follows a multi-tier architecture:

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   Flutter App   │────▶│ Firebase Cloud  │────▶│  Cloud Storage  │
│   (Frontend)    │     │   Functions     │     │   & Firestore   │
└─────────────────┘     └─────────────────┘     └─────────────────┘
         │                       │                        │
         └───────────────────────┴────────────────────────┘
                              │
                    ┌─────────────────┐
                    │   Local SQLite  │
                    │    (Offline)     │
                    └─────────────────┘
```

### Key Components

1. **Frontend**: Flutter application (Web, iOS, Android)
2. **Backend**: Firebase services (Auth, Firestore, Functions, Storage)
3. **Local Database**: SQLite via Drift for offline functionality
4. **State Management**: Riverpod for reactive state management
5. **API Layer**: RESTful API via Cloud Functions

## Development Setup

### Prerequisites

- Flutter SDK 3.16.0 or higher
- Dart SDK 3.2.0 or higher
- Node.js 18+ and npm/yarn
- Firebase CLI
- Git
- IDE (VS Code or Android Studio recommended)

### Initial Setup

1. **Clone the repository**
```bash
git clone https://github.com/your-org/inventory-management.git
cd inventory-management
```

2. **Install Flutter dependencies**
```bash
flutter pub get
```

3. **Install Firebase Functions dependencies**
```bash
cd firebase/functions
yarn install
cd ../..
```

4. **Configure Firebase**
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize Firebase (select existing project)
firebase init
```

5. **Environment Configuration**

Create `.env` files:

`.env.development`
```env
ENV=development
API_URL=http://localhost:5001/your-project/us-central1/api
STRIPE_PUBLISHABLE_KEY=pk_test_xxx
USE_FIREBASE_EMULATOR=true
```

`.env.production`
```env
ENV=production
API_URL=https://us-central1-your-project.cloudfunctions.net/api
STRIPE_PUBLISHABLE_KEY=pk_live_xxx
USE_FIREBASE_EMULATOR=false
```

6. **Run Firebase Emulators**
```bash
firebase emulators:start
```

7. **Run the application**
```bash
# Web
flutter run -d chrome --dart-define-from-file=.env.development

# iOS
flutter run -d ios --dart-define-from-file=.env.development

# Android
flutter run -d android --dart-define-from-file=.env.development
```

## Project Structure

```
inventory-management/
├── lib/
│   ├── core/              # Core utilities, constants, themes
│   │   ├── constants/
│   │   ├── errors/
│   │   ├── themes/
│   │   └── utils/
│   ├── data/              # Data layer
│   │   ├── models/
│   │   ├── repositories/
│   │   └── datasources/
│   ├── domain/            # Business logic
│   │   ├── entities/
│   │   ├── repositories/
│   │   └── usecases/
│   ├── presentation/      # UI layer
│   │   ├── pages/
│   │   ├── widgets/
│   │   ├── providers/
│   │   └── router/
│   ├── services/          # External services
│   │   ├── auth/
│   │   ├── database/
│   │   ├── storage/
│   │   └── api/
│   └── main.dart          # Entry point
├── firebase/
│   └── functions/
│       ├── src/
│       │   ├── api/       # REST API endpoints
│       │   ├── triggers/  # Firestore triggers
│       │   └── services/  # Business logic
│       └── index.ts       # Function exports
├── test/                  # Unit and widget tests
├── integration_test/      # Integration tests
├── docs/                  # Documentation
└── pubspec.yaml          # Flutter dependencies
```

## Technology Stack

### Frontend
- **Flutter**: Cross-platform UI framework
- **Dart**: Programming language
- **Riverpod**: State management
- **GoRouter**: Navigation
- **Drift**: Local database (SQLite)
- **Dio**: HTTP client

### Backend
- **Firebase Auth**: Authentication
- **Cloud Firestore**: NoSQL database
- **Cloud Functions**: Serverless backend
- **Cloud Storage**: File storage
- **Firebase Messaging**: Push notifications

### Additional Libraries
- **Stripe**: Payment processing
- **SendGrid**: Email service
- **Twilio**: SMS service
- **Excel**: Report generation
- **PDF**: Document generation
- **Barcode**: Barcode generation

## Core Concepts

### State Management with Riverpod

```dart
// Provider definition
final productsProvider = StreamProvider<List<Product>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value([]);
  
  return ref.watch(productRepositoryProvider)
    .watchProducts(user.organizationId);
});

// Usage in widget
class ProductListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);
    
    return productsAsync.when(
      data: (products) => ListView.builder(...),
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => ErrorWidget(err),
    );
  }
}
```

### Offline-First Architecture

```dart
// Repository pattern with offline support
class ProductRepository {
  final FirebaseFirestore _firestore;
  final AppDatabase _database;
  
  Future<List<Product>> getProducts() async {
    try {
      // Try online first
      final snapshot = await _firestore
        .collection('products')
        .get();
      
      // Cache to local database
      await _database.saveProducts(products);
      
      return products;
    } catch (e) {
      // Fallback to offline
      return _database.getProducts();
    }
  }
}
```

### Clean Architecture Layers

1. **Domain Layer**: Business entities and logic
```dart
class Product {
  final String id;
  final String name;
  final double price;
  // ...
}
```

2. **Data Layer**: Implementation of repositories
```dart
class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<Product> createProduct(Product product) async {
    // Implementation
  }
}
```

3. **Presentation Layer**: UI and state management
```dart
class ProductFormPage extends ConsumerStatefulWidget {
  // UI implementation
}
```

## Development Workflow

### Git Flow

1. **Main branches**
   - `main`: Production-ready code
   - `develop`: Integration branch
   - `feature/*`: New features
   - `bugfix/*`: Bug fixes
   - `hotfix/*`: Urgent production fixes

2. **Commit conventions**
```bash
# Format: <type>(<scope>): <subject>

feat(products): add barcode scanning
fix(auth): resolve login timeout issue
docs(api): update endpoint documentation
refactor(pos): improve checkout flow
test(inventory): add unit tests for stock adjustment
```

### Code Generation

Run code generation for Drift, Freezed, and other generators:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Watch mode for development:
```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Linting and Formatting

```bash
# Format code
dart format lib/

# Analyze code
flutter analyze

# Fix issues
dart fix --apply
```

## Testing

### Unit Tests

```dart
// test/services/product_service_test.dart
void main() {
  group('ProductService', () {
    late ProductService service;
    late MockFirestore mockFirestore;
    
    setUp(() {
      mockFirestore = MockFirestore();
      service = ProductService(firestore: mockFirestore);
    });
    
    test('should create product', () async {
      final product = Product(name: 'Test', price: 10.0);
      final result = await service.createProduct(product);
      
      expect(result.id, isNotEmpty);
      expect(result.name, equals('Test'));
    });
  });
}
```

### Widget Tests

```dart
// test/widgets/product_card_test.dart
void main() {
  testWidgets('ProductCard displays product info', (tester) async {
    final product = Product(
      name: 'Test Product',
      price: 29.99,
      stock: 10,
    );
    
    await tester.pumpWidget(
      MaterialApp(
        home: ProductCard(product: product),
      ),
    );
    
    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('\$29.99'), findsOneWidget);
  });
}
```

### Integration Tests

```dart
// integration_test/app_test.dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  testWidgets('Complete purchase flow', (tester) async {
    app.main();
    await tester.pumpAndSettle();
    
    // Login
    await tester.enterText(find.byKey(Key('email')), 'test@example.com');
    await tester.enterText(find.byKey(Key('password')), 'password');
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();
    
    // Navigate to POS
    await tester.tap(find.text('POS'));
    await tester.pumpAndSettle();
    
    // Add product and complete sale
    // ...
  });
}
```

### Running Tests

```bash
# Unit tests
flutter test

# Widget tests
flutter test test/widgets/

# Integration tests
flutter test integration_test/

# Coverage report
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## Deployment

### Web Deployment

1. **Build for production**
```bash
flutter build web --dart-define-from-file=.env.production
```

2. **Deploy to Firebase Hosting**
```bash
firebase deploy --only hosting
```

### Mobile Deployment

#### iOS
1. **Configure signing in Xcode**
2. **Build for release**
```bash
flutter build ios --dart-define-from-file=.env.production
```
3. **Upload to App Store Connect**

#### Android
1. **Configure signing**
```bash
# Create keystore
keytool -genkey -v -keystore upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias upload
```

2. **Build APK/AAB**
```bash
flutter build appbundle --dart-define-from-file=.env.production
```

3. **Upload to Google Play Console**

### Cloud Functions Deployment

```bash
cd firebase/functions
yarn build
firebase deploy --only functions
```

### Environment-Specific Deployment

```bash
# Deploy to staging
firebase use staging
firebase deploy

# Deploy to production
firebase use production
firebase deploy
```

## Best Practices

### Code Quality

1. **Follow Dart style guide**
2. **Use strong typing**
3. **Implement proper error handling**
4. **Write self-documenting code**
5. **Keep functions small and focused**

### Performance

1. **Lazy load routes and features**
2. **Optimize images and assets**
3. **Use const constructors**
4. **Implement proper caching**
5. **Minimize rebuilds with proper state management**

### Security

1. **Validate all inputs**
2. **Implement proper authentication checks**
3. **Use environment variables for secrets**
4. **Enable Firebase Security Rules**
5. **Implement rate limiting**
6. **Regular security audits**

### Database

1. **Design efficient data structures**
2. **Use compound queries wisely**
3. **Implement proper indexing**
4. **Batch write operations**
5. **Monitor usage and costs**

## Troubleshooting

### Common Issues

#### Build Failures
```bash
# Clean build
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

#### Firebase Connection Issues
```bash
# Check Firebase configuration
firebase projects:list
firebase use --add

# Verify google-services files
# iOS: ios/Runner/GoogleService-Info.plist
# Android: android/app/google-services.json
```

#### State Management Issues
- Ensure providers are properly scoped
- Check for circular dependencies
- Verify provider disposal

#### Performance Issues
- Use Flutter DevTools
- Profile with Observatory
- Check for unnecessary rebuilds
- Optimize database queries

### Debug Tools

1. **Flutter Inspector**: Widget tree and properties
2. **Flutter DevTools**: Performance profiling
3. **Firebase Console**: Monitor backend
4. **Sentry**: Error tracking
5. **Analytics**: User behavior insights

### Getting Help

- **Documentation**: Check `/docs` folder
- **GitHub Issues**: Report bugs
- **Discord**: Developer community
- **Stack Overflow**: Tag with `flutter` and `firebase`

## Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Riverpod Documentation](https://riverpod.dev)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Flutter Cookbook](https://flutter.dev/docs/cookbook)

---

*Last updated: January 2024*