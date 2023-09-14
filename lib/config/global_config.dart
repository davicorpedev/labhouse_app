import 'package:global_configs/global_configs.dart';

class AppGlobalConfig {
  Future<void> setupConfiguration() async {
    await GlobalConfigs().loadJsonFromdir('config/config.json');
  }

  String get baseUrl {
    return GlobalConfigs().get('base_url');
  }

  String get format {
    return GlobalConfigs().get('format');
  }
}
