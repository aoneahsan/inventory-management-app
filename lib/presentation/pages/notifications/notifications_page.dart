import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/notification/push_notification_service.dart';
import '../../../core/providers.dart';
import '../../../core/routes.dart';
import 'package:intl/intl.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  final _notificationService = PushNotificationService();

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('Not authenticated')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              ref.read(routerProvider).push(Routes.notificationSettings);
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) async {
              switch (value) {
                case 'clear_all':
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Clear All Notifications'),
                      content: const Text('Are you sure you want to clear all notifications?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Clear All'),
                        ),
                      ],
                    ),
                  );
                  if (confirmed == true) {
                    await _notificationService.clearAllNotifications(user.id);
                  }
                  break;
                case 'mark_all_read':
                  // Mark all as read functionality
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'mark_all_read',
                child: Text('Mark all as read'),
              ),
              const PopupMenuItem(
                value: 'clear_all',
                child: Text('Clear all'),
              ),
            ],
          ),
        ],
      ),
      body: StreamBuilder<List<NotificationModel>>(
        stream: _notificationService.getNotificationHistory(user.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final notifications = snapshot.data ?? [];

          if (notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 64,
                    color: Theme.of(context).disabledColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No notifications',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You\'ll see notifications here when you receive them',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).disabledColor,
                        ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return _NotificationTile(
                notification: notification,
                onTap: () async {
                  // Mark as read
                  if (!notification.read) {
                    await _notificationService.markAsRead(notification.id);
                  }
                  
                  // Navigate based on notification type
                  if (notification.data != null) {
                    final type = notification.data!['type'] as String?;
                    final targetId = notification.data!['target_id'] as String?;
                    
                    switch (type) {
                      case 'low_stock':
                        if (targetId != null) {
                          // Navigate to product details
                          ref.read(routerProvider).push('/products/$targetId');
                        }
                        break;
                      case 'order_update':
                        if (targetId != null) {
                          // Navigate to order details
                          ref.read(routerProvider).push('/orders/$targetId');
                        }
                        break;
                      case 'stock_transfer':
                        if (targetId != null) {
                          // Navigate to stock transfer
                          ref.read(routerProvider).push('/stock-transfers/$targetId');
                        }
                        break;
                    }
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const _NotificationTile({
    required this.notification,
    required this.onTap,
  });

  IconData _getIcon() {
    if (notification.data != null) {
      final type = notification.data!['type'] as String?;
      switch (type) {
        case 'low_stock':
          return Icons.inventory_2;
        case 'order_update':
          return Icons.shopping_cart;
        case 'stock_transfer':
          return Icons.swap_horiz;
        case 'announcement':
          return Icons.campaign;
        default:
          return Icons.notifications;
      }
    }
    return Icons.notifications;
  }

  Color _getIconColor(BuildContext context) {
    if (notification.data != null) {
      final type = notification.data!['type'] as String?;
      switch (type) {
        case 'low_stock':
          return Colors.orange;
        case 'order_update':
          return Colors.blue;
        case 'stock_transfer':
          return Colors.green;
        case 'announcement':
          return Colors.purple;
        default:
          return Theme.of(context).primaryColor;
      }
    }
    return Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.yMMMd().add_jm();
    
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _getIconColor(context).withOpacity(0.1),
        child: Icon(
          _getIcon(),
          color: _getIconColor(context),
        ),
      ),
      title: Text(
        notification.title,
        style: TextStyle(
          fontWeight: notification.read ? FontWeight.normal : FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(notification.body),
          const SizedBox(height: 4),
          Text(
            dateFormat.format(notification.createdAt),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      trailing: !notification.read
          ? Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            )
          : null,
      onTap: onTap,
    );
  }
}