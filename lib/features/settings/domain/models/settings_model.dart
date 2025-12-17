/// Settings domain model
class AppSettingsModel {
  final bool notificationsEnabled;
  final bool autoSaveProgress;
  final String language;

  const AppSettingsModel({
    this.notificationsEnabled = true,
    this.autoSaveProgress = true,
    this.language = 'en',
  });
}
