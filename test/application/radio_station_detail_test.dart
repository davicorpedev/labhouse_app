import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labhouse_app/application/radio_station_detail/radio_station_detail_bloc.dart';
import 'package:labhouse_app/domain/repositories/radio_player_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../utils/mock_radio_stations.dart';

class MockRadioPlayerRepository extends Mock implements RadioPlayerRepository {}

void main() {
  late MockRadioPlayerRepository mockRadioPlayerRepository;

  setUp(
    () {
      mockRadioPlayerRepository = MockRadioPlayerRepository();
    },
  );

  void setStreamsAndDispose() {
    when(() => mockRadioPlayerRepository.isPlaying).thenAnswer(
      (invocation) => Stream.value(true),
    );
    when(() => mockRadioPlayerRepository.currentPosition).thenAnswer(
      (invocation) => Stream.value(const Duration(seconds: 1)),
    );
    when(() => mockRadioPlayerRepository.volume).thenAnswer(
      (invocation) => Stream.value(0.5),
    );

    when(() => mockRadioPlayerRepository.dispose()).thenAnswer(
      (_) async => Future.value(),
    );
  }

  blocTest<RadioStationDetailBloc, RadioStationDetailState>(
    'should call start from repository',
    build: () => RadioStationDetailBloc(
      repository: mockRadioPlayerRepository,
      radioStation: tRadioStation,
    ),
    setUp: () {
      setStreamsAndDispose();
      when(() => mockRadioPlayerRepository.start(any())).thenAnswer(
        (_) async => Future.value(),
      );
    },
    act: (bloc) => bloc.add(StartRadioEvent()),
    verify: (bloc) {
      verify(() => mockRadioPlayerRepository.start('test.mp3')).called(1);
    },
  );

  blocTest<RadioStationDetailBloc, RadioStationDetailState>(
    'should call pause from repository',
    build: () => RadioStationDetailBloc(
      repository: mockRadioPlayerRepository,
      radioStation: tRadioStation,
    ),
    setUp: () {
      setStreamsAndDispose();
      when(() => mockRadioPlayerRepository.pause()).thenAnswer(
        (_) async => Future.value(),
      );
    },
    act: (bloc) => bloc.add(PauseRadioEvent()),
    verify: (bloc) {
      verify(() => mockRadioPlayerRepository.pause()).called(1);
    },
  );

  blocTest<RadioStationDetailBloc, RadioStationDetailState>(
    'should call play from repository',
    build: () => RadioStationDetailBloc(
      repository: mockRadioPlayerRepository,
      radioStation: tRadioStation,
    ),
    setUp: () {
      setStreamsAndDispose();
      when(() => mockRadioPlayerRepository.play()).thenAnswer(
        (_) async => Future.value(),
      );
    },
    act: (bloc) => bloc.add(PlayRadioEvent()),
    verify: (bloc) {
      verify(() => mockRadioPlayerRepository.play()).called(1);
    },
  );

  blocTest<RadioStationDetailBloc, RadioStationDetailState>(
    'should call setVolume from repository',
    build: () => RadioStationDetailBloc(
      repository: mockRadioPlayerRepository,
      radioStation: tRadioStation,
    ),
    setUp: () {
      setStreamsAndDispose();
      when(() => mockRadioPlayerRepository.setVolume(any())).thenAnswer(
        (_) async => Future.value(),
      );
    },
    act: (bloc) => bloc.add(const SetVolumeRadioEvent(volume: 1)),
    verify: (bloc) {
      verify(() => mockRadioPlayerRepository.setVolume(1)).called(1);
    },
  );

  blocTest<RadioStationDetailBloc, RadioStationDetailState>(
    'should call dispose from repository',
    build: () => RadioStationDetailBloc(
      repository: mockRadioPlayerRepository,
      radioStation: tRadioStation,
    ),
    setUp: () {
      setStreamsAndDispose();
    },
    tearDown: () {
      verify(() => mockRadioPlayerRepository.dispose()).called(1);
    },
  );
}
