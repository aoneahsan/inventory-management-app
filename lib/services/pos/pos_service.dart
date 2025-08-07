import 'dart:convert';
import '../../domain/entities/sale.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/pos_settings.dart';
import '../../core/errors/exceptions.dart';
import '../database/database.dart';
import '../inventory/product_service.dart';
import '../sync/sync_service.dart';
import 'offline_pos_service.dart';

class POSService {
  final AppDatabase _database;
  final ProductService _productService;
  final SyncService _syncService;
  late final OfflinePOSService _offlinePOSService;

  POSService({
    required AppDatabase database,
    required ProductService productService,
    required SyncService syncService,
  })  : _database = database,
        _productService = productService,
        _syncService = syncService {
    _offlinePOSService = OfflinePOSService(
      database: database,
      syncService: syncService,
    );
    // Start auto-sync when service is created
    _offlinePOSService.startAutoSync();
  }

  // Cart Management
  final Map<String, CartItem> _cart = {};
  String? _currentCustomerId;
  double _discountAmount = 0;
  double _discountPercent = 0;

  List<CartItem> get cartItems => _cart.values.toList();
  double get subtotal => _cart.values.fold(0, (sum, item) => sum + item.totalAmount);
  double get discountTotal => _discountAmount > 0 ? _discountAmount : (subtotal * _discountPercent / 100);
  double get taxTotal => _cart.values.fold(0, (sum, item) => sum + item.taxAmount);
  double get total => subtotal - discountTotal + taxTotal;

  // Add item to cart
  Future<void> addToCart(Product product, {double quantity = 1}) async {
    final existingItem = _cart[product.id];
    
    if (existingItem != null) {
      _cart[product.id] = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );
    } else {
      final sellingPrice = product.sellingPrice ?? 0;
      final taxAmount = sellingPrice * (product.taxRate / 100) * quantity;
      _cart[product.id] = CartItem(
        productId: product.id,
        productName: product.name,
        quantity: quantity,
        unitPrice: sellingPrice,
        taxPercent: product.taxRate,
        taxAmount: taxAmount,
        totalAmount: (sellingPrice * quantity) + taxAmount,
      );
    }
    
    _recalculateCart();
  }

  // Update cart item quantity
  void updateQuantity(String productId, double quantity) {
    final item = _cart[productId];
    if (item == null) return;

    if (quantity <= 0) {
      _cart.remove(productId);
    } else {
      final taxAmount = item.unitPrice * (item.taxPercent / 100) * quantity;
      _cart[productId] = item.copyWith(
        quantity: quantity,
        taxAmount: taxAmount,
        totalAmount: (item.unitPrice * quantity) + taxAmount,
      );
    }
    
    _recalculateCart();
  }

  // Apply discount
  void applyDiscount({double? amount, double? percent}) {
    if (amount != null && amount >= 0) {
      _discountAmount = amount;
      _discountPercent = 0;
    } else if (percent != null && percent >= 0 && percent <= 100) {
      _discountPercent = percent;
      _discountAmount = 0;
    }
    _recalculateCart();
  }

  // Set customer
  void setCustomer(String? customerId) {
    _currentCustomerId = customerId;
  }

  // Clear cart
  void clearCart() {
    _cart.clear();
    _currentCustomerId = null;
    _discountAmount = 0;
    _discountPercent = 0;
  }

  // Process sale
  Future<Sale> processSale({
    required String organizationId,
    required String registerId,
    required String userId,
    required String paymentMethod,
    Map<String, double>? splitPayments,
    String? notes,
  }) async {
    if (_cart.isEmpty) {
      throw BusinessException(message: 'Cart is empty');
    }

    final db = await _database.database;
    final now = DateTime.now();
    final saleId = now.millisecondsSinceEpoch.toString();
    final receiptNumber = _generateReceiptNumber();
    
    // Check if online
    final isOnline = await _offlinePOSService.isOnline();

    // Create sale items
    final saleItems = _cart.values.map((item) {
      return SaleItem(
        id: '${saleId}_${item.productId}',
        saleId: saleId,
        productId: item.productId,
        productName: item.productName,
        quantity: item.quantity,
        unitPrice: item.unitPrice,
        discountAmount: 0,
        discountPercent: 0,
        taxAmount: item.taxAmount,
        taxPercent: item.taxPercent,
        totalAmount: item.totalAmount,
        createdAt: now,
      );
    }).toList();

    // Create sale
    final sale = Sale(
      id: saleId,
      organizationId: organizationId,
      registerId: registerId,
      userId: userId,
      customerId: _currentCustomerId,
      receiptNumber: receiptNumber,
      subtotal: subtotal,
      taxAmount: taxTotal,
      discountAmount: discountTotal,
      totalAmount: total,
      paymentMethod: paymentMethod,
      splitPayments: splitPayments,
      status: SaleStatus.completed,
      isOfflineSale: !isOnline,
      notes: notes,
      createdAt: now,
      items: saleItems,
    );

    // Save to database
    await db.transaction((txn) async {
      // Save sale
      await txn.insert('sales', {
        'id': sale.id,
        'organization_id': sale.organizationId,
        'register_id': sale.registerId,
        'user_id': sale.userId,
        'customer_id': sale.customerId,
        'receipt_number': sale.receiptNumber,
        'subtotal': sale.subtotal,
        'tax_amount': sale.taxAmount,
        'discount_amount': sale.discountAmount,
        'total_amount': sale.totalAmount,
        'payment_method': sale.paymentMethod,
        'split_payments': sale.splitPayments != null ? jsonEncode(sale.splitPayments) : null,
        'status': sale.status,
        'is_offline_sale': sale.isOfflineSale ? 1 : 0,
        'notes': sale.notes,
        'created_at': sale.createdAt.millisecondsSinceEpoch,
      });

      // Save sale items
      for (final item in saleItems) {
        await txn.insert('sale_items', {
          'id': item.id,
          'sale_id': item.saleId,
          'product_id': item.productId,
          'product_name': item.productName,
          'quantity': item.quantity,
          'unit_price': item.unitPrice,
          'discount_amount': item.discountAmount,
          'discount_percent': item.discountPercent,
          'tax_amount': item.taxAmount,
          'tax_percent': item.taxPercent,
          'total_amount': item.totalAmount,
          'created_at': item.createdAt.millisecondsSinceEpoch,
        });

        // Update product stock
        final product = await _productService.getProduct(item.productId);
        if (product != null) {
          await _productService.adjustStock(
            productId: item.productId,
            newQuantity: product.currentStock - item.quantity,
            reason: 'Sale #$receiptNumber',
            performedBy: userId,
          );
        }
      }
    });

    // Handle sync based on online status
    if (isOnline) {
      // Queue for sync immediately if online
      await _syncService.queueForSync('sales', 'create', sale.id, sale.toJson());
    } else {
      // Queue for offline sync
      await _offlinePOSService.queueSaleForSync(sale);
    }

    // Clear cart after successful sale
    clearCart();

    return sale;
  }

  // Get sales
  Future<List<Sale>> getSales(String organizationId, {
    String? registerId,
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
  }) async {
    final db = await _database.database;
    String query = 'SELECT * FROM sales WHERE organization_id = ?';
    List<dynamic> args = [organizationId];

    if (registerId != null) {
      query += ' AND register_id = ?';
      args.add(registerId);
    }

    if (startDate != null) {
      query += ' AND created_at >= ?';
      args.add(startDate.millisecondsSinceEpoch);
    }

    if (endDate != null) {
      query += ' AND created_at <= ?';
      args.add(endDate.millisecondsSinceEpoch);
    }

    query += ' ORDER BY created_at DESC';

    if (limit != null) {
      query += ' LIMIT ?';
      args.add(limit);
    }

    final results = await db.rawQuery(query, args);
    final sales = <Sale>[];

    for (final row in results) {
      final saleData = Map<String, dynamic>.from(row);
      
      // Get sale items
      final itemsResults = await db.query(
        'sale_items',
        where: 'sale_id = ?',
        whereArgs: [saleData['id']],
      );

      final items = itemsResults.map((itemRow) {
        final itemData = Map<String, dynamic>.from(itemRow);
        return SaleItem(
          id: itemData['id'],
          saleId: itemData['sale_id'],
          productId: itemData['product_id'],
          productName: itemData['product_name'],
          quantity: itemData['quantity'].toDouble(),
          unitPrice: itemData['unit_price'].toDouble(),
          discountAmount: itemData['discount_amount'].toDouble(),
          discountPercent: itemData['discount_percent'].toDouble(),
          taxAmount: itemData['tax_amount'].toDouble(),
          taxPercent: itemData['tax_percent'].toDouble(),
          totalAmount: itemData['total_amount'].toDouble(),
          createdAt: DateTime.fromMillisecondsSinceEpoch(itemData['created_at']),
        );
      }).toList();

      sales.add(Sale(
        id: saleData['id'],
        organizationId: saleData['organization_id'],
        registerId: saleData['register_id'],
        userId: saleData['user_id'],
        customerId: saleData['customer_id'],
        receiptNumber: saleData['receipt_number'],
        subtotal: saleData['subtotal'].toDouble(),
        taxAmount: saleData['tax_amount'].toDouble(),
        discountAmount: saleData['discount_amount'].toDouble(),
        totalAmount: saleData['total_amount'].toDouble(),
        paymentMethod: saleData['payment_method'],
        splitPayments: saleData['split_payments'] != null
            ? Map<String, double>.from(jsonDecode(saleData['split_payments']))
            : null,
        status: saleData['status'],
        isOfflineSale: saleData['is_offline_sale'] == 1,
        notes: saleData['notes'],
        createdAt: DateTime.fromMillisecondsSinceEpoch(saleData['created_at']),
        syncedAt: saleData['synced_at'] != null
            ? DateTime.fromMillisecondsSinceEpoch(saleData['synced_at'])
            : null,
        items: items,
      ));
    }

    return sales;
  }

  void _recalculateCart() {
    for (final entry in _cart.entries) {
      final item = entry.value;
      final taxAmount = item.unitPrice * (item.taxPercent / 100) * item.quantity;
      _cart[entry.key] = item.copyWith(
        taxAmount: taxAmount,
        totalAmount: (item.unitPrice * item.quantity) + taxAmount,
      );
    }
  }

  String _generateReceiptNumber() {
    final now = DateTime.now();
    return '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}'
        '${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}'
        '${now.second.toString().padLeft(2, '0')}${now.millisecond.toString().padLeft(3, '0')}';
  }

  // Get offline sync status
  Future<Map<String, dynamic>> getOfflineSyncStatus() async {
    final offlineSalesCount = await _offlinePOSService.getOfflineSalesCount();
    final syncQueueSize = await _offlinePOSService.getSyncQueueSize();
    final isOnline = await _offlinePOSService.isOnline();
    
    return {
      'isOnline': isOnline,
      'offlineSalesCount': offlineSalesCount,
      'pendingSyncItems': syncQueueSize,
    };
  }

  // Manually trigger sync
  Future<void> syncOfflineData() async {
    await _offlinePOSService.processSyncQueue();
  }
}

class CartItem {
  final String productId;
  final String productName;
  final double quantity;
  final double unitPrice;
  final double taxPercent;
  final double taxAmount;
  final double totalAmount;

  CartItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.taxPercent,
    required this.taxAmount,
    required this.totalAmount,
  });

  CartItem copyWith({
    double? quantity,
    double? taxAmount,
    double? totalAmount,
  }) {
    return CartItem(
      productId: productId,
      productName: productName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice,
      taxPercent: taxPercent,
      taxAmount: taxAmount ?? this.taxAmount,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}