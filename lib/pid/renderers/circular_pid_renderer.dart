import 'package:flutter/material.dart';
import 'package:schematic_diagrams/core/mixins/mixins.dart';
import 'package:schematic_diagrams/core/parts/parts.dart';
import 'package:schematic_diagrams/models/node.dart';
import 'package:schematic_diagrams/rendering/rendering.dart';

/// Circular renderer for the indicator/sensor nodes, such as
/// the voltage indicator.
class CircularPaintedNodeRenderer<T extends Node>
    extends PaintedNodeRenderer<T> {
  /// Default implementation.
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

    if (node is TextBlockable) {
      for (final textBlock in (node as TextBlockable).textBlocks) {
        textRenderer?.paint(canvas, textBlock, defaultTextBlockTheme);
      }
    }
  }
}
