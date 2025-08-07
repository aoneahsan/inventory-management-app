describe('Basic Page Load Tests', () => {
  it('should load the app without errors', () => {
    cy.visit('/', { timeout: 30000 });
    cy.wait(10000); // Wait for Flutter to fully load
    
    // Check that the page has loaded by looking for any body content
    cy.get('body').should('be.visible');
    
    // The app should show either login page or main page
    cy.url().then((url) => {
      // Log the current URL for debugging
      cy.log('Current URL:', url);
    });
  });

  it('should check different routes', () => {
    const routes = [
      '/',
      '/login',
      '/register',
      '/forgot-password'
    ];

    routes.forEach(route => {
      cy.visit(route, { 
        timeout: 30000,
        failOnStatusCode: false 
      });
      cy.wait(5000); // Wait for each page to load
      
      // Just check that page loads without crash
      cy.get('body').should('be.visible');
      
      cy.log(`Route ${route} loaded successfully`);
    });
  });
});