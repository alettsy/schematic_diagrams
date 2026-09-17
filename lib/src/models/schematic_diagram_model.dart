import 'package:flutter/material.dart';
import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/models/link.dart';
import 'package:schematic_diagrams/src/models/node.dart';
import 'package:schematic_diagrams/src/models/node_resolver.dart';
import 'package:schematic_diagrams/src/rendering/linking/link_manager.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/standard_link_manager.dart';

class SchematicDiagramModel implements NodeResolver {
  SchematicDiagramModel({
    required this.nodes,
    this.links = const [],
    this.schematicTheme = const SchematicTheme(),
    this.defaultNodeTheme = const NodeTheme(
      fill: Colors.blue,
      stroke: Colors.black,
      strokeWidth: 2,
    ),
    this.defaultTextBlockTheme = const TextBlockTheme(),
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
    LinkManager? linkManager,
  }) : linkManager = linkManager ?? StandardLinkManager() {
    for (final node in nodes) {
      if (_nodeIdRegistry.contains(node.id)) {
        throw Exception('Duplicate node ID "${node.id}"');
      }
      _nodeIdRegistry.add(node.id);
    }

    for (final link in links) {
      if (_linkIdRegistry.contains(link.id)) {
        throw Exception('Duplicate node ID "${link.id}"');
      }
      _linkIdRegistry.add(link.id);
    }
  }

  final List<Node> nodes;
  final List<Link> links;
  final LinkManager linkManager;
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

  final _nodeIdRegistry = <String>{};
  final _linkIdRegistry = <String>{};

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
