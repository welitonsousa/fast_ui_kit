import 'package:flutter/material.dart';

/// use this extension to get screen size
extension SizesExt on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;
}
