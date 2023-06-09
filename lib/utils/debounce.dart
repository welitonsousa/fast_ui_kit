import 'dart:async';

/// use this class to debounce actions
///
/// example:
///
/// ```dart
/// FastDebounce.call(
///  action: () {
///   print('debounce');
/// },
class FastDebounce {
  FastDebounce._();

  static Timer? _timer;
  static call({required void Function() action, int? milliseconds}) {
    if (null != _timer) {
      _timer?.cancel();
      _timer = null;
    }
    _timer = Timer(Duration(milliseconds: milliseconds ?? 700), action);
  }
}
