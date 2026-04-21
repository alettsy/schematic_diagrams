import 'package:flutter/widgets.dart';

@immutable
class NodeTheme {
  const NodeTheme({this.fill, this.stroke, this.strokeWidth});

  final Color? fill;
  final Color? stroke;
  final double? strokeWidth;

  NodeTheme copyWith({Color? fill, Color? stroke, double? strokeWidth}) {
    return NodeTheme(
      fill: fill ?? this.fill,
      stroke: stroke ?? this.stroke,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }
}
