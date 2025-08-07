// Import commands.js using ES2015 syntax:
import './commands';

// Cypress Configuration
Cypress.on('uncaught:exception', (err, runnable) => {
  // Flutter apps might throw some errors that we want to ignore
  // returning false here prevents Cypress from failing the test
  if (err.message.includes('ResizeObserver loop limit exceeded')) {
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
  cy.window().should('have.property', 'flutter');
  cy.wait(2000); // Give Flutter time to fully initialize
});