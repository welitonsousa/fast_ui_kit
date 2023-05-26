// import 'package:fast_ui_kit/fast_ui_kit.dart';
import 'package:fast_ui_kit/fast_ui_kit.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = FastTheme(seed: Colors.blue);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      darkTheme: theme.dark,
      theme: theme.light,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FastButton(
            label: 'Confirmar',
            onPressed: () {},
          ),
          Icon(FastIcons.modernPictograms.mail),
        ],
      ),
    );
  }
}
