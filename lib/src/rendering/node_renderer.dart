import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/internal/widgets/node_widget.dart';
import 'package:schematic_diagrams/src/models/node.dart';

/// Base renderer for how to render nodes.
abstract class NodeRenderer<T extends Node> {
  /// Default implementation.
  NodeRenderer();

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

  /// Get the fill color based on [node] and [defaultNodeTheme].
  Color getFillColor(T node, NodeTheme defaultNodeTheme, {int partIndex = 0}) {
    final partTheme = node.getPartThemeOverride(partIndex);

    return partTheme?.fill ??
        node.activeThemeOverride.fill ??
        defaultNodeTheme.fill ??
        Colors.transparent;
  }

  /// Get the stroke color based on [node] and [defaultNodeTheme].
  Color getStrokeColor(
    T node,
    NodeTheme defaultNodeTheme, {
    int partIndex = 0,
  }) {
    final partTheme = node.getPartThemeOverride(partIndex);

    return partTheme?.stroke ??
        node.activeThemeOverride.stroke ??
        defaultNodeTheme.stroke ??
        Colors.transparent;
  }

  /// Get the stroke width based on [node] and [defaultNodeTheme].
  double getStrokeWidth(
    T node,
    NodeTheme defaultNodeTheme, {
    int partIndex = 0,
  }) {
    final partTheme = node.getPartThemeOverride(partIndex);

    return partTheme?.strokeWidth ??
        node.activeThemeOverride.strokeWidth ??
        defaultNodeTheme.strokeWidth ??
        0;
  }
}
