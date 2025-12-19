import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:reading_book/core/utils/logger.dart';
import '../../domain/models/story.dart';
import '../../data/repositories/story_repository.dart';
import '../../data/datasources/story_remote_datasource.dart';

/// Remote data source provider for completed stories
final completedStoriesDataSourceProvider = Provider<StoryRemoteDataSource>((ref) {
  return StoryRemoteDataSourceImpl(httpClient: http.Client());
});

/// Repository provider for completed stories
final completedStoriesRepositoryProvider = Provider<StoryRepository>((ref) {
  final dataSource = ref.watch(completedStoriesDataSourceProvider);
  return StoryRepository(remoteDataSource: dataSource);
});

/// Completed stories provider
final completedStoriesProvider = FutureProvider<List<Story>>((ref) async {
  final repository = ref.watch(completedStoriesRepositoryProvider);
  try {
    AppLogger.log('📦 [COMPLETED STORIES PROVIDER] Fetching completed stories...');
    final stories = await repository.fetchCompletedStories();
    AppLogger.log(
        '✅ [COMPLETED STORIES PROVIDER] Successfully loaded ${stories.length} stories');
    AppLogger.log(
        '✅ [COMPLETED STORIES PROVIDER] First story: ${stories.isNotEmpty ? stories[0].title : 'N/A'}');
    return stories;
  } catch (e) {
    AppLogger.log(
        '❌ [COMPLETED STORIES PROVIDER] Failed to load completed stories: $e');
    // Return empty list on error - no fallback to mock
    return [];
  }
});
