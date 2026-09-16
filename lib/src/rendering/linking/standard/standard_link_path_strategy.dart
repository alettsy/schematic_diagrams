import 'package:schematic_diagrams/schematic_diagrams.dart';
import 'package:schematic_diagrams/src/models/lines/line.dart';
import 'package:schematic_diagrams/src/models/link_details.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/builders/standard_bottom_router.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/builders/standard_left_router.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/builders/standard_right_router.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/builders/standard_top_router.dart';

import '../../../models/node_resolver.dart';
import '../link_path_strategy.dart';

class StandardLinkPathStrategy<T extends Link> extends LinkPathStrategy<T> {
  const StandardLinkPathStrategy({this.gap = 10});

  final double gap;

  @override
  List<Line> compute(T link, NodeResolver nodeResolver) {
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

    // TODO: after this part, should adjust lines accordingly + overlap jumps
    // Painter decides how they should look, not models
    return _computeLinkPath(
      LinkDetails(
        outTo: link.outTo,
        inFrom: link.inFrom,
        fromPortPosition: fromPortOffset,
        toPortPosition: toPortOffset,
        fromNode: fromNode,
        toNode: toNode,
      ),
    );
  }

  List<Line> _computeLinkPath(LinkDetails linkDetails) {
    switch (linkDetails.outTo) {
      case LinkDirection.left:
        return StandardLeftRouter().getLines(linkDetails);
      case LinkDirection.right:
      return StandardRightRouter().getLines(linkDetails);
      case LinkDirection.up:
      return StandardTopRouter().getLines(linkDetails);
      case LinkDirection.down:
      return StandardBottomRouter().getLines(linkDetails);
    }
  }
}
