import 'dart:convert';
import 'package:reading_book/services/api/http_client.dart';
import 'package:reading_book/core/utils/logger.dart';
import '../models/story_detail_response.dart';

/// API data source for story detail queries
/// Handles network communication with /truyen/get-one endpoint
class StoryDetailApiDatasource {
  final HttpClient _httpClient;

  const StoryDetailApiDatasource(this._httpClient);

  /// Fetch story detail by ID
  /// Calls GET /truyen/get-one?id={storyId}
  /// Returns StoryDetailResponse object
  /// Throws exception on error
  Future<StoryDetailResponse> fetchStoryDetail(String storyId) async {
    try {
      if (storyId.isEmpty) {
        throw Exception('Story ID cannot be empty');
      }

      AppLogger.info('Fetching story detail for ID: $storyId');

      // Make GET request to /truyen/get-one with query parameter
      final response = await _httpClient.get(
        'https://redbird-generous-alpaca.ngrok-free.app/webhook/truyen/get-one',
        queryParameters: {'id': storyId},
      );

      // Check status code
      if (response.statusCode == 200) {
        AppLogger.success('Story detail fetched successfully for: $storyId');

        // Parse JSON response
        final jsonData = _parseJsonResponse(response.body)[0];

        // Validate response
        if (jsonData is! Map<String, dynamic>) {
          throw Exception('Invalid API response format');
        }

        // Convert to StoryDetailResponse
        final storyDetail = StoryDetailResponse.fromJson(jsonData);

        // Validate required fields
        if (storyDetail.id.isEmpty || storyDetail.title.isEmpty) {
          throw Exception('Story detail missing required fields');
        }

        return storyDetail;
      } else if (response.statusCode == 404) {
        throw Exception('Story not found');
      } else {
        throw Exception(
            'Failed to fetch story detail: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      AppLogger.error('Error fetching story detail for ID: $storyId', e as Exception);
      rethrow;
    }
  }

  /// Parse JSON response body
  dynamic _parseJsonResponse(String body) {
    try {
      if (body.isEmpty) {
        return {};
      }

      // Decode JSON string to dynamic object
      final jsonData = jsonDecode(body);
      return jsonData;
    } catch (e) {
      AppLogger.warning('Failed to parse JSON response: $e');
      return {};
    }
  }
}
