import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../services/storage/shared_preferences_service.dart';
import '../../../../core/constants/app_constants.dart';

/// App settings state
class AppSettings {
  final ThemeMode themeMode;
  final bool notificationsEnabled;
  final bool autoSaveProgress;
  final String language;

  const AppSettings({
    this.themeMode = ThemeMode.light,
    this.notificationsEnabled = true,
    this.autoSaveProgress = true,
    this.language = 'en',
  });

  AppSettings copyWith({
    ThemeMode? themeMode,
    bool? notificationsEnabled,
    bool? autoSaveProgress,
    String? language,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      autoSaveProgress: autoSaveProgress ?? this.autoSaveProgress,
      language: language ?? this.language,
    );
  }
}

/// Settings notifier
class SettingsNotifier extends StateNotifier<AppSettings> {
  final SharedPreferencesService _prefs;

  SettingsNotifier(this._prefs) : super(const AppSettings());

  /// Load settings from storage
  Future<void> loadSettings() async {
    try {
      final themeModeString = _prefs.getString(AppConstants.themeKey) ?? 'light';
      final notificationsEnabled = _prefs.getBool('notifications_enabled') ?? true;
      final autoSaveProgress = _prefs.getBool('auto_save_progress') ?? true;
      final language = _prefs.getString('language') ?? 'en';

      final themeMode = themeModeString == 'dark'
          ? ThemeMode.dark
          : themeModeString == 'system'
              ? ThemeMode.system
              : ThemeMode.light;

      state = AppSettings(
        themeMode: themeMode,
        notificationsEnabled: notificationsEnabled,
        autoSaveProgress: autoSaveProgress,
        language: language,
      );
    } catch (e) {
      // Use default
    }
  }

  /// Set theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    try {
      final modeString = mode == ThemeMode.dark
          ? 'dark'
          : mode == ThemeMode.system
              ? 'system'
              : 'light';
      await _prefs.setString(AppConstants.themeKey, modeString);
      state = state.copyWith(themeMode: mode);
    } catch (e) {
      // Handle error
    }
  }

  /// Toggle notifications
  Future<void> setNotifications(bool enabled) async {
    try {
      await _prefs.setBool('notifications_enabled', enabled);
      state = state.copyWith(notificationsEnabled: enabled);
    } catch (e) {
      // Handle error
    }
  }

  /// Toggle auto-save progress
  Future<void> setAutoSaveProgress(bool enabled) async {
    try {
      await _prefs.setBool('auto_save_progress', enabled);
      state = state.copyWith(autoSaveProgress: enabled);
    } catch (e) {
      // Handle error
    }
  }

  /// Set language
  Future<void> setLanguage(String lang) async {
    try {
      await _prefs.setString('language', lang);
      state = state.copyWith(language: lang);
    } catch (e) {
      // Handle error
    }
  }
}

/// Settings provider
final settingsProvider =
    StateNotifierProvider<SettingsNotifier, AppSettings>((ref) {
  final prefs = SharedPreferencesService();
  return SettingsNotifier(prefs);
});

/// Theme mode provider
final themeModeProvider = Provider<ThemeMode>((ref) {
  return ref.watch(settingsProvider).themeMode;
});

/// Notifications enabled provider
final notificationsEnabledProvider = Provider<bool>((ref) {
  return ref.watch(settingsProvider).notificationsEnabled;
});

/// Auto-save progress provider
final autoSaveProgressProvider = Provider<bool>((ref) {
  return ref.watch(settingsProvider).autoSaveProgress;
});
