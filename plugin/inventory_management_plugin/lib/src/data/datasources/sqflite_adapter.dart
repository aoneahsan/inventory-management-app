import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../core/interfaces/database_adapter.dart';

class SqfliteAdapter implements DatabaseAdapter {
  Database? _database;
  
  @override
  Future<void> initialize(String databaseName, int version) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, '$databaseName.db');
    
    _database = await openDatabase(
      path,
      version: version,
      onCreate: (db, version) async {
        // Database creation will be handled by the plugin
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Migration will be handled by the plugin
      },
    );
  }
  
  @override
  Future<void> close() async {
    await _database?.close();
    _database = null;
  }
  
  Database get _db {
    if (_database == null) {
      throw Exception('Database not initialized. Call initialize() first.');
    }
    return _database!;
  }
  
  @override
  Future<int> insert(String table, Map<String, dynamic> data) async {
    return await _db.insert(table, data);
  }
  
  @override
  Future<List<Map<String, dynamic>>> query(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<dynamic>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    return await _db.query(
      table,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }
  
  @override
  Future<int> update(
    String table,
    Map<String, dynamic> values, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    return await _db.update(
      table,
      values,
      where: where,
      whereArgs: whereArgs,
    );
  }
  
  @override
  Future<int> delete(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    return await _db.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }
  
  @override
  Future<List<Map<String, dynamic>>> rawQuery(String sql, [List<dynamic>? arguments]) async {
    return await _db.rawQuery(sql, arguments);
  }
  
  @override
  Future<int> rawInsert(String sql, [List<dynamic>? arguments]) async {
    return await _db.rawInsert(sql, arguments);
  }
  
  @override
  Future<int> rawUpdate(String sql, [List<dynamic>? arguments]) async {
    return await _db.rawUpdate(sql, arguments);
  }
  
  @override
  Future<int> rawDelete(String sql, [List<dynamic>? arguments]) async {
    return await _db.rawDelete(sql, arguments);
  }
  
  @override
  Future<T> transaction<T>(Future<T> Function(DatabaseTransaction txn) action) async {
    return await _db.transaction((txn) async {
      return await action(SqfliteTransaction(txn));
    });
  }
  
  @override
  Future<List<dynamic>> batch(void Function(DatabaseBatch batch) actions) async {
    final batch = _db.batch();
    actions(SqfliteBatch(batch));
    return await batch.commit();
  }
  
  @override
  Future<bool> tableExists(String table) async {
    final result = await _db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
      [table],
    );
    return result.isNotEmpty;
  }
  
  @override
  Future<void> createTable(String table, String schema) async {
    await _db.execute('CREATE TABLE IF NOT EXISTS $table ($schema)');
  }
  
  @override
  Future<void> dropTable(String table) async {
    await _db.execute('DROP TABLE IF EXISTS $table');
  }
  
  @override
  Future<void> execute(String sql) async {
    await _db.execute(sql);
  }
  
  @override
  Future<int> getVersion() async {
    return _db.getVersion();
  }
  
  @override
  Future<void> setVersion(int version) async {
    await _db.setVersion(version);
  }
}

class SqfliteTransaction implements DatabaseTransaction {
  final Transaction _txn;
  
  SqfliteTransaction(this._txn);
  
  @override
  Future<int> insert(String table, Map<String, dynamic> data) async {
    return await _txn.insert(table, data);
  }
  
  @override
  Future<List<Map<String, dynamic>>> query(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<dynamic>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    return await _txn.query(
      table,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }
  
  @override
  Future<int> update(
    String table,
    Map<String, dynamic> values, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    return await _txn.update(
      table,
      values,
      where: where,
      whereArgs: whereArgs,
    );
  }
  
  @override
  Future<int> delete(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    return await _txn.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }
  
  @override
  Future<List<Map<String, dynamic>>> rawQuery(String sql, [List<dynamic>? arguments]) async {
    return await _txn.rawQuery(sql, arguments);
  }
  
  @override
  Future<int> rawInsert(String sql, [List<dynamic>? arguments]) async {
    return await _txn.rawInsert(sql, arguments);
  }
  
  @override
  Future<int> rawUpdate(String sql, [List<dynamic>? arguments]) async {
    return await _txn.rawUpdate(sql, arguments);
  }
  
  @override
  Future<int> rawDelete(String sql, [List<dynamic>? arguments]) async {
    return await _txn.rawDelete(sql, arguments);
  }
  
  @override
  Future<void> execute(String sql) async {
    await _txn.execute(sql);
  }
}

class SqfliteBatch implements DatabaseBatch {
  final Batch _batch;
  
  SqfliteBatch(this._batch);
  
  @override
  void insert(String table, Map<String, dynamic> data) {
    _batch.insert(table, data);
  }
  
  @override
  void update(
    String table,
    Map<String, dynamic> values, {
    String? where,
    List<dynamic>? whereArgs,
  }) {
    _batch.update(
      table,
      values,
      where: where,
      whereArgs: whereArgs,
    );
  }
  
  @override
  void delete(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  }) {
    _batch.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }
  
  @override
  void rawInsert(String sql, [List<dynamic>? arguments]) {
    _batch.rawInsert(sql, arguments);
  }
  
  @override
  void rawUpdate(String sql, [List<dynamic>? arguments]) {
    _batch.rawUpdate(sql, arguments);
  }
  
  @override
  void rawDelete(String sql, [List<dynamic>? arguments]) {
    _batch.rawDelete(sql, arguments);
  }
  
  @override
  void execute(String sql) {
    _batch.execute(sql);
  }
  
  @override
  Future<List<dynamic>> commit() async {
    return await _batch.commit();
  }
}