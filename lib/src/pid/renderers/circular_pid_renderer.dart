import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/mixins/mixins.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/models/models.dart';
import 'package:schematic_diagrams/src/rendering/rendering.dart';

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

    final fillPaint = Paint()
      ..color =
          node.activeThemeOverride.fill ??
          defaultNodeTheme.fill ??
          Colors.transparent
      ..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color =
          node.activeThemeOverride.stroke ??
          defaultNodeTheme.stroke ??
          Colors.transparent
      ..style = PaintingStyle.stroke
      ..strokeWidth =
          node.activeThemeOverride.strokeWidth ??
          defaultNodeTheme.strokeWidth ??
          0;

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
