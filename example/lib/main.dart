import 'package:example/pages/content_builder.dart';
import 'package:example/pages/table_page.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FastSearchAppBar(
        title: "Fast UI Kit",
        onSearch: (v) {},
      ),
      body: FastContent(
        children: [
          FastAnimate(
            type: FastAnimateType.fadeInDownBig,
            child: FastRow(
              children: [
                Icon(FastIcons.maki.airport, size: 40),
                Icon(FastIcons.ant.CodeSandbox, size: 40),
                Icon(FastIcons.awesome.facebook_square, size: 40),
                Icon(FastIcons.elico.chrome, size: 40),
              ],
            ),
          ),
          FastColumn(
            xGap: 10,
            yGap: 10,
            children: [
              const FastFormFieldFile(),
              const FastFormFieldFile(showFileType: ShowFileType.bigIcon),
              const FastFormFieldFile(
                  showFileType: ShowFileType.bigIconOrPreviewWhenImage,
                  accepts: ['pdf']),
              const FastFormFieldFile(showFileType: ShowFileType.iconAndName),
              FastButtonIcon(
                icon: FastIcons.modernPictograms.pencil,
                variant: ButtonVariant.outlined,
                loading: false,
                onPressed: () {
                  context.showMessage(
                    'Algo foi alterado com sucesso',
                    title: 'Sucesso',
                    type: MessageVariant.success,
                    position: MessagePosition.bottom,
                    style: Style.flat,
                  );
                },
              ),
              FastButton(
                label: 'Confirmar',
                // variant: ButtonVariant.outlined,
                onPressed: () {
                  context.showMessage(
                    'Algo deu errado',
                    title: 'Erro',
                    position: MessagePosition.bottom,
                    type: MessageVariant.error,
                    style: Style.raised,
                  );
                },
              ),
              const Row(
                children: [
                  SizedBox(width: 50, child: FastSkeleton(radius: 100)),
                  SizedBox(width: 10),
                  Expanded(child: FastSkeleton()),
                ],
              ),
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
                label: "CPF",
                validator: Mask.validations.cpf,
                mask: [
                  Mask.cpf(),
                ],
              ),
              Text('Text H1', style: context.H1),
              Text('Text H2', style: context.H2),
              Text('Text H3', style: context.H3),
              Text('Text H4', style: context.H4),
              Text('Text H5', style: context.H5),
              Text('Text H6', style: context.H6),
              Text('Text P - Paragraph', style: context.p),
              FastButton(
                label: 'go to list builder',
                onPressed: () {
                  context.push(const PageContent());
                },
              ),
              const FastButton(
                label: 'File Picker',
                onPressed: FastPickerService.picker,
              ),
              FastDropDown(
                items: const [1, 2, 3, 4],
                hint: 'Selecione o numero',
                itemBuilder: (v) {
                  return FastRow(
                    children: [
                      Icon(FastIcons.ant.profile),
                      Text(v.toString()),
                    ],
                  );
                },
              ),
              FastButtonGroup<Style>(
                callback: (v) {},
                values: Style.values,
                initial: const [],
              ),
              FastButton(
                label: 'table page',
                onPressed: () {
                  context.push(const TablePage());
                },
              ),
              const FastCalendar(
                rangeMode: false,
              ),
              const FastAudio(
                  url:
                      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3'),
              FastButton(
                label: 'Dialog',
                onPressed: () {
                  context.dialog(
                    FastDialog(
                      title: 'Help',
                      children: [
                        const Text('Dialog'),
                        const Text('Dialog'),
                        const Text('Dialog'),
                        const FastAudio(
                            url:
                                'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3'),
                        FastButton(
                          label: 'Cancel',
                          onPressed: context.pop,
                          background: Colors.red,
                        ),
                      ],
                    ),
                  );

                  setState(() {});
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
