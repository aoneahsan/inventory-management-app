describe('Authentication Tests', () => {
  it('should load the login page', () => {
    cy.visit('/login');
    cy.waitForFlutter();
    
    // Check page elements
    cy.contains('Sign In').should('be.visible');
    cy.get('input[type="email"]').should('be.visible');
    cy.get('input[type="password"]').should('be.visible');
    cy.contains('button', 'Sign In').should('be.visible');
    cy.contains('Forgot Password?').should('be.visible');
    cy.contains('Create Account').should('be.visible');
    
    // Check for no console errors
    cy.checkNoConsoleErrors();
  });

  it('should load the registration page', () => {
    cy.visit('/register');
    cy.waitForFlutter();
    
    // Check page elements
    cy.contains('Create Account').should('be.visible');
    cy.get('input[placeholder*="Full Name"]').should('be.visible');
    cy.get('input[type="email"]').should('be.visible');
    cy.get('input[type="password"]').should('be.visible');
    cy.contains('button', 'Create Account').should('be.visible');
    cy.contains('Already have an account?').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should load the forgot password page', () => {
    cy.visit('/forgot-password');
    cy.waitForFlutter();
    
    // Check page elements
    cy.contains('Reset Password').should('be.visible');
    cy.get('input[type="email"]').should('be.visible');
    cy.contains('button', 'Send Reset Link').should('be.visible');
    cy.contains('Back to Sign In').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should handle login errors gracefully', () => {
    cy.visit('/login');
    cy.waitForFlutter();
    
    // Try to login with invalid credentials
    cy.get('input[type="email"]').type('invalid@example.com');
    cy.get('input[type="password"]').type('wrongpassword');
    cy.contains('button', 'Sign In').click();
    
    // Should show error message
    cy.contains('Invalid email or password').should('be.visible');
    cy.url().should('include', '/login');
    
    cy.checkNoConsoleErrors();
  });

  it('should validate form fields', () => {
    cy.visit('/register');
    cy.waitForFlutter();
    
    // Try to submit empty form
    cy.contains('button', 'Create Account').click();
    
    // Should show validation errors
    cy.contains('Name is required').should('be.visible');
    cy.contains('Email is required').should('be.visible');
    cy.contains('Password is required').should('be.visible');
    
    // Test email validation
    cy.get('input[type="email"]').type('invalid-email');
    cy.contains('Please enter a valid email').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });
});