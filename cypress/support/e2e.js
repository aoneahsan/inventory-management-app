// Import commands.js using ES2015 syntax:
import './commands';

// Cypress Configuration
Cypress.on('uncaught:exception', (err, runnable) => {
  // Flutter apps might throw some errors that we want to ignore
  // returning false here prevents Cypress from failing the test
  if (err.message.includes('ResizeObserver loop limit exceeded')) {
    return false;
  }
  // Ignore database initialization errors
  if (err.message.includes('databaseFactory not initialized')) {
    return false;
  }
  // Ignore sqflite warnings
  if (err.message.includes('sqflite warning')) {
    return false;
  }
  // Let other errors fail the test
  return true;
});

// Before each test
beforeEach(() => {
  // Clear local storage and session storage
  cy.clearLocalStorage();
  cy.clearCookies();
  
  // Visit the base URL
  cy.visit('/');
});

// Custom command to wait for Flutter to be ready
Cypress.Commands.add('waitForFlutter', () => {
  // For Flutter web apps, we just need to wait for the app to load
  // Flutter web doesn't expose a 'flutter' property on window
  cy.wait(3000); // Give Flutter time to fully initialize
});