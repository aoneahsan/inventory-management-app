import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../services/export/data_export_service.dart';
import '../../../services/database/database_service.dart';

class DataExportPage extends ConsumerStatefulWidget {
  const DataExportPage({super.key});

  @override
  ConsumerState<DataExportPage> createState() => _DataExportPageState();
}

class _DataExportPageState extends ConsumerState<DataExportPage> {
  final _exportService = DataExportService();
  final _dbService = DatabaseService();
  bool _exporting = false;

  Future<void> _exportData(String format) async {
    setState(() => _exporting = true);

    try {
      // Get products
      final products = await _dbService.getAllProducts();
      
      String content;
      String fileName;
      
      switch (format) {
        case 'CSV':
          content = _exportService.exportProductsToCSV(products);
          fileName = 'products_export.csv';
          break;
        case 'JSON':
          content = _exportService.exportProductsToJSON(products);
          fileName = 'products_export.json';
          break;
        case 'XML':
          content = _exportService.exportProductsToXML(products);
          fileName = 'products_export.xml';
          break;
        default:
          throw Exception('Unsupported format');
      }

      // Save and share
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/$fileName');
      await file.writeAsString(content);
      
      await Share.shareXFiles([XFile(file.path)]);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Exported to $format successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    } finally {
      setState(() => _exporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Export'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Select Export Format',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _ExportTile(
            icon: Icons.table_chart,
            title: 'CSV Export',
            subtitle: 'Export data as comma-separated values',
            onTap: _exporting ? null : () => _exportData('CSV'),
          ),
          const SizedBox(height: 16),
          _ExportTile(
            icon: Icons.code,
            title: 'JSON Export',
            subtitle: 'Export data in JSON format',
            onTap: _exporting ? null : () => _exportData('JSON'),
          ),
          const SizedBox(height: 16),
          _ExportTile(
            icon: Icons.description,
            title: 'XML Export',
            subtitle: 'Export data in XML format',
            onTap: _exporting ? null : () => _exportData('XML'),
          ),
          if (_exporting) ...[
            const SizedBox(height: 32),
            const Center(child: CircularProgressIndicator()),
          ],
        ],
      ),
    );
  }
}

class _ExportTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _ExportTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}