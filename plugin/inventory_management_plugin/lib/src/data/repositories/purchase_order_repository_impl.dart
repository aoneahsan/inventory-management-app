import 'dart:async';
import '../../domain/entities/purchase_order.dart';
import '../../domain/repositories/purchase_order_repository.dart';
import '../database/app_database.dart';
import '../models/purchase_order_model.dart';
import '../database/tables/purchase_orders_table.dart';
import '../../core/utils/logger.dart';

/// Implementation of PurchaseOrderRepository using Drift
class PurchaseOrderRepositoryImpl implements PurchaseOrderRepository {
  final AppDatabase _database;
  final _orderStreamController = StreamController<List<PurchaseOrder>>.broadcast();

  PurchaseOrderRepositoryImpl(this._database);

  @override
  Future<PurchaseOrder?> getOrderById(String id) async {
    try {
      final query = _database.select(_database.purchaseOrders)
        ..where((p) => p.id.equals(id));
      final result = await query.getSingleOrNull();
      
      if (result != null) {
        return _convertToEntity(result);
      }
      return null;
    } catch (e) {
      Logger.error('Error getting purchase order by ID: $e');
      rethrow;
    }
  }

  @override
  Future<List<PurchaseOrder>> getAllOrders() async {
    try {
      final results = await _database.select(_database.purchaseOrders).get();
      return results.map((p) => _convertToEntity(p)).toList();
    } catch (e) {
      Logger.error('Error getting all purchase orders: $e');
      rethrow;
    }
  }

  @override
  Future<List<PurchaseOrder>> getOrdersByStatus(String status) async {
    try {
      final query = _database.select(_database.purchaseOrders)
        ..where((p) => p.status.equals(status))
        ..orderBy([(p) => OrderingTerm.desc(p.createdAt)]);
      
      final results = await query.get();
      return results.map((p) => _convertToEntity(p)).toList();
    } catch (e) {
      Logger.error('Error getting orders by status: $e');
      rethrow;
    }
  }

  @override
  Future<List<PurchaseOrder>> getOrdersBySupplier(String supplierId) async {
    try {
      final query = _database.select(_database.purchaseOrders)
        ..where((p) => p.supplierId.equals(supplierId))
        ..orderBy([(p) => OrderingTerm.desc(p.createdAt)]);
      
      final results = await query.get();
      return results.map((p) => _convertToEntity(p)).toList();
    } catch (e) {
      Logger.error('Error getting orders by supplier: $e');
      rethrow;
    }
  }

  @override
  Future<List<PurchaseOrder>> getOrdersByBranch(String branchId) async {
    try {
      final query = _database.select(_database.purchaseOrders)
        ..where((p) => p.branchId.equals(branchId))
        ..orderBy([(p) => OrderingTerm.desc(p.createdAt)]);
      
      final results = await query.get();
      return results.map((p) => _convertToEntity(p)).toList();
    } catch (e) {
      Logger.error('Error getting orders by branch: $e');
      rethrow;
    }
  }

  @override
  Future<List<PurchaseOrder>> getOrdersByDateRange(DateTime start, DateTime end) async {
    try {
      final query = _database.select(_database.purchaseOrders)
        ..where((p) => p.orderDate.isBetweenValues(start, end))
        ..orderBy([(p) => OrderingTerm.desc(p.orderDate)]);
      
      final results = await query.get();
      return results.map((p) => _convertToEntity(p)).toList();
    } catch (e) {
      Logger.error('Error getting orders by date range: $e');
      rethrow;
    }
  }

  @override
  Future<List<PurchaseOrder>> getPendingOrders() async {
    try {
      final query = _database.select(_database.purchaseOrders)
        ..where((p) => p.status.isIn(['pending', 'partial']))
        ..orderBy([(p) => OrderingTerm.asc(p.orderDate)]);
      
      final results = await query.get();
      return results.map((p) => _convertToEntity(p)).toList();
    } catch (e) {
      Logger.error('Error getting pending orders: $e');
      rethrow;
    }
  }

  @override
  Future<List<PurchaseOrder>> getPendingSyncOrders() async {
    try {
      final query = _database.select(_database.purchaseOrders)
        ..where((p) => p.syncStatus.equals('pending'))
        ..orderBy([(p) => OrderingTerm.asc(p.createdAt)]);
      
      final results = await query.get();
      return results.map((p) => _convertToEntity(p)).toList();
    } catch (e) {
      Logger.error('Error getting pending sync orders: $e');
      rethrow;
    }
  }

  @override
  Future<PurchaseOrder> createOrder(PurchaseOrder order) async {
    try {
      final model = _convertToModel(order);
      final id = await _database.into(_database.purchaseOrders).insert(model);
      
      // Notify listeners
      _notifyListeners();
      
      return order.copyWith(id: id.toString());
    } catch (e) {
      Logger.error('Error creating purchase order: $e');
      rethrow;
    }
  }

  @override
  Future<PurchaseOrder> updateOrder(PurchaseOrder order) async {
    try {
      final model = _convertToModel(order);
      final updated = await (_database.update(_database.purchaseOrders)
        ..where((p) => p.id.equals(order.id)))
        .write(model);
      
      if (updated > 0) {
        _notifyListeners();
        return order;
      } else {
        throw Exception('Purchase order not found');
      }
    } catch (e) {
      Logger.error('Error updating purchase order: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteOrder(String id) async {
    try {
      final deleted = await (_database.delete(_database.purchaseOrders)
        ..where((p) => p.id.equals(id)))
        .go();
      
      if (deleted > 0) {
        _notifyListeners();
      } else {
        throw Exception('Purchase order not found');
      }
    } catch (e) {
      Logger.error('Error deleting purchase order: $e');
      rethrow;
    }
  }

  @override
  Future<void> markOrderAsSynced(String id) async {
    try {
      await (_database.update(_database.purchaseOrders)
        ..where((p) => p.id.equals(id)))
        .write(const PurchaseOrdersCompanion(
          syncStatus: Value('synced'),
          syncedAt: Value.ofNullable(DateTime.now()),
        ));
      
      _notifyListeners();
    } catch (e) {
      Logger.error('Error marking order as synced: $e');
      rethrow;
    }
  }

  @override
  Stream<List<PurchaseOrder>> watchOrders() {
    return _orderStreamController.stream;
  }

  @override
  Stream<List<PurchaseOrder>> watchOrdersByBranch(String branchId) {
    return _database.select(_database.purchaseOrders)
      .where((p) => p.branchId.equals(branchId))
      .watch()
      .map((orders) => orders.map((p) => _convertToEntity(p)).toList());
  }

  @override
  Stream<PurchaseOrder?> watchOrder(String id) {
    return (_database.select(_database.purchaseOrders)
      ..where((p) => p.id.equals(id)))
      .watchSingleOrNull()
      .map((order) => order != null ? _convertToEntity(order) : null);
  }

  @override
  void dispose() {
    _orderStreamController.close();
  }

  void _notifyListeners() async {
    final orders = await getAllOrders();
    _orderStreamController.add(orders);
  }

  PurchaseOrder _convertToEntity(PurchaseOrdersData data) {
    return PurchaseOrder(
      id: data.id,
      organizationId: data.organizationId,
      branchId: data.branchId,
      supplierId: data.supplierId,
      orderNumber: data.orderNumber,
      orderDate: data.orderDate,
      expectedDeliveryDate: data.expectedDeliveryDate,
      status: data.status,
      items: data.items,
      subtotal: data.subtotal,
      taxAmount: data.taxAmount,
      discountAmount: data.discountAmount,
      total: data.total,
      notes: data.notes,
      createdBy: data.createdBy,
      approvedBy: data.approvedBy,
      approvedAt: data.approvedAt,
      receivedBy: data.receivedBy,
      receivedAt: data.receivedAt,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      syncStatus: data.syncStatus,
      syncedAt: data.syncedAt,
    );
  }

  PurchaseOrdersCompanion _convertToModel(PurchaseOrder order) {
    return PurchaseOrdersCompanion(
      id: Value(order.id),
      organizationId: Value(order.organizationId),
      branchId: Value(order.branchId),
      supplierId: Value(order.supplierId),
      orderNumber: Value(order.orderNumber),
      orderDate: Value(order.orderDate),
      expectedDeliveryDate: Value.ofNullable(order.expectedDeliveryDate),
      status: Value(order.status),
      items: Value(order.items),
      subtotal: Value(order.subtotal),
      taxAmount: Value(order.taxAmount),
      discountAmount: Value(order.discountAmount),
      total: Value(order.total),
      notes: Value.ofNullable(order.notes),
      createdBy: Value(order.createdBy),
      approvedBy: Value.ofNullable(order.approvedBy),
      approvedAt: Value.ofNullable(order.approvedAt),
      receivedBy: Value.ofNullable(order.receivedBy),
      receivedAt: Value.ofNullable(order.receivedAt),
      createdAt: Value(order.createdAt),
      updatedAt: Value(order.updatedAt),
      syncStatus: Value(order.syncStatus),
      syncedAt: Value.ofNullable(order.syncedAt),
    );
  }
}