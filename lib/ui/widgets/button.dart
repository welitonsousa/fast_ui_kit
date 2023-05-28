import 'package:fast_ui_kit/extension/context.dart';
import 'package:flutter/material.dart';

enum ButtonVariant { outlined, contained }

class FastButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool? loading;
  final Color? background;
  final Color? color;
  final double? radius;
  final double? elevation;
  final ButtonVariant variant;

  const FastButton(
      {super.key,
      required this.label,
      this.onPressed,
      this.loading,
      this.background,
      this.color,
      this.radius,
      this.elevation,
      this.variant = ButtonVariant.contained});

  @override
  State<FastButton> createState() => _FastButtonState();
}

class _FastButtonState extends State<FastButton> {
  ButtonStyle? get style {
    if (widget.onPressed != null) {
      return ButtonStyle(
          elevation: MaterialStateProperty.all(widget.elevation ?? 0),
          backgroundColor: MaterialStateProperty.all<Color>(bgColor),
          shape: MaterialStateProperty.all<OutlinedBorder>(
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
    return widget.background ?? context.colors.primary;
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
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: style,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.loading ?? false)
              SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: textColor,
                ),
              ),
            if (!(widget.loading ?? false))
              Text(
                widget.label,
                style: TextStyle(color: textColor),
              ),
          ],
        ),
      ),
    );
  }
}
