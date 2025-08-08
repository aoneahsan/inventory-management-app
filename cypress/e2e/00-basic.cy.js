describe('Basic App Tests', () => {
  it('should load the application', () => {
    cy.visit('/', { timeout: 30000 });
    
    // Wait for any content to appear
    cy.get('body', { timeout: 30000 }).should('be.visible');
    
    // Log what we see
    cy.get('body').then($body => {
      cy.log('Page content:', $body.text().substring(0, 200));
    });
    
    // Check if Flutter loaded
    cy.window().then(win => {
      cy.log('Window loaded');
      cy.log('URL:', win.location.href);
    });
    
    // Take a screenshot for debugging
    cy.screenshot('basic-app-load');
  });
  
  it('should have Flutter app content', () => {
    cy.visit('/', { timeout: 30000 });
    cy.wait(10000); // Give Flutter plenty of time
    
    // Check for any visible text
    cy.get('body').invoke('text').then(text => {
      expect(text.trim()).to.not.be.empty;
      cy.log('Body text length:', text.length);
    });
    
    // Check that we're on a valid route
    cy.url().then(url => {
      cy.log('Current URL:', url);
      expect(url).to.include('localhost:8080');
    });
  });
  
  it('should display onboarding or login screen', () => {
    cy.visit('/', { timeout: 30000 });
    cy.wait(10000); // Wait for Flutter to fully load
    
    // Check for common auth-related text
    cy.get('body').then($body => {
      const bodyText = $body.text();
      const hasAuthContent = 
        bodyText.includes('Sign In') ||
        bodyText.includes('Login') ||
        bodyText.includes('Get Started') ||
        bodyText.includes('Welcome') ||
        bodyText.includes('Email') ||
        bodyText.includes('Password');
      
      expect(hasAuthContent).to.be.true;
    });
  });
});