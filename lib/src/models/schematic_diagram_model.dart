import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/rendering/link_renderer.dart';

import '../core/parts/parts.dart';
import '../rendering/standard_link_renderer.dart';
import 'link.dart';
import 'node.dart';
import 'node_resolver.dart';

class SchematicDiagramModel implements NodeResolver {
  SchematicDiagramModel({
    required this.nodes,
    this.links = const [],
    this.schematicTheme = const SchematicTheme(),
    this.defaultNodeTheme = const NodeTheme(
      fill: Colors.blue,
      stroke: Colors.black,
      strokeWidth: 1,
    ),
    this.defaultTextBlockTheme = const TextBlockTheme(
      color: Colors.black,
      fontSize: 12,
    ),
    this.defaultLinkTheme = const LinkTheme(
      stroke: Colors.black,
      strokeWidth: 2,
    ),
    this.maxZoom = 2.0,
    this.minZoom = 0.5,
    this.scrollZoomStep = 0.1,
    this.canvasHeight = 2000,
    this.canvasWidth = 2000,
    this.canPan = true,
    this.canZoom = true,
    this.linkRenderer = const StandardLinkRenderer(),
  });

  final List<Node> nodes;
  final List<Link> links;
  final LinkRenderer linkRenderer;
  final SchematicTheme schematicTheme;
  final NodeTheme defaultNodeTheme;
  final TextBlockTheme defaultTextBlockTheme;
  final LinkTheme defaultLinkTheme;
  final double maxZoom;
  final double minZoom;
  final double scrollZoomStep;
  final double canvasWidth;
  final double canvasHeight;
  final bool canZoom;
  final bool canPan;

  @override
  Node? getNode(String nodeId) {
    // TODO: implement a more efficient solution for large diagrams
    for (final node in nodes) {
      if (node.id == nodeId) {
        return node;
      }
    }

    return null;
  }
}
