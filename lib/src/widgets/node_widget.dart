import 'package:flutter/widgets.dart';

import '../core/parts/node_theme.dart';
import '../core/parts/text_block_theme.dart';
import '../models/node.dart';
import '../rendering/node_renderer.dart';

class NodeWidget extends StatelessWidget {
  const NodeWidget({
    required this.node,
    required this.renderer,
    required this.defaultNodeTheme,
    required this.defaultTextTheme,
    super.key,
  });

  final Node node;
  final NodeRenderer renderer;
  final NodeTheme defaultNodeTheme;
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

    return Positioned(
      left: node.position.x,
      top: node.position.y,
      child: RepaintBoundary(
        child: renderer.buildContent(node, defaultNodeTheme, defaultTextTheme),
      ),
    );
  }
}
