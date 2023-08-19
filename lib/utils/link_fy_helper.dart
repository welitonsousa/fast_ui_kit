class FastLinkFyHelper {
  FastLinkFyHelper._();
  static List<String> linksOfMessage(String message) {
    final regex =
        RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-&?=%.]+');
    final matches = regex.allMatches(message);
    final links = matches.map((match) => match.group(0)).toList();
    final res = links.where((e) => e != null).toList();
    return res.cast<String>();
  }
}
