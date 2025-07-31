/// Base repository interface for all entities
abstract class BaseRepository<T> {
  /// Create a new entity
  Future<T> create(T entity);
  
  /// Create multiple entities
  Future<List<T>> createMany(List<T> entities);
  
  /// Get entity by ID
  Future<T?> getById(String id);
  
  /// Get all entities
  Future<List<T>> getAll();
  
  /// Get entities by organization ID
  Future<List<T>> getByOrganizationId(String organizationId);
  
  /// Update an entity
  Future<T> update(T entity);
  
  /// Update multiple entities
  Future<List<T>> updateMany(List<T> entities);
  
  /// Delete entity by ID
  Future<bool> delete(String id);
  
  /// Delete multiple entities by IDs
  Future<bool> deleteMany(List<String> ids);
  
  /// Check if entity exists
  Future<bool> exists(String id);
  
  /// Get count of entities
  Future<int> count({String? organizationId});
  
  /// Search entities
  Future<List<T>> search(String query, {String? organizationId});
  
  /// Get entities with pagination
  Future<List<T>> getPaginated({
    required int page,
    required int pageSize,
    String? organizationId,
    String? orderBy,
    bool descending = false,
  });
  
  /// Sync entities with server
  Future<void> sync({String? organizationId});
  
  /// Get unsync entities
  Future<List<T>> getUnsyncedEntities({String? organizationId});
  
  /// Mark entities as synced
  Future<void> markAsSynced(List<String> ids);
  
  /// Clear all data
  Future<void> clear({String? organizationId});
}