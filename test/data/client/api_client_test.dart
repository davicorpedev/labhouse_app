import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:labhouse_app/data/client/api_client.dart';
import 'package:labhouse_app/data/client/api_requester.dart';
import 'package:labhouse_app/data/error/exceptions.dart';
import 'package:labhouse_app/data/models/radio_station_model.dart';
import 'package:labhouse_app/domain/entitites/id.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/fixture_reader.dart';

class MockApiRequester extends Mock implements ApiRequester {}

void main() {
  late MockApiRequester mockApiRequester;
  late LiveApiClient apiClient;

  setUp(() {
    mockApiRequester = MockApiRequester();
    apiClient = LiveApiClient(apiRequester: mockApiRequester);
  });

  group('getRadioStations', () {
    const tRadioStationModelList = [
      RadioStationModel(
        id: ID('test1'),
        name: 'TEST 1 FM',
        image: 'test1.jpg',
        streamURL: 'test1.mp3',
        homepage: 'test1.com',
      ),
      RadioStationModel(
        id: ID('test2'),
        name: 'TEST 2 FM',
        image: 'test2.jpg',
        streamURL: 'test2.mp3',
        homepage: 'test2.com',
      ),
    ];

    void mockGetRadioStationsSuccess() {
      when(
        () => mockApiRequester.get(
          path: any(named: 'path'),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          fixture('stations.json'),
          200,
        ),
      );
    }

    test(
      'should perform a get request',
      () async {
        mockGetRadioStationsSuccess();

        await apiClient.getRadioStations();

        verify(
          () => mockApiRequester.get(
            path: 'stations',
            queryParameters: {'limit': 20},
          ),
        ).called(1);
      },
    );

    test(
      'should return a list of RadioStations Models when the request is successful',
      () async {
        mockGetRadioStationsSuccess();

        final result = await apiClient.getRadioStations();

        expect(result, tRadioStationModelList);
      },
    );

    test(
      'should throw a ServerException if the response fails',
      () async {
        when(
          () => mockApiRequester.get(
            path: any(named: 'path'),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenThrow(ServerException());

        final call = apiClient.getRadioStations();

        expect(() => call, throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
