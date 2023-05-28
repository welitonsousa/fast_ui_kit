import 'package:flutter/material.dart';

extension NavigationExt on BuildContext {
  Future<T?> dialog<T>(Widget page, {bool dismissible = true}) async {
    return await showDialog<T?>(
      context: this,
      builder: (_) => page,
      barrierDismissible: dismissible,
    );
  }

  void push(Widget page) {
    Navigator.of(this).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void pushNamed(String routeName) {
    Navigator.of(this).pushNamed(routeName);
  }

  void pushReplacement(Widget page) {
    Navigator.of(this).pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void pushReplacementNamed(String routeName) {
    Navigator.of(this).pushReplacementNamed(routeName);
  }

  void pushAndRemoveUntil(Widget page) {
    Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  void pushAndRemoveUntilNamed(String routeName) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
    );
  }

  void pop() {
    Navigator.of(this).pop();
  }

  void popUntil() {
    Navigator.of(this).popUntil((route) => false);
  }

  void popUntilNamed(String routeName) {
    Navigator.of(this).popUntil(ModalRoute.withName(routeName));
  }
}
