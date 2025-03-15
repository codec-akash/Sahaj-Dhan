import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void showSnackBar({required String title}) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(title)));
  }
}
