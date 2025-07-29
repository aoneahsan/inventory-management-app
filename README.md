# Inventory Management SaaS

A comprehensive, multi-tenant inventory management system built with Flutter and Firebase. This production-ready application supports web, iOS, and Android platforms with offline capabilities and real-time synchronization.

## 🚀 Features

### Core Functionality
- **Multi-tenant Architecture** - Support for multiple organizations with isolated data
- **Real-time Inventory Tracking** - Live stock updates across all devices
- **Multi-warehouse Support** - Manage inventory across multiple locations
- **Order Management** - Handle purchase and sales orders with status tracking
- **Product Categorization** - Organize products with hierarchical categories
- **Barcode Support** - Generate and scan barcodes (mobile only)

### Advanced Features
- **Role-based Access Control** - Fine-grained permissions system
- **Offline Support** - Full functionality without internet connection
- **Analytics & Reporting** - Visual insights with charts and exportable reports
- **Activity Logging** - Complete audit trail of all actions
- **Multi-language Support** - English, Spanish, and French
- **Dark/Light Theme** - Customizable UI with theme persistence

### Business Features
- **Subscription Management** - Integrated with Stripe for payments
- **Email Notifications** - Automated alerts and updates
- **Data Export** - Export reports in PDF, Excel, and CSV formats
- **Custom Branding** - Personalize with organization colors and logo

## 🛠️ Technology Stack

- **Frontend**: Flutter (Web, iOS, Android)
- **Backend**: Firebase (Auth, Firestore, Functions, Storage)
- **Database**: Cloud Firestore + SQLite (offline)
- **State Management**: Riverpod
- **Authentication**: Firebase Auth (Email/Password, Google)
- **Payments**: Stripe
- **Analytics**: Firebase Analytics
- **Crash Reporting**: Firebase Crashlytics

## 📋 Prerequisites

- Flutter SDK (3.32.4 or higher)
- Dart SDK (3.8.1 or higher)
- Firebase CLI
- Node.js (v22.x) for Firebase Functions
- Git

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone https://github.com/aoneahsan/inventory-management-app.git
cd inventory-management-app
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Firebase Setup
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize Firebase project
firebase init

# Select: Firestore, Functions, Hosting, Storage, Emulators
```

### 4. Environment Configuration
Create environment files:
```bash
# Copy example files
cp .env.example .env.development
cp .env.example .env.production

# Edit with your configuration
```

### 5. Run Development Server
```bash
# Run with development environment
flutter run -d chrome --dart-define=ENV=dev

# Or use Firebase emulators
firebase emulators:start
flutter run -d chrome --dart-define=ENV=dev --dart-define=USE_FIREBASE_EMULATOR=true
```

## 🏗️ Project Structure

```
lib/
├── core/               # Core utilities, constants, themes
│   ├── constants/      # App constants and configurations
│   ├── errors/         # Error handling and exceptions
│   ├── theme/          # App themes and styling
│   └── utils/          # Utility functions and helpers
├── data/               # Data layer
│   ├── models/         # Data models
│   ├── repositories/   # Data repositories
│   └── datasources/    # Local and remote data sources
├── domain/             # Business logic
│   ├── entities/       # Business entities
│   └── usecases/       # Business use cases
├── presentation/       # UI layer
│   ├── pages/          # App screens
│   ├── widgets/        # Reusable widgets
│   └── providers/      # Riverpod providers
└── services/           # External services
    ├── auth/           # Authentication service
    ├── database/       # Database services
    └── sync/           # Synchronization service

functions/              # Firebase Cloud Functions
├── src/                # TypeScript source files
└── lib/                # Compiled JavaScript
```

## 📱 Building for Production

### Web
```bash
flutter build web --dart-define=ENV=prod --no-tree-shake-icons
```

### Android
```bash
# Enable mobile_scanner in pubspec.yaml first
flutter build apk --release --dart-define=ENV=prod
```

### iOS
```bash
# Enable mobile_scanner in pubspec.yaml first
flutter build ios --release --dart-define=ENV=prod
```

## 🚀 Deployment

### Deploy to Firebase Hosting
```bash
# Deploy everything
firebase deploy

# Deploy specific services
firebase deploy --only hosting
firebase deploy --only functions
firebase deploy --only firestore:rules,firestore:indexes
```

## 📖 Documentation

- [Project Plan](docs/PROJECT_PLAN.md) - Architecture and technical specifications
- [Features Guide](docs/FEATURES.md) - Detailed feature documentation
- [Development Guide](docs/DEVELOPMENT_GUIDE.md) - Development workflow and standards
- [Deployment Guide](docs/DEPLOYMENT_GUIDE.md) - Production deployment instructions
- [API Documentation](docs/API.md) - Cloud Functions API reference

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/specific_test.dart
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase team for the backend infrastructure
- All contributors and testers

## 📞 Support

For support, email support@inventory.zaions.com or visit our website.

---

Built with ❤️ using Flutter and Firebase