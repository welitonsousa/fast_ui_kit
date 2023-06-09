import 'package:fast_ui_kit/fast_ui_kit.dart';
import 'package:fast_ui_kit/utils/top_snackbar.dart';
import 'package:flutter/material.dart';

/// message type
enum MessageVariant { success, error, info }

/// message position
enum MessagePosition { top, bottom }

/// message style
enum Style { flat, raised }

/// use this extension to show message
extension MessagesExt on BuildContext {
  Color _bg(MessageVariant? type) {
    if (type == MessageVariant.error) return Colors.red;
    if (type == MessageVariant.info) return Colors.blue;
    return Colors.green;
  }

  Widget _flatDesign({
    required String message,
    String? title,
    MessageVariant? type,
    Color? background,
  }) {
    return SizedBox(
      width: MediaQuery.of(this).size.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: FastTopMessage(
          message: message,
          title: title,
          backgroundColor: background ?? _bg(type),
        ),
      ),
    );
  }

  Widget _raisedDesign({
    required String message,
    String? title,
    MessageVariant? type,
    Color? background,
    MessagePosition? position,
  }) {
    return Material(
      child: Container(
        width: MediaQuery.of(this).size.width,
        padding: const EdgeInsets.all(10),
        color: background ?? _bg(type),
        child: Center(
          child: Container(
            width: MediaQuery.of(this).size.width,
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (position == MessagePosition.top) const SizedBox(height: 50),
                if (title != null)
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                  ),
                Text(
                  message,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _styleButton({
    required String message,
    String? title,
    MessagePosition? position,
    MessageVariant? type,
    Color? background,
    Style? style,
  }) {
    if (style == Style.raised) {
      return _raisedDesign(
        message: message,
        title: title,
        type: type,
        position: position,
        background: background,
      );
    }
    return _flatDesign(
      message: message,
      title: title,
      type: type,
      background: background,
    );
  }

  /// show message
  void showMessage(
    String message, {
    String? title,
    MessageVariant type = MessageVariant.success,
    MessagePosition position = MessagePosition.top,
    Color? background,
    Style style = Style.flat,
  }) {
    if (position == MessagePosition.top) {
      showTopSnackBar(
        this,
        _styleButton(
          message: message,
          title: title,
          position: position,
          type: type,
          background: background,
          style: style,
        ),
      );
    } else {
      ScaffoldMessenger.of(this).clearSnackBars();
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          padding: EdgeInsets.zero,
          elevation: 0,
          backgroundColor: style == Style.flat
              ? Colors.transparent
              : background ?? _bg(type),
          content: _styleButton(
            message: message,
            title: title,
            type: type,
            background: background,
            style: style,
          ),
        ),
      );
    }
  }
}
