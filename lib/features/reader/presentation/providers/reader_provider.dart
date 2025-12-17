import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../services/storage/shared_preferences_service.dart';

/// Reading progress model
class ReadingProgress {
  final String storyId;
  final int currentPage;
  final int totalPages;
  final DateTime lastReadAt;

  const ReadingProgress({
    required this.storyId,
    required this.currentPage,
    required this.totalPages,
    required this.lastReadAt,
  });

  int get progressPercentage => ((currentPage / totalPages) * 100).toInt();
}

/// Reader settings state
class ReaderSettings {
  final double fontSize;
  final bool isDarkMode;
  final String fontFamily;

  const ReaderSettings({
    this.fontSize = AppConstants.defaultFontSize,
    this.isDarkMode = false,
    this.fontFamily = 'CustomFont',
  });

  ReaderSettings copyWith({
    double? fontSize,
    bool? isDarkMode,
    String? fontFamily,
  }) {
    return ReaderSettings(
      fontSize: fontSize ?? this.fontSize,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      fontFamily: fontFamily ?? this.fontFamily,
    );
  }
}

/// Reader notifier
class ReaderNotifier extends StateNotifier<ReaderSettings> {
  final SharedPreferencesService _prefs;

  ReaderNotifier(this._prefs) : super(const ReaderSettings());

  /// Load saved settings
  Future<void> loadSettings() async {
    try {
      final fontSize = _prefs.getDouble(AppConstants.fontSizeKey) ??
          AppConstants.defaultFontSize;
      final isDarkMode =
          _prefs.getBool('reader_dark_mode') ?? false;

      state = state.copyWith(
        fontSize: fontSize,
        isDarkMode: isDarkMode,
      );
    } catch (e) {
      // Use default
    }
  }

  /// Update font size
  Future<void> setFontSize(double size) async {
    try {
      await _prefs.setDouble(AppConstants.fontSizeKey, size);
      state = state.copyWith(fontSize: size);
    } catch (e) {
      // Handle error
    }
  }

  /// Toggle dark mode
  Future<void> toggleDarkMode() async {
    try {
      await _prefs.setBool('reader_dark_mode', !state.isDarkMode);
      state = state.copyWith(isDarkMode: !state.isDarkMode);
    } catch (e) {
      // Handle error
    }
  }

  /// Increase font size
  void increaseFontSize() {
    if (state.fontSize < AppConstants.maxFontSize) {
      setFontSize(state.fontSize + 1);
    }
  }

  /// Decrease font size
  void decreaseFontSize() {
    if (state.fontSize > AppConstants.minFontSize) {
      setFontSize(state.fontSize - 1);
    }
  }
}

/// Reading progress notifier
class ReadingProgressNotifier extends StateNotifier<ReadingProgress?> {
  final SharedPreferencesService _prefs;

  ReadingProgressNotifier(this._prefs) : super(null);

  /// Save reading progress
  Future<void> saveProgress(String storyId, int currentPage, int totalPages) async {
    try {
      final progress = ReadingProgress(
        storyId: storyId,
        currentPage: currentPage,
        totalPages: totalPages,
        lastReadAt: DateTime.now(),
      );

      // Save to preferences
      await _prefs.setInt('${AppConstants.readingProgressKey}_$storyId',
          currentPage);
      await _prefs.setString('${AppConstants.readingProgressKey}_time_$storyId',
          DateTime.now().toIso8601String());

      state = progress;
    } catch (e) {
      // Handle error
    }
  }

  /// Load reading progress
  Future<void> loadProgress(String storyId, int totalPages) async {
    try {
      final currentPage =
          _prefs.getInt('${AppConstants.readingProgressKey}_$storyId') ?? 0;
      final lastReadString = _prefs
          .getString('${AppConstants.readingProgressKey}_time_$storyId');

      final lastReadAt = lastReadString != null
          ? DateTime.parse(lastReadString)
          : DateTime.now();

      state = ReadingProgress(
        storyId: storyId,
        currentPage: currentPage,
        totalPages: totalPages,
        lastReadAt: lastReadAt,
      );
    } catch (e) {
      state = null;
    }
  }
}

/// Reader settings provider
final readerSettingsProvider =
    StateNotifierProvider<ReaderNotifier, ReaderSettings>((ref) {
  final prefs = SharedPreferencesService();
  return ReaderNotifier(prefs);
});

/// Reading progress provider
final readingProgressProvider = StateNotifierProvider.family<
    ReadingProgressNotifier,
    ReadingProgress?,
    String>((ref, storyId) {
  final prefs = SharedPreferencesService();
  return ReadingProgressNotifier(prefs);
});

/// Font size provider for convenience
final fontSizeProvider = Provider<double>((ref) {
  return ref.watch(readerSettingsProvider).fontSize;
});

/// Dark mode provider for convenience
final readerDarkModeProvider = Provider<bool>((ref) {
  return ref.watch(readerSettingsProvider).isDarkMode;
});
