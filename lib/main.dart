import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:labhouse_app/presentation/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const App());
}
