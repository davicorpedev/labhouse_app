import 'package:flutter/material.dart';
import 'package:labhouse_app/presentation/style/theming/app_themes.dart';

extension ThemeBuilder on AppTheme {
  ThemeData get themeData {
    return ThemeData(
      primaryColor: primary,
      brightness: brightness,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primary,
        secondary: secondary,
      ),
    );
  }
}
