import 'package:assets_audio_player/assets_audio_player.dart';

abstract class RadioPlayer {
  Stream<bool> get isPlaying;
  Stream<double> get volume;
  Stream<Duration> get currentPosition;
  Future<void> start(String url);
  Future<void> play();
  Future<void> pause();
  Future<void> setVolume(double volume);
  Future<void> dispose();
}

class RadioPlayerImpl implements RadioPlayer {
  final AssetsAudioPlayer _assetsAudioPlayer;

  RadioPlayerImpl({
    required AssetsAudioPlayer assetsAudioPlayer,
  }) : _assetsAudioPlayer = assetsAudioPlayer;

  @override
  Stream<bool> get isPlaying => _assetsAudioPlayer.isPlaying;

  @override
  Stream<double> get volume => _assetsAudioPlayer.volume;

  @override
  Stream<Duration> get currentPosition => _assetsAudioPlayer.currentPosition;

  @override
  Future<void> pause() async {
    await _assetsAudioPlayer.pause();
  }

  @override
  Future<void> play() async {
    await _assetsAudioPlayer.play();
  }

  @override
  Future<void> setVolume(double volume) async {
    await _assetsAudioPlayer.setVolume(volume);
  }

  @override
  Future<void> start(String url) async {
    await _assetsAudioPlayer.open(Audio.liveStream(url));
  }

  @override
  Future<void> dispose() async {
    _assetsAudioPlayer.dispose();
  }
}
