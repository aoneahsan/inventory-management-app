# E2E Testing with Cypress

## Overview

This document describes the end-to-end testing setup using Cypress for the Inventory Management application.

## Current Status

### Completed
- ✅ Cypress installed and configured
- ✅ Basic test structure created
- ✅ Custom commands implemented
- ✅ Flutter web build working
- ✅ Basic app loading tests passing

### Known Issues
1. **Flutter Web Loading**: The Flutter web app takes 10-15 seconds to fully initialize
2. **Route Navigation**: The app uses hash routing (#/) which requires special handling in tests
3. **Dynamic Content**: Flutter renders content dynamically, requiring longer wait times

## Test Files

### Core Test Suites
- `01-auth.cy.js` - Authentication flow tests
- `02-dashboard.cy.js` - Dashboard functionality
- `03-products.cy.js` - Product management
- `04-pos.cy.js` - Point of Sale features
- `05-inventory.cy.js` - Inventory management
- `06-advanced-features.cy.js` - Advanced features
- `07-settings.cy.js` - Settings and configuration
- `08-analytics.cy.js` - Analytics and reporting

### Diagnostic Tests
- `00-basic.cy.js` - Basic app loading tests
- `00-diagnostic.cy.js` - Detailed page content diagnostics
- `00-simple-diagnostic.cy.js` - Simple diagnostic checks

## Running Tests

### Prerequisites
1. Build the Flutter web app:
   ```bash
   flutter build web --dart-define=ENV=dev --no-tree-shake-icons
   ```

2. Start a local web server:
   ```bash
   cd build/web && python3 -m http.server 8080
   ```

### Run Tests
```bash
# Run all tests
yarn cypress:run

# Run specific test
yarn cypress:run --spec "cypress/e2e/01-auth.cy.js"

# Run tests in headed mode (with UI)
yarn cypress:open

# Run tests headlessly
yarn cypress:run:headless
```

## Test Configuration

### cypress.config.js
- Base URL: `http://localhost:8080`
- Default timeout: 10 seconds
- Page load timeout: 30 seconds
- Chrome web security: disabled (for cross-origin requests)

### Custom Commands
Located in `cypress/support/commands.js`:
- `login(email, password)` - Login helper
- `logout()` - Logout helper
- `navigateTo(pageName)` - Navigation helper
- `checkNoConsoleErrors()` - Console error checking
- `waitForPageLoad()` - Wait for page to load
- `createTestProduct(productData)` - Create test product

## Writing Tests for Flutter Web

### Best Practices

1. **Wait for Flutter to Initialize**
   ```javascript
   cy.visit('/');
   cy.wait(10000); // Give Flutter time to load
   ```

2. **Use Flexible Selectors**
   ```javascript
   // Instead of exact text
   cy.contains(/Sign In|Login/i)
   
   // Multiple selector options
   const selectors = ['button:contains("Login")', 'a:contains("Sign In")'];
   ```

3. **Handle Dynamic Content**
   ```javascript
   cy.get('body').then($body => {
     if ($body.text().includes('Loading')) {
       cy.wait(5000);
     }
   });
   ```

4. **Check for Route Changes**
   ```javascript
   cy.url().should('match', /(dashboard|home)/);
   ```

## Common Issues and Solutions

### Issue: Tests timeout waiting for elements
**Solution**: Increase wait times for Flutter initialization
```javascript
cy.wait(15000); // Wait 15 seconds
cy.get('element', { timeout: 30000 }); // 30 second timeout
```

### Issue: Elements not found
**Solution**: Use more flexible selectors
```javascript
// Use contains with regex
cy.contains(/submit|save|confirm/i);

// Check multiple possible selectors
cy.get('body').then($body => {
  const found = $body.find('button').length > 0;
  if (found) {
    cy.get('button').first().click();
  }
});
```

### Issue: Navigation doesn't work as expected
**Solution**: Use hash routing
```javascript
// Instead of cy.visit('/login')
cy.visit('/#/login');
// Or navigate through UI
cy.contains('Login').click();
```

## Future Improvements

1. **Add Firebase Emulator Support**: Configure tests to work with Firebase emulators
2. **Implement Page Objects**: Create page object models for better test organization
3. **Add Visual Regression Tests**: Implement screenshot comparison tests
4. **Performance Monitoring**: Add performance metrics to tests
5. **CI/CD Integration**: Set up automated test runs in CI pipeline

## Debugging Tests

1. **Take Screenshots**
   ```javascript
   cy.screenshot('debug-screenshot');
   ```

2. **Log Page Content**
   ```javascript
   cy.get('body').invoke('text').then(text => {
     cy.log('Page content:', text);
   });
   ```

3. **Check Console Logs**
   Open Cypress in headed mode to see browser console logs:
   ```bash
   yarn cypress:open
   ```

4. **Use Cypress Dashboard**
   View test recordings and screenshots in the Cypress dashboard

## Test Data

### Test Credentials
- Email: `test@example.com`
- Password: `testPassword123`

### Environment Variables
Set in `cypress.config.js`:
- `testEmail`: Test user email
- `testPassword`: Test user password
- `firebaseAuthEmulator`: Auth emulator URL
- `firestoreEmulator`: Firestore emulator URL