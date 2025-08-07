import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/tax_rate.dart';
import '../../../services/tax/tax_rate_service.dart';
import '../../providers/organization_provider.dart';

final taxRatesProvider = FutureProvider.autoDispose<List<TaxRate>>((ref) async {
  final organizationId = ref.watch(currentOrganizationIdProvider);
  if (organizationId == null) return [];
  
  final service = TaxRateService();
  return service.getTaxRates(organizationId);
});

class TaxRatesPage extends ConsumerStatefulWidget {
  const TaxRatesPage({super.key});

  @override
  ConsumerState<TaxRatesPage> createState() => _TaxRatesPageState();
}

class _TaxRatesPageState extends ConsumerState<TaxRatesPage> {
  final _service = TaxRateService();
  
  @override
  Widget build(BuildContext context) {
    final taxRatesAsync = ref.watch(taxRatesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tax Rates'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'create_gst') {
                final organizationId = ref.read(currentOrganizationIdProvider);
                if (organizationId != null) {
                  await _service.bulkCreateGSTRates(organizationId);
                  ref.invalidate(taxRatesProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Standard GST rates created')),
                    );
                  }
                }
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'create_gst',
                child: Text('Create Standard GST Rates'),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showTaxRateDialog(),
          ),
        ],
      ),
      body: taxRatesAsync.when(
        data: (taxRates) {
          if (taxRates.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No tax rates configured',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add tax rates for your products',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => _showTaxRateDialog(),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Tax Rate'),
                  ),
                ],
              ),
            );
          }

          final gstRates = taxRates.where((r) => r.type == TaxType.gst).toList();
          final vatRates = taxRates.where((r) => r.type == TaxType.vat).toList();
          final customRates = taxRates.where((r) => r.type == TaxType.other).toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (gstRates.isNotEmpty) ...[
                _buildSection('GST Rates', gstRates),
                const SizedBox(height: 16),
              ],
              if (vatRates.isNotEmpty) ...[
                _buildSection('VAT Rates', vatRates),
                const SizedBox(height: 16),
              ],
              if (customRates.isNotEmpty) ...[
                _buildSection('Custom Rates', customRates),
              ],
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<TaxRate> rates) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 1),
          ...rates.map((rate) => ListTile(
            leading: CircleAvatar(
              backgroundColor: rate.isActive
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outline,
              child: Text(
                '${rate.rate.toStringAsFixed(0)}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(rate.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HSN code is not part of TaxRate entity
                if (rate.type == TaxType.gst)
                  Text(
                    'CGST: ${rate.cgstRate}% | SGST: ${rate.sgstRate}% | IGST: ${rate.igstRate}%',
                    style: const TextStyle(fontSize: 12),
                  ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // isDefault is not part of TaxRate entity
                const SizedBox(width: 8),
                Switch(
                  value: rate.isActive,
                  onChanged: (value) => _toggleTaxRateStatus(rate),
                ),
              ],
            ),
            onTap: () => _showTaxRateDialog(taxRate: rate),
          )),
        ],
      ),
    );
  }

  Future<void> _toggleTaxRateStatus(TaxRate rate) async {
    try {
      await _service.updateTaxRate(
        rate.id,
        rate.copyWith(isActive: !rate.isActive),
      );
      ref.invalidate(taxRatesProvider);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _showTaxRateDialog({TaxRate? taxRate}) {
    showDialog(
      context: context,
      builder: (context) => _TaxRateDialog(
        taxRate: taxRate,
        onSave: () => ref.invalidate(taxRatesProvider),
      ),
    );
  }
}

class _TaxRateDialog extends ConsumerStatefulWidget {
  final TaxRate? taxRate;
  final VoidCallback onSave;

  const _TaxRateDialog({
    this.taxRate,
    required this.onSave,
  });

  @override
  ConsumerState<_TaxRateDialog> createState() => _TaxRateDialogState();
}

class _TaxRateDialogState extends ConsumerState<_TaxRateDialog> {
  final _formKey = GlobalKey<FormState>();
  final _service = TaxRateService();
  
  late TextEditingController _nameController;
  late TextEditingController _rateController;
  late TaxType _selectedType;
  
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.taxRate?.name ?? '');
    _rateController = TextEditingController(
      text: widget.taxRate?.rate.toString() ?? '',
    );
    _selectedType = widget.taxRate?.type ?? TaxType.gst;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.taxRate == null ? 'New Tax Rate' : 'Edit Tax Rate'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name*',
                  hintText: 'e.g., GST 18%',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<TaxType>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Type',
                ),
                items: TaxType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.value),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedType = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _rateController,
                decoration: const InputDecoration(
                  labelText: 'Rate (%)*',
                  hintText: '18',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter rate';
                  }
                  final rate = double.tryParse(value);
                  if (rate == null || rate < 0 || rate > 100) {
                    return 'Invalid rate';
                  }
                  return null;
                },
              ),
              // HSN code and isDefault removed as they're not part of TaxRate entity
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _save,
          child: Text(widget.taxRate == null ? 'Create' : 'Update'),
        ),
      ],
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      // Get organization ID from the current context
      final organizationId = ref.read(currentOrganizationIdProvider);
      if (organizationId == null) return;

      final rate = double.parse(_rateController.text);
      final taxRate = TaxRate(
        id: widget.taxRate?.id ?? '',
        organizationId: organizationId,
        name: _nameController.text.trim(),
        type: _selectedType,
        rate: rate,
        cgstRate: _selectedType == TaxType.gst ? rate / 2 : 0,
        sgstRate: _selectedType == TaxType.gst ? rate / 2 : 0,
        igstRate: _selectedType == TaxType.gst ? rate : 0,
        cessRate: 0,
        code: _nameController.text.trim().replaceAll(' ', '_').toUpperCase(),
        isCompound: false,
        isInclusive: false,
        isActive: true,
        createdAt: widget.taxRate?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      if (widget.taxRate == null) {
        await _service.createTaxRate(taxRate);
      } else {
        await _service.updateTaxRate(widget.taxRate!.id, taxRate);
      }

      // Default tax rate functionality removed

      widget.onSave();
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
}