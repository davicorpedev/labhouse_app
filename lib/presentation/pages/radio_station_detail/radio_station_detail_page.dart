import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labhouse_app/application/radio_station_detail/radio_station_detail_bloc.dart';
import 'package:labhouse_app/domain/entitites/radio_station.dart';
import 'package:labhouse_app/domain/repositories/radio_player_repository.dart';
import 'package:labhouse_app/domain/utils/radio_player.dart';
import 'package:labhouse_app/presentation/pages/radio_station_detail/widgets/radio_station_detail_section.dart';
import 'package:labhouse_app/presentation/widgets/background.dart';

class RadioStationDetailPage extends StatefulWidget {
  final RadioStation radioStation;

  const RadioStationDetailPage({super.key, required this.radioStation});

  @override
  State<RadioStationDetailPage> createState() => _RadioStationDetailPageState();
}

class _RadioStationDetailPageState extends State<RadioStationDetailPage> {
  late final RadioStationDetailBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = RadioStationDetailBloc(
      radioStation: widget.radioStation,
      repository: RadioPlayerRepositoryImpl(
        radioPlayer: RadioPlayerImpl(
          assetsAudioPlayer: AssetsAudioPlayer(),
        ),
      ),
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
      child: const RadioStationDetailBody(),
    );
  }
}

class RadioStationDetailBody extends StatefulWidget {
  const RadioStationDetailBody({super.key});

  @override
  State<RadioStationDetailBody> createState() => _RadioStationDetailBodyState();
}

class _RadioStationDetailBodyState extends State<RadioStationDetailBody> {
  @override
  void initState() {
    context.read<RadioStationDetailBloc>().add(StartRadioEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Radio'),
        ),
        body: BlocBuilder<RadioStationDetailBloc, RadioStationDetailState>(
          buildWhen: (previous, current) =>
              previous.loadingState != current.loadingState,
          builder: (context, state) {
            if (state.isLoaded) {
              return const RadioStationDetailSection();
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
