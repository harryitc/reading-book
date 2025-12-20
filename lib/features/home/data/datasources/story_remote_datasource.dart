import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/hot_story_response.dart';
import '../models/recently_updated_response.dart';
import '../models/completed_story_response.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/constants/app_constants.dart';

/// Remote data source for story API calls
abstract class StoryRemoteDataSource {
  /// Fetch hot stories from API
  Future<List<HotStoryResponse>> getHotStories();

  /// Fetch recently updated stories from API
  Future<List<RecentlyUpdatedResponse>> getRecentlyUpdatedStories();

  /// Fetch completed stories from API
  Future<List<CompletedStoryResponse>> getCompletedStories();
}

/// Implementation of StoryRemoteDataSource
class StoryRemoteDataSourceImpl implements StoryRemoteDataSource {
  final http.Client httpClient;

  StoryRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<List<HotStoryResponse>> getHotStories() async {
    try {
      final url = '${AppConstants.baseApiUrl}${AppConstants.hotStoriesEndpoint}';
      AppLogger.debug('Calling API: $url');

      final uri = Uri.parse(url);
      // print('🌐 [DATASOURCE] Full URI: $uri');

      final response = await httpClient
          .get(uri)
          .timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw Exception(
          'API Error: ${response.statusCode} - ${response.reasonPhrase}',
        );
      }


      final jsonData = jsonDecode(response.body);
      final List<dynamic> jsonList = jsonData is List ? jsonData : [];

      final stories = jsonList
          .map((json) => HotStoryResponse.fromJson(json as Map<String, dynamic>))
          .toList();

      AppLogger.debug('Successfully fetched ${stories.length} hot stories from API');
      // print('✅ [DATASOURCE] Successfully created ${stories.length} HotStoryResponse objects');
      return stories;
    } catch (e) {
      AppLogger.error('Failed to fetch hot stories', e);
      rethrow;
    }
  }

  @override
  Future<List<RecentlyUpdatedResponse>> getRecentlyUpdatedStories() async {
    try {
      final url = '${AppConstants.baseApiUrl}${AppConstants.recentlyUpdatedEndpoint}';
      AppLogger.debug('Calling API: $url');

      final uri = Uri.parse(url);
      // print('🌐 [DATASOURCE] Full URI: $uri');

      final response = await httpClient
          .get(uri)
          .timeout(const Duration(seconds: 15));


      if (response.statusCode != 200) {
        throw Exception(
          'API Error: ${response.statusCode} - ${response.reasonPhrase}',
        );
      }


      final jsonData = jsonDecode(response.body);
      final List<dynamic> jsonList = jsonData is List ? jsonData : [];

      final stories = jsonList
          .map((json) =>
              RecentlyUpdatedResponse.fromJson(json as Map<String, dynamic>))
          .toList();

      AppLogger.debug(
          'Successfully fetched ${stories.length} recently updated stories from API');
      return stories;
    } catch (e) {
      AppLogger.error('Failed to fetch recently updated stories', e);
      rethrow;
    }
  }

  @override
  Future<List<CompletedStoryResponse>> getCompletedStories() async {
    try {
      final url = '${AppConstants.baseApiUrl}${AppConstants.completedStoriesEndpoint}';
      AppLogger.debug('Calling API: $url');

      final uri = Uri.parse(url);

      final response = await httpClient
          .get(uri)
          .timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw Exception(
          'API Error: ${response.statusCode} - ${response.reasonPhrase}',
        );
      }

      final jsonData = jsonDecode(response.body);
      final List<dynamic> jsonList = jsonData is List ? jsonData : [];

      final stories = jsonList
          .map((json) =>
              CompletedStoryResponse.fromJson(json as Map<String, dynamic>))
          .toList();

      AppLogger.debug(
          'Successfully fetched ${stories.length} completed stories from API');
      return stories;
    } catch (e) {
      AppLogger.error('Failed to fetch completed stories', e);
      rethrow;
    }
  }
}
