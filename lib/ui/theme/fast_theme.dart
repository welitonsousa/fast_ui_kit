import 'package:flutter/material.dart';

class FastTheme {
  final Color seed;
  final String? font;
  FastTheme({required this.seed, this.font});

  ColorScheme _scheme(Brightness mode) => ColorScheme.fromSeed(
        seedColor: seed,
        primary: mode == Brightness.light ? seed.withOpacity(.8) : null,
        brightness: mode,
      );

  ThemeData _defineTheme(Brightness mode) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _scheme(mode),
      fontFamily: font,
      appBarTheme: const AppBarTheme(centerTitle: true),
    );
  }

  ThemeData get dark => _defineTheme(Brightness.dark);
  ThemeData get light => _defineTheme(Brightness.light);
}
