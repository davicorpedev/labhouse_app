import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labhouse_app/application/radio_stations/radio_stations_bloc.dart';
import 'package:labhouse_app/domain/repositories/radio_station_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final RadioStationsBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = RadioStationsBloc(
      repository: RepositoryProvider.of<RadioStationRepository>(context),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: const HomePageBody(),
    );
  }
}

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  void initState() {
    super.initState();

    context.read<RadioStationsBloc>().add(GetRadioStationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<RadioStationsBloc, RadioStationsState>(
      builder: (context, state) {
        switch (state) {
          case RadioStationsInitialState():
          case RadioStationsLoadingState():
            return const Center(child: CircularProgressIndicator());

          case RadioStationsLoadedState():
            return Center(
                child: Text(state.radioStations.map((e) => e.name).toString()));
          case RadioStationsErrorState():
            return const Center(child: Text('error'));
        }
      },
    ));
  }
}
