import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/settings_provider.dart';
import '../../domain/models/settings_model.dart';

/// Settings screen
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Account section
            _SettingSection(
              title: 'Account',
              children: [
                _SettingTile(
                  icon: Icons.person,
                  title: 'Profile',
                  onTap: () => context.go('/profile'),
                ),
                _SettingTile(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              context.go('/login');
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),

            // Display section
            _SettingSection(
              title: 'Display',
              children: [
                _SettingTileWithDropdown(
                  icon: Icons.brightness_4,
                  title: 'Theme',
                  value: settings.themeMode.toString().split('.')[1],
                  options: {'light': 'Light', 'dark': 'Dark', 'system': 'System'},
                  onChanged: (value) {
                    final mode = value == 'dark'
                        ? ThemeMode.dark
                        : value == 'system'
                            ? ThemeMode.system
                            : ThemeMode.light;
                    ref.read(settingsProvider.notifier).setThemeMode(mode);
                  },
                ),
                _SettingTile(
                  icon: Icons.language,
                  title: 'Language',
                  subtitle: 'English',
                  onTap: () {},
                ),
              ],
            ),

            // Reading section
            _SettingSection(
              title: 'Reading',
              children: [
                _SettingTileWithSwitch(
                  icon: Icons.bookmark,
                  title: 'Auto-save Progress',
                  value: settings.autoSaveProgress,
                  onChanged: (value) {
                    ref
                        .read(settingsProvider.notifier)
                        .setAutoSaveProgress(value);
                  },
                ),
              ],
            ),

            // Notifications section
            _SettingSection(
              title: 'Notifications',
              children: [
                _SettingTileWithSwitch(
                  icon: Icons.notifications,
                  title: 'Enable Notifications',
                  value: settings.notificationsEnabled,
                  onChanged: (value) {
                    ref
                        .read(settingsProvider.notifier)
                        .setNotifications(value);
                  },
                ),
              ],
            ),

            // About section
            _SettingSection(
              title: 'About',
              children: [
                _SettingTile(
                  icon: Icons.info,
                  title: 'App Version',
                  subtitle: '1.0.0',
                  onTap: () {},
                ),
                _SettingTile(
                  icon: Icons.description,
                  title: 'Privacy Policy',
                  onTap: () {},
                ),
                _SettingTile(
                  icon: Icons.description,
                  title: 'Terms of Service',
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

/// Settings section widget
class _SettingSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        ...children,
        const Divider(height: 1),
      ],
    );
  }
}

/// Setting tile widget
class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _SettingTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

/// Setting tile with switch
class _SettingTileWithSwitch extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingTileWithSwitch({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

/// Setting tile with dropdown
class _SettingTileWithDropdown extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Map<String, String> options;
  final ValueChanged<String> onChanged;

  const _SettingTileWithDropdown({
    required this.icon,
    required this.title,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      trailing: DropdownButton<String>(
        value: value,
        items: options.entries
            .map(
              (e) => DropdownMenuItem(
                value: e.key,
                child: Text(e.value),
              ),
            )
            .toList(),
        onChanged: (newValue) {
          if (newValue != null) {
            onChanged(newValue);
          }
        },
      ),
    );
  }
}
