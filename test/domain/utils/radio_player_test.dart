import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:labhouse_app/domain/utils/radio_player.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';

class MockAssetsAudioPlayer extends Mock implements AssetsAudioPlayer {}

void main() {
  late RadioPlayer radioPlayer;
  late MockAssetsAudioPlayer mockAssetsAudioPlayer;

  setUp(
    () {
      mockAssetsAudioPlayer = MockAssetsAudioPlayer();
      radioPlayer = RadioPlayerImpl(assetsAudioPlayer: mockAssetsAudioPlayer);
    },
  );

  setUpAll(() {
    registerFallbackValue(Playable());
  });

  group(
    'start',
    () {
      test(
        'should call submethod from RadioPlayer',
        () async {
          when(() => mockAssetsAudioPlayer.open(any())).thenAnswer(
            (_) => Future.value(),
          );

          await radioPlayer.start('url');

          verify(
            () => mockAssetsAudioPlayer.open(Audio.liveStream('url')),
          ).called(1);
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
          when(() => mockAssetsAudioPlayer.play()).thenAnswer(
            (_) => Future.value(),
          );

          await radioPlayer.play();

          verify(() => mockAssetsAudioPlayer.play()).called(1);
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
          when(() => mockAssetsAudioPlayer.pause()).thenAnswer(
            (_) => Future.value(),
          );

          await radioPlayer.pause();

          verify(() => mockAssetsAudioPlayer.pause()).called(1);
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
          when(() => mockAssetsAudioPlayer.setVolume(any())).thenAnswer(
            (_) => Future.value(),
          );

          await radioPlayer.setVolume(1);

          verify(() => mockAssetsAudioPlayer.setVolume(1)).called(1);
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
          when(() => mockAssetsAudioPlayer.dispose()).thenAnswer(
            (_) => Future.value(),
          );

          await radioPlayer.dispose();

          verify(() => mockAssetsAudioPlayer.dispose()).called(1);
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
          when(() => mockAssetsAudioPlayer.isPlaying).thenAnswer(
            (invocation) => BehaviorSubject.seeded(true),
          );

          var stream = radioPlayer.isPlaying;

          expectLater(stream, emits(true));

          radioPlayer.isPlaying.first;
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
          when(() => mockAssetsAudioPlayer.currentPosition).thenAnswer(
            (invocation) => BehaviorSubject.seeded(const Duration(seconds: 1)),
          );

          var stream = radioPlayer.currentPosition;

          expectLater(stream, emits(const Duration(seconds: 1)));

          radioPlayer.currentPosition.first;
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
          when(() => mockAssetsAudioPlayer.volume).thenAnswer(
            (invocation) => BehaviorSubject.seeded(1),
          );

          var stream = radioPlayer.volume;

          expectLater(stream, emits(1));

          radioPlayer.volume.first;
        },
      );
    },
  );
}
