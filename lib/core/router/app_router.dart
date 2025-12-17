import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/profile_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/library/presentation/screens/library_screen.dart';
import '../../features/reader/presentation/screens/reader_screen.dart';
import '../../features/ai/presentation/screens/ai_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/home/presentation/screens/main_navigation_screen.dart';

/// GoRouter configuration for app navigation
final goRouterProvider = Provider<GoRouter>((ref) {
  // In a real app, you would check authentication state here
  final isLoggedIn = false; // Replace with actual auth check

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      ShellRoute(
      builder: (context, state, child) {
        return MainNavigationScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/main/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/main/library',
          builder: (context, state) => const LibraryScreen(),
        ),
        GoRoute(
          path: '/main/ai',
          builder: (context, state) => const AIScreen(),
        ),
        GoRoute(
          path: '/main/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
      GoRoute(
        path: '/reader/:storyId',
        name: 'reader',
        builder: (context, state) {
          final storyId = state.pathParameters['storyId'] ?? '';
          return ReaderScreen(storyId: storyId);
        },
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Text('Route not found: ${state.uri.toString()}'),
          // child: Text('Route not found: ${state.location}'),
        ),
      );
    },
    redirect: (context, state) {
      // Handle splash/auth redirect logic here
      return null;
    },
  );
});
