describe('Products Management Tests', () => {
  beforeEach(() => {
    cy.visit('/products');
    cy.waitForFlutter();
  });

  it('should load the products page', () => {
    // Check page elements
    cy.contains('Products').should('be.visible');
    cy.contains('button', 'Add Product').should('be.visible');
    cy.contains('button', 'Import').should('be.visible');
    cy.contains('button', 'Export').should('be.visible');
    
    // Check search and filters
    cy.get('[data-testid="product-search"]').should('be.visible');
    cy.get('[data-testid="category-filter"]').should('be.visible');
    cy.get('[data-testid="stock-filter"]').should('be.visible');
    
    // Check product list/grid
    cy.get('[data-testid="product-list"]').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should open add product form', () => {
    cy.contains('button', 'Add Product').click();
    cy.waitForPageLoad();
    
    // Check form fields
    cy.contains('Add New Product').should('be.visible');
    cy.get('[data-testid="product-name"]').should('be.visible');
    cy.get('[data-testid="product-sku"]').should('be.visible');
    cy.get('[data-testid="product-barcode"]').should('be.visible');
    cy.get('[data-testid="product-category"]').should('be.visible');
    cy.get('[data-testid="product-price"]').should('be.visible');
    cy.get('[data-testid="product-cost"]').should('be.visible');
    cy.get('[data-testid="product-stock"]').should('be.visible');
    cy.get('[data-testid="product-unit"]').should('be.visible');
    cy.get('[data-testid="product-description"]').should('be.visible');
    
    // Check action buttons
    cy.contains('button', 'Save').should('be.visible');
    cy.contains('button', 'Cancel').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should validate product form', () => {
    cy.contains('button', 'Add Product').click();
    cy.waitForPageLoad();
    
    // Try to save empty form
    cy.contains('button', 'Save').click();
    
    // Check validation messages
    cy.contains('Product name is required').should('be.visible');
    cy.contains('SKU is required').should('be.visible');
    cy.contains('Price is required').should('be.visible');
    
    // Test numeric validation
    cy.get('[data-testid="product-price"]').type('abc');
    cy.contains('Price must be a valid number').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should handle search functionality', () => {
    // Type in search box
    cy.get('[data-testid="product-search"]').type('test product');
    cy.wait(500); // Debounce wait
    
    // Check that search is working (results should update)
    cy.get('[data-testid="product-list"]').should('be.visible');
    
    // Clear search
    cy.get('[data-testid="product-search"]').clear();
    
    cy.checkNoConsoleErrors();
  });

  it('should handle category filter', () => {
    // Open category filter
    cy.get('[data-testid="category-filter"]').click();
    
    // Check that categories are listed
    cy.get('[data-testid="category-options"]').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should handle bulk operations', () => {
    // Select multiple products
    cy.get('[data-testid="select-all-checkbox"]').click();
    
    // Check bulk actions appear
    cy.contains('Bulk Actions').should('be.visible');
    cy.contains('Delete Selected').should('be.visible');
    cy.contains('Export Selected').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });

  it('should show product details', () => {
    // Click on first product in list
    cy.get('[data-testid="product-item"]').first().click();
    
    // Check product details page
    cy.contains('Product Details').should('be.visible');
    cy.contains('Edit').should('be.visible');
    cy.contains('Delete').should('be.visible');
    
    // Check tabs
    cy.contains('Overview').should('be.visible');
    cy.contains('Stock History').should('be.visible');
    cy.contains('Price History').should('be.visible');
    
    cy.checkNoConsoleErrors();
  });
});