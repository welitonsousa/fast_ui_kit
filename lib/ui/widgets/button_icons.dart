import 'package:fast_ui_kit/fast_ui_kit.dart';
import 'package:flutter/material.dart';

class FastButtonIcon extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final bool? loading;
  final Color? background;
  final Color? color;
  final double? radius;
  final double? elevation;
  final ButtonVariant variant;

  const FastButtonIcon(
      {super.key,
      required this.icon,
      this.onPressed,
      this.loading,
      this.background,
      this.color,
      this.radius,
      this.elevation,
      this.variant = ButtonVariant.contained});

  @override
  State<FastButtonIcon> createState() => _FastButtonIconState();
}

class _FastButtonIconState extends State<FastButtonIcon> {
  ButtonStyle? get style {
    if (widget.onPressed != null) {
      return ButtonStyle(
          elevation: MaterialStateProperty.all(widget.elevation ?? 0),
          backgroundColor: MaterialStateProperty.all<Color>(bgColor),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 200),
              side: BorderSide(color: borderColor, width: 2),
            ),
          ));
    }
    return null;
  }

  Color get bgColor {
    if (widget.color != null) return widget.color!;
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
      width: 72,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: style,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
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
              Icon(
                widget.icon,
                color: textColor,
              ),
          ],
        ),
      ),
    );
  }
}
