import 'package:flutter/material.dart';

class FastTheme {
  final Color seed;
  FastTheme({required this.seed});

  ColorScheme _scheme(Brightness mode) => ColorScheme.fromSeed(
        seedColor: seed,
        primary: mode == Brightness.light ? seed.withOpacity(.8) : null,
        brightness: mode,
      );

  ThemeData _defineTheme(Brightness mode) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _scheme(mode),
      appBarTheme: const AppBarTheme(centerTitle: true),
    );
  }

  ThemeData get dark => _defineTheme(Brightness.dark);
  ThemeData get light => _defineTheme(Brightness.light);
}
