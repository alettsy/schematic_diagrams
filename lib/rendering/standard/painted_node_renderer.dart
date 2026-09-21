import 'package:flutter/material.dart';
import 'package:schematic_diagrams/core/mixins/updatable.dart';
import 'package:schematic_diagrams/core/parts/parts.dart';
import 'package:schematic_diagrams/models/node.dart';
import 'package:schematic_diagrams/rendering/node_renderer.dart';
import 'package:schematic_diagrams/rendering/standard/standard_painted_text_renderer.dart';
import 'package:schematic_diagrams/rendering/text_renderer.dart';

/// Base renderer for nodes that uses [CustomPaint] to draw them.
abstract class PaintedNodeRenderer<T extends Node> extends NodeRenderer<T> {
  /// Default implementation.
  const PaintedNodeRenderer({
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
  Paint getFill(T node, NodeTheme defaultNodeTheme) {
    return Paint()
      ..color =
          node.activeThemeOverride.fill ??
          defaultNodeTheme.fill ??
          Colors.transparent
      ..style = PaintingStyle.fill;
  }

  /// Get the stroke paint based on [node] and [defaultNodeTheme].
  Paint getStroke(T node, NodeTheme defaultNodeTheme) {
    return Paint()
      ..color =
          node.activeThemeOverride.stroke ??
          defaultNodeTheme.stroke ??
          Colors.transparent
      ..style = PaintingStyle.stroke
      ..strokeWidth =
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
