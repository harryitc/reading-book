/// Input validation utilities
class Validators {
  Validators._();

  /// Validate email format
  static bool isValidEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  /// Validate password strength (min 6 characters)
  static bool isValidPassword(String password) {
    return password.length >= 6;
  }

  /// Validate username (3-20 chars, alphanumeric and underscore)
  static bool isValidUsername(String username) {
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
    return usernameRegex.hasMatch(username);
  }

  /// Validate non-empty string
  static bool isNotEmpty(String value) {
    return value.trim().isNotEmpty;
  }

  /// Get error message for email
  static String getEmailError(String email) {
    if (email.isEmpty) return 'Email is required';
    if (!isValidEmail(email)) return 'Please enter a valid email';
    return '';
  }

  /// Get error message for password
  static String getPasswordError(String password) {
    if (password.isEmpty) return 'Password is required';
    if (!isValidPassword(password)) return 'Password must be at least 6 characters';
    return '';
  }

  /// Get error message for username
  static String getUsernameError(String username) {
    if (username.isEmpty) return 'Username is required';
    if (!isValidUsername(username)) {
      return 'Username must be 3-20 characters (letters, numbers, underscore)';
    }
    return '';
  }
}
