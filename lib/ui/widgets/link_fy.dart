import 'package:fast_ui_kit/fast_ui_kit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FastLinkFy extends StatefulWidget {
  final String text;
  final TextStyle? styleLink;
  final TextStyle? styleText;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final void Function(String)? onTapLink;

  const FastLinkFy({
    super.key,
    required this.text,
    this.maxLines,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.clip,
    this.styleText,
    this.onTapLink,
    this.styleLink = const TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    ),
  });

  @override
  State<FastLinkFy> createState() => _LinkFyState();
}

class _LinkFyState extends State<FastLinkFy> {
  final spans = <TextSpan>[];

  @override
  void initState() {
    _buildTextSpans(widget.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: widget.textAlign,
      overflow: widget.overflow,
      maxLines: widget.maxLines,
      text: TextSpan(
          children: spans,
          style: widget.styleText ??
              TextStyle(
                color: context.theme.textTheme.bodyLarge?.color,
              )),
    );
  }

  List<TextSpan> _buildTextSpans(String text) {
    final links = FastLinkFyHelper.linksOfMessage(text);
    final words = text.split(' ');

    for (var i = 0; i < words.length; i++) {
      final word = words[i];
      final isLink = links.contains(word);
      if (isLink) {
        spans.add(TextSpan(
          text: word,
          style: widget.styleLink,
          recognizer: TapGestureRecognizer()
            ..onTap = () => widget.onTapLink?.call(word),
        ));
      } else {
        spans.add(TextSpan(text: word));
      }
      if (i < words.length - 1) spans.add(const TextSpan(text: ' '));
    }

    return spans;
  }
}
