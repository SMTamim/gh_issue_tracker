import 'dart:convert';
import 'package:http/http.dart' as http;

class APIClient {
  static APIClient? _instance;
  final String baseUrl;
  final Duration timeout;

  APIClient._({required this.baseUrl, required this.timeout});

  static APIClient get instance {
    _instance ??= APIClient._(
      baseUrl: 'https://api.github.com',
      timeout: const Duration(minutes: 1),
    );
    return _instance!;
  }

  Future<http.Response> get(String endpoint,
      {Map<String, String>? headers, Map<String, String>? queries}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    if (queries != null) {
      uri.replace(queryParameters: queries);
    }
    return http.get(uri, headers: headers).timeout(timeout, onTimeout: () {
      throw Exception('Request timeout');
    });
  }

  Future<http.Response> post(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    return http
        .post(
      uri,
      headers: headers,
      body: json.encode(body),
    )
        .timeout(timeout, onTimeout: () {
      throw Exception('Request timeout');
    });
  }

  Future<http.Response> requestGetMethodAsJSONEncoded(
          {required String url,
          Map<String, dynamic>? queries,
          Map<String, String>? headers,
          String? contentType}) async =>
      await get(url, headers: headers);
}
