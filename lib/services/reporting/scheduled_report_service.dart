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

  // Execute a report immediately
  Future<Map<String, dynamic>> runReportNow(String reportId) async {
    final report = await getScheduledReport(reportId);
    if (report == null) throw Exception('Report not found');
    
    // Create execution log entry
    final db = await _database.database;
    final executionId = DateTime.now().millisecondsSinceEpoch.toString();
    
    await db.insert('report_executions', {
      'id': executionId,
      'report_id': reportId,
      'organization_id': report.organizationId,
      'status': 'running',
      'started_at': DateTime.now().millisecondsSinceEpoch,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    });
    
    try {
      // In real implementation, this would generate the actual report
      // For now, simulate report generation
      await Future.delayed(const Duration(seconds: 2));
      
      // Update execution status
      await db.update(
        'report_executions',
        {
          'status': 'completed',
          'completed_at': DateTime.now().millisecondsSinceEpoch,
          'file_url': 'reports/$reportId/$executionId.pdf',
        },
        where: 'id = ?',
        whereArgs: [executionId],
      );
      
      return {
        'success': true,
        'executionId': executionId,
        'fileUrl': 'reports/$reportId/$executionId.pdf',
      };
    } catch (e) {
      // Update execution status to failed
      await db.update(
        'report_executions',
        {
          'status': 'failed',
          'error_message': e.toString(),
          'completed_at': DateTime.now().millisecondsSinceEpoch,
        },
        where: 'id = ?',
        whereArgs: [executionId],
      );
      
      rethrow;
    }
  }

  // Get report execution history
  Future<List<Map<String, dynamic>>> getReportHistory(
    String reportId, {
    int limit = 50,
  }) async {
    final db = await _database.database;
    
    final results = await db.query(
      'report_executions',
      where: 'report_id = ?',
      whereArgs: [reportId],
      orderBy: 'created_at DESC',
      limit: limit,
    );
    
    return results.map((row) => {
      'id': row['id'],
      'status': row['status'],
      'startedAt': row['started_at'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(row['started_at'] as int)
          : null,
      'completedAt': row['completed_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(row['completed_at'] as int)
          : null,
      'fileUrl': row['file_url'],
      'errorMessage': row['error_message'],
    }).toList();
  }
}