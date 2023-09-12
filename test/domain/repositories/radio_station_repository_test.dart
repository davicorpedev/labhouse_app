import 'package:flutter_test/flutter_test.dart';
import 'package:labhouse_app/data/error/exceptions.dart';
import 'package:labhouse_app/domain/entitites/radio_station.dart';
import 'package:labhouse_app/domain/entitites/result.dart';
import 'package:labhouse_app/domain/error/failures.dart';
import 'package:labhouse_app/domain/repositories/radio_station_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../data/utils/mock_api_client.dart';
import '../../utils/mock_radio_stations.dart';
import '../utils/mock_network_info.dart';

void main() {
  late RadioStationRepository repository;
  late MockApiClient mockApiClient;
  late MockNetworkInfo mockNetworkInfo;

  setUp(
    () {
      mockApiClient = MockApiClient();
      mockNetworkInfo = MockNetworkInfo();

      repository = RadioStationRepositoryImpl(
        networkInfo: mockNetworkInfo,
        apiClient: mockApiClient,
      );
    },
  );

  group(
    'getRadioStations',
    () {
      group(
        'user has internet connection',
        () {
          setUp(
            () {
              mockNetworkInfo.runTestsOnline();
            },
          );

          test(
            'should call getRadioStations on ApiClient',
            () async {
              when(() => mockApiClient.getRadioStations()).thenAnswer(
                (_) async => tRadioStationModelList,
              );

              await repository.getRadioStations();

              verify(() => mockNetworkInfo.isConnected).called(1);
              verify(() => mockApiClient.getRadioStations()).called(1);
            },
          );

          test(
            'should return a list of RadioStation when the request is successful',
            () async {
              when(() => mockApiClient.getRadioStations()).thenAnswer(
                (_) async => tRadioStationModelList,
              );

              final result = await repository.getRadioStations();

              expect(
                result,
                Result<List<RadioStation>>.success(tRadioStationList),
              );
            },
          );

          test(
            'should return a ServerFailure when the request fails',
            () async {
              when(() => mockApiClient.getRadioStations()).thenThrow(
                ServerException(),
              );

              final result = await repository.getRadioStations();

              expect(
                result,
                Result<List<RadioStation>>.error(ServerFailure()),
              );
            },
          );
        },
      );

      group(
        'user has no internet connection',
        () {
          test(
            'should return NetworkFailure',
            () async {
              mockNetworkInfo.runTestsOffline();

              final result = await repository.getRadioStations();

              verify(() => mockNetworkInfo.isConnected).called(1);

              expect(
                result,
                Result<List<RadioStation>>.error(NetworkFailure()),
              );
            },
          );
        },
      );
    },
  );
}
