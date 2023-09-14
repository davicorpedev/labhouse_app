part of 'radio_station_detail_bloc.dart';

enum LoadingState { loading, loaded }

class RadioStationDetailState extends Equatable {
  final LoadingState loadingState;
  final bool isPlaying;
  final double volume;
  final Duration currenPosition;

  bool get isLoaded => loadingState == LoadingState.loaded;

  const RadioStationDetailState({
    required this.loadingState,
    required this.isPlaying,
    required this.volume,
    required this.currenPosition,
  });

  RadioStationDetailState copyWith({
    bool? isPlaying,
    double? volume,
    Duration? currenPosition,
    LoadingState? loadingState,
  }) {
    return RadioStationDetailState(
      isPlaying: isPlaying ?? this.isPlaying,
      volume: volume ?? this.volume,
      currenPosition: currenPosition ?? this.currenPosition,
      loadingState: loadingState ?? this.loadingState,
    );
  }

  @override
  List<Object> get props => [
        isPlaying,
        volume,
        currenPosition,
        loadingState,
      ];
}
