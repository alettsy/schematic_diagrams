import 'package:flutter/material.dart';

import '../core/mixins/updatable.dart';
import '../core/parts/parts.dart';
import '../models/node.dart';
import 'node_renderer.dart';
import 'text_renderer.dart';

abstract class PaintedNodeRenderer<T extends Node> extends NodeRenderer<T> {
  final PaintedTextRenderer? textRenderer;

  const PaintedNodeRenderer({
    this.textRenderer = const StandardPaintedTextRenderer(),
  });

  void paint(
    Canvas canvas,
    T node,
    NodeTheme defaultNodeTheme,
    TextBlockTheme defaultTextBlockTheme,
  );

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
