import 'package:labhouse_app/domain/utils/radio_player.dart';

abstract class RadioPlayerRepository {
  Stream<bool> get isPlaying;
  Stream<double> get volume;
  Stream<Duration> get currentPosition;
  Future<void> start(String url);
  Future<void> play();
  Future<void> pause();
  Future<void> setVolume(double volume);
  Future<void> dispose();
}

class RadioPlayerRepositoryImpl implements RadioPlayerRepository {
  final RadioPlayer _radioPlayer;

  RadioPlayerRepositoryImpl({
    required RadioPlayer radioPlayer,
  }) : _radioPlayer = radioPlayer;

  @override
  Stream<bool> get isPlaying => _radioPlayer.isPlaying;

  @override
  Stream<double> get volume => _radioPlayer.volume;

  @override
  Stream<Duration> get currentPosition => _radioPlayer.currentPosition;

  @override
  Future<void> pause() async {
    await _radioPlayer.pause();
  }

  @override
  Future<void> play() async {
    await _radioPlayer.play();
  }

  @override
  Future<void> setVolume(double volume) async {
    await _radioPlayer.setVolume(volume);
  }

  @override
  Future<void> start(String url) async {
    await _radioPlayer.start(url);
  }

  @override
  Future<void> dispose() async {
    _radioPlayer.dispose();
  }
}
