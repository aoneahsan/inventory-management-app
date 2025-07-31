# Inventory Management Plugin - Example App

This example demonstrates how to use the Inventory Management Plugin to build a complete inventory management application.

## Features Demonstrated

- ✅ Product management with search and filtering
- ✅ Point of Sale (POS) system
- ✅ Inventory tracking and movements
- ✅ Multi-branch support
- ✅ Reporting and analytics
- ✅ Barcode scanning
- ✅ Offline functionality

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / Xcode (for mobile development)

### Running the Example

1. Navigate to the example directory:
   ```bash
   cd example
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   # For web
   flutter run -d chrome
   
   # For iOS
   flutter run -d ios
   
   # For Android
   flutter run -d android
   ```

## Project Structure

```
example/
├── lib/
│   ├── main.dart              # App entry point and configuration
│   ├── screens/
│   │   ├── home_screen.dart   # Dashboard with metrics
│   │   ├── products_screen.dart # Product management
│   │   ├── pos_screen.dart    # Point of sale
│   │   ├── inventory_screen.dart # Stock management
│   │   └── reports_screen.dart # Analytics and reports
│   └── providers/
│       └── product_providers.dart # State management
├── pubspec.yaml
└── README.md
```

## Key Implementation Examples

### 1. Plugin Initialization

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();
  final config = InventoryPluginConfig(
    appName: 'Inventory Manager Demo',
    databaseAdapter: SqfliteAdapter(),
    storageAdapter: SharedPreferencesAdapter(prefs),
    enableOfflineSync: true,
    features: FeatureConfig(
      enableProducts: true,
      enablePOS: true,
      enableReports: true,
      // ... other features
    ),
  );
  
  await InventoryManagementPlugin.initialize(config);
  runApp(MyApp());
}
```

### 2. Product Management

The products screen demonstrates:
- Grid and list view toggle
- Search with debouncing
- Advanced filtering (category, stock status, price range)
- Barcode scanning integration
- Product CRUD operations

```dart
// Search and filter products
final products = ref.watch(productsProvider(searchQuery, filters));

// Barcode scanning
BarcodeScannerButton(
  barcodeService: barcodeService,
  onScanned: (result) {
    if (result.type == BarcodeType.product) {
      _showProductDetails(result.product!);
    }
  },
)
```

### 3. Point of Sale

The POS screen shows:
- Product grid with search
- Shopping cart management
- Checkout process
- Payment processing
- Receipt generation

```dart
// Process sale
final sale = await posService.processSale(
  items: cartItems,
  paymentMethod: selectedPaymentMethod,
  customerId: selectedCustomer?.id,
);
```

### 4. Inventory Management

The inventory screen includes:
- Stock level monitoring
- Movement history
- Stock transfers between branches
- Low stock alerts

### 5. Reporting

The reports screen demonstrates:
- Date range selection
- Sales analytics
- Inventory reports
- Export functionality
- Visual charts (placeholder for actual implementation)

## State Management

The example uses Riverpod for state management:

### Product Providers

```dart
// Products list with search and filters
final productsProvider = FutureProvider.family<
  List<Product>, 
  (String, Map<String, dynamic>)
>((ref, params) async {
  final (searchQuery, filters) = params;
  // Implementation
});

// Single product stock level
final productStockProvider = FutureProvider.family<double, String>(
  (ref, productId) async {
    // Get stock level
  }
);
```

## Offline Support

The app works completely offline:

1. All data is stored locally using SQLite
2. Changes sync automatically when online
3. Sync status is displayed in the UI
4. Manual sync can be triggered

## Customization

### Theme Customization

```dart
final config = InventoryPluginConfig(
  themeConfig: ThemeConfig(
    primaryColor: '#2196F3',
    useMaterial3: true,
    enableDarkMode: true,
  ),
);
```

### Feature Toggle

Enable/disable features based on your needs:

```dart
features: FeatureConfig(
  enableProducts: true,
  enablePOS: true,
  enableBarcodeScanning: false, // Disable if not needed
  // ... other features
),
```

## Best Practices Demonstrated

1. **Error Handling**
   ```dart
   products.when(
     data: (list) => ProductGrid(list),
     loading: () => CircularProgressIndicator(),
     error: (error, stack) => ErrorWidget(error),
   );
   ```

2. **Responsive Design**
   - Grid view adapts to screen size
   - POS layout changes for tablet/desktop
   - Mobile-first approach

3. **Performance**
   - Lazy loading of products
   - Image caching
   - Debounced search
   - Efficient state management

## Testing the Example

### Manual Testing Checklist

1. **Products**
   - [ ] Create new product
   - [ ] Edit existing product
   - [ ] Delete product
   - [ ] Search products
   - [ ] Filter by category
   - [ ] Scan barcode

2. **POS**
   - [ ] Add items to cart
   - [ ] Update quantities
   - [ ] Apply discounts
   - [ ] Process payment
   - [ ] Generate receipt

3. **Inventory**
   - [ ] View stock levels
   - [ ] Track movements
   - [ ] Create transfers

4. **Reports**
   - [ ] Generate sales report
   - [ ] View analytics
   - [ ] Export data

### Automated Tests

Run the example tests:

```bash
flutter test
```

## Troubleshooting

### Common Issues

1. **Database not initialized**
   - Ensure `InventoryManagementPlugin.initialize()` is called before app start

2. **Barcode scanner not working**
   - Check camera permissions
   - For web, ensure HTTPS is used

3. **Sync not working**
   - Check network connectivity
   - Verify sync service is initialized

## Next Steps

1. **Customize the UI**
   - Modify screens to match your brand
   - Add custom features

2. **Integrate with Backend**
   - Implement custom sync adapter
   - Connect to your API

3. **Add Features**
   - Implement missing features
   - Extend existing functionality

4. **Deploy**
   - Build for production
   - Configure app signing
   - Submit to app stores

## Resources

- [Plugin Documentation](../README.md)
- [API Reference](../API_DOCUMENTATION.md)
- [Flutter Documentation](https://docs.flutter.dev)
- [Riverpod Documentation](https://riverpod.dev)

## Support

For issues or questions:
- Create an issue on GitHub
- Check existing documentation
- Contact support team