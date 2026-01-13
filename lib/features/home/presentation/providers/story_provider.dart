import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:reading_book/core/utils/logger.dart';
import '../../domain/models/story.dart';
import '../../data/repositories/story_repository.dart';
import '../../data/datasources/story_remote_datasource.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../reader/data/mock_story_content.dart';

/// Story state notifier
class StoryNotifier extends StateNotifier<List<Story>> {
  StoryNotifier() : super([]);

  /// Load stories (mock implementation)
  Future<void> loadStories() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock stories
      final stories = _getMockStories();
      state = stories;
    } catch (e) {
      state = [];
    }
  }

  /// Get hot/featured stories
  List<Story> getHotStories() {
    return state.take(5).toList();
  }

  /// Get recently updated stories
  List<Story> getRecentlyUpdatedStories() {
    return state.skip(5).take(5).toList();
  }

  /// Get completed stories
  List<Story> getCompletedStories() {
    return state.where((story) => story.status == StoryStatus.full).toList();
  }

  /// Mock data generator
  static List<Story> _getMockStories() {
    final now = DateTime.now();
    return [
      // Hot Stories (Featured)
      Story(
        id: '1',
        title: 'The Lost Kingdom',
        author: 'John Doe',
        description: 'A thrilling adventure through ancient lands.',
        coverImageUrl: 'https://picsum.photos/300/400?random=1',
        genres: ['Adventure', 'Fantasy'],
        rating: 4.8,
        totalChapters: 45,
        latestChapter: 45,
        publishedAt: now.subtract(const Duration(days: 90)),
        updatedAt: now.subtract(const Duration(hours: 2)),
        content: MockData.sampleStoryContent,
        status: StoryStatus.full,
      ),
      Story(
        id: '2',
        title: 'Whispers in the Dark',
        author: 'Jane Smith',
        description: 'A mysterious tale of secrets and revelations.',
        coverImageUrl: 'https://picsum.photos/300/400?random=2',
        genres: ['Mystery', 'Thriller'],
        rating: 4.6,
        totalChapters: 52,
        latestChapter: 48,
        publishedAt: now.subtract(const Duration(days: 60)),
        updatedAt: now.subtract(const Duration(hours: 3)),
        content: MockData.sampleStoryContent,
        status: StoryStatus.ongoing,
      ),
      Story(
        id: '3',
        title: 'Love in the City',
        author: 'Emma Wilson',
        description: 'A romantic story set in a bustling metropolis.',
        coverImageUrl: 'https://picsum.photos/300/400?random=3',
        genres: ['Romance', 'Contemporary'],
        rating: 4.5,
        totalChapters: 38,
        latestChapter: 38,
        publishedAt: now.subtract(const Duration(days: 45)),
        updatedAt: now.subtract(const Duration(hours: 1)),
        content: MockData.sampleStoryContent,
        status: StoryStatus.full,
      ),
      Story(
        id: '4',
        title: 'The Time Traveler',
        author: 'Michael Brown',
        description: 'Journey through time and space in this epic saga.',
        coverImageUrl: 'https://picsum.photos/300/400?random=4',
        genres: ['Sci-Fi', 'Adventure'],
        rating: 4.7,
        totalChapters: 67,
        latestChapter: 52,
        publishedAt: now.subtract(const Duration(days: 75)),
        updatedAt: now.subtract(const Duration(minutes: 45)),
        content: MockData.sampleStoryContent,
        status: StoryStatus.ongoing,
      ),
      Story(
        id: '5',
        title: 'Dragon\'s Legacy',
        author: 'Sarah Knights',
        description: 'An epic fantasy with dragons, magic, and destiny.',
        coverImageUrl: 'https://picsum.photos/300/400?random=5',
        genres: ['Fantasy', 'Adventure'],
        rating: 4.9,
        totalChapters: 80,
        latestChapter: 80,
        publishedAt: now.subtract(const Duration(days: 120)),
        updatedAt: now.subtract(const Duration(days: 5)),
        content: MockData.sampleStoryContent,
        status: StoryStatus.full,
      ),

      // Recently Updated Stories
      Story(
        id: '6',
        title: 'Midnight Chronicles',
        author: 'Alex Turner',
        description: 'Dark secrets unfold in this gripping thriller.',
        coverImageUrl: 'https://picsum.photos/300/400?random=6',
        genres: ['Thriller', 'Mystery'],
        rating: 4.4,
        totalChapters: 56,
        latestChapter: 42,
        publishedAt: now.subtract(const Duration(days: 50)),
        updatedAt: now.subtract(const Duration(minutes: 30)),
        content: MockData.sampleStoryContent,
        status: StoryStatus.ongoing,
      ),
      Story(
        id: '7',
        title: 'Eternal Flames',
        author: 'Lisa Chen',
        description: 'A tale of forbidden love and ancient magic.',
        coverImageUrl: 'https://picsum.photos/300/400?random=7',
        genres: ['Romance', 'Fantasy'],
        rating: 4.3,
        totalChapters: 44,
        latestChapter: 44,
        publishedAt: now.subtract(const Duration(days: 55)),
        updatedAt: now.subtract(const Duration(minutes: 15)),
        content: MockData.sampleStoryContent,
        status: StoryStatus.full,
      ),
      Story(
        id: '8',
        title: 'Silicon Dreams',
        author: 'Robert Park',
        description: 'A cyberpunk adventure in a digital world.',
        coverImageUrl: 'https://picsum.photos/300/400?random=8',
        genres: ['Sci-Fi', 'Cyberpunk'],
        rating: 4.2,
        totalChapters: 63,
        latestChapter: 38,
        publishedAt: now.subtract(const Duration(days: 70)),
        updatedAt: now.subtract(const Duration(minutes: 10)),
        content: MockData.sampleStoryContent,
        status: StoryStatus.ongoing,
      ),
      Story(
        id: '9',
        title: 'Echoes of Yesterday',
        author: 'Maria Santos',
        description: 'Family secrets resurface in this emotional drama.',
        coverImageUrl: 'https://picsum.photos/300/400?random=9',
        genres: ['Drama', 'Contemporary'],
        rating: 4.1,
        totalChapters: 35,
        latestChapter: 35,
        publishedAt: now.subtract(const Duration(days: 40)),
        updatedAt: now.subtract(const Duration(minutes: 5)),
        content: MockData.sampleStoryContent,
        status: StoryStatus.full,
      ),
      Story(
        id: '10',
        title: 'The Forgotten Isle',
        author: 'James Mitchell',
        description: 'An adventure on a mysterious island filled with secrets.',
        coverImageUrl: 'https://picsum.photos/300/400?random=10',
        genres: ['Adventure', 'Mystery'],
        rating: 4.5,
        totalChapters: 58,
        latestChapter: 49,
        publishedAt: now.subtract(const Duration(days: 65)),
        updatedAt: now.subtract(const Duration(hours: 1)),
        content: MockData.sampleStoryContent,
        status: StoryStatus.ongoing,
      ),

      // Completed Stories
      Story(
        id: '11',
        title: 'The Phoenix Rising',
        author: 'Victoria Rose',
        description: 'A tale of resurrection and redemption.',
        coverImageUrl: 'https://picsum.photos/300/400?random=11',
        genres: ['Fantasy', 'Adventure'],
        rating: 4.7,
        totalChapters: 42,
        latestChapter: 42,
        publishedAt: now.subtract(const Duration(days: 200)),
        updatedAt: now.subtract(const Duration(days: 30)),
        content: MockData.sampleStoryContent,
        status: StoryStatus.full,
      ),
      Story(
        id: '12',
        title: 'Ocean\'s Whisper',
        author: 'David Collins',
        description: 'A journey across the seas seeking truth.',
        coverImageUrl: 'https://picsum.photos/300/400?random=12',
        genres: ['Adventure', 'Contemporary'],
        rating: 4.4,
        totalChapters: 39,
        latestChapter: 39,
        publishedAt: now.subtract(const Duration(days: 180)),
        updatedAt: now.subtract(const Duration(days: 25)),
        content: MockData.sampleStoryContent,
        status: StoryStatus.full,
      ),
      Story(
        id: '13',
        title: 'Starlight Promise',
        author: 'Isabella Moon',
        description: 'A romance written in the stars.',
        coverImageUrl: 'https://picsum.photos/300/400?random=13',
        genres: ['Romance', 'Fantasy'],
        rating: 4.6,
        totalChapters: 36,
        latestChapter: 36,
        publishedAt: now.subtract(const Duration(days: 150)),
        updatedAt: now.subtract(const Duration(days: 20)),
        content: MockData.sampleStoryContent,
        status: StoryStatus.full,
      ),
      Story(
        id: '14',
        title: 'The Last Detective',
        author: 'Thomas Grant',
        description: 'A final case before retirement changes everything.',
        coverImageUrl: 'https://picsum.photos/300/400?random=14',
        genres: ['Mystery', 'Thriller'],
        rating: 4.5,
        totalChapters: 48,
        latestChapter: 48,
        publishedAt: now.subtract(const Duration(days: 210)),
        updatedAt: now.subtract(const Duration(days: 35)),
        content: MockData.sampleStoryContent,
        status: StoryStatus.full,
      ),
      Story(
        id: '15',
        title: 'Quantum Leap',
        author: 'Dr. Nina Patel',
        description: 'Science fiction exploring alternate realities.',
        coverImageUrl: 'https://picsum.photos/300/400?random=15',
        genres: ['Sci-Fi', 'Adventure'],
        rating: 4.8,
        totalChapters: 55,
        latestChapter: 55,
        publishedAt: now.subtract(const Duration(days: 190)),
        updatedAt: now.subtract(const Duration(days: 28)),
        content: MockData.sampleStoryContent,
        status: StoryStatus.full,
      ),
      Story(
        id: '16',
        title: 'Winter\'s Song',
        author: 'Grace Aurora',
        description: 'A poetic tale of love and loss during the coldest season.',
        coverImageUrl: 'https://picsum.photos/300/400?random=16',
        genres: ['Romance', 'Drama'],
        rating: 4.3,
        totalChapters: 31,
        latestChapter: 31,
        publishedAt: now.subtract(const Duration(days: 160)),
        updatedAt: now.subtract(const Duration(days: 22)),
        content: MockData.sampleStoryContent,
        status: StoryStatus.full,
      ),
      Story(
        id: '17',
        title: 'The Silent Guardian',
        author: 'Marcus Stone',
        description: 'An action-packed story of protection and sacrifice.',
        coverImageUrl: 'https://picsum.photos/300/400?random=17',
        genres: ['Action', 'Adventure'],
        rating: 4.6,
        totalChapters: 47,
        latestChapter: 47,
        publishedAt: now.subtract(const Duration(days: 195)),
        updatedAt: now.subtract(const Duration(days: 32)),
        content: MockData.sampleStoryContent,
        status: StoryStatus.full,
      ),
      Story(
        id: '18',
        title: 'Moonlit Secrets',
        author: 'Emily Blackwood',
        description: 'Gothic mysteries unfold in a haunted manor.',
        coverImageUrl: 'https://picsum.photos/300/400?random=18',
        genres: ['Mystery', 'Gothic'],
        rating: 4.4,
        totalChapters: 41,
        latestChapter: 41,
        publishedAt: now.subtract(const Duration(days: 170)),
        updatedAt: now.subtract(const Duration(days: 27)),
        content: MockData.sampleStoryContent,
        status: StoryStatus.full,
      ),
    ];
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

/// Remote data source provider
final storyRemoteDataSourceProvider =
    Provider<StoryRemoteDataSource>((ref) {
  return StoryRemoteDataSourceImpl(httpClient: http.Client());
});

/// Story repository provider
final storyRepositoryProvider = Provider<StoryRepository>((ref) {
  final dataSource = ref.watch(storyRemoteDataSourceProvider);
  return StoryRepository(remoteDataSource: dataSource);
});

/// Load hot stories from API
final allStoriesProvider = FutureProvider<List<Story>>((ref) async {
  final repository = ref.watch(storyRepositoryProvider);
  try {
    final stories = await repository.fetchHotStories();
    return stories;
  } catch (e) {
    AppLogger.log('❌ [API] Failed to load from API: $e');
    AppLogger.log('⚠️ [FALLBACK] Falling back to mock data...');
    // Fallback to mock data if API fails
    final notifier = ref.read(storyListProvider.notifier);
    await notifier.loadStories();
    final mockStories = ref.watch(storyListProvider);
    AppLogger.log('✅ [MOCK] Loaded ${mockStories.length} mock stories as fallback');
    return mockStories;
  }
});

/// Featured stories provider
final featuredStoriesProvider = FutureProvider<List<Story>>((ref) async {
  final stories = await ref.watch(allStoriesProvider.future);
  return stories;
});

/// Hot stories provider
final hotStoriesProvider = FutureProvider<List<Story>>((ref) async {
  final stories = await ref.watch(allStoriesProvider.future);
  return stories.take(5).toList();
});

/// Recently updated stories provider
final recentlyUpdatedProvider = FutureProvider<List<Story>>((ref) async {
  final stories = await ref.watch(allStoriesProvider.future);
  return stories.skip(5).take(5).toList();
});

/// Completed stories provider
final completedStoriesProvider = FutureProvider<List<Story>>((ref) async {
  final stories = await ref.watch(allStoriesProvider.future);
  return stories.where((story) => story.status == StoryStatus.full).toList();
});

/// Single story provider
final storyProvider = FutureProvider.family<Story?, String>((ref, storyId) async {
  // Load all stories first
  final stories = await ref.watch(allStoriesProvider.future);
  
  // Find the story by ID
  final story = stories.firstWhere(
    (s) => s.id == storyId,
    orElse: () => Story(
      id: storyId,
      title: 'Mock Story',
      author: 'Mock Author',
      description: 'This is a mock story for testing.',
      content: MockStoryContent.getContentById(storyId),
      genres: ['Adventure', 'Fantasy'],
      rating: 4.5,
      totalChapters: 10,
      latestChapter: 10,
      publishedAt: DateTime.now(),
      status: StoryStatus.full,
    ),
  );
  
  // Override content with detailed mock data
  return story.copyWith(
    content: MockStoryContent.getContentById(storyId),
  );
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
