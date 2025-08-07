describe('Analytics & Reports Tests', () => {
  beforeEach(() => {
    cy.visit('/analytics');
    cy.waitForFlutter();
  });

  it('should load the analytics page', () => {
    // Check page title
    cy.contains('Analytics').should('be.visible');
    
    // Check tabs
    cy.contains('Overview').should('be.visible');
    cy.contains('Sales').should('be.visible');
    cy.contains('Inventory').should('be.visible');
    cy.contains('Reports').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should show overview analytics', () => {
    cy.contains('Overview').click();
    
    // Check metric cards
    cy.contains('Total Revenue').should('be.visible');
    cy.contains('Total Products').should('be.visible');
    cy.contains('Low Stock Items').should('be.visible');
    cy.contains('Active Customers').should('be.visible');
    
    // Check charts
    cy.get('[data-testid="revenue-chart"]').should('be.visible');
    cy.get('[data-testid="sales-trend-chart"]').should('be.visible');
    cy.get('[data-testid="top-products-chart"]').should('be.visible');
    
    // Check date range selector
    cy.get('[data-testid="date-range-selector"]').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should show sales analytics', () => {
    cy.contains('Sales').click();
    
    // Check sales metrics
    cy.contains('Daily Sales').should('be.visible');
    cy.contains('Average Transaction').should('be.visible');
    cy.contains('Payment Methods').should('be.visible');
    cy.contains('Top Selling Products').should('be.visible');
    
    // Check sales charts
    cy.get('[data-testid="hourly-sales-chart"]').should('be.visible');
    cy.get('[data-testid="payment-method-chart"]').should('be.visible');
    cy.get('[data-testid="cashier-performance-chart"]').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should show inventory analytics', () => {
    cy.contains('Inventory').click();
    
    // Check inventory metrics
    cy.contains('Stock Value').should('be.visible');
    cy.contains('Stock Turnover').should('be.visible');
    cy.contains('Dead Stock').should('be.visible');
    cy.contains('Stock by Category').should('be.visible');
    
    // Check inventory charts
    cy.get('[data-testid="stock-value-chart"]').should('be.visible');
    cy.get('[data-testid="category-distribution-chart"]').should('be.visible');
    cy.get('[data-testid="stock-movement-trend"]').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should show reports section', () => {
    cy.contains('Reports').click();
    
    // Check report types
    cy.contains('Inventory Report').should('be.visible');
    cy.contains('Sales Report').should('be.visible');
    cy.contains('Stock Movement Report').should('be.visible');
    cy.contains('Low Stock Report').should('be.visible');
    cy.contains('Tax Report').should('be.visible');
    
    // Check export options
    cy.contains('button', 'Generate Report').should('be.visible');
    cy.contains('PDF').should('be.visible');
    cy.contains('Excel').should('be.visible');
    cy.contains('CSV').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should handle date range selection', () => {
    // Click date range selector
    cy.get('[data-testid="date-range-selector"]').click();
    
    // Check preset options
    cy.contains('Today').should('be.visible');
    cy.contains('Yesterday').should('be.visible');
    cy.contains('Last 7 Days').should('be.visible');
    cy.contains('Last 30 Days').should('be.visible');
    cy.contains('This Month').should('be.visible');
    cy.contains('Last Month').should('be.visible');
    cy.contains('Custom Range').should('be.visible');
    
    // Select a preset
    cy.contains('Last 7 Days').click();
    
    // Check that charts update
    cy.get('[data-testid="loading-indicator"]').should('not.exist');
    
    cy.checkNoConsoleErrors();
  });

  it('should generate a report', () => {
    cy.contains('Reports').click();
    
    // Select report type
    cy.get('[data-testid="report-type-select"]').click();
    cy.contains('Inventory Report').click();
    
    // Select date range
    cy.get('[data-testid="report-date-range"]').click();
    cy.contains('This Month').click();
    
    // Select format
    cy.contains('PDF').click();
    
    // Generate report
    cy.contains('button', 'Generate Report').click();
    
    // Check loading state
    cy.contains('Generating report...').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should export analytics data', () => {
    // Find export button
    cy.contains('button', 'Export').click();
    
    // Check export options
    cy.contains('Export as PDF').should('be.visible');
    cy.contains('Export as Excel').should('be.visible');
    cy.contains('Export as CSV').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });
});