import 'package:fast_ui_kit/extension/context.dart';
import 'package:fast_ui_kit/extension/text.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class TableItem {
  final String? title;
  final Widget? widget;

  /// width of column
  ///
  /// default is 100
  ///
  TableItem({
    this.title = '',
    this.widget,
  });
}

class TableTitleItem {
  final String? title;
  final double width;
  final Widget? widget;

  /// width of column
  ///
  /// default is 100
  TableTitleItem({
    this.title = '',
    this.widget,
    this.width = 100,
  });
}

class FastTable extends StatelessWidget {
  final List<List<TableItem>> rows;
  final List<TableTitleItem> header;
  final List<TableTitleItem> footer;

  final bool fixedHeader;
  final bool fixedFooter;

  /// ```dart
  ///  FastTable(
  ///   header: [
  ///     TableTitleItem(title: 'Name', width: 200),
  ///     TableTitleItem(title: 'Age', width: 100),
  ///     TableTitleItem(title: 'City', width: 100),
  ///   ],
  ///   rows: [
  ///   [
  ///     TableItem(title: 'John'),
  ///     TableItem(title: '30'),
  ///     TableItem(title: 'New York'),
  ///   ],
  ///   [
  ///     TableItem(title: 'John'),
  ///     TableItem(title: '30'),
  ///     TableItem(title: 'New York'),
  ///   ],
  ///   ],
  ///   footer: [
  ///     TableTitleItem(title: 'Name', width: 200),
  ///     TableTitleItem(title: 'Age', width: 100),
  ///     TableTitleItem(title: 'City', width: 100),
  ///   ],
  /// ),
  /// ```
  const FastTable({
    super.key,
    this.fixedHeader = false,
    this.fixedFooter = false,
    required this.rows,
    this.header = const [],
    this.footer = const [],
  });

  List<Widget>? _getTitleWidget(
      List<TableTitleItem> list, BuildContext context) {
    list = [TableTitleItem(title: '', width: 0), ...list];
    if (list.isEmpty) return null;
    return list.map((e) {
      return Container(
        padding: const EdgeInsets.all(10),
        width: e.width,
        child: e.widget ?? Text(e.title ?? '', style: context.H4),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return HorizontalDataTable(
      leftHandSideColBackgroundColor: context.colors.background,
      rightHandSideColBackgroundColor: context.colors.background,
      leftHandSideColumnWidth: 0,
      rightHandSideColumnWidth: header.fold(.0, (p, e) => p + e.width),
      isFixedHeader: header.isNotEmpty && fixedHeader,
      headerWidgets: _getTitleWidget(header, context),
      isFixedFooter: footer.isNotEmpty && fixedFooter,
      footerWidgets: _getTitleWidget(footer, context),
      leftSideChildren: const [],
      rightSideChildren: [
        if (header.isNotEmpty && !fixedHeader)
          Row(children: _getTitleWidget(header, context)!),
        ...List.generate(rows.length, (i) {
          return Column(
            children: [
              if (i > 0) const Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(rows[i].length, (index) {
                  return Container(
                      padding: const EdgeInsets.all(10),
                      width: header[index].width,
                      child: rows[i][index].widget ??
                          Text(rows[i][index].title ?? ''));
                }),
              ),
            ],
          );
        }),
        if (footer.isNotEmpty && !fixedFooter)
          Row(children: _getTitleWidget(footer, context)!),
      ],
      itemCount: rows.length,
      rowSeparatorWidget: Divider(color: context.colors.primary, height: 1.0),
    );
  }
}
