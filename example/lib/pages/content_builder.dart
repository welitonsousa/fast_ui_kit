import 'package:fast_ui_kit/fast_ui_kit.dart';
import 'package:flutter/material.dart';

class PageContent extends StatelessWidget {
  const PageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FastContentBuilder(
        maxWidth: 800,
        itemCount: 100,
        builder: (c, index) {
          return Text(index.toString());
        },
      ),
    );
  }
}
