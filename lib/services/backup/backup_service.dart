import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:archive/archive.dart';
import '../database/database.dart';

class BackupService {
  final _storage = FirebaseStorage.instance;
  final _database = AppDatabase.instance;

  Future<String> createBackup(String organizationId, String userId) async {
    try {
      // Collect all data
      final backupData = {
        'metadata': {
          'version': '1.0',
          'createdAt': DateTime.now().toIso8601String(),
          'organizationId': organizationId,
          'userId': userId,
        },
        'products': await _database.getProducts(organizationId),
        'categories': await _database.getCategories(organizationId),
        'customers': [], // TODO: Add customers table
        'suppliers': [], // TODO: Add suppliers table
        'inventoryMovements': await _database.getInventoryMovements(organizationId, limit: 10000),
      };

      // Create backup file
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'backup_${organizationId}_$timestamp.json';
      
      // Compress data
      final jsonString = jsonEncode(backupData);
      final archive = Archive();
      archive.addFile(ArchiveFile(fileName, jsonString.length, jsonString.codeUnits));
      final compressed = ZipEncoder().encode(archive)!;

      // Upload to Firebase Storage
      final ref = _storage.ref().child('backups/$organizationId/$fileName.zip');
      final uploadTask = await ref.putData(Uint8List.fromList(compressed));
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      throw Exception('Backup failed: $e');
    }
  }

  Future<void> restoreBackup(String backupUrl) async {
    try {
      // Download backup
      final ref = _storage.refFromURL(backupUrl);
      final data = await ref.getData();
      
      if (data == null) throw Exception('No backup data found');

      // Decompress
      final archive = ZipDecoder().decodeBytes(data);
      final file = archive.first;
      final jsonString = String.fromCharCodes(file.content);
      final backupData = jsonDecode(jsonString) as Map<String, dynamic>;

      // Validate version
      final metadata = backupData['metadata'] as Map<String, dynamic>;
      if (metadata['version'] != '1.0') {
        throw Exception('Incompatible backup version');
      }

      // Clear existing data
      final db = await _database.database;
      await db.delete('products');
      await db.delete('categories');
      await db.delete('customers');
      await db.delete('suppliers');
      await db.delete('inventory_movements');

      // Restore data
      final products = backupData['products'] as List;
      for (final product in products) {
        await db.insert('products', product as Map<String, dynamic>);
      }

      final categories = backupData['categories'] as List;
      for (final category in categories) {
        await db.insert('categories', category as Map<String, dynamic>);
      }

      final customers = backupData['customers'] as List;
      for (final customer in customers) {
        await db.insert('customers', customer as Map<String, dynamic>);
      }

      final suppliers = backupData['suppliers'] as List;
      for (final supplier in suppliers) {
        await db.insert('suppliers', supplier as Map<String, dynamic>);
      }

    } catch (e) {
      throw Exception('Restore failed: $e');
    }
  }

  Future<List<BackupInfo>> getBackupHistory(String organizationId) async {
    try {
      final ref = _storage.ref().child('backups/$organizationId');
      final result = await ref.listAll();
      
      final backups = <BackupInfo>[];
      for (final item in result.items) {
        final metadata = await item.getMetadata();
        final url = await item.getDownloadURL();
        
        backups.add(BackupInfo(
          name: item.name,
          url: url,
          size: metadata.size ?? 0,
          createdAt: metadata.timeCreated ?? DateTime.now(),
        ));
      }

      backups.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return backups;
    } catch (e) {
      return [];
    }
  }
}

class BackupInfo {
  final String name;
  final String url;
  final int size;
  final DateTime createdAt;

  BackupInfo({
    required this.name,
    required this.url,
    required this.size,
    required this.createdAt,
  });
}