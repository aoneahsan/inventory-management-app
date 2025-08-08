import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../../domain/entities/customer.dart';
import '../../../domain/entities/communication_template.dart';
import '../../../services/customer/customer_service.dart';
import '../../../services/communication/communication_service.dart';
import '../../providers/auth_provider.dart';

final customerServiceProvider = Provider<CustomerService>((ref) {
  return CustomerService();
});

final customersProvider = FutureProvider.family<List<Customer>, Map<String, dynamic>>((ref, filters) async {
  final org = ref.watch(currentOrganizationProvider);
  if (org == null) throw Exception('No organization');
  
  final customerService = ref.watch(customerServiceProvider);
  return customerService.getCustomers(
    org.id,
    searchQuery: filters['searchQuery'] as String?,
    customerType: filters['customerType'] as String?,
    activeOnly: filters['activeOnly'] as bool?,
  );
});

final customerStatsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final org = ref.watch(currentOrganizationProvider);
  if (org == null) throw Exception('No organization');
  
  final customerService = ref.watch(customerServiceProvider);
  return customerService.getCustomerStats(org.id);
});

class CustomersPage extends ConsumerStatefulWidget {
  const CustomersPage({super.key});

  @override
  ConsumerState<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends ConsumerState<CustomersPage> {
  final _searchController = TextEditingController();
  String? _selectedCustomerType;
  bool _showActiveOnly = true;
  final _selectedCustomers = <String>{};
  bool _isSelectionMode = false;

  Map<String, dynamic> get _filters => {
    'searchQuery': _searchController.text,
    'customerType': _selectedCustomerType,
    'activeOnly': _showActiveOnly,
  };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customersAsync = ref.watch(customersProvider(_filters));
    final statsAsync = ref.watch(customerStatsProvider);
    final user = ref.watch(currentUserProvider);
    
    final canManageCustomers = user?.hasPermission('manage_customers') ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isSelectionMode 
            ? '${_selectedCustomers.length} selected' 
            : 'Customers'),
        leading: _isSelectionMode
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _isSelectionMode = false;
                    _selectedCustomers.clear();
                  });
                },
              )
            : null,
        actions: [
          if (_isSelectionMode) ...[
            IconButton(
              icon: const Icon(Icons.email),
              onPressed: _selectedCustomers.isEmpty 
                  ? null 
                  : () => _sendBulkEmail(),
            ),
            IconButton(
              icon: const Icon(Icons.label),
              onPressed: _selectedCustomers.isEmpty 
                  ? null 
                  : () => _exportLabels(),
            ),
          ] else ...[
            IconButton(
              icon: const Icon(Icons.file_download),
              onPressed: () => _exportCustomers(),
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => ref.invalidate(customersProvider),
            ),
          ],
        ],
      ),
      body: Column(
        children: [
          // Stats Cards
          if (!_isSelectionMode)
            Container(
              height: 120,
              padding: const EdgeInsets.all(16),
              child: statsAsync.when(
                data: (stats) => Row(
                  children: [
                    _buildStatCard(
                      'Total Customers',
                      stats['totalCustomers'].toString(),
                      Icons.people,
                      Colors.blue,
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      'Active',
                      stats['activeCustomers'].toString(),
                      Icons.check_circle,
                      Colors.green,
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      'With Credit',
                      stats['customersWithCredit'].toString(),
                      Icons.credit_card,
                      Colors.orange,
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      'Outstanding',
                      '\$${stats['totalOutstandingBalance'].toStringAsFixed(2)}',
                      Icons.account_balance_wallet,
                      Colors.red,
                    ),
                  ],
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('Error: $error')),
              ),
            ),
          
          // Search and Filters
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search customers...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 12),
                
                // Customer Type Filter
                DropdownButton<String?>(
                  value: _selectedCustomerType,
                  hint: const Text('All Types'),
                  items: const [
                    DropdownMenuItem(value: null, child: Text('All Types')),
                    DropdownMenuItem(value: 'retail', child: Text('Retail')),
                    DropdownMenuItem(value: 'wholesale', child: Text('Wholesale')),
                    DropdownMenuItem(value: 'corporate', child: Text('Corporate')),
                  ],
                  onChanged: (value) => setState(() {
                    _selectedCustomerType = value;
                  }),
                ),
                const SizedBox(width: 12),
                
                // Active Only Filter
                FilterChip(
                  label: const Text('Active Only'),
                  selected: _showActiveOnly,
                  onSelected: (selected) => setState(() {
                    _showActiveOnly = selected;
                  }),
                ),
              ],
            ),
          ),
          
          // Customers List
          Expanded(
            child: customersAsync.when(
              data: (customers) {
                if (customers.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 64,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No customers found',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: canManageCustomers
                              ? () => context.push('/customers/new')
                              : null,
                          icon: const Icon(Icons.add),
                          label: const Text('Add First Customer'),
                        ),
                      ],
                    ),
                  );
                }
                
                return ListView.builder(
                  itemCount: customers.length,
                  itemBuilder: (context, index) {
                    final customer = customers[index];
                    final isSelected = _selectedCustomers.contains(customer.id);
                    
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: ListTile(
                        leading: _isSelectionMode
                            ? Checkbox(
                                value: isSelected,
                                onChanged: (_) => _toggleSelection(customer.id),
                              )
                            : CircleAvatar(
                                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                child: Text(
                                  customer.name.substring(0, 1).toUpperCase(),
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              ),
                        title: Text(customer.name),
                        subtitle: Row(
                          children: [
                            if (customer.code != null) ...[
                              Icon(Icons.tag, size: 14, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text(customer.code!),
                              const SizedBox(width: 12),
                            ],
                            if (customer.email != null) ...[
                              Icon(Icons.email, size: 14, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  customer.email!,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (customer.loyaltyPoints > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.purple[50],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.star, size: 14, color: Colors.purple[700]),
                                    const SizedBox(width: 4),
                                    Text(
                                      customer.loyaltyPoints.toString(),
                                      style: TextStyle(
                                        color: Colors.purple[700],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            const SizedBox(width: 8),
                            if (customer.currentBalance > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.red[50],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '\$${customer.currentBalance.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Colors.red[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            const SizedBox(width: 8),
                            Chip(
                              label: Text(
                                customer.customerType.toUpperCase(),
                                style: const TextStyle(fontSize: 11),
                              ),
                              visualDensity: VisualDensity.compact,
                              backgroundColor: _getCustomerTypeColor(customer.customerType),
                            ),
                          ],
                        ),
                        onTap: () => context.push('/customers/${customer.id}'),
                        onLongPress: canManageCustomers
                            ? () {
                                setState(() {
                                  _isSelectionMode = true;
                                  _selectedCustomers.add(customer.id);
                                });
                              }
                            : null,
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: 16),
                    Text('Error: $error'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref.invalidate(customersProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: canManageCustomers && !_isSelectionMode
          ? FloatingActionButton.extended(
              onPressed: () => context.push('/customers/new'),
              icon: const Icon(Icons.add),
              label: const Text('Add Customer'),
            )
          : null,
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: color,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCustomerTypeColor(String type) {
    switch (type) {
      case 'retail':
        return Colors.blue[100]!;
      case 'wholesale':
        return Colors.green[100]!;
      case 'corporate':
        return Colors.orange[100]!;
      default:
        return Colors.grey[100]!;
    }
  }

  void _toggleSelection(String customerId) {
    setState(() {
      if (_selectedCustomers.contains(customerId)) {
        _selectedCustomers.remove(customerId);
      } else {
        _selectedCustomers.add(customerId);
      }
    });
  }

  Future<void> _sendBulkEmail() async {
    if (_selectedCustomers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one customer')),
      );
      return;
    }

    // Show email compose dialog
    final result = await showDialog<Map<String, String>>(
      context: context,
      barrierDismissible: false,
      builder: (context) => _BulkEmailDialog(
        customerCount: _selectedCustomers.length,
      ),
    );

    if (result != null) {
      try {
        final org = ref.read(currentOrganizationProvider);
        if (org == null) return;

        final communicationService = CommunicationService();
        final customers = await ref.read(customersProvider({
          'searchQuery': null,
          'customerType': _selectedCustomerType,
          'activeOnly': true,
        }).future);

        final selectedCustomersList = customers
            .where((c) => _selectedCustomers.contains(c.id))
            .toList();

        int successCount = 0;
        int failCount = 0;

        for (final customer in selectedCustomersList) {
          if (customer.email != null && customer.email!.isNotEmpty) {
            try {
              // Create a temporary template for bulk email
              final templateId = DateTime.now().millisecondsSinceEpoch.toString();
              final template = CommunicationTemplate(
                id: templateId,
                organizationId: org.id,
                name: 'Bulk Email - ${DateTime.now()}',
                type: CommunicationType.email,
                trigger: CommunicationTrigger.custom,
                subject: result['subject']!,
                content: result['body']!,
                variables: ['customerName', 'customerCode'],
                isActive: true,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              );
              
              await communicationService.createTemplate(template);
              
              await communicationService.sendCommunication(
                organizationId: org.id,
                templateId: templateId,
                recipientId: customer.id,
                recipientType: 'customer',
                variables: {
                  'customerName': customer.name,
                  'customerCode': customer.code ?? '',
                },
              );
              successCount++;
            } catch (e) {
              failCount++;
            }
          } else {
            failCount++;
          }
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Emails sent: $successCount successful, $failCount failed',
              ),
              backgroundColor: failCount > 0 ? Colors.orange : Colors.green,
            ),
          );
          setState(() {
            _isSelectionMode = false;
            _selectedCustomers.clear();
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error sending emails: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Future<void> _exportLabels() async {
    if (_selectedCustomers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one customer')),
      );
      return;
    }

    // Show label configuration dialog
    final config = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => _LabelConfigDialog(),
    );

    if (config != null) {
      try {
        final customers = await ref.read(customersProvider({
          'searchQuery': null,
          'customerType': _selectedCustomerType,
          'activeOnly': true,
        }).future);

        final selectedCustomersList = customers
            .where((c) => _selectedCustomers.contains(c.id))
            .toList();

        // Generate PDF with labels
        final pdf = pw.Document();
        final labelsPerPage = (config['labelsPerRow'] as int) * (config['labelsPerColumn'] as int);
        final totalPages = (selectedCustomersList.length / labelsPerPage).ceil();

        for (int page = 0; page < totalPages; page++) {
          pdf.addPage(
            pw.Page(
              pageFormat: PdfPageFormat.a4,
              margin: const pw.EdgeInsets.all(10),
              build: (context) {
                final startIdx = page * labelsPerPage;
                final endIdx = (startIdx + labelsPerPage).clamp(0, selectedCustomersList.length);
                final pageCustomers = selectedCustomersList.sublist(startIdx, endIdx);

                return pw.GridView(
                  crossAxisCount: config['labelsPerRow'] as int,
                  childAspectRatio: (config['labelWidth'] as double) / (config['labelHeight'] as double),
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  children: pageCustomers.map((customer) {
                    return pw.Container(
                      padding: const pw.EdgeInsets.all(5),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(width: 0.5),
                      ),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            customer.name,
                            style: pw.TextStyle(
                              fontSize: config['includeName'] ? 10 : 0,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          if (config['includeCode'])
                            pw.Text(
                              'Code: ${customer.code}',
                              style: const pw.TextStyle(fontSize: 8),
                            ),
                          if (config['includePhone'] && customer.phone != null)
                            pw.Text(
                              'Ph: ${customer.phone}',
                              style: const pw.TextStyle(fontSize: 8),
                            ),
                          if (config['includeAddress'] && customer.address != null)
                            pw.Text(
                              customer.address!,
                              style: const pw.TextStyle(fontSize: 7),
                              maxLines: 2,
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          );
        }

        // Print or save the PDF
        await Printing.layoutPdf(
          onLayout: (format) async => pdf.save(),
          name: 'customer_labels_${DateTime.now().millisecondsSinceEpoch}.pdf',
        );

        if (mounted) {
          setState(() {
            _isSelectionMode = false;
            _selectedCustomers.clear();
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error generating labels: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Future<void> _exportCustomers() async {
    if (_selectedCustomers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one customer')),
      );
      return;
    }

    // Show export format dialog
    final format = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Format'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('CSV'),
              subtitle: const Text('Comma-separated values'),
              onTap: () => Navigator.of(context).pop('csv'),
            ),
            ListTile(
              leading: const Icon(Icons.code),
              title: const Text('JSON'),
              subtitle: const Text('JavaScript Object Notation'),
              onTap: () => Navigator.of(context).pop('json'),
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text('PDF'),
              subtitle: const Text('Portable Document Format'),
              onTap: () => Navigator.of(context).pop('pdf'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );

    if (format != null) {
      try {
        final customers = await ref.read(customersProvider({
          'searchQuery': null,
          'customerType': _selectedCustomerType,
          'activeOnly': true,
        }).future);

        final selectedCustomersList = customers
            .where((c) => _selectedCustomers.contains(c.id))
            .toList();

        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final filename = 'customers_export_$timestamp';

        switch (format) {
          case 'csv':
            await _exportAsCSV(selectedCustomersList, filename);
            break;
          case 'json':
            await _exportAsJSON(selectedCustomersList, filename);
            break;
          case 'pdf':
            await _exportAsPDF(selectedCustomersList, filename);
            break;
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Exported ${selectedCustomersList.length} customers'),
              backgroundColor: Colors.green,
            ),
          );
          setState(() {
            _isSelectionMode = false;
            _selectedCustomers.clear();
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error exporting customers: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Future<void> _exportAsCSV(List<Customer> customers, String filename) async {
    final csvData = StringBuffer();
    
    // Headers
    csvData.writeln('Code,Name,Type,Email,Phone,Address,City,State,ZIP,Country,Tax ID,Credit Limit,Tags,Status,Created Date');
    
    // Data rows
    for (final customer in customers) {
      csvData.writeln([
        customer.code,
        '"${customer.name.replaceAll('"', '""')}"',
        customer.customerType,
        customer.email ?? '',
        customer.phone ?? '',
        '"${customer.address?.replaceAll('"', '""') ?? ''}"',
        customer.creditLimit.toString(),
        customer.isActive ? 'Active' : 'Inactive',
        customer.createdAt.toIso8601String(),
      ].join(','));
    }

    final bytes = utf8.encode(csvData.toString());
    await _downloadFile(bytes, '$filename.csv', 'text/csv');
  }

  Future<void> _exportAsJSON(List<Customer> customers, String filename) async {
    final jsonData = customers.map((c) => {
      'code': c.code,
      'name': c.name,
      'type': c.customerType,
      'email': c.email,
      'phone': c.phone,
      'address': c.address,
      'creditLimit': c.creditLimit,
      'isActive': c.isActive,
      'createdAt': c.createdAt.toIso8601String(),
    }).toList();

    final bytes = utf8.encode(const JsonEncoder.withIndent('  ').convert(jsonData));
    await _downloadFile(bytes, '$filename.json', 'application/json');
  }

  Future<void> _exportAsPDF(List<Customer> customers, String filename) async {
    final pdf = pw.Document();

    // Add pages with customer data
    const pageSize = 20;
    for (int i = 0; i < customers.length; i += pageSize) {
      final end = (i + pageSize).clamp(0, customers.length);
      final pageCustomers = customers.sublist(i, end);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(20),
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Customer Export',
                  style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Generated on: ${DateTime.now().toString().split('.')[0]}',
                  style: const pw.TextStyle(fontSize: 10),
                ),
                pw.SizedBox(height: 20),
                pw.TableHelper.fromTextArray(
                  headers: ['Code', 'Name', 'Email', 'Phone', 'Type', 'Status'],
                  data: pageCustomers.map((c) => [
                    c.code,
                    c.name,
                    c.email ?? '-',
                    c.phone ?? '-',
                    c.customerType,
                    c.isActive ? 'Active' : 'Inactive',
                  ]).toList(),
                  cellStyle: const pw.TextStyle(fontSize: 8),
                  headerStyle: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                  cellAlignment: pw.Alignment.centerLeft,
                ),
              ],
            );
          },
        ),
      );
    }

    final bytes = await pdf.save();
    await _downloadFile(bytes, '$filename.pdf', 'application/pdf');
  }

  Future<void> _downloadFile(Uint8List bytes, String filename, String mimeType) async {
    if (kIsWeb) {
      // Web download
      // For web platform, use universal_html or dart:html
      // Since we're using conditional imports, we need to handle this differently
      // For now, use the printing plugin which works on web too
      await Printing.sharePdf(
        bytes: bytes,
        filename: filename,
      );
    } else {
      // Mobile/Desktop - use printing plugin
      await Printing.sharePdf(
        bytes: bytes,
        filename: filename,
      );
    }
  }
}

class _BulkEmailDialog extends StatefulWidget {
  final int customerCount;

  const _BulkEmailDialog({
    required this.customerCount,
  });

  @override
  State<_BulkEmailDialog> createState() => _BulkEmailDialogState();
}

class _BulkEmailDialogState extends State<_BulkEmailDialog> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void dispose() {
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Send Bulk Email'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sending to ${widget.customerCount} customer${widget.customerCount > 1 ? 's' : ''}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 8,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a message';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              Text(
                'Available variables: {customerName}, {customerCode}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop({
                'subject': _subjectController.text,
                'body': _bodyController.text,
              });
            }
          },
          child: const Text('Send Emails'),
        ),
      ],
    );
  }
}

class _LabelConfigDialog extends StatefulWidget {
  @override
  State<_LabelConfigDialog> createState() => _LabelConfigDialogState();
}

class _LabelConfigDialogState extends State<_LabelConfigDialog> {
  int _labelsPerRow = 3;
  int _labelsPerColumn = 10;
  final double _labelWidth = 70;
  final double _labelHeight = 25;
  bool _includeName = true;
  bool _includeCode = true;
  bool _includePhone = true;
  bool _includeAddress = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Configure Labels'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Layout Settings'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Labels per row',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _labelsPerRow = int.tryParse(value) ?? 3;
                      });
                    },
                    controller: TextEditingController(text: _labelsPerRow.toString()),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Labels per column',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _labelsPerColumn = int.tryParse(value) ?? 10;
                      });
                    },
                    controller: TextEditingController(text: _labelsPerColumn.toString()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Include in Labels'),
            const SizedBox(height: 8),
            CheckboxListTile(
              title: const Text('Customer Name'),
              value: _includeName,
              onChanged: (value) => setState(() => _includeName = value ?? true),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: const Text('Customer Code'),
              value: _includeCode,
              onChanged: (value) => setState(() => _includeCode = value ?? true),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: const Text('Phone Number'),
              value: _includePhone,
              onChanged: (value) => setState(() => _includePhone = value ?? true),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: const Text('Address'),
              value: _includeAddress,
              onChanged: (value) => setState(() => _includeAddress = value ?? true),
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop({
              'labelsPerRow': _labelsPerRow,
              'labelsPerColumn': _labelsPerColumn,
              'labelWidth': _labelWidth,
              'labelHeight': _labelHeight,
              'includeName': _includeName,
              'includeCode': _includeCode,
              'includePhone': _includePhone,
              'includeAddress': _includeAddress,
            });
          },
          child: const Text('Generate Labels'),
        ),
      ],
    );
  }
}