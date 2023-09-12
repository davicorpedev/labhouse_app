import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labhouse_app/domain/entitites/radio_station.dart';
import 'package:labhouse_app/domain/error/failures.dart';
import 'package:labhouse_app/domain/repositories/radio_station_repository.dart';

part 'radio_stations_event.dart';
part 'radio_stations_state.dart';

class RadioStationsBloc extends Bloc<RadioStationsEvent, RadioStationsState> {
  final RadioStationRepository _repository;

  RadioStationsBloc({
    required RadioStationRepository repository,
  })  : _repository = repository,
        super(RadioStationsInitialState()) {
    on<GetRadioStationsEvent>(_onGetRadioStations);
  }

  Future<void> _onGetRadioStations(
    GetRadioStationsEvent event,
    Emitter<RadioStationsState> emit,
  ) async {
    emit(RadioStationsLoadingState());

    final result = await _repository.getRadioStations();

    result.when(
      success: (radioStations) {
        emit(RadioStationsLoadedState(radioStations: radioStations));
      },
      error: (failure) {
        emit(RadioStationsErrorState(failure: failure));
      },
    );
  }
}
