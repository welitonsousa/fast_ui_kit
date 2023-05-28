import 'package:fast_ui_kit/fast_ui_kit.dart';
import 'package:fast_ui_kit/ui/widgets/animate.dart';
import 'package:flutter/material.dart';

class FastSearchAppBar extends PreferredSize {
  final void Function(String)? onSearch;
  final int? debounceTime;
  final String title;
  final String? hint;
  final bool? loading;
  final bool animated;
  FastSearchAppBar({
    super.key,
    this.onSearch,
    this.debounceTime,
    required this.title,
    this.hint = 'Search...',
    this.loading,
    this.animated = true,
  }) : super(
            child: _SearchAppBar(
              onSearch: onSearch,
              animated: animated,
              debounceTime: debounceTime,
              title: title,
              hint: hint,
              loading: loading,
            ),
            preferredSize: Size(double.infinity,
                loading == true ? kToolbarHeight + 5 : kToolbarHeight));
}

class _SearchAppBar extends StatefulWidget {
  final void Function(String)? onSearch;
  final String title;
  final int? debounceTime;
  final String? hint;
  final bool? loading;
  final bool animated;
  const _SearchAppBar({
    required this.onSearch,
    required this.title,
    required this.hint,
    required this.loading,
    required this.debounceTime,
    required this.animated,
  });
  @override
  State<_SearchAppBar> createState() => __SearchAppBarState();
}

class __SearchAppBarState extends State<_SearchAppBar> {
  bool searching = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text(widget.title),
          actions: [
            if (!searching && widget.onSearch != null)
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => setState(() => searching = true),
              ),
            if (searching)
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
                  child: FastAnimate(
                    type: widget.animated
                        ? FastAnimateType.fadeInRightBig
                        : FastAnimateType.none,
                    child: FastFormField(
                      hint: widget.hint,
                      autoFocus: true,
                      textInputAction: TextInputAction.search,
                      onChanged: (v) => FastDebounce.call(
                        action: () => widget.onSearch?.call(v),
                        milliseconds: widget.debounceTime,
                      ),
                      suffix: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          widget.onSearch?.call('');
                          setState(() => searching = false);
                        },
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        if (widget.loading ?? false)
          const Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: LinearProgressIndicator(),
          )),
      ],
    );
  }
}
