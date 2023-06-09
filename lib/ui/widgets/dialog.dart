import 'package:fast_ui_kit/fast_ui_kit.dart';
import 'package:flutter/material.dart';

class FastDialog extends StatelessWidget {
  final double maxWidth;
  final String? title;
  final List<Widget> children;
  final double radius;

  /// [FastDialog] is a widget that can be used to create a dialog with a
  /// custom width and radius.
  ///
  /// [maxWidth] is the maximum width of the dialog.
  ///
  /// [radius] is the radius of the dialog.
  ///
  /// [title] is the title of the dialog.
  ///
  /// [children] is the content of the dialog.
  ///
  /// [key] is the key of the widget.
  ///
  /// Example:
  ///
  /// ```dart
  /// FastDialog(
  ///   title: 'Title',
  ///   maxWidth: 500,
  ///   radius: 20,
  ///   children: [
  ///     Text('Content'),
  ///   ],
  /// )
  /// ```
  const FastDialog({
    super.key,
    required this.children,
    this.maxWidth = 400,
    this.radius = 12,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: SizedBox(
          width: maxWidth,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FastContent(
                  children: [
                    if (title != null)
                      Center(child: Text(title!, style: context.H2)),
                    ...children,
                  ],
                ),
                const SizedBox(height: 5)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
