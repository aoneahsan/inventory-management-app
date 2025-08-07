# Cypress E2E Tests for Inventory Management App

## Overview
This directory contains end-to-end tests for the Inventory Management SaaS application using Cypress.

## Test Structure

### Test Suites
1. **01-auth.cy.js** - Authentication tests (login, register, password reset)
2. **02-dashboard.cy.js** - Dashboard and navigation tests
3. **03-products.cy.js** - Product management tests
4. **04-pos.cy.js** - Point of Sale system tests
5. **05-inventory.cy.js** - Inventory movements and categories
6. **06-advanced-features.cy.js** - Advanced features (multi-location, transfers, etc.)
7. **07-settings.cy.js** - Settings and configuration tests
8. **08-analytics.cy.js** - Analytics and reporting tests

## Running Tests

### Prerequisites
1. Build the Flutter web app:
   ```bash
   flutter build web
   ```

2. Start a local web server:
   ```bash
   cd build/web
   python3 -m http.server 5000
   # or
   npx serve -p 5000
   ```

### Run Tests

**Interactive Mode (Recommended for development):**
```bash
yarn cypress:open
```

**Headless Mode (For CI/CD):**
```bash
yarn cypress:run
```

**Run specific test file:**
```bash
yarn cypress run --spec "cypress/e2e/01-auth.cy.js"
```

## Custom Commands

The following custom commands are available in `cypress/support/commands.js`:

- `cy.login(email, password)` - Login with credentials
- `cy.logout()` - Logout current user
- `cy.navigateTo(pageName)` - Navigate to a specific page
- `cy.checkNoConsoleErrors()` - Verify no console errors
- `cy.waitForPageLoad()` - Wait for page to fully load
- `cy.createTestProduct(productData)` - Create a test product
- `cy.waitForFlutter()` - Wait for Flutter to initialize

## Test Data

Test fixtures are located in `cypress/fixtures/test-data.json` and include:
- Test users with different roles
- Sample products
- Categories
- Organization data
- Branch locations

## Configuration

Cypress configuration is in `cypress.config.js` with:
- Base URL: http://localhost:5000
- Viewport: 1280x720
- Video recording enabled
- Screenshots on failure
- Custom timeouts for Flutter app

## Writing New Tests

1. Create a new file in `cypress/e2e/` with `.cy.js` extension
2. Use existing patterns from other test files
3. Leverage custom commands for common operations
4. Add test data to fixtures if needed
5. Use data-testid attributes for reliable element selection

## Best Practices

1. **Use data-testid attributes** instead of CSS selectors
2. **Wait for Flutter** to initialize before interacting
3. **Check for console errors** after each test
4. **Use fixtures** for test data consistency
5. **Group related tests** in describe blocks
6. **Clean up** after tests (logout, clear data)

## Troubleshooting

### Flutter not loading
- Ensure web server is running on port 5000
- Check that Flutter build is up to date
- Increase timeout in cypress.config.js

### Elements not found
- Add data-testid attributes to Flutter widgets
- Use cy.waitForPageLoad() before assertions
- Check if element is in viewport

### Authentication issues
- Set up test users in Firebase
- Use Firebase emulators for isolated testing
- Mock authentication for faster tests

## CI/CD Integration

To run in CI/CD pipeline:

```yaml
# Example GitHub Actions
- name: Build Flutter Web
  run: flutter build web
  
- name: Start Web Server
  run: npx serve build/web -p 5000 &
  
- name: Run Cypress Tests
  run: yarn cypress:run --record
```

## Future Improvements

1. Add visual regression tests
2. Implement API mocking for faster tests
3. Add performance testing
4. Create more granular test data
5. Add accessibility tests