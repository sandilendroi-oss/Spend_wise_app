import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:speed_wise_app/models/event.dart';
import 'package:speed_wise_app/models/program.dart';

/// All API settings live here, so there is ONE place to change.
///
/// The base URL below is a PLACEHOLDER. Replace it with your team's real
/// Mock API URL, or pass it when running the app:
///   flutter run --dart-define=API_BASE_URL=https://xxxx.mockapi.io/api/v1
class ApiConfig {
  static const String placeholderBaseUrl =
      'https://YOUR_PROJECT_ID.mockapi.io/api/v1';

  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: placeholderBaseUrl,
  );

  // PROPOSED endpoint paths. Change them if the real API uses other names.
  static const String programsPath = '/programs';
  static const String eventsPath = '/events';

  static const Duration timeout = Duration(seconds: 10);
}

/// The one error type the UI has to handle.
///
/// [message] is written in plain English so it can be shown to the user.
/// [statusCode] is set only when the server answered with an error status.
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, {this.statusCode});

  @override
  String toString() =>
      statusCode == null ? message : '$message (HTTP $statusCode)';
}

/// Talks to the Mock API. It contains NO UI code.
///
/// Usage:
///   final api = ApiService();
///   final programs = await api.fetchPrograms(); // List<Program>
///   final events = await api.fetchEvents();     // List<Event>
///
/// Every failure (no internet, timeout, 404/500, bad JSON, wrong format) is
/// thrown as an [ApiException]. Nothing is silently turned into an empty list.
class ApiService {
  final http.Client _client;
  final bool _ownsClient;
  final String baseUrl;
  final Duration timeout;

  /// [client] can be replaced with a fake one in tests.
  ApiService({http.Client? client, String? baseUrl, Duration? timeout})
    : _client = client ?? http.Client(),
      _ownsClient = client == null,
      baseUrl = baseUrl ?? ApiConfig.baseUrl,
      timeout = timeout ?? ApiConfig.timeout;

  Future<List<Program>> fetchPrograms() =>
      _fetchList(ApiConfig.programsPath, 'programs', Program.fromJson);

  Future<List<Event>> fetchEvents() =>
      _fetchList(ApiConfig.eventsPath, 'events', Event.fromJson);

  /// Closes the internal HTTP client (only if this service created it).
  void dispose() {
    if (_ownsClient) _client.close();
  }

  Future<List<T>> _fetchList<T>(
    String path,
    String label,
    T Function(Map<String, dynamic>) parseItem,
  ) async {
    if (baseUrl.contains('YOUR_PROJECT_ID')) {
      throw const ApiException(
        'The Mock API URL is not set yet. Update ApiConfig.baseUrl in '
        'lib/services/api_service.dart.',
      );
    }

    // Step 1: make the request.
    final http.Response response;
    try {
      final uri = Uri.parse('$baseUrl$path');
      response = await _client
          .get(uri, headers: const {'Accept': 'application/json'})
          .timeout(timeout);
    } on TimeoutException {
      throw ApiException(
        'The server took too long to respond while loading $label.',
      );
    } on http.ClientException catch (e) {
      throw ApiException('Network problem while loading $label: ${e.message}');
    } on FormatException {
      throw ApiException('The API URL "$baseUrl$path" is not valid.');
    } catch (e) {
      // For example a SocketException when there is no internet connection.
      throw ApiException('Could not reach the server while loading $label: $e');
    }

    // Step 2: check the HTTP status code.
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw ApiException(
        'The server returned an error while loading $label',
        statusCode: response.statusCode,
      );
    }

    // Step 3: decode the JSON text.
    final Object? decoded;
    try {
      decoded = jsonDecode(utf8.decode(response.bodyBytes));
    } on FormatException {
      throw ApiException('The server sent invalid JSON for $label.');
    }

    // Step 4: make sure it is a list, then convert each item to a model.
    if (decoded is! List) {
      throw ApiException(
        'Unexpected response format for $label: expected a JSON list.',
      );
    }

    final result = <T>[];
    for (var i = 0; i < decoded.length; i++) {
      final item = decoded[i];
      if (item is! Map<String, dynamic>) {
        throw ApiException(
          'Unexpected response format for $label: item $i is not a JSON object.',
        );
      }
      try {
        result.add(parseItem(item));
      } on FormatException catch (e) {
        throw ApiException('Bad data in $label (item $i): ${e.message}');
      }
    }
    return result;
  }
}
