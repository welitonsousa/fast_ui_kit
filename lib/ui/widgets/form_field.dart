import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
export 'package:mask/mask.dart';
export 'package:mask/validations/validations.dart';
export 'package:zod_validation/zod_validation.dart';

class FastFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final Widget? prefix;
  final Widget? suffix;
  final bool? isPassword;
  final bool? autoFocus;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? mask;
  final int maxLines;
  final int minLines;

  const FastFormField({
    super.key,
    this.label,
    this.onChanged,
    this.autoFocus,
    this.hint,
    this.prefix,
    this.suffix,
    this.isPassword,
    this.controller,
    this.validator,
    this.onFieldSubmitted,
    this.textInputType,
    this.textInputAction,
    this.mask,
    this.maxLines = 1,
    this.minLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: isPassword ?? false,
      controller: controller,
      inputFormatters: mask,
      onChanged: onChanged,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: textInputType,
      maxLines: maxLines,
      minLines: minLines,
      validator: validator,
      autofocus: autoFocus ?? false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        hintText: hint,
        prefixIcon: prefix,
        suffixIcon: suffix,
      ),
    );
  }
}
