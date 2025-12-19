import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reading_book/services/api/http_client.dart';
import 'package:reading_book/features/home/domain/models/story.dart';
import '../../../story_api/data/datasources/story_api_datasource.dart';
import '../../../story_api/data/repositories/story_api_repository.dart';

/// HTTP Client Provider
final httpClientProvider = Provider<HttpClient>((ref) {
  final client = HttpClient();
  client.init();
  return client;
});

/// Story API Datasource Provider
final storyApiDatasourceProvider = Provider<StoryApiDatasource>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return StoryApiDatasource(httpClient);
});

/// Story API Repository Provider
final storyApiRepositoryProvider = Provider<StoryApiRepository>((ref) {
  final datasource = ref.watch(storyApiDatasourceProvider);
  return StoryApiRepository(datasource);
});

/// Async Provider for fetching all stories
/// Use this to get a FutureProvider<List<Story>>
final fetchStoriesProvider = FutureProvider<List<Story>>((ref) async {
  final repository = ref.watch(storyApiRepositoryProvider);

  try {
    return await repository.getAllStories();
  } catch (e) {
    // Log and rethrow for UI handling
    rethrow;
  }
});

/// Provider for cached stories (simple in-memory cache)
/// Useful if you want to preserve data across screen transitions
final cachedStoriesProvider =
    StateProvider<List<Story>>((ref) => []);

/// Refresh function for manually triggering story fetch
/// Usage: ref.refresh(fetchStoriesProvider)
