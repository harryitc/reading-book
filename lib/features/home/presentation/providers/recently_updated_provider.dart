import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:reading_book/core/utils/logger.dart';
import '../../domain/models/story.dart';
import '../../data/repositories/story_repository.dart';
import '../../data/datasources/story_remote_datasource.dart';

/// Remote data source provider for recently updated stories
final recentlyUpdatedDataSourceProvider = Provider<StoryRemoteDataSource>((ref) {
  return StoryRemoteDataSourceImpl(httpClient: http.Client());
});

/// Repository provider for recently updated stories
final recentlyUpdatedRepositoryProvider = Provider<StoryRepository>((ref) {
  final dataSource = ref.watch(recentlyUpdatedDataSourceProvider);
  return StoryRepository(remoteDataSource: dataSource);
});

/// Recently updated stories provider
final recentlyUpdatedProvider = FutureProvider<List<Story>>((ref) async {
  final repository = ref.watch(recentlyUpdatedRepositoryProvider);
  try {
    final stories = await repository.fetchRecentlyUpdatedStories();
    return stories;
  } catch (e) {
    AppLogger.log(
        '❌ [RECENTLY UPDATED PROVIDER] Failed to load recently updated stories: $e');
    // Return empty list on error - no fallback to mock
    return [];
  }
});
