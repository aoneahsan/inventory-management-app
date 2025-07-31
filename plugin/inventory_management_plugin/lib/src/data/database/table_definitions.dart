import 'database_schema.dart';

/// SQL table definitions for the inventory management database
class TableDefinitions {
  // Organizations table
  static const String createOrganizationsTable = '''
    CREATE TABLE ${DatabaseSchema.organizationsTable} (
      ${DatabaseSchema.id} TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      code TEXT UNIQUE NOT NULL,
      address TEXT,
      phone TEXT,
      email TEXT,
      website TEXT,
      tax_number TEXT,
      logo_url TEXT,
      subscription_plan TEXT DEFAULT 'basic',
      subscription_status TEXT DEFAULT 'active',
      subscription_end_date INTEGER,
      ${DatabaseSchema.isActive} INTEGER DEFAULT 1,
      ${DatabaseSchema.metadata} TEXT,
      ${DatabaseSchema.createdAt} INTEGER NOT NULL,
      ${DatabaseSchema.updatedAt} INTEGER NOT NULL,
      ${DatabaseSchema.syncedAt} INTEGER
    )
  ''';
  
  // Users table
  static const String createUsersTable = '''
    CREATE TABLE ${DatabaseSchema.usersTable} (
      ${DatabaseSchema.id} TEXT PRIMARY KEY,
      ${DatabaseSchema.organizationId} TEXT NOT NULL,
      name TEXT NOT NULL,
      email TEXT UNIQUE NOT NULL,
      phone TEXT,
      role_id TEXT,
      branch_id TEXT,
      ${DatabaseSchema.isActive} INTEGER DEFAULT 1,
      last_login_at INTEGER,
      ${DatabaseSchema.metadata} TEXT,
      ${DatabaseSchema.createdAt} INTEGER NOT NULL,
      ${DatabaseSchema.updatedAt} INTEGER NOT NULL,
      ${DatabaseSchema.syncedAt} INTEGER,
      FOREIGN KEY (${DatabaseSchema.organizationId}) REFERENCES ${DatabaseSchema.organizationsTable}(${DatabaseSchema.id})
    )
  ''';
  
  // Products table
  static const String createProductsTable = '''
    CREATE TABLE ${DatabaseSchema.productsTable} (
      ${DatabaseSchema.id} TEXT PRIMARY KEY,
      ${DatabaseSchema.organizationId} TEXT NOT NULL,
      name TEXT NOT NULL,
      sku TEXT NOT NULL,
      barcode TEXT,
      category_id TEXT,
      description TEXT,
      unit TEXT NOT NULL,
      purchase_price REAL NOT NULL DEFAULT 0,
      selling_price REAL NOT NULL DEFAULT 0,
      tax_rate REAL DEFAULT 0,
      hsn_code TEXT,
      brand TEXT,
      model TEXT,
      ${DatabaseSchema.isActive} INTEGER DEFAULT 1,
      track_inventory INTEGER DEFAULT 1,
      track_batches INTEGER DEFAULT 0,
      track_serial_numbers INTEGER DEFAULT 0,
      low_stock_alert INTEGER DEFAULT 0,
      reorder_point REAL DEFAULT 0,
      reorder_quantity REAL DEFAULT 0,
      image_url TEXT,
      ${DatabaseSchema.metadata} TEXT,
      ${DatabaseSchema.createdAt} INTEGER NOT NULL,
      ${DatabaseSchema.updatedAt} INTEGER NOT NULL,
      ${DatabaseSchema.syncedAt} INTEGER,
      FOREIGN KEY (${DatabaseSchema.organizationId}) REFERENCES ${DatabaseSchema.organizationsTable}(${DatabaseSchema.id}),
      UNIQUE(${DatabaseSchema.organizationId}, sku)
    )
  ''';
  
  // Categories table
  static const String createCategoriesTable = '''
    CREATE TABLE ${DatabaseSchema.categoriesTable} (
      ${DatabaseSchema.id} TEXT PRIMARY KEY,
      ${DatabaseSchema.organizationId} TEXT NOT NULL,
      name TEXT NOT NULL,
      description TEXT,
      parent_id TEXT,
      color TEXT,
      icon TEXT,
      sort_order INTEGER DEFAULT 0,
      ${DatabaseSchema.isActive} INTEGER DEFAULT 1,
      ${DatabaseSchema.metadata} TEXT,
      ${DatabaseSchema.createdAt} INTEGER NOT NULL,
      ${DatabaseSchema.updatedAt} INTEGER NOT NULL,
      ${DatabaseSchema.syncedAt} INTEGER,
      FOREIGN KEY (${DatabaseSchema.organizationId}) REFERENCES ${DatabaseSchema.organizationsTable}(${DatabaseSchema.id}),
      FOREIGN KEY (parent_id) REFERENCES ${DatabaseSchema.categoriesTable}(${DatabaseSchema.id}),
      UNIQUE(${DatabaseSchema.organizationId}, name, parent_id)
    )
  ''';
  
  // Customers table
  static const String createCustomersTable = '''
    CREATE TABLE ${DatabaseSchema.customersTable} (
      ${DatabaseSchema.id} TEXT PRIMARY KEY,
      ${DatabaseSchema.organizationId} TEXT NOT NULL,
      name TEXT NOT NULL,
      code TEXT,
      email TEXT,
      phone TEXT NOT NULL,
      address TEXT,
      city TEXT,
      state TEXT,
      country TEXT,
      postal_code TEXT,
      tax_number TEXT,
      customer_type TEXT DEFAULT 'retail',
      credit_limit REAL DEFAULT 0,
      current_balance REAL DEFAULT 0,
      loyalty_points INTEGER DEFAULT 0,
      discount_percentage REAL DEFAULT 0,
      payment_terms TEXT,
      ${DatabaseSchema.isActive} INTEGER DEFAULT 1,
      ${DatabaseSchema.metadata} TEXT,
      ${DatabaseSchema.createdAt} INTEGER NOT NULL,
      ${DatabaseSchema.updatedAt} INTEGER NOT NULL,
      ${DatabaseSchema.syncedAt} INTEGER,
      FOREIGN KEY (${DatabaseSchema.organizationId}) REFERENCES ${DatabaseSchema.organizationsTable}(${DatabaseSchema.id}),
      UNIQUE(${DatabaseSchema.organizationId}, phone)
    )
  ''';
  
  // Suppliers table
  static const String createSuppliersTable = '''
    CREATE TABLE ${DatabaseSchema.suppliersTable} (
      ${DatabaseSchema.id} TEXT PRIMARY KEY,
      ${DatabaseSchema.organizationId} TEXT NOT NULL,
      name TEXT NOT NULL,
      code TEXT,
      contact_person TEXT,
      email TEXT,
      phone TEXT NOT NULL,
      address TEXT,
      city TEXT,
      state TEXT,
      country TEXT,
      postal_code TEXT,
      tax_number TEXT,
      payment_terms TEXT,
      credit_limit REAL DEFAULT 0,
      current_balance REAL DEFAULT 0,
      bank_name TEXT,
      bank_account TEXT,
      bank_routing TEXT,
      ${DatabaseSchema.isActive} INTEGER DEFAULT 1,
      ${DatabaseSchema.metadata} TEXT,
      ${DatabaseSchema.createdAt} INTEGER NOT NULL,
      ${DatabaseSchema.updatedAt} INTEGER NOT NULL,
      ${DatabaseSchema.syncedAt} INTEGER,
      FOREIGN KEY (${DatabaseSchema.organizationId}) REFERENCES ${DatabaseSchema.organizationsTable}(${DatabaseSchema.id}),
      UNIQUE(${DatabaseSchema.organizationId}, code)
    )
  ''';
  
  // Branches table
  static const String createBranchesTable = '''
    CREATE TABLE ${DatabaseSchema.branchesTable} (
      ${DatabaseSchema.id} TEXT PRIMARY KEY,
      ${DatabaseSchema.organizationId} TEXT NOT NULL,
      name TEXT NOT NULL,
      code TEXT NOT NULL,
      type TEXT DEFAULT 'store',
      address TEXT,
      city TEXT,
      state TEXT,
      country TEXT,
      postal_code TEXT,
      phone TEXT,
      email TEXT,
      manager_id TEXT,
      ${DatabaseSchema.isActive} INTEGER DEFAULT 1,
      is_warehouse INTEGER DEFAULT 0,
      can_sell INTEGER DEFAULT 1,
      ${DatabaseSchema.metadata} TEXT,
      ${DatabaseSchema.createdAt} INTEGER NOT NULL,
      ${DatabaseSchema.updatedAt} INTEGER NOT NULL,
      ${DatabaseSchema.syncedAt} INTEGER,
      FOREIGN KEY (${DatabaseSchema.organizationId}) REFERENCES ${DatabaseSchema.organizationsTable}(${DatabaseSchema.id}),
      UNIQUE(${DatabaseSchema.organizationId}, code)
    )
  ''';
  
  // Sales table
  static const String createSalesTable = '''
    CREATE TABLE ${DatabaseSchema.salesTable} (
      ${DatabaseSchema.id} TEXT PRIMARY KEY,
      ${DatabaseSchema.organizationId} TEXT NOT NULL,
      branch_id TEXT NOT NULL,
      sale_number TEXT NOT NULL,
      customer_id TEXT,
      sale_date INTEGER NOT NULL,
      subtotal REAL NOT NULL DEFAULT 0,
      tax_amount REAL NOT NULL DEFAULT 0,
      discount_amount REAL NOT NULL DEFAULT 0,
      total_amount REAL NOT NULL DEFAULT 0,
      paid_amount REAL NOT NULL DEFAULT 0,
      change_amount REAL NOT NULL DEFAULT 0,
      payment_method TEXT,
      payment_reference TEXT,
      status TEXT NOT NULL DEFAULT 'completed',
      cashier_id TEXT,
      register_id TEXT,
      notes TEXT,
      ${DatabaseSchema.metadata} TEXT,
      ${DatabaseSchema.createdAt} INTEGER NOT NULL,
      ${DatabaseSchema.updatedAt} INTEGER NOT NULL,
      ${DatabaseSchema.syncedAt} INTEGER,
      FOREIGN KEY (${DatabaseSchema.organizationId}) REFERENCES ${DatabaseSchema.organizationsTable}(${DatabaseSchema.id}),
      FOREIGN KEY (branch_id) REFERENCES ${DatabaseSchema.branchesTable}(${DatabaseSchema.id}),
      UNIQUE(${DatabaseSchema.organizationId}, sale_number)
    )
  ''';
  
  // Sale Items table
  static const String createSaleItemsTable = '''
    CREATE TABLE ${DatabaseSchema.saleItemsTable} (
      ${DatabaseSchema.id} TEXT PRIMARY KEY,
      sale_id TEXT NOT NULL,
      product_id TEXT NOT NULL,
      quantity REAL NOT NULL,
      unit_price REAL NOT NULL,
      subtotal REAL NOT NULL,
      discount_amount REAL DEFAULT 0,
      tax_amount REAL DEFAULT 0,
      total_amount REAL NOT NULL,
      cost_price REAL,
      batch_id TEXT,
      serial_number TEXT,
      notes TEXT,
      ${DatabaseSchema.createdAt} INTEGER NOT NULL,
      FOREIGN KEY (sale_id) REFERENCES ${DatabaseSchema.salesTable}(${DatabaseSchema.id}) ON DELETE CASCADE,
      FOREIGN KEY (product_id) REFERENCES ${DatabaseSchema.productsTable}(${DatabaseSchema.id})
    )
  ''';
  
  // Inventory Movements table
  static const String createInventoryMovementsTable = '''
    CREATE TABLE ${DatabaseSchema.inventoryMovementsTable} (
      ${DatabaseSchema.id} TEXT PRIMARY KEY,
      ${DatabaseSchema.organizationId} TEXT NOT NULL,
      branch_id TEXT NOT NULL,
      product_id TEXT NOT NULL,
      movement_type TEXT NOT NULL,
      quantity REAL NOT NULL,
      unit_cost REAL,
      reference_type TEXT,
      reference_id TEXT,
      batch_id TEXT,
      serial_number TEXT,
      from_location TEXT,
      to_location TEXT,
      notes TEXT,
      performed_by TEXT,
      ${DatabaseSchema.metadata} TEXT,
      ${DatabaseSchema.createdAt} INTEGER NOT NULL,
      ${DatabaseSchema.syncedAt} INTEGER,
      FOREIGN KEY (${DatabaseSchema.organizationId}) REFERENCES ${DatabaseSchema.organizationsTable}(${DatabaseSchema.id}),
      FOREIGN KEY (branch_id) REFERENCES ${DatabaseSchema.branchesTable}(${DatabaseSchema.id}),
      FOREIGN KEY (product_id) REFERENCES ${DatabaseSchema.productsTable}(${DatabaseSchema.id})
    )
  ''';
  
  // Purchase Orders table
  static const String createPurchaseOrdersTable = '''
    CREATE TABLE ${DatabaseSchema.purchaseOrdersTable} (
      ${DatabaseSchema.id} TEXT PRIMARY KEY,
      ${DatabaseSchema.organizationId} TEXT NOT NULL,
      supplier_id TEXT NOT NULL,
      po_number TEXT NOT NULL,
      order_date INTEGER NOT NULL,
      expected_delivery_date INTEGER,
      branch_id TEXT NOT NULL,
      status TEXT NOT NULL DEFAULT 'draft',
      subtotal REAL NOT NULL DEFAULT 0,
      tax_amount REAL NOT NULL DEFAULT 0,
      shipping_amount REAL DEFAULT 0,
      discount_amount REAL DEFAULT 0,
      total_amount REAL NOT NULL DEFAULT 0,
      notes TEXT,
      payment_terms TEXT,
      shipping_address TEXT,
      billing_address TEXT,
      approved_by TEXT,
      approved_at INTEGER,
      received_by TEXT,
      received_at INTEGER,
      ${DatabaseSchema.metadata} TEXT,
      ${DatabaseSchema.createdAt} INTEGER NOT NULL,
      ${DatabaseSchema.updatedAt} INTEGER NOT NULL,
      ${DatabaseSchema.syncedAt} INTEGER,
      FOREIGN KEY (${DatabaseSchema.organizationId}) REFERENCES ${DatabaseSchema.organizationsTable}(${DatabaseSchema.id}),
      FOREIGN KEY (supplier_id) REFERENCES ${DatabaseSchema.suppliersTable}(${DatabaseSchema.id}),
      FOREIGN KEY (branch_id) REFERENCES ${DatabaseSchema.branchesTable}(${DatabaseSchema.id}),
      UNIQUE(${DatabaseSchema.organizationId}, po_number)
    )
  ''';
  
  // All table creation statements
  static List<String> getAllTableCreationStatements() {
    return [
      createOrganizationsTable,
      createUsersTable,
      createProductsTable,
      createCategoriesTable,
      createCustomersTable,
      createSuppliersTable,
      createBranchesTable,
      createSalesTable,
      createSaleItemsTable,
      createInventoryMovementsTable,
      createPurchaseOrdersTable,
      // Add more tables as needed
    ];
  }
  
  // Index creation statements
  static List<String> getAllIndexCreationStatements() {
    return [
      'CREATE INDEX idx_users_organization ON ${DatabaseSchema.usersTable}(${DatabaseSchema.organizationId})',
      'CREATE INDEX idx_products_organization ON ${DatabaseSchema.productsTable}(${DatabaseSchema.organizationId})',
      'CREATE INDEX idx_products_barcode ON ${DatabaseSchema.productsTable}(barcode)',
      'CREATE INDEX idx_products_category ON ${DatabaseSchema.productsTable}(category_id)',
      'CREATE INDEX idx_categories_organization ON ${DatabaseSchema.categoriesTable}(${DatabaseSchema.organizationId})',
      'CREATE INDEX idx_customers_organization ON ${DatabaseSchema.customersTable}(${DatabaseSchema.organizationId})',
      'CREATE INDEX idx_suppliers_organization ON ${DatabaseSchema.suppliersTable}(${DatabaseSchema.organizationId})',
      'CREATE INDEX idx_branches_organization ON ${DatabaseSchema.branchesTable}(${DatabaseSchema.organizationId})',
      'CREATE INDEX idx_sales_organization ON ${DatabaseSchema.salesTable}(${DatabaseSchema.organizationId})',
      'CREATE INDEX idx_sales_branch ON ${DatabaseSchema.salesTable}(branch_id)',
      'CREATE INDEX idx_sales_customer ON ${DatabaseSchema.salesTable}(customer_id)',
      'CREATE INDEX idx_sale_items_sale ON ${DatabaseSchema.saleItemsTable}(sale_id)',
      'CREATE INDEX idx_inventory_movements_organization ON ${DatabaseSchema.inventoryMovementsTable}(${DatabaseSchema.organizationId})',
      'CREATE INDEX idx_inventory_movements_product ON ${DatabaseSchema.inventoryMovementsTable}(product_id)',
      'CREATE INDEX idx_purchase_orders_organization ON ${DatabaseSchema.purchaseOrdersTable}(${DatabaseSchema.organizationId})',
      'CREATE INDEX idx_purchase_orders_supplier ON ${DatabaseSchema.purchaseOrdersTable}(supplier_id)',
    ];
  }
}