import '../../domain/entities/supplier.dart';
import '../../domain/entities/supplier_transaction.dart';
import '../../services/database/database.dart';
import '../../core/utils/id_generator.dart';

class SupplierService {
  final AppDatabase database;

  SupplierService({required this.database});

  // Supplier CRUD operations
  Future<List<Supplier>> getSuppliers(String organizationId, {
    String? searchQuery,
    String? status,
    int? limit,
    int? offset,
  }) async {
    final db = await database.database;
    String query = 'SELECT * FROM suppliers WHERE organization_id = ?';
    List<dynamic> args = [organizationId];

    if (status != null) {
      query += ' AND status = ?';
      args.add(status);
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query += ' AND (name LIKE ? OR code LIKE ? OR email LIKE ? OR phone LIKE ?)';
      final searchPattern = '%$searchQuery%';
      args.addAll([searchPattern, searchPattern, searchPattern, searchPattern]);
    }

    query += ' ORDER BY name ASC';

    if (limit != null) {
      query += ' LIMIT ?';
      args.add(limit);
      if (offset != null) {
        query += ' OFFSET ?';
        args.add(offset);
      }
    }

    final results = await db.rawQuery(query, args);
    return results.map((map) => Supplier.fromMap(map)).toList();
  }

  Future<Supplier?> getSupplierById(String supplierId) async {
    final db = await database.database;
    final results = await db.query(
      'suppliers',
      where: 'id = ?',
      whereArgs: [supplierId],
      limit: 1,
    );

    if (results.isEmpty) return null;
    return Supplier.fromMap(results.first);
  }

  Future<Supplier?> getSupplierByCode(String code) async {
    final db = await database.database;
    final results = await db.query(
      'suppliers',
      where: 'code = ?',
      whereArgs: [code],
      limit: 1,
    );

    if (results.isEmpty) return null;
    return Supplier.fromMap(results.first);
  }

  Future<Supplier> createSupplier(Supplier supplier) async {
    final db = await database.database;
    final now = DateTime.now();
    
    final newSupplier = supplier.copyWith(
      id: supplier.id.isEmpty ? IdGenerator.generateId() : supplier.id,
      createdAt: now,
      updatedAt: now,
    );

    await db.insert('suppliers', newSupplier.toMap());
    return newSupplier;
  }

  Future<Supplier> updateSupplier(String supplierId, Map<String, dynamic> updates) async {
    final db = await database.database;
    final existingSupplier = await getSupplierById(supplierId);
    if (existingSupplier == null) {
      throw Exception('Supplier not found');
    }

    final updatedData = {
      ...updates,
      'updated_at': DateTime.now().millisecondsSinceEpoch,
    };

    await db.update(
      'suppliers',
      updatedData,
      where: 'id = ?',
      whereArgs: [supplierId],
    );

    final updatedSupplier = await getSupplierById(supplierId);
    return updatedSupplier!;
  }

  Future<void> deleteSupplier(String supplierId) async {
    final db = await database.database;
    
    // Check if supplier has any transactions
    final transactionCount = await db.rawQuery(
      'SELECT COUNT(*) as count FROM supplier_transactions WHERE supplier_id = ?',
      [supplierId],
    );
    
    if ((transactionCount.first['count'] as int) > 0) {
      // Soft delete - mark as inactive
      await updateSupplier(supplierId, {'status': 'inactive'});
    } else {
      // Hard delete if no transactions
      await db.delete(
        'suppliers',
        where: 'id = ?',
        whereArgs: [supplierId],
      );
    }
  }

  // Supplier transaction operations
  Future<List<SupplierTransaction>> getSupplierTransactions(
    String supplierId, {
    String? transactionType,
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
  }) async {
    final db = await database.database;
    String query = 'SELECT * FROM supplier_transactions WHERE supplier_id = ?';
    List<dynamic> args = [supplierId];

    if (transactionType != null) {
      query += ' AND transaction_type = ?';
      args.add(transactionType);
    }

    if (startDate != null) {
      query += ' AND transaction_date >= ?';
      args.add(startDate.millisecondsSinceEpoch);
    }

    if (endDate != null) {
      query += ' AND transaction_date <= ?';
      args.add(endDate.millisecondsSinceEpoch);
    }

    query += ' ORDER BY transaction_date DESC, created_at DESC';

    if (limit != null) {
      query += ' LIMIT ?';
      args.add(limit);
    }

    final results = await db.rawQuery(query, args);
    return results.map((map) => SupplierTransaction.fromMap(map)).toList();
  }

  Future<void> recordTransaction({
    required String supplierId,
    required String transactionType,
    required double amount,
    String? referenceId,
    String? notes,
    DateTime? transactionDate,
  }) async {
    final db = await database.database;
    final supplier = await getSupplierById(supplierId);
    if (supplier == null) {
      throw Exception('Supplier not found');
    }

    // Calculate new balance
    double newBalance = supplier.currentBalance;
    if (transactionType == 'purchase' || transactionType == 'return') {
      newBalance += amount; // Increase what we owe
    } else if (transactionType == 'payment' || transactionType == 'credit_note') {
      newBalance -= amount; // Decrease what we owe
    }

    // Create transaction record
    final transaction = SupplierTransaction(
      id: IdGenerator.generateId(),
      supplierId: supplierId,
      transactionType: transactionType,
      referenceId: referenceId,
      amount: amount,
      balance: newBalance,
      transactionDate: transactionDate ?? DateTime.now(),
      notes: notes,
      createdAt: DateTime.now(),
    );

    // Use transaction to ensure consistency
    await db.transaction((txn) async {
      // Insert transaction
      await txn.insert('supplier_transactions', transaction.toMap());

      // Update supplier balance
      await txn.update(
        'suppliers',
        {
          'current_balance': newBalance,
          'updated_at': DateTime.now().millisecondsSinceEpoch,
        },
        where: 'id = ?',
        whereArgs: [supplierId],
      );
    });
  }

  // Analytics methods
  Future<Map<String, dynamic>> getSupplierStats(String organizationId) async {
    final db = await database.database;

    // Total suppliers
    final totalCount = await db.rawQuery(
      'SELECT COUNT(*) as count FROM suppliers WHERE organization_id = ? AND status = ?',
      [organizationId, 'active'],
    );

    // Suppliers with outstanding balance
    final outstandingCount = await db.rawQuery(
      'SELECT COUNT(*) as count FROM suppliers WHERE organization_id = ? AND status = ? AND current_balance > 0',
      [organizationId, 'active'],
    );

    // Total outstanding amount
    final outstandingAmount = await db.rawQuery(
      'SELECT SUM(current_balance) as total FROM suppliers WHERE organization_id = ? AND status = ?',
      [organizationId, 'active'],
    );

    // Top suppliers by balance
    final topSuppliers = await db.rawQuery(
      '''SELECT id, name, code, current_balance 
         FROM suppliers 
         WHERE organization_id = ? AND status = ? AND current_balance > 0
         ORDER BY current_balance DESC 
         LIMIT 5''',
      [organizationId, 'active'],
    );

    return {
      'total_suppliers': (totalCount.first['count'] as int),
      'suppliers_with_balance': (outstandingCount.first['count'] as int),
      'total_outstanding': (outstandingAmount.first['total'] ?? 0) as double,
      'top_suppliers': topSuppliers,
    };
  }

  // Validation methods
  Future<bool> isCodeUnique(String code, [String? excludeId]) async {
    final db = await database.database;
    String query = 'SELECT COUNT(*) as count FROM suppliers WHERE code = ?';
    List<dynamic> args = [code];

    if (excludeId != null) {
      query += ' AND id != ?';
      args.add(excludeId);
    }

    final result = await db.rawQuery(query, args);
    return (result.first['count'] as int) == 0;
  }

  Future<String> generateUniqueCode(String organizationId, String supplierName) async {
    // Generate code from supplier name (first 3 letters + number)
    final prefix = supplierName
        .replaceAll(RegExp(r'[^a-zA-Z]'), '')
        .toUpperCase()
        .padRight(3, 'X')
        .substring(0, 3);

    int counter = 1;
    String code;
    
    do {
      code = '$prefix${counter.toString().padLeft(3, '0')}';
      counter++;
    } while (!(await isCodeUnique(code)));

    return code;
  }
}