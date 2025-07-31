class DatabaseSchema {
  static const int currentVersion = 1;
  
  static List<TableDefinition> get tables => [
    // Core tables
    TableDefinition(
      name: 'users',
      schema: '''
        id TEXT PRIMARY KEY,
        email TEXT NOT NULL,
        name TEXT NOT NULL,
        photo_url TEXT,
        role TEXT NOT NULL,
        organization_id TEXT,
        is_active INTEGER DEFAULT 1,
        last_login_at INTEGER,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        synced_at INTEGER
      ''',
    ),
    TableDefinition(
      name: 'organizations',
      schema: '''
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        code TEXT UNIQUE,
        subscription_tier TEXT DEFAULT 'free',
        subscription_status TEXT DEFAULT 'active',
        max_users INTEGER DEFAULT 1,
        max_products INTEGER DEFAULT 100,
        max_locations INTEGER DEFAULT 1,
        settings TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        synced_at INTEGER
      ''',
    ),
    
    // Product tables
    TableDefinition(
      name: 'products',
      schema: '''
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        sku TEXT NOT NULL,
        barcode TEXT,
        name TEXT NOT NULL,
        description TEXT,
        category_id TEXT,
        unit TEXT DEFAULT 'pcs',
        cost_price REAL DEFAULT 0,
        selling_price REAL DEFAULT 0,
        tax_rate REAL DEFAULT 0,
        stock_quantity REAL DEFAULT 0,
        reorder_point REAL DEFAULT 0,
        reorder_quantity REAL DEFAULT 0,
        image_url TEXT,
        is_active INTEGER DEFAULT 1,
        is_composite INTEGER DEFAULT 0,
        track_inventory INTEGER DEFAULT 1,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        synced_at INTEGER
      ''',
    ),
    TableDefinition(
      name: 'categories',
      schema: '''
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        name TEXT NOT NULL,
        description TEXT,
        parent_id TEXT,
        color TEXT,
        icon TEXT,
        sort_order INTEGER DEFAULT 0,
        is_active INTEGER DEFAULT 1,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        synced_at INTEGER
      ''',
    ),
    
    // Inventory tables
    TableDefinition(
      name: 'inventory_movements',
      schema: '''
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        product_id TEXT NOT NULL,
        branch_id TEXT,
        movement_type TEXT NOT NULL,
        quantity REAL NOT NULL,
        unit_cost REAL,
        total_cost REAL,
        reference_type TEXT,
        reference_id TEXT,
        reason TEXT,
        notes TEXT,
        performed_by TEXT NOT NULL,
        performed_at INTEGER NOT NULL,
        created_at INTEGER NOT NULL,
        synced_at INTEGER
      ''',
    ),
    TableDefinition(
      name: 'branches',
      schema: '''
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        name TEXT NOT NULL,
        code TEXT,
        branch_type TEXT DEFAULT 'store',
        address TEXT,
        city TEXT,
        state TEXT,
        country TEXT,
        postal_code TEXT,
        phone TEXT,
        email TEXT,
        manager_id TEXT,
        is_active INTEGER DEFAULT 1,
        settings TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        synced_at INTEGER
      ''',
    ),
    TableDefinition(
      name: 'branch_inventory',
      schema: '''
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        branch_id TEXT NOT NULL,
        product_id TEXT NOT NULL,
        quantity REAL DEFAULT 0,
        reserved_quantity REAL DEFAULT 0,
        last_counted_at INTEGER,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        synced_at INTEGER,
        UNIQUE(branch_id, product_id)
      ''',
    ),
    
    // Purchase tables
    TableDefinition(
      name: 'suppliers',
      schema: '''
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        name TEXT NOT NULL,
        code TEXT,
        email TEXT,
        phone TEXT,
        mobile TEXT,
        website TEXT,
        tax_number TEXT,
        address TEXT,
        city TEXT,
        state TEXT,
        country TEXT,
        postal_code TEXT,
        payment_terms INTEGER DEFAULT 30,
        credit_limit REAL DEFAULT 0,
        current_balance REAL DEFAULT 0,
        status TEXT DEFAULT 'active',
        notes TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        synced_at INTEGER
      ''',
    ),
    TableDefinition(
      name: 'purchase_orders',
      schema: '''
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        supplier_id TEXT NOT NULL,
        po_number TEXT NOT NULL,
        order_date INTEGER NOT NULL,
        expected_date INTEGER,
        status TEXT DEFAULT 'draft',
        total_amount REAL DEFAULT 0,
        tax_amount REAL DEFAULT 0,
        discount_amount REAL DEFAULT 0,
        notes TEXT,
        created_by TEXT NOT NULL,
        approved_by TEXT,
        approved_at INTEGER,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        synced_at INTEGER
      ''',
    ),
    TableDefinition(
      name: 'purchase_order_items',
      schema: '''
        id TEXT PRIMARY KEY,
        purchase_order_id TEXT NOT NULL,
        product_id TEXT NOT NULL,
        quantity REAL NOT NULL,
        received_quantity REAL DEFAULT 0,
        unit_price REAL NOT NULL,
        tax_rate REAL DEFAULT 0,
        discount_rate REAL DEFAULT 0,
        total_amount REAL NOT NULL,
        created_at INTEGER NOT NULL,
        synced_at INTEGER
      ''',
    ),
    
    // Customer tables
    TableDefinition(
      name: 'customers',
      schema: '''
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        name TEXT NOT NULL,
        code TEXT,
        email TEXT,
        phone TEXT,
        mobile TEXT,
        tax_number TEXT,
        customer_type TEXT DEFAULT 'retail',
        price_list_id TEXT,
        credit_limit REAL DEFAULT 0,
        current_balance REAL DEFAULT 0,
        loyalty_points INTEGER DEFAULT 0,
        address TEXT,
        shipping_address TEXT,
        status TEXT DEFAULT 'active',
        notes TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        synced_at INTEGER
      ''',
    ),
    
    // POS tables
    TableDefinition(
      name: 'sales',
      schema: '''
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        branch_id TEXT,
        register_id TEXT,
        sale_number TEXT NOT NULL,
        customer_id TEXT,
        sale_date INTEGER NOT NULL,
        subtotal REAL NOT NULL,
        tax_amount REAL DEFAULT 0,
        discount_amount REAL DEFAULT 0,
        total_amount REAL NOT NULL,
        paid_amount REAL DEFAULT 0,
        change_amount REAL DEFAULT 0,
        payment_status TEXT DEFAULT 'pending',
        payment_methods TEXT,
        notes TEXT,
        cashier_id TEXT NOT NULL,
        voided INTEGER DEFAULT 0,
        voided_by TEXT,
        voided_at INTEGER,
        void_reason TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        synced_at INTEGER
      ''',
    ),
    TableDefinition(
      name: 'sale_items',
      schema: '''
        id TEXT PRIMARY KEY,
        sale_id TEXT NOT NULL,
        product_id TEXT NOT NULL,
        quantity REAL NOT NULL,
        unit_price REAL NOT NULL,
        cost_price REAL,
        discount_rate REAL DEFAULT 0,
        discount_amount REAL DEFAULT 0,
        tax_rate REAL DEFAULT 0,
        tax_amount REAL DEFAULT 0,
        total_amount REAL NOT NULL,
        notes TEXT,
        created_at INTEGER NOT NULL,
        synced_at INTEGER
      ''',
    ),
    TableDefinition(
      name: 'registers',
      schema: '''
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        branch_id TEXT NOT NULL,
        name TEXT NOT NULL,
        opening_cash REAL DEFAULT 0,
        closing_cash REAL,
        expected_cash REAL,
        cash_difference REAL,
        status TEXT DEFAULT 'closed',
        opened_by TEXT,
        opened_at INTEGER,
        closed_by TEXT,
        closed_at INTEGER,
        notes TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        synced_at INTEGER
      ''',
    ),
    
    // Tax tables
    TableDefinition(
      name: 'tax_rates',
      schema: '''
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        name TEXT NOT NULL,
        rate REAL NOT NULL,
        tax_type TEXT DEFAULT 'percentage',
        is_compound INTEGER DEFAULT 0,
        is_default INTEGER DEFAULT 0,
        hsn_code TEXT,
        sac_code TEXT,
        is_active INTEGER DEFAULT 1,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        synced_at INTEGER
      ''',
    ),
    
    // Serial/Batch tables
    TableDefinition(
      name: 'serial_numbers',
      schema: '''
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        product_id TEXT NOT NULL,
        serial_number TEXT NOT NULL,
        batch_id TEXT,
        status TEXT DEFAULT 'available',
        purchase_order_id TEXT,
        sale_id TEXT,
        current_location_id TEXT,
        notes TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        synced_at INTEGER,
        UNIQUE(organization_id, serial_number)
      ''',
    ),
    TableDefinition(
      name: 'batches',
      schema: '''
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        product_id TEXT NOT NULL,
        batch_number TEXT NOT NULL,
        manufacturing_date INTEGER,
        expiry_date INTEGER,
        quantity REAL DEFAULT 0,
        available_quantity REAL DEFAULT 0,
        cost_price REAL,
        supplier_id TEXT,
        purchase_order_id TEXT,
        notes TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        synced_at INTEGER,
        UNIQUE(organization_id, batch_number)
      ''',
    ),
    
    // Composite items
    TableDefinition(
      name: 'composite_items',
      schema: '''
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        parent_product_id TEXT NOT NULL,
        child_product_id TEXT NOT NULL,
        quantity REAL NOT NULL,
        created_at INTEGER NOT NULL,
        synced_at INTEGER
      ''',
    ),
    
    // Stock transfers
    TableDefinition(
      name: 'stock_transfers',
      schema: '''
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        transfer_number TEXT NOT NULL,
        from_branch_id TEXT NOT NULL,
        to_branch_id TEXT NOT NULL,
        transfer_date INTEGER NOT NULL,
        expected_date INTEGER,
        status TEXT DEFAULT 'draft',
        total_items INTEGER DEFAULT 0,
        total_quantity REAL DEFAULT 0,
        notes TEXT,
        created_by TEXT NOT NULL,
        approved_by TEXT,
        approved_at INTEGER,
        received_by TEXT,
        received_at INTEGER,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        synced_at INTEGER
      ''',
    ),
    
    // Communication tables
    TableDefinition(
      name: 'communication_templates',
      schema: '''
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        name TEXT NOT NULL,
        template_type TEXT NOT NULL,
        channel TEXT NOT NULL,
        subject TEXT,
        content TEXT NOT NULL,
        variables TEXT,
        is_active INTEGER DEFAULT 1,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        synced_at INTEGER
      ''',
    ),
    
    // Sync queue
    TableDefinition(
      name: 'sync_queue',
      schema: '''
        id TEXT PRIMARY KEY,
        table_name TEXT NOT NULL,
        operation TEXT NOT NULL,
        record_id TEXT NOT NULL,
        data TEXT NOT NULL,
        retry_count INTEGER DEFAULT 0,
        status TEXT DEFAULT 'pending',
        error_message TEXT,
        created_at INTEGER NOT NULL,
        processed_at INTEGER
      ''',
    ),
  ];
  
  static List<String> get indexes => [
    // User indexes
    'CREATE INDEX idx_users_email ON users(email)',
    'CREATE INDEX idx_users_organization ON users(organization_id)',
    
    // Product indexes
    'CREATE INDEX idx_products_organization ON products(organization_id)',
    'CREATE INDEX idx_products_sku ON products(organization_id, sku)',
    'CREATE INDEX idx_products_barcode ON products(barcode)',
    'CREATE INDEX idx_products_category ON products(category_id)',
    
    // Category indexes
    'CREATE INDEX idx_categories_organization ON categories(organization_id)',
    'CREATE INDEX idx_categories_parent ON categories(parent_id)',
    
    // Inventory indexes
    'CREATE INDEX idx_inventory_movements_product ON inventory_movements(product_id)',
    'CREATE INDEX idx_inventory_movements_branch ON inventory_movements(branch_id)',
    'CREATE INDEX idx_inventory_movements_date ON inventory_movements(performed_at)',
    
    // Branch inventory indexes
    'CREATE INDEX idx_branch_inventory_branch ON branch_inventory(branch_id)',
    'CREATE INDEX idx_branch_inventory_product ON branch_inventory(product_id)',
    
    // Purchase indexes
    'CREATE INDEX idx_purchase_orders_organization ON purchase_orders(organization_id)',
    'CREATE INDEX idx_purchase_orders_supplier ON purchase_orders(supplier_id)',
    'CREATE INDEX idx_purchase_order_items_order ON purchase_order_items(purchase_order_id)',
    
    // Customer indexes
    'CREATE INDEX idx_customers_organization ON customers(organization_id)',
    'CREATE INDEX idx_customers_code ON customers(code)',
    
    // Sales indexes
    'CREATE INDEX idx_sales_organization ON sales(organization_id)',
    'CREATE INDEX idx_sales_branch ON sales(branch_id)',
    'CREATE INDEX idx_sales_customer ON sales(customer_id)',
    'CREATE INDEX idx_sales_date ON sales(sale_date)',
    'CREATE INDEX idx_sale_items_sale ON sale_items(sale_id)',
    
    // Register indexes
    'CREATE INDEX idx_registers_branch ON registers(branch_id)',
    'CREATE INDEX idx_registers_status ON registers(status)',
    
    // Serial/Batch indexes
    'CREATE INDEX idx_serial_numbers_product ON serial_numbers(product_id)',
    'CREATE INDEX idx_serial_numbers_status ON serial_numbers(status)',
    'CREATE INDEX idx_batches_product ON batches(product_id)',
    'CREATE INDEX idx_batches_expiry ON batches(expiry_date)',
    
    // Stock transfer indexes
    'CREATE INDEX idx_stock_transfers_from_branch ON stock_transfers(from_branch_id)',
    'CREATE INDEX idx_stock_transfers_to_branch ON stock_transfers(to_branch_id)',
    'CREATE INDEX idx_stock_transfers_status ON stock_transfers(status)',
    
    // Sync queue indexes
    'CREATE INDEX idx_sync_queue_status ON sync_queue(status)',
    'CREATE INDEX idx_sync_queue_table ON sync_queue(table_name)',
  ];
  
  static Migration? getMigration(int version) {
    // Add migrations here as needed
    switch (version) {
      // case 2:
      //   return Migration(
      //     version: 2,
      //     upStatements: [
      //       'ALTER TABLE products ADD COLUMN hsn_code TEXT',
      //       'ALTER TABLE products ADD COLUMN sac_code TEXT',
      //     ],
      //     downStatements: [
      //       // SQLite doesn't support DROP COLUMN
      //     ],
      //   );
      default:
        return null;
    }
  }
}

class TableDefinition {
  final String name;
  final String schema;
  
  const TableDefinition({
    required this.name,
    required this.schema,
  });
}

class Migration {
  final int version;
  final List<String> upStatements;
  final List<String> downStatements;
  
  const Migration({
    required this.version,
    required this.upStatements,
    required this.downStatements,
  });
}