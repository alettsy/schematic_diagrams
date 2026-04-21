import 'package:schematic_diagrams/schematic_diagrams.dart';

import '../models/node_resolver.dart';
import 'link_path_strategy.dart';

class StandardLinkPathStrategy<T extends Link> extends LinkPathStrategy<T> {
  const StandardLinkPathStrategy({this.gap = 10});

  final double gap;

  @override
  List<Position> compute(T link, NodeResolver nodeResolver) {
    final fromNode = nodeResolver.getNode(link.fromNodeId);
    final toNode = nodeResolver.getNode(link.toNodeId);

    if (fromNode is! Linkable || toNode is! Linkable) {
      return [];
    }

    final fromPortOffset = fromNode.getPortOffset(link.fromPortId);
    final toPortOffset = toNode.getPortOffset(link.toPortId);

    if (fromPortOffset == null || toPortOffset == null) {
      return [];
    }

    return _computeLinkPath(
      link.outTo,
      link.inFrom,
      fromPortOffset,
      toPortOffset,
      fromNode,
      toNode,
    );
  }

  List<Position> _computeLinkPath(
    LinkDirection outTo,
    LinkDirection inFrom,
    Position fromPortPosition,
    Position toPortPosition,
    Node fromNode,
    Node toNode,
  ) {
    final points = <Position>[fromPortPosition];

    // TODO: main chunk

    return points;
  }

  bool _isToOnDirectionSide(
    LinkDirection outTo,
    Position fromPortPosition,
    Position toPortPosition,
  ) {
    switch (outTo) {
      case LinkDirection.left:
        return toPortPosition.x < fromPortPosition.x;
      case LinkDirection.right:
        return toPortPosition.x > fromPortPosition.x;
      case LinkDirection.up:
        return toPortPosition.y < fromPortPosition.y;
      case LinkDirection.down:
        return toPortPosition.y > fromPortPosition.y;
    }
  }

  Position _getFurthestPointFromOrigin(
    Position origin,
    Position point1,
    Position point2,
  ) {
    final dx1 = point1.x - origin.x;
    final dy1 = point1.y - origin.y;
    final dx2 = point2.x - origin.x;
    final dy2 = point2.y - origin.y;
    final dot1 = dx1 * dx1 + dy1 * dy1;
    final dot2 = dx2 * dx2 + dy2 * dy2;
    return dot1 > dot2 ? point1 : point2;
  }
}
