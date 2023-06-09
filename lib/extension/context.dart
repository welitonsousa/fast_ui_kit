import 'package:flutter/material.dart';

/// use this extension to get application style
extension ColorExt on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  ThemeData get theme => Theme.of(this);
  ColorScheme get button => Theme.of(this).buttonTheme.colorScheme!;
  Brightness get brightness => Theme.of(this).brightness;
}
