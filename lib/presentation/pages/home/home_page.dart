import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labhouse_app/application/home/home_bloc.dart';
import 'package:labhouse_app/domain/repositories/radio_station_repository.dart';
import 'package:labhouse_app/presentation/pages/home/widgets/radio_stations_grid.dart';
import 'package:labhouse_app/presentation/widgets/app_error.dart';
import 'package:labhouse_app/presentation/widgets/background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = HomeBloc(
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
      child: const HomeBody(),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    super.initState();

    context.read<HomeBloc>().add(GetRadioStationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'We have prepared a list of the greatest radio stations of the world.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Choose one and enjoy their amazing content.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    switch (state) {
                      case HomeInitialState():
                      case HomeLoadingState():
                        return const SliverFillRemaining(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      case HomeLoadedState():
                        return RadioStationsGrid(
                          radioStations: state.radioStations,
                        );
                      case HomeErrorState():
                        return SliverFillRemaining(
                          child: Center(
                            child: AppError(
                              description: 'Err',
                              refresh: () => context.read<HomeBloc>().add(
                                    GetRadioStationsEvent(),
                                  ),
                            ),
                          ),
                        );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
