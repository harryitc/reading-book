import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Main navigation screen with bottom navigation
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<({String name, IconData icon})> _navItems = [
    (name: 'Home', icon: Icons.home),
    (name: 'Library', icon: Icons.library_books),
    (name: 'AI', icon: Icons.auto_awesome),
    (name: 'Settings', icon: Icons.settings),
  ];

  void _onNavItemTap(int index) {
    setState(() => _selectedIndex = index);

    final routes = ['/main/home', '/main/library', '/main/ai', '/main/settings'];
    context.go(routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTap,
        items: _navItems
            .map(
              (item) => BottomNavigationBarItem(
                icon: Icon(item.icon),
                label: item.name,
              ),
            )
            .toList(),
      ),
      body: const RouterView(),
    );
  }
}

/// Route view widget that renders the appropriate screen
class RouterView extends StatelessWidget {
  const RouterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    if (location.contains('/home')) {
      // Home is loaded by router
      return const SizedBox.expand();
    } else if (location.contains('/library')) {
      return const SizedBox.expand();
    } else if (location.contains('/ai')) {
      return const SizedBox.expand();
    } else if (location.contains('/settings')) {
      return const SizedBox.expand();
    }

    return const SizedBox.expand();
  }
}
