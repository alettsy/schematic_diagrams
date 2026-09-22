import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/models/node.dart';
import 'package:schematic_diagrams/src/premade/pid/renderers/circular_pid_renderer.dart';

class PumpRenderer<T extends Node> extends CircularPaintedNodeRenderer<T> {
  PumpRenderer({super.textRenderer});

  @override
  void paint(
    Canvas canvas,
    T node,
    NodeTheme defaultNodeTheme,
    TextBlockTheme defaultTextBlockTheme,
  ) {
    super.paint(canvas, node, defaultNodeTheme, defaultTextBlockTheme);

    final center = Offset(node.size.width / 2, node.size.height / 2);
    final radius = node.size.width / 2;

    final topPoint = Offset(
      center.dx + radius * math.cos(math.pi * 0.6),
      center.dy + radius * math.sin(math.pi * 0.6),
    );

    final bottomPoint = Offset(
      center.dx + radius * math.cos(math.pi * 1.4),
      center.dy + radius * math.sin(math.pi * 1.4),
    );

    final topPointPath = Path()
      ..moveTo(topPoint.dx, topPoint.dy)
      ..lineTo(node.size.width, node.size.height / 2);

    final bottomPointPath = Path()
      ..moveTo(bottomPoint.dx, bottomPoint.dy)
      ..lineTo(node.size.width, node.size.height / 2);

    canvas
      ..drawPath(topPointPath, getStroke(node, defaultNodeTheme))
      ..drawPath(bottomPointPath, getStroke(node, defaultNodeTheme));
  }
}
