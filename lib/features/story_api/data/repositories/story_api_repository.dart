import 'package:reading_book/features/home/domain/models/story.dart';
import '../datasources/story_api_datasource.dart';

/// Repository for story API operations
/// Bridges datasource (network) and domain logic
/// Converts API models to domain models
class StoryApiRepository {
  final StoryApiDatasource _datasource;

  const StoryApiRepository(this._datasource);

  /// Get all stories from API
  /// Returns List<Story> (domain model, not API response)
  /// Throws exception on error
  Future<List<Story>> getAllStories({
    int? limit,
    int? offset,
    String? searchQuery,
  }) async {
    try {
      // Fetch from API
      final apiResponses = await _datasource.fetchStories(
        limit: limit,
        offset: offset,
        searchQuery: searchQuery,
      );

      // Convert API responses to domain Story objects
      return apiResponses.map((apiStory) => _convertToStory(apiStory)).toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Convert ApiStoryResponse to domain Story model
  /// Maps API fields to domain model fields
  Story _convertToStory(dynamic apiStory) {
    final domainJson = apiStory.toDomainJson();

    return Story.fromJson(domainJson);
  }
}
