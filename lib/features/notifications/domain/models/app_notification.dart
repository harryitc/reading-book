import 'package:json_annotation/json_annotation.dart';

part 'app_notification.g.dart';

/// Notification model for storing push notifications
@JsonSerializable()
class AppNotification {
  /// Unique identifier for the notification
  final String id;

  /// Notification title
  final String title;

  /// Notification body/message
  final String body;

  /// Additional data payload from notification
  final Map<String, dynamic>? data;

  /// Timestamp when notification was received
  final DateTime timestamp;

  /// Whether the notification has been read
  final bool isRead;

  /// Type of notification (optional)
  final String? type;

  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    this.data,
    required this.timestamp,
    this.isRead = false,
    this.type,
  });

  /// Create notification from JSON
  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);

  /// Convert notification to JSON
  Map<String, dynamic> toJson() => _$AppNotificationToJson(this);

  /// Create a copy with modified fields
  AppNotification copyWith({
    String? id,
    String? title,
    String? body,
    Map<String, dynamic>? data,
    DateTime? timestamp,
    bool? isRead,
    String? type,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      data: data ?? this.data,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      type: type ?? this.type,
    );
  }

  /// Get target screen from data payload
  String? get targetScreen => data?['targetScreen'] as String?;

  /// Get story ID from data payload
  String? get storyId => data?['storyId'] as String?;

  /// Get formatted time ago
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years năm trước';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months tháng trước';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} phút trước';
    } else {
      return 'Vừa xong';
    }
  }

  /// Get formatted date and time
  String get formattedDateTime {
    return '${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppNotification &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'AppNotification(id: $id, title: $title, body: $body, timestamp: $timestamp, isRead: $isRead)';
  }
}
