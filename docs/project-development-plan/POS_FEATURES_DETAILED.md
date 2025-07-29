# POS System - Detailed Feature Specifications

## 1. Sale Transaction Management

### Sale Entity
```dart
class Sale {
  String id;
  String organizationId;
  String registerId;
  String userId;
  String? customerId;
  List<SaleItem> items;
  double subtotal;
  double taxAmount;
  double discountAmount;
  double totalAmount;
  String paymentMethod; // cash, card, upi, split
  Map<String, double>? splitPayments; // for split payments
  String status; // pending, completed, refunded, partial_refund
  String? refundReason;
  String receiptNumber;
  bool isOfflineSale;
  DateTime createdAt;
  DateTime? syncedAt;
}
```

### Sale Item Entity
```dart
class SaleItem {
  String productId;
  String productName;
  String? variantId;
  double quantity;
  double unitPrice;
  double discountAmount;
  double discountPercent;
  double taxAmount;
  double taxPercent;
  double totalAmount;
  String? notes;
}
```

## 2. Register Management

### Register Entity
```dart
class Register {
  String id;
  String organizationId;
  String name;
  String? location;
  double openingBalance;
  double currentBalance;
  double expectedBalance;
  String status; // open, closed, suspended
  String openedBy;
  DateTime openedAt;
  String? closedBy;
  DateTime? closedAt;
  Map<String, double> denominations; // cash denominations
  List<RegisterTransaction> transactions;
}
```

### Register Operations
- Open Register with opening balance
- Close Register with reconciliation
- Cash In/Out transactions
- Register reports
- Multiple register support

## 3. Receipt System

### Receipt Entity
```dart
class Receipt {
  String id;
  String saleId;
  String receiptNumber;
  String template; // default, minimal, detailed
  Map<String, dynamic> customFields;
  String format; // pdf, thermal, a4
  bool isPrinted;
  DateTime? printedAt;
  String? printerName;
  String? digitalReceipt; // email, whatsapp
}
```

### Receipt Features
- Customizable templates
- Multi-language receipts
- Digital receipt delivery
- Barcode/QR on receipt
- Return policy printing

## 4. Payment Processing

### Payment Methods
- **Cash**: With change calculation
- **Card**: Integration with card readers
- **UPI**: QR code generation
- **Digital Wallets**: Multiple wallet support
- **Split Payment**: Multiple methods per sale
- **Credit**: Customer credit tracking

### Payment Features
```dart
class PaymentProcessor {
  // Process different payment types
  Future<PaymentResult> processCashPayment(double amount, double tendered);
  Future<PaymentResult> processCardPayment(double amount, CardDetails card);
  Future<PaymentResult> processUPIPayment(double amount, String upiId);
  Future<PaymentResult> processSplitPayment(Map<String, double> splits);
  
  // Refund operations
  Future<RefundResult> processRefund(String saleId, double amount, String reason);
  Future<RefundResult> processPartialRefund(String saleId, List<String> itemIds);
}
```

## 5. Barcode Integration

### Scanning Features
- Camera-based scanning
- External scanner support
- Batch scanning mode
- Product lookup by barcode
- Generate barcodes for products
- Print barcode labels

### Implementation
```dart
class BarcodeService {
  // Scanning
  Future<String?> scanBarcode();
  Future<List<String>> batchScan();
  
  // Product lookup
  Future<Product?> findProductByBarcode(String barcode);
  
  // Generation
  String generateBarcode(String productId);
  Future<Uint8List> generateBarcodeImage(String barcode);
}
```

## 6. Offline Mode

### Offline Features
- Complete POS functionality offline
- Local transaction storage
- Automatic sync when online
- Conflict resolution
- Offline receipt printing

### Sync Management
```dart
class OfflinePOSManager {
  // Transaction queue
  Queue<Sale> offlineTransactions;
  
  // Save offline
  Future<void> saveOfflineSale(Sale sale);
  
  // Sync operations
  Future<void> syncOfflineTransactions();
  Future<void> resolveConflicts(List<Conflict> conflicts);
  
  // Status
  bool isOffline();
  int pendingTransactionCount();
}
```

## 7. Customer Integration

### Customer Features
- Quick customer search
- New customer creation
- Purchase history view
- Credit limit management
- Loyalty points
- Customer-specific pricing

### Customer Service
```dart
class POSCustomerService {
  // Customer operations
  Future<Customer?> searchCustomer(String query);
  Future<Customer> quickCreateCustomer(String name, String phone);
  
  // Credit management
  Future<double> getCustomerCredit(String customerId);
  Future<void> updateCustomerCredit(String customerId, double amount);
  
  // Loyalty
  Future<int> getCustomerPoints(String customerId);
  Future<void> addLoyaltyPoints(String customerId, int points);
  Future<void> redeemPoints(String customerId, int points);
}
```

## 8. Inventory Real-time Updates

### Stock Management
- Instant stock deduction
- Low stock alerts
- Stock verification
- Multi-location visibility
- Reserved stock handling

### Integration
```dart
class POSInventoryService {
  // Stock operations
  Future<bool> checkStockAvailability(String productId, double quantity);
  Future<void> deductStock(List<SaleItem> items);
  Future<void> restoreStock(List<SaleItem> items); // for refunds
  
  // Alerts
  Stream<LowStockAlert> lowStockAlerts();
  
  // Multi-location
  Future<Map<String, double>> getStockAcrossLocations(String productId);
}
```

## 9. Tax Management

### Tax Features
- GST compliance
- Tax rules by product/category
- Tax-inclusive/exclusive pricing
- Multiple tax rates
- Tax exemptions
- Tax reports

### Tax Service
```dart
class TaxService {
  // Tax calculation
  double calculateTax(Product product, double amount);
  Map<String, double> calculateMultipleTaxes(List<SaleItem> items);
  
  // Tax rules
  Future<TaxRule> getTaxRule(String productId);
  Future<void> updateTaxRule(String productId, TaxRule rule);
  
  // Reports
  Future<TaxReport> generateGSTReport(DateRange range);
  Future<TaxReport> generateTaxSummary(DateRange range);
}
```

## 10. Reporting Suite

### Report Types
1. **Sales Reports**
   - Daily sales summary
   - Hourly sales analysis
   - Sales by payment method
   - Sales by category
   - Sales by staff

2. **Financial Reports**
   - Cash flow statement
   - Revenue analysis
   - Profit margins
   - Discount impact
   - Tax collection

3. **Inventory Reports**
   - Stock movement
   - Fast/slow moving items
   - Reorder suggestions
   - Stock valuation

4. **Customer Reports**
   - Top customers
   - Customer segments
   - Credit outstanding
   - Loyalty analysis

## 11. Hardware Integration

### Supported Hardware
- **Receipt Printers**: Thermal, laser
- **Cash Drawers**: Automatic open
- **Barcode Scanners**: USB, Bluetooth
- **Card Readers**: Integrated terminals
- **Weighing Scales**: For weight-based items

### Hardware Service
```dart
class HardwareService {
  // Printer operations
  Future<bool> printReceipt(Receipt receipt);
  Future<List<Printer>> getAvailablePrinters();
  
  // Cash drawer
  Future<void> openCashDrawer();
  
  // Scanner
  Stream<String> barcodeStream(); // from external scanner
  
  // Scale
  Future<double> getWeight();
}
```

## 12. Mobile POS Features

### Mobile-specific
- Touch-optimized UI
- Gesture support
- Camera barcode scanning
- Mobile receipt printing
- GPS location tracking
- Offline-first design

### Field Sales
- Route planning
- Customer visit tracking
- Van inventory management
- Order collection
- Instant invoicing
- Payment collection

---
Created: 2025-07-29
Status: Detailed Specifications Complete