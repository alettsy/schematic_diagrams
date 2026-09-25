import 'package:flutter/material.dart';
import 'package:schematic_diagrams/schematic_diagrams.dart';
import 'package:schematic_diagrams/src/core/helpers/angle_helper.dart';

/// Widget representation of a node.
class NodeWidget extends StatelessWidget {
  /// Create a [NodeWidget] that will use [renderer] to draw the [node].
  /// 
  /// The [defaultNodeTheme] will be applied if the node has no theme override.
  /// Similarly, the [defaultTextTheme] will be applied to all text blocks if
  /// the have no theme override either.
  const NodeWidget({
    required this.node,
    required this.renderer,
    required this.defaultNodeTheme,
    required this.defaultTextTheme,
    super.key,
  });

  /// The model representation of the node.
  final Node node;

  /// How the node should be rendered to the diagram.
  final NodeRenderer renderer;

  /// The default theme for the node.
  final NodeTheme defaultNodeTheme;

  /// The default text block theme for all text blocks in the
  /// node.
  final TextBlockTheme defaultTextTheme;

  @override
  Widget build(BuildContext context) {
    if (node is Listenable) {
      return Positioned(
        left: 0,
        top: 0,
        child: ListenableBuilder(
          listenable: node as Listenable,
          builder: (context, _) => Transform.translate(
            offset: node.position.asOffset,
            child: Transform.rotate(
              angle: node.rotation.radians,
              child: InkWell(
                mouseCursor: node is Tappable
                    ? SystemMouseCursors.click
                    : SystemMouseCursors.basic,
                onTap: () {
                  if (node is Tappable) {
                    (node as Tappable).onTap();
                  }
                },
                child: RepaintBoundary(
                  child: renderer.buildContent(
                    node,
                    defaultNodeTheme,
                    defaultTextTheme,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Positioned(
      left: node.position.x,
      top: node.position.y,
      child: Transform.rotate(
        angle: node.rotation.radians,
        child: InkWell(
          mouseCursor: node is Tappable
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
          onTap: () {
            if (node is Tappable) {
              (node as Tappable).onTap();
            }
          },
          child: RepaintBoundary(
            child: renderer.buildContent(
              node,
              defaultNodeTheme,
              defaultTextTheme,
            ),
          ),
        ),
      ),
    );
  }
}
