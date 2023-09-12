import 'package:labhouse_app/data/models/radio_station_model.dart';
import 'package:labhouse_app/domain/entitites/id.dart';
import 'package:labhouse_app/domain/entitites/radio_station.dart';

final tRadioStationModelList = [
  const RadioStationModel(
    id: ID('test1'),
    name: 'TEST 1 FM',
    image: 'test1.jpg',
    streamURL: 'test1.mp3',
    homepage: 'test1.com',
  ),
  const RadioStationModel(
    id: ID('test2'),
    name: 'TEST 2 FM',
    image: 'test2.jpg',
    streamURL: 'test2.mp3',
    homepage: 'test2.com',
  ),
];

List<RadioStation> tRadioStationList = tRadioStationModelList;
