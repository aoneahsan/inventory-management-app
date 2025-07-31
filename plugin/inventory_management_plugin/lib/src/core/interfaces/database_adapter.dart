abstract class DatabaseAdapter {
  Future<void> initialize(String databaseName, int version);
  Future<void> close();
  
  // Basic CRUD operations
  Future<int> insert(String table, Map<String, dynamic> data);
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
  });
  Future<int> update(
    String table,
    Map<String, dynamic> values, {
    String? where,
    List<dynamic>? whereArgs,
  });
  Future<int> delete(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  });
  
  // Raw queries
  Future<List<Map<String, dynamic>>> rawQuery(String sql, [List<dynamic>? arguments]);
  Future<int> rawInsert(String sql, [List<dynamic>? arguments]);
  Future<int> rawUpdate(String sql, [List<dynamic>? arguments]);
  Future<int> rawDelete(String sql, [List<dynamic>? arguments]);
  
  // Transaction support
  Future<T> transaction<T>(Future<T> Function(DatabaseTransaction txn) action);
  
  // Batch operations
  Future<List<dynamic>> batch(void Function(DatabaseBatch batch) actions);
  
  // Database management
  Future<bool> tableExists(String table);
  Future<void> createTable(String table, String schema);
  Future<void> dropTable(String table);
  Future<void> execute(String sql);
  
  // Migration support
  Future<int> getVersion();
  Future<void> setVersion(int version);
}

abstract class DatabaseTransaction {
  Future<int> insert(String table, Map<String, dynamic> data);
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
  });
  Future<int> update(
    String table,
    Map<String, dynamic> values, {
    String? where,
    List<dynamic>? whereArgs,
  });
  Future<int> delete(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  });
  Future<List<Map<String, dynamic>>> rawQuery(String sql, [List<dynamic>? arguments]);
  Future<int> rawInsert(String sql, [List<dynamic>? arguments]);
  Future<int> rawUpdate(String sql, [List<dynamic>? arguments]);
  Future<int> rawDelete(String sql, [List<dynamic>? arguments]);
  Future<void> execute(String sql);
}

abstract class DatabaseBatch {
  void insert(String table, Map<String, dynamic> data);
  void update(
    String table,
    Map<String, dynamic> values, {
    String? where,
    List<dynamic>? whereArgs,
  });
  void delete(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  });
  void rawInsert(String sql, [List<dynamic>? arguments]);
  void rawUpdate(String sql, [List<dynamic>? arguments]);
  void rawDelete(String sql, [List<dynamic>? arguments]);
  void execute(String sql);
  Future<List<dynamic>> commit();
}