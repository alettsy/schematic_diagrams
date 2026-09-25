import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/mixins/mixins.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/models/node.dart';
import 'package:schematic_diagrams/src/rendering/rendering.dart';

/// Base renderer for the P&ID nodes.
class StandardPaintedBaseRenderer<T extends Node>
    extends PaintedNodeRenderer<T> {
  /// Create a [StandardPaintedBaseRenderer], which acts as the base for
  /// all nodes that use paint and can be optionally `Textblockable`, such as
  /// the P&ID nodes.
  StandardPaintedBaseRenderer({super.textRenderer});

  @override
  void paint(
    Canvas canvas,
    T node,
    NodeTheme defaultNodeTheme,
    TextBlockTheme defaultTextBlockTheme,
  ) {
    if (node is TextBlockable) {
      for (final textBlock in (node as TextBlockable).textBlocks) {
        textRenderer?.paint(canvas, textBlock, node, defaultTextBlockTheme);
      }
    }
  }
}
