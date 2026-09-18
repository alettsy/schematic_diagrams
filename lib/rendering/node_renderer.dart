import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:schematic_diagrams/core/parts/parts.dart';
import 'package:schematic_diagrams/models/node.dart';
import 'package:schematic_diagrams/src/widgets/node_widget.dart';

/// Base renderer for how to render nodes.
abstract class NodeRenderer<T extends Node> {
  /// Default implementation.
  const NodeRenderer();

  /// Build the content inside the node, such as via [CustomPaint].
  Widget buildContent(
    T node,
    NodeTheme defaultNodeTheme,
    TextBlockTheme defaultTextBlockTheme,
  );

  /// Build the [node] as [NodeWidget].
  @nonVirtual
  Widget build(
    T node,
    NodeTheme defaultNodeTheme,
    TextBlockTheme defaultTextTheme,
  ) {
    return NodeWidget(
      node: node,
      renderer: this,
      defaultNodeTheme: defaultNodeTheme,
      defaultTextTheme: defaultTextTheme,
    );
  }
}
