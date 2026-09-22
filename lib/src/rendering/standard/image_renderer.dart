import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/parts/node_theme.dart';
import 'package:schematic_diagrams/src/core/parts/text_block_theme.dart';
import 'package:schematic_diagrams/src/models/node.dart';
import 'package:schematic_diagrams/src/rendering/node_renderer.dart';

class ImageNodeRenderer extends NodeRenderer {
  ImageNodeRenderer({required this.image});

  final AssetImage image;

  @override
  Widget buildContent(
    Node node,
    NodeTheme defaultNodeTheme,
    TextBlockTheme defaultTextBlockTheme,
  ) {
    return Image(
      image: image,
      width: node.size.width,
      height: node.size.height,
    );
  }
}
