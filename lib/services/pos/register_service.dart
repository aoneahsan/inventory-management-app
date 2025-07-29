import 'dart:convert';
import '../../domain/entities/register.dart';
import '../../core/errors/exceptions.dart';
import '../database/database.dart';
import '../sync/sync_service.dart';

class RegisterService {
  final AppDatabase _database;
  final SyncService _syncService;

  RegisterService({
    required AppDatabase database,
    required SyncService syncService,
  })  : _database = database,
        _syncService = syncService;

  // Open register
  Future<Register> openRegister({
    required String organizationId,
    required String name,
    required double openingBalance,
    required String userId,
    String? location,
  }) async {
    final db = await _database.database;
    
    // Check if register already exists and is open
    final existingRegisters = await db.query(
      'registers',
      where: 'organization_id = ? AND name = ? AND status = ?',
      whereArgs: [organizationId, name, RegisterStatus.open],
    );

    if (existingRegisters.isNotEmpty) {
      throw BusinessException('Register "$name" is already open');
    }

    final now = DateTime.now();
    final register = Register(
      id: now.millisecondsSinceEpoch.toString(),
      organizationId: organizationId,
      name: name,
      location: location,
      openingBalance: openingBalance,
      currentBalance: openingBalance,
      expectedBalance: openingBalance,
      status: RegisterStatus.open,
      openedBy: userId,
      openedAt: now,
      createdAt: now,
      updatedAt: now,
    );

    await db.insert('registers', {
      'id': register.id,
      'organization_id': register.organizationId,
      'name': register.name,
      'location': register.location,
      'opening_balance': register.openingBalance,
      'current_balance': register.currentBalance,
      'expected_balance': register.expectedBalance,
      'status': register.status,
      'opened_by': register.openedBy,
      'opened_at': register.openedAt.millisecondsSinceEpoch,
      'created_at': register.createdAt.millisecondsSinceEpoch,
      'updated_at': register.updatedAt.millisecondsSinceEpoch,
    });

    await _syncService.queueForSync('registers', 'create', register.id, register.toJson());

    return register;
  }

  // Close register
  Future<Register> closeRegister({
    required String registerId,
    required String userId,
    required Map<String, int> denominations,
  }) async {
    final db = await _database.database;
    
    final register = await getRegister(registerId);
    if (register == null) {
      throw BusinessException('Register not found');
    }

    if (register.status != RegisterStatus.open) {
      throw BusinessException('Register is not open');
    }

    final actualBalance = _calculateDenominationTotal(denominations);
    final now = DateTime.now();

    final updatedRegister = register.copyWith(
      currentBalance: actualBalance,
      status: RegisterStatus.closed,
      closedBy: userId,
      closedAt: now,
      denominations: denominations,
      updatedAt: now,
    );

    await db.update(
      'registers',
      {
        'current_balance': updatedRegister.currentBalance,
        'status': updatedRegister.status,
        'closed_by': updatedRegister.closedBy,
        'closed_at': updatedRegister.closedAt!.millisecondsSinceEpoch,
        'denominations': jsonEncode(updatedRegister.denominations),
        'updated_at': updatedRegister.updatedAt.millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [registerId],
    );

    await _syncService.queueForSync('registers', 'update', registerId, updatedRegister.toJson());

    return updatedRegister;
  }

  // Add transaction
  Future<RegisterTransaction> addTransaction({
    required String registerId,
    required String type,
    required double amount,
    required String performedBy,
    String? reason,
  }) async {
    final db = await _database.database;
    
    final register = await getRegister(registerId);
    if (register == null) {
      throw BusinessException('Register not found');
    }

    if (register.status != RegisterStatus.open) {
      throw BusinessException('Register is not open');
    }

    final now = DateTime.now();
    final transaction = RegisterTransaction(
      id: now.millisecondsSinceEpoch.toString(),
      registerId: registerId,
      type: type,
      amount: amount,
      reason: reason,
      performedBy: performedBy,
      createdAt: now,
    );

    await db.transaction((txn) async {
      // Insert transaction
      await txn.insert('register_transactions', {
        'id': transaction.id,
        'register_id': transaction.registerId,
        'type': transaction.type,
        'amount': transaction.amount,
        'reason': transaction.reason,
        'performed_by': transaction.performedBy,
        'created_at': transaction.createdAt.millisecondsSinceEpoch,
      });

      // Update register balances
      double balanceChange = 0;
      switch (type) {
        case RegisterTransactionType.sale:
        case RegisterTransactionType.cashIn:
          balanceChange = amount;
          break;
        case RegisterTransactionType.refund:
        case RegisterTransactionType.cashOut:
          balanceChange = -amount;
          break;
      }

      await txn.rawUpdate(
        'UPDATE registers SET current_balance = current_balance + ?, '
        'expected_balance = expected_balance + ?, updated_at = ? WHERE id = ?',
        [balanceChange, balanceChange, now.millisecondsSinceEpoch, registerId],
      );
    });

    await _syncService.queueForSync('register_transactions', 'create', transaction.id, transaction.toJson());

    return transaction;
  }

  // Get register
  Future<Register?> getRegister(String id) async {
    final db = await _database.database;
    final results = await db.query('registers', where: 'id = ?', whereArgs: [id]);
    
    if (results.isEmpty) return null;

    return _registerFromMap(results.first);
  }

  // Get open registers
  Future<List<Register>> getOpenRegisters(String organizationId) async {
    final db = await _database.database;
    final results = await db.query(
      'registers',
      where: 'organization_id = ? AND status = ?',
      whereArgs: [organizationId, RegisterStatus.open],
    );

    return results.map(_registerFromMap).toList();
  }

  // Get register transactions
  Future<List<RegisterTransaction>> getTransactions(String registerId) async {
    final db = await _database.database;
    final results = await db.query(
      'register_transactions',
      where: 'register_id = ?',
      whereArgs: [registerId],
      orderBy: 'created_at DESC',
    );

    return results.map((row) {
      return RegisterTransaction(
        id: row['id'] as String,
        registerId: row['register_id'] as String,
        type: row['type'] as String,
        amount: (row['amount'] as num).toDouble(),
        reason: row['reason'] as String?,
        performedBy: row['performed_by'] as String,
        createdAt: DateTime.fromMillisecondsSinceEpoch(row['created_at'] as int),
      );
    }).toList();
  }

  Register _registerFromMap(Map<String, dynamic> row) {
    return Register(
      id: row['id'] as String,
      organizationId: row['organization_id'] as String,
      name: row['name'] as String,
      location: row['location'] as String?,
      openingBalance: (row['opening_balance'] as num).toDouble(),
      currentBalance: (row['current_balance'] as num).toDouble(),
      expectedBalance: (row['expected_balance'] as num).toDouble(),
      status: row['status'] as String,
      openedBy: row['opened_by'] as String,
      openedAt: DateTime.fromMillisecondsSinceEpoch(row['opened_at'] as int),
      closedBy: row['closed_by'] as String?,
      closedAt: row['closed_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(row['closed_at'] as int)
          : null,
      denominations: row['denominations'] != null
          ? Map<String, int>.from(jsonDecode(row['denominations'] as String))
          : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(row['created_at'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(row['updated_at'] as int),
    );
  }

  double _calculateDenominationTotal(Map<String, int> denominations) {
    double total = 0;
    denominations.forEach((denomination, count) {
      final value = double.tryParse(denomination) ?? 0;
      total += value * count;
    });
    return total;
  }
}