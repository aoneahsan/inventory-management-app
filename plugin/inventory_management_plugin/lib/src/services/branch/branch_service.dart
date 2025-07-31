import 'dart:async';
import 'dart:math';
import '../../domain/entities/branch.dart';
import '../../core/utils/logger.dart';
import '../database/database_service.dart';
import '../sync/sync_service.dart';

class BranchService {
  final DatabaseService _databaseService;
  final SyncService? _syncService;
  final _branchStreamController = StreamController<List<Branch>>.broadcast();
  
  BranchService({
    required DatabaseService databaseService,
    SyncService? syncService,
  })  : _databaseService = databaseService,
        _syncService = syncService;
  
  Stream<List<Branch>> get branchesStream => _branchStreamController.stream;
  
  // Create a new branch
  Future<Branch> createBranch(Branch branch) async {
    try {
      final now = DateTime.now();
      final newBranch = branch.copyWith(
        id: _generateBranchId(),
        code: branch.code ?? _generateBranchCode(),
        createdAt: now,
        updatedAt: now,
      );
      
      // If this is the first branch, make it default
      final branchCount = await getBranchCount(branch.organizationId);
      if (branchCount == 0) {
        newBranch = newBranch.copyWith(isDefault: true);
      }
      
      // Save to local database
      await _databaseService.insert('branches', newBranch.toJson());
      
      // Add to sync queue
      if (_syncService != null) {
        await _syncService.addToSyncQueue(
          tableName: 'branches',
          operation: 'create',
          recordId: newBranch.id,
          data: newBranch.toJson(),
        );
      }
      
      Logger.info('Branch created: ${newBranch.id}');
      await _refreshBranchStream();
      
      return newBranch;
    } catch (e) {
      Logger.error('Failed to create branch', error: e);
      rethrow;
    }
  }
  
  // Update an existing branch
  Future<Branch> updateBranch(Branch branch) async {
    try {
      final updatedBranch = branch.copyWith(
        updatedAt: DateTime.now(),
      );
      
      await _databaseService.transaction((txn) async {
        // If setting as default, unset other defaults
        if (updatedBranch.isDefault) {
          await txn.update(
            'branches',
            {'is_default': 0},
            where: 'organization_id = ? AND id != ?',
            whereArgs: [updatedBranch.organizationId, updatedBranch.id],
          );
        }
        
        // Update branch
        await txn.update(
          'branches',
          updatedBranch.toJson(),
          where: 'id = ?',
          whereArgs: [branch.id],
        );
      });
      
      // Add to sync queue
      if (_syncService != null) {
        await _syncService.addToSyncQueue(
          tableName: 'branches',
          operation: 'update',
          recordId: updatedBranch.id,
          data: updatedBranch.toJson(),
        );
      }
      
      Logger.info('Branch updated: ${updatedBranch.id}');
      await _refreshBranchStream();
      
      return updatedBranch;
    } catch (e) {
      Logger.error('Failed to update branch', error: e);
      rethrow;
    }
  }
  
  // Delete a branch
  Future<void> deleteBranch(String branchId) async {
    try {
      final branch = await getBranchById(branchId);
      if (branch == null) {
        throw Exception('Branch not found');
      }
      
      if (branch.isDefault) {
        throw Exception('Cannot delete default branch');
      }
      
      // Check if branch has associated data
      final hasData = await _branchHasData(branchId);
      if (hasData) {
        throw Exception('Cannot delete branch with existing data');
      }
      
      await _databaseService.delete(
        'branches',
        where: 'id = ?',
        whereArgs: [branchId],
      );
      
      // Add to sync queue
      if (_syncService != null) {
        await _syncService.addToSyncQueue(
          tableName: 'branches',
          operation: 'delete',
          recordId: branchId,
          data: {'id': branchId},
        );
      }
      
      Logger.info('Branch deleted: $branchId');
      await _refreshBranchStream();
    } catch (e) {
      Logger.error('Failed to delete branch', error: e);
      rethrow;
    }
  }
  
  // Get a single branch by ID
  Future<Branch?> getBranchById(String branchId) async {
    try {
      final result = await _databaseService.findById('branches', branchId);
      if (result == null) return null;
      
      return Branch.fromJson(result);
    } catch (e) {
      Logger.error('Failed to get branch by ID', error: e);
      rethrow;
    }
  }
  
  // Get branch by code
  Future<Branch?> getBranchByCode(String code, String organizationId) async {
    try {
      final results = await _databaseService.query(
        'branches',
        where: 'code = ? AND organization_id = ?',
        whereArgs: [code, organizationId],
        limit: 1,
      );
      
      if (results.isEmpty) return null;
      return Branch.fromJson(results.first);
    } catch (e) {
      Logger.error('Failed to get branch by code', error: e);
      rethrow;
    }
  }
  
  // Get default branch for organization
  Future<Branch?> getDefaultBranch(String organizationId) async {
    try {
      final results = await _databaseService.query(
        'branches',
        where: 'organization_id = ? AND is_default = ?',
        whereArgs: [organizationId, 1],
        limit: 1,
      );
      
      if (results.isEmpty) return null;
      return Branch.fromJson(results.first);
    } catch (e) {
      Logger.error('Failed to get default branch', error: e);
      rethrow;
    }
  }
  
  // Get all branches for an organization
  Future<List<Branch>> getBranches({
    required String organizationId,
    String? branchType,
    bool? isActive,
    bool? isWarehouse,
    String? searchQuery,
    String? sortBy,
    bool ascending = true,
    int? limit,
    int? offset,
  }) async {
    try {
      final whereConditions = <String>['organization_id = ?'];
      final whereArgs = <dynamic>[organizationId];
      
      if (branchType != null) {
        whereConditions.add('branch_type = ?');
        whereArgs.add(branchType);
      }
      
      if (isActive != null) {
        whereConditions.add('is_active = ?');
        whereArgs.add(isActive ? 1 : 0);
      }
      
      if (isWarehouse != null) {
        whereConditions.add('is_warehouse = ?');
        whereArgs.add(isWarehouse ? 1 : 0);
      }
      
      if (searchQuery != null && searchQuery.isNotEmpty) {
        whereConditions.add(
          '(name LIKE ? OR code LIKE ? OR address LIKE ? OR city LIKE ?)'
        );
        final searchPattern = '%$searchQuery%';
        whereArgs.addAll([searchPattern, searchPattern, searchPattern, searchPattern]);
      }
      
      String? orderBy;
      if (sortBy != null) {
        orderBy = '$sortBy ${ascending ? 'ASC' : 'DESC'}';
      }
      
      final results = await _databaseService.query(
        'branches',
        where: whereConditions.join(' AND '),
        whereArgs: whereArgs,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
      
      return results.map((json) => Branch.fromJson(json)).toList();
    } catch (e) {
      Logger.error('Failed to get branches', error: e);
      rethrow;
    }
  }
  
  // Get branches within radius of a location
  Future<List<Branch>> getBranchesNearLocation({
    required String organizationId,
    required double latitude,
    required double longitude,
    required double radiusKm,
    bool? allowDelivery,
    bool? allowPickup,
  }) async {
    try {
      final branches = await getBranches(
        organizationId: organizationId,
        isActive: true,
      );
      
      final nearbyBranches = <Branch>[];
      
      for (final branch in branches) {
        if (!branch.hasLocation) continue;
        
        // Calculate distance using Haversine formula
        final distance = _calculateDistance(
          latitude,
          longitude,
          branch.latitude,
          branch.longitude,
        );
        
        if (distance <= radiusKm) {
          // Check delivery/pickup constraints
          if (allowDelivery != null && allowDelivery && !branch.allowDelivery) {
            continue;
          }
          if (allowPickup != null && allowPickup && !branch.allowPickup) {
            continue;
          }
          
          // Check delivery radius constraint for delivery orders
          if (allowDelivery == true && branch.deliveryRadius > 0 && distance > branch.deliveryRadius) {
            continue;
          }
          
          nearbyBranches.add(branch);
        }
      }
      
      // Sort by distance
      nearbyBranches.sort((a, b) {
        final distA = _calculateDistance(latitude, longitude, a.latitude, a.longitude);
        final distB = _calculateDistance(latitude, longitude, b.latitude, b.longitude);
        return distA.compareTo(distB);
      });
      
      return nearbyBranches;
    } catch (e) {
      Logger.error('Failed to get branches near location', error: e);
      rethrow;
    }
  }
  
  // Get branch inventory status
  Future<Map<String, dynamic>> getBranchInventoryStatus(String branchId) async {
    try {
      final branch = await getBranchById(branchId);
      if (branch == null) {
        throw Exception('Branch not found');
      }
      
      // Get inventory statistics
      final inventoryStats = await _databaseService.rawQuery('''
        SELECT 
          COUNT(DISTINCT product_id) as total_products,
          SUM(quantity) as total_quantity,
          SUM(quantity * cost_price) as total_value,
          SUM(CASE WHEN quantity <= reorder_point THEN 1 ELSE 0 END) as low_stock_count,
          SUM(CASE WHEN quantity = 0 THEN 1 ELSE 0 END) as out_of_stock_count
        FROM inventory
        WHERE branch_id = ?
      ''', [branchId]);
      
      return {
        'branch': branch.toJson(),
        'inventory': inventoryStats.isNotEmpty ? inventoryStats.first : {},
      };
    } catch (e) {
      Logger.error('Failed to get branch inventory status', error: e);
      rethrow;
    }
  }
  
  // Get branch sales statistics
  Future<Map<String, dynamic>> getBranchSalesStats(
    String branchId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final branch = await getBranchById(branchId);
      if (branch == null) {
        throw Exception('Branch not found');
      }
      
      final whereConditions = ['branch_id = ?'];
      final whereArgs = <dynamic>[branchId];
      
      if (startDate != null) {
        whereConditions.add('created_at >= ?');
        whereArgs.add(startDate.millisecondsSinceEpoch);
      }
      
      if (endDate != null) {
        whereConditions.add('created_at <= ?');
        whereArgs.add(endDate.millisecondsSinceEpoch);
      }
      
      // Get sales statistics
      final salesStats = await _databaseService.rawQuery('''
        SELECT 
          COUNT(*) as total_sales,
          SUM(total_amount) as total_revenue,
          AVG(total_amount) as average_sale_value,
          COUNT(DISTINCT customer_id) as unique_customers,
          COUNT(DISTINCT DATE(created_at / 1000, 'unixepoch')) as active_days
        FROM sales
        WHERE ${whereConditions.join(' AND ')}
      ''', whereArgs);
      
      return {
        'branch': branch.toJson(),
        'sales': salesStats.isNotEmpty ? salesStats.first : {},
      };
    } catch (e) {
      Logger.error('Failed to get branch sales stats', error: e);
      rethrow;
    }
  }
  
  // Set default branch
  Future<Branch> setDefaultBranch(String branchId) async {
    try {
      final branch = await getBranchById(branchId);
      if (branch == null) {
        throw Exception('Branch not found');
      }
      
      return await updateBranch(branch.copyWith(isDefault: true));
    } catch (e) {
      Logger.error('Failed to set default branch', error: e);
      rethrow;
    }
  }
  
  // Check if branch is open
  Future<bool> isBranchOpen(String branchId, {DateTime? at}) async {
    try {
      final branch = await getBranchById(branchId);
      if (branch == null || !branch.isActive) {
        return false;
      }
      
      final checkTime = at ?? DateTime.now();
      return branch.isOpenAt(checkTime);
    } catch (e) {
      Logger.error('Failed to check if branch is open', error: e);
      rethrow;
    }
  }
  
  // Get branch count
  Future<int> getBranchCount(String organizationId) async {
    try {
      return await _databaseService.count(
        'branches',
        where: 'organization_id = ?',
        whereArgs: [organizationId],
      );
    } catch (e) {
      Logger.error('Failed to get branch count', error: e);
      rethrow;
    }
  }
  
  // Search branches
  Future<List<Branch>> searchBranches(
    String query,
    String organizationId, {
    int limit = 20,
  }) async {
    try {
      final searchPattern = '%$query%';
      final results = await _databaseService.query(
        'branches',
        where: 'organization_id = ? AND (name LIKE ? OR code LIKE ? OR city LIKE ?)',
        whereArgs: [organizationId, searchPattern, searchPattern, searchPattern],
        limit: limit,
      );
      
      return results.map((json) => Branch.fromJson(json)).toList();
    } catch (e) {
      Logger.error('Failed to search branches', error: e);
      rethrow;
    }
  }
  
  // Private helper methods
  String _generateBranchId() {
    return 'br_${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}';
  }
  
  String _generateBranchCode() {
    return 'BR${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
  }
  
  Future<bool> _branchHasData(String branchId) async {
    // Check for inventory
    final inventoryCount = await _databaseService.count(
      'inventory',
      where: 'branch_id = ?',
      whereArgs: [branchId],
    );
    
    // Check for sales
    final salesCount = await _databaseService.count(
      'sales',
      where: 'branch_id = ?',
      whereArgs: [branchId],
    );
    
    // Check for staff
    final staffCount = await _databaseService.count(
      'users',
      where: "json_extract(branch_ids, '\$') LIKE ?",
      whereArgs: ['%"$branchId"%'],
    );
    
    return inventoryCount > 0 || salesCount > 0 || staffCount > 0;
  }
  
  // Calculate distance between two coordinates using Haversine formula
  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Earth's radius in kilometers
    
    final double dLat = _toRadians(lat2 - lat1);
    final double dLon = _toRadians(lon2 - lon1);
    
    final double a = 
      (sin(dLat / 2) * sin(dLat / 2)) +
      cos(_toRadians(lat1)) * cos(_toRadians(lat2)) *
      (sin(dLon / 2) * sin(dLon / 2));
    
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    
    return earthRadius * c;
  }
  
  double _toRadians(double degrees) {
    return degrees * (pi / 180);
  }
  
  Future<void> _refreshBranchStream() async {
    // This would typically emit the current branch list to the stream
    // Implementation depends on current context/organization
  }
  
  void dispose() {
    _branchStreamController.close();
  }
}