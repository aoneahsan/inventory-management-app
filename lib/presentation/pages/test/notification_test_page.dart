import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/notification/email_sms_service.dart';
import '../../providers/auth_provider.dart';

class NotificationTestPage extends ConsumerStatefulWidget {
  const NotificationTestPage({super.key});

  @override
  ConsumerState<NotificationTestPage> createState() => _NotificationTestPageState();
}

class _NotificationTestPageState extends ConsumerState<NotificationTestPage> {
  final _emailSmsService = EmailSmsService();
  bool _isLoading = false;
  String? _lastResult;

  Future<void> _testNotification(String type) async {
    setState(() {
      _isLoading = true;
      _lastResult = null;
    });

    try {
      final user = ref.read(currentUserProvider);
      if (user == null) {
        throw Exception('User not logged in');
      }

      switch (type) {
        case 'welcome':
          await _emailSmsService.sendWelcomeEmail(
            userName: user.name,
            organizationName: 'Test Organization',
          );
          break;
        case 'lowStock':
          await _emailSmsService.sendLowStockNotification(
            productName: 'Test Product',
            productSku: 'TEST-001',
            currentStock: 5,
            threshold: 10,
          );
          break;
        case 'orderConfirmation':
          await _emailSmsService.sendOrderConfirmation(
            orderNumber: 'ORD-2024-001',
            totalAmount: 99.99,
            items: [
              {
                'name': 'Test Product 1',
                'quantity': 2,
                'price': 25.00,
                'total': 50.00,
              },
              {
                'name': 'Test Product 2',
                'quantity': 1,
                'price': 49.99,
                'total': 49.99,
              },
            ],
          );
          break;
        case 'invoiceReady':
          await _emailSmsService.sendNotification(
            template: 'invoiceReady',
            data: {
              'invoice_number': 'INV-2024-001',
              'amount': '99.99',
              'due_date': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
            },
          );
          break;
        case 'paymentReminder':
          await _emailSmsService.sendNotification(
            template: 'paymentReminder',
            data: {
              'invoice_number': 'INV-2024-001',
              'amount': '99.99',
              'due_date': DateTime.now().toIso8601String(),
            },
          );
          break;
        case 'orderShipped':
          await _emailSmsService.sendNotification(
            template: 'orderShipped',
            data: {
              'order_number': 'ORD-2024-001',
              'tracking_number': '1234567890',
              'estimated_delivery': DateTime.now().add(const Duration(days: 3)).toIso8601String(),
            },
          );
          break;
        case 'systemAlert':
          await _emailSmsService.sendNotification(
            template: 'systemAlert',
            data: {
              'alert_type': 'Security Update',
              'alert_message': 'Your account security settings have been updated.',
            },
          );
          break;
      }

      setState(() {
        _lastResult = '$type notification sent successfully!';
      });
    } catch (e) {
      setState(() {
        _lastResult = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Test'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email/SMS Notification Testing',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Test different notification types. Make sure your notification preferences are configured.',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Notification Test Buttons
            _buildTestButton(
              'Welcome Email',
              'Send a welcome email notification',
              Icons.email,
              () => _testNotification('welcome'),
            ),
            _buildTestButton(
              'Low Stock Alert',
              'Send a low stock notification',
              Icons.inventory_2,
              () => _testNotification('lowStock'),
            ),
            _buildTestButton(
              'Order Confirmation',
              'Send an order confirmation notification',
              Icons.receipt_long,
              () => _testNotification('orderConfirmation'),
            ),
            _buildTestButton(
              'Invoice Ready',
              'Send an invoice ready notification',
              Icons.request_page,
              () => _testNotification('invoiceReady'),
            ),
            _buildTestButton(
              'Payment Reminder',
              'Send a payment reminder notification',
              Icons.payment,
              () => _testNotification('paymentReminder'),
            ),
            _buildTestButton(
              'Order Shipped',
              'Send an order shipped notification',
              Icons.local_shipping,
              () => _testNotification('orderShipped'),
            ),
            _buildTestButton(
              'System Alert',
              'Send a system alert notification',
              Icons.warning_amber,
              () => _testNotification('systemAlert'),
            ),
            
            // Result Display
            if (_lastResult != null) ...[
              const SizedBox(height: 24),
              Card(
                color: _lastResult!.startsWith('Error') 
                    ? Colors.red.shade50 
                    : Colors.green.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        _lastResult!.startsWith('Error') 
                            ? Icons.error_outline 
                            : Icons.check_circle,
                        color: _lastResult!.startsWith('Error') 
                            ? Colors.red 
                            : Colors.green,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _lastResult!,
                          style: TextStyle(
                            color: _lastResult!.startsWith('Error') 
                                ? Colors.red.shade700 
                                : Colors.green.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            
            // Loading Indicator
            if (_isLoading) ...[
              const SizedBox(height: 24),
              const Center(child: CircularProgressIndicator()),
            ],
            
            // Instructions
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
                          'Setup Instructions',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '1. Configure your notification preferences\n'
                      '2. Make sure email/SMS is enabled in settings\n'
                      '3. Ensure Firebase Functions are deployed\n'
                      '4. Check SendGrid/Twilio configuration in Firebase',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestButton(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: ElevatedButton(
          onPressed: _isLoading ? null : onPressed,
          child: const Text('Test'),
        ),
      ),
    );
  }
}