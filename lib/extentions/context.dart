import 'package:flutter/material.dart';

extension ColorExt on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  ThemeData get theme => Theme.of(this);
  ColorScheme get button => Theme.of(this).buttonTheme.colorScheme!;
}
