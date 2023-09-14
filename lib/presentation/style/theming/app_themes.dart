import 'package:flutter/material.dart';

abstract class AppTheme {
  late final Color primary;
  late final Color secondary;
  late final Color background;
  late final Brightness brightness;
}

class DarkTheme implements AppTheme {
  @override
  Color primary = Colors.white;

  @override
  Color background = Colors.transparent;

  @override
  Color secondary = const Color(0xffe22255);

  @override
  Brightness brightness = Brightness.dark;
}
