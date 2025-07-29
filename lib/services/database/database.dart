import 'dart:convert';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static Database? _database;
  static final AppDatabase instance = AppDatabase._();

  AppDatabase._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'inventory_app.db');
    
    return await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Users table
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        email TEXT NOT NULL,
        name TEXT NOT NULL,
        role TEXT NOT NULL,
        organization_id TEXT,
        permissions TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');

    // Organizations table
    await db.execute('''
      CREATE TABLE organizations (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        subscription_tier TEXT NOT NULL,
        subscription_status TEXT NOT NULL,
        owner_id TEXT NOT NULL,
        member_count INTEGER DEFAULT 1,
        settings TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');

    // Products table
    await db.execute('''
      CREATE TABLE products (
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        name TEXT NOT NULL,
        sku TEXT NOT NULL,
        barcode TEXT,
        description TEXT,
        category_id TEXT,
        unit TEXT,
        current_stock REAL DEFAULT 0,
        min_stock REAL DEFAULT 0,
        max_stock REAL,
        reorder_point REAL,
        reorder_quantity REAL,
        cost_price REAL,
        selling_price REAL,
        tax_rate REAL DEFAULT 0,
        warehouse_location TEXT,
        supplier_id TEXT,
        image_url TEXT,
        is_active INTEGER DEFAULT 1,
        metadata TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        FOREIGN KEY (organization_id) REFERENCES organizations (id)
      )
    ''');

    // Categories table
    await db.execute('''
      CREATE TABLE categories (
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
        FOREIGN KEY (organization_id) REFERENCES organizations (id)
      )
    ''');

    // Inventory movements table
    await db.execute('''
      CREATE TABLE inventory_movements (
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        product_id TEXT NOT NULL,
        type TEXT NOT NULL,
        quantity REAL NOT NULL,
        unit_cost REAL,
        total_cost REAL,
        reason TEXT,
        reference_number TEXT,
        from_warehouse TEXT,
        to_warehouse TEXT,
        performed_by TEXT NOT NULL,
        notes TEXT,
        created_at INTEGER NOT NULL,
        FOREIGN KEY (organization_id) REFERENCES organizations (id),
        FOREIGN KEY (product_id) REFERENCES products (id)
      )
    ''');

    // Permissions table
    await db.execute('''
      CREATE TABLE permissions (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        category TEXT NOT NULL,
        is_system_permission INTEGER DEFAULT 0,
        dependencies TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');

    // Roles table
    await db.execute('''
      CREATE TABLE roles (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        organization_id TEXT,
        is_system_role INTEGER DEFAULT 0,
        is_custom_role INTEGER DEFAULT 0,
        permissions TEXT,
        sort_order INTEGER DEFAULT 0,
        is_active INTEGER DEFAULT 1,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        FOREIGN KEY (organization_id) REFERENCES organizations (id)
      )
    ''');

    // Sync queue table for offline support
    await db.execute('''
      CREATE TABLE sync_queue (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        table_name TEXT NOT NULL,
        operation TEXT NOT NULL,
        record_id TEXT NOT NULL,
        data TEXT NOT NULL,
        retry_count INTEGER DEFAULT 0,
        created_at INTEGER NOT NULL
      )
    ''');

    // Sales table
    await db.execute('''
      CREATE TABLE sales (
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        register_id TEXT NOT NULL,
        user_id TEXT NOT NULL,
        customer_id TEXT,
        receipt_number TEXT NOT NULL,
        subtotal REAL NOT NULL,
        tax_amount REAL NOT NULL,
        discount_amount REAL NOT NULL,
        total_amount REAL NOT NULL,
        payment_method TEXT NOT NULL,
        split_payments TEXT,
        status TEXT NOT NULL,
        refund_reason TEXT,
        is_offline_sale INTEGER DEFAULT 0,
        notes TEXT,
        created_at INTEGER NOT NULL,
        synced_at INTEGER,
        FOREIGN KEY (organization_id) REFERENCES organizations (id),
        FOREIGN KEY (register_id) REFERENCES registers (id),
        FOREIGN KEY (user_id) REFERENCES users (id)
      )
    ''');

    // Sale items table
    await db.execute('''
      CREATE TABLE sale_items (
        id TEXT PRIMARY KEY,
        sale_id TEXT NOT NULL,
        product_id TEXT NOT NULL,
        product_name TEXT NOT NULL,
        variant_id TEXT,
        quantity REAL NOT NULL,
        unit_price REAL NOT NULL,
        discount_amount REAL NOT NULL,
        discount_percent REAL NOT NULL,
        tax_amount REAL NOT NULL,
        tax_percent REAL NOT NULL,
        total_amount REAL NOT NULL,
        notes TEXT,
        created_at INTEGER NOT NULL,
        FOREIGN KEY (sale_id) REFERENCES sales (id),
        FOREIGN KEY (product_id) REFERENCES products (id)
      )
    ''');

    // Registers table
    await db.execute('''
      CREATE TABLE registers (
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        name TEXT NOT NULL,
        location TEXT,
        opening_balance REAL NOT NULL,
        current_balance REAL NOT NULL,
        expected_balance REAL NOT NULL,
        status TEXT NOT NULL,
        opened_by TEXT NOT NULL,
        opened_at INTEGER NOT NULL,
        closed_by TEXT,
        closed_at INTEGER,
        denominations TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        FOREIGN KEY (organization_id) REFERENCES organizations (id)
      )
    ''');

    // Register transactions table
    await db.execute('''
      CREATE TABLE register_transactions (
        id TEXT PRIMARY KEY,
        register_id TEXT NOT NULL,
        type TEXT NOT NULL,
        amount REAL NOT NULL,
        reason TEXT,
        performed_by TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        FOREIGN KEY (register_id) REFERENCES registers (id)
      )
    ''');

    // Receipts table
    await db.execute('''
      CREATE TABLE receipts (
        id TEXT PRIMARY KEY,
        sale_id TEXT NOT NULL,
        receipt_number TEXT NOT NULL,
        template TEXT NOT NULL,
        custom_fields TEXT,
        format TEXT NOT NULL,
        is_printed INTEGER DEFAULT 0,
        printed_at INTEGER,
        printer_name TEXT,
        digital_receipt TEXT,
        created_at INTEGER NOT NULL,
        FOREIGN KEY (sale_id) REFERENCES sales (id)
      )
    ''');

    // POS settings table
    await db.execute('''
      CREATE TABLE pos_settings (
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        default_register_id TEXT,
        receipt_template TEXT,
        tax_inclusive INTEGER DEFAULT 0,
        enable_customer_display INTEGER DEFAULT 1,
        enable_quick_keys INTEGER DEFAULT 1,
        quick_keys TEXT,
        payment_methods TEXT,
        print_receipt_default INTEGER DEFAULT 1,
        email_receipt_default INTEGER DEFAULT 0,
        barcode_scanning_enabled INTEGER DEFAULT 1,
        offline_mode_enabled INTEGER DEFAULT 1,
        sync_interval INTEGER DEFAULT 30,
        currency TEXT DEFAULT 'USD',
        decimal_places INTEGER DEFAULT 2,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        FOREIGN KEY (organization_id) REFERENCES organizations (id)
      )
    ''');

    // Customer credits table
    await db.execute('''
      CREATE TABLE customer_credits (
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        customer_id TEXT NOT NULL,
        credit_limit REAL DEFAULT 0,
        current_balance REAL DEFAULT 0,
        last_payment_date INTEGER,
        last_payment_amount REAL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        FOREIGN KEY (organization_id) REFERENCES organizations (id)
      )
    ''');

    // Loyalty points table
    await db.execute('''
      CREATE TABLE loyalty_points (
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        customer_id TEXT NOT NULL,
        points_balance INTEGER DEFAULT 0,
        lifetime_points INTEGER DEFAULT 0,
        last_earned_date INTEGER,
        last_redeemed_date INTEGER,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        FOREIGN KEY (organization_id) REFERENCES organizations (id)
      )
    ''');

    // Purchase Orders table
    await db.execute('''
      CREATE TABLE purchase_orders (
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        supplier_id TEXT NOT NULL,
        po_number TEXT NOT NULL,
        order_date INTEGER NOT NULL,
        expected_date INTEGER,
        status TEXT NOT NULL,
        total_amount REAL NOT NULL,
        tax_amount REAL DEFAULT 0,
        discount_amount REAL DEFAULT 0,
        notes TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        created_by TEXT NOT NULL,
        FOREIGN KEY (organization_id) REFERENCES organizations (id),
        FOREIGN KEY (supplier_id) REFERENCES suppliers (id)
      )
    ''');

    // Purchase Order Items table
    await db.execute('''
      CREATE TABLE purchase_order_items (
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
        FOREIGN KEY (purchase_order_id) REFERENCES purchase_orders(id),
        FOREIGN KEY (product_id) REFERENCES products(id)
      )
    ''');

    // Purchase Bills table
    await db.execute('''
      CREATE TABLE purchase_bills (
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        supplier_id TEXT NOT NULL,
        purchase_order_id TEXT,
        bill_number TEXT NOT NULL,
        bill_date INTEGER NOT NULL,
        due_date INTEGER,
        status TEXT NOT NULL,
        total_amount REAL NOT NULL,
        paid_amount REAL DEFAULT 0,
        notes TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        FOREIGN KEY (organization_id) REFERENCES organizations (id),
        FOREIGN KEY (supplier_id) REFERENCES suppliers (id),
        FOREIGN KEY (purchase_order_id) REFERENCES purchase_orders(id)
      )
    ''');

    // Suppliers table
    await db.execute('''
      CREATE TABLE suppliers (
        id TEXT PRIMARY KEY,
        organization_id TEXT NOT NULL,
        name TEXT NOT NULL,
        code TEXT UNIQUE,
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
        FOREIGN KEY (organization_id) REFERENCES organizations (id)
      )
    ''');

    // Supplier Transactions table
    await db.execute('''
      CREATE TABLE supplier_transactions (
        id TEXT PRIMARY KEY,
        supplier_id TEXT NOT NULL,
        transaction_type TEXT NOT NULL,
        reference_id TEXT,
        amount REAL NOT NULL,
        balance REAL NOT NULL,
        transaction_date INTEGER NOT NULL,
        notes TEXT,
        created_at INTEGER NOT NULL,
        FOREIGN KEY (supplier_id) REFERENCES suppliers (id)
      )
    ''');

    // Create indexes
    await db.execute('CREATE INDEX idx_products_org ON products(organization_id)');
    await db.execute('CREATE INDEX idx_products_sku ON products(sku)');
    await db.execute('CREATE INDEX idx_products_barcode ON products(barcode)');
    await db.execute('CREATE INDEX idx_categories_org ON categories(organization_id)');
    await db.execute('CREATE INDEX idx_movements_org ON inventory_movements(organization_id)');
    await db.execute('CREATE INDEX idx_movements_product ON inventory_movements(product_id)');
    await db.execute('CREATE INDEX idx_roles_org ON roles(organization_id)');
    await db.execute('CREATE INDEX idx_roles_system ON roles(is_system_role)');
    await db.execute('CREATE INDEX idx_sales_org ON sales(organization_id)');
    await db.execute('CREATE INDEX idx_sales_register ON sales(register_id)');
    await db.execute('CREATE INDEX idx_sales_receipt ON sales(receipt_number)');
    await db.execute('CREATE INDEX idx_sale_items_sale ON sale_items(sale_id)');
    await db.execute('CREATE INDEX idx_registers_org ON registers(organization_id)');
    await db.execute('CREATE INDEX idx_receipts_sale ON receipts(sale_id)');
    await db.execute('CREATE INDEX idx_purchase_orders_org ON purchase_orders(organization_id)');
    await db.execute('CREATE INDEX idx_purchase_orders_supplier ON purchase_orders(supplier_id)');
    await db.execute('CREATE INDEX idx_purchase_order_items_po ON purchase_order_items(purchase_order_id)');
    await db.execute('CREATE INDEX idx_purchase_bills_org ON purchase_bills(organization_id)');
    await db.execute('CREATE INDEX idx_purchase_bills_supplier ON purchase_bills(supplier_id)');
    await db.execute('CREATE INDEX idx_suppliers_org ON suppliers(organization_id)');
    await db.execute('CREATE INDEX idx_supplier_transactions_supplier ON supplier_transactions(supplier_id)');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add POS-related tables
      await db.execute('''
        CREATE TABLE IF NOT EXISTS sales (
          id TEXT PRIMARY KEY,
          organization_id TEXT NOT NULL,
          register_id TEXT NOT NULL,
          user_id TEXT NOT NULL,
          customer_id TEXT,
          receipt_number TEXT NOT NULL,
          subtotal REAL NOT NULL,
          tax_amount REAL NOT NULL,
          discount_amount REAL NOT NULL,
          total_amount REAL NOT NULL,
          payment_method TEXT NOT NULL,
          split_payments TEXT,
          status TEXT NOT NULL,
          refund_reason TEXT,
          is_offline_sale INTEGER DEFAULT 0,
          notes TEXT,
          created_at INTEGER NOT NULL,
          synced_at INTEGER,
          FOREIGN KEY (organization_id) REFERENCES organizations (id),
          FOREIGN KEY (register_id) REFERENCES registers (id),
          FOREIGN KEY (user_id) REFERENCES users (id)
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS sale_items (
          id TEXT PRIMARY KEY,
          sale_id TEXT NOT NULL,
          product_id TEXT NOT NULL,
          product_name TEXT NOT NULL,
          variant_id TEXT,
          quantity REAL NOT NULL,
          unit_price REAL NOT NULL,
          discount_amount REAL NOT NULL,
          discount_percent REAL NOT NULL,
          tax_amount REAL NOT NULL,
          tax_percent REAL NOT NULL,
          total_amount REAL NOT NULL,
          notes TEXT,
          created_at INTEGER NOT NULL,
          FOREIGN KEY (sale_id) REFERENCES sales (id),
          FOREIGN KEY (product_id) REFERENCES products (id)
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS registers (
          id TEXT PRIMARY KEY,
          organization_id TEXT NOT NULL,
          name TEXT NOT NULL,
          location TEXT,
          opening_balance REAL NOT NULL,
          current_balance REAL NOT NULL,
          expected_balance REAL NOT NULL,
          status TEXT NOT NULL,
          opened_by TEXT NOT NULL,
          opened_at INTEGER NOT NULL,
          closed_by TEXT,
          closed_at INTEGER,
          denominations TEXT,
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL,
          FOREIGN KEY (organization_id) REFERENCES organizations (id)
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS register_transactions (
          id TEXT PRIMARY KEY,
          register_id TEXT NOT NULL,
          type TEXT NOT NULL,
          amount REAL NOT NULL,
          reason TEXT,
          performed_by TEXT NOT NULL,
          created_at INTEGER NOT NULL,
          FOREIGN KEY (register_id) REFERENCES registers (id)
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS receipts (
          id TEXT PRIMARY KEY,
          sale_id TEXT NOT NULL,
          receipt_number TEXT NOT NULL,
          template TEXT NOT NULL,
          custom_fields TEXT,
          format TEXT NOT NULL,
          is_printed INTEGER DEFAULT 0,
          printed_at INTEGER,
          printer_name TEXT,
          digital_receipt TEXT,
          created_at INTEGER NOT NULL,
          FOREIGN KEY (sale_id) REFERENCES sales (id)
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS pos_settings (
          id TEXT PRIMARY KEY,
          organization_id TEXT NOT NULL,
          default_register_id TEXT,
          receipt_template TEXT,
          tax_inclusive INTEGER DEFAULT 0,
          enable_customer_display INTEGER DEFAULT 1,
          enable_quick_keys INTEGER DEFAULT 1,
          quick_keys TEXT,
          payment_methods TEXT,
          print_receipt_default INTEGER DEFAULT 1,
          email_receipt_default INTEGER DEFAULT 0,
          barcode_scanning_enabled INTEGER DEFAULT 1,
          offline_mode_enabled INTEGER DEFAULT 1,
          sync_interval INTEGER DEFAULT 30,
          currency TEXT DEFAULT 'USD',
          decimal_places INTEGER DEFAULT 2,
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL,
          FOREIGN KEY (organization_id) REFERENCES organizations (id)
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS customer_credits (
          id TEXT PRIMARY KEY,
          organization_id TEXT NOT NULL,
          customer_id TEXT NOT NULL,
          credit_limit REAL DEFAULT 0,
          current_balance REAL DEFAULT 0,
          last_payment_date INTEGER,
          last_payment_amount REAL,
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL,
          FOREIGN KEY (organization_id) REFERENCES organizations (id)
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS loyalty_points (
          id TEXT PRIMARY KEY,
          organization_id TEXT NOT NULL,
          customer_id TEXT NOT NULL,
          points_balance INTEGER DEFAULT 0,
          lifetime_points INTEGER DEFAULT 0,
          last_earned_date INTEGER,
          last_redeemed_date INTEGER,
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL,
          FOREIGN KEY (organization_id) REFERENCES organizations (id)
        )
      ''');

      // Create indexes for POS tables
      await db.execute('CREATE INDEX IF NOT EXISTS idx_sales_org ON sales(organization_id)');
      await db.execute('CREATE INDEX IF NOT EXISTS idx_sales_register ON sales(register_id)');
      await db.execute('CREATE INDEX IF NOT EXISTS idx_sales_receipt ON sales(receipt_number)');
      await db.execute('CREATE INDEX IF NOT EXISTS idx_sale_items_sale ON sale_items(sale_id)');
      await db.execute('CREATE INDEX IF NOT EXISTS idx_registers_org ON registers(organization_id)');
      await db.execute('CREATE INDEX IF NOT EXISTS idx_receipts_sale ON receipts(sale_id)');
    }
    
    if (oldVersion < 3) {
      // Add Purchase Order Management tables
      await db.execute('''
        CREATE TABLE IF NOT EXISTS purchase_orders (
          id TEXT PRIMARY KEY,
          organization_id TEXT NOT NULL,
          supplier_id TEXT NOT NULL,
          po_number TEXT NOT NULL,
          order_date INTEGER NOT NULL,
          expected_date INTEGER,
          status TEXT NOT NULL,
          total_amount REAL NOT NULL,
          tax_amount REAL DEFAULT 0,
          discount_amount REAL DEFAULT 0,
          notes TEXT,
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL,
          created_by TEXT NOT NULL,
          FOREIGN KEY (organization_id) REFERENCES organizations (id),
          FOREIGN KEY (supplier_id) REFERENCES suppliers (id)
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS purchase_order_items (
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
          FOREIGN KEY (purchase_order_id) REFERENCES purchase_orders(id),
          FOREIGN KEY (product_id) REFERENCES products(id)
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS purchase_bills (
          id TEXT PRIMARY KEY,
          organization_id TEXT NOT NULL,
          supplier_id TEXT NOT NULL,
          purchase_order_id TEXT,
          bill_number TEXT NOT NULL,
          bill_date INTEGER NOT NULL,
          due_date INTEGER,
          status TEXT NOT NULL,
          total_amount REAL NOT NULL,
          paid_amount REAL DEFAULT 0,
          notes TEXT,
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL,
          FOREIGN KEY (organization_id) REFERENCES organizations (id),
          FOREIGN KEY (supplier_id) REFERENCES suppliers (id),
          FOREIGN KEY (purchase_order_id) REFERENCES purchase_orders(id)
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS suppliers (
          id TEXT PRIMARY KEY,
          organization_id TEXT NOT NULL,
          name TEXT NOT NULL,
          code TEXT UNIQUE,
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
          FOREIGN KEY (organization_id) REFERENCES organizations (id)
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS supplier_transactions (
          id TEXT PRIMARY KEY,
          supplier_id TEXT NOT NULL,
          transaction_type TEXT NOT NULL,
          reference_id TEXT,
          amount REAL NOT NULL,
          balance REAL NOT NULL,
          transaction_date INTEGER NOT NULL,
          notes TEXT,
          created_at INTEGER NOT NULL,
          FOREIGN KEY (supplier_id) REFERENCES suppliers (id)
        )
      ''');

      // Create indexes for Purchase Order tables
      await db.execute('CREATE INDEX IF NOT EXISTS idx_purchase_orders_org ON purchase_orders(organization_id)');
      await db.execute('CREATE INDEX IF NOT EXISTS idx_purchase_orders_supplier ON purchase_orders(supplier_id)');
      await db.execute('CREATE INDEX IF NOT EXISTS idx_purchase_order_items_po ON purchase_order_items(purchase_order_id)');
      await db.execute('CREATE INDEX IF NOT EXISTS idx_purchase_bills_org ON purchase_bills(organization_id)');
      await db.execute('CREATE INDEX IF NOT EXISTS idx_purchase_bills_supplier ON purchase_bills(supplier_id)');
      await db.execute('CREATE INDEX IF NOT EXISTS idx_suppliers_org ON suppliers(organization_id)');
      await db.execute('CREATE INDEX IF NOT EXISTS idx_supplier_transactions_supplier ON supplier_transactions(supplier_id)');
    }
  }

  // User operations
  Future<Map<String, dynamic>?> getUser(String id) async {
    final db = await database;
    final results = await db.query('users', where: 'id = ?', whereArgs: [id]);
    return results.isNotEmpty ? results.first : null;
  }

  Future<String> createUser(Map<String, dynamic> user) async {
    final db = await database;
    final id = user['id'] ?? DateTime.now().millisecondsSinceEpoch.toString();
    final now = DateTime.now().millisecondsSinceEpoch;
    
    await db.insert('users', {
      ...user,
      'id': id,
      'created_at': now,
      'updated_at': now,
      'permissions': jsonEncode(user['permissions'] ?? []),
    });
    
    return id;
  }

  Future<void> updateUser(String id, Map<String, dynamic> updates) async {
    final db = await database;
    await db.update(
      'users',
      {
        ...updates,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
        if (updates['permissions'] != null)
          'permissions': jsonEncode(updates['permissions']),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Organization operations
  Future<Map<String, dynamic>?> getOrganization(String id) async {
    final db = await database;
    final results = await db.query('organizations', where: 'id = ?', whereArgs: [id]);
    if (results.isEmpty) return null;
    
    final org = Map<String, dynamic>.from(results.first);
    if (org['settings'] != null) {
      org['settings'] = jsonDecode(org['settings']);
    }
    return org;
  }

  Future<String> createOrganization(Map<String, dynamic> organization) async {
    final db = await database;
    final id = organization['id'] ?? DateTime.now().millisecondsSinceEpoch.toString();
    final now = DateTime.now().millisecondsSinceEpoch;
    
    await db.insert('organizations', {
      ...organization,
      'id': id,
      'created_at': now,
      'updated_at': now,
      'settings': jsonEncode(organization['settings'] ?? {}),
    });
    
    return id;
  }

  // Product operations
  Future<List<Map<String, dynamic>>> getProducts(String organizationId, {
    String? categoryId,
    String? searchQuery,
    int? limit,
    int? offset,
  }) async {
    final db = await database;
    String query = 'SELECT * FROM products WHERE organization_id = ?';
    List<dynamic> args = [organizationId];
    
    if (categoryId != null) {
      query += ' AND category_id = ?';
      args.add(categoryId);
    }
    
    if (searchQuery != null && searchQuery.isNotEmpty) {
      query += ' AND (name LIKE ? OR sku LIKE ? OR barcode LIKE ?)';
      final searchPattern = '%$searchQuery%';
      args.addAll([searchPattern, searchPattern, searchPattern]);
    }
    
    query += ' ORDER BY name ASC';
    
    if (limit != null) {
      query += ' LIMIT ?';
      args.add(limit);
      if (offset != null) {
        query += ' OFFSET ?';
        args.add(offset);
      }
    }
    
    final results = await db.rawQuery(query, args);
    return results.map((row) {
      final product = Map<String, dynamic>.from(row);
      if (product['metadata'] != null) {
        product['metadata'] = jsonDecode(product['metadata']);
      }
      product['is_active'] = product['is_active'] == 1;
      return product;
    }).toList();
  }

  Future<String> createProduct(Map<String, dynamic> product) async {
    final db = await database;
    final id = product['id'] ?? DateTime.now().millisecondsSinceEpoch.toString();
    final now = DateTime.now().millisecondsSinceEpoch;
    
    await db.insert('products', {
      ...product,
      'id': id,
      'created_at': now,
      'updated_at': now,
      'is_active': product['is_active'] == true ? 1 : 0,
      'metadata': jsonEncode(product['metadata'] ?? {}),
    });
    
    return id;
  }

  Future<void> updateProduct(String id, Map<String, dynamic> updates) async {
    final db = await database;
    await db.update(
      'products',
      {
        ...updates,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
        if (updates['is_active'] != null)
          'is_active': updates['is_active'] ? 1 : 0,
        if (updates['metadata'] != null)
          'metadata': jsonEncode(updates['metadata']),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Category operations
  Future<List<Map<String, dynamic>>> getCategories(String organizationId) async {
    final db = await database;
    final results = await db.query(
      'categories',
      where: 'organization_id = ?',
      whereArgs: [organizationId],
      orderBy: 'sort_order ASC, name ASC',
    );
    
    return results.map((row) {
      final category = Map<String, dynamic>.from(row);
      category['is_active'] = category['is_active'] == 1;
      return category;
    }).toList();
  }

  Future<String> createCategory(Map<String, dynamic> category) async {
    final db = await database;
    final id = category['id'] ?? DateTime.now().millisecondsSinceEpoch.toString();
    final now = DateTime.now().millisecondsSinceEpoch;
    
    await db.insert('categories', {
      ...category,
      'id': id,
      'created_at': now,
      'updated_at': now,
      'is_active': category['is_active'] == true ? 1 : 0,
    });
    
    return id;
  }

  Future<void> updateCategory(String categoryId, Map<String, dynamic> updates) async {
    final db = await database;
    final now = DateTime.now().millisecondsSinceEpoch;
    
    final updatesWithTimestamp = Map<String, dynamic>.from(updates);
    updatesWithTimestamp['updated_at'] = now;
    
    // Handle boolean conversion for is_active
    if (updatesWithTimestamp.containsKey('is_active')) {
      updatesWithTimestamp['is_active'] = updatesWithTimestamp['is_active'] == true ? 1 : 0;
    }
    
    await db.update(
      'categories',
      updatesWithTimestamp,
      where: 'id = ?',
      whereArgs: [categoryId],
    );
  }

  // Inventory movement operations
  Future<void> recordInventoryMovement(Map<String, dynamic> movement) async {
    final db = await database;
    final id = movement['id'] ?? DateTime.now().millisecondsSinceEpoch.toString();
    final now = DateTime.now().millisecondsSinceEpoch;
    
    await db.transaction((txn) async {
      // Record the movement
      await txn.insert('inventory_movements', {
        ...movement,
        'id': id,
        'created_at': now,
      });
      
      // Update product stock
      if (movement['type'] == 'IN' || movement['type'] == 'PURCHASE') {
        await txn.rawUpdate(
          'UPDATE products SET current_stock = current_stock + ? WHERE id = ?',
          [movement['quantity'], movement['product_id']],
        );
      } else if (movement['type'] == 'OUT' || movement['type'] == 'SALE') {
        await txn.rawUpdate(
          'UPDATE products SET current_stock = current_stock - ? WHERE id = ?',
          [movement['quantity'], movement['product_id']],
        );
      }
    });
  }

  Future<List<Map<String, dynamic>>> getInventoryMovements(
    String organizationId, {
    String? productId,
    String? type,
    int? limit,
  }) async {
    final db = await database;
    String query = 'SELECT * FROM inventory_movements WHERE organization_id = ?';
    List<dynamic> args = [organizationId];
    
    if (productId != null) {
      query += ' AND product_id = ?';
      args.add(productId);
    }
    
    if (type != null) {
      query += ' AND type = ?';
      args.add(type);
    }
    
    query += ' ORDER BY created_at DESC';
    
    if (limit != null) {
      query += ' LIMIT ?';
      args.add(limit);
    }
    
    return await db.rawQuery(query, args);
  }

  // Sync queue operations
  Future<void> addToSyncQueue(String tableName, String operation, String recordId, Map<String, dynamic> data) async {
    final db = await database;
    await db.insert('sync_queue', {
      'table_name': tableName,
      'operation': operation,
      'record_id': recordId,
      'data': jsonEncode(data),
      'created_at': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<List<Map<String, dynamic>>> getPendingSyncItems() async {
    final db = await database;
    final results = await db.query(
      'sync_queue',
      orderBy: 'created_at ASC',
      limit: 50,
    );
    
    return results.map((row) {
      final item = Map<String, dynamic>.from(row);
      item['data'] = jsonDecode(item['data']);
      return item;
    }).toList();
  }

  Future<void> removeSyncItem(int id) async {
    final db = await database;
    await db.delete('sync_queue', where: 'id = ?', whereArgs: [id]);
  }

  // Alias for getSyncQueue for compatibility
  Future<List<Map<String, dynamic>>> getSyncQueue() async {
    return await getPendingSyncItems();
  }

  // Remove sync queue item
  Future<void> removeSyncQueueItem(int id) async {
    return await removeSyncItem(id);
  }

  // Update sync queue item
  Future<void> updateSyncQueueItem(int id, Map<String, dynamic> updates) async {
    final db = await database;
    await db.update('sync_queue', updates, where: 'id = ?', whereArgs: [id]);
  }

  // Clear failed sync items
  Future<void> clearFailedSyncItems() async {
    final db = await database;
    await db.delete('sync_queue', where: 'retry_count >= ?', whereArgs: [3]);
  }

  // Reset failed sync items
  Future<void> resetFailedSyncItems() async {
    final db = await database;
    await db.update(
      'sync_queue',
      {'retry_count': 0},
      where: 'retry_count >= ?',
      whereArgs: [3],
    );
  }

  // Analytics queries
  Future<Map<String, dynamic>> getDashboardStats(String organizationId) async {
    final db = await database;
    
    // Total products
    final productCount = Sqflite.firstIntValue(await db.rawQuery(
      'SELECT COUNT(*) FROM products WHERE organization_id = ? AND is_active = 1',
      [organizationId],
    )) ?? 0;
    
    // Low stock products
    final lowStockCount = Sqflite.firstIntValue(await db.rawQuery(
      'SELECT COUNT(*) FROM products WHERE organization_id = ? AND is_active = 1 AND current_stock <= min_stock',
      [organizationId],
    )) ?? 0;
    
    // Total inventory value
    final inventoryValue = Sqflite.firstIntValue(await db.rawQuery(
      'SELECT SUM(current_stock * cost_price) FROM products WHERE organization_id = ? AND is_active = 1',
      [organizationId],
    )) ?? 0;
    
    // Recent movements
    final recentMovements = await getInventoryMovements(organizationId, limit: 10);
    
    return {
      'total_products': productCount,
      'low_stock_count': lowStockCount,
      'inventory_value': inventoryValue,
      'recent_movements': recentMovements,
    };
  }

  // Permission operations
  Future<List<Map<String, dynamic>>> getPermissions() async {
    final db = await database;
    final results = await db.query('permissions', orderBy: 'category ASC, name ASC');
    
    return results.map((row) {
      final permission = Map<String, dynamic>.from(row);
      permission['is_system_permission'] = permission['is_system_permission'] == 1;
      permission['dependencies'] = permission['dependencies'] != null 
          ? (permission['dependencies'] as String).split(',').where((s) => s.isNotEmpty).toList()
          : <String>[];
      return permission;
    }).toList();
  }

  Future<String> createPermission(Map<String, dynamic> permission) async {
    final db = await database;
    final id = permission['id'] ?? DateTime.now().millisecondsSinceEpoch.toString();
    final now = DateTime.now().millisecondsSinceEpoch;
    
    await db.insert('permissions', {
      ...permission,
      'id': id,
      'created_at': now,
      'updated_at': now,
      'is_system_permission': permission['is_system_permission'] == true ? 1 : 0,
      'dependencies': permission['dependencies'] is List 
          ? (permission['dependencies'] as List<String>).join(',')
          : permission['dependencies'] ?? '',
    });
    
    return id;
  }

  // Role operations
  Future<List<Map<String, dynamic>>> getRoles() async {
    final db = await database;
    final results = await db.query('roles', orderBy: 'sort_order ASC, name ASC');
    
    return results.map((row) {
      final role = Map<String, dynamic>.from(row);
      role['is_system_role'] = role['is_system_role'] == 1;
      role['is_custom_role'] = role['is_custom_role'] == 1;
      role['is_active'] = role['is_active'] == 1;
      role['permissions'] = role['permissions'] != null 
          ? (role['permissions'] as String).split(',').where((s) => s.isNotEmpty).toList()
          : <String>[];
      return role;
    }).toList();
  }

  Future<Map<String, dynamic>?> getRoleById(String roleId) async {
    final db = await database;
    final results = await db.query(
      'roles',
      where: 'id = ?',
      whereArgs: [roleId],
      limit: 1,
    );
    
    if (results.isEmpty) return null;
    
    final role = Map<String, dynamic>.from(results.first);
    role['is_system_role'] = role['is_system_role'] == 1;
    role['is_custom_role'] = role['is_custom_role'] == 1;
    role['is_active'] = role['is_active'] == 1;
    role['permissions'] = role['permissions'] != null 
        ? (role['permissions'] as String).split(',').where((s) => s.isNotEmpty).toList()
        : <String>[];
    return role;
  }

  Future<String> createRole(Map<String, dynamic> role) async {
    final db = await database;
    final id = role['id'] ?? DateTime.now().millisecondsSinceEpoch.toString();
    final now = DateTime.now().millisecondsSinceEpoch;
    
    await db.insert('roles', {
      ...role,
      'id': id,
      'created_at': now,
      'updated_at': now,
      'is_system_role': role['is_system_role'] == true ? 1 : 0,
      'is_custom_role': role['is_custom_role'] == true ? 1 : 0,
      'is_active': role['is_active'] == true ? 1 : 0,
      'permissions': role['permissions'] is List 
          ? (role['permissions'] as List<String>).join(',')
          : role['permissions'] ?? '',
    });
    
    return id;
  }

  Future<void> updateRole(String roleId, Map<String, dynamic> updates) async {
    final db = await database;
    final now = DateTime.now().millisecondsSinceEpoch;
    
    final updatesWithTimestamp = Map<String, dynamic>.from(updates);
    updatesWithTimestamp['updated_at'] = now;
    
    // Handle boolean conversions
    if (updatesWithTimestamp.containsKey('is_system_role')) {
      updatesWithTimestamp['is_system_role'] = updatesWithTimestamp['is_system_role'] == true ? 1 : 0;
    }
    if (updatesWithTimestamp.containsKey('is_custom_role')) {
      updatesWithTimestamp['is_custom_role'] = updatesWithTimestamp['is_custom_role'] == true ? 1 : 0;
    }
    if (updatesWithTimestamp.containsKey('is_active')) {
      updatesWithTimestamp['is_active'] = updatesWithTimestamp['is_active'] == true ? 1 : 0;
    }
    if (updatesWithTimestamp.containsKey('permissions')) {
      updatesWithTimestamp['permissions'] = updatesWithTimestamp['permissions'] is List 
          ? (updatesWithTimestamp['permissions'] as List<String>).join(',')
          : updatesWithTimestamp['permissions'] ?? '';
    }
    
    await db.update(
      'roles',
      updatesWithTimestamp,
      where: 'id = ?',
      whereArgs: [roleId],
    );
  }

  Future<void> deleteRole(String roleId) async {
    final db = await database;
    await db.delete(
      'roles',
      where: 'id = ?',
      whereArgs: [roleId],
    );
  }

  Future<List<Map<String, dynamic>>> getUsersWithRole(String roleId) async {
    final db = await database;
    return await db.query(
      'users',
      where: 'role = ?',
      whereArgs: [roleId],
    );
  }

  Future<Map<String, dynamic>?> getUserById(String userId) async {
    final db = await database;
    final results = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
      limit: 1,
    );
    
    if (results.isEmpty) return null;
    return Map<String, dynamic>.from(results.first);
  }

  // System admin methods
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.query('users', orderBy: 'created_at DESC');
  }

  Future<List<Map<String, dynamic>>> getUsers(String organizationId) async {
    final db = await database;
    return await db.query('users', where: 'organization_id = ?', whereArgs: [organizationId]);
  }

  Future<List<Map<String, dynamic>>> getAllOrganizations() async {
    final db = await database;
    final results = await db.query('organizations', orderBy: 'created_at DESC');
    
    return results.map((row) {
      final org = Map<String, dynamic>.from(row);
      org['is_active'] = org['is_active'] == 1;
      return org;
    }).toList();
  }

  Future<void> deleteUser(String userId) async {
    final db = await database;
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  Future<void> deleteOrganization(String organizationId) async {
    final db = await database;
    await db.transaction((txn) async {
      // Delete related data first
      await txn.delete('inventory_movements', where: 'organization_id = ?', whereArgs: [organizationId]);
      await txn.delete('products', where: 'organization_id = ?', whereArgs: [organizationId]);
      await txn.delete('categories', where: 'organization_id = ?', whereArgs: [organizationId]);
      await txn.delete('users', where: 'organization_id = ?', whereArgs: [organizationId]);
      
      // Delete organization
      await txn.delete('organizations', where: 'id = ?', whereArgs: [organizationId]);
    });
  }

  // Sync queue operations
  Future<List<Map<String, dynamic>>> getSyncQueue() async {
    final db = await database;
    return await db.query('sync_queue', orderBy: 'created_at ASC');
  }

  Future<void> removeSyncQueueItem(int id) async {
    final db = await database;
    await db.delete('sync_queue', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateSyncQueueItem(int id, Map<String, dynamic> updates) async {
    final db = await database;
    await db.update('sync_queue', updates, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearFailedSyncItems() async {
    final db = await database;
    await db.delete('sync_queue', where: 'retry_count >= ?', whereArgs: [3]);
  }

  Future<void> resetFailedSyncItems() async {
    final db = await database;
    await db.update(
      'sync_queue',
      {'retry_count': 0},
      where: 'retry_count >= ?',
      whereArgs: [3],
    );
  }

  // Clear all data (for logout)
  Future<void> clearAllData() async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete('sync_queue');
      await txn.delete('inventory_movements');
      await txn.delete('products');
      await txn.delete('categories');
      await txn.delete('organizations');
      await txn.delete('users');
      await txn.delete('roles');
      await txn.delete('permissions');
    });
  }
}