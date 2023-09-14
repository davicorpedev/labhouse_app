import 'package:flutter_test/flutter_test.dart';
import 'package:labhouse_app/domain/repositories/radio_player_repository.dart';
import 'package:labhouse_app/domain/utils/radio_player.dart';
import 'package:mocktail/mocktail.dart';

//TODO: https://stackoverflow.com/questions/56621534/how-to-unit-test-stream-listen-in-dart

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
}
