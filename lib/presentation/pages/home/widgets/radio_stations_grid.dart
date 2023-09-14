import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labhouse_app/domain/entitites/radio_station.dart';
import 'package:labhouse_app/presentation/pages/radio_station_detail/radio_station_detail_page.dart';
import 'package:labhouse_app/presentation/style/theming/app_themes.dart';
import 'package:labhouse_app/presentation/utils/navigator.dart';

class RadioStationsGrid extends StatelessWidget {
  final List<RadioStation> radioStations;

  const RadioStationsGrid({super.key, required this.radioStations});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      crossAxisCount: 2,
      childAspectRatio: 0.8,
      children: radioStations
          .map((radioStation) => _Card(radioStation: radioStation))
          .toList(),
    );
  }
}

class _Card extends StatelessWidget {
  final RadioStation radioStation;

  const _Card({required this.radioStation});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(24)),
      child: GestureDetector(
        onTap: () {
          AppNavigator.navigateTo(
            context: context,
            page: RadioStationDetailPage(radioStation: radioStation),
          );
        },
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              if (radioStation.image.isNotEmpty)
                Positioned.fill(
                  child: Image.network(
                    radioStation.image,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Positioned.fill(
                  child: Icon(
                    Icons.radio_rounded,
                    size: 80,
                    color: context.read<AppTheme>().secondary,
                  ),
                ),
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Colors.transparent,
                        Colors.black54,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      radioStation.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      radioStation.country,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
