import 'package:flutter/material.dart';

class FastTheme {
  final Color seed;
  FastTheme({required this.seed});

  ColorScheme _scheme(Brightness mode) => ColorScheme.fromSeed(
        seedColor: seed,
        primary: mode == Brightness.light ? seed.withOpacity(.8) : null,
        brightness: mode,
      );

  ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: _scheme(Brightness.dark),
      );

  ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: _scheme(Brightness.light),
      );
}
