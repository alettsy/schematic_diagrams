import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/models/node.dart';
import 'package:schematic_diagrams/src/rendering/rendering.dart';

/// Circular renderer for the indicator/sensor nodes, such as
/// the voltage indicator.
class IoRenderer<T extends Node> extends StandardPaintedBaseRenderer<T> {
  /// Create a [IoRenderer], which draws the IO triangle valve.
  IoRenderer({super.textRenderer});

  @override
  void paint(
    Canvas canvas,
    T node,
    NodeTheme defaultNodeTheme,
    TextBlockTheme defaultTextBlockTheme,
  ) {
    final fillPaint = getFill(node, defaultNodeTheme);
    final outlinePaint = getStroke(node, defaultNodeTheme);

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(node.size.width, 0)
      ..lineTo(node.size.width / 2, node.size.height)
      ..close();

    canvas
      ..drawPath(path, fillPaint)
      ..drawPath(path, outlinePaint);

    super.paint(canvas, node, defaultNodeTheme, defaultTextBlockTheme);
  }
}
