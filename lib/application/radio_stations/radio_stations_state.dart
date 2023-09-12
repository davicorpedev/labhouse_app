part of 'radio_stations_bloc.dart';

sealed class RadioStationsState extends Equatable {
  const RadioStationsState();

  @override
  List<Object> get props => [];
}

final class RadioStationsInitialState extends RadioStationsState {}

final class RadioStationsLoadingState extends RadioStationsState {}

final class RadioStationsLoadedState extends RadioStationsState {
  final List<RadioStation> radioStations;

  const RadioStationsLoadedState({required this.radioStations});

  @override
  List<Object> get props => [radioStations];
}

final class RadioStationsErrorState extends RadioStationsState {
  final Failure failure;

  const RadioStationsErrorState({required this.failure});

  @override
  List<Object> get props => [failure];
}
