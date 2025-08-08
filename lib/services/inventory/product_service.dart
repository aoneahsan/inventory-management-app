import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/inventory_movement.dart';
import '../../core/errors/exceptions.dart';
import '../database/database.dart';
import '../notification/email_sms_service.dart';
import '../notification/push_notification_service.dart';

class ProductService {
  final FirebaseFirestore _firestore;
  final AppDatabase _database;
  final EmailSmsService _emailSmsService;
  final PushNotificationService _pushNotificationService;

  ProductService({
    FirebaseFirestore? firestore,
    AppDatabase? database,
    EmailSmsService? emailSmsService,
    PushNotificationService? pushNotificationService,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _database = database ?? AppDatabase.instance,
        _emailSmsService = emailSmsService ?? EmailSmsService(),
        _pushNotificationService = pushNotificationService ?? PushNotificationService();

  // Product CRUD operations
  Future<List<Product>> getProducts(
    String organizationId, {
    String? categoryId,
    String? searchQuery,
    bool? lowStockOnly,
    int? limit,
    int? offset,
  }) async {
    try {
      // Try to get from local database first
      final localProducts = await _database.getProducts(
        organizationId,
        categoryId: categoryId,
        searchQuery: searchQuery,
        limit: limit,
        offset: offset,
      );

      // Filter for low stock if requested
      var products = localProducts.map((p) => Product.fromJson(p)).toList();
      
      if (lowStockOnly == true) {
        products = products.where((p) => p.isLowStock).toList();
      }

      return products;
    } catch (e) {
      throw BusinessException(message: 'Failed to load products: $e');
    }
  }

  Future<Product?> getProduct(String productId) async {
    try {
      // Try local database first
      final localProduct = await _database.getProducts(
        '', // organizationId not needed for single product
        searchQuery: productId,
        limit: 1,
      );

      if (localProduct.isNotEmpty) {
        return Product.fromJson(localProduct.first);
      }

      // Fallback to Firestore
      final doc = await _firestore.collection('products').doc(productId).get();
      if (doc.exists) {
        final product = Product.fromJson({...doc.data()!, 'id': doc.id});
        
        // Save to local database
        await _database.createProduct(product.toJson());
        
        return product;
      }

      return null;
    } catch (e) {
      throw BusinessException(message: 'Failed to load product: $e');
    }
  }

  Future<Product> createProduct({
    required String organizationId,
    required String name,
    required String sku,
    required String unit,
    String? barcode,
    String? description,
    String? categoryId,
    double initialStock = 0,
    double minStock = 0,
    double? maxStock,
    double? reorderPoint,
    double? reorderQuantity,
    double? costPrice,
    double? sellingPrice,
    double taxRate = 0,
    String? warehouseLocation,
    String? supplierId,
    String? imageUrl,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      // Check for duplicate SKU
      final existingProducts = await _database.getProducts(
        organizationId,
        searchQuery: sku,
      );
      
      if (existingProducts.any((p) => p['sku'] == sku)) {
        throw BusinessException(message: 'Product with SKU $sku already exists');
      }

      final now = DateTime.now();
      final product = Product(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        organizationId: organizationId,
        name: name,
        sku: sku,
        barcode: barcode,
        description: description,
        categoryId: categoryId,
        unit: unit,
        currentStock: initialStock,
        minStock: minStock,
        maxStock: maxStock,
        reorderPoint: reorderPoint,
        reorderQuantity: reorderQuantity,
        costPrice: costPrice,
        sellingPrice: sellingPrice,
        taxRate: taxRate,
        warehouseLocation: warehouseLocation,
        supplierId: supplierId,
        imageUrl: imageUrl,
        metadata: metadata ?? {},
        createdAt: now,
        updatedAt: now,
      );

      // Save to local database
      final productId = await _database.createProduct(product.toJson());
      
      // Add to sync queue for Firestore
      await _database.addToSyncQueue(
        'products',
        'create',
        productId,
        product.toJson(),
      );

      // If initial stock > 0, record movement
      if (initialStock > 0) {
        await recordInventoryMovement(
          productId: productId,
          type: MovementType.purchase,
          quantity: initialStock,
          unitCost: costPrice,
          reason: 'Initial stock',
          performedBy: 'system',
        );
      }

      return product.copyWith(id: productId);
    } catch (e) {
      if (e is BusinessException) rethrow;
      throw BusinessException(message: 'Failed to create product: $e');
    }
  }

  Future<void> updateProduct(
    String productId,
    Map<String, dynamic> updates,
  ) async {
    try {
      updates['updated_at'] = DateTime.now().toIso8601String();
      
      // Update local database
      await _database.updateProduct(productId, updates);
      
      // Add to sync queue
      await _database.addToSyncQueue(
        'products',
        'update',
        productId,
        updates,
      );
    } catch (e) {
      throw BusinessException(message: 'Failed to update product: $e');
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      // Soft delete by marking as inactive
      await updateProduct(productId, {'is_active': false});
    } catch (e) {
      throw BusinessException(message: 'Failed to delete product: $e');
    }
  }

  // Inventory management
  Future<void> recordInventoryMovement({
    required String productId,
    required MovementType type,
    required double quantity,
    double? unitCost,
    String? reason,
    String? referenceNumber,
    String? fromWarehouse,
    String? toWarehouse,
    required String performedBy,
    String? notes,
  }) async {
    try {
      final product = await getProduct(productId);
      if (product == null) {
        throw BusinessException(message: 'Product not found');
      }

      // Validate quantity
      if (quantity <= 0) {
        throw BusinessException(message: 'Quantity must be greater than 0');
      }

      // Check if outgoing movement has sufficient stock
      if (type == MovementType.sale || 
          type == MovementType.damage || 
          type == MovementType.expired) {
        if (product.currentStock < quantity) {
          throw BusinessException(message: 'Insufficient stock. Available: ${product.currentStock}');
        }
      }

      final movement = InventoryMovement(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        organizationId: product.organizationId,
        productId: productId,
        type: type,
        quantity: quantity,
        unitCost: unitCost ?? product.costPrice,
        totalCost: quantity * (unitCost ?? product.costPrice ?? 0),
        reason: reason,
        referenceNumber: referenceNumber,
        fromWarehouse: fromWarehouse,
        toWarehouse: toWarehouse,
        performedBy: performedBy,
        notes: notes,
        createdAt: DateTime.now(),
      );

      // Record movement (this also updates stock)
      await _database.recordInventoryMovement(movement.toJson());
      
      // Add to sync queue
      await _database.addToSyncQueue(
        'inventory_movements',
        'create',
        movement.id,
        movement.toJson(),
      );
      
      // Check if stock went low after this movement
      if (type == MovementType.sale || 
          type == MovementType.damage || 
          type == MovementType.expired) {
        await _checkAndSendLowStockNotification(product, quantity);
      }
    } catch (e) {
      if (e is BusinessException) rethrow;
      throw BusinessException(message: 'Failed to record inventory movement: $e');
    }
  }

  Future<void> adjustStock({
    required String productId,
    required double newQuantity,
    required String reason,
    required String performedBy,
    String? notes,
  }) async {
    try {
      final product = await getProduct(productId);
      if (product == null) {
        throw BusinessException(message: 'Product not found');
      }

      final difference = newQuantity - product.currentStock;
      if (difference == 0) return;

      await recordInventoryMovement(
        productId: productId,
        type: MovementType.adjustment,
        quantity: difference.abs(),
        reason: reason,
        performedBy: performedBy,
        notes: notes,
      );
    } catch (e) {
      if (e is BusinessException) rethrow;
      throw BusinessException(message: 'Failed to adjust stock: $e');
    }
  }

  Future<List<InventoryMovement>> getInventoryMovements(
    String organizationId, {
    String? productId,
    MovementType? type,
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
  }) async {
    try {
      final movements = await _database.getInventoryMovements(
        organizationId,
        productId: productId,
        type: type?.name.toUpperCase(),
        limit: limit,
      );

      var result = movements.map((m) => InventoryMovement.fromJson(m)).toList();
      
      // Filter by date if provided
      if (startDate != null) {
        result = result.where((m) => m.createdAt.isAfter(startDate)).toList();
      }
      if (endDate != null) {
        result = result.where((m) => m.createdAt.isBefore(endDate)).toList();
      }

      return result;
    } catch (e) {
      throw BusinessException(message: 'Failed to load inventory movements: $e');
    }
  }

  // Analytics
  Future<Map<String, dynamic>> getInventoryStats(String organizationId) async {
    try {
      final stats = await _database.getDashboardStats(organizationId);
      
      // Get all products for additional stats
      final products = await getProducts(organizationId);
      
      final lowStockProducts = products.where((p) => p.isLowStock).toList();
      final outOfStockProducts = products.where((p) => p.isOutOfStock).toList();
      
      return {
        ...stats,
        'total_products': products.length,
        'low_stock_products': lowStockProducts,
        'out_of_stock_products': outOfStockProducts,
        'total_value': products.fold<double>(
          0,
          (total, p) => total + p.stockValue,
        ),
        'potential_revenue': products.fold<double>(
          0,
          (total, p) => total + p.potentialRevenue,
        ),
      };
    } catch (e) {
      throw BusinessException(message: 'Failed to get inventory stats: $e');
    }
  }

  // Barcode operations
  Future<Product?> getProductByBarcode(
    String organizationId,
    String barcode,
  ) async {
    try {
      final products = await _database.getProducts(
        organizationId,
        searchQuery: barcode,
      );
      
      final matches = products.where((p) => p['barcode'] == barcode).toList();
      
      if (matches.isNotEmpty) {
        return Product.fromJson(matches.first);
      }
      
      return null;
    } catch (e) {
      throw BusinessException(message: 'Failed to find product by barcode: $e');
    }
  }

  // Bulk operations
  Future<void> bulkUpdateProducts(
    List<String> productIds,
    Map<String, dynamic> updates,
  ) async {
    try {
      for (final productId in productIds) {
        await updateProduct(productId, updates);
      }
    } catch (e) {
      throw BusinessException(message: 'Failed to bulk update products: $e');
    }
  }

  Future<void> bulkDeleteProducts(List<String> productIds) async {
    try {
      for (final productId in productIds) {
        await deleteProduct(productId);
      }
    } catch (e) {
      throw BusinessException(message: 'Failed to bulk delete products: $e');
    }
  }

  // Notification helpers
  Future<void> _checkAndSendLowStockNotification(
    Product product,
    double quantityMoved,
  ) async {
    try {
      // Calculate new stock after movement
      final newStock = product.currentStock - quantityMoved;
      
      // Get organization's users who have low stock alerts enabled
      final orgUsers = await _firestore
          .collection('users')
          .where('organization_id', isEqualTo: product.organizationId)
          .get();
      
      for (final userDoc in orgUsers.docs) {
        final userId = userDoc.id;
        
        // Check user's notification settings
        final settings = await _pushNotificationService.getNotificationSettings(userId);
        
        if (settings.enabled && settings.lowStockAlerts) {
          // Check if stock fell below threshold
          if (newStock <= settings.lowStockThreshold && 
              product.currentStock > settings.lowStockThreshold) {
            
            // Send notifications based on user's preferences
            if (settings.emailNotifications) {
              await _emailSmsService.sendLowStockNotification(
                productName: product.name,
                productSku: product.sku,
                currentStock: newStock.toInt(),
                threshold: settings.lowStockThreshold,
              );
            }
            
            if (settings.smsNotifications) {
              // SMS notifications would be sent here if phone number is available
              // For now, we'll skip SMS as it requires phone number setup
            }
            
            if (settings.pushNotifications) {
              await _pushNotificationService.sendNotification(
                userId: userId,
                title: 'Low Stock Alert',
                body: '${product.name} (${product.sku}) is running low. Only ${newStock.toInt()} units remaining.',
                data: {
                  'type': 'low_stock',
                  'product_id': product.id,
                  'product_name': product.name,
                  'current_stock': newStock.toString(),
                },
              );
            }
          }
          
          // Check if product is out of stock
          if (newStock <= 0 && product.currentStock > 0) {
            if (settings.emailNotifications) {
              await _emailSmsService.sendNotification(
                template: 'outOfStock',
                data: {
                  'product_name': product.name,
                  'product_sku': product.sku,
                },
              );
            }
            
            if (settings.pushNotifications) {
              await _pushNotificationService.sendNotification(
                userId: userId,
                title: 'Out of Stock Alert',
                body: '${product.name} (${product.sku}) is now out of stock!',
                data: {
                  'type': 'out_of_stock',
                  'product_id': product.id,
                  'product_name': product.name,
                },
              );
            }
          }
        }
      }
    } catch (e) {
      // Don't fail the inventory movement if notification fails
      print('Error sending low stock notification: $e');
    }
  }
}