import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:reading_book/core/utils/logger.dart';
import '../../domain/models/story.dart';
import '../../data/repositories/story_repository.dart';
import '../../data/datasources/story_remote_datasource.dart';

/// Remote data source provider for hot stories
final hotStoriesDataSourceProvider = Provider<StoryRemoteDataSource>((ref) {
  return StoryRemoteDataSourceImpl(httpClient: http.Client());
});

/// Repository provider for hot stories
final hotStoriesRepositoryProvider = Provider<StoryRepository>((ref) {
  final dataSource = ref.watch(hotStoriesDataSourceProvider);
  return StoryRepository(remoteDataSource: dataSource);
});

/// Hot stories provider - fetches from API only
final hotStoriesProvider = FutureProvider<List<Story>>((ref) async {
  final repository = ref.watch(hotStoriesRepositoryProvider);
  try {
    final stories = await repository.fetchHotStories();
    return stories;
  } catch (e) {
    AppLogger.log('❌ [HOT STORIES PROVIDER] Failed to load hot stories: $e');
    // Return empty list on error - no fallback to mock
    return [];
  }
});
