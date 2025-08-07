describe('Advanced Features Tests', () => {
  beforeEach(() => {
    cy.visit('/advanced-features');
    cy.waitForFlutter();
  });

  it('should load the advanced features hub', () => {
    // Check page title
    cy.contains('Advanced Features').should('be.visible');
    
    // Check feature cards
    cy.contains('Multi-Location Management').should('be.visible');
    cy.contains('Stock Transfers').should('be.visible');
    cy.contains('Serial/Batch Tracking').should('be.visible');
    cy.contains('Composite Items').should('be.visible');
    cy.contains('Repackaging').should('be.visible');
    cy.contains('Tax Management').should('be.visible');
    cy.contains('Communication').should('be.visible');
    cy.contains('Scheduled Reports').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should navigate to branches page', () => {
    cy.contains('Multi-Location Management').click();
    cy.url().should('include', '/branches');
    
    // Check branches page
    cy.contains('Branches').should('be.visible');
    cy.contains('button', 'Add Branch').should('be.visible');
    cy.get('[data-testid="branch-list"]').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should navigate to stock transfers page', () => {
    cy.contains('Stock Transfers').click();
    cy.url().should('include', '/stock-transfers');
    
    // Check stock transfers page
    cy.contains('Stock Transfers').should('be.visible');
    cy.contains('button', 'New Transfer').should('be.visible');
    cy.get('[data-testid="transfer-list"]').should('be.visible');
    
    // Check status filters
    cy.contains('Pending').should('be.visible');
    cy.contains('Approved').should('be.visible');
    cy.contains('In Transit').should('be.visible');
    cy.contains('Completed').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should navigate to serial/batch tracking', () => {
    cy.contains('Serial/Batch Tracking').click();
    cy.url().should('include', '/serial-batch');
    
    // Check page tabs
    cy.contains('Serial Numbers').should('be.visible');
    cy.contains('Batches').should('be.visible');
    
    // Check search functionality
    cy.get('[data-testid="serial-search"]').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should navigate to composite items', () => {
    cy.contains('Composite Items').click();
    cy.url().should('include', '/composite-items');
    
    // Check page elements
    cy.contains('Composite Items').should('be.visible');
    cy.contains('button', 'Create Bundle').should('be.visible');
    cy.get('[data-testid="composite-list"]').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should navigate to repackaging page', () => {
    cy.contains('Repackaging').click();
    cy.url().should('include', '/repackaging');
    
    // Check page elements
    cy.contains('Repackaging Rules').should('be.visible');
    cy.contains('button', 'Add Rule').should('be.visible');
    cy.contains('button', 'Execute Repackaging').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should navigate to tax rates', () => {
    cy.contains('Tax Management').click();
    cy.url().should('include', '/tax-rates');
    
    // Check page elements
    cy.contains('Tax Rates').should('be.visible');
    cy.contains('button', 'Add Tax Rate').should('be.visible');
    
    // Check GST presets
    cy.contains('GST Presets').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should navigate to communication templates', () => {
    cy.contains('Communication').click();
    cy.url().should('include', '/communication-templates');
    
    // Check page elements
    cy.contains('Communication Templates').should('be.visible');
    cy.contains('button', 'Add Template').should('be.visible');
    
    // Check template types
    cy.contains('SMS').should('be.visible');
    cy.contains('Email').should('be.visible');
    cy.contains('WhatsApp').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should navigate to scheduled reports', () => {
    cy.contains('Scheduled Reports').click();
    cy.url().should('include', '/scheduled-reports');
    
    // Check page elements
    cy.contains('Scheduled Reports').should('be.visible');
    cy.contains('button', 'Add Report').should('be.visible');
    cy.get('[data-testid="report-list"]').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });
});