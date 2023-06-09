import 'package:flutter/material.dart';

class FastRow extends StatelessWidget {
  final List<Widget> children;
  final double xGap;
  final double yGap;
  final CrossAxisAlignment cross;
  final MainAxisAlignment main;
  final bool extreme;

  /// [FastRow] is a widget that allows you to create a row with a gap between the widgets.
  ///
  /// [children] is a list of widgets that will be displayed in the row.
  ///
  /// [xGap] is the horizontal gap between the widgets.
  ///
  /// [yGap] is the vertical gap between the widgets.
  ///
  /// [cross] is the alignment of the widgets in the row.
  ///
  /// [main] is the alignment of the row.
  ///
  /// [extreme] is a boolean that defines whether the row will have a gap at the beginning and end.
  ///
  /// Example:
  ///
  /// ```dart
  /// FastRow(
  ///  children: [
  ///     Icon(FastIcons.ant.profile),
  ///     Text(v.toString()),
  ///   ],
  /// ),
  /// ```
  const FastRow({
    super.key,
    required this.children,
    this.yGap = 0,
    this.xGap = 10,
    this.extreme = false,
    this.cross = CrossAxisAlignment.start,
    this.main = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: yGap),
      child: Row(
        mainAxisAlignment: main,
        crossAxisAlignment: cross,
        children: [
          if (extreme) SizedBox(width: xGap / 2),
          ...children
              .map((e) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: xGap / 2),
                    child: e,
                  ))
              .toList(),
          if (extreme) SizedBox(width: xGap / 2),
        ],
      ),
    );
  }
}
