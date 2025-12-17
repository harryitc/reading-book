import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';
import '../../core/utils/logger.dart';

/// HTTP client configuration
class HttpClient {
  late final http.Client _client;
  late final String _baseUrl;
  late final Duration _timeout;

  /// Initialize HTTP client
  void init() {
    _baseUrl = AppConstants.baseApiUrl;
    _timeout = AppConstants.apiTimeout;
    _client = http.Client();
  }

  /// GET request
  Future<http.Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = _buildUri(path, queryParameters);
      AppLogger.debug('GET $path');
      final response = await _client
          .get(uri, headers: _buildHeaders(headers))
          .timeout(_timeout);
      return response;
    } catch (e) {
      AppLogger.error('GET request failed: $path', e);
      rethrow;
    }
  }

  /// POST request
  Future<http.Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = _buildUri(path, queryParameters);
      AppLogger.debug('POST $path');
      final response = await _client
          .post(
            uri,
            headers: _buildHeaders(headers),
            body: data is String ? data : jsonEncode(data),
          )
          .timeout(_timeout);
      return response;
    } catch (e) {
      AppLogger.error('POST request failed: $path', e);
      rethrow;
    }
  }

  /// PUT request
  Future<http.Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = _buildUri(path, queryParameters);
      AppLogger.debug('PUT $path');
      final response = await _client
          .put(
            uri,
            headers: _buildHeaders(headers),
            body: data is String ? data : jsonEncode(data),
          )
          .timeout(_timeout);
      return response;
    } catch (e) {
      AppLogger.error('PUT request failed: $path', e);
      rethrow;
    }
  }

  /// DELETE request
  Future<http.Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = _buildUri(path, queryParameters);
      AppLogger.debug('DELETE $path');
      final response = await _client
          .delete(
            uri,
            headers: _buildHeaders(headers),
            body: data is String ? data : jsonEncode(data),
          )
          .timeout(_timeout);
      return response;
    } catch (e) {
      AppLogger.error('DELETE request failed: $path', e);
      rethrow;
    }
  }

  /// Build complete URI
  Uri _buildUri(String path, Map<String, dynamic>? queryParameters) {
    final fullUrl = path.startsWith('http')
        ? path
        : '$_baseUrl$path';
    
    if (queryParameters != null && queryParameters.isNotEmpty) {
      return Uri.parse(fullUrl).replace(
        queryParameters: queryParameters.map((k, v) => MapEntry(k, v.toString())),
      );
    }
    return Uri.parse(fullUrl);
  }

  /// Build default headers
  Map<String, String> _buildHeaders(Map<String, String>? customHeaders) {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }
    return headers;
  }

  /// Dispose client
  void dispose() {
    _client.close();
  }
}
