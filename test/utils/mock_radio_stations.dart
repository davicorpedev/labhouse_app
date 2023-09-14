import 'package:labhouse_app/data/models/radio_station_model.dart';
import 'package:labhouse_app/domain/entitites/id.dart';
import 'package:labhouse_app/domain/entitites/radio_station.dart';

const tRadioStationModel = RadioStationModel(
  id: ID('test'),
  name: 'TEST FM',
  image: 'test.jpg',
  streamURL: 'test.mp3',
  country: 'test',
);

final tRadioStationModelList = [
  const RadioStationModel(
    id: ID('test1'),
    name: 'TEST 1 FM',
    image: 'test1.jpg',
    streamURL: 'test1.mp3',
    country: 'test',
  ),
  const RadioStationModel(
    id: ID('test2'),
    name: 'TEST 2 FM',
    image: 'test2.jpg',
    streamURL: 'test2.mp3',
    country: 'test',
  ),
];

List<RadioStation> tRadioStationList = tRadioStationModelList;
