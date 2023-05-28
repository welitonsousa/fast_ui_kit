import 'dart:async';

class FastDebounce {
  static Timer? _timer;
  static call({required void Function() action, int? milliseconds}) {
    if (null != _timer) {
      _timer?.cancel();
      _timer = null;
    }
    _timer = Timer(Duration(milliseconds: milliseconds ?? 700), action);
  }
}
