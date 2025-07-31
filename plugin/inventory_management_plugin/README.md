# Inventory Management Plugin

A comprehensive Flutter plugin for building inventory management applications with offline-first capabilities, multi-branch support, and advanced features like barcode scanning, POS, and tax management.

## Features

- 📦 **Product Management** - Complete CRUD operations with variants, categories, and custom fields
- 🏪 **Multi-Branch Support** - Manage inventory across multiple locations
- 📊 **Real-time Analytics** - Sales reports, inventory insights, and business metrics
- 🔄 **Offline-First** - Work without internet, automatic sync when connected
- 📱 **Barcode Support** - Scan and generate barcodes for products
- 💰 **Point of Sale** - Complete POS system with payment processing
- 🧾 **Tax Management** - GST/VAT support with compound tax calculations
- 📦 **Batch & Serial Tracking** - Track products by batch numbers and serial numbers
- 🚚 **Stock Transfers** - Inter-branch transfers with approval workflow
- 📈 **Advanced Reporting** - Comprehensive reports with PDF export

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  inventory_management_plugin: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Platform Support

| Platform | Status | Notes |
|----------|--------|-------|
| Android | ✅ | Full support |
| iOS | ✅ | Full support |
| Web | ✅ | Full support (except native barcode scanning) |
| Windows | 🚧 | Coming soon |
| macOS | 🚧 | Coming soon |
| Linux | 🚧 | Coming soon |

## Quick Start

### 1. Initialize the Plugin

```dart
import 'package:inventory_management_plugin/inventory_management_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configure the plugin
  final prefs = await SharedPreferences.getInstance();
  final config = InventoryPluginConfig(
    appName: 'My Inventory App',
    databaseAdapter: SqfliteAdapter(),
    storageAdapter: SharedPreferencesAdapter(prefs),
    enableOfflineSync: true,
    enableMultiBranch: true,
    features: FeatureConfig(
      enableProducts: true,
      enableCategories: true,
      enableInventoryTracking: true,
      enableBarcodeScanning: true,
      enablePOS: true,
      enableSuppliers: true,
      enableCustomers: true,
      enableReports: true,
      enableMultiBranch: true,
      enableBatchTracking: true,
      enableSerialTracking: true,
      enableStockTransfer: true,
      enablePurchaseOrders: true,
      enableTaxManagement: true,
    ),
  );
  
  // Initialize the plugin
  await InventoryManagementPlugin.initialize(config);
  
  runApp(MyApp());
}
```

### 2. Create Your App

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InventoryManagementPlugin.createApp(
      title: 'My Inventory App',
      home: HomeScreen(),
    );
  }
}
```

### 3. Use Services

```dart
// Product Management
final productService = ref.read(productServiceProvider);

// Create a product
final product = await productService.createProduct(Product(
  id: DateTime.now().millisecondsSinceEpoch.toString(),
  name: 'Sample Product',
  sku: 'SKU001',
  sellingPrice: 99.99,
  trackStock: true,
  reorderLevel: 10,
));

// Search products
final products = await productService.searchProducts('sample');

// Get product with stock info
final productWithStock = await productService.getProductWithStock(product.id);
```

## Core Concepts

### 1. Offline-First Architecture

The plugin uses a local SQLite database (via Drift) for all operations, ensuring your app works without internet:

```dart
// All operations work offline
final sale = await posService.processSale(
  items: cartItems,
  paymentMethod: 'cash',
);

// Data syncs automatically when online
// Or trigger manual sync
await syncService.syncAll();
```

### 2. Multi-Branch Management

Manage inventory across multiple locations:

```dart
// Create branches
final branch = await branchService.createBranch(Branch(
  name: 'Main Store',
  type: BranchType.store,
  address: '123 Main St',
));

// Transfer stock between branches
final transfer = await stockTransferService.initiateTransfer(
  fromBranchId: branch1.id,
  toBranchId: branch2.id,
  items: transferItems,
);
```

### 3. Barcode Integration

Scan and generate barcodes:

```dart
// Scan barcode
BarcodeScannerWidget(
  onScan: (barcode) async {
    final result = await barcodeService.parseBarcode(barcode);
    if (result?.product != null) {
      // Handle scanned product
    }
  },
);

// Generate barcode
final barcode = await barcodeService.generateBarcode(
  type: BarcodeType.product,
  data: product.id,
);
```

### 4. Point of Sale

Complete POS functionality:

```dart
// Process a sale
final sale = await posService.processSale(
  items: [
    SaleItem(
      productId: product.id,
      quantity: 2,
      unitPrice: product.sellingPrice!,
    ),
  ],
  paymentMethod: 'credit_card',
  customerId: customer?.id,
);

// Generate receipt
final receipt = await posService.generateReceipt(sale.id);
```

### 5. Advanced Inventory Features

#### Batch Tracking

```dart
// Create batch
final batch = await batchService.createBatch(Batch(
  batchNumber: 'BATCH001',
  productId: product.id,
  quantity: 100,
  expiryDate: DateTime.now().add(Duration(days: 365)),
));

// Allocate from batch (FIFO/LIFO)
final allocatedBatches = await batchService.allocateBatchQuantity(
  productId: product.id,
  branchId: branch.id,
  requiredQuantity: 50,
  useFifo: true,
);
```

#### Serial Number Tracking

```dart
// Register serial numbers
await batchService.registerSerialNumbers(
  productId: product.id,
  serialNumbers: ['SN001', 'SN002', 'SN003'],
  batchId: batch.id,
);

// Track serial number in sale
await batchService.markSerialNumberAsSold('SN001', sale.id);
```

## UI Components

The plugin provides ready-to-use UI components:

### Product Card

```dart
ProductCard(
  product: product,
  stockLevel: 45.0,
  showActions: true,
  onTap: () => showProductDetails(product),
  onEdit: () => editProduct(product),
  onDelete: () => deleteProduct(product),
)
```

### Barcode Scanner

```dart
BarcodeScannerButton(
  barcodeService: barcodeService,
  onScanned: (result) {
    if (result.type == BarcodeType.product) {
      addToCart(result.product!);
    }
  },
)
```

### Search Bar

```dart
InventorySearchBar(
  hintText: 'Search products...',
  onSearch: (query) => searchProducts(query),
  onFiltersChanged: (filters) => applyFilters(filters),
  filters: [
    SearchFilter(
      key: 'category',
      label: 'Category',
      type: FilterType.select,
      options: categories,
    ),
  ],
)
```

## Services

### Product Service
- Create, update, delete products
- Search with filters
- Bulk operations
- Stock management

### Category Service
- Hierarchical categories
- Parent-child relationships
- Category statistics

### Inventory Movement Service
- Track all stock changes
- Movement history
- Reason tracking
- Audit trail

### POS Service
- Process sales
- Payment methods
- Receipt generation
- Register management

### Tax Service
- Tax rate management
- Compound tax support
- GST/VAT calculations
- HSN code support

### Reporting Service
- Sales reports
- Inventory reports
- Purchase reports
- Expiry reports
- Custom date ranges

### Stock Transfer Service
- Inter-branch transfers
- Approval workflow
- Transfer tracking
- Automatic inventory updates

### Batch Service
- Batch creation
- FIFO/LIFO allocation
- Expiry tracking
- Serial number management

### Barcode Service
- Barcode generation
- QR code support
- Barcode parsing
- Product lookup

## Configuration Options

```dart
InventoryPluginConfig(
  // Basic Configuration
  appName: 'My Inventory App',
  databaseName: 'inventory.db',
  databaseVersion: 1,
  
  // Features
  features: FeatureConfig(
    enableProducts: true,
    enableCategories: true,
    enableInventoryTracking: true,
    enableBarcodeScanning: true,
    enablePOS: true,
    enableSuppliers: true,
    enableCustomers: true,
    enableReports: true,
    enableMultiBranch: true,
    enableBatchTracking: true,
    enableSerialTracking: true,
    enableStockTransfer: true,
    enablePurchaseOrders: true,
    enableTaxManagement: true,
  ),
  
  // Sync Configuration
  enableOfflineSync: true,
  syncInterval: Duration(minutes: 5),
  maxSyncRetries: 3,
  
  // Theme Configuration
  themeConfig: ThemeConfig(
    primaryColor: '#2196F3',
    useMaterial3: true,
    enableDarkMode: true,
    fontFamily: 'Roboto',
  ),
  
  // Authentication (Optional)
  requireAuthentication: true,
  authAdapter: MyAuthAdapter(),
  
  // Localization
  defaultLanguage: 'en',
  supportedLanguages: ['en', 'es', 'fr'],
)
```

## State Management

The plugin uses Riverpod for state management. Access providers easily:

```dart
// In a ConsumerWidget
final products = ref.watch(productsProvider(searchQuery, filters));
final productService = ref.read(productServiceProvider);
final stockLevel = ref.watch(productStockProvider(productId));
```

## Error Handling

The plugin provides comprehensive error handling:

```dart
try {
  await productService.createProduct(product);
} on ValidationException catch (e) {
  // Handle validation errors
  showError(e.message);
} on NetworkException catch (e) {
  // Handle network errors
  showOfflineMessage();
} on PermissionException catch (e) {
  // Handle permission errors
  showPermissionDenied();
}
```

## Example App

Check out the complete example app in the `example` directory:

```bash
cd example
flutter run
```

The example demonstrates:
- Product management with search and filters
- POS system with cart and checkout
- Inventory tracking and movements
- Multi-branch stock transfers
- Reporting and analytics
- Barcode scanning
- Offline functionality

## Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

## License

This plugin is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Support

- 📧 Email: support@inventoryplugin.com
- 💬 Discord: [Join our community](https://discord.gg/inventory)
- 📚 Documentation: [Full docs](https://docs.inventoryplugin.com)
- 🐛 Issues: [GitHub Issues](https://github.com/yourusername/inventory_management_plugin/issues)

## Acknowledgments

This plugin is built with:
- Flutter & Dart
- Drift (SQLite)
- Riverpod
- Mobile Scanner
- PDF Generation

Special thanks to all contributors and the Flutter community!