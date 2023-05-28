import 'package:flutter/material.dart';

extension TextExt on BuildContext {
  TextStyle get H1 => const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
      );
  TextStyle get H2 => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
      );
  TextStyle get H3 => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      );
  TextStyle get H4 => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      );
  TextStyle get H5 => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      );
  TextStyle get H6 => const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      );

  TextStyle get p => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      );
}
