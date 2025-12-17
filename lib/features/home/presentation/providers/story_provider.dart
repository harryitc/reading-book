import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/story.dart';
import '../../../../core/constants/app_constants.dart';

/// Story state notifier
class StoryNotifier extends StateNotifier<List<Story>> {
  StoryNotifier() : super([]);

  /// Load stories (mock implementation)
  Future<void> loadStories() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock stories
      final stories = [
        Story(
          id: '1',
          title: 'The Lost Kingdom',
          author: 'John Doe',
          description: 'A thrilling adventure through ancient lands.',
          genres: ['Adventure', 'Fantasy'],
          rating: 4.5,
          totalChapters: 12,
          publishedAt: DateTime.now().subtract(const Duration(days: 30)),
          content: MockData.sampleStoryContent,
        ),
        Story(
          id: '2',
          title: 'Whispers in the Dark',
          author: 'Jane Smith',
          description: 'A mysterious tale of secrets and revelations.',
          genres: ['Mystery', 'Thriller'],
          rating: 4.2,
          totalChapters: 15,
          publishedAt: DateTime.now().subtract(const Duration(days: 20)),
          content: MockData.sampleStoryContent,
        ),
        Story(
          id: '3',
          title: 'Love in the City',
          author: 'Emma Wilson',
          description: 'A romantic story set in a bustling metropolis.',
          genres: ['Romance', 'Contemporary'],
          rating: 4.0,
          totalChapters: 10,
          publishedAt: DateTime.now().subtract(const Duration(days: 10)),
          content: MockData.sampleStoryContent,
        ),
        Story(
          id: '4',
          title: 'The Time Traveler',
          author: 'Michael Brown',
          description: 'Journey through time and space.',
          genres: ['Sci-Fi', 'Adventure'],
          rating: 4.7,
          totalChapters: 20,
          publishedAt: DateTime.now().subtract(const Duration(days: 5)),
          content: MockData.sampleStoryContent,
        ),
      ];

      state = stories;
    } catch (e) {
      state = [];
    }
  }

  /// Get story by ID
  Story? getStoryById(String id) {
    try {
      return state.firstWhere((story) => story.id == id);
    } catch (_) {
      return null;
    }
  }
}

/// Story list provider
final storyListProvider = StateNotifierProvider<StoryNotifier, List<Story>>((ref) {
  return StoryNotifier();
});

/// Featured stories provider
final featuredStoriesProvider = FutureProvider<List<Story>>((ref) async {
  final notifier = ref.read(storyListProvider.notifier);
  await notifier.loadStories();
  return ref.watch(storyListProvider);
});

/// Single story provider
final storyProvider = FutureProvider.family<Story?, String>((ref, storyId) async {
  final notifier = ref.read(storyListProvider.notifier);
  await notifier.loadStories();
  return notifier.getStoryById(storyId);
});

/// Search stories provider
final searchStoriesProvider =
    StateNotifierProvider<SearchStoryNotifier, List<Story>>((ref) {
  return SearchStoryNotifier(ref);
});

class SearchStoryNotifier extends StateNotifier<List<Story>> {
  final Ref ref;

  SearchStoryNotifier(this.ref) : super([]);

  Future<void> search(String query) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final allStories = ref.read(storyListProvider);
      final filtered = allStories
          .where((story) =>
              story.title.toLowerCase().contains(query.toLowerCase()) ||
              story.author.toLowerCase().contains(query.toLowerCase()))
          .toList();

      state = filtered;
    } catch (e) {
      state = [];
    }
  }
}
