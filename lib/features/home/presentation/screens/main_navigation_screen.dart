import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Main navigation screen with bottom navigation
class MainNavigationScreen extends StatelessWidget {
  final Widget child;

  const MainNavigationScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    int index = 0;
    if (location.contains('/explore')) index = 1;
    if (location.contains('/library')) index = 2;
    if (location.contains('/ai')) index = 3;
    if (location.contains('/settings')) index = 4;

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) {
          const routes = [
            '/main/home',
            '/main/explore',
            '/main/library',
            '/main/ai',
            '/main/settings',
          ];
          context.go(routes[i]);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Khám phá'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
