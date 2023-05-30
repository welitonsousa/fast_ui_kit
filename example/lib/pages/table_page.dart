import 'package:fast_ui_kit/fast_ui_kit.dart';
import 'package:flutter/material.dart';

class TablePage extends StatelessWidget {
  const TablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fast table')),
      body: FastTable(
        fixedHeader: true,
        fixedFooter: true,
        footer: [
          TableTitleItem(title: 'Nome'),
          TableTitleItem(title: 'Idade'),
          TableTitleItem(title: 'Sexo'),
          TableTitleItem(title: 'outra coisa', width: 200),
        ],
        header: [
          TableTitleItem(title: 'Nome'),
          TableTitleItem(title: 'Idade'),
          TableTitleItem(title: 'Sexo'),
          TableTitleItem(title: 'outra coisa', width: 200),
        ],
        rows: [
          ...List.generate(100, (index) {
            return [
              TableItem(title: 'Nome $index'),
              TableItem(title: '23'),
              TableItem(title: 'Masculino'),
              TableItem(title: 'Masculino asd as s s as'),
            ];
          })
        ],
      ),
    );
  }
}
