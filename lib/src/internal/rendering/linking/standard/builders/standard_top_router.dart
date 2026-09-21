import 'dart:math';

import 'package:schematic_diagrams/src/internal/models/link_details.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/builders/mixins/bottom_to_top.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/builders/mixins/left_to_top.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/builders/mixins/right_to_top.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/builders/standard_link_router.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/standard_link_path.dart';
import 'package:schematic_diagrams/src/internal/models/lines/straight_line.dart';

class StandardTopRouter extends StandardLinkRouter
    with BottomToTop, LeftToTop, RightToTop {
  @override
  List<StraightLine> toBottom(LinkDetails linkDetails) {
    return bottomToTop(linkDetails.flip()).lines;
  }

  @override
  List<StraightLine> toLeft(LinkDetails linkDetails) {
    return leftToTop(linkDetails.flip()).lines;
  }

  @override
  List<StraightLine> toRight(LinkDetails linkDetails) {
    return rightToTop(linkDetails.flip()).lines;
  }

  @override
  List<StraightLine> toTop(LinkDetails linkDetails) {
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
    } else if (linkDetails.toNode.isAbove(
      linkDetails.fromNode,
      offset: minDistanceFromNodes,
    )) {
      linkPath = _handleAbove(linkPath, linkDetails);
    } else {
      linkPath = _handleBelow(linkPath, linkDetails);
    }

    linkPath.addLineTo(
      linkDetails.toPortPosition.x,
      linkDetails.toPortPosition.y,
    );

    return linkPath.lines;
  }

  StandardLinkPath _handleLeftOrRight(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    final drawOutY = min(
      linkDetails.toNode.position.y - minDistanceFromNodes,
      linkDetails.fromNode.position.y - minDistanceFromNodes,
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
      ..addLineTo(linkDetails.fromPortPosition.x, midY)
      ..addLineTo(linkDetails.toNode.position.x - minDistanceFromNodes, midY)
      ..addLineTo(
        linkDetails.toNode.position.x - minDistanceFromNodes,
        linkDetails.toNode.position.y - minDistanceFromNodes,
      )
      ..addLineTo(
        linkDetails.toPortPosition.x,
        linkDetails.toNode.position.y - minDistanceFromNodes,
      );

    return linkPath;
  }

  StandardLinkPath _handleBelow(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    final fromMaxY = linkDetails.fromNode.maxY;
    final midY = (fromMaxY + linkDetails.toNode.position.y) / 2;

    linkPath
      ..addLineTo(
        linkDetails.fromPortPosition.x,
        linkDetails.fromPortPosition.y - minDistanceFromNodes,
      )
      ..addLineTo(
        linkDetails.fromNode.position.x - minDistanceFromNodes,
        linkDetails.fromPortPosition.y - minDistanceFromNodes,
      )
      ..addLineTo(linkDetails.fromNode.position.x - minDistanceFromNodes, midY)
      ..addLineTo(linkDetails.toPortPosition.x, midY);

    return linkPath;
  }
}
