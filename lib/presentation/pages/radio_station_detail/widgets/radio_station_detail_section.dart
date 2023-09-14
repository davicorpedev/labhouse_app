import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labhouse_app/application/radio_station_detail/radio_station_detail_bloc.dart';
import 'package:labhouse_app/presentation/pages/radio_station_detail/widgets/radio_controls.dart';
import 'package:labhouse_app/presentation/pages/radio_station_detail/widgets/radio_volume_slider.dart';
import 'package:labhouse_app/presentation/style/theming/app_themes.dart';

class RadioStationDetailSection extends StatelessWidget {
  const RadioStationDetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    final radioStation = context.read<RadioStationDetailBloc>().radioStation;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _Image(
          image: radioStation.image,
          size: 160,
        ),
        Column(
          children: [
            Text(
              radioStation.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              radioStation.country,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            children: [
              Icon(
                Icons.volume_down_sharp,
                color: context.read<AppTheme>().primary,
              ),
              const Expanded(
                child: RadioVolumeSlider(),
              ),
            ],
          ),
        ),
        Column(
          children: [
            const RadioControls(),
            const SizedBox(height: 16),
            _CurrentPosition(),
          ],
        )
      ],
    );
  }
}

class _CurrentPosition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RadioStationDetailBloc, RadioStationDetailState>(
      buildWhen: (previous, current) =>
          previous.currenPosition != current.currenPosition,
      builder: (context, state) {
        return Text(
          state.currenPosition.toString().substring(2, 7),
          style: Theme.of(context).textTheme.bodyLarge,
        );
      },
    );
  }
}

class _Image extends StatelessWidget {
  final String image;
  final double size;

  const _Image({
    required this.image,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    if (image.isNotEmpty) {
      return Image.network(
        image,
        width: size,
        height: size,
        fit: BoxFit.contain,
      );
    } else {
      return Icon(
        Icons.radio_rounded,
        size: size,
      );
    }
  }
}
