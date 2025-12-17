import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/logger.dart';

/// Service for managing shared preferences (app settings, cache)
class SharedPreferencesService {
  late final SharedPreferences _prefs;
  
  static final SharedPreferencesService _instance = SharedPreferencesService._internal();
  
  factory SharedPreferencesService() {
    return _instance;
  }
  
  SharedPreferencesService._internal();

  /// Initialize the service
  Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      AppLogger.info('SharedPreferences initialized');
    } catch (e) {
      AppLogger.error('Error initializing SharedPreferences', e);
      rethrow;
    }
  }

  /// Save a string value
  Future<bool> setString(String key, String value) async {
    try {
      return await _prefs.setString(key, value);
    } catch (e) {
      AppLogger.error('Error saving string value', e);
      rethrow;
    }
  }

  /// Retrieve a string value
  String? getString(String key) {
    try {
      return _prefs.getString(key);
    } catch (e) {
      AppLogger.error('Error retrieving string value', e);
      return null;
    }
  }

  /// Save a boolean value
  Future<bool> setBool(String key, bool value) async {
    try {
      return await _prefs.setBool(key, value);
    } catch (e) {
      AppLogger.error('Error saving boolean value', e);
      rethrow;
    }
  }

  /// Retrieve a boolean value
  bool? getBool(String key) {
    try {
      return _prefs.getBool(key);
    } catch (e) {
      AppLogger.error('Error retrieving boolean value', e);
      return null;
    }
  }

  /// Save a double value
  Future<bool> setDouble(String key, double value) async {
    try {
      return await _prefs.setDouble(key, value);
    } catch (e) {
      AppLogger.error('Error saving double value', e);
      rethrow;
    }
  }

  /// Retrieve a double value
  double? getDouble(String key) {
    try {
      return _prefs.getDouble(key);
    } catch (e) {
      AppLogger.error('Error retrieving double value', e);
      return null;
    }
  }

  /// Save an integer value
  Future<bool> setInt(String key, int value) async {
    try {
      return await _prefs.setInt(key, value);
    } catch (e) {
      AppLogger.error('Error saving integer value', e);
      rethrow;
    }
  }

  /// Retrieve an integer value
  int? getInt(String key) {
    try {
      return _prefs.getInt(key);
    } catch (e) {
      AppLogger.error('Error retrieving integer value', e);
      return null;
    }
  }

  /// Remove a value
  Future<bool> remove(String key) async {
    try {
      return await _prefs.remove(key);
    } catch (e) {
      AppLogger.error('Error removing value', e);
      rethrow;
    }
  }

  /// Clear all preferences
  Future<bool> clear() async {
    try {
      return await _prefs.clear();
    } catch (e) {
      AppLogger.error('Error clearing preferences', e);
      rethrow;
    }
  }

  /// Check if key exists
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }
}
