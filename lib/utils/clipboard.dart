import 'package:flutter/services.dart';

sealed class FastClipboard {
  static void copy(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  static Future<String?> paste() async {
    return (await Clipboard.getData('text/plain'))?.text;
  }
}
