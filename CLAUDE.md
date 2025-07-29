# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Inventory Management SaaS - A multi-tenant inventory management system built with Flutter, Firebase, and Drift.

## Key Documents
- `PROJECT_PLAN.md` - Comprehensive project plan and architecture
- `FEATURES.md` - Detailed feature specifications
- `PROGRESS.md` - Module completion tracking
- `DEVELOPMENT_GUIDE.md` - Development process documentation

## Technology Stack
- **Frontend**: Flutter (Web, iOS, Android)
- **Backend**: Firebase (Auth, Firestore, Functions, Storage)
- **Local DB**: Drift (SQLite)
- **State Management**: Riverpod
- **Payments**: Stripe

## Development Commands

### Flutter Commands
```bash
# Run in development
flutter run -d chrome --dart-define=ENV=dev

# Build for production
flutter build web --dart-define=ENV=prod

# Generate code (Drift, Freezed, etc.)
flutter pub run build_runner build --delete-conflicting-outputs

# Run tests
flutter test

# Analyze code
flutter analyze
```

### Firebase Commands
```bash
# Deploy to staging
firebase deploy --only hosting:staging

# Deploy functions
firebase deploy --only functions

# Run emulators
firebase emulators:start
```

## Project Structure
```
lib/
├── core/           # Core utilities, constants, themes
├── data/           # Data layer (models, repositories, datasources)
├── domain/         # Business logic (entities, use cases)
├── presentation/   # UI layer (pages, widgets, providers)
└── services/       # External services (auth, database, api)
```

## Current Status
Check `PROGRESS.md` for the latest development status and completed modules.

## Next Steps
Refer to the todo list and `PROGRESS.md` to see what needs to be implemented next.