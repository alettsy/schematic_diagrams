import 'dart:math';

import 'package:schematic_diagrams/src/models/lines/line.dart';
import 'package:schematic_diagrams/src/models/link_details.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/builders/mixins/bottom_to_top.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/builders/mixins/left_to_bottom.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/builders/mixins/right_to_bottom.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/builders/standard_link_router.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/standard_link_path.dart';

class StandardBottomRouter extends StandardLinkRouter
    with BottomToTop, LeftToBottom, RightToBottom {
  @override
  List<Line> toLeft(LinkDetails linkDetails) {
    return leftToBottom(linkDetails.flip()).lines;
  }

  @override
  List<Line> toTop(LinkDetails linkDetails) {
    return bottomToTop(linkDetails).lines;
  }

  @override
  List<Line> toRight(LinkDetails linkDetails) {
    return rightToBottom(linkDetails.flip()).lines;
  }

  @override
  List<Line> toBottom(LinkDetails linkDetails) {
    var linkPath = StandardLinkPath(start: linkDetails.fromPortPosition);

    final isLeftOfFrom = linkDetails.toNode.isLeftOf(
      linkDetails.fromNode,
      offset: minDistanceFromNodes,
    );
    final isRightOfFrom = linkDetails.toNode.isRightOf(
      linkDetails.fromNode,
      offset: minDistanceFromNodes,
    );

    if (isLeftOfFrom || isRightOfFrom) {
      linkPath = _handleLeftOrRight(linkPath, linkDetails);
    } else if (linkDetails.toNode.isBelow(
      linkDetails.fromNode,
      offset: minDistanceFromNodes,
    )) {
      linkPath = _handleBelow(linkPath, linkDetails);
    } else {
      linkPath = _handleAbove(linkPath, linkDetails);
    }

    linkPath.addLineTo(
      linkDetails.toPortPosition.x,
      linkDetails.toPortPosition.y,
    );
    return linkPath.lines;
  }

  StandardLinkPath _handleBelow(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    final fromMaxY = linkDetails.fromNode.maxY;
    final toMaxY = linkDetails.toNode.maxY;
    final midY = (fromMaxY + linkDetails.toNode.position.y) / 2;

    linkPath
      ..addLineTo(linkDetails.fromPortPosition.x, midY)
      ..addLineTo(linkDetails.fromNode.position.x - minDistanceFromNodes, midY)
      ..addLineTo(
        linkDetails.fromNode.position.x - minDistanceFromNodes,
        toMaxY + minDistanceFromNodes,
      )
      ..addLineTo(linkDetails.toPortPosition.x, toMaxY + minDistanceFromNodes);

    return linkPath;
  }

  StandardLinkPath _handleLeftOrRight(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    final drawOutY = max(
      linkDetails.toNode.maxY + minDistanceFromNodes,
      linkDetails.fromNode.maxY + minDistanceFromNodes,
    );

    linkPath
      ..addLineTo(linkDetails.fromPortPosition.x, drawOutY)
      ..addLineTo(linkDetails.toPortPosition.x, drawOutY);

    return linkPath;
  }

  StandardLinkPath _handleAbove(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    final toMaxY = linkDetails.toNode.maxY;
    final midY = (toMaxY + linkDetails.fromNode.position.y) / 2;

    linkPath
      ..addLineTo(
        linkDetails.fromPortPosition.x,
        linkDetails.fromPortPosition.y + minDistanceFromNodes,
      )
      ..addLineTo(
        linkDetails.fromNode.position.x - minDistanceFromNodes,
        linkDetails.fromPortPosition.y + minDistanceFromNodes,
      )
      ..addLineTo(linkDetails.fromNode.position.x - minDistanceFromNodes, midY)
      ..addLineTo(linkDetails.toPortPosition.x, midY);

    return linkPath;
  }
}
