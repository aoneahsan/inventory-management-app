describe('Dashboard Tests', () => {
  beforeEach(() => {
    // Mock login or use test credentials
    cy.visit('/login');
    cy.waitForFlutter();
    // Note: In a real test, you'd login with test credentials
    // For now, we'll just check if dashboard is accessible
  });

  it('should load the dashboard page', () => {
    cy.visit('/dashboard');
    cy.waitForFlutter();
    
    // Check for dashboard elements
    cy.contains('Dashboard').should('be.visible');
    
    // Check for main metric cards
    cy.contains('Total Products').should('be.visible');
    cy.contains('Low Stock Items').should('be.visible');
    cy.contains('Total Categories').should('be.visible');
    cy.contains('Recent Movements').should('be.visible');
    
    // Check for charts
    cy.get('[data-testid="inventory-value-chart"]').should('be.visible');
    cy.get('[data-testid="stock-movement-chart"]').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should have working navigation', () => {
    cy.visit('/dashboard');
    cy.waitForFlutter();
    
    // Check navigation drawer
    cy.get('[data-testid="nav-drawer-button"]').click();
    
    // Check main navigation items
    cy.contains('Dashboard').should('be.visible');
    cy.contains('Products').should('be.visible');
    cy.contains('Categories').should('be.visible');
    cy.contains('Inventory').should('be.visible');
    cy.contains('Point of Sale').should('be.visible');
    cy.contains('Analytics').should('be.visible');
    cy.contains('Settings').should('be.visible');
    
    // Check advanced features
    cy.contains('Advanced Features').should('be.visible');
    cy.contains('Multi-Location').should('be.visible');
    cy.contains('Stock Transfers').should('be.visible');
    cy.contains('Serial/Batch Tracking').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should display user profile menu', () => {
    cy.visit('/dashboard');
    cy.waitForFlutter();
    
    // Click profile menu
    cy.get('[data-testid="profile-menu-button"]').click();
    
    // Check menu items
    cy.contains('Profile').should('be.visible');
    cy.contains('Organization').should('be.visible');
    cy.contains('Subscription').should('be.visible');
    cy.contains('Theme').should('be.visible');
    cy.contains('Language').should('be.visible');
    cy.contains('Logout').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should show quick actions', () => {
    cy.visit('/dashboard');
    cy.waitForFlutter();
    
    // Check quick action buttons
    cy.contains('Add Product').should('be.visible');
    cy.contains('New Sale').should('be.visible');
    cy.contains('Stock In').should('be.visible');
    cy.contains('View Reports').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should display recent activities', () => {
    cy.visit('/dashboard');
    cy.waitForFlutter();
    
    // Check recent activities section
    cy.contains('Recent Activities').should('be.visible');
    cy.get('[data-testid="activity-list"]').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });
});