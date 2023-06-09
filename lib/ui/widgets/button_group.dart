import 'package:fast_ui_kit/fast_ui_kit.dart';
import 'package:flutter/material.dart';

/// FastButtonGroup
///
/// example:
///
/// ```dart
/// FastButtonGroup<String>(
///   callback: (v) {},
///   values: const ['Test 1', 'Test 2', 'Test 3', 'Test 4'],
///   initial: const [],
/// ),
///
class FastButtonGroup<T> extends StatefulWidget {
  final void Function(List<T>) callback;
  final List<T> values;
  final List<T> initial;
  final bool multiple;
  final bool updateSelectionOnInitialChange;
  final bool allowEmpty;
  final Widget Function(T)? itemBuilder;

  /// FastButtonGroup
  ///
  /// example:
  ///
  /// ```dart
  /// FastButtonGroup<String>(
  ///   callback: (v) {},
  ///   values: const ['Test 1', 'Test 2', 'Test 3', 'Test 4'],
  ///   initial: const [],
  /// ),
  ///
  /// ```
  const FastButtonGroup({
    super.key,
    required this.callback,
    required this.values,
    required this.initial,
    this.multiple = true,
    this.itemBuilder,
    this.updateSelectionOnInitialChange = true,
    this.allowEmpty = true,
  });

  @override
  State<FastButtonGroup<T>> createState() => _FastButtonGroupState<T>();
}

class _FastButtonGroupState<T> extends State<FastButtonGroup<T>> {
  final selectees = <T>[];

  @override
  void initState() {
    selectees.clear();
    selectees.addAll(widget.initial);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FastButtonGroup<T> oldWidget) {
    if (widget.updateSelectionOnInitialChange) {
      selectees.clear();
      selectees.addAll(widget.initial);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _toggleSelect(T item) {
    if (selectees.contains(item)) {
      if ((selectees.length > 1 && !widget.allowEmpty) || widget.allowEmpty) {
        selectees.remove(item);
      }
    } else {
      if (widget.multiple) {
        selectees.add(item);
      } else {
        selectees.clear();
        selectees.addAll([item]);
      }
    }
    setState(() {
      widget.callback.call(selectees);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Wrap(
        runSpacing: 20,
        spacing: 8,
        children: widget.values.map((item) {
          final isSelected = selectees.contains(item);
          return InkWell(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: context.colors.primary),
                  borderRadius: BorderRadius.circular(50),
                  color: isSelected
                      ? context.colors.primary
                      : context.colors.primary.withOpacity(0.3),
                ),
                child: widget.itemBuilder?.call(item) ??
                    Text(
                      item.toString(),
                      style: context.p.copyWith(
                        color: isSelected ? context.colors.onPrimary : null,
                      ),
                    ),
              ),
              onTap: () => _toggleSelect(item));
        }).toList(),
      ),
    );
  }
}
