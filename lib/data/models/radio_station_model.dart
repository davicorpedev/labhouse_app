import 'package:labhouse_app/domain/entitites/id.dart';
import 'package:labhouse_app/domain/entitites/radio_station.dart';

class RadioStationModel extends RadioStation {
  const RadioStationModel({
    required super.id,
    required super.name,
    required super.streamURL,
    required super.image,
    required super.country,
  });

  factory RadioStationModel.fromJson(Map<String, dynamic> json) {
    return RadioStationModel(
      id: ID(json['stationuuid']),
      name: json['name'],
      streamURL: json['url'],
      image: json['favicon'],
      country: json['country'],
    );
  }
}
