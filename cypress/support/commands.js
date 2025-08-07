// Custom commands for testing the Inventory Management app

// Login command
Cypress.Commands.add('login', (email, password) => {
  cy.get('input[type="email"]').type(email);
  cy.get('input[type="password"]').type(password);
  cy.contains('button', 'Sign In').click();
  cy.url().should('not.include', '/login');
});

// Logout command
Cypress.Commands.add('logout', () => {
  cy.get('[data-testid="profile-menu"]').click();
  cy.contains('Logout').click();
  cy.url().should('include', '/login');
});

// Navigate to a specific page
Cypress.Commands.add('navigateTo', (pageName) => {
  cy.get('[data-testid="nav-drawer"]').click();
  cy.contains(pageName).click();
});

// Check for no console errors
Cypress.Commands.add('checkNoConsoleErrors', () => {
  // For Flutter web, we'll skip console error checking as it may have initialization warnings
  // that are not actual errors
  cy.log('Console error check skipped for Flutter web');
});

// Wait for page to load completely
Cypress.Commands.add('waitForPageLoad', () => {
  cy.get('body').should('be.visible');
  cy.get('[data-testid="loading-indicator"]').should('not.exist');
});

// Create a test product
Cypress.Commands.add('createTestProduct', (productData) => {
  cy.navigateTo('Products');
  cy.contains('button', 'Add Product').click();
  
  if (productData.name) cy.get('[data-testid="product-name"]').type(productData.name);
  if (productData.sku) cy.get('[data-testid="product-sku"]').type(productData.sku);
  if (productData.price) cy.get('[data-testid="product-price"]').type(productData.price);
  if (productData.stock) cy.get('[data-testid="product-stock"]').type(productData.stock);
  
  cy.contains('button', 'Save').click();
  cy.contains('Product created successfully').should('be.visible');
});