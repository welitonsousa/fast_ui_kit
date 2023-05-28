import 'package:fast_ui_kit/fast_ui_kit.dart';
import 'package:flutter/material.dart';

class FastDropDown<T> extends StatelessWidget {
  final Zod? validation;
  final List<T> items;
  final String? hint;
  final void Function(T?)? onChanged;
  final Widget Function(T)? itemBuilder;
  final T? value;

  const FastDropDown({
    super.key,
    this.hint,
    this.value,
    this.onChanged,
    this.validation,
    this.itemBuilder,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      elevation: 0,
      value: value,
      hint: hint != null ? Text(hint!) : null,
      enableFeedback: true,
      focusColor: Colors.transparent,
      decoration: const InputDecoration(
        filled: false,
        border: OutlineInputBorder(),
      ),
      items: items.map((e) {
        return DropdownMenuItem(
          value: e,
          child: itemBuilder?.call(e) ?? Text(e.toString()),
        );
      }).toList(),
      validator: validation?.build,
      onChanged: onChanged ?? (v) {},
    );
  }
}
