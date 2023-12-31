import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:labhouse_app/data/models/radio_station_model.dart';
import 'package:labhouse_app/domain/entitites/radio_station.dart';

import '../../fixtures/fixture_reader.dart';
import '../../utils/mock_radio_stations.dart';

void main() {
  test(
    'should be a subclass of RadioStation Entity',
    () async {
      expect(tRadioStationModel, isA<RadioStation>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid object',
      () async {
        final Map<String, dynamic> jsonMap = json.decode(
          fixture('station.json'),
        );

        final result = RadioStationModel.fromJson(jsonMap);

        expect(result, tRadioStationModel);
      },
    );
  });
}
