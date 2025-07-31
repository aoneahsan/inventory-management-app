import 'dart:async';

import '../../domain/repositories/base_repository.dart';
import '../database/database_helper.dart';
import '../models/base_model.dart';

/// Base repository implementation with common CRUD operations
abstract class BaseRepositoryImpl<T, M extends BaseModel> implements BaseRepository<T> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  
  /// Get table name for this repository
  String get tableName;
  
  /// Convert entity to model
  M toModel(T entity);
  
  /// Convert model to entity
  T fromModel(M model);
  
  /// Create model from database map
  M fromDatabase(Map<String, dynamic> map);
  
  @override
  Future<T> create(T entity) async {
    final model = toModel(entity);
    final id = await _databaseHelper.insert(tableName, model.toDatabase());
    
    // Return the entity with potentially updated fields
    final created = await getById(model.toDatabase()[model.primaryKey] as String);
    if (created == null) {
      throw Exception('Failed to create entity');
    }
    return created;
  }
  
  @override
  Future<List<T>> createMany(List<T> entities) async {
    if (entities.isEmpty) return [];
    
    final models = entities.map((e) => toModel(e)).toList();
    final values = models.map((m) => m.toDatabase()).toList();
    
    await _databaseHelper.insertBatch(tableName, values);
    
    // Return entities
    return entities;
  }
  
  @override
  Future<T?> getById(String id) async {
    final results = await _databaseHelper.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    
    if (results.isEmpty) return null;
    
    final model = fromDatabase(results.first);
    return fromModel(model);
  }
  
  @override
  Future<List<T>> getAll() async {
    final results = await _databaseHelper.query(tableName);
    
    return results.map((map) {
      final model = fromDatabase(map);
      return fromModel(model);
    }).toList();
  }
  
  @override
  Future<List<T>> getByOrganizationId(String organizationId) async {
    final results = await _databaseHelper.query(
      tableName,
      where: 'organization_id = ?',
      whereArgs: [organizationId],
    );
    
    return results.map((map) {
      final model = fromDatabase(map);
      return fromModel(model);
    }).toList();
  }
  
  @override
  Future<T> update(T entity) async {
    final model = toModel(entity);
    final map = model.toDatabase();
    final id = map[model.primaryKey] as String;
    
    final count = await _databaseHelper.update(
      tableName,
      map,
      where: '${model.primaryKey} = ?',
      whereArgs: [id],
    );
    
    if (count == 0) {
      throw Exception('Entity not found for update');
    }
    
    return entity;
  }
  
  @override
  Future<List<T>> updateMany(List<T> entities) async {
    if (entities.isEmpty) return [];
    
    await _databaseHelper.transaction((txn) async {
      for (final entity in entities) {
        final model = toModel(entity);
        final map = model.toDatabase();
        final id = map[model.primaryKey] as String;
        
        await txn.update(
          tableName,
          map,
          where: '${model.primaryKey} = ?',
          whereArgs: [id],
        );
      }
    });
    
    return entities;
  }
  
  @override
  Future<bool> delete(String id) async {
    final count = await _databaseHelper.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    
    return count > 0;
  }
  
  @override
  Future<bool> deleteMany(List<String> ids) async {
    if (ids.isEmpty) return true;
    
    final placeholders = List.filled(ids.length, '?').join(',');
    final count = await _databaseHelper.delete(
      tableName,
      where: 'id IN ($placeholders)',
      whereArgs: ids,
    );
    
    return count == ids.length;
  }
  
  @override
  Future<bool> exists(String id) async {
    return await _databaseHelper.exists(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  @override
  Future<int> count({String? organizationId}) async {
    if (organizationId != null) {
      return await _databaseHelper.count(
        tableName,
        where: 'organization_id = ?',
        whereArgs: [organizationId],
      );
    }
    
    return await _databaseHelper.count(tableName);
  }
  
  @override
  Future<List<T>> search(String query, {String? organizationId}) async {
    // Default implementation - override in specific repositories
    final results = await _databaseHelper.query(
      tableName,
      where: organizationId != null
          ? 'organization_id = ? AND (name LIKE ? OR code LIKE ?)'
          : '(name LIKE ? OR code LIKE ?)',
      whereArgs: organizationId != null
          ? [organizationId, '%$query%', '%$query%']
          : ['%$query%', '%$query%'],
    );
    
    return results.map((map) {
      final model = fromDatabase(map);
      return fromModel(model);
    }).toList();
  }
  
  @override
  Future<List<T>> getPaginated({
    required int page,
    required int pageSize,
    String? organizationId,
    String? orderBy,
    bool descending = false,
  }) async {
    final offset = (page - 1) * pageSize;
    final order = orderBy != null
        ? '$orderBy ${descending ? 'DESC' : 'ASC'}'
        : 'created_at DESC';
    
    final results = await _databaseHelper.query(
      tableName,
      where: organizationId != null ? 'organization_id = ?' : null,
      whereArgs: organizationId != null ? [organizationId] : null,
      orderBy: order,
      limit: pageSize,
      offset: offset,
    );
    
    return results.map((map) {
      final model = fromDatabase(map);
      return fromModel(model);
    }).toList();
  }
  
  @override
  Future<void> sync({String? organizationId}) async {
    // TODO: Implement sync with server
    // This would typically:
    // 1. Get unsynced entities
    // 2. Send to server
    // 3. Update local records with server response
    // 4. Mark as synced
  }
  
  @override
  Future<List<T>> getUnsyncedEntities({String? organizationId}) async {
    final results = await _databaseHelper.query(
      tableName,
      where: organizationId != null
          ? 'organization_id = ? AND synced_at IS NULL'
          : 'synced_at IS NULL',
      whereArgs: organizationId != null ? [organizationId] : null,
    );
    
    return results.map((map) {
      final model = fromDatabase(map);
      return fromModel(model);
    }).toList();
  }
  
  @override
  Future<void> markAsSynced(List<String> ids) async {
    if (ids.isEmpty) return;
    
    final now = DateTime.now().millisecondsSinceEpoch;
    final placeholders = List.filled(ids.length, '?').join(',');
    
    await _databaseHelper.execute(
      'UPDATE $tableName SET synced_at = ? WHERE id IN ($placeholders)',
      [now, ...ids],
    );
  }
  
  @override
  Future<void> clear({String? organizationId}) async {
    if (organizationId != null) {
      await _databaseHelper.delete(
        tableName,
        where: 'organization_id = ?',
        whereArgs: [organizationId],
      );
    } else {
      await _databaseHelper.execute('DELETE FROM $tableName');
    }
  }
}