abstract class StorageAdapter {
  // Key-value storage
  Future<void> setString(String key, String value);
  Future<String?> getString(String key);
  
  Future<void> setInt(String key, int value);
  Future<int?> getInt(String key);
  
  Future<void> setDouble(String key, double value);
  Future<double?> getDouble(String key);
  
  Future<void> setBool(String key, bool value);
  Future<bool?> getBool(String key);
  
  Future<void> setStringList(String key, List<String> value);
  Future<List<String>?> getStringList(String key);
  
  // JSON storage
  Future<void> setJson(String key, Map<String, dynamic> value);
  Future<Map<String, dynamic>?> getJson(String key);
  
  // Secure storage (for sensitive data)
  Future<void> setSecureString(String key, String value);
  Future<String?> getSecureString(String key);
  
  // File storage
  Future<String> saveFile(String fileName, List<int> bytes);
  Future<List<int>?> readFile(String fileName);
  Future<void> deleteFile(String fileName);
  Future<bool> fileExists(String fileName);
  Future<List<String>> listFiles();
  
  // Management
  Future<void> remove(String key);
  Future<void> clear();
  Future<bool> containsKey(String key);
  Future<Set<String>> getKeys();
  
  // Batch operations
  Future<void> setBatch(Map<String, dynamic> values);
  Future<Map<String, dynamic>> getBatch(List<String> keys);
  Future<void> removeBatch(List<String> keys);
}