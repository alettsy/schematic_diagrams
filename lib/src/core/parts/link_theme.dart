import 'package:flutter/material.dart';

/// How the link should look when painted on the screen.
///
/// Allows for setting a [stroke] color and [strokeWidth].
@immutable
class LinkTheme {
  /// Create a new [LinkTheme] with an optional [stroke] [Color]
  /// and [strokeWidth].
  const LinkTheme({
    this.stroke = const Color.fromARGB(255, 171, 175, 177),
    this.strokeWidth = 1.25,
  });

  /// The color the link should be.
  final Color? stroke;

  /// The thickness of the link line.
  final double? strokeWidth;

  /// Copy this link with new properties.
  LinkTheme copyWith({Color? stroke, double? strokeWidth}) {
    return LinkTheme(
      stroke: stroke ?? this.stroke,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LinkTheme) return false;

    return strokeWidth == other.strokeWidth && stroke == other.stroke;
  }

  @override
  int get hashCode => Object.hash(stroke, strokeWidth);
}
