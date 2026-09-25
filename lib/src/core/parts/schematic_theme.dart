import 'package:flutter/material.dart';

/// How the diagram should look when rendered to the screen.
@immutable
class SchematicTheme {
  /// Create a new [SchematicTheme] with an optional [backgroundColor],
  /// [borderColor], [borderWidth], and [borderRadius].
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SchematicTheme) return false;

    return backgroundColor == other.backgroundColor &&
        borderColor == other.borderColor &&
        borderWidth == other.borderWidth &&
        borderRadius == other.borderRadius;
  }

  @override
  int get hashCode =>
      Object.hash(backgroundColor, borderColor, borderWidth, borderRadius);
}
