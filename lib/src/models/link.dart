import 'package:schematic_diagrams/src/core/parts/parts.dart';

/// A link between the port of one node to the port of
/// another node, based on the node IDs and port IDs.
/// 
/// Linking direction is specified at the start and end ports,
/// using [outTo] (link direction when leaving start port) and [inFrom]
/// (link direction when entering end port). 
class Link {
  /// Default implementation.
  Link({
    required this.id,
    required this.fromNodeId,
    required this.toNodeId,
    required this.fromPortId,
    required this.toPortId,
    required this.outTo,
    required this.inFrom,
    this.themeOverride = const LinkTheme(),
  });

  /// The unique ID of this link.
  final String id;

  /// The ID of the node which has the start port.
  final String fromNodeId;

  /// The ID of the node ewhich hasthe end port.
  final String toNodeId;

  /// The ID of the port in the start node. 
  final String fromPortId;

  /// The ID of the port in the end node.
  final String toPortId;

  /// The direction to draw the link when leaving the start port.
  final LinkDirection outTo;

  /// The direction to draw the link when entering the end port.
  final LinkDirection inFrom;

  /// The theme that takes precedence over the inherited theme.
  final LinkTheme themeOverride;

  /// The theme that can be dynamically adjusted externally and takes
  /// precendence over all themes.
  LinkTheme? transientTheme;

  /// Get the currently active theme for this link.
  LinkTheme get activeTheme => transientTheme ?? themeOverride;
}
