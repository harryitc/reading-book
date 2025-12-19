import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/hot_story_response.dart';
import '../models/recently_updated_response.dart';
import '../models/completed_story_response.dart';
import '../../../../core/utils/logger.dart';

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
  static const String baseUrl =
      'https://redbird-generous-alpaca.ngrok-free.app/webhook';

  StoryRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<List<HotStoryResponse>> getHotStories() async {
    try {
      AppLogger.debug('Calling API: $baseUrl/dashboard-truyen-hot');

      final uri = Uri.parse('$baseUrl/dashboard-truyen-hot');
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
      AppLogger.debug('Calling API: $baseUrl/dashboard-truyen-moi-cap-nhat');

      final uri = Uri.parse('$baseUrl/dashboard-truyen-moi-cap-nhat');
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
      AppLogger.debug('Calling API: $baseUrl/dashboard-truyen-da-hoan-thanh');

      final uri = Uri.parse('$baseUrl/dashboard-truyen-da-hoan-thanh');

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
