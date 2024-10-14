import 'package:fast_ui_kit/extension/context.dart';
import 'package:flutter/material.dart';

/// Button variants enum for [FastButton]
enum ButtonVariant { outlined, contained }

/// FastButton is a button with a lot of customizations
///
/// ```dart
/// FastButton(
///   label: 'go to PageContent',
///   onPressed: () {
///     context.push(const PageContent());
///   },
/// ),
class FastButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool? loading;
  final Color? background;
  final Color? color;
  final double? radius;
  final double? elevation;
  final ButtonVariant variant;

  /// FastButton is a button with a lot of customizations
  ///
  /// ```dart
  /// FastButton(
  ///   label: 'go to PageContent',
  ///   onPressed: () {
  ///     context.push(const PageContent());
  ///   },
  /// ),
  /// ```
  const FastButton({
    super.key,
    required this.label,
    this.onPressed,
    this.loading,
    this.background,
    this.color,
    this.radius,
    this.elevation,
    this.variant = ButtonVariant.contained,
  });

  @override
  State<FastButton> createState() => _FastButtonState();
}

class _FastButtonState extends State<FastButton> {
  ButtonStyle? get style {
    if (widget.onPressed != null) {
      return ButtonStyle(
          elevation: WidgetStateProperty.all(widget.elevation ?? 0),
          backgroundColor: WidgetStateProperty.all<Color>(bgColor),
          shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 8),
              side: BorderSide(color: borderColor, width: 2),
            ),
          ));
    }
    return null;
  }

  Color get bgColor {
    if (widget.background != null) return widget.background!;
    if (widget.variant == ButtonVariant.outlined) return Colors.transparent;
    return widget.background ?? context.button.primary;
  }

  Color get borderColor {
    if (widget.color != null) return widget.color!;
    if (widget.variant == ButtonVariant.outlined) return context.button.primary;
    return widget.background ?? Colors.transparent;
  }

  Color get textColor {
    if (widget.color != null) return widget.color!;
    if (widget.variant == ButtonVariant.outlined) return borderColor;
    return context.colors.onPrimary;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.onPressed != null
            ? () {
                if (!(widget.loading ?? false)) widget.onPressed?.call();
              }
            : null,
        style: style,
        child: Visibility(
            visible: widget.loading ?? false,
            replacement: Text(
              widget.label,
              style: TextStyle(color: textColor),
            ),
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: textColor,
              ),
            )),
      ),
    );
  }
}
