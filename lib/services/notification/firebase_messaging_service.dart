import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import '../storage/shared_preferences_service.dart';

/// Background message handler - MUST be top-level function
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print('📱 Background Message: ${message.messageId}');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
  }
  
  // Save notification to local storage
  await FirebaseMessagingService._saveNotificationToStorage(message);
}

/// Firebase Cloud Messaging Service
/// Handles FCM initialization, token management, and message handling
class FirebaseMessagingService {
  static final FirebaseMessagingService _instance = FirebaseMessagingService._internal();
  factory FirebaseMessagingService() => _instance;
  FirebaseMessagingService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _sharedPrefs = SharedPreferencesService();
  
  // Stream controllers for notifications
  final _notificationStreamController = StreamController<RemoteMessage>.broadcast();
  final _tokenStreamController = StreamController<String>.broadcast();

  // Public streams
  Stream<RemoteMessage> get onNotificationReceived => _notificationStreamController.stream;
  Stream<String> get onTokenRefresh => _tokenStreamController.stream;

  String? _currentToken;
  String? get currentToken => _currentToken;

  /// Initialize Firebase Messaging
  Future<void> initialize() async {
    try {
      // Request permission (iOS and Android 13+)
      await requestPermission();
      
      // Get FCM token
      await getToken();
      
      // Setup message handlers
      _setupMessageHandlers();
      
      // Listen to token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        if (kDebugMode) {
          print('🔄 FCM Token refreshed: $newToken');
        }
        _currentToken = newToken;
        _saveToken(newToken);
        _tokenStreamController.add(newToken);
      });

      if (kDebugMode) {
        print('✅ Firebase Messaging initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error initializing Firebase Messaging: $e');
      }
    }
  }

  /// Request notification permission
  Future<bool> requestPermission() async {
    try {
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (kDebugMode) {
        print('📲 Notification permission status: ${settings.authorizationStatus}');
      }

      return settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error requesting permission: $e');
      }
      return false;
    }
  }

  /// Get FCM token
  Future<String?> getToken() async {
    try {
      // Get APNs token first (iOS only)
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        String? apnsToken = await _firebaseMessaging.getAPNSToken();
        if (apnsToken == null) {
          // Wait a bit and retry
          await Future.delayed(const Duration(seconds: 3));
          apnsToken = await _firebaseMessaging.getAPNSToken();
        }
        if (kDebugMode) {
          print('📱 APNs Token: $apnsToken');
        }
      }

      _currentToken = await _firebaseMessaging.getToken();
      
      if (_currentToken != null) {
        await _saveToken(_currentToken!);
        if (kDebugMode) {
          print('🔑 FCM Token: $_currentToken');
        }
      }
      
      return _currentToken;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error getting FCM token: $e');
      }
      return null;
    }
  }

  /// Delete FCM token (useful for logout)
  Future<void> deleteToken() async {
    try {
      await _firebaseMessaging.deleteToken();
      _currentToken = null;
      await _sharedPrefs.remove('fcm_token');
      if (kDebugMode) {
        print('🗑️ FCM Token deleted');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error deleting token: $e');
      }
    }
  }

  /// Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      if (kDebugMode) {
        print('📢 Subscribed to topic: $topic');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error subscribing to topic: $e');
      }
    }
  }

  /// Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      if (kDebugMode) {
        print('📢 Unsubscribed from topic: $topic');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error unsubscribing from topic: $e');
      }
    }
  }

  /// Setup message handlers for different app states
  void _setupMessageHandlers() {
    // 1. FOREGROUND: When app is open and in focus
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('📬 Foreground Message: ${message.messageId}');
        print('Title: ${message.notification?.title}');
        print('Body: ${message.notification?.body}');
        print('Data: ${message.data}');
      }

      // Save to storage
      _saveNotificationToStorage(message);
      
      // Emit event
      _notificationStreamController.add(message);
    });

    // 2. BACKGROUND: When app is in background but not terminated
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // 3. TERMINATED: When app was terminated and opened by tapping notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('🚀 Notification opened app: ${message.messageId}');
        print('Data: ${message.data}');
      }
      
      // Handle navigation based on message.data
      _handleNotificationTap(message);
    });

    // Check if app was opened from terminated state by notification
    _checkInitialMessage();
  }

  /// Check if app was opened from a notification (terminated state)
  Future<void> _checkInitialMessage() async {
    RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
    
    if (initialMessage != null) {
      if (kDebugMode) {
        print('🚀 App opened from terminated state by notification');
        print('Data: ${initialMessage.data}');
      }
      
      // Handle navigation
      _handleNotificationTap(initialMessage);
    }
  }

  /// Handle notification tap - navigate to appropriate screen
  void _handleNotificationTap(RemoteMessage message) {
    // This will be called when user taps on notification
    // Navigation logic will be implemented in main.dart using the stream
    _notificationStreamController.add(message);
  }

  /// Save FCM token to local storage
  Future<void> _saveToken(String token) async {
    await _sharedPrefs.setString('fcm_token', token);
    await _sharedPrefs.setString('fcm_token_timestamp', DateTime.now().toIso8601String());
  }

  /// Get saved FCM token
  Future<String?> getSavedToken() async {
    return _sharedPrefs.getString('fcm_token');
  }

  /// Save notification to local storage
  static Future<void> _saveNotificationToStorage(RemoteMessage message) async {
    try {
      final prefs = SharedPreferencesService();
      
      // Get existing notifications
      final notificationsJson = prefs.getString('notifications') ?? '[]';
      final List<dynamic> notifications = jsonDecode(notificationsJson);
      
      // Create notification object
      final notification = {
        'id': message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString(),
        'title': message.notification?.title ?? '',
        'body': message.notification?.body ?? '',
        'data': message.data,
        'timestamp': DateTime.now().toIso8601String(),
        'isRead': false,
      };
      
      // Add to beginning of list
      notifications.insert(0, notification);
      
      // Keep only last 100 notifications
      if (notifications.length > 100) {
        notifications.removeRange(100, notifications.length);
      }
      
      // Save back to storage
      await prefs.setString('notifications', jsonEncode(notifications));
      
      // Increment unread count
      final unreadCount = prefs.getInt('unread_notification_count') ?? 0;
      await prefs.setInt('unread_notification_count', unreadCount + 1);
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error saving notification to storage: $e');
      }
    }
  }

  /// Dispose streams
  void dispose() {
    _notificationStreamController.close();
    _tokenStreamController.close();
  }
}
