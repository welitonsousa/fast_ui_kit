import 'package:fast_ui_kit/fast_ui_kit.dart';
import 'package:flutter/material.dart';

class FastDropDown<T> extends StatelessWidget {
  final Zod? validation;
  final List<T> items;
  final String? hint;
  final void Function(T?)? onChanged;
  final Widget Function(T)? itemBuilder;
  final T? value;
  final bool showClearButton;
  final Widget? clearButton;
  final double radius;

  /// use this widget to create a dropdown
  ///
  /// example:
  ///
  /// ```dart
  /// FastDropDown(
  ///   items: const [1, 2, 3, 4],
  ///   hint: 'Selecione o numero',
  ///   itemBuilder: (v) {
  ///    return FastRow(
  ///     children: [
  ///       Icon(FastIcons.ant.profile),
  ///       Text(v.toString()),
  ///     ],
  ///   );},
  /// ),
  /// ```
  const FastDropDown({
    super.key,
    this.hint,
    this.value,
    this.radius = 8,
    this.onChanged,
    this.validation,
    this.clearButton,
    this.showClearButton = true,
    this.itemBuilder,
    required this.items,
  });

  Widget? get icon {
    if (value != null) {
      if (showClearButton || clearButton != null) {
        return GestureDetector(
          onTap: () => onChanged?.call(null),
          child: clearButton ?? const Icon(Icons.clear),
        );
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      elevation: 0,
      value: value,
      isExpanded: true,
      hint: hint != null ? Text(hint!) : null,
      enableFeedback: true,
      icon: icon,
      focusColor: Colors.transparent,
      decoration: InputDecoration(
        filled: false,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
      ),
      items: items.map((e) {
        return DropdownMenuItem(
          value: e,
          child: Center(
            child: itemBuilder?.call(e) ??
                Text(
                  e.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
          ),
        );
      }).toList(),
      validator: validation?.build,
      onChanged: onChanged ?? (v) {},
    );
  }
}
