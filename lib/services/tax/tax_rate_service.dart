import '../../domain/entities/tax_rate.dart';
import '../database/database.dart';
import '../sync/sync_service.dart';

class TaxRateService {
  final AppDatabase _database = AppDatabase.instance;
  final SyncService _syncService = SyncService();

  Future<List<TaxRate>> getTaxRates(
    String organizationId, {
    bool? activeOnly,
    TaxType? type,
    String? searchQuery,
  }) async {
    final db = await _database.database;
    String query = 'SELECT * FROM tax_rates WHERE organization_id = ?';
    List<dynamic> args = [organizationId];

    if (activeOnly == true) {
      query += ' AND is_active = 1';
    }

    if (type != null) {
      query += ' AND type = ?';
      args.add(type.value);
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query += ' AND (name LIKE ? OR hsn_code LIKE ?)';
      final pattern = '%$searchQuery%';
      args.addAll([pattern, pattern]);
    }

    query += ' ORDER BY rate DESC, name ASC';

    final results = await db.rawQuery(query, args);
    return results.map((map) => TaxRate.fromMap(map)).toList();
  }

  Future<TaxRate?> getTaxRate(String taxRateId) async {
    final db = await _database.database;
    final results = await db.query(
      'tax_rates',
      where: 'id = ?',
      whereArgs: [taxRateId],
    );

    if (results.isEmpty) return null;
    return TaxRate.fromMap(results.first);
  }

  Future<TaxRate?> getTaxRateByHSN(
    String organizationId,
    String hsnCode,
  ) async {
    final db = await _database.database;
    final results = await db.query(
      'tax_rates',
      where: 'organization_id = ? AND hsn_code = ? AND is_active = 1',
      whereArgs: [organizationId, hsnCode],
    );

    if (results.isEmpty) return null;
    return TaxRate.fromMap(results.first);
  }

  Future<String> createTaxRate(TaxRate taxRate) async {
    final db = await _database.database;
    final id = taxRate.id.isEmpty
        ? DateTime.now().millisecondsSinceEpoch.toString()
        : taxRate.id;

    await db.insert(
      'tax_rates',
      taxRate.copyWith(id: id).toMap(),
    );

    await _syncService.addToQueue(
      'tax_rates',
      id,
      'create',
      taxRate.toMap(),
    );

    return id;
  }

  Future<void> updateTaxRate(
    String taxRateId,
    TaxRate taxRate,
  ) async {
    final db = await _database.database;
    
    await db.update(
      'tax_rates',
      taxRate.copyWith(
        updatedAt: DateTime.now(),
      ).toMap(),
      where: 'id = ?',
      whereArgs: [taxRateId],
    );

    await _syncService.addToQueue(
      'tax_rates',
      taxRateId,
      'update',
      taxRate.toMap(),
    );
  }

  Future<void> deleteTaxRate(String taxRateId) async {
    final db = await _database.database;
    
    await db.delete(
      'tax_rates',
      where: 'id = ?',
      whereArgs: [taxRateId],
    );

    await _syncService.addToQueue(
      'tax_rates',
      taxRateId,
      'delete',
      {},
    );
  }

  // Tax Calculation Methods
  Future<TaxCalculationResult> calculateTax({
    required String organizationId,
    required double baseAmount,
    String? hsnCode,
    String? taxRateId,
    bool isInclusive = false,
  }) async {
    TaxRate? taxRate;

    if (taxRateId != null) {
      taxRate = await getTaxRate(taxRateId);
    } else if (hsnCode != null) {
      taxRate = await getTaxRateByHSN(organizationId, hsnCode);
    }

    if (taxRate == null) {
      // Return zero tax if no rate found
      return TaxCalculationResult(
        baseAmount: baseAmount,
        cgstAmount: 0,
        sgstAmount: 0,
        igstAmount: 0,
        cessAmount: 0,
        totalTax: 0,
        totalAmount: baseAmount,
      );
    }

    return _calculateTaxAmount(baseAmount, taxRate, isInclusive);
  }

  TaxCalculationResult _calculateTaxAmount(
    double baseAmount,
    TaxRate taxRate,
    bool isInclusive,
  ) {
    double actualBaseAmount = baseAmount;
    
    if (isInclusive) {
      // Calculate base amount from inclusive price
      final totalRate = (taxRate.cgstRate ?? 0) + 
                       (taxRate.sgstRate ?? 0) + 
                       (taxRate.igstRate ?? 0) + 
                       (taxRate.cessRate ?? 0);
      actualBaseAmount = baseAmount / (1 + totalRate / 100);
    }

    final cgstAmount = actualBaseAmount * (taxRate.cgstRate ?? 0) / 100;
    final sgstAmount = actualBaseAmount * (taxRate.sgstRate ?? 0) / 100;
    final igstAmount = actualBaseAmount * (taxRate.igstRate ?? 0) / 100;
    final cessAmount = actualBaseAmount * (taxRate.cessRate ?? 0) / 100;

    final totalTax = cgstAmount + sgstAmount + igstAmount + cessAmount;
    final totalAmount = actualBaseAmount + totalTax;

    return TaxCalculationResult(
      baseAmount: actualBaseAmount,
      cgstAmount: cgstAmount,
      sgstAmount: sgstAmount,
      igstAmount: igstAmount,
      cessAmount: cessAmount,
      totalTax: totalTax,
      totalAmount: totalAmount,
    );
  }

  // Get tax rates by type
  Future<List<TaxRate>> getGSTRates(String organizationId) async {
    return getTaxRates(organizationId, type: TaxType.gst, activeOnly: true);
  }

  Future<List<TaxRate>> getVATRates(String organizationId) async {
    return getTaxRates(organizationId, type: TaxType.vat, activeOnly: true);
  }

  Future<List<TaxRate>> getCustomRates(String organizationId) async {
    return getTaxRates(organizationId, type: TaxType.other, activeOnly: true);
  }

  // Get default tax rate
  Future<TaxRate?> getDefaultTaxRate(String organizationId) async {
    final db = await _database.database;
    final results = await db.query(
      'tax_rates',
      where: 'organization_id = ? AND is_default = 1 AND is_active = 1',
      whereArgs: [organizationId],
      limit: 1,
    );

    if (results.isEmpty) return null;
    return TaxRate.fromMap(results.first);
  }

  // Set default tax rate
  Future<void> setDefaultTaxRate(
    String organizationId,
    String taxRateId,
  ) async {
    final db = await _database.database;
    
    await db.transaction((txn) async {
      // Remove default from all other rates
      await txn.update(
        'tax_rates',
        {'is_default': 0},
        where: 'organization_id = ?',
        whereArgs: [organizationId],
      );

      // Set new default
      await txn.update(
        'tax_rates',
        {'is_default': 1},
        where: 'id = ?',
        whereArgs: [taxRateId],
      );
    });

    await _syncService.addToQueue(
      'tax_rates',
      taxRateId,
      'update',
      {'is_default': true},
    );
  }

  // Analytics
  Future<Map<String, dynamic>> getTaxStats(
    String organizationId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final db = await _database.database;
    
    final totalRates = await db.rawQuery(
      'SELECT COUNT(*) as count FROM tax_rates WHERE organization_id = ? AND is_active = 1',
      [organizationId],
    );

    final ratesByType = await db.rawQuery('''
      SELECT type, COUNT(*) as count
      FROM tax_rates
      WHERE organization_id = ? AND is_active = 1
      GROUP BY type
    ''', [organizationId]);

    final mostUsedRates = await db.rawQuery('''
      SELECT tr.name, tr.rate, COUNT(p.id) as product_count
      FROM tax_rates tr
      LEFT JOIN products p ON p.tax_rate_id = tr.id
      WHERE tr.organization_id = ?
      GROUP BY tr.id, tr.name, tr.rate
      ORDER BY product_count DESC
      LIMIT 5
    ''', [organizationId]);

    return {
      'total_active_rates': totalRates.first['count'] ?? 0,
      'rates_by_type': ratesByType,
      'most_used_rates': mostUsedRates,
    };
  }

  // Bulk operations
  Future<void> bulkCreateGSTRates(String organizationId) async {
    final standardGSTRates = [
      TaxRate(
        id: '',
        organizationId: organizationId,
        name: 'GST 0%',
        code: 'GST0',
        type: TaxType.gst,
        rate: 0,
        cgstRate: 0,
        sgstRate: 0,
        igstRate: 0,
        cessRate: 0,
        isCompound: false,
        isInclusive: false,
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      TaxRate(
        id: '',
        organizationId: organizationId,
        name: 'GST 5%',
        code: 'GST5',
        type: TaxType.gst,
        rate: 5,
        cgstRate: 2.5,
        sgstRate: 2.5,
        igstRate: 5,
        cessRate: 0,
        isCompound: false,
        isInclusive: false,
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      TaxRate(
        id: '',
        organizationId: organizationId,
        name: 'GST 12%',
        code: 'GST12',
        type: TaxType.gst,
        rate: 12,
        cgstRate: 6,
        sgstRate: 6,
        igstRate: 12,
        cessRate: 0,
        isCompound: false,
        isInclusive: false,
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      TaxRate(
        id: '',
        organizationId: organizationId,
        name: 'GST 18%',
        code: 'GST18',
        type: TaxType.gst,
        rate: 18,
        cgstRate: 9,
        sgstRate: 9,
        igstRate: 18,
        cessRate: 0,
        isCompound: false,
        isInclusive: false,
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      TaxRate(
        id: '',
        organizationId: organizationId,
        name: 'GST 28%',
        code: 'GST28',
        type: TaxType.gst,
        rate: 28,
        cgstRate: 14,
        sgstRate: 14,
        igstRate: 28,
        cessRate: 0,
        isCompound: false,
        isInclusive: false,
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    for (final rate in standardGSTRates) {
      await createTaxRate(rate);
    }
  }
}

class TaxCalculationResult {
  final double baseAmount;
  final double cgstAmount;
  final double sgstAmount;
  final double igstAmount;
  final double cessAmount;
  final double totalTax;
  final double totalAmount;

  TaxCalculationResult({
    required this.baseAmount,
    required this.cgstAmount,
    required this.sgstAmount,
    required this.igstAmount,
    required this.cessAmount,
    required this.totalTax,
    required this.totalAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'base_amount': baseAmount,
      'cgst_amount': cgstAmount,
      'sgst_amount': sgstAmount,
      'igst_amount': igstAmount,
      'cess_amount': cessAmount,
      'total_tax': totalTax,
      'total_amount': totalAmount,
    };
  }
}