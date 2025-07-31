# Testing Guide

## Setup

To run tests for the inventory management plugin, you need to:

1. Add test dependencies to `pubspec.yaml`:
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.0
  build_runner: ^2.4.0
```

2. Generate mocks:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Running Tests

Run all tests:
```bash
flutter test
```

Run specific test file:
```bash
flutter test test/services/product_service_test.dart
```

Run with coverage:
```bash
flutter test --coverage
```

## Test Structure

Tests are organized by feature:
- `test/services/` - Service layer tests
- `test/repositories/` - Repository tests
- `test/widgets/` - Widget tests
- `test/integration/` - Integration tests

## Writing Tests

Example test structure:
```dart
void main() {
  group('FeatureName', () {
    setUp(() {
      // Setup test dependencies
    });

    tearDown(() {
      // Cleanup after tests
    });

    test('should do something', () async {
      // Arrange
      // Act
      // Assert
    });
  });
}
```

## Mocking

Use Mockito for mocking dependencies:
```dart
@GenerateMocks([Repository, Service])
void main() {
  // Tests
}
```

Then generate mocks:
```bash
flutter pub run build_runner build
```