import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/notification_settings.dart';
import '../../../services/notification/push_notification_service.dart';
import '../../../core/providers.dart';

class NotificationSettingsPage extends ConsumerStatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  ConsumerState<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends ConsumerState<NotificationSettingsPage> {
  final _notificationService = PushNotificationService();
  NotificationSettings? _settings;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final user = ref.read(currentUserProvider);
    if (user != null) {
      final settings = await _notificationService.getNotificationSettings(user.id);
      if (mounted) {
        setState(() {
          _settings = settings;
          _loading = false;
        });
      }
    }
  }

  Future<void> _saveSettings() async {
    if (_settings == null) return;

    try {
      await _notificationService.saveNotificationSettings(_settings!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notification settings saved')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving settings: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_settings == null) {
      return const Scaffold(
        body: Center(child: Text('Error loading settings')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveSettings,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Enable Notifications'),
            subtitle: const Text('Receive notifications from the app'),
            value: _settings!.enabled,
            onChanged: (value) {
              setState(() {
                _settings = _settings!.copyWith(enabled: value);
              });
            },
          ),
          const Divider(),
          
          // Notification Types
          ListTile(
            title: const Text('Notification Types'),
            subtitle: const Text('Choose which notifications to receive'),
            enabled: _settings!.enabled,
          ),
          SwitchListTile(
            title: const Text('Low Stock Alerts'),
            subtitle: const Text('Get notified when products are running low'),
            value: _settings!.lowStockAlerts,
            enabled: _settings!.enabled,
            onChanged: _settings!.enabled
                ? (value) {
                    setState(() {
                      _settings = _settings!.copyWith(lowStockAlerts: value);
                    });
                  }
                : null,
          ),
          SwitchListTile(
            title: const Text('Order Updates'),
            subtitle: const Text('Receive updates about order status'),
            value: _settings!.orderUpdates,
            enabled: _settings!.enabled,
            onChanged: _settings!.enabled
                ? (value) {
                    setState(() {
                      _settings = _settings!.copyWith(orderUpdates: value);
                    });
                  }
                : null,
          ),
          SwitchListTile(
            title: const Text('Stock Transfer Alerts'),
            subtitle: const Text('Get notified about stock transfers'),
            value: _settings!.stockTransferAlerts,
            enabled: _settings!.enabled,
            onChanged: _settings!.enabled
                ? (value) {
                    setState(() {
                      _settings = _settings!.copyWith(stockTransferAlerts: value);
                    });
                  }
                : null,
          ),
          SwitchListTile(
            title: const Text('System Announcements'),
            subtitle: const Text('Important updates and announcements'),
            value: _settings!.systemAnnouncements,
            enabled: _settings!.enabled,
            onChanged: _settings!.enabled
                ? (value) {
                    setState(() {
                      _settings = _settings!.copyWith(systemAnnouncements: value);
                    });
                  }
                : null,
          ),
          const Divider(),
          
          // Delivery Methods
          ListTile(
            title: const Text('Delivery Methods'),
            subtitle: const Text('How you want to receive notifications'),
            enabled: _settings!.enabled,
          ),
          SwitchListTile(
            title: const Text('Push Notifications'),
            subtitle: const Text('Receive push notifications on your device'),
            value: _settings!.pushNotifications,
            enabled: _settings!.enabled,
            onChanged: _settings!.enabled
                ? (value) {
                    setState(() {
                      _settings = _settings!.copyWith(pushNotifications: value);
                    });
                  }
                : null,
          ),
          SwitchListTile(
            title: const Text('Email Notifications'),
            subtitle: const Text('Receive notifications via email'),
            value: _settings!.emailNotifications,
            enabled: _settings!.enabled,
            onChanged: _settings!.enabled
                ? (value) {
                    setState(() {
                      _settings = _settings!.copyWith(emailNotifications: value);
                    });
                  }
                : null,
          ),
          const Divider(),
          
          // Low Stock Threshold
          ListTile(
            title: const Text('Low Stock Threshold'),
            subtitle: Text('Alert when stock falls below ${_settings!.lowStockThreshold} units'),
            enabled: _settings!.enabled && _settings!.lowStockAlerts,
            trailing: SizedBox(
              width: 100,
              child: TextField(
                enabled: _settings!.enabled && _settings!.lowStockAlerts,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
                controller: TextEditingController(
                  text: _settings!.lowStockThreshold.toString(),
                ),
                onChanged: (value) {
                  final threshold = int.tryParse(value);
                  if (threshold != null && threshold > 0) {
                    setState(() {
                      _settings = _settings!.copyWith(lowStockThreshold: threshold);
                    });
                  }
                },
              ),
            ),
          ),
          const Divider(),
          
          // Quiet Hours
          ListTile(
            title: const Text('Quiet Hours'),
            subtitle: const Text('Set times when you don\'t want to be disturbed'),
            enabled: _settings!.enabled,
          ),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: const Text('Start Time'),
                  subtitle: Text(_settings!.quietHoursStart ?? 'Not set'),
                  enabled: _settings!.enabled,
                  onTap: _settings!.enabled
                      ? () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (time != null) {
                            setState(() {
                              _settings = _settings!.copyWith(
                                quietHoursStart: '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                              );
                            });
                          }
                        }
                      : null,
                ),
              ),
              Expanded(
                child: ListTile(
                  title: const Text('End Time'),
                  subtitle: Text(_settings!.quietHoursEnd ?? 'Not set'),
                  enabled: _settings!.enabled,
                  onTap: _settings!.enabled
                      ? () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (time != null) {
                            setState(() {
                              _settings = _settings!.copyWith(
                                quietHoursEnd: '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                              );
                            });
                          }
                        }
                      : null,
                ),
              ),
            ],
          ),
          if (_settings!.quietHoursStart != null || _settings!.quietHoursEnd != null)
            TextButton(
              onPressed: _settings!.enabled
                  ? () {
                      setState(() {
                        _settings = _settings!.copyWith(
                          quietHoursStart: null,
                          quietHoursEnd: null,
                        );
                      });
                    }
                  : null,
              child: const Text('Clear Quiet Hours'),
            ),
        ],
      ),
    );
  }
}