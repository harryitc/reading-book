import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reading_book/features/explore/presentation/widgets/view_toggle_button.dart';
import 'package:reading_book/features/home/domain/models/story.dart';

/// Provider for view mode state (Grid / List)
final exploreViewModeProvider =
    StateProvider<ViewMode>((ref) => ViewMode.grid);

/// DEPRECATED: Use fetchStoriesProvider from story_api_provider instead
/// This provider is kept for reference only
/// The real API data is now fetched from story_api_provider.dart

/// Provider for all stories - NOW USES REAL API
/// See: lib/features/story_api/presentation/providers/story_api_provider.dart
/// The Explore screen now uses fetchStoriesProvider which gets data from /truyen/query
