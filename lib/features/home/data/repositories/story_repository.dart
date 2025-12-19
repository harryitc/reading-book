import '../../domain/models/story.dart';
import '../datasources/story_remote_datasource.dart';
import '../models/hot_story_response.dart';
import '../models/recently_updated_response.dart';
import '../models/completed_story_response.dart';
import '../../../../core/utils/logger.dart';

/// Story repository for business logic
class StoryRepository {
  final StoryRemoteDataSource remoteDataSource;

  StoryRepository({required this.remoteDataSource});

  /// Fetch hot stories from remote source
  Future<List<Story>> fetchHotStories() async {
    try {
      print('📦 [REPOSITORY] Fetching hot stories...');
      final responses = await remoteDataSource.getHotStories();
      print(
        '📦 [REPOSITORY] Received ${responses.length} responses from datasource',
      );

      final stories = responses.map(_mapToStory).toList();
      print('📦 [REPOSITORY] Mapped to ${stories.length} Story objects');
      print(
        '📦 [REPOSITORY] First story after mapping: ${stories.isNotEmpty ? stories[0].title : 'N/A'}',
      );

      AppLogger.debug('Successfully fetched ${stories.length} hot stories');
      return stories;
    } catch (e) {
      AppLogger.error('Error fetching hot stories in repository', e);
      print('❌ [REPOSITORY] Error: $e');
      rethrow;
    }
  }

  /// Fetch recently updated stories from remote source
  Future<List<Story>> fetchRecentlyUpdatedStories() async {
    try {
      print('📦 [REPOSITORY] Fetching recently updated stories...');
      final responses = await remoteDataSource.getRecentlyUpdatedStories();
      print(
        '📦 [REPOSITORY] Received ${responses.length} responses from datasource',
      );

      final stories = responses.map(_mapRecentlyUpdatedToStory).toList();
      print('📦 [REPOSITORY] Mapped to ${stories.length} Story objects');
      print(
        '📦 [REPOSITORY] First story: ${stories.isNotEmpty ? stories[0].title : 'N/A'}',
      );

      AppLogger.debug(
        'Successfully fetched ${stories.length} recently updated stories',
      );
      return stories;
    } catch (e) {
      AppLogger.error('Error fetching recently updated stories', e);
      print('❌ [REPOSITORY] Error: $e');
      rethrow;
    }
  }

  /// Fetch completed stories from remote source
  Future<List<Story>> fetchCompletedStories() async {
    try {
      print('📦 [REPOSITORY] Fetching completed stories...');
      final responses = await remoteDataSource.getCompletedStories();
      print(
        '📦 [REPOSITORY] Received ${responses.length} responses from datasource',
      );

      final stories = responses.map(_mapCompletedToStory).toList();
      print('📦 [REPOSITORY] Mapped to ${stories.length} Story objects');
      print(
        '📦 [REPOSITORY] First story: ${stories.isNotEmpty ? stories[0].title : 'N/A'}',
      );

      AppLogger.debug(
        'Successfully fetched ${stories.length} completed stories',
      );
      return stories;
    } catch (e) {
      AppLogger.error('Error fetching completed stories', e);
      print('❌ [REPOSITORY] Error: $e');
      rethrow;
    }
  }

  /// Map HotStoryResponse to Story domain model
  Story _mapToStory(HotStoryResponse response) {
    final now = DateTime.now();

    return Story(
      id: response.id,
      title: response.title,
      author: 'Unknown', // Default author since API doesn't provide it
      description: response.imageAlt, // Use imageAlt as description
      coverImageUrl: response.imageUrl,
      content: '', // Empty by default, loaded on demand
      genres: [], // Empty by default, can be populated from another API
      rating: 4.5, // Default rating, can be updated from another API
      totalChapters: 0, // Unknown from this endpoint
      latestChapter: 0, // Unknown from this endpoint
      publishedAt: now.subtract(const Duration(days: 30)), // Default date
      updatedAt: now, // Set to current time
      status: response.isFull ? StoryStatus.full : StoryStatus.ongoing,
    );
  }

  /// Map RecentlyUpdatedResponse to Story domain model
  Story _mapRecentlyUpdatedToStory(RecentlyUpdatedResponse response) {
    final now = DateTime.now();

    return Story(
      id: response.id,
      title: response.title,
      author: 'Unknown', // Default author since API doesn't provide it
      description: response.title, // Use title as description
      coverImageUrl: null, // No image URL in this API
      content: '', // Empty by default, loaded on demand
      genres: response.genres, // Use genres from API
      rating: 4.5, // Default rating
      totalChapters: 0, // Unknown from this endpoint
      latestChapter:
          int.tryParse(response.latestChapter.replaceAll('Chương ', '')) ?? 0,
      publishedAt: now.subtract(const Duration(days: 30)), // Default date
      updatedAt: now, // Set to current time
      status:
          StoryStatus.ongoing, // Recently updated stories are typically ongoing
    );
  }

  /// Map CompletedStoryResponse to Story domain model
  Story _mapCompletedToStory(CompletedStoryResponse response) {
    final now = DateTime.now();

    return Story(
      id: response.id,
      title: response.title,
      author: 'Unknown', // Default author since API doesn't provide it
      description: response.title, // Use title as description
      coverImageUrl: response.imageUrl,
      content: '', // Empty by default, loaded on demand
      genres: [], // No genres in this API
      rating: 4.5, // Default rating
      totalChapters: response.chapters,
      latestChapter: response.chapters, // Completed stories have all chapters
      publishedAt: now.subtract(const Duration(days: 30)), // Default date
      updatedAt: now, // Set to current time
      status: StoryStatus.full, // Completed stories are always FULL
    );
  }
}
