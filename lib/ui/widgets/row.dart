import 'package:flutter/material.dart';

class FastRow extends StatelessWidget {
  final List<Widget> children;
  final double xGap;
  final double yGap;

  const FastRow({
    super.key,
    required this.children,
    this.yGap = 10,
    this.xGap = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: xGap),
      child: Row(
        children: [
          SizedBox(width: xGap / 2),
          ...children
              .map((e) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: xGap / 2),
                    child: e,
                  ))
              .toList(),
          SizedBox(width: xGap / 2),
        ],
      ),
    );
  }
}
