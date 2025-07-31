/// Database schema constants for inventory management plugin
class DatabaseSchema {
  static const String databaseName = 'inventory_management.db';
  static const int databaseVersion = 1;
  
  // Table names
  static const String organizationsTable = 'organizations';
  static const String usersTable = 'users';
  static const String productsTable = 'products';
  static const String categoriesTable = 'categories';
  static const String customersTable = 'customers';
  static const String suppliersTable = 'suppliers';
  static const String branchesTable = 'branches';
  static const String salesTable = 'sales';
  static const String saleItemsTable = 'sale_items';
  static const String inventoryMovementsTable = 'inventory_movements';
  static const String purchaseOrdersTable = 'purchase_orders';
  static const String purchaseOrderItemsTable = 'purchase_order_items';
  static const String batchesTable = 'batches';
  static const String serialNumbersTable = 'serial_numbers';
  static const String serialMovementsTable = 'serial_movements';
  static const String stockTransfersTable = 'stock_transfers';
  static const String stockTransferItemsTable = 'stock_transfer_items';
  static const String taxRatesTable = 'tax_rates';
  static const String hsnCodesTable = 'hsn_codes';
  static const String posSettingsTable = 'pos_settings';
  static const String quickKeysTable = 'quick_keys';
  static const String receiptsTable = 'receipts';
  static const String registersTable = 'registers';
  static const String registerTransactionsTable = 'register_transactions';
  static const String branchInventoryTable = 'branch_inventory';
  static const String stockAlertsTable = 'stock_alerts';
  static const String permissionsTable = 'permissions';
  static const String rolesTable = 'roles';
  static const String rolePermissionsTable = 'role_permissions';
  static const String compositeItemsTable = 'composite_items';
  static const String compositeItemComponentsTable = 'composite_item_components';
  static const String supplierTransactionsTable = 'supplier_transactions';
  static const String supplierPaymentSchedulesTable = 'supplier_payment_schedules';
  static const String communicationTemplatesTable = 'communication_templates';
  static const String communicationLogsTable = 'communication_logs';
  static const String costLotsTable = 'cost_lots';
  static const String purchaseBillsTable = 'purchase_bills';
  static const String purchaseBillItemsTable = 'purchase_bill_items';
  static const String purchaseBillPaymentsTable = 'purchase_bill_payments';
  static const String repackagingRulesTable = 'repackaging_rules';
  static const String repackagingTransactionsTable = 'repackaging_transactions';
  static const String scheduledReportsTable = 'scheduled_reports';
  static const String syncQueueTable = 'sync_queue';
  
  // Common column names
  static const String id = 'id';
  static const String organizationId = 'organization_id';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String syncedAt = 'synced_at';
  static const String isActive = 'is_active';
  static const String metadata = 'metadata';
  
  // Index names
  static const String indexOrganizationId = 'idx_organization_id';
  static const String indexSyncedAt = 'idx_synced_at';
  static const String indexCreatedAt = 'idx_created_at';
  static const String indexIsActive = 'idx_is_active';
}