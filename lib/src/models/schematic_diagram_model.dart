import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/internal/models/node_resolver.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/standard_link_manager.dart';
import 'package:schematic_diagrams/src/models/link.dart';
import 'package:schematic_diagrams/src/models/node.dart';
import 'package:schematic_diagrams/src/rendering/linking/link_manager.dart';

/// The model of the schematic diagram.
class SchematicDiagramModel implements NodeResolver {
  /// Creates a [SchematicDiagramModel] with a required list of
  /// [nodes].
  ///
  /// ## Example:
  /// ```Dart
  /// SchematicDiagramModel(
  ///   nodes: [
  ///     GateValve(id: 'g1', position: Position(50, 75), title: 'Gate 1'),
  ///     GateValve(id: 'g2', position: Position(50, 200), title: 'Gate 2'),
  ///   ].protected,
  ///   links: [
  ///     Link(
  ///       id: 'connect-g1-to-g2',
  ///       fromNodeId: 'g1',
  ///       toNodeId: 'g2',
  ///       fromPortId: 'bottom',
  ///       toPortId: 'top',
  ///       inFrom: LinkDirection.top,
  ///       outTo: LinkDirection.bottom,
  ///     ),
  ///   ].protected
  /// );
  /// ```
  SchematicDiagramModel({
    required this.nodes,
    ProtectedList<Link>? links,
    this.schematicTheme = const SchematicTheme(),
    this.defaultNodeTheme = const NodeTheme(),
    this.defaultTextBlockTheme = const TextBlockTheme(),
    this.defaultLinkTheme = const LinkTheme(),
    this.maxZoom = 2.0,
    this.minZoom = 0.5,
    this.scrollZoomStep = 0.1,
    this.canvasHeight = 2000,
    this.canvasWidth = 2000,
    this.canPan = true,
    this.canZoom = true,
    LinkManager? linkManager,
  }) : links = links ?? ProtectedList<Link>(),
       linkManager = linkManager ?? StandardLinkManager();

  /// The nodes in the diagram.
  final ProtectedList<Node> nodes;

  /// The links between nodes in the diagram.
  final ProtectedList<Link> links;

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
