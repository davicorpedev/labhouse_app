part of 'radio_station_detail_bloc.dart';

sealed class RadioStationDetailEvent extends Equatable {
  const RadioStationDetailEvent();

  @override
  List<Object?> get props => [];
}

class StartRadioEvent extends RadioStationDetailEvent {}

class PauseRadioEvent extends RadioStationDetailEvent {}

class PlayRadioEvent extends RadioStationDetailEvent {}

class SetVolumeRadioEvent extends RadioStationDetailEvent {
  final double volume;

  const SetVolumeRadioEvent({required this.volume});

  @override
  List<Object> get props => [volume];
}

class SubListenedEvent extends RadioStationDetailEvent {
  final bool? isPlaying;
  final double? volume;
  final Duration? currenPosition;

  const SubListenedEvent({
    this.isPlaying,
    this.volume,
    this.currenPosition,
  });

  @override
  List<Object?> get props => [
        isPlaying,
        volume,
        currenPosition,
      ];
}
