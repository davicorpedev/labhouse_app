import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labhouse_app/application/radio_station_detail/radio_station_detail_bloc.dart';
import 'package:labhouse_app/presentation/style/theming/app_themes.dart';

class RadioControls extends StatefulWidget {
  const RadioControls({super.key});

  @override
  State<RadioControls> createState() => _RadioControlsState();
}

class _RadioControlsState extends State<RadioControls>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RadioStationDetailBloc, RadioStationDetailState>(
      buildWhen: (previous, current) => previous.isPlaying != current.isPlaying,
      listenWhen: (previous, current) =>
          previous.isPlaying != current.isPlaying,
      listener: (context, state) {
        if (state.isPlaying) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if (state.isPlaying) {
              context.read<RadioStationDetailBloc>().add(PauseRadioEvent());
            } else {
              context.read<RadioStationDetailBloc>().add(PlayRadioEvent());
            }
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.read<AppTheme>().primary,
            ),
            child: Center(
              child: AnimatedIcon(
                icon: AnimatedIcons.pause_play,
                color: context.read<AppTheme>().secondary,
                progress: _animation,
              ),
            ),
          ),
        );
      },
    );
  }
}
