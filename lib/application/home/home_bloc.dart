import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labhouse_app/domain/entitites/radio_station.dart';
import 'package:labhouse_app/domain/error/failures.dart';
import 'package:labhouse_app/domain/repositories/radio_station_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final RadioStationRepository _repository;

  HomeBloc({
    required RadioStationRepository repository,
  })  : _repository = repository,
        super(HomeInitialState()) {
    on<GetRadioStationsEvent>(_onGetRadioStationsEvent);
  }

  Future<void> _onGetRadioStationsEvent(
    GetRadioStationsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());

    final result = await _repository.getRadioStations();

    result.when(
      success: (radioStations) {
        emit(HomeLoadedState(radioStations: radioStations));
      },
      error: (failure) {
        emit(HomeErrorState(failure: failure));
      },
    );
  }
}
