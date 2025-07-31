# Inventory Management Plugin - API Documentation

## Table of Contents
1. [Core Services](#core-services)
2. [Entities](#entities)
3. [Repositories](#repositories)
4. [UI Components](#ui-components)
5. [Configuration](#configuration)
6. [Error Handling](#error-handling)

## Core Services

### ProductService

Manages all product-related operations.

#### Methods

##### createProduct
```dart
Future<Product> createProduct(Product product)
```
Creates a new product in the database.

**Parameters:**
- `product`: Product entity with required fields

**Returns:** Created Product with generated ID

**Throws:**
- `ValidationException`: If product data is invalid
- `DatabaseException`: If database operation fails

##### updateProduct
```dart
Future<Product> updateProduct(Product product)
```
Updates an existing product.

**Parameters:**
- `product`: Product entity with updated values

**Returns:** Updated Product entity

##### deleteProduct
```dart
Future<void> deleteProduct(String productId)
```
Deletes a product by ID.

**Parameters:**
- `productId`: Unique identifier of the product

##### getProducts
```dart
Future<List<Product>> getProducts()
```
Retrieves all products.

**Returns:** List of all products

##### searchProducts
```dart
Future<List<Product>> searchProducts(String query)
```
Searches products by name, SKU, or barcode.

**Parameters:**
- `query`: Search term

**Returns:** List of matching products

##### getProductWithStock
```dart
Future<(Product, double)?> getProductWithStock(String productId)
```
Gets product with current stock level.

**Parameters:**
- `productId`: Product identifier

**Returns:** Tuple of Product and stock level, or null if not found

### CategoryService

Manages product categories with hierarchical support.

#### Methods

##### createCategory
```dart
Future<Category> createCategory(Category category)
```
Creates a new category.

##### getCategoryTree
```dart
Future<List<Category>> getCategoryTree()
```
Gets all categories in tree structure.

##### moveCategory
```dart
Future<void> moveCategory(String categoryId, String? newParentId)
```
Moves category to new parent.

### InventoryMovementService

Tracks all inventory changes.

#### Methods

##### recordMovement
```dart
Future<InventoryMovement> recordMovement({
  required String productId,
  required String branchId,
  required double quantity,
  required MovementType type,
  required String reason,
  String? referenceId,
  String? notes,
})
```
Records an inventory movement.

**Parameters:**
- `productId`: Product being moved
- `branchId`: Branch where movement occurs
- `quantity`: Amount moved (positive or negative)
- `type`: Type of movement (in/out/adjustment)
- `reason`: Reason for movement
- `referenceId`: Optional reference (e.g., sale ID)
- `notes`: Optional notes

### POSService

Point of Sale operations.

#### Methods

##### processSale
```dart
Future<Sale> processSale({
  required List<SaleItem> items,
  required String paymentMethod,
  String? customerId,
  double? discountAmount,
  String? notes,
})
```
Processes a complete sale transaction.

**Parameters:**
- `items`: List of items being sold
- `paymentMethod`: Payment method used
- `customerId`: Optional customer ID
- `discountAmount`: Optional discount
- `notes`: Optional notes

**Returns:** Completed Sale entity

##### generateReceipt
```dart
Future<Receipt> generateReceipt(String saleId)
```
Generates receipt for a sale.

##### voidSale
```dart
Future<void> voidSale(String saleId, String reason)
```
Voids a completed sale.

### TaxService

Tax calculation and management.

#### Methods

##### calculateTax
```dart
Future<double> calculateTax({
  required double amount,
  required List<String> applicableTaxIds,
  bool includeCompound = true,
})
```
Calculates total tax for an amount.

##### createTaxRate
```dart
Future<TaxRate> createTaxRate(TaxRate taxRate)
```
Creates a new tax rate.

### StockTransferService

Inter-branch stock transfers.

#### Methods

##### initiateTransfer
```dart
Future<StockTransfer> initiateTransfer({
  required String fromBranchId,
  required String toBranchId,
  required List<StockTransferItem> items,
  required String userId,
  String? notes,
})
```
Initiates a stock transfer between branches.

##### approveTransfer
```dart
Future<StockTransfer> approveTransfer(String transferId, String approverId)
```
Approves a pending transfer.

##### receiveTransfer
```dart
Future<StockTransfer> receiveTransfer(
  String transferId,
  String receiverId,
  Map<String, double> receivedQuantities,
)
```
Marks transfer as received with actual quantities.

### BatchService

Batch and serial number tracking.

#### Methods

##### createBatch
```dart
Future<Batch> createBatch(Batch batch)
```
Creates a new batch.

##### allocateBatchQuantity
```dart
Future<List<Batch>> allocateBatchQuantity({
  required String productId,
  required String branchId,
  required double requiredQuantity,
  String? preferredBatchId,
  bool useFifo = true,
})
```
Allocates quantity from available batches using FIFO/LIFO.

##### registerSerialNumbers
```dart
Future<void> registerSerialNumbers({
  required String productId,
  required List<String> serialNumbers,
  String? batchId,
  String? branchId,
})
```
Registers new serial numbers.

### BarcodeService

Barcode generation and parsing.

#### Methods

##### generateBarcode
```dart
Future<String> generateBarcode({
  required BarcodeType type,
  required String data,
  BarcodeFormat format = BarcodeFormat.code128,
})
```
Generates barcode string.

##### parseBarcode
```dart
Future<BarcodeParseResult?> parseBarcode(String barcodeData)
```
Parses scanned barcode data.

### ReportingService

Report generation.

#### Methods

##### generateSalesReport
```dart
Future<SalesReport> generateSalesReport({
  required DateTime startDate,
  required DateTime endDate,
  String? branchId,
  String? customerId,
  String? userId,
})
```
Generates sales report for date range.

##### generateInventoryReport
```dart
Future<InventoryReport> generateInventoryReport({
  DateTime? asOfDate,
  String? branchId,
  String? categoryId,
  bool includeZeroStock = false,
})
```
Generates inventory valuation report.

## Entities

### Product
```dart
class Product {
  final String id;
  final String name;
  final String? sku;
  final String? barcode;
  final String? description;
  final String? categoryId;
  final String? imageUrl;
  final double? purchasePrice;
  final double? sellingPrice;
  final String? unit;
  final double? reorderLevel;
  final double? reorderQuantity;
  final bool trackStock;
  final bool trackBatches;
  final bool trackSerialNumbers;
  final bool isActive;
  final Map<String, dynamic>? customFields;
  final DateTime createdAt;
  final DateTime updatedAt;
}
```

### Sale
```dart
class Sale {
  final String id;
  final String saleNumber;
  final DateTime saleDate;
  final String branchId;
  final String? customerId;
  final String? userId;
  final List<SaleItem> items;
  final double subtotal;
  final double taxAmount;
  final double discountAmount;
  final double totalAmount;
  final String paymentMethod;
  final String status;
  final String? notes;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
}
```

### Branch
```dart
class Branch {
  final String id;
  final String name;
  final BranchType type;
  final String? code;
  final String? address;
  final String? phone;
  final String? email;
  final String? managerId;
  final bool isActive;
  final Map<String, dynamic>? settings;
  final DateTime createdAt;
  final DateTime updatedAt;
}
```

### TaxRate
```dart
class TaxRate {
  final String id;
  final String name;
  final double rate;
  final TaxType type;
  final String? hsnCode;
  final bool isCompound;
  final bool isActive;
  final DateTime? effectiveFrom;
  final DateTime? effectiveTo;
  final DateTime createdAt;
  final DateTime updatedAt;
}
```

## Repositories

All repositories follow a common interface pattern:

```dart
abstract class Repository<T> {
  Future<T> create(T entity);
  Future<T?> getById(String id);
  Future<T> update(T entity);
  Future<void> delete(String id);
  Future<List<T>> getAll();
  Stream<List<T>> watchAll();
}
```

### ProductRepository
Additional methods:
- `searchProducts(String query)`
- `getByCategory(String categoryId)`
- `getLowStockProducts()`
- `getCurrentStock(String productId)`

### SaleRepository
Additional methods:
- `getByDateRange(DateTime start, DateTime end)`
- `getByCustomer(String customerId)`
- `getByPaymentMethod(String method)`
- `getTotalSales(DateTime start, DateTime end)`

## UI Components

### ProductCard
```dart
ProductCard({
  required Product product,
  double? stockLevel,
  bool showStock = true,
  bool showActions = false,
  VoidCallback? onTap,
  VoidCallback? onEdit,
  VoidCallback? onDelete,
})
```

### BarcodeScannerWidget
```dart
BarcodeScannerWidget({
  required void Function(String) onScan,
  void Function(String)? onError,
  bool continuousMode = false,
  bool showTorchButton = true,
  bool showSwitchCameraButton = true,
})
```

### InventorySearchBar
```dart
InventorySearchBar({
  String? hintText,
  required void Function(String) onSearch,
  void Function(Map<String, dynamic>)? onFiltersChanged,
  List<SearchFilter>? filters,
  Duration debounceTime = const Duration(milliseconds: 500),
})
```

### StockLevelBadge
```dart
StockLevelBadge({
  required double currentStock,
  double? reorderLevel,
  String? unit,
  bool showQuantity = true,
})
```

## Configuration

### InventoryPluginConfig
```dart
class InventoryPluginConfig {
  final String appName;
  final String databaseName;
  final int databaseVersion;
  final DatabaseAdapter databaseAdapter;
  final StorageAdapter storageAdapter;
  final SimpleAuthAdapter? authAdapter;
  final FeatureConfig features;
  final bool enableOfflineSync;
  final Duration syncInterval;
  final int maxSyncRetries;
  final bool requireAuthentication;
  final ThemeConfig? themeConfig;
  final String defaultLanguage;
  final List<String> supportedLanguages;
}
```

### FeatureConfig
```dart
class FeatureConfig {
  final bool enableProducts;
  final bool enableCategories;
  final bool enableInventoryTracking;
  final bool enableBarcodeScanning;
  final bool enablePOS;
  final bool enableSuppliers;
  final bool enableCustomers;
  final bool enableReports;
  final bool enableMultiBranch;
  final bool enableBatchTracking;
  final bool enableSerialTracking;
  final bool enableStockTransfer;
  final bool enablePurchaseOrders;
  final bool enableTaxManagement;
}
```

## Error Handling

### BusinessException
Base class for all business logic exceptions.

```dart
class BusinessException implements Exception {
  final String message;
  final String? code;
  final dynamic details;
}
```

### Specific Exceptions

#### ValidationException
Thrown when input validation fails.
```dart
throw ValidationException('Product name is required');
```

#### PermissionException
Thrown when user lacks required permissions.
```dart
throw PermissionException('Insufficient permissions to delete product');
```

#### NetworkException
Thrown when network operations fail.
```dart
throw NetworkException('Unable to sync data');
```

#### StockException
Thrown for inventory-related errors.
```dart
throw StockException('Insufficient stock available');
```

## Best Practices

1. **Always handle errors gracefully**
   ```dart
   try {
     await productService.createProduct(product);
   } on ValidationException catch (e) {
     showError(e.message);
   }
   ```

2. **Use streams for real-time updates**
   ```dart
   ref.watch(productsStreamProvider).when(
     data: (products) => ProductList(products),
     loading: () => CircularProgressIndicator(),
     error: (e, s) => ErrorWidget(e),
   );
   ```

3. **Leverage offline capabilities**
   ```dart
   // All operations work offline
   final product = await productService.createProduct(...);
   // Syncs automatically when online
   ```

4. **Follow repository pattern**
   ```dart
   // Use repositories through services
   final products = await productService.getProducts();
   // Not: await productRepository.getAll();
   ```