import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:labhouse_app/config/global_config.dart';
import 'package:labhouse_app/data/client/api_client.dart';
import 'package:labhouse_app/data/client/api_requester.dart';
import 'package:labhouse_app/presentation/app_initializer.dart';
import 'package:labhouse_app/presentation/pages/home_page.dart';
import 'package:labhouse_app/presentation/repository_builder.dart';
import 'package:labhouse_app/presentation/style/theming/app_themes.dart';
import 'package:labhouse_app/presentation/style/theming/theme_builder.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final ApiClient _apiClient;
  late final AppTheme _appTheme;

  @override
  void initState() {
    _appTheme = LightTheme();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LabHouse Radio App',
      theme: _appTheme.themeData,
      builder: (context, widget) {
        return Provider<AppTheme>.value(
          value: _appTheme,
          child: AppInitializer(
            initializeTasks: () async {
              await _setupConfiguration();
            },
            initalizedBuilder: (context) => Provider<ApiClient>.value(
              value: _apiClient,
              child: RepositoryBuilder(
                apiClient: _apiClient,
                child: const HomePage(),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _setupConfiguration() async {
    final config = AppGlobalConfig();

    await config.setupConfiguration();

    _apiClient = LiveApiClient(
      apiRequester: HttpApiRequester(
        client: http.Client(),
        baseUrl: config.baseUrl,
        format: config.format,
      ),
    );
  }
}
