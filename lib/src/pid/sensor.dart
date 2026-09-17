import 'package:flutter/material.dart';

import '../core/mixins/mixins.dart';
import '../core/parts/parts.dart';
import '../models/node.dart';
import '../rendering/painted_node_renderer.dart';

abstract class SensorNode extends Node
    with
        ChangeNotifier,
        Updatable,
        Valuable<double>,
        TextBlockable,
        Linkable,
        StateToColorMappable<double> {
  SensorNode({required this.prefix, required super.id, super.position})
    : super(
        renderer: CircularPaintedNodeRenderer<SensorNode>(),
        themeOverride: NodeTheme(strokeWidth: 4),
        size: Size(32, 32),
      ) {
    textBlocks = [
      TextBlock(
        id: 'value',
        text: '0',
        themeOverride: TextBlockTheme(color: Colors.purple),
        position: Position(40, 7),
      ),
      TextBlock(
        id: 'prefix',
        text: prefix,
        themeOverride: TextBlockTheme(color: Colors.lightGreen),
        position: Position(12, 7),
      ),
    ];
    ports = [Port(id: 'top', position: Position(16, 0)), Port(id: 'bottom', position: Position(16, 32)), Port(id: 'left', position: Position(0, 16)), Port(id: 'right', position: Position(32, 16))];
  }

  final String prefix;

  @override
  void update() {
    if (value == null) return;

    textBlocks[0] = textBlocks[0].copyWith(text: value.toString());

    if (value! > 500) {
      transientTheme = themeOverride.copyWith(fill: Colors.green);
    } else {
      transientTheme = themeOverride.copyWith(fill: Colors.red);
    }

    notifyListeners();
  }
}

class VoltageSensorNode extends SensorNode {
  VoltageSensorNode({required super.id, super.position}) : super(prefix: 'VI');
}

class FlowSensorNode extends SensorNode {
  FlowSensorNode({required super.id, super.position}) : super(prefix: 'FI');
}

class CircularPaintedNodeRenderer<T extends Node>
    extends PaintedNodeRenderer<T> {
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

    canvas.drawCircle(center, radius, fillPaint);
    canvas.drawCircle(center, radius, outlinePaint);

    if (node is TextBlockable) {
      for (final textBlock in (node as TextBlockable).textBlocks) {
        textRenderer?.paint(canvas, textBlock, defaultTextBlockTheme);
      }
    }
  }
}
