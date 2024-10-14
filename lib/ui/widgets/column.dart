import 'package:flutter/material.dart';

class FastColumn extends StatelessWidget {
  final List<Widget> children;
  final double xGap;
  final double yGap;
  final bool extreme;
  final MainAxisSize size;
  final CrossAxisAlignment cross;
  final MainAxisAlignment main;

  /// [FastColumn] is a widget that allows you to create a column with a
  /// predefined gap between the children.
  ///
  /// [children] is a list of widgets that will be displayed in the column.
  ///
  /// [xGap] is the horizontal gap between the children.
  ///
  const FastColumn({
    super.key,
    required this.children,
    this.xGap = 10,
    this.yGap = 10,
    this.extreme = false,
    this.size = MainAxisSize.max,
    this.cross = CrossAxisAlignment.start,
    this.main = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: xGap),
      child: Column(
        crossAxisAlignment: cross,
        mainAxisAlignment: main,
        mainAxisSize: size,
        children: [
          if (extreme) SizedBox(height: yGap / 2),
          ...children.map((e) => Padding(
                padding: EdgeInsets.symmetric(vertical: yGap / 2),
                child: e,
              )),
          if (extreme) SizedBox(height: yGap / 2),
        ],
      ),
    );
  }
}
