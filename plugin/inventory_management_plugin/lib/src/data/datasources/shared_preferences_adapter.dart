import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../../core/interfaces/storage_adapter.dart';

class SharedPreferencesAdapter implements StorageAdapter {
  late SharedPreferences _prefs;
  late FlutterSecureStorage _secureStorage;
  late Directory _documentsDirectory;
  
  SharedPreferencesAdapter() {
    _secureStorage = const FlutterSecureStorage();
  }
  
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _documentsDirectory = await getApplicationDocumentsDirectory();
  }
  
  @override
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }
  
  @override
  Future<String?> getString(String key) async {
    return _prefs.getString(key);
  }
  
  @override
  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }
  
  @override
  Future<int?> getInt(String key) async {
    return _prefs.getInt(key);
  }
  
  @override
  Future<void> setDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }
  
  @override
  Future<double?> getDouble(String key) async {
    return _prefs.getDouble(key);
  }
  
  @override
  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }
  
  @override
  Future<bool?> getBool(String key) async {
    return _prefs.getBool(key);
  }
  
  @override
  Future<void> setStringList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
  }
  
  @override
  Future<List<String>?> getStringList(String key) async {
    return _prefs.getStringList(key);
  }
  
  @override
  Future<void> setJson(String key, Map<String, dynamic> value) async {
    final jsonString = jsonEncode(value);
    await _prefs.setString(key, jsonString);
  }
  
  @override
  Future<Map<String, dynamic>?> getJson(String key) async {
    final jsonString = _prefs.getString(key);
    if (jsonString == null) return null;
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }
  
  @override
  Future<void> setSecureString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }
  
  @override
  Future<String?> getSecureString(String key) async {
    return await _secureStorage.read(key: key);
  }
  
  @override
  Future<String> saveFile(String fileName, List<int> bytes) async {
    final file = File(path.join(_documentsDirectory.path, fileName));
    await file.writeAsBytes(bytes);
    return file.path;
  }
  
  @override
  Future<List<int>?> readFile(String fileName) async {
    final file = File(path.join(_documentsDirectory.path, fileName));
    if (await file.exists()) {
      return await file.readAsBytes();
    }
    return null;
  }
  
  @override
  Future<void> deleteFile(String fileName) async {
    final file = File(path.join(_documentsDirectory.path, fileName));
    if (await file.exists()) {
      await file.delete();
    }
  }
  
  @override
  Future<bool> fileExists(String fileName) async {
    final file = File(path.join(_documentsDirectory.path, fileName));
    return await file.exists();
  }
  
  @override
  Future<List<String>> listFiles() async {
    final files = await _documentsDirectory.list().toList();
    return files
        .where((entity) => entity is File)
        .map((entity) => path.basename(entity.path))
        .toList();
  }
  
  @override
  Future<void> remove(String key) async {
    await _prefs.remove(key);
    await _secureStorage.delete(key: key);
  }
  
  @override
  Future<void> clear() async {
    await _prefs.clear();
    await _secureStorage.deleteAll();
    // Clear all files
    final files = await _documentsDirectory.list().toList();
    for (final file in files) {
      if (file is File) {
        await file.delete();
      }
    }
  }
  
  @override
  Future<bool> containsKey(String key) async {
    return _prefs.containsKey(key) || await _secureStorage.containsKey(key: key);
  }
  
  @override
  Future<Set<String>> getKeys() async {
    final prefsKeys = _prefs.getKeys();
    final secureKeys = await _secureStorage.readAll();
    return {...prefsKeys, ...secureKeys.keys};
  }
  
  @override
  Future<void> setBatch(Map<String, dynamic> values) async {
    for (final entry in values.entries) {
      final value = entry.value;
      if (value is String) {
        await setString(entry.key, value);
      } else if (value is int) {
        await setInt(entry.key, value);
      } else if (value is double) {
        await setDouble(entry.key, value);
      } else if (value is bool) {
        await setBool(entry.key, value);
      } else if (value is List<String>) {
        await setStringList(entry.key, value);
      } else if (value is Map<String, dynamic>) {
        await setJson(entry.key, value);
      }
    }
  }
  
  @override
  Future<Map<String, dynamic>> getBatch(List<String> keys) async {
    final result = <String, dynamic>{};
    for (final key in keys) {
      final value = _prefs.get(key);
      if (value != null) {
        result[key] = value;
      }
    }
    return result;
  }
  
  @override
  Future<void> removeBatch(List<String> keys) async {
    for (final key in keys) {
      await remove(key);
    }
  }
}