import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../services/storage/shared_preferences_service.dart';
import '../../data/repositories/notification_repository.dart';
import '../../domain/models/app_notification.dart';

/// Provider for SharedPreferencesService
final sharedPreferencesServiceProvider = Provider<SharedPreferencesService>((ref) {
  return SharedPreferencesService();
});

/// Provider for NotificationRepository
final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesServiceProvider);
  return NotificationRepository(sharedPrefs);
});

/// State for notification list
class NotificationState {
  final List<AppNotification> notifications;
  final int unreadCount;
  final bool isLoading;
  final String? error;

  const NotificationState({
    this.notifications = const [],
    this.unreadCount = 0,
    this.isLoading = false,
    this.error,
  });

  NotificationState copyWith({
    List<AppNotification>? notifications,
    int? unreadCount,
    bool? isLoading,
    String? error,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

/// Notification provider (StateNotifier)
class NotificationNotifier extends StateNotifier<NotificationState> {
  final NotificationRepository _repository;

  NotificationNotifier(this._repository) : super(const NotificationState()) {
    loadNotifications();
  }

  /// Load all notifications from storage
  Future<void> loadNotifications() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      
      final notifications = await _repository.getNotifications();
      final unreadCount = await _repository.getUnreadCount();
      
      state = state.copyWith(
        notifications: notifications,
        unreadCount: unreadCount,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Add a new notification
  Future<void> addNotification(AppNotification notification) async {
    try {
      await _repository.addNotification(notification);
      await loadNotifications();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    try {
      await _repository.markAsRead(notificationId);
      
      // Update state locally for instant feedback
      final updatedNotifications = state.notifications.map((n) {
        if (n.id == notificationId && !n.isRead) {
          return n.copyWith(isRead: true);
        }
        return n;
      }).toList();
      
      final unreadCount = (state.unreadCount - 1).clamp(0, double.infinity).toInt();
      
      state = state.copyWith(
        notifications: updatedNotifications,
        unreadCount: unreadCount,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead() async {
    try {
      await _repository.markAllAsRead();
      
      // Update state locally
      final updatedNotifications = state.notifications
          .map((n) => n.copyWith(isRead: true))
          .toList();
      
      state = state.copyWith(
        notifications: updatedNotifications,
        unreadCount: 0,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Delete a notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      final notification = state.notifications.firstWhere((n) => n.id == notificationId);
      
      await _repository.deleteNotification(notificationId);
      
      // Update state locally
      final updatedNotifications = state.notifications
          .where((n) => n.id != notificationId)
          .toList();
      
      final unreadCount = !notification.isRead
          ? (state.unreadCount - 1).clamp(0, double.infinity).toInt()
          : state.unreadCount;
      
      state = state.copyWith(
        notifications: updatedNotifications,
        unreadCount: unreadCount,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Clear all notifications
  Future<void> clearAll() async {
    try {
      await _repository.clearAll();
      state = const NotificationState();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Get unread notifications only
  List<AppNotification> get unreadNotifications {
    return state.notifications.where((n) => !n.isRead).toList();
  }

  /// Refresh notifications (pull to refresh)
  Future<void> refresh() async {
    await loadNotifications();
  }
}

/// Provider for NotificationNotifier
final notificationProvider = StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
  final repository = ref.watch(notificationRepositoryProvider);
  return NotificationNotifier(repository);
});

/// Provider for unread count only (optimized for badge)
final unreadCountProvider = Provider<int>((ref) {
  return ref.watch(notificationProvider).unreadCount;
});

/// Provider for unread notifications only
final unreadNotificationsProvider = Provider<List<AppNotification>>((ref) {
  final notifier = ref.watch(notificationProvider.notifier);
  return notifier.unreadNotifications;
});
