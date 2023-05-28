import 'package:flutter/material.dart';

class FastRow extends StatelessWidget {
  final List<Widget> children;
  final double xGap;
  final double yGap;
  final CrossAxisAlignment cross;
  final MainAxisAlignment main;
  final bool extreme;
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
