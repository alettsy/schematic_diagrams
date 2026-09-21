import 'package:flutter/material.dart';
import 'package:schematic_diagrams/core/parts/parts.dart';
import 'package:schematic_diagrams/models/models.dart';
import 'package:schematic_diagrams/rendering/standard/painted_node_renderer.dart';

class GateValveRenderer<T extends Node> extends PaintedNodeRenderer<T> {
  GateValveRenderer({super.textRenderer});

  @override
  void paint(
    Canvas canvas,
    T node,
    NodeTheme defaultNodeTheme,
    TextBlockTheme defaultTextBlockTheme,
  ) {
    final fillPaint = getFill(node, defaultNodeTheme);
    final outlinePaint = getStroke(node, defaultNodeTheme);

    final centerX = node.size.width / 2;
    final centerY = node.size.height / 2;

    final topPath = Path()
      ..moveTo(0, 0)
      ..lineTo(node.size.width, 0)
      ..lineTo(centerX, centerY)
      ..close();

    canvas
      ..drawPath(topPath, fillPaint)
      ..drawPath(topPath, outlinePaint);

    final bottomPath = Path()
      ..moveTo(centerX, centerY)
      ..lineTo(node.size.width, node.size.height)
      ..lineTo(0, node.size.height)
      ..close();

    canvas
      ..drawPath(bottomPath, fillPaint)
      ..drawPath(bottomPath, outlinePaint);
  }
}
