import 'dart:math';

import 'package:schematic_diagrams/src/models/link_details.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/builders/standard_link_router.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/standard_link_path.dart';

mixin LeftToBottom on StandardLinkRouter {
  StandardLinkPath leftToBottom(LinkDetails linkDetails) {
    var linkPath = StandardLinkPath(start: linkDetails.fromPortPosition);

    final isLeftOfFrom = linkDetails.fromPortPosition.x > linkDetails.toPortPosition.x;
    final isAboveFrom = linkDetails.fromPortPosition.y > linkDetails.toPortPosition.y;

    if (isLeftOfFrom && isAboveFrom) {
      linkPath.addLineTo(linkDetails.toPortPosition.x, linkDetails.fromPortPosition.y);
    } else if (isLeftOfFrom) {
      linkPath = _handleLeft(linkPath, linkDetails);
    } else if (isAboveFrom) {
      linkPath = _handleAbove(linkPath, linkDetails);
    } else {
      linkPath = _handleOtherPlacements(linkPath, linkDetails);
    }

    linkPath.addLineTo(linkDetails.toPortPosition.x, linkDetails.toPortPosition.y);
    return linkPath;
  }

  StandardLinkPath _handleLeft(StandardLinkPath linkPath, LinkDetails linkDetails) {
    final toMaxY = linkDetails.toNode.maxY;
    final midX = (linkDetails.toNode.maxX + linkDetails.fromNode.position.x) / 2;

    linkPath
      ..addLineTo(midX, linkDetails.fromPortPosition.y)
      ..addLineTo(midX, toMaxY + minDistanceFromNodes)
      ..addLineTo(linkDetails.toPortPosition.x, toMaxY + minDistanceFromNodes);

    return linkPath;
  }

  StandardLinkPath _handleAbove(StandardLinkPath linkPath, LinkDetails linkDetails) {
    final minX = min(linkDetails.fromPortPosition.x, linkDetails.toPortPosition.x);
    final midY =
        (linkDetails.fromNode.maxY +
            linkDetails.toNode.position.y) /
        2;

    linkPath
      ..addLineTo(minX - minDistanceFromNodes, linkDetails.fromPortPosition.y)
      ..addLineTo(minX - minDistanceFromNodes, midY)
      ..addLineTo(linkDetails.toPortPosition.x, midY);

    return linkPath;
  }

  StandardLinkPath _handleOtherPlacements(StandardLinkPath linkPath, LinkDetails linkDetails) {
    final toMaxY = linkDetails.toNode.maxY;

    linkPath
      ..addLineTo(
        linkDetails.fromPortPosition.x - minDistanceFromNodes,
        linkDetails.fromPortPosition.y,
      )
      ..addLineTo(
        linkDetails.fromPortPosition.x - minDistanceFromNodes,
        toMaxY + minDistanceFromNodes,
      )
      ..addLineTo(linkDetails.toPortPosition.x, toMaxY + minDistanceFromNodes);

    return linkPath;
  }
}
