import 'dart:async';
import '../../domain/entities/supplier.dart';
import '../../core/utils/logger.dart';
import '../database/database_service.dart';
import '../sync/sync_service.dart';

class SupplierService {
  final DatabaseService _databaseService;
  final SyncService? _syncService;
  final _supplierStreamController = StreamController<List<Supplier>>.broadcast();
  
  SupplierService({
    required DatabaseService databaseService,
    SyncService? syncService,
  })  : _databaseService = databaseService,
        _syncService = syncService;
  
  Stream<List<Supplier>> get suppliersStream => _supplierStreamController.stream;
  
  // Create a new supplier
  Future<Supplier> createSupplier(Supplier supplier) async {
    try {
      final now = DateTime.now();
      final newSupplier = supplier.copyWith(
        id: _generateSupplierId(),
        code: supplier.code ?? _generateSupplierCode(),
        createdAt: now,
        updatedAt: now,
      );
      
      // Save to local database
      await _databaseService.insert('suppliers', newSupplier.toJson());
      
      // Add to sync queue
      if (_syncService != null) {
        await _syncService.addToSyncQueue(
          tableName: 'suppliers',
          operation: 'create',
          recordId: newSupplier.id,
          data: newSupplier.toJson(),
        );
      }
      
      Logger.info('Supplier created: ${newSupplier.id}');
      await _refreshSupplierStream();
      
      return newSupplier;
    } catch (e) {
      Logger.error('Failed to create supplier', error: e);
      rethrow;
    }
  }
  
  // Update an existing supplier
  Future<Supplier> updateSupplier(Supplier supplier) async {
    try {
      final updatedSupplier = supplier.copyWith(
        updatedAt: DateTime.now(),
      );
      
      await _databaseService.update(
        'suppliers',
        updatedSupplier.toJson(),
        where: 'id = ?',
        whereArgs: [supplier.id],
      );
      
      // Add to sync queue
      if (_syncService != null) {
        await _syncService.addToSyncQueue(
          tableName: 'suppliers',
          operation: 'update',
          recordId: updatedSupplier.id,
          data: updatedSupplier.toJson(),
        );
      }
      
      Logger.info('Supplier updated: ${updatedSupplier.id}');
      await _refreshSupplierStream();
      
      return updatedSupplier;
    } catch (e) {
      Logger.error('Failed to update supplier', error: e);
      rethrow;
    }
  }
  
  // Delete a supplier
  Future<void> deleteSupplier(String supplierId) async {
    try {
      // Check if supplier has associated data
      final canDelete = await _canDeleteSupplier(supplierId);
      if (!canDelete) {
        throw Exception('Cannot delete supplier with existing products or purchase orders');
      }
      
      await _databaseService.delete(
        'suppliers',
        where: 'id = ?',
        whereArgs: [supplierId],
      );
      
      // Add to sync queue
      if (_syncService != null) {
        await _syncService.addToSyncQueue(
          tableName: 'suppliers',
          operation: 'delete',
          recordId: supplierId,
          data: {'id': supplierId},
        );
      }
      
      Logger.info('Supplier deleted: $supplierId');
      await _refreshSupplierStream();
    } catch (e) {
      Logger.error('Failed to delete supplier', error: e);
      rethrow;
    }
  }
  
  // Get a single supplier by ID
  Future<Supplier?> getSupplierById(String supplierId) async {
    try {
      final result = await _databaseService.findById('suppliers', supplierId);
      if (result == null) return null;
      
      return Supplier.fromJson(result);
    } catch (e) {
      Logger.error('Failed to get supplier by ID', error: e);
      rethrow;
    }
  }
  
  // Get supplier by code
  Future<Supplier?> getSupplierByCode(String code, String organizationId) async {
    try {
      final results = await _databaseService.query(
        'suppliers',
        where: 'code = ? AND organization_id = ?',
        whereArgs: [code, organizationId],
        limit: 1,
      );
      
      if (results.isEmpty) return null;
      return Supplier.fromJson(results.first);
    } catch (e) {
      Logger.error('Failed to get supplier by code', error: e);
      rethrow;
    }
  }
  
  // Get all suppliers for an organization
  Future<List<Supplier>> getSuppliers({
    required String organizationId,
    String? categoryId,
    bool? isActive,
    String? searchQuery,
    String? sortBy,
    bool ascending = true,
    int? limit,
    int? offset,
  }) async {
    try {
      final whereConditions = <String>['organization_id = ?'];
      final whereArgs = <dynamic>[organizationId];
      
      if (categoryId != null) {
        whereConditions.add("json_extract(categories, '\$') LIKE ?");
        whereArgs.add('%"$categoryId"%');
      }
      
      if (isActive != null) {
        whereConditions.add('is_active = ?');
        whereArgs.add(isActive ? 1 : 0);
      }
      
      if (searchQuery != null && searchQuery.isNotEmpty) {
        whereConditions.add(
          '(name LIKE ? OR code LIKE ? OR email LIKE ? OR phone LIKE ?)'
        );
        final searchPattern = '%$searchQuery%';
        whereArgs.addAll([searchPattern, searchPattern, searchPattern, searchPattern]);
      }
      
      String? orderBy;
      if (sortBy != null) {
        orderBy = '$sortBy ${ascending ? 'ASC' : 'DESC'}';
      }
      
      final results = await _databaseService.query(
        'suppliers',
        where: whereConditions.join(' AND '),
        whereArgs: whereArgs,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
      
      return results.map((json) => Supplier.fromJson(json)).toList();
    } catch (e) {
      Logger.error('Failed to get suppliers', error: e);
      rethrow;
    }
  }
  
  // Get suppliers by product category
  Future<List<Supplier>> getSuppliersByCategory(
    String categoryId,
    String organizationId,
  ) async {
    try {
      final results = await _databaseService.query(
        'suppliers',
        where: "organization_id = ? AND json_extract(categories, '\$') LIKE ?",
        whereArgs: [organizationId, '%"$categoryId"%'],
        orderBy: 'name ASC',
      );
      
      return results.map((json) => Supplier.fromJson(json)).toList();
    } catch (e) {
      Logger.error('Failed to get suppliers by category', error: e);
      rethrow;
    }
  }
  
  // Get supplier products
  Future<List<Map<String, dynamic>>> getSupplierProducts(String supplierId) async {
    try {
      final results = await _databaseService.query(
        'products',
        where: 'supplier_id = ?',
        whereArgs: [supplierId],
        orderBy: 'name ASC',
      );
      
      return results;
    } catch (e) {
      Logger.error('Failed to get supplier products', error: e);
      rethrow;
    }
  }
  
  // Get supplier purchase history
  Future<List<Map<String, dynamic>>> getSupplierPurchaseHistory(
    String supplierId, {
    int limit = 50,
  }) async {
    try {
      final results = await _databaseService.query(
        'purchase_orders',
        where: 'supplier_id = ?',
        whereArgs: [supplierId],
        orderBy: 'created_at DESC',
        limit: limit,
      );
      
      return results;
    } catch (e) {
      Logger.error('Failed to get supplier purchase history', error: e);
      rethrow;
    }
  }
  
  // Get supplier statistics
  Future<Map<String, dynamic>> getSupplierStats(String supplierId) async {
    try {
      final supplier = await getSupplierById(supplierId);
      if (supplier == null) {
        throw Exception('Supplier not found');
      }
      
      // Get purchase statistics
      final purchaseStats = await _databaseService.rawQuery('''
        SELECT 
          COUNT(*) as total_orders,
          SUM(total_amount) as total_purchased,
          AVG(total_amount) as average_order_value,
          MAX(created_at) as last_purchase_date,
          SUM(CASE WHEN status = 'pending' THEN 1 ELSE 0 END) as pending_orders,
          SUM(CASE WHEN status = 'pending' THEN total_amount ELSE 0 END) as pending_amount
        FROM purchase_orders
        WHERE supplier_id = ?
      ''', [supplierId]);
      
      // Get product count
      final productCount = await _databaseService.count(
        'products',
        where: 'supplier_id = ?',
        whereArgs: [supplierId],
      );
      
      return {
        'supplier': supplier.toJson(),
        'stats': purchaseStats.isNotEmpty ? purchaseStats.first : {},
        'product_count': productCount,
      };
    } catch (e) {
      Logger.error('Failed to get supplier stats', error: e);
      rethrow;
    }
  }
  
  // Update supplier rating
  Future<Supplier> updateSupplierRating(
    String supplierId,
    double rating, {
    String? review,
  }) async {
    try {
      final supplier = await getSupplierById(supplierId);
      if (supplier == null) {
        throw Exception('Supplier not found');
      }
      
      if (rating < 0 || rating > 5) {
        throw Exception('Rating must be between 0 and 5');
      }
      
      // Calculate new average rating
      final totalRatings = supplier.metadata['total_ratings'] ?? 0;
      final currentAverage = supplier.rating;
      final newTotalRatings = totalRatings + 1;
      final newAverageRating = ((currentAverage * totalRatings) + rating) / newTotalRatings;
      
      // Update supplier
      final updatedMetadata = Map<String, dynamic>.from(supplier.metadata);
      updatedMetadata['total_ratings'] = newTotalRatings;
      
      final updatedSupplier = supplier.copyWith(
        rating: newAverageRating,
        metadata: updatedMetadata,
      );
      
      await updateSupplier(updatedSupplier);
      
      // Save rating record
      if (review != null || rating != 0) {
        await _databaseService.insert('supplier_ratings', {
          'id': _generateRatingId(),
          'supplier_id': supplierId,
          'organization_id': supplier.organizationId,
          'rating': rating,
          'review': review,
          'created_at': DateTime.now().millisecondsSinceEpoch,
        });
      }
      
      return updatedSupplier;
    } catch (e) {
      Logger.error('Failed to update supplier rating', error: e);
      rethrow;
    }
  }
  
  // Search suppliers
  Future<List<Supplier>> searchSuppliers(
    String query,
    String organizationId, {
    int limit = 20,
  }) async {
    try {
      final searchPattern = '%$query%';
      final results = await _databaseService.query(
        'suppliers',
        where: 'organization_id = ? AND (name LIKE ? OR code LIKE ? OR contact_person LIKE ?)',
        whereArgs: [organizationId, searchPattern, searchPattern, searchPattern],
        limit: limit,
      );
      
      return results.map((json) => Supplier.fromJson(json)).toList();
    } catch (e) {
      Logger.error('Failed to search suppliers', error: e);
      rethrow;
    }
  }
  
  // Bulk import suppliers
  Future<List<Supplier>> bulkImportSuppliers(
    List<Supplier> suppliers,
    String organizationId,
  ) async {
    try {
      final importedSuppliers = <Supplier>[];
      
      await _databaseService.transaction((txn) async {
        for (final supplier in suppliers) {
          final now = DateTime.now();
          final newSupplier = supplier.copyWith(
            id: _generateSupplierId(),
            code: supplier.code ?? _generateSupplierCode(),
            organizationId: organizationId,
            createdAt: now,
            updatedAt: now,
          );
          
          await txn.insert('suppliers', newSupplier.toJson());
          importedSuppliers.add(newSupplier);
        }
      });
      
      // Add to sync queue
      if (_syncService != null) {
        for (final supplier in importedSuppliers) {
          await _syncService.addToSyncQueue(
            tableName: 'suppliers',
            operation: 'create',
            recordId: supplier.id,
            data: supplier.toJson(),
          );
        }
      }
      
      Logger.info('Bulk imported ${importedSuppliers.length} suppliers');
      await _refreshSupplierStream();
      
      return importedSuppliers;
    } catch (e) {
      Logger.error('Failed to bulk import suppliers', error: e);
      rethrow;
    }
  }
  
  // Private helper methods
  String _generateSupplierId() {
    return 'sup_${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}';
  }
  
  String _generateSupplierCode() {
    return 'S${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}';
  }
  
  String _generateRatingId() {
    return 'rat_${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}';
  }
  
  Future<bool> _canDeleteSupplier(String supplierId) async {
    // Check if supplier has products
    final productCount = await _databaseService.count(
      'products',
      where: 'supplier_id = ?',
      whereArgs: [supplierId],
    );
    
    // Check if supplier has purchase orders
    final purchaseCount = await _databaseService.count(
      'purchase_orders',
      where: 'supplier_id = ?',
      whereArgs: [supplierId],
    );
    
    return productCount == 0 && purchaseCount == 0;
  }
  
  Future<void> _refreshSupplierStream() async {
    // This would typically emit the current supplier list to the stream
    // Implementation depends on current context/organization
  }
  
  void dispose() {
    _supplierStreamController.close();
  }
}