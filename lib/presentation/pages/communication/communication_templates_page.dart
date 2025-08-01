import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/communication_template.dart';
import '../../../services/communication/communication_service.dart';
import '../../providers/organization_provider.dart';

final communicationTemplatesProvider = FutureProvider.autoDispose<List<CommunicationTemplate>>((ref) async {
  final organizationId = ref.watch(currentOrganizationIdProvider);
  if (organizationId == null) return [];
  
  final service = CommunicationService();
  return service.getTemplates(organizationId);
});

class CommunicationTemplatesPage extends ConsumerWidget {
  const CommunicationTemplatesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templatesAsync = ref.watch(communicationTemplatesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Communication Templates'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showTemplateDialog(context, ref),
          ),
        ],
      ),
      body: templatesAsync.when(
        data: (templates) {
          if (templates.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.message,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No templates created',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create SMS, Email and WhatsApp templates',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => _showTemplateDialog(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text('Create Template'),
                  ),
                ],
              ),
            );
          }

          final smsTemplates = templates.where((t) => t.channel == CommunicationChannel.sms).toList();
          final emailTemplates = templates.where((t) => t.channel == CommunicationChannel.email).toList();
          final whatsappTemplates = templates.where((t) => t.channel == CommunicationChannel.whatsapp).toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (smsTemplates.isNotEmpty) ...[
                _buildSection(context, 'SMS Templates', smsTemplates, Icons.sms, Colors.blue),
                const SizedBox(height: 16),
              ],
              if (emailTemplates.isNotEmpty) ...[
                _buildSection(context, 'Email Templates', emailTemplates, Icons.email, Colors.red),
                const SizedBox(height: 16),
              ],
              if (whatsappTemplates.isNotEmpty) ...[
                _buildSection(context, 'WhatsApp Templates', whatsappTemplates, Icons.chat, Colors.green),
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

  Widget _buildSection(
    BuildContext context,
    String title,
    List<CommunicationTemplate> templates,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...templates.map((template) => ListTile(
            leading: CircleAvatar(
              backgroundColor: template.isActive
                  ? color.withValues(alpha: 0.1)
                  : Colors.grey.shade200,
              child: Icon(
                _getTriggerIcon(template.triggerEvent),
                color: template.isActive ? color : Colors.grey,
                size: 20,
              ),
            ),
            title: Text(
              template.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  template.triggerEvent.displayName,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  template.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            trailing: Switch(
              value: template.isActive,
              onChanged: (value) {
                // TODO: Toggle template status
              },
            ),
            onTap: () => _showTemplatePreview(context, template),
          )),
        ],
      ),
    );
  }

  IconData _getTriggerIcon(TriggerEvent event) {
    switch (event) {
      case TriggerEvent.orderPlaced:
        return Icons.shopping_cart;
      case TriggerEvent.orderDelivered:
        return Icons.local_shipping;
      case TriggerEvent.orderShipped:
        return Icons.local_shipping;
      case TriggerEvent.paymentReceived:
        return Icons.payment;
      case TriggerEvent.lowStock:
        return Icons.warning;
      case TriggerEvent.customerRegistration:
        return Icons.person_add;
      case TriggerEvent.invoiceGenerated:
        return Icons.receipt;
      case TriggerEvent.custom:
        return Icons.star;
    }
  }

  void _showTemplateDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => const _TemplateDialog(),
    );
  }

  void _showTemplatePreview(BuildContext context, CommunicationTemplate template) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              template.channel == CommunicationChannel.sms
                  ? Icons.sms
                  : template.channel == CommunicationChannel.email
                      ? Icons.email
                      : Icons.chat,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(template.name),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (template.channel == CommunicationChannel.email && template.subject != null) ...[
                      Text(
                        'Subject: ${template.subject}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                    ],
                    Text(template.content),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Variables:',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: template.variables.map((variable) => Chip(
                  label: Text(
                    '{$variable}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  visualDensity: VisualDensity.compact,
                )).toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          FilledButton.icon(
            onPressed: () {
              // TODO: Test template
            },
            icon: const Icon(Icons.send),
            label: const Text('Send Test'),
          ),
        ],
      ),
    );
  }
}

class _TemplateDialog extends StatefulWidget {
  const _TemplateDialog();

  @override
  State<_TemplateDialog> createState() => _TemplateDialogState();
}

class _TemplateDialogState extends State<_TemplateDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _subjectController = TextEditingController();
  final _contentController = TextEditingController();
  
  CommunicationChannel _selectedChannel = CommunicationChannel.sms;
  TriggerEvent _selectedTrigger = TriggerEvent.orderPlaced;

  @override
  void dispose() {
    _nameController.dispose();
    _subjectController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Communication Template'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Template Name*',
                  hintText: 'e.g., Order Confirmation SMS',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter template name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<CommunicationChannel>(
                value: _selectedChannel,
                decoration: const InputDecoration(
                  labelText: 'Channel',
                ),
                items: CommunicationChannel.values.map((channel) {
                  return DropdownMenuItem(
                    value: channel,
                    child: Row(
                      children: [
                        Icon(
                          channel == CommunicationChannel.sms
                              ? Icons.sms
                              : channel == CommunicationChannel.email
                                  ? Icons.email
                                  : Icons.chat,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(channel.displayName),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedChannel = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<TriggerEvent>(
                value: _selectedTrigger,
                decoration: const InputDecoration(
                  labelText: 'Trigger Event',
                ),
                items: TriggerEvent.values.map((event) {
                  return DropdownMenuItem(
                    value: event,
                    child: Text(event.displayName),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedTrigger = value);
                  }
                },
              ),
              if (_selectedChannel == CommunicationChannel.email) ...[
                const SizedBox(height: 16),
                TextFormField(
                  controller: _subjectController,
                  decoration: const InputDecoration(
                    labelText: 'Subject*',
                    hintText: 'Email subject line',
                  ),
                  validator: _selectedChannel == CommunicationChannel.email
                      ? (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter subject';
                          }
                          return null;
                        }
                      : null,
                ),
              ],
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Content*',
                  hintText: 'Message content with {variables}',
                  helperText: 'Use {customer_name}, {order_id}, etc.',
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.blue.shade700,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Available Variables',
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '{customer_name}, {order_id}, {order_total}, {product_name}, {quantity}, {tracking_number}',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
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
        FilledButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // TODO: Create template
              Navigator.of(context).pop();
            }
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}