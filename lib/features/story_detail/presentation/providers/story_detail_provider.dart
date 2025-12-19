import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reading_book/features/story_detail/data/datasources/story_detail_api_datasource.dart';
import 'package:reading_book/features/story_detail/data/repositories/story_detail_repository.dart';
import 'package:reading_book/features/story_detail/data/models/story_detail_response.dart';
import 'package:reading_book/features/story_api/presentation/providers/story_api_provider.dart';

/// Story Detail API Datasource Provider
final storyDetailApiDatasourceProvider =
    Provider<StoryDetailApiDatasource>((ref) {
  final httpClient = ref.watch(httpClientProvider);
  return StoryDetailApiDatasource(httpClient);
});

/// Story Detail Repository Provider
final storyDetailRepositoryProvider = Provider<StoryDetailRepository>((ref) {
  final datasource = ref.watch(storyDetailApiDatasourceProvider);
  return StoryDetailRepository(datasource);
});

/// Family provider for fetching story detail by ID
/// Usage: ref.watch(fetchStoryDetailProvider(storyId))
/// Returns: AsyncValue<StoryDetailResponse>
/// States: loading, data(StoryDetailResponse), error
final fetchStoryDetailProvider =
    FutureProvider.family<StoryDetailResponse, String>((ref, storyId) async {
  final repository = ref.watch(storyDetailRepositoryProvider);

  try {
    return await repository.getStoryDetail(storyId);
  } catch (e) {
    rethrow;
  }
});

/// In-memory cache for story details
/// Key: storyId, Value: StoryDetailResponse
final storyDetailCacheProvider =
    StateProvider<Map<String, StoryDetailResponse>>((ref) => {});

/// Get cached or fetch story detail
/// Automatically caches result for future requests
final cachedStoryDetailProvider =
    FutureProvider.family<StoryDetailResponse, String>(
  (ref, storyId) async {
    // Check cache first
    final cache = ref.watch(storyDetailCacheProvider);
    if (cache.containsKey(storyId)) {
      return cache[storyId]!;
    }

    // Fetch from API
    final repository = ref.watch(storyDetailRepositoryProvider);
    final detail = await repository.getStoryDetail(storyId);

    // Update cache
    ref.read(storyDetailCacheProvider.notifier).update((cache) {
      return {...cache, storyId: detail};
    });

    return detail;
  },
);
