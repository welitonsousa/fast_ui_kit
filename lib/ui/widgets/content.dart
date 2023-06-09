import 'package:fast_ui_kit/fast_ui_kit.dart';
import 'package:flutter/material.dart';

class FastContent extends StatelessWidget {
  final List<Widget> children;
  final double maxWidth;

  /// [maxWidth] default is 800
  /// [children] is required
  /// [FastContent] is a widget to wrap your content
  const FastContent({super.key, required this.children, this.maxWidth = 800});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Align(
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: FastColumn(
            cross: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      ),
    );
  }
}

class FastContentBuilder extends StatelessWidget {
  final double maxWidth;
  final int itemCount;
  final Widget Function(BuildContext context, int index) builder;
  const FastContentBuilder({
    super.key,
    this.maxWidth = 800,
    required this.itemCount,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (c, i) => FastContent(
        maxWidth: maxWidth,
        children: [
          builder(c, i),
        ],
      ),
      itemCount: itemCount,
    );
  }
}
