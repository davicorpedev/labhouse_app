part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitialState extends HomeState {}

final class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<RadioStation> radioStations;

  const HomeLoadedState({required this.radioStations});

  @override
  List<Object> get props => [radioStations];
}

class HomeErrorState extends HomeState {
  final Failure failure;

  const HomeErrorState({required this.failure});

  @override
  List<Object> get props => [failure];
}
