import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../database/database_service.dart';
import '../../domain/entities/notification_settings.dart';

// Background message handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling background message: ${message.messageId}');
}

class PushNotificationService {
  static final PushNotificationService _instance = PushNotificationService._internal();
  factory PushNotificationService() => _instance;
  PushNotificationService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  String? _fcmToken;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    
    try {
      // Request permission
      final settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint('User granted notification permission');
        
        // Initialize local notifications
        await _initializeLocalNotifications();
        
        // Get FCM token
        _fcmToken = await _messaging.getToken();
        debugPrint('FCM Token: $_fcmToken');
        
        // Save token to Firestore
        if (_fcmToken != null) {
          await _saveTokenToDatabase(_fcmToken!);
        }
        
        // Listen to token changes
        _messaging.onTokenRefresh.listen(_saveTokenToDatabase);
        
        // Configure message handlers
        FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
        FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
        FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
        
        // Check if app was opened from a notification
        final initialMessage = await _messaging.getInitialMessage();
        if (initialMessage != null) {
          _handleMessageOpenedApp(initialMessage);
        }
        
        _initialized = true;
      } else {
        debugPrint('User declined notification permission');
      }
    } catch (e) {
      debugPrint('Error initializing push notifications: $e');
    }
  }

  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    
    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }

  Future<void> _saveTokenToDatabase(String token) async {
    try {
      final db = DatabaseService();
      final userId = await db.getCurrentUserId();
      if (userId != null) {
        await _firestore.collection('users').doc(userId).update({
          'fcm_token': token,
          'fcm_token_updated_at': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      debugPrint('Error saving FCM token: $e');
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    debugPrint('Received foreground message: ${message.messageId}');
    
    // Show local notification when app is in foreground
    _showLocalNotification(message);
    
    // Handle data payload
    if (message.data.isNotEmpty) {
      _processNotificationData(message.data);
    }
  }

  void _handleMessageOpenedApp(RemoteMessage message) {
    debugPrint('Message opened app: ${message.messageId}');
    
    // Navigate based on notification type
    if (message.data.isNotEmpty) {
      _processNotificationData(message.data);
    }
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'inventory_notifications',
      'Inventory Notifications',
      channelDescription: 'Notifications for inventory management',
      importance: Importance.high,
      priority: Priority.high,
    );
    
    const iosDetails = DarwinNotificationDetails();
    
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    await _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? 'New Notification',
      message.notification?.body ?? '',
      details,
      payload: message.data.toString(),
    );
  }

  void _onNotificationTapped(NotificationResponse response) {
    debugPrint('Notification tapped: ${response.payload}');
    // Handle notification tap
  }

  void _processNotificationData(Map<String, dynamic> data) {
    final type = data['type'] as String?;
    final targetId = data['target_id'] as String?;
    
    switch (type) {
      case 'low_stock':
        // Navigate to product details
        if (targetId != null) {
          // Navigation logic here
        }
        break;
      case 'order_update':
        // Navigate to order details
        if (targetId != null) {
          // Navigation logic here
        }
        break;
      case 'stock_transfer':
        // Navigate to stock transfer
        if (targetId != null) {
          // Navigation logic here
        }
        break;
      case 'announcement':
        // Show announcement
        break;
      default:
        // Default handling
        break;
    }
  }

  // Subscribe to topics
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
      debugPrint('Subscribed to topic: $topic');
    } catch (e) {
      debugPrint('Error subscribing to topic: $e');
    }
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _messaging.unsubscribeFromTopic(topic);
      debugPrint('Unsubscribed from topic: $topic');
    } catch (e) {
      debugPrint('Error unsubscribing from topic: $e');
    }
  }

  // Send notification via Cloud Function
  Future<void> sendNotification({
    required String userId,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      // This would call a Cloud Function to send the notification
      await _firestore.collection('notifications').add({
        'user_id': userId,
        'title': title,
        'body': body,
        'data': data,
        'created_at': FieldValue.serverTimestamp(),
        'read': false,
      });
    } catch (e) {
      debugPrint('Error sending notification: $e');
    }
  }

  // Get notification history
  Stream<List<NotificationModel>> getNotificationHistory(String userId) {
    return _firestore
        .collection('notifications')
        .where('user_id', isEqualTo: userId)
        .orderBy('created_at', descending: true)
        .limit(50)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => NotificationModel.fromFirestore(doc))
            .toList());
  }

  // Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      await _firestore.collection('notifications').doc(notificationId).update({
        'read': true,
        'read_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Error marking notification as read: $e');
    }
  }

  // Clear all notifications
  Future<void> clearAllNotifications(String userId) async {
    try {
      final batch = _firestore.batch();
      final notifications = await _firestore
          .collection('notifications')
          .where('user_id', isEqualTo: userId)
          .get();
      
      for (final doc in notifications.docs) {
        batch.delete(doc.reference);
      }
      
      await batch.commit();
    } catch (e) {
      debugPrint('Error clearing notifications: $e');
    }
  }

  // Get notification settings
  Future<NotificationSettings?> getNotificationSettings(String userId) async {
    try {
      final doc = await _firestore
          .collection('notification_settings')
          .doc(userId)
          .get();
      
      if (doc.exists) {
        return NotificationSettings.fromJson(doc.data()!);
      }
      
      // Create default settings if none exist
      final defaultSettings = NotificationSettings(userId: userId);
      await saveNotificationSettings(defaultSettings);
      return defaultSettings;
    } catch (e) {
      debugPrint('Error getting notification settings: $e');
      return null;
    }
  }

  // Save notification settings
  Future<void> saveNotificationSettings(NotificationSettings settings) async {
    try {
      await _firestore
          .collection('notification_settings')
          .doc(settings.userId)
          .set({
        ...settings.toJson(),
        'updated_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Error saving notification settings: $e');
    }
  }

  // Check if notification should be shown based on settings
  Future<bool> shouldShowNotification(
    String userId,
    String notificationType,
  ) async {
    final settings = await getNotificationSettings(userId);
    if (settings == null || !settings.enabled) return false;

    // Check quiet hours
    if (settings.quietHoursStart != null && settings.quietHoursEnd != null) {
      final now = DateTime.now();
      final currentTime = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
      
      if (currentTime.compareTo(settings.quietHoursStart!) >= 0 &&
          currentTime.compareTo(settings.quietHoursEnd!) <= 0) {
        return false;
      }
    }

    // Check notification type preferences
    switch (notificationType) {
      case 'low_stock':
        return settings.lowStockAlerts;
      case 'order_update':
        return settings.orderUpdates;
      case 'stock_transfer':
        return settings.stockTransferAlerts;
      case 'announcement':
        return settings.systemAnnouncements;
      default:
        return true;
    }
  }
}

// Notification model
class NotificationModel {
  final String id;
  final String userId;
  final String title;
  final String body;
  final Map<String, dynamic>? data;
  final DateTime createdAt;
  final bool read;
  final DateTime? readAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    this.data,
    required this.createdAt,
    required this.read,
    this.readAt,
  });

  factory NotificationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NotificationModel(
      id: doc.id,
      userId: data['user_id'] as String,
      title: data['title'] as String,
      body: data['body'] as String,
      data: data['data'] as Map<String, dynamic>?,
      createdAt: (data['created_at'] as Timestamp).toDate(),
      read: data['read'] as bool? ?? false,
      readAt: data['read_at'] != null 
          ? (data['read_at'] as Timestamp).toDate() 
          : null,
    );
  }
}