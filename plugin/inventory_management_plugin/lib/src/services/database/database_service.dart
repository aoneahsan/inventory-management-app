import '../../core/interfaces/database_adapter.dart';
import 'database_schema.dart';

class DatabaseService {
  final DatabaseAdapter adapter;
  final String databaseName;
  final int version;
  
  DatabaseService({
    required this.adapter,
    required this.databaseName,
    required this.version,
  });
  
  Future<void> initialize() async {
    await adapter.initialize(databaseName, version);
    await _createTables();
    await _runMigrations();
  }
  
  Future<void> _createTables() async {
    final currentVersion = await adapter.getVersion();
    if (currentVersion == 0) {
      // First time setup - create all tables
      for (final table in DatabaseSchema.tables) {
        await adapter.createTable(table.name, table.schema);
      }
      
      // Create indexes
      for (final index in DatabaseSchema.indexes) {
        await adapter.execute(index);
      }
      
      await adapter.setVersion(version);
    }
  }
  
  Future<void> _runMigrations() async {
    final currentVersion = await adapter.getVersion();
    
    if (currentVersion < version) {
      // Run migrations
      for (int v = currentVersion + 1; v <= version; v++) {
        final migration = DatabaseSchema.getMigration(v);
        if (migration != null) {
          await adapter.transaction((txn) async {
            for (final sql in migration.upStatements) {
              await txn.execute(sql);
            }
          });
        }
      }
      
      await adapter.setVersion(version);
    }
  }
  
  // Generic CRUD operations
  Future<int> insert(String table, Map<String, dynamic> data) async {
    return await adapter.insert(table, data);
  }
  
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
    return await adapter.query(
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
  
  Future<int> update(
    String table,
    Map<String, dynamic> values, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    return await adapter.update(
      table,
      values,
      where: where,
      whereArgs: whereArgs,
    );
  }
  
  Future<int> delete(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    return await adapter.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }
  
  Future<T> transaction<T>(Future<T> Function(DatabaseTransaction txn) action) async {
    return await adapter.transaction(action);
  }
  
  Future<List<dynamic>> batch(void Function(DatabaseBatch batch) actions) async {
    return await adapter.batch(actions);
  }
  
  // Helper methods
  Future<Map<String, dynamic>?> findById(String table, String id) async {
    final results = await query(
      table,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return results.isEmpty ? null : results.first;
  }
  
  Future<bool> exists(String table, String id) async {
    final result = await adapter.rawQuery(
      'SELECT 1 FROM $table WHERE id = ? LIMIT 1',
      [id],
    );
    return result.isNotEmpty;
  }
  
  Future<int> count(String table, {String? where, List<dynamic>? whereArgs}) async {
    String query = 'SELECT COUNT(*) as count FROM $table';
    if (where != null) {
      query += ' WHERE $where';
    }
    
    final result = await adapter.rawQuery(query, whereArgs);
    return result.first['count'] as int;
  }
  
  // Clear all data (for testing)
  Future<void> clearAllData() async {
    await adapter.transaction((txn) async {
      for (final table in DatabaseSchema.tables) {
        await txn.delete(table.name);
      }
    });
  }
  
  // Export database
  Future<Map<String, List<Map<String, dynamic>>>> exportDatabase() async {
    final export = <String, List<Map<String, dynamic>>>{};
    
    for (final table in DatabaseSchema.tables) {
      export[table.name] = await query(table.name);
    }
    
    return export;
  }
  
  // Import database
  Future<void> importDatabase(Map<String, List<Map<String, dynamic>>> data) async {
    await adapter.transaction((txn) async {
      // Clear existing data
      for (final table in DatabaseSchema.tables) {
        await txn.delete(table.name);
      }
      
      // Import new data
      for (final entry in data.entries) {
        final tableName = entry.key;
        final records = entry.value;
        
        for (final record in records) {
          await txn.insert(tableName, record);
        }
      }
    });
  }
}