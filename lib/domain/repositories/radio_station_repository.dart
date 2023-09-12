import 'package:labhouse_app/data/client/api_client.dart';
import 'package:labhouse_app/data/error/exceptions.dart';
import 'package:labhouse_app/domain/entitites/radio_station.dart';
import 'package:labhouse_app/domain/entitites/result.dart';
import 'package:labhouse_app/domain/error/failures.dart';
import 'package:labhouse_app/domain/utils/network_info.dart';

abstract class RadioStationRepository {
  Future<Result<List<RadioStation>>> getRadioStations();
}

class RadioStationRepositoryImpl extends RadioStationRepository {
  final NetworkInfo _networkInfo;
  final ApiClient _apiClient;

  RadioStationRepositoryImpl({
    required NetworkInfo networkInfo,
    required ApiClient apiClient,
  })  : _networkInfo = networkInfo,
        _apiClient = apiClient;

  @override
  Future<Result<List<RadioStation>>> getRadioStations() async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _apiClient.getRadioStations();

        return Result.success(result);
      } on ServerException {
        return Result.error(ServerFailure());
      }
    } else {
      return Result.error(NetworkFailure());
    }
  }
}
