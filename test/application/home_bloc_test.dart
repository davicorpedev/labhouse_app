import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labhouse_app/application/home/home_bloc.dart';
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
      blocTest<HomeBloc, HomeState>(
        'should call getRadioStations from repository',
        build: () => HomeBloc(repository: mockRadioStationRepository),
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

      blocTest<HomeBloc, HomeState>(
        'should emit [Loading, Loaded] when the request has succeded',
        build: () => HomeBloc(repository: mockRadioStationRepository),
        setUp: () {
          when(() => mockRadioStationRepository.getRadioStations()).thenAnswer(
            (_) async => Result<List<RadioStation>>.success(tRadioStationList),
          );
        },
        act: (bloc) => bloc.add(GetRadioStationsEvent()),
        expect: () => [
          HomeLoadingState(),
          HomeLoadedState(radioStations: tRadioStationList),
        ],
      );

      blocTest<HomeBloc, HomeState>(
        'should emit [Loading, Error] when the request has failed',
        build: () => HomeBloc(repository: mockRadioStationRepository),
        setUp: () {
          when(() => mockRadioStationRepository.getRadioStations()).thenAnswer(
            (_) async => Result<List<RadioStation>>.error(NetworkFailure()),
          );
        },
        act: (bloc) => bloc.add(GetRadioStationsEvent()),
        expect: () => [
          HomeLoadingState(),
          HomeErrorState(failure: NetworkFailure()),
        ],
      );
    },
  );
}
