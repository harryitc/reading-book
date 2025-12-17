/// Application-wide constants
class AppConstants {
  AppConstants._();

  // App Information
  static const String appName = 'StoryNest';
  static const String appVersion = '1.0.0';

  // API Configuration
  static const String baseApiUrl = 'https://api.storynest.local';
  static const Duration apiTimeout = Duration(seconds: 30);

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'theme_mode';
  static const String fontSizeKey = 'font_size';
  static const String readingProgressKey = 'reading_progress';

  // Reading Settings
  static const double minFontSize = 12.0;
  static const double maxFontSize = 28.0;
  static const double defaultFontSize = 16.0;

  // Pagination
  static const int itemsPerPage = 20;
  static const int timeoutDuration = 30;

  // Routes (prefix for go_router)
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';
  static const String libraryRoute = '/library';
  static const String readerRoute = '/reader';
  static const String aiRoute = '/ai';
  static const String settingsRoute = '/settings';
  static const String profileRoute = '/profile';
}

/// Default text content for mock data
class MockData {
  MockData._();

  static const String sampleStoryTitle = 'The Lost Kingdom';
  static const String sampleStoryAuthor = 'John Doe';
  static const String sampleStoryDescription =
      'A thrilling adventure through ancient lands and mysterious civilizations.';
  static const String sampleStoryContent =
      '''Chapter 1: The Beginning

In the beginning, there was a vast kingdom that stretched across mountains and valleys. The people lived in harmony, and the land was rich with beauty and prosperity.

One day, a shadow fell upon the kingdom. No one knew where it came from or what it meant. But as weeks turned into months, the shadow grew darker and more ominous.

The king called upon his wisest advisors. "We must find the source of this darkness," he declared. "Send our bravest knights to explore the farthest reaches of our land."

Thus began a great quest that would change the fate of the kingdom forever...

Chapter 2: The Journey Begins

The knights gathered their provisions and set out at dawn. They traveled through dense forests where sunlight barely pierced the canopy. They crossed roaring rivers and climbed treacherous mountains.

Each day brought new challenges and discoveries. They met strange peoples and heard tales of forgotten lands. Some turned back, unable to face the unknown. But the bravest pressed on.

Days became weeks, and weeks became months. The journey seemed endless, but the knights refused to give up. They knew that somewhere, beyond the horizon, lay the answer they sought.

As they traveled further, they began to notice strange occurrences. The air grew colder, and an eerie silence fell upon the land. It was then that they knew they were getting close to the source of the darkness.

One night, as they camped under the stars, the leader of the knights stood watch. He looked out into the darkness and saw something that made his heart race. In the distance, a strange red glow illuminated the sky.

"It's there," he whispered to himself. "The source of the darkness. Tomorrow, we ride toward the light."

The next morning, they set off toward the glow. Their determination renewed, they rode faster than ever before. They knew that whatever lay ahead would test them in ways they could never imagine.

But they were ready. They were knights of the kingdom, sworn to protect their people. And no matter what horrors awaited them, they would not falter.''';
}
