import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labhouse_app/application/radio_station_detail/radio_station_detail_bloc.dart';
import 'package:labhouse_app/presentation/style/theming/app_themes.dart';

class RadioVolumeSlider extends StatelessWidget {
  const RadioVolumeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RadioStationDetailBloc, RadioStationDetailState>(
      buildWhen: (previous, current) => previous.volume != current.volume,
      builder: (context, state) {
        return Slider(
          value: state.volume,
          activeColor: context.read<AppTheme>().primary,
          onChanged: (volume) {
            context
                .read<RadioStationDetailBloc>()
                .add(SetVolumeRadioEvent(volume: volume));
          },
        );
      },
    );
  }
}
