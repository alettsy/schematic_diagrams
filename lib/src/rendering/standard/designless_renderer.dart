import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/parts/node_theme.dart';
import 'package:schematic_diagrams/src/core/parts/text_block_theme.dart';
import 'package:schematic_diagrams/src/models/node.dart';
import 'package:schematic_diagrams/src/rendering/node_renderer.dart';

/// Renders a designless node.
class DesignlessRenderer extends NodeRenderer {
  /// Create a renderer that returns no design.
  DesignlessRenderer();

  @override
  Widget buildContent(
    Node node,
    NodeTheme defaultNodeTheme,
    TextBlockTheme defaultTextBlockTheme,
  ) {
    return const SizedBox.shrink();
  }
}
