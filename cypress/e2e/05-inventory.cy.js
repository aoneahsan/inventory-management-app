describe('Inventory Management Tests', () => {
  beforeEach(() => {
    cy.visit('/inventory');
    cy.waitForFlutter();
  });

  it('should load the inventory movements page', () => {
    // Check page elements
    cy.contains('Inventory Movements').should('be.visible');
    cy.contains('button', 'Stock In').should('be.visible');
    cy.contains('button', 'Stock Out').should('be.visible');
    cy.contains('button', 'Transfer').should('be.visible');
    
    // Check filters
    cy.get('[data-testid="movement-type-filter"]').should('be.visible');
    cy.get('[data-testid="date-range-filter"]').should('be.visible');
    cy.get('[data-testid="product-filter"]').should('be.visible');
    
    // Check movement list
    cy.get('[data-testid="movement-list"]').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should open stock in dialog', () => {
    cy.contains('button', 'Stock In').click();
    
    // Check dialog elements
    cy.contains('Stock In').should('be.visible');
    cy.get('[data-testid="product-select"]').should('be.visible');
    cy.get('[data-testid="quantity-input"]').should('be.visible');
    cy.get('[data-testid="reason-select"]').should('be.visible');
    cy.get('[data-testid="notes-input"]').should('be.visible');
    
    // Check action buttons
    cy.contains('button', 'Save').should('be.visible');
    cy.contains('button', 'Cancel').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should open stock out dialog', () => {
    cy.contains('button', 'Stock Out').click();
    
    // Check dialog elements
    cy.contains('Stock Out').should('be.visible');
    cy.get('[data-testid="product-select"]').should('be.visible');
    cy.get('[data-testid="quantity-input"]').should('be.visible');
    cy.get('[data-testid="reason-select"]').should('be.visible');
    
    // Check reasons
    cy.get('[data-testid="reason-select"]').click();
    cy.contains('Sold').should('be.visible');
    cy.contains('Damaged').should('be.visible');
    cy.contains('Expired').should('be.visible');
    cy.contains('Lost').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should filter movements by type', () => {
    // Click type filter
    cy.get('[data-testid="movement-type-filter"]').click();
    
    // Select Stock In
    cy.contains('Stock In').click();
    
    // Check filtered results
    cy.get('[data-testid="movement-list"]').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should show movement details', () => {
    // Click on a movement item
    cy.get('[data-testid="movement-item"]').first().click();
    
    // Check details dialog
    cy.contains('Movement Details').should('be.visible');
    cy.contains('Product').should('be.visible');
    cy.contains('Quantity').should('be.visible');
    cy.contains('Type').should('be.visible');
    cy.contains('Date').should('be.visible');
    cy.contains('Reason').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should load categories page', () => {
    cy.visit('/categories');
    cy.waitForFlutter();
    
    // Check page elements
    cy.contains('Categories').should('be.visible');
    cy.contains('button', 'Add Category').should('be.visible');
    
    // Check category tree
    cy.get('[data-testid="category-tree"]').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should open add category dialog', () => {
    cy.visit('/categories');
    cy.waitForFlutter();
    
    cy.contains('button', 'Add Category').click();
    
    // Check dialog fields
    cy.contains('Add Category').should('be.visible');
    cy.get('[data-testid="category-name"]').should('be.visible');
    cy.get('[data-testid="parent-category"]').should('be.visible');
    cy.get('[data-testid="category-description"]').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });
});