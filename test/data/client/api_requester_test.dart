import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:labhouse_app/data/client/api_requester.dart';
import 'package:labhouse_app/data/error/exceptions.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  const baseUrl = 'baseUrl';
  const format = 'json';
  const path = 'path';

  const jsonKey = 'test';
  const jsonValue = 'test';

  late final HttpApiRequester apiRequester;
  late final MockHttpClient httpClient;

  setUpAll(() {
    httpClient = MockHttpClient();

    apiRequester = HttpApiRequester(
      client: httpClient,
      baseUrl: baseUrl,
      format: format,
    );

    registerFallbackValue(Uri());
  });

  group(
    'get',
    () {
      test(
        'should perform a HTTP GET request with valid queryParameters and headers',
        () async {
          when(
            () => httpClient.get(
              any(),
              headers: any(named: 'headers'),
            ),
          ).thenAnswer((_) async => http.Response('[]', 200));

          await apiRequester.get(
            path: path,
            queryParameters: {jsonKey: jsonValue},
          );

          verify(
            () => httpClient.get(
              Uri.https(
                baseUrl,
                '/$format/$path',
                {jsonKey: jsonValue},
              ),
              headers: {},
            ),
          ).called(1);
        },
      );

      test(
        'should return a Response if successful',
        () async {
          when(
            () => httpClient.get(
              any(),
              headers: any(named: 'headers'),
            ),
          ).thenAnswer(
            (_) async => http.Response('[{"$jsonKey": "$jsonValue"}]', 200),
          );

          final result = await apiRequester.get(path: path);

          expect(
            result.body,
            '[{"$jsonKey": "$jsonValue"}]',
          );

          expect(
            result.statusCode,
            200,
          );
        },
      );

      test(
        'should throw a ServerException if the request has failed',
        () async {
          when(
            () => httpClient.get(
              any(),
              headers: any(named: 'headers'),
            ),
          ).thenAnswer((_) async => http.Response('[]', 404));

          final call = apiRequester.get(path: path);

          expect(
            () => call,
            throwsA(const TypeMatcher<ServerException>()),
          );
        },
      );

      test(
        'should throw a ServerException if an exception has occurred',
        () async {
          when(
            () => httpClient.get(
              any(),
              headers: any(named: 'headers'),
            ),
          ).thenThrow(const FormatException());

          final call = apiRequester.get(path: path);

          expect(
            () => call,
            throwsA(const TypeMatcher<ServerException>()),
          );
        },
      );
    },
  );

  group(
    'post',
    () {
      test(
        'should perform a HTTP POST request with valid queryParameters and headers',
        () async {
          when(
            () => httpClient.post(
              any(),
              headers: any(named: 'headers'),
            ),
          ).thenAnswer((_) async => http.Response('[]', 200));

          await apiRequester.post(
            path: path,
            queryParameters: {jsonKey: jsonValue},
          );

          verify(
            () => httpClient.post(
              Uri.https(
                baseUrl,
                '/$format/$path',
                {jsonKey: jsonValue},
              ),
              headers: {},
            ),
          ).called(1);
        },
      );

      test(
        'should return a Response if successful',
        () async {
          when(
            () => httpClient.post(
              any(),
              headers: any(named: 'headers'),
            ),
          ).thenAnswer(
            (_) async => http.Response('[{"$jsonKey": "$jsonValue"}]', 200),
          );

          final result = await apiRequester.post(path: path);

          expect(
            result.body,
            '[{"$jsonKey": "$jsonValue"}]',
          );

          expect(
            result.statusCode,
            200,
          );
        },
      );

      test(
        'should throw a ServerException if the request has failed',
        () async {
          when(
            () => httpClient.post(
              any(),
              headers: any(named: 'headers'),
            ),
          ).thenAnswer((_) async => http.Response('[]', 404));

          final call = apiRequester.post(path: path);

          expect(
            () => call,
            throwsA(const TypeMatcher<ServerException>()),
          );
        },
      );

      test(
        'should throw a ServerException if an exception has occurred',
        () async {
          when(
            () => httpClient.post(
              any(),
              headers: any(named: 'headers'),
            ),
          ).thenThrow(const FormatException());

          final call = apiRequester.post(path: path);

          expect(
            () => call,
            throwsA(const TypeMatcher<ServerException>()),
          );
        },
      );
    },
  );
}
