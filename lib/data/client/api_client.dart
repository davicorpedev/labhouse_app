import 'dart:convert';

import 'package:labhouse_app/data/client/api_requester.dart';
import 'package:labhouse_app/data/models/radio_station_model.dart';

abstract class ApiClient {
  Future<List<RadioStationModel>> getRadioStations();
}

class LiveApiClient implements ApiClient {
  final ApiRequester _apiRequester;

  LiveApiClient({
    required ApiRequester apiRequester,
  }) : _apiRequester = apiRequester;

  @override
  Future<List<RadioStationModel>> getRadioStations() async {
    final response = await _apiRequester.get(
      path: 'stations',
      queryParameters: {
        'limit': '20',
      },
    );

    final decodedResponse = json.decode(response.body);

    return decodedResponse
        .map<RadioStationModel>(
          (radioStation) => RadioStationModel.fromJson(radioStation),
        )
        .toList();
  }
}
