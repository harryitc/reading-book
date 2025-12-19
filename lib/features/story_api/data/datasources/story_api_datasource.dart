import 'dart:convert';
import 'package:reading_book/services/api/http_client.dart';
import 'package:reading_book/core/utils/logger.dart';
import '../models/api_story_response.dart';

/// API data source for story queries
/// Handles all network communication with /truyen/query endpoint
class StoryApiDatasource {
  final HttpClient _httpClient;

  const StoryApiDatasource(this._httpClient);

  /// Fetch all stories from /truyen/query endpoint
  /// Returns a list of ApiStoryResponse objects
  /// Throws exception on network error or invalid response
  Future<List<ApiStoryResponse>> fetchStories({
    int? limit,
    int? offset,
    String? searchQuery,
  }) async {
    try {
      AppLogger.info('Fetching stories from /truyen/query');

      final queryParameters = <String, dynamic>{};

      if (limit != null) {
        queryParameters['limit'] = limit;
      }

      if (offset != null) {
        queryParameters['offset'] = offset;
      }

      if (searchQuery != null && searchQuery.isNotEmpty) {
        queryParameters['search'] = searchQuery;
      }

      // Make GET request to /truyen/query
      final response = await _httpClient.get(
      'https://redbird-generous-alpaca.ngrok-free.app/webhook/truyen/query',
        queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      );

      // Check status code
      if (response.statusCode == 200) {
        AppLogger.info('Stories fetched successfully');

        // Parse response body
        final jsonData = _parseJsonResponse(response.body);

        // Handle different response formats
        final List<dynamic> storiesList = _extractStoriesList(jsonData);

        // Convert to ApiStoryResponse objects
        return storiesList
            .map((item) {
              try {
                return ApiStoryResponse.fromJson(
                    item as Map<String, dynamic>);
              } catch (e) {
                AppLogger.warning('Failed to parse story item: $item');
                return null;
              }
            })
            .whereType<ApiStoryResponse>()
            .toList();
      } else {
        throw Exception(
            'Failed to fetch stories: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      AppLogger.error('Error fetching stories', e);
      rethrow;
    }
  }

  /// Parse JSON response body
  dynamic _parseJsonResponse(String body) {
    try {
      if (body.isEmpty) {
        return {};
      }

      // Parse JSON string to dynamic object
      final jsonData = jsonDecode(body);
      return jsonData;
    } catch (e) {
      AppLogger.warning('Failed to parse JSON response: $e');
      return {};
    }
  }

  /// Extract stories list from response
  /// Handles different API response formats:
  /// 1. Direct array: [...]
  /// 2. Wrapped in object: {data: [...], ...}
  /// 3. Other variations
  List<dynamic> _extractStoriesList(dynamic jsonData) {
    if (jsonData is List) {
      return jsonData;
    }

    if (jsonData is Map<String, dynamic>) {
      // Try common response wrappers
      if (jsonData.containsKey('data') && jsonData['data'] is List) {
        return jsonData['data'] as List;
      }

      if (jsonData.containsKey('stories') && jsonData['stories'] is List) {
        return jsonData['stories'] as List;
      }

      if (jsonData.containsKey('items') && jsonData['items'] is List) {
        return jsonData['items'] as List;
      }

      if (jsonData.containsKey('results') && jsonData['results'] is List) {
        return jsonData['results'] as List;
      }
    }

    return [];
  }
}
