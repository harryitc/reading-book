import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/utils/logger.dart';

/// Service for managing secure storage (auth tokens, sensitive data)
class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  /// Save a value securely
  Future<void> saveSecure(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
      AppLogger.debug('Saved secure value for key: $key');
    } catch (e) {
      AppLogger.error('Error saving secure value', e);
      rethrow;
    }
  }

  /// Retrieve a secure value
  Future<String?> getSecure(String key) async {
    try {
      final value = await _storage.read(key: key);
      AppLogger.debug('Retrieved secure value for key: $key');
      return value;
    } catch (e) {
      AppLogger.error('Error retrieving secure value', e);
      rethrow;
    }
  }

  /// Delete a secure value
  Future<void> deleteSecure(String key) async {
    try {
      await _storage.delete(key: key);
      AppLogger.debug('Deleted secure value for key: $key');
    } catch (e) {
      AppLogger.error('Error deleting secure value', e);
      rethrow;
    }
  }

  /// Clear all secure storage
  Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
      AppLogger.info('Cleared all secure storage');
    } catch (e) {
      AppLogger.error('Error clearing secure storage', e);
      rethrow;
    }
  }

  /// Check if key exists
  Future<bool> containsKey(String key) async {
    try {
      final value = await _storage.read(key: key);
      return value != null;
    } catch (e) {
      AppLogger.error('Error checking key existence', e);
      return false;
    }
  }
}
