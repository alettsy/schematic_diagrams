import 'dart:math';

import 'package:schematic_diagrams/src/internal/models/link_details.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/builders/mixins/left_to_bottom.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/builders/mixins/left_to_right.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/builders/mixins/left_to_top.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/builders/standard_link_router.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/standard_link_path.dart';
import 'package:schematic_diagrams/src/internal/models/lines/straight_line.dart';

class StandardLeftRouter extends StandardLinkRouter
    with LeftToTop, LeftToRight, LeftToBottom {
  @override
  List<StraightLine> toBottom(LinkDetails linkDetails) {
    return leftToBottom(linkDetails).lines;
  }

  @override
  List<StraightLine> toRight(LinkDetails linkDetails) {
    return leftToRight(linkDetails).lines;
  }

  @override
  List<StraightLine> toTop(LinkDetails linkDetails) {
    return leftToTop(linkDetails).lines;
  }

  @override
  List<StraightLine> toLeft(LinkDetails linkDetails) {
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
    final minX = min(
      linkDetails.toNode.position.x,
      linkDetails.fromNode.position.x,
    );

    linkPath
      ..addLineTo(minX - minDistanceFromNodes, linkDetails.fromPortPosition.y)
      ..addLineTo(minX - minDistanceFromNodes, linkDetails.toPortPosition.y);

    return linkPath;
  }

  StandardLinkPath _handleLeft(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    final toMaxY = linkDetails.toNode.maxY;
    final midX =
        (linkDetails.fromNode.position.x + linkDetails.toNode.maxX) / 2;

    linkPath
      ..addLineTo(midX, linkDetails.fromPortPosition.y)
      ..addLineTo(midX, toMaxY + minDistanceFromNodes)
      ..addLineTo(
        linkDetails.toNode.position.x - minDistanceFromNodes,
        toMaxY + minDistanceFromNodes,
      )
      ..addLineTo(
        linkDetails.toNode.position.x - minDistanceFromNodes,
        linkDetails.toPortPosition.y,
      );

    return linkPath;
  }

  StandardLinkPath _handleRight(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    final fromMaxY = linkDetails.fromNode.maxY;
    final midX =
        (linkDetails.toNode.position.x + linkDetails.fromNode.maxX) / 2;

    linkPath
      ..addLineTo(
        linkDetails.fromPortPosition.x - minDistanceFromNodes,
        linkDetails.fromPortPosition.y,
      )
      ..addLineTo(
        linkDetails.fromPortPosition.x - minDistanceFromNodes,
        fromMaxY + minDistanceFromNodes,
      )
      ..addLineTo(midX, fromMaxY + minDistanceFromNodes)
      ..addLineTo(midX, linkDetails.toPortPosition.y);

    return linkPath;
  }
}
