import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:labhouse_app/domain/repositories/radio_player_repository.dart';
import 'package:labhouse_app/domain/utils/radio_player.dart';
import 'package:mocktail/mocktail.dart';

class MockRadioPlayer extends Mock implements RadioPlayer {}

void main() {
  late RadioPlayerRepository repository;
  late MockRadioPlayer mockRadioPlayer;

  setUp(
    () {
      mockRadioPlayer = MockRadioPlayer();
      repository = RadioPlayerRepositoryImpl(radioPlayer: mockRadioPlayer);
    },
  );

  group(
    'start',
    () {
      test(
        'should call submethod from RadioPlayer',
        () async {
          when(() => mockRadioPlayer.start(any())).thenAnswer(
            (_) => Future.value(),
          );

          await repository.start('url');

          verify(() => mockRadioPlayer.start('url')).called(1);
        },
      );
    },
  );

  group(
    'play',
    () {
      test(
        'should call submethod from RadioPlayer',
        () async {
          when(() => mockRadioPlayer.play()).thenAnswer(
            (_) => Future.value(),
          );

          await repository.play();

          verify(() => mockRadioPlayer.play()).called(1);
        },
      );
    },
  );

  group(
    'pause',
    () {
      test(
        'should call submethod from RadioPlayer',
        () async {
          when(() => mockRadioPlayer.pause()).thenAnswer(
            (_) => Future.value(),
          );

          await repository.pause();

          verify(() => mockRadioPlayer.pause()).called(1);
        },
      );
    },
  );

  group(
    'setVolume',
    () {
      test(
        'should call submethod from RadioPlayer',
        () async {
          when(() => mockRadioPlayer.setVolume(any())).thenAnswer(
            (_) => Future.value(),
          );

          await repository.setVolume(1);

          verify(() => mockRadioPlayer.setVolume(1)).called(1);
        },
      );
    },
  );

  group(
    'dispose',
    () {
      test(
        'should call submethod from RadioPlayer',
        () async {
          when(() => mockRadioPlayer.dispose()).thenAnswer(
            (_) => Future.value(),
          );

          await repository.dispose();

          verify(() => mockRadioPlayer.dispose()).called(1);
        },
      );
    },
  );

  group(
    'isPlaying',
    () {
      test(
        'Listens to RadioPlayer Stream',
        () {
          when(() => mockRadioPlayer.isPlaying).thenAnswer(
            (invocation) => Stream.value(true),
          );

          var stream = repository.isPlaying;

          expectLater(stream, emits(true));

          repository.isPlaying.first;
        },
      );
    },
  );

  group(
    'currentPosition',
    () {
      test(
        'Listens to RadioPlayer Stream',
        () {
          when(() => mockRadioPlayer.currentPosition).thenAnswer(
            (invocation) => Stream.value(const Duration(seconds: 1)),
          );

          var stream = repository.currentPosition;

          expectLater(stream, emits(const Duration(seconds: 1)));

          repository.currentPosition.first;
        },
      );
    },
  );

  group(
    'volume',
    () {
      test(
        'Listens to RadioPlayer Stream',
        () {
          when(() => mockRadioPlayer.volume).thenAnswer(
            (invocation) => Stream.value(1),
          );

          var stream = repository.volume;

          expectLater(stream, emits(1));

          repository.volume.first;
        },
      );
    },
  );
}
