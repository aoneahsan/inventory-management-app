describe('Point of Sale Tests', () => {
  beforeEach(() => {
    cy.visit('/pos');
    cy.waitForFlutter();
  });

  it('should load the POS page', () => {
    // Check main POS elements
    cy.contains('Point of Sale').should('be.visible');
    
    // Check product grid
    cy.get('[data-testid="pos-product-grid"]').should('be.visible');
    
    // Check cart section
    cy.get('[data-testid="pos-cart"]').should('be.visible');
    cy.contains('Cart').should('be.visible');
    cy.contains('Total').should('be.visible');
    
    // Check action buttons
    cy.contains('button', 'Checkout').should('be.visible');
    cy.contains('button', 'Hold').should('be.visible');
    cy.contains('button', 'Clear').should('be.visible');
    
    // Check search bar
    cy.get('[data-testid="pos-search"]').should('be.visible');
    
    // Check barcode input
    cy.get('[data-testid="barcode-input"]').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should add products to cart', () => {
    // Click on a product
    cy.get('[data-testid="pos-product-item"]').first().click();
    
    // Check product is added to cart
    cy.get('[data-testid="cart-item"]').should('have.length.at.least', 1);
    
    // Check cart total updates
    cy.get('[data-testid="cart-total"]').should('not.contain', '0.00');
    
    cy.checkNoConsoleErrors();
  });

  it('should update quantity in cart', () => {
    // Add product to cart
    cy.get('[data-testid="pos-product-item"]').first().click();
    
    // Increase quantity
    cy.get('[data-testid="quantity-increase"]').first().click();
    cy.get('[data-testid="cart-item-quantity"]').first().should('contain', '2');
    
    // Decrease quantity
    cy.get('[data-testid="quantity-decrease"]').first().click();
    cy.get('[data-testid="cart-item-quantity"]').first().should('contain', '1');
    
    cy.checkNoConsoleErrors();
  });

  it('should remove items from cart', () => {
    // Add product to cart
    cy.get('[data-testid="pos-product-item"]').first().click();
    
    // Remove item
    cy.get('[data-testid="remove-cart-item"]').first().click();
    
    // Check cart is empty
    cy.contains('Cart is empty').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should clear entire cart', () => {
    // Add multiple products
    cy.get('[data-testid="pos-product-item"]').eq(0).click();
    cy.get('[data-testid="pos-product-item"]').eq(1).click();
    
    // Clear cart
    cy.contains('button', 'Clear').click();
    cy.contains('Clear cart?').should('be.visible');
    cy.contains('button', 'Confirm').click();
    
    // Check cart is empty
    cy.contains('Cart is empty').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should search for products', () => {
    // Type in search
    cy.get('[data-testid="pos-search"]').type('test');
    cy.wait(500); // Debounce
    
    // Check filtered results
    cy.get('[data-testid="pos-product-grid"]').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should open checkout dialog', () => {
    // Add product to cart
    cy.get('[data-testid="pos-product-item"]').first().click();
    
    // Click checkout
    cy.contains('button', 'Checkout').click();
    
    // Check checkout dialog
    cy.contains('Checkout').should('be.visible');
    cy.contains('Payment Method').should('be.visible');
    cy.contains('Cash').should('be.visible');
    cy.contains('Card').should('be.visible');
    cy.contains('Other').should('be.visible');
    
    // Check totals
    cy.contains('Subtotal').should('be.visible');
    cy.contains('Tax').should('be.visible');
    cy.contains('Total').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should handle barcode scanning', () => {
    // Type barcode
    cy.get('[data-testid="barcode-input"]').type('1234567890{enter}');
    
    // Check if product is added (if exists)
    // Note: This would depend on test data
    
    cy.checkNoConsoleErrors();
  });

  it('should show register status', () => {
    // Check register info
    cy.get('[data-testid="register-status"]').should('be.visible');
    cy.contains('Register').should('be.visible');
    
    // Click to open register management
    cy.get('[data-testid="register-status"]').click();
    cy.contains('Register Management').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });
});