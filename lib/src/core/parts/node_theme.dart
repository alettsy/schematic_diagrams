import 'package:flutter/material.dart';

/// How the node should look when painted on the screen.
///
/// Allows for setting a [fill] color, [stroke] color, and
/// [strokeWidth].
@immutable
class NodeTheme {
  /// Create a new [NodeTheme] with an optional [fill] [Color],
  /// [stroke] [Color], and [strokeWidth].
  const NodeTheme({
    this.fill = Colors.transparent,
    this.stroke = Colors.white,
    this.strokeWidth = 0.25,
  });

  /// The color the node body should be.
  final Color? fill;

  /// The color the node outline should be.
  final Color? stroke;

  /// The thickness of the outline.
  final double? strokeWidth;

  /// Copy this node with new properties.
  NodeTheme copyWith({Color? fill, Color? stroke, double? strokeWidth}) {
    return NodeTheme(
      fill: fill ?? this.fill,
      stroke: stroke ?? this.stroke,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NodeTheme) return false;

    return fill == other.fill &&
        stroke == other.stroke &&
        strokeWidth == other.strokeWidth;
  }

  @override
  int get hashCode => Object.hash(fill, stroke, strokeWidth);
}
