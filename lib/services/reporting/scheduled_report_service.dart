import 'dart:convert';
import '../../domain/entities/scheduled_report.dart';
import '../database/database.dart';
import '../sync/sync_service.dart';

class ScheduledReportService {
  final AppDatabase _database = AppDatabase.instance;
  final SyncService _syncService = SyncService();

  Future<List<ScheduledReport>> getScheduledReports(
    String organizationId, {
    bool? activeOnly,
  }) async {
    final db = await _database.database;
    String query = 'SELECT * FROM scheduled_reports WHERE organization_id = ?';
    List<dynamic> args = [organizationId];

    if (activeOnly == true) {
      query += ' AND is_active = 1';
    }

    query += ' ORDER BY name ASC';

    final results = await db.rawQuery(query, args);
    return results.map((map) => ScheduledReport.fromMap(map)).toList();
  }

  Future<ScheduledReport?> getScheduledReport(String reportId) async {
    final db = await _database.database;
    final results = await db.query(
      'scheduled_reports',
      where: 'id = ?',
      whereArgs: [reportId],
    );

    if (results.isEmpty) return null;
    return ScheduledReport.fromMap(results.first);
  }

  Future<String> createScheduledReport(ScheduledReport report) async {
    final db = await _database.database;
    final id = report.id.isEmpty
        ? DateTime.now().millisecondsSinceEpoch.toString()
        : report.id;

    await db.insert(
      'scheduled_reports',
      report.copyWith(id: id).toMap(),
    );

    await _syncService.addToQueue(
      'scheduled_reports',
      id,
      'create',
      report.toMap(),
    );

    return id;
  }

  Future<void> updateScheduledReport(
    String reportId,
    ScheduledReport report,
  ) async {
    final db = await _database.database;
    
    await db.update(
      'scheduled_reports',
      report.copyWith(
        updatedAt: DateTime.now(),
      ).toMap(),
      where: 'id = ?',
      whereArgs: [reportId],
    );

    await _syncService.addToQueue(
      'scheduled_reports',
      reportId,
      'update',
      report.toMap(),
    );
  }

  Future<void> deleteScheduledReport(String reportId) async {
    final db = await _database.database;
    
    await db.delete(
      'scheduled_reports',
      where: 'id = ?',
      whereArgs: [reportId],
    );

    await _syncService.addToQueue(
      'scheduled_reports',
      reportId,
      'delete',
      {},
    );
  }
}