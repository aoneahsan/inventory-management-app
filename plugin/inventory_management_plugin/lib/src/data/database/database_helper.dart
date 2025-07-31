import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';
import 'database_schema.dart';
import 'table_definitions.dart';

/// Database helper class for managing SQLite database
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();
  
  static Database? _database;
  final _databaseLock = Completer<void>();
  bool _isInitializing = false;
  
  /// Get database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    
    // Prevent multiple initialization
    if (_isInitializing) {
      await _databaseLock.future;
      return _database!;
    }
    
    _isInitializing = true;
    _database = await _initDatabase();
    _databaseLock.complete();
    _isInitializing = false;
    
    return _database!;
  }
  
  /// Initialize database
  Future<Database> _initDatabase() async {
    try {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, DatabaseSchema.databaseName);
      
      if (kDebugMode) {
        print('Database path: $path');
      }
      
      return await openDatabase(
        path,
        version: DatabaseSchema.databaseVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onOpen: _onOpen,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing database: $e');
      }
      rethrow;
    }
  }
  
  /// Create database tables
  Future<void> _onCreate(Database db, int version) async {
    if (kDebugMode) {
      print('Creating database version $version');
    }
    
    // Create all tables
    final batch = db.batch();
    
    for (final statement in TableDefinitions.getAllTableCreationStatements()) {
      batch.execute(statement);
    }
    
    // Create indexes
    for (final statement in TableDefinitions.getAllIndexCreationStatements()) {
      batch.execute(statement);
    }
    
    await batch.commit(noResult: true);
    
    if (kDebugMode) {
      print('Database created successfully');
    }
  }
  
  /// Upgrade database
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (kDebugMode) {
      print('Upgrading database from version $oldVersion to $newVersion');
    }
    
    // Handle database migrations here
    // For now, we'll just recreate the database
    // In production, you would want to preserve data
    
    // Drop all existing tables
    final tables = await db.query(
      'sqlite_master',
      where: 'type = ?',
      whereArgs: ['table'],
    );
    
    final batch = db.batch();
    for (final table in tables) {
      final tableName = table['name'] as String;
      if (!tableName.startsWith('sqlite_')) {
        batch.execute('DROP TABLE IF EXISTS $tableName');
      }
    }
    await batch.commit(noResult: true);
    
    // Recreate tables
    await _onCreate(db, newVersion);
  }
  
  /// Called when database is opened
  Future<void> _onOpen(Database db) async {
    // Enable foreign keys
    await db.execute('PRAGMA foreign_keys = ON');
    
    if (kDebugMode) {
      print('Database opened successfully');
    }
  }
  
  /// Close database
  Future<void> close() async {
    final db = _database;
    _database = null;
    
    if (db != null && db.isOpen) {
      await db.close();
    }
  }
  
  /// Delete database
  Future<void> deleteDatabase() async {
    await close();
    
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, DatabaseSchema.databaseName);
    
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
    
    if (kDebugMode) {
      print('Database deleted');
    }
  }
  
  /// Execute raw SQL query
  Future<List<Map<String, dynamic>>> rawQuery(String sql, [List<dynamic>? arguments]) async {
    final db = await database;
    return await db.rawQuery(sql, arguments);
  }
  
  /// Execute raw SQL command
  Future<void> execute(String sql, [List<dynamic>? arguments]) async {
    final db = await database;
    await db.execute(sql, arguments);
  }
  
  /// Begin transaction
  Future<T> transaction<T>(Future<T> Function(Transaction txn) action) async {
    final db = await database;
    return await db.transaction(action);
  }
  
  /// Insert data
  Future<int> insert(String table, Map<String, dynamic> values) async {
    final db = await database;
    return await db.insert(
      table,
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  
  /// Insert batch
  Future<void> insertBatch(String table, List<Map<String, dynamic>> values) async {
    if (values.isEmpty) return;
    
    final db = await database;
    final batch = db.batch();
    
    for (final value in values) {
      batch.insert(
        table,
        value,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    
    await batch.commit(noResult: true);
  }
  
  /// Query data
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
    final db = await database;
    return await db.query(
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
  
  /// Update data
  Future<int> update(
    String table,
    Map<String, dynamic> values, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final db = await database;
    return await db.update(
      table,
      values,
      where: where,
      whereArgs: whereArgs,
    );
  }
  
  /// Delete data
  Future<int> delete(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final db = await database;
    return await db.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }
  
  /// Get count
  Future<int> count(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final db = await database;
    final result = await db.query(
      table,
      columns: ['COUNT(*) as count'],
      where: where,
      whereArgs: whereArgs,
    );
    
    return Sqflite.firstIntValue(result) ?? 0;
  }
  
  /// Check if record exists
  Future<bool> exists(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final count = await this.count(
      table,
      where: where,
      whereArgs: whereArgs,
    );
    return count > 0;
  }
  
  /// Get database info
  Future<Map<String, dynamic>> getDatabaseInfo() async {
    final db = await database;
    final version = await db.getVersion();
    final path = db.path;
    
    // Get table count
    final tables = await db.query(
      'sqlite_master',
      where: 'type = ?',
      whereArgs: ['table'],
    );
    
    // Get total record count
    int totalRecords = 0;
    for (final table in tables) {
      final tableName = table['name'] as String;
      if (!tableName.startsWith('sqlite_')) {
        final count = await this.count(tableName);
        totalRecords += count;
      }
    }
    
    return {
      'version': version,
      'path': path,
      'tableCount': tables.length,
      'totalRecords': totalRecords,
    };
  }
}