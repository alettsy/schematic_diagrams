import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/mixins/updatable.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/models/node.dart';
import 'package:schematic_diagrams/src/rendering/node_renderer.dart';
import 'package:schematic_diagrams/src/rendering/standard/standard_painted_text_renderer.dart';
import 'package:schematic_diagrams/src/rendering/text_renderer.dart';

/// Base renderer for nodes that uses [CustomPaint] to draw them.
abstract class PaintedNodeRenderer<T extends Node> extends NodeRenderer<T> {
  /// Default implementation.
  PaintedNodeRenderer({
    this.textRenderer = const StandardPaintedTextRenderer(),
  });

  /// Text renderer that uses [CustomPaint] to draw them.
  final PaintedTextRenderer? textRenderer;

  /// How to paint each [node] on the [canvas].
  void paint(
    Canvas canvas,
    T node,
    NodeTheme defaultNodeTheme,
    TextBlockTheme defaultTextBlockTheme,
  );

  /// Get the fill paint based on [node] and [defaultNodeTheme].
  Paint getFill(T node, NodeTheme defaultNodeTheme, {int partIndex = 0}) {
    final partTheme = node.getPartThemeOverride(partIndex);

    return Paint()
      ..color =
          partTheme?.fill ??
          node.activeThemeOverride.fill ??
          defaultNodeTheme.fill ??
          Colors.transparent
      ..style = PaintingStyle.fill;
  }

  /// Get the stroke paint based on [node] and [defaultNodeTheme].
  Paint getStroke(T node, NodeTheme defaultNodeTheme, {int partIndex = 0}) {
    final partTheme = node.getPartThemeOverride(partIndex);

    return Paint()
      ..color =
          partTheme?.stroke ??
          node.activeThemeOverride.stroke ??
          defaultNodeTheme.stroke ??
          Colors.transparent
      ..style = PaintingStyle.stroke
      ..strokeWidth =
          partTheme?.strokeWidth ??
          node.activeThemeOverride.strokeWidth ??
          defaultNodeTheme.strokeWidth ??
          0;
  }

  @override
  Widget buildContent(
    T node,
    NodeTheme defaultNodeTheme,
    TextBlockTheme defaultTextBlockTheme,
  ) {
    return CustomPaint(
      size: node.size,
      painter: _PaintedNodeDelegate(
        node: node,
        onPaint: (canvas) =>
            paint(canvas, node, defaultNodeTheme, defaultTextBlockTheme),
      ),
    );
  }
}

class _PaintedNodeDelegate<T extends Node> extends CustomPainter {
  const _PaintedNodeDelegate({required this.node, required this.onPaint});

  final T node;
  final void Function(Canvas canvas) onPaint;

  @override
  void paint(Canvas canvas, Size size) {
    onPaint(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return node is Updatable;
  }
}
