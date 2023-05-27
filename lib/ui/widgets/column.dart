import 'package:flutter/material.dart';

class FastColumn extends StatelessWidget {
  final List<Widget> children;
  final double xGap;
  final double yGap;
  final CrossAxisAlignment cross;
  final MainAxisAlignment main;

  const FastColumn({
    super.key,
    required this.children,
    this.xGap = 10,
    this.yGap = 10,
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
        children: [
          SizedBox(height: yGap / 2),
          ...children
              .map((e) => Padding(
                    padding: EdgeInsets.symmetric(vertical: yGap / 2),
                    child: e,
                  ))
              .toList(),
          SizedBox(height: yGap / 2),
        ],
      ),
    );
  }
}
