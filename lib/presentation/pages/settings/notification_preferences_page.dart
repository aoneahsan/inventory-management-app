import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/notification/email_sms_service.dart';
import '../../providers/auth_provider.dart';

final emailSmsServiceProvider = Provider<EmailSmsService>((ref) {
  return EmailSmsService();
});

final notificationPreferencesProvider = StateNotifierProvider<NotificationPreferencesNotifier, AsyncValue<NotificationPreferences>>((ref) {
  return NotificationPreferencesNotifier(ref);
});

class NotificationPreferencesNotifier extends StateNotifier<AsyncValue<NotificationPreferences>> {
  final Ref _ref;

  NotificationPreferencesNotifier(this._ref) : super(const AsyncValue.loading()) {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    try {
      final user = _ref.read(currentUserProvider);
      if (user == null) {
        state = AsyncValue.data(NotificationPreferences.defaultPrefs());
        return;
      }

      // Load from user's preferences or use defaults
      final prefs = user.notificationPreferences != null
          ? NotificationPreferences.fromJson(user.notificationPreferences!)
          : NotificationPreferences.defaultPrefs();
      
      state = AsyncValue.data(prefs);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updatePreferences(NotificationPreferences preferences) async {
    state = const AsyncValue.loading();
    try {
      final service = _ref.read(emailSmsServiceProvider);
      await service.updateNotificationPreferences(preferences: preferences);
      state = AsyncValue.data(preferences);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

class NotificationPreferencesPage extends ConsumerStatefulWidget {
  const NotificationPreferencesPage({super.key});

  @override
  ConsumerState<NotificationPreferencesPage> createState() => _NotificationPreferencesPageState();
}

class _NotificationPreferencesPageState extends ConsumerState<NotificationPreferencesPage> {
  @override
  Widget build(BuildContext context) {
    final preferencesAsync = ref.watch(notificationPreferencesProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Preferences'),
        actions: [
          preferencesAsync.maybeWhen(
            data: (prefs) => TextButton(
              onPressed: () => _savePreferences(prefs),
              child: const Text('Save'),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: preferencesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (preferences) => _buildPreferencesForm(preferences),
      ),
    );
  }

  Widget _buildPreferencesForm(NotificationPreferences preferences) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How would you like to receive notifications?',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose your preferred notification channels for different types of alerts.',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildChannelSection(
            title: 'Low Stock Alerts',
            subtitle: 'Get notified when products are running low',
            icon: Icons.inventory_2,
            preferences: preferences.lowStock,
            onChanged: (newPrefs) {
              final updated = NotificationPreferences(
                lowStock: newPrefs,
                orderUpdates: preferences.orderUpdates,
                invoices: preferences.invoices,
                systemAlerts: preferences.systemAlerts,
              );
              ref.read(notificationPreferencesProvider.notifier).updatePreferences(updated);
            },
          ),
          const SizedBox(height: 16),
          _buildChannelSection(
            title: 'Order Updates',
            subtitle: 'Receive updates about order status changes',
            icon: Icons.local_shipping,
            preferences: preferences.orderUpdates,
            onChanged: (newPrefs) {
              final updated = NotificationPreferences(
                lowStock: preferences.lowStock,
                orderUpdates: newPrefs,
                invoices: preferences.invoices,
                systemAlerts: preferences.systemAlerts,
              );
              ref.read(notificationPreferencesProvider.notifier).updatePreferences(updated);
            },
          ),
          const SizedBox(height: 16),
          _buildChannelSection(
            title: 'Invoices & Billing',
            subtitle: 'Get notified about new invoices and payment reminders',
            icon: Icons.receipt_long,
            preferences: preferences.invoices,
            onChanged: (newPrefs) {
              final updated = NotificationPreferences(
                lowStock: preferences.lowStock,
                orderUpdates: preferences.orderUpdates,
                invoices: newPrefs,
                systemAlerts: preferences.systemAlerts,
              );
              ref.read(notificationPreferencesProvider.notifier).updatePreferences(updated);
            },
          ),
          const SizedBox(height: 16),
          _buildChannelSection(
            title: 'System Alerts',
            subtitle: 'Important system updates and security alerts',
            icon: Icons.warning_amber,
            preferences: preferences.systemAlerts,
            onChanged: (newPrefs) {
              final updated = NotificationPreferences(
                lowStock: preferences.lowStock,
                orderUpdates: preferences.orderUpdates,
                invoices: preferences.invoices,
                systemAlerts: newPrefs,
              );
              ref.read(notificationPreferencesProvider.notifier).updatePreferences(updated);
            },
          ),
          const SizedBox(height: 24),
          Card(
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue.shade700),
                      const SizedBox(width: 8),
                      const Text(
                        'Note',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'SMS notifications may incur additional charges based on your carrier rates. '
                    'Email and push notifications are free.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChannelSection({
    required String title,
    required String subtitle,
    required IconData icon,
    required NotificationChannelPrefs preferences,
    required Function(NotificationChannelPrefs) onChanged,
  }) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(icon, color: Theme.of(context).colorScheme.primary),
            ),
            title: Text(title),
            subtitle: Text(subtitle),
            trailing: Switch(
              value: preferences.enabled,
              onChanged: (value) {
                onChanged(NotificationChannelPrefs(
                  enabled: value,
                  email: preferences.email,
                  sms: preferences.sms,
                  push: preferences.push,
                ));
              },
            ),
          ),
          if (preferences.enabled) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildChannelToggle(
                    icon: Icons.email,
                    label: 'Email',
                    value: preferences.email,
                    onChanged: (value) {
                      onChanged(NotificationChannelPrefs(
                        enabled: preferences.enabled,
                        email: value,
                        sms: preferences.sms,
                        push: preferences.push,
                      ));
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildChannelToggle(
                    icon: Icons.sms,
                    label: 'SMS',
                    value: preferences.sms,
                    onChanged: (value) {
                      onChanged(NotificationChannelPrefs(
                        enabled: preferences.enabled,
                        email: preferences.email,
                        sms: value,
                        push: preferences.push,
                      ));
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildChannelToggle(
                    icon: Icons.notifications,
                    label: 'Push Notifications',
                    value: preferences.push,
                    onChanged: (value) {
                      onChanged(NotificationChannelPrefs(
                        enabled: preferences.enabled,
                        email: preferences.email,
                        sms: preferences.sms,
                        push: value,
                      ));
                    },
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildChannelToggle({
    required IconData icon,
    required String label,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: value ? Theme.of(context).colorScheme.primary : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(8),
          color: value ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1) : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: value ? Theme.of(context).colorScheme.primary : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(label)),
            Checkbox(
              value: value,
              onChanged: (v) => onChanged(v ?? false),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _savePreferences(NotificationPreferences preferences) async {
    try {
      await ref.read(notificationPreferencesProvider.notifier).updatePreferences(preferences);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notification preferences saved')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving preferences: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}