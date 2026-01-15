import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'features/settings/presentation/providers/settings_provider.dart';
import 'services/storage/shared_preferences_service.dart';
import 'services/notification/firebase_messaging_service.dart';
import 'features/notifications/presentation/providers/notification_provider.dart';
import 'features/notifications/domain/models/app_notification.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Initialize shared preferences if needed
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService().init();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Firebase Messaging
  final fcmService = FirebaseMessagingService();
  await fcmService.initialize();

  runApp(
    ProviderScope(
      child: StoryNestApp(fcmService: fcmService),
    ),
  );
}

/// Main app widget
class StoryNestApp extends ConsumerStatefulWidget {
  final FirebaseMessagingService fcmService;

  const StoryNestApp({Key? key, required this.fcmService}) : super(key: key);

  @override
  ConsumerState<StoryNestApp> createState() => _StoryNestAppState();
}

class _StoryNestAppState extends ConsumerState<StoryNestApp> {
  @override
  void initState() {
    super.initState();
    _setupNotificationListeners();
  }

  void _setupNotificationListeners() {
    // Listen to foreground notifications
    widget.fcmService.onNotificationReceived.listen((RemoteMessage message) {
      // Add notification to provider
      final notification = AppNotification(
        id: message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        data: message.data,
        timestamp: DateTime.now(),
        isRead: false,
        type: message.data['type'] as String?,
      );

      ref.read(notificationProvider.notifier).addNotification(notification);

      // Don't show in-app notification to avoid duplicates
      // System notification is already shown by Firebase
      // _showInAppNotification(message);

      // Handle navigation if needed
      _handleNotificationNavigation(message);
    });
  }

  void _showInAppNotification(RemoteMessage message) {
    // Show a snackbar or custom notification UI when app is in foreground
    if (mounted) {
      final context = ref.read(goRouterProvider).routerDelegate.navigatorKey.currentContext;
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.notification?.title ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (message.notification?.body != null)
                  Text(message.notification!.body!),
              ],
            ),
            action: SnackBarAction(
              label: 'Xem',
              onPressed: () {
                ref.read(goRouterProvider).push('/notifications');
              },
            ),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  void _handleNotificationNavigation(RemoteMessage message) {
    // Navigate based on notification data
    final targetScreen = message.data['targetScreen'] as String?;
    if (targetScreen != null && mounted) {
      // Delay navigation slightly to avoid conflicts
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          ref.read(goRouterProvider).push(targetScreen);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(goRouterProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Truyện Hay',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
    );
  }
}
