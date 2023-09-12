import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labhouse_app/application/radio_stations/radio_stations_bloc.dart';
import 'package:labhouse_app/domain/entitites/radio_station.dart';
import 'package:labhouse_app/domain/entitites/result.dart';
import 'package:labhouse_app/domain/error/failures.dart';
import 'package:labhouse_app/domain/repositories/radio_station_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../utils/mock_radio_stations.dart';

class MockRadioStationRepository extends Mock
    implements RadioStationRepository {}

void main() {
  late MockRadioStationRepository mockRadioStationRepository;

  setUp(
    () {
      mockRadioStationRepository = MockRadioStationRepository();
    },
  );

  group(
    'GetRadioStations',
    () {
      blocTest<RadioStationsBloc, RadioStationsState>(
        'should call getRadioStations from repository',
        build: () => RadioStationsBloc(repository: mockRadioStationRepository),
        setUp: () {
          when(() => mockRadioStationRepository.getRadioStations()).thenAnswer(
            (_) async => Result<List<RadioStation>>.success(tRadioStationList),
          );
        },
        act: (bloc) => bloc.add(GetRadioStationsEvent()),
        verify: (bloc) {
          verify(() => mockRadioStationRepository.getRadioStations()).called(1);
        },
      );

      blocTest<RadioStationsBloc, RadioStationsState>(
        'should emit [Loading, Loaded] when the request has succeded',
        build: () => RadioStationsBloc(repository: mockRadioStationRepository),
        setUp: () {
          when(() => mockRadioStationRepository.getRadioStations()).thenAnswer(
            (_) async => Result<List<RadioStation>>.success(tRadioStationList),
          );
        },
        act: (bloc) => bloc.add(GetRadioStationsEvent()),
        expect: () => [
          RadioStationsLoadingState(),
          RadioStationsLoadedState(radioStations: tRadioStationList),
        ],
      );

      blocTest<RadioStationsBloc, RadioStationsState>(
        'should emit [Loading, Error] when the request has failed',
        build: () => RadioStationsBloc(repository: mockRadioStationRepository),
        setUp: () {
          when(() => mockRadioStationRepository.getRadioStations()).thenAnswer(
            (_) async => Result<List<RadioStation>>.error(NetworkFailure()),
          );
        },
        act: (bloc) => bloc.add(GetRadioStationsEvent()),
        expect: () => [
          RadioStationsLoadingState(),
          RadioStationsErrorState(failure: NetworkFailure()),
        ],
      );
    },
  );
}
