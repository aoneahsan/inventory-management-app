import '../../domain/entities/communication_template.dart';
import '../database/database.dart';
import '../sync/sync_service.dart';

class CommunicationService {
  final AppDatabase _database = AppDatabase.instance;
  final SyncService _syncService = SyncService();

  // Template Management
  Future<List<CommunicationTemplate>> getTemplates(
    String organizationId, {
    CommunicationType? type,
    String? category,
    bool? activeOnly,
    String? searchQuery,
  }) async {
    final db = await _database.database;
    String query = 'SELECT * FROM communication_templates WHERE organization_id = ?';
    List<dynamic> args = [organizationId];

    if (type != null) {
      query += ' AND type = ?';
      args.add(type.name);
    }

    if (category != null) {
      query += ' AND category = ?';
      args.add(category);
    }

    if (activeOnly == true) {
      query += ' AND is_active = 1';
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query += ' AND (name LIKE ? OR subject LIKE ?)';
      final pattern = '%$searchQuery%';
      args.addAll([pattern, pattern]);
    }

    query += ' ORDER BY category ASC, name ASC';

    final results = await db.rawQuery(query, args);
    return results.map((map) => CommunicationTemplate.fromMap(map)).toList();
  }

  Future<CommunicationTemplate?> getTemplate(String templateId) async {
    final db = await _database.database;
    final results = await db.query(
      'communication_templates',
      where: 'id = ?',
      whereArgs: [templateId],
    );

    if (results.isEmpty) return null;
    return CommunicationTemplate.fromMap(results.first);
  }

  Future<String> createTemplate(CommunicationTemplate template) async {
    final db = await _database.database;
    final id = template.id.isEmpty
        ? DateTime.now().millisecondsSinceEpoch.toString()
        : template.id;

    await db.insert(
      'communication_templates',
      template.copyWith(id: id).toMap(),
    );

    await _syncService.addToQueue(
      'communication_templates',
      id,
      'create',
      template.toMap(),
    );

    return id;
  }

  Future<void> updateTemplate(
    String templateId,
    CommunicationTemplate template,
  ) async {
    final db = await _database.database;
    
    await db.update(
      'communication_templates',
      template.copyWith(
        updatedAt: DateTime.now(),
      ).toMap(),
      where: 'id = ?',
      whereArgs: [templateId],
    );

    await _syncService.addToQueue(
      'communication_templates',
      templateId,
      'update',
      template.toMap(),
    );
  }

  Future<void> deleteTemplate(String templateId) async {
    final db = await _database.database;
    
    await db.delete(
      'communication_templates',
      where: 'id = ?',
      whereArgs: [templateId],
    );

    await _syncService.addToQueue(
      'communication_templates',
      templateId,
      'delete',
      {},
    );
  }

  // Send Communication
  Future<String> sendCommunication({
    required String organizationId,
    required String templateId,
    required String recipientId,
    required String recipientType, // customer, supplier, etc.
    required Map<String, dynamic> variables,
    String? scheduledFor,
  }) async {
    final template = await getTemplate(templateId);
    if (template == null) {
      throw Exception('Template not found');
    }

    // Process template variables
    final processedContent = _processTemplateVariables(
      template.content,
      variables,
    );
    
    final processedSubject = template.subject != null
        ? _processTemplateVariables(template.subject!, variables)
        : null;

    final db = await _database.database;
    final logId = DateTime.now().millisecondsSinceEpoch.toString();

    // Create communication log
    await db.insert('communication_logs', {
      'id': logId,
      'organization_id': organizationId,
      'template_id': templateId,
      'recipient_id': recipientId,
      'recipient_type': recipientType,
      'type': template.type.value,
      'subject': processedSubject,
      'content': processedContent,
      'status': scheduledFor != null ? 'scheduled' : 'pending',
      'scheduled_for': scheduledFor,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    });

    // If not scheduled, send immediately
    if (scheduledFor == null) {
      await _sendImmediate(logId, template.type, processedSubject, processedContent);
    }

    await _syncService.addToQueue(
      'communication_logs',
      logId,
      'create',
      {
        'template_id': templateId,
        'recipient_id': recipientId,
        'type': template.type.value,
      },
    );

    return logId;
  }

  // Send bulk communication
  Future<List<String>> sendBulkCommunication({
    required String organizationId,
    required String templateId,
    required List<String> recipientIds,
    required String recipientType,
    required Map<String, dynamic> commonVariables,
    Map<String, Map<String, dynamic>>? recipientSpecificVariables,
  }) async {
    final logIds = <String>[];

    for (final recipientId in recipientIds) {
      final variables = {
        ...commonVariables,
        if (recipientSpecificVariables != null && 
            recipientSpecificVariables.containsKey(recipientId))
          ...recipientSpecificVariables[recipientId]!,
      };

      final logId = await sendCommunication(
        organizationId: organizationId,
        templateId: templateId,
        recipientId: recipientId,
        recipientType: recipientType,
        variables: variables,
      );

      logIds.add(logId);
    }

    return logIds;
  }

  // Get communication logs
  Future<List<CommunicationLog>> getCommunicationLogs(
    String organizationId, {
    String? recipientId,
    String? templateId,
    CommunicationStatus? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final db = await _database.database;
    String query = 'SELECT * FROM communication_logs WHERE organization_id = ?';
    List<dynamic> args = [organizationId];

    if (recipientId != null) {
      query += ' AND recipient_id = ?';
      args.add(recipientId);
    }

    if (templateId != null) {
      query += ' AND template_id = ?';
      args.add(templateId);
    }

    if (status != null) {
      query += ' AND status = ?';
      args.add(status.value);
    }

    if (startDate != null) {
      query += ' AND created_at >= ?';
      args.add(startDate.millisecondsSinceEpoch);
    }

    if (endDate != null) {
      query += ' AND created_at <= ?';
      args.add(endDate.millisecondsSinceEpoch);
    }

    query += ' ORDER BY created_at DESC';

    final results = await db.rawQuery(query, args);
    return results.map((map) => CommunicationLog.fromMap(map)).toList();
  }

  // Process scheduled communications
  Future<void> processScheduledCommunications() async {
    final db = await _database.database;
    final now = DateTime.now().millisecondsSinceEpoch;

    final scheduledLogs = await db.query(
      'communication_logs',
      where: 'status = ? AND scheduled_for <= ?',
      whereArgs: ['scheduled', now],
    );

    for (final logMap in scheduledLogs) {
      final log = CommunicationLog.fromMap(logMap);
      await _sendImmediate(
        log.id,
        log.type,
        log.subject,
        log.content,
      );
    }
  }

  // Private helper methods
  String _processTemplateVariables(
    String template,
    Map<String, dynamic> variables,
  ) {
    String processed = template;
    
    variables.forEach((key, value) {
      processed = processed.replaceAll('{{$key}}', value.toString());
    });

    return processed;
  }

  Future<void> _sendImmediate(
    String logId,
    CommunicationType type,
    String? subject,
    String content,
  ) async {
    final db = await _database.database;
    
    try {
      // In a real implementation, this would integrate with actual
      // SMS, Email, and WhatsApp APIs
      switch (type) {
        case CommunicationType.sms:
          // await _sendSMS(content);
          break;
        case CommunicationType.email:
          // await _sendEmail(subject, content);
          break;
        case CommunicationType.whatsapp:
          // await _sendWhatsApp(content);
          break;
      }

      // Update status to sent
      await db.update(
        'communication_logs',
        {
          'status': 'sent',
          'sent_at': DateTime.now().millisecondsSinceEpoch,
        },
        where: 'id = ?',
        whereArgs: [logId],
      );
    } catch (e) {
      // Update status to failed
      await db.update(
        'communication_logs',
        {
          'status': 'failed',
          'error_message': e.toString(),
        },
        where: 'id = ?',
        whereArgs: [logId],
      );
    }
  }

  // Template categories
  Future<List<String>> getTemplateCategories(String organizationId) async {
    final db = await _database.database;
    final results = await db.rawQuery('''
      SELECT DISTINCT category
      FROM communication_templates
      WHERE organization_id = ?
      ORDER BY category ASC
    ''', [organizationId]);

    return results
        .map((row) => row['category'] as String)
        .where((category) => category.isNotEmpty)
        .toList();
  }

  // Analytics
  Future<Map<String, dynamic>> getCommunicationStats(
    String organizationId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final db = await _database.database;
    
    String dateFilter = '';
    List<dynamic> args = [organizationId];

    if (startDate != null) {
      dateFilter += ' AND created_at >= ?';
      args.add(startDate.millisecondsSinceEpoch);
    }

    if (endDate != null) {
      dateFilter += ' AND created_at <= ?';
      args.add(endDate.millisecondsSinceEpoch);
    }

    final totalSent = await db.rawQuery(
      'SELECT COUNT(*) as count FROM communication_logs WHERE organization_id = ? AND status = ?$dateFilter',
      [...args, 'sent'],
    );

    final sentByType = await db.rawQuery('''
      SELECT type, COUNT(*) as count
      FROM communication_logs
      WHERE organization_id = ? AND status = ?$dateFilter
      GROUP BY type
    ''', [...args, 'sent']);

    final failureRate = await db.rawQuery('''
      SELECT 
        COUNT(CASE WHEN status = 'failed' THEN 1 END) * 100.0 / COUNT(*) as failure_rate
      FROM communication_logs
      WHERE organization_id = ?$dateFilter
    ''', args);

    final mostUsedTemplates = await db.rawQuery('''
      SELECT ct.name, COUNT(cl.id) as usage_count
      FROM communication_logs cl
      JOIN communication_templates ct ON cl.template_id = ct.id
      WHERE cl.organization_id = ?$dateFilter
      GROUP BY ct.id, ct.name
      ORDER BY usage_count DESC
      LIMIT 5
    ''', args);

    return {
      'total_sent': totalSent.first['count'] ?? 0,
      'sent_by_type': sentByType,
      'failure_rate': failureRate.first['failure_rate'] ?? 0.0,
      'most_used_templates': mostUsedTemplates,
    };
  }

  // Create default templates
  Future<void> createDefaultTemplates(String organizationId) async {
    final defaultTemplates = [
      CommunicationTemplate(
        id: '',
        organizationId: organizationId,
        name: 'Order Confirmation',
        type: CommunicationType.sms,
        trigger: CommunicationTrigger.orderPlaced,
        variables: ['customer_name', 'order_number', 'total_amount'],
        subject: null,
        content: 'Dear {{customer_name}}, your order #{{order_number}} has been confirmed. Total: ₹{{total_amount}}. Thank you!',
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CommunicationTemplate(
        id: '',
        organizationId: organizationId,
        name: 'Payment Reminder',
        type: CommunicationType.email,
        trigger: CommunicationTrigger.invoiceGenerated,
        variables: ['customer_name', 'invoice_number', 'amount', 'due_date'],
        subject: 'Payment Reminder - Invoice #{{invoice_number}}',
        content: '''Dear {{customer_name}},

This is a friendly reminder that your invoice #{{invoice_number}} for ₹{{amount}} is due on {{due_date}}.

Please make the payment at your earliest convenience.

Thank you for your business!''',
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      CommunicationTemplate(
        id: '',
        organizationId: organizationId,
        name: 'Low Stock Alert',
        type: CommunicationType.whatsapp,
        trigger: CommunicationTrigger.lowStock,
        variables: ['product_name', 'current_stock', 'unit'],
        subject: null,
        content: 'Stock Alert: {{product_name}} is running low. Current stock: {{current_stock}} {{unit}}. Please reorder soon.',
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    for (final template in defaultTemplates) {
      await createTemplate(template);
    }
  }
}