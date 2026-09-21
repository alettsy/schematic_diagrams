import 'dart:math';

import 'package:schematic_diagrams/src/internal/models/link_details.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/builders/standard_link_router.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/standard_link_path.dart';

mixin BottomToTop on StandardLinkRouter {
  StandardLinkPath bottomToTop(LinkDetails linkDetails) {
    var linkPath = StandardLinkPath(start: linkDetails.fromPortPosition);

    if (linkDetails.fromPortPosition.x == linkDetails.toPortPosition.x &&
        linkDetails.fromNode.isAbove(linkDetails.toNode)) {
      linkPath.addLineTo(
        linkDetails.toPortPosition.x,
        linkDetails.toPortPosition.y,
      );
      return linkPath;
    }

    final isLeftOfFrom = linkDetails.toNode.isLeftOf(
      linkDetails.fromNode,
      offset: minDistanceFromNodes,
    );
    final isRightOfFrom = linkDetails.toNode.isRightOf(
      linkDetails.fromNode,
      offset: minDistanceFromNodes,
    );
    final isBelow =
        linkDetails.toPortPosition.y > linkDetails.fromPortPosition.y;

    if (isBelow) {
      linkPath = _handleBelow(linkPath, linkDetails);
    } else if (isLeftOfFrom || isRightOfFrom) {
      linkPath = _handleLeftOrRight(linkPath, linkDetails);
    } else {
      linkPath = _handleAbove(linkPath, linkDetails);
    }

    linkPath.addLineTo(
      linkDetails.toPortPosition.x,
      linkDetails.toPortPosition.y,
    );

    return linkPath;
  }

  StandardLinkPath _handleBelow(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    final midY =
        (linkDetails.fromPortPosition.y + linkDetails.toPortPosition.y) / 2;

    linkPath
      ..addLineTo(linkDetails.fromPortPosition.x, midY)
      ..addLineTo(linkDetails.toPortPosition.x, midY);

    return linkPath;
  }

  StandardLinkPath _handleLeftOrRight(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    final isLeftOfFrom = linkDetails.toNode.isLeftOf(
      linkDetails.fromNode,
      offset: minDistanceFromNodes,
    );

    final toMaxX = linkDetails.toNode.maxX;
    final fromMaxX = linkDetails.fromNode.maxX;
    final fromBorder = isLeftOfFrom
        ? linkDetails.fromNode.position.x
        : fromMaxX;
    final toBorder = isLeftOfFrom ? toMaxX : linkDetails.toNode.position.x;
    final midX = (fromBorder + toBorder) / 2;

    linkPath
      ..addLineTo(
        linkDetails.fromPortPosition.x,
        linkDetails.fromPortPosition.y + minDistanceFromNodes,
      )
      ..addLineTo(midX, linkDetails.fromPortPosition.y + minDistanceFromNodes)
      ..addLineTo(midX, linkDetails.toNode.position.y - minDistanceFromNodes)
      ..addLineTo(
        linkDetails.toPortPosition.x,
        linkDetails.toNode.position.y - minDistanceFromNodes,
      );

    return linkPath;
  }

  StandardLinkPath _handleAbove(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    final drawOutX = min(
      linkDetails.fromNode.position.x,
      linkDetails.toNode.position.x,
    );

    linkPath
      ..addLineTo(
        linkDetails.fromPortPosition.x,
        linkDetails.fromPortPosition.y + minDistanceFromNodes,
      )
      ..addLineTo(
        drawOutX - minDistanceFromNodes,
        linkDetails.fromPortPosition.y + minDistanceFromNodes,
      )
      ..addLineTo(
        drawOutX - minDistanceFromNodes,
        linkDetails.toNode.position.y - minDistanceFromNodes,
      )
      ..addLineTo(
        linkDetails.toPortPosition.x,
        linkDetails.toNode.position.y - minDistanceFromNodes,
      );

    return linkPath;
  }
}
