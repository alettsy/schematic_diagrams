import 'package:flutter/material.dart';
import 'package:schematic_diagrams/core/parts/parts.dart';
import 'package:schematic_diagrams/models/link.dart';
import 'package:schematic_diagrams/models/node.dart';
import 'package:schematic_diagrams/rendering/linking/link_manager.dart';
import 'package:schematic_diagrams/src/models/node_resolver.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/standard_link_manager.dart';

/// The model of the schematic diagram.
class SchematicDiagramModel implements NodeResolver {
  /// Default implementation.
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

  /// The nodes in the diagram.
  final List<Node> nodes;

  /// The links between nodes in the diagram.
  final List<Link> links;

  /// How the links are drawn and handled.
  final LinkManager linkManager;

  /// The main theme of the diagram.
  final SchematicTheme schematicTheme;

  /// The default theme for all nodes.
  final NodeTheme defaultNodeTheme;

  /// The default theme for all text blocks.
  final TextBlockTheme defaultTextBlockTheme;

  /// The default theme for all links.
  final LinkTheme defaultLinkTheme;

  /// The maximum zoom a user can zoom in to.
  final double maxZoom;

  /// The minimum zoom a user can zoom out to.
  final double minZoom;

  /// How much each scroll should adjust the zoom by.
  final double scrollZoomStep;

  /// The width of the diagram canvas.
  final double canvasWidth;

  /// The height of the diagram canvas.
  final double canvasHeight;

  /// Whether or not zooming is allowed.
  final bool canZoom;

  /// Whether or not panning is allowed.
  final bool canPan;

  final _nodeIdRegistry = <String>{};
  final _linkIdRegistry = <String>{};

  @override
  Node? getNode(String nodeId) {
    for (final node in nodes) {
      if (node.id == nodeId) {
        return node;
      }
    }

    return null;
  }
}
