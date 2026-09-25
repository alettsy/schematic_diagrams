import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/models/node.dart';
import 'package:schematic_diagrams/src/rendering/rendering.dart';

/// Circular renderer for the indicator/sensor nodes, such as
/// the voltage indicator.
class CircularPaintedNodeRenderer<T extends Node>
    extends StandardPaintedBaseRenderer<T> {
  /// Create a renderer which draws a circle.
  CircularPaintedNodeRenderer({super.textRenderer});

  @override
  void paint(
    Canvas canvas,
    T node,
    NodeTheme defaultNodeTheme,
    TextBlockTheme defaultTextBlockTheme,
  ) {
    final center = Offset(node.size.width / 2, node.size.height / 2);
    final radius = node.size.width / 2;

    final fillPaint = getFill(node, defaultNodeTheme);
    final outlinePaint = getStroke(node, defaultNodeTheme);

    canvas
      ..drawCircle(center, radius, fillPaint)
      ..drawCircle(center, radius, outlinePaint);

    super.paint(canvas, node, defaultNodeTheme, defaultTextBlockTheme);
  }
}
