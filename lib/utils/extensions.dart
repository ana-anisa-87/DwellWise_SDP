import 'package:flutter/material.dart';

/// Extension methods on BuildContext for cleaner layout query code.
extension BuildContextExt on BuildContext {
  /// Theme getter shortcut.
  ThemeData get theme => Theme.of(this);

  /// Color scheme getter shortcut.
  ColorScheme get colors => Theme.of(this).colorScheme;

  /// Screen size dimensions shortcut.
  Size get screenSize => MediaQuery.of(this).size;

  /// Screen width shortcut.
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Screen height shortcut.
  double get screenHeight => MediaQuery.of(this).size.height;
}

/// Extension methods on String for text transformations.
extension StringExt on String {
  /// Capitalizes first character of text.
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
