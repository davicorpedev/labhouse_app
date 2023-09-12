import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:labhouse_app/data/client/api_client.dart';
import 'package:labhouse_app/domain/repositories/radio_station_repository.dart';
import 'package:labhouse_app/domain/utils/network_info.dart';
import 'package:provider/provider.dart';

class RepositoryBuilder extends StatelessWidget {
  final ApiClient apiClient;
  final Widget child;

  const RepositoryBuilder({
    Key? key,
    required this.child,
    required this.apiClient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider<RadioStationRepository>(
          create: (context) => RadioStationRepositoryImpl(
            apiClient: apiClient,
            networkInfo: NetworkInfoImpl(
              connectionChecker: InternetConnectionChecker(),
            ),
          ),
        ),
      ],
      child: child,
    );
  }
}
