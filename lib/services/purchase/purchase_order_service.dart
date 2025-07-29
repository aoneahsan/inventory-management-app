import '../../domain/entities/purchase_order.dart';
import '../../domain/entities/inventory_movement.dart';
import '../../services/database/database.dart';
import '../../services/purchase/supplier_service.dart';
import '../../core/utils/id_generator.dart';

class PurchaseOrderService {
  final AppDatabase database;
  final SupplierService supplierService;

  PurchaseOrderService({
    required this.database,
    required this.supplierService,
  });

  // Purchase Order CRUD operations
  Future<List<PurchaseOrder>> getPurchaseOrders(String organizationId, {
    String? supplierId,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    String? searchQuery,
    int? limit,
    int? offset,
  }) async {
    final db = await database.database;
    String query = 'SELECT * FROM purchase_orders WHERE organization_id = ?';
    List<dynamic> args = [organizationId];

    if (supplierId != null) {
      query += ' AND supplier_id = ?';
      args.add(supplierId);
    }

    if (status != null) {
      query += ' AND status = ?';
      args.add(status);
    }

    if (startDate != null) {
      query += ' AND order_date >= ?';
      args.add(startDate.millisecondsSinceEpoch);
    }

    if (endDate != null) {
      query += ' AND order_date <= ?';
      args.add(endDate.millisecondsSinceEpoch);
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query += ' AND (po_number LIKE ? OR notes LIKE ?)';
      final searchPattern = '%$searchQuery%';
      args.addAll([searchPattern, searchPattern]);
    }

    query += ' ORDER BY order_date DESC, created_at DESC';

    if (limit != null) {
      query += ' LIMIT ?';
      args.add(limit);
      if (offset != null) {
        query += ' OFFSET ?';
        args.add(offset);
      }
    }

    final results = await db.rawQuery(query, args);
    final orders = <PurchaseOrder>[];

    for (final orderMap in results) {
      final order = PurchaseOrder.fromMap(orderMap);
      // Load items for each order
      final items = await getPurchaseOrderItems(order.id);
      orders.add(order.copyWith(items: items));
    }

    return orders;
  }

  Future<PurchaseOrder?> getPurchaseOrderById(String orderId) async {
    final db = await database.database;
    final results = await db.query(
      'purchase_orders',
      where: 'id = ?',
      whereArgs: [orderId],
      limit: 1,
    );

    if (results.isEmpty) return null;
    
    final order = PurchaseOrder.fromMap(results.first);
    final items = await getPurchaseOrderItems(order.id);
    return order.copyWith(items: items);
  }

  Future<List<PurchaseOrderItem>> getPurchaseOrderItems(String orderId) async {
    final db = await database.database;
    final results = await db.query(
      'purchase_order_items',
      where: 'purchase_order_id = ?',
      whereArgs: [orderId],
      orderBy: 'created_at ASC',
    );

    return results.map((map) => PurchaseOrderItem.fromMap(map)).toList();
  }

  Future<String> generatePONumber(String organizationId) async {
    final db = await database.database;
    final now = DateTime.now();
    final prefix = 'PO${now.year}${now.month.toString().padLeft(2, '0')}';
    
    // Get the latest PO number for this month
    final results = await db.rawQuery(
      '''SELECT po_number FROM purchase_orders 
         WHERE organization_id = ? AND po_number LIKE ?
         ORDER BY po_number DESC LIMIT 1''',
      [organizationId, '$prefix%'],
    );

    int nextNumber = 1;
    if (results.isNotEmpty) {
      final lastNumber = results.first['po_number'] as String;
      final numberPart = lastNumber.substring(prefix.length);
      nextNumber = int.tryParse(numberPart) ?? 0;
      nextNumber++;
    }

    return '$prefix${nextNumber.toString().padLeft(4, '0')}';
  }

  Future<PurchaseOrder> createPurchaseOrder({
    required String organizationId,
    required String supplierId,
    required List<PurchaseOrderItem> items,
    required String createdBy,
    DateTime? expectedDate,
    String? notes,
  }) async {
    final db = await database.database;
    final now = DateTime.now();
    final poNumber = await generatePONumber(organizationId);
    final orderId = IdGenerator.generateId();

    // Calculate totals
    double subtotal = 0;
    double taxAmount = 0;
    double discountAmount = 0;

    for (final item in items) {
      subtotal += item.subtotal;
      discountAmount += item.discountAmount;
      taxAmount += item.taxAmount;
    }

    final totalAmount = subtotal - discountAmount + taxAmount;

    final order = PurchaseOrder(
      id: orderId,
      organizationId: organizationId,
      supplierId: supplierId,
      poNumber: poNumber,
      orderDate: now,
      expectedDate: expectedDate,
      status: 'draft',
      totalAmount: totalAmount,
      taxAmount: taxAmount,
      discountAmount: discountAmount,
      notes: notes,
      createdAt: now,
      updatedAt: now,
      createdBy: createdBy,
    );

    await db.transaction((txn) async {
      // Insert order
      await txn.insert('purchase_orders', order.toMap());

      // Insert items
      for (final item in items) {
        final newItem = item.copyWith(
          id: IdGenerator.generateId(),
          purchaseOrderId: orderId,
          createdAt: now,
        );
        await txn.insert('purchase_order_items', newItem.toMap());
      }
    });

    return order.copyWith(items: items);
  }

  Future<PurchaseOrder> updatePurchaseOrder(
    String orderId,
    Map<String, dynamic> updates,
  ) async {
    final db = await database.database;
    final existingOrder = await getPurchaseOrderById(orderId);
    if (existingOrder == null) {
      throw Exception('Purchase order not found');
    }

    if (!existingOrder.canEdit) {
      throw Exception('Purchase order cannot be edited in current status');
    }

    final updatedData = {
      ...updates,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    };

    await db.update(
      'purchase_orders',
      updatedData,
      where: 'id = ?',
      whereArgs: [orderId],
    );

    final updatedOrder = await getPurchaseOrderById(orderId);
    return updatedOrder!;
  }

  Future<void> updatePurchaseOrderItems(
    String orderId,
    List<PurchaseOrderItem> newItems,
  ) async {
    final db = await database.database;
    final order = await getPurchaseOrderById(orderId);
    if (order == null) {
      throw Exception('Purchase order not found');
    }

    if (!order.canEdit) {
      throw Exception('Purchase order items cannot be edited in current status');
    }

    await db.transaction((txn) async {
      // Delete existing items
      await txn.delete(
        'purchase_order_items',
        where: 'purchase_order_id = ?',
        whereArgs: [orderId],
      );

      // Insert new items
      double subtotal = 0;
      double taxAmount = 0;
      double discountAmount = 0;

      for (final item in newItems) {
        final newItem = item.copyWith(
          id: IdGenerator.generateId(),
          purchaseOrderId: orderId,
          createdAt: DateTime.now(),
        );
        await txn.insert('purchase_order_items', newItem.toMap());

        subtotal += item.subtotal;
        discountAmount += item.discountAmount;
        taxAmount += item.taxAmount;
      }

      // Update order totals
      final totalAmount = subtotal - discountAmount + taxAmount;
      await txn.update(
        'purchase_orders',
        {
          'total_amount': totalAmount,
          'tax_amount': taxAmount,
          'discount_amount': discountAmount,
          'updated_at': DateTime.now().millisecondsSinceEpoch,
        },
        where: 'id = ?',
        whereArgs: [orderId],
      );
    });
  }

  Future<void> sendPurchaseOrder(String orderId) async {
    final order = await getPurchaseOrderById(orderId);
    if (order == null) {
      throw Exception('Purchase order not found');
    }

    if (!order.canSend) {
      throw Exception('Purchase order cannot be sent in current status');
    }

    await updatePurchaseOrder(orderId, {'status': 'sent'});
  }

  Future<void> cancelPurchaseOrder(String orderId) async {
    final order = await getPurchaseOrderById(orderId);
    if (order == null) {
      throw Exception('Purchase order not found');
    }

    if (!order.canCancel) {
      throw Exception('Purchase order cannot be cancelled in current status');
    }

    await updatePurchaseOrder(orderId, {'status': 'cancelled'});
  }

  // Receiving operations
  Future<void> receivePurchaseOrderItems(
    String orderId,
    Map<String, double> receivedQuantities, // productId -> quantity
    String receivedBy,
  ) async {
    final db = await database.database;
    final order = await getPurchaseOrderById(orderId);
    if (order == null) {
      throw Exception('Purchase order not found');
    }

    if (!order.canReceive) {
      throw Exception('Purchase order cannot be received in current status');
    }

    await db.transaction((txn) async {
      bool allFullyReceived = true;
      bool anyReceived = false;

      for (final item in order.items) {
        final receivedQty = receivedQuantities[item.productId] ?? 0;
        if (receivedQty > 0) {
          anyReceived = true;
          final newReceivedQty = item.receivedQuantity + receivedQty;
          
          // Update item received quantity
          await txn.update(
            'purchase_order_items',
            {'received_quantity': newReceivedQty},
            where: 'id = ?',
            whereArgs: [item.id],
          );

          // Record inventory movement
          await database.recordInventoryMovement({
            'id': IdGenerator.generateId(),
            'organization_id': order.organizationId,
            'product_id': item.productId,
            'type': 'PURCHASE',
            'quantity': receivedQty,
            'unit_cost': item.unitPrice,
            'total_cost': receivedQty * item.unitPrice,
            'reason': 'Purchase Order Receipt',
            'reference_number': order.poNumber,
            'performed_by': receivedBy,
            'notes': 'Received from PO ${order.poNumber}',
          });

          if (newReceivedQty < item.quantity) {
            allFullyReceived = false;
          }
        } else if (item.receivedQuantity < item.quantity) {
          allFullyReceived = false;
        }
      }

      if (anyReceived) {
        // Update order status
        String newStatus = order.status;
        if (allFullyReceived) {
          newStatus = 'received';
        } else if (order.status == 'sent') {
          newStatus = 'partial';
        }

        await txn.update(
          'purchase_orders',
          {
            'status': newStatus,
            'updated_at': DateTime.now().millisecondsSinceEpoch,
          },
          where: 'id = ?',
          whereArgs: [orderId],
        );

        // Record supplier transaction if fully received
        if (allFullyReceived) {
          await supplierService.recordTransaction(
            supplierId: order.supplierId,
            transactionType: 'purchase',
            amount: order.totalAmount,
            referenceId: order.id,
            notes: 'Purchase Order ${order.poNumber}',
          );
        }
      }
    });
  }

  // Analytics methods
  Future<Map<String, dynamic>> getPurchaseOrderStats(String organizationId) async {
    final db = await database.database;

    // Order counts by status
    final statusCounts = await db.rawQuery(
      '''SELECT status, COUNT(*) as count 
         FROM purchase_orders 
         WHERE organization_id = ?
         GROUP BY status''',
      [organizationId],
    );

    // Total value by status
    final statusValues = await db.rawQuery(
      '''SELECT status, SUM(total_amount) as total 
         FROM purchase_orders 
         WHERE organization_id = ?
         GROUP BY status''',
      [organizationId],
    );

    // Recent orders
    final recentOrders = await getPurchaseOrders(
      organizationId,
      limit: 5,
    );

    // Pending receipts
    final pendingReceipts = await db.rawQuery(
      '''SELECT COUNT(*) as count 
         FROM purchase_orders 
         WHERE organization_id = ? AND status IN (?, ?)''',
      [organizationId, 'sent', 'partial'],
    );

    return {
      'status_counts': Map.fromEntries(
        statusCounts.map((row) => MapEntry(
          row['status'] as String,
          row['count'] as int,
        )),
      ),
      'status_values': Map.fromEntries(
        statusValues.map((row) => MapEntry(
          row['status'] as String,
          (row['total'] ?? 0) as double,
        )),
      ),
      'recent_orders': recentOrders,
      'pending_receipts': (pendingReceipts.first['count'] as int),
    };
  }
}