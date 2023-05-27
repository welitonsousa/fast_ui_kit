import 'package:fast_ui_kit/fast_ui_kit.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = FastTheme(seed: Colors.purple);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      body: ListView(
        children: [
          FastRow(
            children: [
              Icon(FastIcons.evil.eye, size: 40),
              Icon(FastIcons.ant.CodeSandbox, size: 40),
              Icon(FastIcons.awesome.facebook_square, size: 40),
              Icon(FastIcons.awesome.whatsapp, size: 40),
            ],
          ),
          FastColumn(
            xGap: 10,
            yGap: 10,
            children: [
              FastButton(
                label: 'Confirmar',
                onPressed: () {},
                variant: ButtonVariant.outlined,
              ),
              const FastSkeleton(),
              const FastRow(
                children: [
                  FastImg(
                    path: 'https://github.com/welitonsousa.png',
                    width: 60,
                  ),
                  FastAvatar(path: 'https://github.com/welitonsousa.png'),
                ],
              ),
              FastFormField(
                minLines: 1,
                validator: Mask.validations.cpf,
                // validator: Zod().cpf().build,
                mask: [
                  Mask.cpf(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
