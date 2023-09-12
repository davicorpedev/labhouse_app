import 'package:equatable/equatable.dart';
import 'package:labhouse_app/domain/entitites/id.dart';

class RadioStation extends Equatable {
  final ID<RadioStation> id;
  final String name;
  final String streamURL;
  final String homepage;
  final String image;

  const RadioStation({
    required this.id,
    required this.name,
    required this.streamURL,
    required this.homepage,
    required this.image,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        streamURL,
        homepage,
        image,
      ];
}
