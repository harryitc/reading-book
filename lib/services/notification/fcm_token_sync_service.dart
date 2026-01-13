import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../notification/firebase_messaging_service.dart';

/// Service for syncing FCM token with backend
class FcmTokenSyncService {
  static const String baseUrl = 'YOUR_BACKEND_URL'; // TODO: Replace with your actual backend URL
  
  final FirebaseMessagingService _fcmService;
  
  FcmTokenSyncService(this._fcmService);

  /// Send FCM token to backend
  /// Call this after user login or when token refreshes
  Future<bool> syncTokenToBackend({
    required String userId,
    String? authToken,
  }) async {
    try {
      // Get current FCM token
      final fcmToken = await _fcmService.getToken();
      
      if (fcmToken == null) {
        if (kDebugMode) {
          print('⚠️ No FCM token available to sync');
        }
        return false;
      }

      // Determine platform
      final platform = Platform.isIOS ? 'ios' : 'android';

      // Send to backend API
      final response = await http.post(
        Uri.parse('$baseUrl/api/users/$userId/fcm-token'),
        headers: {
          'Content-Type': 'application/json',
          if (authToken != null) 'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode({
          'token': fcmToken,
          'platform': platform,
          'timestamp': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
          print('✅ FCM token synced to backend successfully');
        }
        return true;
      } else {
        if (kDebugMode) {
          print('❌ Failed to sync FCM token: ${response.statusCode}');
          print('Response: ${response.body}');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error syncing FCM token: $e');
      }
      return false;
    }
  }

  /// Delete FCM token from backend (on logout)
  Future<bool> deleteTokenFromBackend({
    required String userId,
    String? authToken,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/users/$userId/fcm-token'),
        headers: {
          'Content-Type': 'application/json',
          if (authToken != null) 'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        if (kDebugMode) {
          print('✅ FCM token deleted from backend');
        }
        
        // Also delete from Firebase
        await _fcmService.deleteToken();
        
        return true;
      } else {
        if (kDebugMode) {
          print('❌ Failed to delete FCM token: ${response.statusCode}');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error deleting FCM token: $e');
      }
      return false;
    }
  }

  /// Setup auto-sync on token refresh
  void setupAutoSync({
    required String userId,
    String? authToken,
  }) {
    // Listen to token refresh
    _fcmService.onTokenRefresh.listen((newToken) {
      if (kDebugMode) {
        print('🔄 Token refreshed, syncing to backend...');
      }
      syncTokenToBackend(userId: userId, authToken: authToken);
    });
  }
}
