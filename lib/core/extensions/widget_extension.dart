import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget updateOpacity(double opacity) => Opacity(
        opacity: opacity,
        child: this,
      );
}
