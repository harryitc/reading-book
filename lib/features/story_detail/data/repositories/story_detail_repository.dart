import '../models/story_detail_response.dart';
import '../datasources/story_detail_api_datasource.dart';

/// Repository for story detail API operations
/// Bridges datasource (network) and domain logic
/// Converts API models to domain models
class StoryDetailRepository {
  final StoryDetailApiDatasource _datasource;

  const StoryDetailRepository(this._datasource);

  /// Get story detail by ID
  /// Returns StoryDetailResponse from API
  /// Throws exception on error (network, not found, etc)
  Future<StoryDetailResponse> getStoryDetail(String storyId) async {
    try {
      // Fetch from API
      final storyDetail = await _datasource.fetchStoryDetail(storyId);
      return storyDetail;
    } catch (e) {
      rethrow;
    }
  }
}
