import 'package:flutter/material.dart';

abstract class AppTheme {
  late final Color primary;
  late final Color secondary;
  late final Brightness brightness;
}

class LightTheme implements AppTheme {
  @override
  Color primary = const Color(0xFFf0e4b1);

  @override
  Color secondary = const Color(0xFF5a3a1a);

  @override
  Brightness brightness = Brightness.light;
}
