describe('Diagnostic Tests', () => {
  it('should show what content is on the page', () => {
    cy.visit('/', { timeout: 30000 });
    cy.wait(15000); // Give Flutter extra time to load
    
    // Get all text content
    cy.get('body').invoke('text').then(text => {
      cy.log('=== FULL PAGE TEXT ===');
      cy.log(text.trim() || 'NO TEXT CONTENT FOUND');
      
      // Also log to console for easier viewing
      console.log('Page text:', text);
    });
    
    // Check for any buttons
    cy.get('button').then($buttons => {
      cy.log(`Found ${$buttons.length} buttons`);
      $buttons.each((index, button) => {
        cy.log(`Button ${index}: ${button.textContent}`);
      });
    });
    
    // Check for any links
    cy.get('a').then($links => {
      cy.log(`Found ${$links.length} links`);
      $links.each((index, link) => {
        cy.log(`Link ${index}: ${link.textContent}`);
      });
    });
    
    // Check for any inputs
    cy.get('input').then($inputs => {
      cy.log(`Found ${$inputs.length} inputs`);
      $inputs.each((index, input) => {
        cy.log(`Input ${index}: type=${input.type}, placeholder=${input.placeholder}`);
      });
    });
    
    // Check URL
    cy.url().then(url => {
      cy.log('Current URL:', url);
    });
    
    // Take screenshot
    cy.screenshot('diagnostic-page-content');
  });
});