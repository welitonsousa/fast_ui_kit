import 'package:fast_ui_kit/fast_ui_kit.dart';
import 'package:flutter/material.dart';

class FastSearchSelect<T> extends StatefulWidget {
  final String? Function(List<T>)? validation;
  final Future<List<T>> Function(String)? onSearch;
  final String searchTitle;
  final List<T> items;
  final String? hint;
  final int? max;
  final bool alowMultiple;
  final void Function(List<T>?)? onChanged;
  final Widget Function(T)? itemBuilder;
  final List<T>? initialValue;
  final double radius;
  final bool showClearButton;

  const FastSearchSelect({
    super.key,
    this.showClearButton = true,
    this.searchTitle = 'Search',
    this.onSearch,
    this.hint,
    this.initialValue,
    this.alowMultiple = true,
    this.radius = 8,
    this.onChanged,
    this.max,
    this.validation,
    this.itemBuilder,
    required this.items,
  });

  @override
  State<FastSearchSelect<T>> createState() => _FastSearchSelectState<T>();
}

class _FastSearchSelectState<T> extends State<FastSearchSelect<T>> {
  final selections = <T>[];

  @override
  void initState() {
    selections.addAll(widget.initialValue ?? []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<FileData>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validation != null
          ? (v) => widget.validation!(selections)
          : null,
      builder: (field) {
        return GestureDetector(
          onTap: () async {
            final res = await showDialog(
              context: context,
              barrierColor: Colors.transparent,
              builder: (context) => _Dialog(
                items: widget.items,
                itemBuilder: widget.itemBuilder,
                alowMultiple: widget.alowMultiple,
                max: widget.max,
                onSearch: widget.onSearch,
                searchTitle: widget.searchTitle,
                initialValue: selections,
              ),
            );
            if (res is List<T>) {
              widget.onChanged?.call(res);
              setState(() {
                selections.clear();
                selections.addAll(res);
              });
            }
            field.validate();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.radius),
                  border: Border.all(
                      color: field.hasError ? Colors.red[900]! : Colors.grey,
                      width: 1.2),
                ),
                constraints: const BoxConstraints(minHeight: 60),
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (selections.isNotEmpty)
                      Wrap(
                        runSpacing: 5,
                        spacing: 5,
                        children: [
                          ...selections.map(
                            (e) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: context.colors.primary.withOpacity(.2),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    e.toString(),
                                    style: TextStyle(
                                        color: context.colors.primary),
                                  ),
                                  if (widget.showClearButton)
                                    const SizedBox(width: 5),
                                  if (widget.showClearButton)
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selections.remove(e);
                                          widget.onChanged?.call(selections);
                                        });
                                      },
                                      child: Icon(
                                        Icons.close,
                                        size: 15,
                                        color: context.colors.primary,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (widget.hint != null)
                              Expanded(
                                child: Text(
                                  widget.hint!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            else
                              const SizedBox(),
                            const Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              if (field.hasError && field.errorText != null)
                Text(
                  field.errorText!,
                  style: TextStyle(color: Colors.red[900]!),
                )
            ],
          ),
        );
      },
    );
  }
}

class _Dialog<T> extends StatefulWidget {
  final List<T> items;
  final String searchTitle;
  final int? max;
  final Widget Function(T)? itemBuilder;
  final bool alowMultiple;
  final List<T> initialValue;
  final Future<List<T>> Function(String)? onSearch;

  const _Dialog({
    super.key,
    this.max,
    this.onSearch,
    this.initialValue = const [],
    this.searchTitle = 'Search',
    this.alowMultiple = true,
    this.itemBuilder,
    required this.items,
  });

  @override
  State<_Dialog<T>> createState() => _DialogState<T>();
}

class _DialogState<T> extends State<_Dialog<T>> {
  final selects = <T>[];
  final items = <T>[];
  final search = TextEditingController();
  var loading = false;

  List<T> get filtered {
    if (search.text.isEmpty) return items;

    return items.where((element) {
      if (widget.onSearch != null) return true;
      final text = element.toString().toLowerCase();
      return text.contains(search.text.toLowerCase());
    }).toList();
  }

  @override
  void initState() {
    items.clear();
    items.addAll(widget.items);
    selects.addAll(widget.initialValue);

    super.initState();
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shadowColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 500,
          maxWidth: 200,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              margin: const EdgeInsets.only(top: 10),
              child: FastFormField(
                hint: widget.searchTitle,
                controller: search,
                onChanged: (v) async {
                  if (widget.onSearch != null) {
                    if (loading) return;
                    FastDebounce.call(action: () async {
                      try {
                        setState(() => loading = true);
                        final res = await widget.onSearch!(v);
                        items.clear();
                        items.addAll(res);
                      } finally {
                        setState(() => loading = false);
                      }
                    });
                  }
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (loading)
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else
                      ...List.generate(filtered.length, (index) {
                        final item = filtered[index];
                        return ListTile(
                          leading: widget.alowMultiple
                              ? Visibility(
                                  visible: selects.contains(item),
                                  replacement:
                                      const Icon(Icons.check_box_outline_blank),
                                  child: const Icon(Icons.check_box_outlined),
                                )
                              : null,
                          title: widget.itemBuilder != null
                              ? widget.itemBuilder!(item)
                              : Text(item.toString()),
                          onTap: () {
                            if (widget.alowMultiple) {
                              setState(() {
                                if (selects.contains(item)) {
                                  selects.remove(item);
                                } else if (widget.max == null ||
                                    selects.length < widget.max!) {
                                  selects.add(item);
                                }
                              });
                            } else {
                              setState(() {
                                selects.clear();
                                selects.add(item);
                              });
                              context.pop(selects);
                            }
                          },
                        );
                      })
                  ],
                ),
              ),
            ),
            if (widget.alowMultiple)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: context.pop,
                        child: const Text('Cancelar'),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () => context.pop(selects),
                        child: const Text('Confirmar'),
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
