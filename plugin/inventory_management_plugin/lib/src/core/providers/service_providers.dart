import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/repositories/customer_repository.dart';
import '../../domain/repositories/supplier_repository.dart';
import '../../domain/repositories/branch_repository.dart';
import '../../domain/repositories/sale_repository.dart';
import '../../domain/repositories/purchase_order_repository.dart';
import '../../domain/repositories/inventory_movement_repository.dart';
import '../../domain/repositories/stock_transfer_repository.dart';
import '../../domain/repositories/tax_rate_repository.dart';
import '../../domain/repositories/batch_repository.dart';
import '../../domain/repositories/serial_number_repository.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../data/repositories/customer_repository_impl.dart';
import '../../data/repositories/supplier_repository_impl.dart';
import '../../data/repositories/branch_repository_impl.dart';
import '../../data/repositories/sale_repository_impl.dart';
import '../../data/repositories/purchase_order_repository_impl.dart';
import '../../data/repositories/inventory_movement_repository_impl.dart';
import '../../data/repositories/stock_transfer_repository_impl.dart';
import '../../data/repositories/tax_rate_repository_impl.dart';
import '../../data/repositories/batch_repository_impl.dart';
import '../../data/repositories/serial_number_repository_impl.dart';
import '../../services/product/product_service.dart';
import '../../services/category/category_service.dart';
import '../../services/customer/customer_service.dart';
import '../../services/supplier/supplier_service.dart';
import '../../services/branch/branch_service.dart';
import '../../services/inventory/inventory_movement_service.dart';
import '../../services/purchase/purchase_order_service.dart';
import '../../services/pos/pos_service.dart';
import '../../services/tax/tax_service.dart';
import '../../services/stock_transfer/stock_transfer_service.dart';
import '../../services/batch/batch_service.dart';
import '../../services/reporting/reporting_service.dart';
import '../../services/barcode/barcode_service.dart';
import '../../services/sync/sync_service.dart';
import '../interfaces/simple_auth_adapter.dart';
import '../interfaces/storage_adapter.dart';

/// Service providers manager
class ServiceProviders {
  late AppDatabase _database;
  SimpleAuthAdapter? _authAdapter;
  StorageAdapter? _storageAdapter;

  void initialize({
    required AppDatabase database,
    SimpleAuthAdapter? authAdapter,
    StorageAdapter? storageAdapter,
  }) {
    _database = database;
    _authAdapter = authAdapter;
    _storageAdapter = storageAdapter;
  }

  AppDatabase get database => _database;
  SimpleAuthAdapter? get authAdapter => _authAdapter;
  StorageAdapter? get storageAdapter => _storageAdapter;
}

/// Provider for service providers manager
final serviceProvidersProvider = Provider<ServiceProviders>((ref) {
  return ServiceProviders();
});

/// Database provider
final databaseProvider = Provider<AppDatabase>((ref) {
  return ref.watch(serviceProvidersProvider).database;
});

// Repository providers

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return ProductRepositoryImpl(database);
});

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return CategoryRepositoryImpl(database);
});

final customerRepositoryProvider = Provider<CustomerRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return CustomerRepositoryImpl(database);
});

final supplierRepositoryProvider = Provider<SupplierRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return SupplierRepositoryImpl(database);
});

final branchRepositoryProvider = Provider<BranchRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return BranchRepositoryImpl(database);
});

final saleRepositoryProvider = Provider<SaleRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return SaleRepositoryImpl(database);
});

final purchaseOrderRepositoryProvider = Provider<PurchaseOrderRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return PurchaseOrderRepositoryImpl(database);
});

final inventoryMovementRepositoryProvider = Provider<InventoryMovementRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return InventoryMovementRepositoryImpl(database);
});

final stockTransferRepositoryProvider = Provider<StockTransferRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return StockTransferRepositoryImpl(database);
});

final taxRateRepositoryProvider = Provider<TaxRateRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return TaxRateRepositoryImpl(database);
});

final batchRepositoryProvider = Provider<BatchRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return BatchRepositoryImpl(database);
});

final serialNumberRepositoryProvider = Provider<SerialNumberRepository>((ref) {
  final database = ref.watch(databaseProvider);
  return SerialNumberRepositoryImpl(database);
});

// Service providers

final productServiceProvider = Provider<ProductService>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  final syncService = ref.watch(syncServiceProvider);
  return ProductService(
    productRepository: repository,
    syncService: syncService,
  );
});

final categoryServiceProvider = Provider<CategoryService>((ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  final syncService = ref.watch(syncServiceProvider);
  return CategoryService(
    categoryRepository: repository,
    syncService: syncService,
  );
});

final customerServiceProvider = Provider<CustomerService>((ref) {
  final repository = ref.watch(customerRepositoryProvider);
  final syncService = ref.watch(syncServiceProvider);
  return CustomerService(
    customerRepository: repository,
    syncService: syncService,
  );
});

final supplierServiceProvider = Provider<SupplierService>((ref) {
  final repository = ref.watch(supplierRepositoryProvider);
  final syncService = ref.watch(syncServiceProvider);
  return SupplierService(
    supplierRepository: repository,
    syncService: syncService,
  );
});

final branchServiceProvider = Provider<BranchService>((ref) {
  final repository = ref.watch(branchRepositoryProvider);
  final syncService = ref.watch(syncServiceProvider);
  return BranchService(
    branchRepository: repository,
    syncService: syncService,
  );
});

final inventoryMovementServiceProvider = Provider<InventoryMovementService>((ref) {
  final movementRepo = ref.watch(inventoryMovementRepositoryProvider);
  final productRepo = ref.watch(productRepositoryProvider);
  final batchRepo = ref.watch(batchRepositoryProvider);
  final syncService = ref.watch(syncServiceProvider);
  
  return InventoryMovementService(
    movementRepository: movementRepo,
    productRepository: productRepo,
    batchRepository: batchRepo,
    syncService: syncService,
  );
});

// Alias for inventory service
final inventoryServiceProvider = inventoryMovementServiceProvider;

final purchaseOrderServiceProvider = Provider<PurchaseOrderService>((ref) {
  final orderRepo = ref.watch(purchaseOrderRepositoryProvider);
  final productRepo = ref.watch(productRepositoryProvider);
  final supplierRepo = ref.watch(supplierRepositoryProvider);
  final movementRepo = ref.watch(inventoryMovementRepositoryProvider);
  final syncService = ref.watch(syncServiceProvider);
  
  return PurchaseOrderService(
    orderRepository: orderRepo,
    productRepository: productRepo,
    supplierRepository: supplierRepo,
    movementRepository: movementRepo,
    syncService: syncService,
  );
});

final posServiceProvider = Provider<POSService>((ref) {
  final saleRepo = ref.watch(saleRepositoryProvider);
  final productRepo = ref.watch(productRepositoryProvider);
  final movementRepo = ref.watch(inventoryMovementRepositoryProvider);
  final syncService = ref.watch(syncServiceProvider);
  
  return POSService(
    saleRepository: saleRepo,
    productRepository: productRepo,
    movementRepository: movementRepo,
    syncService: syncService,
  );
});

final taxServiceProvider = Provider<TaxService>((ref) {
  final taxRepo = ref.watch(taxRateRepositoryProvider);
  final syncService = ref.watch(syncServiceProvider);
  
  return TaxService(
    taxRepository: taxRepo,
    syncService: syncService,
  );
});

final stockTransferServiceProvider = Provider<StockTransferService>((ref) {
  final transferRepo = ref.watch(stockTransferRepositoryProvider);
  final movementRepo = ref.watch(inventoryMovementRepositoryProvider);
  final productRepo = ref.watch(productRepositoryProvider);
  final syncService = ref.watch(syncServiceProvider);
  
  return StockTransferService(
    transferRepository: transferRepo,
    movementRepository: movementRepo,
    productRepository: productRepo,
    syncService: syncService,
  );
});

final batchServiceProvider = Provider<BatchService>((ref) {
  final batchRepo = ref.watch(batchRepositoryProvider);
  final serialRepo = ref.watch(serialNumberRepositoryProvider);
  final movementRepo = ref.watch(inventoryMovementRepositoryProvider);
  final syncService = ref.watch(syncServiceProvider);
  
  return BatchService(
    batchRepository: batchRepo,
    serialNumberRepository: serialRepo,
    movementRepository: movementRepo,
    syncService: syncService,
  );
});

final reportingServiceProvider = Provider<ReportingService>((ref) {
  final saleRepo = ref.watch(saleRepositoryProvider);
  final purchaseRepo = ref.watch(purchaseOrderRepositoryProvider);
  final movementRepo = ref.watch(inventoryMovementRepositoryProvider);
  final productRepo = ref.watch(productRepositoryProvider);
  final batchRepo = ref.watch(batchRepositoryProvider);
  
  return ReportingService(
    saleRepository: saleRepo,
    purchaseOrderRepository: purchaseRepo,
    movementRepository: movementRepo,
    productRepository: productRepo,
    batchRepository: batchRepo,
  );
});

final barcodeServiceProvider = Provider<BarcodeService>((ref) {
  final productRepo = ref.watch(productRepositoryProvider);
  final batchRepo = ref.watch(batchRepositoryProvider);
  final serialRepo = ref.watch(serialNumberRepositoryProvider);
  
  return BarcodeService(
    productRepository: productRepo,
    batchRepository: batchRepo,
    serialNumberRepository: serialRepo,
  );
});

final syncServiceProvider = Provider<SyncService?>((ref) {
  // Return null if sync is not enabled
  // This will be properly initialized during plugin initialization
  return null;
});