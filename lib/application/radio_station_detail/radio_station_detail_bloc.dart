import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labhouse_app/domain/entitites/radio_station.dart';
import 'package:labhouse_app/domain/repositories/radio_player_repository.dart';

part 'radio_station_detail_event.dart';
part 'radio_station_detail_state.dart';

class RadioStationDetailBloc
    extends Bloc<RadioStationDetailEvent, RadioStationDetailState> {
  final RadioPlayerRepository _repository;
  final RadioStation radioStation;

  RadioStationDetailBloc({
    required RadioPlayerRepository repository,
    required this.radioStation,
  })  : _repository = repository,
        super(
          const RadioStationDetailState(
            loadingState: LoadingState.loading,
            isPlaying: false,
            volume: 1,
            currenPosition: Duration.zero,
          ),
        ) {
    _repository.isPlaying.listen((isPlaying) {
      add(SubListenedEvent(isPlaying: isPlaying));
    });

    _repository.volume.listen((volume) {
      add(SubListenedEvent(volume: volume));
    });

    _repository.currentPosition.listen((currenPosition) {
      add(SubListenedEvent(currenPosition: currenPosition));
    });

    on<PauseRadioEvent>(_onPauseRadioEvent);
    on<PlayRadioEvent>(_onPlayRadioEvent);
    on<StartRadioEvent>(_onStartRadioEvent);
    on<SetVolumeRadioEvent>(_onSetVolumeRadioEvent);
    on<SubListenedEvent>(_onSubListenedEvent);
  }

  @override
  Future<void> close() async {
    _repository.dispose();
    super.close();
  }

  Future<void> _onPauseRadioEvent(
    PauseRadioEvent event,
    Emitter<RadioStationDetailState> emit,
  ) async {
    await _repository.pause();
  }

  Future<void> _onPlayRadioEvent(
    PlayRadioEvent event,
    Emitter<RadioStationDetailState> emit,
  ) async {
    await _repository.play();
  }

  Future<void> _onStartRadioEvent(
    StartRadioEvent event,
    Emitter<RadioStationDetailState> emit,
  ) async {
    await _repository.start(radioStation.streamURL);

    emit(
      state.copyWith(
        loadingState: LoadingState.loaded,
      ),
    );
  }

  Future<void> _onSetVolumeRadioEvent(
    SetVolumeRadioEvent event,
    Emitter<RadioStationDetailState> emit,
  ) async {
    _repository.setVolume(event.volume);
  }

  Future<void> _onSubListenedEvent(
    SubListenedEvent event,
    Emitter<RadioStationDetailState> emit,
  ) async {
    emit(
      state.copyWith(
        isPlaying: event.isPlaying,
        currenPosition: event.currenPosition,
        volume: event.volume,
      ),
    );
  }
}
