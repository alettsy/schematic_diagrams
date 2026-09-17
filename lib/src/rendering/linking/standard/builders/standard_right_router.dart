import 'dart:math';

import 'package:schematic_diagrams/src/models/link_details.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/builders/mixins/left_to_right.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/builders/mixins/right_to_bottom.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/builders/mixins/right_to_top.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/builders/standard_link_router.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/standard_link_path.dart';

import '../../../../models/lines/straight_line.dart';

class StandardRightRouter extends StandardLinkRouter
    with RightToBottom, LeftToRight, RightToTop {
  @override
  List<StraightLine> toBottom(LinkDetails linkDetails) {
    return rightToBottom(linkDetails).lines;
  }

  @override
  List<StraightLine> toLeft(LinkDetails linkDetails) {
    return leftToRight(linkDetails.flip()).lines;
  }

  @override
  List<StraightLine> toTop(LinkDetails linkDetails) {
    return rightToTop(linkDetails).lines;
  }

  @override
  List<StraightLine> toRight(LinkDetails linkDetails) {
    var linkPath = StandardLinkPath(start: linkDetails.fromPortPosition);

    final isAboveFrom = linkDetails.toNode.isAbove(
      linkDetails.fromNode,
      offset: minDistanceFromNodes,
    );
    final isBelowFrom = linkDetails.toNode.isBelow(
      linkDetails.fromNode,
      offset: minDistanceFromNodes,
    );

    if (isAboveFrom || isBelowFrom) {
      linkPath = _handleAboveOrBelow(linkPath, linkDetails);
    } else if (linkDetails.toNode.isLeftOf(
      linkDetails.fromNode,
      offset: minDistanceFromNodes,
    )) {
      linkPath = _handleLeft(linkPath, linkDetails);
    } else {
      linkPath = _handleRight(linkPath, linkDetails);
    }

    linkPath.addLineTo(
      linkDetails.toPortPosition.x,
      linkDetails.toPortPosition.y,
    );

    return linkPath.lines;
  }

  StandardLinkPath _handleAboveOrBelow(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    final toMaxX = linkDetails.toNode.maxX;
    final fromMaxX = linkDetails.fromNode.maxX;
    final drawOutX = max(
      toMaxX + minDistanceFromNodes,
      fromMaxX + minDistanceFromNodes,
    );

    linkPath
      ..addLineTo(drawOutX, linkDetails.fromPortPosition.y)
      ..addLineTo(drawOutX, linkDetails.toPortPosition.y);

    return linkPath;
  }

  StandardLinkPath _handleLeft(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    final toMaxX = linkDetails.toNode.maxX;
    final fromMaxY = linkDetails.fromNode.maxY;

    final midX = (toMaxX + linkDetails.fromNode.position.x) / 2;
    linkPath
      ..addLineTo(
        linkDetails.fromPortPosition.x + minDistanceFromNodes,
        linkDetails.fromPortPosition.y,
      )
      ..addLineTo(
        linkDetails.fromPortPosition.x + minDistanceFromNodes,
        fromMaxY + minDistanceFromNodes,
      )
      ..addLineTo(midX, fromMaxY + minDistanceFromNodes)
      ..addLineTo(midX, linkDetails.toPortPosition.y);

    return linkPath;
  }

  StandardLinkPath _handleRight(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    final toMaxX = linkDetails.toNode.maxX;
    final toMaxY = linkDetails.toNode.maxY;
    final fromMaxX = linkDetails.fromNode.maxX;
    final midX = (fromMaxX + linkDetails.toNode.position.x) / 2;

    linkPath
      ..addLineTo(midX, linkDetails.fromPortPosition.y)
      ..addLineTo(midX, toMaxY + minDistanceFromNodes)
      ..addLineTo(toMaxX + minDistanceFromNodes, toMaxY + minDistanceFromNodes)
      ..addLineTo(toMaxX + minDistanceFromNodes, linkDetails.toPortPosition.y);

    return linkPath;
  }
}
