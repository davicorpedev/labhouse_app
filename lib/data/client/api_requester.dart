import 'package:http/http.dart' as http;
import 'package:labhouse_app/data/error/exceptions.dart';

abstract class ApiRequester {
  Future<http.Response> get({
    required String path,
    Map<String, dynamic>? queryParameters = const {},
  });

  Future<http.Response> post({
    required String path,
    Map<String, dynamic>? queryParameters = const {},
  });
}

class HttpApiRequester extends ApiRequester {
  final http.Client _client;
  final String _baseUrl;
  final String _format;

  HttpApiRequester({
    required http.Client client,
    required String baseUrl,
    required String format,
  })  : _client = client,
        _baseUrl = baseUrl,
        _format = format;

  @override
  Future<http.Response> get({
    required String path,
    Map<String, dynamic>? queryParameters = const {},
  }) async {
    try {
      final response = await _client.get(
        Uri.https(
          _baseUrl,
          '/$_format/$path',
          queryParameters,
        ),
        headers: {},
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<http.Response> post({
    required String path,
    Map<String, dynamic>? queryParameters = const {},
  }) async {
    try {
      final response = await _client.post(
        Uri.https(
          _baseUrl,
          '/$_format/$path',
          queryParameters,
        ),
        headers: {},
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
