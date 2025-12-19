import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'features/settings/presentation/providers/settings_provider.dart';
import 'services/storage/shared_preferences_service.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Initialize shared preferences if needed
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService().init();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  
  
  runApp(
    const ProviderScope(
      child: StoryNestApp(),
    ),
  );
}

/// Main app widget
class StoryNestApp extends ConsumerWidget {
  const StoryNestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'StoryNest',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
    );
  }
}
