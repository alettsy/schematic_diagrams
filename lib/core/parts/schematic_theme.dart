import 'package:flutter/material.dart';

/// How the diagram should look when rendered to the screen.
@immutable
class SchematicTheme {
  /// Default implementation.
  const SchematicTheme({
    this.backgroundColor = Colors.grey,
    this.borderColor = Colors.black,
    this.borderWidth = 2,
    this.borderRadius,
  });

  /// The background color of the diagram.
  final Color backgroundColor;

  /// The outline border color of the diagram.
  final Color borderColor;

  /// The thickness of the outline border.
  final double borderWidth;

  /// The outline border radius.
  final BorderRadiusGeometry? borderRadius;
}
