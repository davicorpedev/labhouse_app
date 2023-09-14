import 'package:equatable/equatable.dart';
import 'package:labhouse_app/domain/entitites/id.dart';

class RadioStation extends Equatable {
  final ID<RadioStation> id;
  final String name;
  final String streamURL;
  final String image;
  final String country;

  const RadioStation({
    required this.id,
    required this.name,
    required this.streamURL,
    required this.image,
    required this.country,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        streamURL,
        image,
        country,
      ];
}
