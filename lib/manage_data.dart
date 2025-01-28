import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Custom exception for API related errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic response;

  ApiException(this.message, {this.statusCode, this.response});

  @override
  String toString() => 'ApiException: $message (Status Code: $statusCode)';
}

class _CacheEntry {
  final dynamic data;
  final DateTime timestamp;

  _CacheEntry(this.data) : timestamp = DateTime.now();
  static const Duration _cacheDuration = Duration(minutes: 5);

  bool get isValid => DateTime.now().difference(timestamp) < _cacheDuration;
}

/// Generic API response wrapper
class ApiResponse<T> {
  final T? data;
  final bool success;
  final String? error;
  final int statusCode;

  ApiResponse({
    this.data,
    required this.success,
    this.error,
    required this.statusCode,
  });
}


class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();
  final _client = http.Client();
  final _connectivity = Connectivity();
  final _cache = <String, _CacheEntry>{};
  static const int _maxRetries = 3;
  static const Duration _timeout = Duration(seconds: 30);


  Future<ApiResponse<T>> request<T>({
    required String url,
    required String method,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool useCache = true,
    Duration? customTimeout,
    bool requiresAuth = true,
  }) async {
    try {
      // Check connectivity
      if (!await _checkConnectivity()) {
        throw ApiException('No internet connection');
      }

      // Check cache for GET requests
      if (method == 'GET' && useCache) {
        final cachedResponse = _getCachedResponse<T>(url, fromJson);
        if (cachedResponse != null) {
          return ApiResponse(
            data: cachedResponse,
            success: true,
            statusCode: 200,
          );
        }
      }

      // Prepare headers
      headers ??= {};
      headers['Content-Type'] = 'application/json';
      if (requiresAuth) {
        headers['Authorization'] = await _getAuthToken();
      }

      // Make the request with retry mechanism
      final response = await _retryRequest(
        () => _makeRequest(
          url: url,
          method: method,
          headers: headers!,
          body: body,
          timeout: customTimeout ?? _timeout,
        ),
      );

      // Handle response
      return await _handleResponse<T>(response, fromJson, url, useCache);
    } on SocketException {
      throw ApiException('Network error occurred');
    } on TimeoutException {
      throw ApiException('Request timed out');
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  /// Convenience method for GET requests
  Future<ApiResponse<T>> get<T>({
    required String url,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, String>? headers,
    bool useCache = true,
  }) async {
    return request<T>(
      url: url,
      method: 'GET',
      fromJson: fromJson,
      headers: headers,
      useCache: useCache,
    );
  }

  /// Convenience method for POST requests
  Future<ApiResponse<T>> post<T>({
    required String url,
    required T Function(Map<String, dynamic>) fromJson,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    return request<T>(
      url: url,
      method: 'POST',
      fromJson: fromJson,
      body: body,
      headers: headers,
      useCache: false,
    );
  }

  /// Convenience method for PUT requests
  Future<ApiResponse<T>> put<T>({
    required String url,
    required T Function(Map<String, dynamic>) fromJson,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    return request<T>(
      url: url,
      method: 'PUT',
      fromJson: fromJson,
      body: body,
      headers: headers,
      useCache: false,
    );
  }

  /// Convenience method for DELETE requests
  Future<bool> delete({
    required String url,
    Map<String, String>? headers,
  }) async {
    final response = await request<void>(
      url: url,
      method: 'DELETE',
      fromJson: (_) {},
      headers: headers,
      useCache: false,
    );
    return response.success;
  }

  /// Check internet connectivity
  Future<bool> _checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  /// Get cached response if valid
  T? _getCachedResponse<T>(
    String url,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final cacheEntry = _cache[url];
    if (cacheEntry != null && cacheEntry.isValid) {
      return fromJson(cacheEntry.data);
    }
    return null;
  }

  /// Cache response data
  void _cacheResponse(String url, Map<String, dynamic> data) {
    _cache[url] = _CacheEntry(data);
  }

  /// Make HTTP request with timeout
  Future<http.Response> _makeRequest({
    required String url,
    required String method,
    required Map<String, String> headers,
    Map<String, dynamic>? body,
    required Duration timeout,
  }) async {
    final uri = Uri.parse(url);
    final request = http.Request(method, uri)
      ..headers.addAll(headers)
      ..body = body != null ? json.encode(body) : '';

    final streamedResponse = await _client.send(request).timeout(timeout);

    return http.Response.fromStream(streamedResponse);
  }

  /// Retry mechanism for failed requests
  Future<T> _retryRequest<T>(
    Future<T> Function() request, {
    int retries = _maxRetries,
  }) async {
    try {
      return await request();
    } catch (e) {
      if (retries > 0) {
        await Future.delayed(Duration(seconds: 1));
        return _retryRequest(request, retries: retries - 1);
      }
      rethrow;
    }
  }

  /// Handle API response
  Future<ApiResponse<T>> _handleResponse<T>(
    http.Response response,
    T Function(Map<String, dynamic>) fromJson,
    String url,
    bool useCache,
  ) async {
    final statusCode = response.statusCode;
    final body = _parseResponseBody(response);

    switch (statusCode) {
      case 200:
      case 201:
        if (body is! Map<String, dynamic>) {
          throw ApiException('Invalid response format');
        }

        if (useCache) {
          _cacheResponse(url, body);
        }

        return ApiResponse(
          data: fromJson(body),
          success: true,
          statusCode: statusCode,
        );

      case 401:
        // Handle unauthorized access
        await _handleUnauthorized();
        throw ApiException('Unauthorized', statusCode: statusCode);

      case 404:
        throw ApiException('Resource not found', statusCode: statusCode);

      case 422:
        throw ApiException('Validation error',
            statusCode: statusCode, response: body);

      case 429:
        // Handle rate limiting
        final retryAfter = response.headers['retry-after'];
        throw ApiException(
          'Rate limit exceeded. Try again after $retryAfter seconds',
          statusCode: statusCode,
        );

      default:
        if (statusCode >= 500) {
          throw ApiException('Server error', statusCode: statusCode);
        } else {
          throw ApiException('Request failed', statusCode: statusCode);
        }
    }
  }

  /// Parse response body safely
  dynamic _parseResponseBody(http.Response response) {
    try {
      return json.decode(response.body);
    } catch (e) {
      throw ApiException('Failed to parse response');
    }
  }

  /// Handle unauthorized access
  Future<void> _handleUnauthorized() async {
    // Clear cached auth token
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');

    // You might want to trigger a logout or refresh token flow here
  }

  /// Get authentication token
  Future<String> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token') ?? '';
  }

  /// Clear cache
  void clearCache() {
    _cache.clear();
  }

  /// Close client
  void dispose() {
    _client.close();
  }
}
