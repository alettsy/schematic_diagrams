import 'package:schematic_diagrams/src/core/parts/parts.dart';
import 'package:schematic_diagrams/src/models/models.dart';

/// Internally used link details which provides all required references
/// to calculate the route for the link.
class LinkDetails {
  /// Default implementation
  LinkDetails({
    required this.outTo,
    required this.inFrom,
    required this.fromPortPosition,
    required this.toPortPosition,
    required this.fromNode,
    required this.toNode,
  });

  /// The origin node where the [fromPortPosition] is.
  final Node fromNode;

  /// The destination node where the [toPortPosition] is.
  final Node toNode;

  /// The position of the origin port.
  final Position fromPortPosition;

  /// The position of the destination port.
  final Position toPortPosition;

  /// The direction to draw the link into the destination port.
  final LinkDirection inFrom;

  /// The direction to draw the link out from the origin port.
  final LinkDirection outTo;

  /// Flip these details to their opposites.
  LinkDetails flip() {
    return LinkDetails(
      outTo: inFrom,
      inFrom: outTo,
      fromPortPosition: toPortPosition,
      toPortPosition: fromPortPosition,
      fromNode: toNode,
      toNode: fromNode,
    );
  }
}
