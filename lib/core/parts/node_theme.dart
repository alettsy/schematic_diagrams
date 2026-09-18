import 'package:flutter/widgets.dart';

/// How the node should look when painted on the screen.
///
/// Allows for setting a [fill] color, [stroke] color, and 
/// [strokeWidth].
@immutable
class NodeTheme {
  /// Default implementation.
  const NodeTheme({this.fill, this.stroke, this.strokeWidth});

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
}
