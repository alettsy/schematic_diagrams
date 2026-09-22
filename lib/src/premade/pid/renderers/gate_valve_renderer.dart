import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/models/models.dart';
import 'package:schematic_diagrams/src/premade/pid/base/base_renderer.dart';

/// Renderer for the standard P&ID two-port gate valve.
class GateValveRenderer<T extends Node> extends BaseRenderer<T> {
  /// Default implementation.
  GateValveRenderer({super.textRenderer});

  @override
  void paint(
    Canvas canvas,
    T node,
    NodeTheme defaultNodeTheme,
    TextBlockTheme defaultTextBlockTheme,
  ) {
    final centerX = node.size.width / 2;
    final centerY = node.size.height / 2;

    final topPath = Path()
      ..moveTo(0, 0)
      ..lineTo(node.size.width, 0)
      ..lineTo(centerX, centerY)
      ..close();

    canvas
      ..drawPath(topPath, getFill(node, defaultNodeTheme, partIndex: 0))
      ..drawPath(topPath, getStroke(node, defaultNodeTheme, partIndex: 0));

    final bottomPath = Path()
      ..moveTo(centerX, centerY)
      ..lineTo(node.size.width, node.size.height)
      ..lineTo(0, node.size.height)
      ..close();

    canvas
      ..drawPath(bottomPath, getFill(node, defaultNodeTheme, partIndex: 1))
      ..drawPath(bottomPath, getStroke(node, defaultNodeTheme, partIndex: 1));

    super.paint(canvas, node, defaultNodeTheme, defaultTextBlockTheme);
  }
}
