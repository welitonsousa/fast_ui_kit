import 'package:fast_ui_kit/extentions/context.dart';
import 'package:flutter/material.dart';

class FastButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool? loading;
  final Color? background;
  final Color? color;
  final double? radius;

  const FastButton({
    super.key,
    required this.label,
    this.onPressed,
    this.loading,
    this.background,
    this.color,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: onPressed == null
          ? null
          : ButtonStyle(
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? 8),
              )),
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all<Color>(
                  background ?? context.colors.primary),
            ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (loading ?? false)
            SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: context.colors.onPrimary,
              ),
            ),
          if (!(loading ?? false))
            Text(
              label,
              style: TextStyle(color: color ?? context.colors.onPrimary),
            ),
        ],
      ),
    );
  }
}
