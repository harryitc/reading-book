import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../../../services/storage/shared_preferences_service.dart';
import '../../domain/models/app_notification.dart';

/// Repository for managing notifications in local storage
class NotificationRepository {
  final SharedPreferencesService _prefs;

  NotificationRepository(this._prefs);

  static const String _notificationsKey = 'notifications';
  static const String _unreadCountKey = 'unread_notification_count';
  static const int _maxNotifications = 100;

  /// Get all notifications from storage
  Future<List<AppNotification>> getNotifications() async {
    try {
      final notificationsJson = _prefs.getString(_notificationsKey) ?? '[]';
      final List<dynamic> notificationsList = jsonDecode(notificationsJson);
      
      return notificationsList
          .map((json) => AppNotification.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error getting notifications: $e');
      }
      return [];
    }
  }

  /// Get unread notifications count
  Future<int> getUnreadCount() async {
    return _prefs.getInt(_unreadCountKey) ?? 0;
  }

  /// Add a new notification
  Future<void> addNotification(AppNotification notification) async {
    try {
      final notifications = await getNotifications();
      
      // Check if notification with same ID already exists (prevent duplicates)
      final exists = notifications.any((n) => n.id == notification.id);
      if (exists) {
        if (kDebugMode) {
          print('⚠️ Notification ${notification.id} already exists, skipping...');
        }
        return; // Don't save duplicate
      }
      
      // Add to beginning
      notifications.insert(0, notification);
      
      // Keep only last N notifications
      if (notifications.length > _maxNotifications) {
        notifications.removeRange(_maxNotifications, notifications.length);
      }
      
      // Save
      await _saveNotifications(notifications);
      
      // Increment unread count if not read
      if (!notification.isRead) {
        final count = await getUnreadCount();
        await _prefs.setInt(_unreadCountKey, count + 1);
      }
      
      if (kDebugMode) {
        print('✅ Notification ${notification.id} saved successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error adding notification: $e');
      }
    }
  }

  /// Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      final notifications = await getNotifications();
      final index = notifications.indexWhere((n) => n.id == notificationId);
      
      if (index != -1) {
        final notification = notifications[index];
        
        // Only update if currently unread
        if (!notification.isRead) {
          notifications[index] = notification.copyWith(isRead: true);
          await _saveNotifications(notifications);
          
          // Decrement unread count
          final count = await getUnreadCount();
          await _prefs.setInt(_unreadCountKey, (count - 1).clamp(0, double.infinity).toInt());
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error marking notification as read: $e');
      }
    }
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead() async {
    try {
      final notifications = await getNotifications();
      final updatedNotifications = notifications
          .map((n) => n.copyWith(isRead: true))
          .toList();
      
      await _saveNotifications(updatedNotifications);
      await _prefs.setInt(_unreadCountKey, 0);
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error marking all as read: $e');
      }
    }
  }

  /// Delete a notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      final notifications = await getNotifications();
      final notification = notifications.firstWhere(
        (n) => n.id == notificationId,
        orElse: () => throw Exception('Notification not found'),
      );
      
      notifications.removeWhere((n) => n.id == notificationId);
      await _saveNotifications(notifications);
      
      // Decrement unread count if it was unread
      if (!notification.isRead) {
        final count = await getUnreadCount();
        await _prefs.setInt(_unreadCountKey, (count - 1).clamp(0, double.infinity).toInt());
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error deleting notification: $e');
      }
    }
  }

  /// Clear all notifications
  Future<void> clearAll() async {
    try {
      await _prefs.remove(_notificationsKey);
      await _prefs.setInt(_unreadCountKey, 0);
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error clearing notifications: $e');
      }
    }
  }

  /// Get notifications by type
  Future<List<AppNotification>> getNotificationsByType(String type) async {
    final notifications = await getNotifications();
    return notifications.where((n) => n.type == type).toList();
  }

  /// Get unread notifications only
  Future<List<AppNotification>> getUnreadNotifications() async {
    final notifications = await getNotifications();
    return notifications.where((n) => !n.isRead).toList();
  }

  /// Save notifications to storage
  Future<void> _saveNotifications(List<AppNotification> notifications) async {
    final notificationsJson = jsonEncode(
      notifications.map((n) => n.toJson()).toList(),
    );
    await _prefs.setString(_notificationsKey, notificationsJson);
  }
}
