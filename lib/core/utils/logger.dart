import 'package:flutter/foundation.dart';

/// Simple logger utility for debugging
class AppLogger {
  AppLogger._();

  static void log(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('[Truyện Hay] $message');
      if (error != null) {
        print('[Truyện Hay Error] $error');
      }
      if (stackTrace != null) {
        print('[StackTrace] $stackTrace');
      }
    }
  }

  static void info(String message) {
    log('ℹ️ INFO: $message');
  }

  static void debug(String message) {
    log('🐛 DEBUG: $message');
  }

  static void warning(String message) {
    log('⚠️ WARNING: $message');
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    log('❌ ERROR: $message', error, stackTrace);
  }

  static void success(String message) {
    log('✅ SUCCESS: $message');
  }
}
