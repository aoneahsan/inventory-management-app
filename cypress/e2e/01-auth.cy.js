describe('Authentication Tests', () => {
  it('should load the onboarding or login page', () => {
    cy.visit('/');
    cy.wait(5000); // Wait for Flutter to load
    
    // The app should show either onboarding or login
    cy.url().should('match', /(onboarding|login)/);
    
    // If on onboarding, navigate to login
    cy.get('body').then($body => {
      if ($body.text().includes('Get Started')) {
        cy.contains('Get Started').click();
        cy.wait(2000);
      }
    });
    
    // Check for login elements - using more flexible selectors
    cy.contains(/Sign In|Login|Welcome/i, { timeout: 30000 }).should('be.visible');
    
    // Check for no console errors
    cy.checkNoConsoleErrors();
  });

  it('should navigate to registration page', () => {
    cy.visit('/');
    cy.wait(5000);
    
    // Navigate to register from login
    cy.get('body').then($body => {
      // Skip onboarding if present
      if ($body.text().includes('Get Started')) {
        cy.contains('Get Started').click();
        cy.wait(2000);
      }
      
      // Look for sign up link
      const signUpSelectors = [
        'a:contains("Sign Up")',
        'a:contains("Create Account")',
        'a:contains("Register")',
        'button:contains("Sign Up")',
        'button:contains("Create Account")'
      ];
      
      cy.get('body').then($body => {
        for (const selector of signUpSelectors) {
          if ($body.find(selector).length > 0) {
            cy.get(selector).first().click();
            break;
          }
        }
      });
    });
    
    cy.wait(2000);
    
    // Check for registration page elements
    cy.contains(/Create Account|Sign Up|Register/i).should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should navigate to forgot password page', () => {
    cy.visit('/');
    cy.wait(5000);
    
    // Navigate to forgot password from login
    cy.get('body').then($body => {
      // Skip onboarding if present
      if ($body.text().includes('Get Started')) {
        cy.contains('Get Started').click();
        cy.wait(2000);
      }
      
      // Look for forgot password link
      const forgotPasswordSelectors = [
        'a:contains("Forgot Password")',
        'a:contains("Forgot password")',
        'a:contains("Reset Password")',
        'button:contains("Forgot Password")'
      ];
      
      cy.get('body').then($body => {
        for (const selector of forgotPasswordSelectors) {
          if ($body.find(selector).length > 0) {
            cy.get(selector).first().click();
            break;
          }
        }
      });
    });
    
    cy.wait(2000);
    
    // Check for forgot password page elements
    cy.contains(/Reset Password|Forgot Password/i).should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should display login form validation', () => {
    cy.visit('/');
    cy.wait(5000);
    
    // Navigate to login if needed
    cy.get('body').then($body => {
      if ($body.text().includes('Get Started')) {
        cy.contains('Get Started').click();
        cy.wait(2000);
      }
    });
    
    // Try to submit empty form
    cy.get('button').contains(/Sign In|Login/i).click();
    
    // Should show validation messages
    cy.wait(1000);
    cy.get('body').should('contain.text', /required|email|password/i);
    
    cy.checkNoConsoleErrors();
  });

  it('should handle login attempts', () => {
    cy.visit('/');
    cy.wait(5000);
    
    // Navigate to login if needed
    cy.get('body').then($body => {
      if ($body.text().includes('Get Started')) {
        cy.contains('Get Started').click();
        cy.wait(2000);
      }
    });
    
    // Find and fill email input
    cy.get('input').then($inputs => {
      // Find email input by type or placeholder
      const emailInput = Array.from($inputs).find(input => 
        input.type === 'email' || 
        input.placeholder?.toLowerCase().includes('email') ||
        input.name?.toLowerCase().includes('email')
      );
      if (emailInput) {
        cy.wrap(emailInput).type('test@example.com');
      }
    });
    
    // Find and fill password input
    cy.get('input[type="password"]').first().type('testpassword123');
    
    // Submit form
    cy.get('button').contains(/Sign In|Login/i).click();
    
    // Wait for response
    cy.wait(3000);
    
    // Check that we're still on login (since credentials are invalid)
    cy.url().should('match', /(login|onboarding)/);
    
    cy.checkNoConsoleErrors();
  });
});