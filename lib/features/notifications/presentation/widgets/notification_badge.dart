import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/notification_provider.dart';

/// Badge widget showing unread notification count
class NotificationBadge extends ConsumerWidget {
  final Widget child;
  final bool showZero;
  final Color? badgeColor;
  final Color? textColor;

  const NotificationBadge({
    Key? key,
    required this.child,
    this.showZero = false,
    this.badgeColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCount = ref.watch(unreadCountProvider);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        if (unreadCount > 0 || showZero)
          Positioned(
            top: -4,
            right: -4,
            child: Container(
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              decoration: BoxDecoration(
                color: badgeColor ?? Colors.red,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 1.5,
                ),
              ),
              child: Center(
                child: Text(
                  unreadCount > 99 ? '99+' : unreadCount.toString(),
                  style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Icon button with notification badge
class NotificationIconButton extends ConsumerWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color? iconColor;
  final Color? badgeColor;
  final String? tooltip;

  const NotificationIconButton({
    Key? key,
    required this.onPressed,
    this.icon = Icons.notifications,
    this.iconColor,
    this.badgeColor,
    this.tooltip = 'Thông báo',
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotificationBadge(
      badgeColor: badgeColor,
      child: IconButton(
        icon: Icon(icon),
        color: iconColor,
        tooltip: tooltip,
        onPressed: onPressed,
      ),
    );
  }
}
