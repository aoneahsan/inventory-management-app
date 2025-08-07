describe('Settings Tests', () => {
  beforeEach(() => {
    cy.visit('/settings');
    cy.waitForFlutter();
  });

  it('should load the settings page', () => {
    // Check page title
    cy.contains('Settings').should('be.visible');
    
    // Check tabs
    cy.contains('Organization').should('be.visible');
    cy.contains('Profile').should('be.visible');
    cy.contains('Subscription').should('be.visible');
    cy.contains('Roles & Permissions').should('be.visible');
    cy.contains('Theme').should('be.visible');
    cy.contains('System').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should show organization settings', () => {
    cy.contains('Organization').click();
    
    // Check organization fields
    cy.contains('Organization Name').should('be.visible');
    cy.contains('Organization Type').should('be.visible');
    cy.contains('Industry').should('be.visible');
    cy.contains('Members').should('be.visible');
    
    // Check invite member button
    cy.contains('button', 'Invite Member').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should show profile settings', () => {
    cy.contains('Profile').click();
    
    // Check profile fields
    cy.contains('Full Name').should('be.visible');
    cy.contains('Email').should('be.visible');
    cy.contains('Phone').should('be.visible');
    cy.contains('Language').should('be.visible');
    cy.contains('Time Zone').should('be.visible');
    
    // Check action buttons
    cy.contains('button', 'Update Profile').should('be.visible');
    cy.contains('button', 'Change Password').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should show subscription settings', () => {
    cy.contains('Subscription').click();
    
    // Check subscription info
    cy.contains('Current Plan').should('be.visible');
    cy.contains('Features').should('be.visible');
    cy.contains('Usage').should('be.visible');
    
    // Check plan options
    cy.contains('Free').should('be.visible');
    cy.contains('Starter').should('be.visible');
    cy.contains('Professional').should('be.visible');
    cy.contains('Enterprise').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should show roles and permissions', () => {
    cy.contains('Roles & Permissions').click();
    
    // Check roles list
    cy.contains('System Roles').should('be.visible');
    cy.contains('Owner').should('be.visible');
    cy.contains('Admin').should('be.visible');
    cy.contains('Manager').should('be.visible');
    cy.contains('Staff').should('be.visible');
    cy.contains('Viewer').should('be.visible');
    
    // Check custom roles section
    cy.contains('Custom Roles').should('be.visible');
    cy.contains('button', 'Create Role').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should show theme settings', () => {
    cy.contains('Theme').click();
    
    // Check theme options
    cy.contains('Theme Mode').should('be.visible');
    cy.contains('Light').should('be.visible');
    cy.contains('Dark').should('be.visible');
    cy.contains('System').should('be.visible');
    
    // Check color schemes
    cy.contains('Color Scheme').should('be.visible');
    cy.get('[data-testid="color-options"]').should('be.visible');
    
    // Check font options
    cy.contains('Font Family').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should show system settings', () => {
    cy.contains('System').click();
    
    // Check system info
    cy.contains('App Version').should('be.visible');
    cy.contains('Database').should('be.visible');
    cy.contains('Storage').should('be.visible');
    cy.contains('Sync Status').should('be.visible');
    
    // Check action buttons
    cy.contains('button', 'Clear Cache').should('be.visible');
    cy.contains('button', 'Export Data').should('be.visible');
    cy.contains('button', 'Force Sync').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should handle theme switching', () => {
    cy.contains('Theme').click();
    
    // Switch to dark mode
    cy.contains('Dark').click();
    cy.get('body').should('have.class', 'dark-theme');
    
    // Switch to light mode
    cy.contains('Light').click();
    cy.get('body').should('have.class', 'light-theme');
    
    cy.checkNoConsoleErrors();
  });
});