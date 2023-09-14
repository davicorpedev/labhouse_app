import 'package:flutter/material.dart';
import 'package:labhouse_app/presentation/style/theming/app_themes.dart';

extension ThemeBuilder on AppTheme {
  ThemeData get themeData {
    return ThemeData(
      fontFamily: 'Montserrat',
      primaryColor: primary,
      brightness: brightness,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: primary,
        secondary: secondary,
        brightness: brightness,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: background,
        foregroundColor: primary,
      ),
    );
  }
}
