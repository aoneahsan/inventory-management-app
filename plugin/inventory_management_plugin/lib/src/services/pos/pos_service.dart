import 'dart:async';
import '../../domain/entities/sale.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/customer.dart';
import '../../domain/repositories/sale_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/inventory_movement_repository.dart';
import '../../core/utils/logger.dart';
import '../sync/sync_service.dart';

/// Service for Point of Sale operations
class POSService {
  final SaleRepository _saleRepository;
  final ProductRepository _productRepository;
  final InventoryMovementRepository _movementRepository;
  final SyncService? _syncService;
  
  POSService({
    required SaleRepository saleRepository,
    required ProductRepository productRepository,
    required InventoryMovementRepository movementRepository,
    SyncService? syncService,
  })  : _saleRepository = saleRepository,
        _productRepository = productRepository,
        _movementRepository = movementRepository,
        _syncService = syncService;
  
  /// Create a new sale
  Future<Sale> createSale({
    required String organizationId,
    required String branchId,
    required String userId,
    required List<SaleItem> items,
    required String paymentMethod,
    String? customerId,
    double? discountAmount,
    String? notes,
  }) async {
    try {
      // Calculate totals
      double subtotal = 0;
      double totalTax = 0;
      
      for (final item in items) {
        subtotal += item.quantity * item.unitPrice;
        totalTax += item.taxAmount ?? 0;
      }
      
      final totalAmount = subtotal + totalTax - (discountAmount ?? 0);
      
      final sale = Sale(
        id: _generateSaleId(),
        organizationId: organizationId,
        branchId: branchId,
        customerId: customerId,
        userId: userId,
        saleNumber: _generateSaleNumber(),
        items: items,
        subtotal: subtotal,
        taxAmount: totalTax,
        discountAmount: discountAmount ?? 0,
        totalAmount: totalAmount,
        paidAmount: totalAmount,
        changeAmount: 0,
        paymentMethod: paymentMethod,
        status: SaleStatus.completed,
        notes: notes,
        saleDate: DateTime.now(),
        createdAt: DateTime.now(),
        syncedAt: null,
      );
      
      // Create sale and inventory movements
      final created = await _saleRepository.create(sale);
      
      // Create inventory movements for each item
      for (final item in items) {
        await _movementRepository.createSaleMovement(
          productId: item.productId,
          branchId: branchId,
          quantity: item.quantity,
          saleId: created.id,
          unitCost: item.costPrice,
          performedBy: userId,
        );
      }
      
      if (_syncService != null) {
        await _syncService.addToSyncQueue(
          tableName: 'sales',
          operation: 'create',
          recordId: created.id,
          data: created.toJson(),
        );
      }
      
      Logger.info('Sale created: ${created.id}');
      return created;
    } catch (e) {
      Logger.error('Failed to create sale', error: e);
      rethrow;
    }
  }
  
  /// Process return
  Future<Sale> processReturn({
    required String originalSaleId,
    required List<String> returnItemIds,
    required String reason,
    required String userId,
  }) async {
    try {
      final originalSale = await _saleRepository.getById(originalSaleId);
      if (originalSale == null) throw Exception('Original sale not found');
      
      // Create return sale with negative amounts
      final returnItems = originalSale.items
          .where((item) => returnItemIds.contains(item.id))
          .map((item) => item.copyWith(
                quantity: -item.quantity,
                returnReason: reason,
              ))
          .toList();
      
      final returnSale = await createSale(
        organizationId: originalSale.organizationId,
        branchId: originalSale.branchId,
        userId: userId,
        items: returnItems,
        paymentMethod: originalSale.paymentMethod,
        customerId: originalSale.customerId,
        notes: 'Return for sale: ${originalSale.saleNumber}. Reason: $reason',
      );
      
      // Update original sale
      await _saleRepository.update(originalSale.copyWith(
        hasReturn: true,
        returnId: returnSale.id,
      ));
      
      Logger.info('Return processed for sale: $originalSaleId');
      return returnSale;
    } catch (e) {
      Logger.error('Failed to process return', error: e);
      rethrow;
    }
  }
  
  /// Void sale
  Future<void> voidSale(String saleId, String reason, String userId) async {
    try {
      final sale = await _saleRepository.getById(saleId);
      if (sale == null) throw Exception('Sale not found');
      
      if (sale.status == SaleStatus.voided) {
        throw Exception('Sale already voided');
      }
      
      // Update sale status
      await _saleRepository.update(sale.copyWith(
        status: SaleStatus.voided,
        voidedBy: userId,
        voidedAt: DateTime.now(),
        voidReason: reason,
      ));
      
      // Reverse inventory movements
      for (final item in sale.items) {
        await _movementRepository.createAdjustment(
          productId: item.productId,
          branchId: sale.branchId,
          quantity: item.quantity,
          reason: 'Sale voided: $saleId',
          performedBy: userId,
        );
      }
      
      Logger.info('Sale voided: $saleId');
    } catch (e) {
      Logger.error('Failed to void sale', error: e);
      rethrow;
    }
  }
  
  String _generateSaleId() => 'SALE${DateTime.now().millisecondsSinceEpoch}';
  
  String _generateSaleNumber() => 'S${DateTime.now().millisecondsSinceEpoch}';
}