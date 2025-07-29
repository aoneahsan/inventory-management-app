import 'dart:convert';
import '../../domain/entities/repackaging_rule.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/inventory_movement.dart';
import '../database/database.dart';
import '../branch/branch_service.dart';
import '../sync/sync_service.dart';
import 'product_service.dart';

class RepackagingService {
  final AppDatabase _database = AppDatabase.instance;
  final BranchService _branchService = BranchService();
  final ProductService _productService = ProductService();
  final SyncService _syncService = SyncService();

  Future<List<RepackagingRule>> getRepackagingRules(
    String organizationId, {
    bool? activeOnly,
    String? sourceProductId,
    String? targetProductId,
  }) async {
    final db = await _database.database;
    String query = 'SELECT * FROM repackaging_rules WHERE organization_id = ?';
    List<dynamic> args = [organizationId];

    if (activeOnly == true) {
      query += ' AND is_active = 1';
    }

    if (sourceProductId != null) {
      query += ' AND source_product_id = ?';
      args.add(sourceProductId);
    }

    if (targetProductId != null) {
      query += ' AND target_product_id = ?';
      args.add(targetProductId);
    }

    query += ' ORDER BY name ASC';

    final results = await db.rawQuery(query, args);
    return results.map((map) => RepackagingRule.fromMap(map)).toList();
  }

  Future<RepackagingRule?> getRepackagingRule(String ruleId) async {
    final db = await _database.database;
    final results = await db.query(
      'repackaging_rules',
      where: 'id = ?',
      whereArgs: [ruleId],
    );

    if (results.isEmpty) return null;
    return RepackagingRule.fromMap(results.first);
  }

  Future<String> createRepackagingRule(RepackagingRule rule) async {
    final db = await _database.database;
    final id = rule.id.isEmpty
        ? DateTime.now().millisecondsSinceEpoch.toString()
        : rule.id;

    await db.insert(
      'repackaging_rules',
      rule.copyWith(id: id).toMap(),
    );

    await _syncService.addToQueue(
      'repackaging_rules',
      id,
      'create',
      rule.toMap(),
    );

    return id;
  }

  Future<void> updateRepackagingRule(
    String ruleId,
    RepackagingRule rule,
  ) async {
    final db = await _database.database;
    
    await db.update(
      'repackaging_rules',
      rule.copyWith(
        updatedAt: DateTime.now(),
      ).toMap(),
      where: 'id = ?',
      whereArgs: [ruleId],
    );

    await _syncService.addToQueue(
      'repackaging_rules',
      ruleId,
      'update',
      rule.toMap(),
    );
  }

  Future<void> deleteRepackagingRule(String ruleId) async {
    final db = await _database.database;
    
    await db.delete(
      'repackaging_rules',
      where: 'id = ?',
      whereArgs: [ruleId],
    );

    await _syncService.addToQueue(
      'repackaging_rules',
      ruleId,
      'delete',
      {},
    );
  }

  // Check if repackaging is possible
  Future<Map<String, dynamic>> checkRepackagingPossibility(
    String ruleId,
    String branchId,
    double sourceQuantity,
  ) async {
    final rule = await getRepackagingRule(ruleId);
    if (rule == null) {
      throw Exception('Repackaging rule not found');
    }

    final sourceInventory = await _branchService.getBranchInventory(
      branchId,
      rule.sourceProductId,
    );

    final sourceProduct = await _productService.getProduct(rule.sourceProductId);
    final targetProduct = await _productService.getProduct(rule.targetProductId);

    final availableQuantity = sourceInventory?.availableStock ?? 0;
    final canRepackage = availableQuantity >= sourceQuantity;
    final targetQuantity = sourceQuantity * rule.conversionFactor;

    return {
      'canRepackage': canRepackage,
      'sourceProduct': sourceProduct?.name ?? 'Unknown',
      'targetProduct': targetProduct?.name ?? 'Unknown',
      'sourceQuantityAvailable': availableQuantity,
      'sourceQuantityRequired': sourceQuantity,
      'targetQuantityOutput': targetQuantity,
      'conversionFactor': rule.conversionFactor,
    };
  }

  // Execute repackaging
  Future<String> executeRepackaging(
    String ruleId,
    String branchId,
    double sourceQuantity,
    String performedBy,
    String? notes,
  ) async {
    final rule = await getRepackagingRule(ruleId);
    if (rule == null) {
      throw Exception('Repackaging rule not found');
    }

    // Check possibility first
    final possibility = await checkRepackagingPossibility(
      ruleId,
      branchId,
      sourceQuantity,
    );

    if (!possibility['canRepackage']) {
      throw Exception('Insufficient source product stock');
    }

    final db = await _database.database;
    final repackagingId = DateTime.now().millisecondsSinceEpoch.toString();
    final targetQuantity = sourceQuantity * rule.conversionFactor;

    await db.transaction((txn) async {
      // Create repackaging log
      await txn.insert('repackaging_logs', {
        'id': repackagingId,
        'organization_id': rule.organizationId,
        'rule_id': ruleId,
        'branch_id': branchId,
        'source_quantity': sourceQuantity,
        'target_quantity': targetQuantity,
        'performed_by': performedBy,
        'notes': notes,
        'created_at': DateTime.now().millisecondsSinceEpoch,
      });

      // Deduct source product stock
      await _branchService.updateBranchInventory(
        branchId,
        rule.sourceProductId,
        -sourceQuantity,
      );

      // Add target product stock
      await _branchService.updateBranchInventory(
        branchId,
        rule.targetProductId,
        targetQuantity,
      );

      // Create inventory movements
      final sourceProduct = await _productService.getProduct(rule.sourceProductId);
      final targetProduct = await _productService.getProduct(rule.targetProductId);

      // Out movement for source product
      await txn.insert('inventory_movements', {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'organization_id': rule.organizationId,
        'product_id': rule.sourceProductId,
        'type': 'out',
        'quantity': sourceQuantity,
        'reason': 'Repackaged to ${targetProduct?.name ?? 'target product'}',
        'reference_id': repackagingId,
        'reference_type': 'repackaging',
        'performed_by': performedBy,
        'created_at': DateTime.now().millisecondsSinceEpoch,
      });

      // In movement for target product
      await txn.insert('inventory_movements', {
        'id': (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        'organization_id': rule.organizationId,
        'product_id': rule.targetProductId,
        'type': 'in',
        'quantity': targetQuantity,
        'reason': 'Repackaged from ${sourceProduct?.name ?? 'source product'}',
        'reference_id': repackagingId,
        'reference_type': 'repackaging',
        'performed_by': performedBy,
        'created_at': DateTime.now().millisecondsSinceEpoch,
      });

      // Add to sync queue
      await _syncService.addToQueue(
        'repackaging_logs',
        repackagingId,
        'create',
        {
          'rule_id': ruleId,
          'branch_id': branchId,
          'source_quantity': sourceQuantity,
          'target_quantity': targetQuantity,
        },
      );
    });

    return repackagingId;
  }

  // Get repackaging history
  Future<List<Map<String, dynamic>>> getRepackagingHistory(
    String organizationId, {
    String? branchId,
    String? ruleId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final db = await _database.database;
    String query = '''
      SELECT rl.*, rr.name as rule_name, rr.source_product_id, rr.target_product_id
      FROM repackaging_logs rl
      JOIN repackaging_rules rr ON rl.rule_id = rr.id
      WHERE rl.organization_id = ?
    ''';
    List<dynamic> args = [organizationId];

    if (branchId != null) {
      query += ' AND rl.branch_id = ?';
      args.add(branchId);
    }

    if (ruleId != null) {
      query += ' AND rl.rule_id = ?';
      args.add(ruleId);
    }

    if (startDate != null) {
      query += ' AND rl.created_at >= ?';
      args.add(startDate.millisecondsSinceEpoch);
    }

    if (endDate != null) {
      query += ' AND rl.created_at <= ?';
      args.add(endDate.millisecondsSinceEpoch);
    }

    query += ' ORDER BY rl.created_at DESC';

    final results = await db.rawQuery(query, args);
    
    // Enrich with product names
    final enrichedResults = <Map<String, dynamic>>[];
    for (final log in results) {
      final sourceProduct = await _productService.getProduct(
        log['source_product_id'] as String,
      );
      final targetProduct = await _productService.getProduct(
        log['target_product_id'] as String,
      );

      enrichedResults.add({
        ...log,
        'source_product_name': sourceProduct?.name ?? 'Unknown',
        'target_product_name': targetProduct?.name ?? 'Unknown',
      });
    }

    return enrichedResults;
  }

  // Analytics
  Future<Map<String, dynamic>> getRepackagingStats(
    String organizationId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final db = await _database.database;
    
    String dateFilter = '';
    List<dynamic> args = [organizationId];

    if (startDate != null) {
      dateFilter += ' AND created_at >= ?';
      args.add(startDate.millisecondsSinceEpoch);
    }

    if (endDate != null) {
      dateFilter += ' AND created_at <= ?';
      args.add(endDate.millisecondsSinceEpoch);
    }

    final totalCount = await db.rawQuery(
      'SELECT COUNT(*) as count FROM repackaging_logs WHERE organization_id = ?$dateFilter',
      args,
    );

    final totalSourceQuantity = await db.rawQuery(
      'SELECT SUM(source_quantity) as total FROM repackaging_logs WHERE organization_id = ?$dateFilter',
      args,
    );

    final totalTargetQuantity = await db.rawQuery(
      'SELECT SUM(target_quantity) as total FROM repackaging_logs WHERE organization_id = ?$dateFilter',
      args,
    );

    final mostUsedRules = await db.rawQuery('''
      SELECT rr.name, COUNT(*) as usage_count
      FROM repackaging_logs rl
      JOIN repackaging_rules rr ON rl.rule_id = rr.id
      WHERE rl.organization_id = ?$dateFilter
      GROUP BY rr.id, rr.name
      ORDER BY usage_count DESC
      LIMIT 5
    ''', args);

    return {
      'total_repackaging_operations': totalCount.first['count'] ?? 0,
      'total_source_quantity': totalSourceQuantity.first['total'] ?? 0.0,
      'total_target_quantity': totalTargetQuantity.first['total'] ?? 0.0,
      'most_used_rules': mostUsedRules,
    };
  }

  // Get available rules for a product
  Future<List<RepackagingRule>> getAvailableRulesForProduct(
    String organizationId,
    String productId,
  ) async {
    final db = await _database.database;
    final results = await db.query(
      'repackaging_rules',
      where: 'organization_id = ? AND (source_product_id = ? OR target_product_id = ?) AND is_active = 1',
      whereArgs: [organizationId, productId, productId],
    );

    return results.map((map) => RepackagingRule.fromMap(map)).toList();
  }
}