describe('Simple Diagnostic', () => {
  it('should capture page state', () => {
    cy.visit('/', { timeout: 30000 });
    cy.wait(15000); // Give Flutter time to load
    
    // Log page text without requiring any elements
    cy.document().then(doc => {
      const bodyText = doc.body.innerText || doc.body.textContent || '';
      cy.log('Page has text:', bodyText.length > 0 ? 'YES' : 'NO');
      cy.log('Text length:', bodyText.length);
      if (bodyText.length > 0) {
        cy.log('First 500 chars:', bodyText.substring(0, 500));
      }
    });
    
    // Check HTML structure
    cy.document().then(doc => {
      cy.log('Body children:', doc.body.children.length);
      cy.log('HTML:', doc.body.innerHTML.substring(0, 500));
    });
    
    // Take screenshot
    cy.screenshot('simple-diagnostic');
    
    // Force pass to see logs
    expect(true).to.be.true;
  });
});