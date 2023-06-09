// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

/// use this extension to get text style
///
/// example:
///
/// ```dart
/// Text('data', style: context.H1)
/// ```
extension TextExt on BuildContext {
  /// use this extension to get text style
  ///
  /// example:
  ///
  /// ```dart
  /// Text('data', style: context.H1)
  /// ```
  TextStyle get H1 => const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
      );

  /// use this extension to get text style
  ///
  /// example:
  ///
  /// ```dart
  /// Text('data', style: context.H2)
  /// ```
  TextStyle get H2 => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
      );

  /// use this extension to get text style
  ///
  /// example:
  ///
  /// ```dart
  /// Text('data', style: context.H3)
  /// ```
  TextStyle get H3 => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      );

  /// use this extension to get text style
  ///
  /// example:
  ///
  /// ```dart
  /// Text('data', style: context.H4)
  /// ```
  TextStyle get H4 => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      );

  /// use this extension to get text style
  ///
  /// example:
  ///
  /// ```dart
  /// Text('data', style: context.H5)
  /// ```
  TextStyle get H5 => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      );

  /// use this extension to get text style
  ///
  /// example:
  ///
  /// ```dart
  /// Text('data', style: context.H6)
  /// ```
  TextStyle get H6 => const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      );

  /// use this extension to get text style
  ///
  /// example:
  ///
  /// ```dart
  /// Text('data', style: context.p)
  /// ```
  TextStyle get p => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      );
}
