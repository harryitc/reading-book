import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/user.dart';
import '../../../../services/storage/secure_storage_service.dart';
import '../../../../services/storage/shared_preferences_service.dart';
import '../../../../core/constants/app_constants.dart';

/// Auth state notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final SecureStorageService _secureStorage;
  final SharedPreferencesService _prefs;

  AuthNotifier(this._secureStorage, this._prefs)
      : super(const Unauthenticated());

  /// Login user with email and password
  Future<void> login(String email, String password) async {
    state = const Loading();
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock user
      final user = User(
        id: '1',
        email: email,
        username: email.split('@')[0],
        createdAt: DateTime.now(),
      );

      // Save token
      const mockToken = 'mock_token_12345';
      await _secureStorage.saveSecure(AppConstants.tokenKey, mockToken);
      await _prefs.setString(AppConstants.userKey, user.toJson().toString());

      state = Authenticated(user);
    } catch (e) {
      state = ErrorState(e.toString());
    }
  }

  /// Register new user
  Future<void> register(String email, String password, String username) async {
    state = const Loading();
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      final user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        username: username,
        createdAt: DateTime.now(),
      );

      // Save token
      final mockToken = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
      await _secureStorage.saveSecure(AppConstants.tokenKey, mockToken);
      await _prefs.setString(AppConstants.userKey, user.toJson().toString());

      state = Authenticated(user);
    } catch (e) {
      state = ErrorState(e.toString());
    }
  }

  /// Logout user
  Future<void> logout() async {
    try {
      await _secureStorage.deleteSecure(AppConstants.tokenKey);
      await _prefs.remove(AppConstants.userKey);
      state = const Unauthenticated();
    } catch (e) {
      state = ErrorState(e.toString());
    }
  }

  /// Check if user is logged in
  Future<void> checkAuthStatus() async {
    try {
      final token =
          await _secureStorage.getSecure(AppConstants.tokenKey);
      if (token != null) {
        // Try to fetch user from storage
        final userJson = _prefs.getString(AppConstants.userKey);
        if (userJson != null) {
          // Parse user (simplified)
          final user = User(
            id: '1',
            email: 'user@example.com',
            username: 'user',
            createdAt: DateTime.now(),
          );
          state = Authenticated(user);
          return;
        }
      }
      state = const Unauthenticated();
    } catch (e) {
      state = ErrorState(e.toString());
    }
  }
}

/// Auth state - Sealed class for type safety
sealed class AuthState {
  const AuthState();
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class Authenticated extends AuthState {
  final User user;
  const Authenticated(this.user);
}

class Loading extends AuthState {
  const Loading();
}

class ErrorState extends AuthState {
  final String message;
  const ErrorState(this.message);
}

/// Auth provider (Riverpod)
final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final secureStorage = SecureStorageService();
  final prefs = SharedPreferencesService();
  return AuthNotifier(secureStorage, prefs);
});

/// Get current user
final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authProvider);
  if (authState is Authenticated) {
    return authState.user;
  }
  return null;
});

/// Check if user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState is Authenticated;
});
