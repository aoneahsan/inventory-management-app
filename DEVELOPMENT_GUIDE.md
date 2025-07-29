# Development Guide

## Overview
This guide documents the development process for the Inventory Management SaaS system, making it easy to replicate for future projects.

## Prerequisites
- Flutter SDK (latest stable)
- Firebase CLI
- Node.js (for Firebase Functions)
- Android Studio / Xcode (for mobile development)
- Git

## Development Workflow

### 1. Project Initialization
```bash
# Create Flutter project with organization
flutter create --org com.yourcompany --project-name inventory_management .

# Enable platforms
flutter config --enable-web
flutter config --enable-windows-desktop
flutter config --enable-macos-desktop
flutter config --enable-linux-desktop

# Initialize git
git init
git add .
git commit -m "Initial commit"
```

### 2. Project Structure
```
lib/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── utils/
│   └── theme/
├── data/
│   ├── models/
│   ├── repositories/
│   └── datasources/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── presentation/
│   ├── pages/
│   ├── widgets/
│   └── providers/
├── services/
│   ├── auth/
│   ├── database/
│   └── api/
└── main.dart
```

### 3. Dependencies Setup
Create `pubspec.yaml` dependencies:
```yaml
dependencies:
  # State Management
  flutter_riverpod: ^2.4.0
  riverpod_annotation: ^2.2.0
  
  # Navigation
  go_router: ^12.0.0
  
  # Firebase
  firebase_core: ^2.24.0
  firebase_auth: ^4.15.0
  cloud_firestore: ^4.13.0
  firebase_storage: ^11.5.0
  firebase_analytics: ^10.7.0
  firebase_crashlytics: ^3.4.0
  firebase_performance: ^0.9.3
  cloud_functions: ^4.5.0
  
  # Local Database
  drift: ^2.13.0
  sqlite3_flutter_libs: ^0.5.0
  path_provider: ^2.1.0
  
  # UI/UX
  flutter_native_splash: ^2.3.0
  introduction_screen: ^3.1.0
  
  # Utilities
  dio: ^5.3.0
  freezed_annotation: ^2.4.0
  json_annotation: ^4.8.0
  
  # Localization
  flutter_localizations:
    sdk: flutter
  intl: ^0.18.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.0
  drift_dev: ^2.13.0
  freezed: ^2.4.0
  json_serializable: ^6.7.0
  riverpod_generator: ^2.3.0
  flutter_lints: ^3.0.0
```

### 4. Firebase Setup
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize Firebase in project
firebase init

# Select:
# - Firestore
# - Functions
# - Hosting
# - Storage
# - Emulators
```

### 5. Environment Configuration
Create `lib/core/config/` directory with:
- `app_config.dart` - App configuration
- `firebase_config.dart` - Firebase options
- `env_config.dart` - Environment variables

### 6. Development Standards

#### Code Style
- Use `flutter_lints` for code analysis
- Follow effective Dart guidelines
- Maximum line length: 80 characters
- Use meaningful variable names

#### Git Workflow
- Feature branches: `feature/module-name`
- Commit format: `type: description`
  - feat: New feature
  - fix: Bug fix
  - docs: Documentation
  - style: Code style
  - refactor: Code refactoring
  - test: Tests
  - chore: Maintenance

#### Testing Strategy
- Unit tests for business logic
- Widget tests for UI components
- Integration tests for critical flows
- Minimum 80% code coverage

### 7. Module Development Process

For each module:
1. Create feature branch
2. Design data models
3. Implement repository pattern
4. Create use cases
5. Build UI components
6. Add state management
7. Write tests
8. Update documentation
9. Merge to main

### 8. Deployment

#### Development
```bash
flutter run -d chrome --dart-define=ENV=dev
```

#### Staging
```bash
flutter build web --dart-define=ENV=staging
firebase deploy --only hosting:staging
```

#### Production
```bash
flutter build web --dart-define=ENV=prod
firebase deploy --only hosting:production
```

### 9. Performance Optimization
- Lazy loading for routes
- Image optimization
- Code splitting
- Tree shaking
- Minimize Firebase reads

### 10. Security Checklist
- [ ] Environment variables secured
- [ ] Firebase security rules configured
- [ ] API keys restricted
- [ ] Input validation implemented
- [ ] SQL injection prevention (Drift)
- [ ] XSS protection
- [ ] Authentication properly implemented
- [ ] Authorization checks in place

## Troubleshooting

### Common Issues
1. **Firebase initialization error**
   - Ensure `firebase_options.dart` is generated
   - Check Firebase project configuration

2. **Drift build errors**
   - Run `flutter pub run build_runner build`
   - Delete `.dart_tool/` and rebuild

3. **Platform-specific issues**
   - Check platform-specific setup in documentation
   - Ensure all permissions are configured

## Resources
- [Flutter Documentation](https://docs.flutter.dev/)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Drift Documentation](https://drift.simonbinder.eu/)
- [Riverpod Documentation](https://riverpod.dev/)