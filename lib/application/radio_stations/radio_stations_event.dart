part of 'radio_stations_bloc.dart';

sealed class RadioStationsEvent extends Equatable {
  const RadioStationsEvent();

  @override
  List<Object> get props => [];
}

class GetRadioStationsEvent extends RadioStationsEvent {}
