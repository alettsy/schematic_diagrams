

import 'package:schematic_diagrams/src/models/link_details.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/builders/standard_link_router.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/standard_link_path.dart';

mixin LeftToTop on StandardLinkRouter {
  StandardLinkPath leftToTop(LinkDetails linkDetails) {
    var linkPath = StandardLinkPath(start: linkDetails.fromPortPosition);

    final isLeftOfFrom = linkDetails.fromPortPosition.x > linkDetails.toPortPosition.x;
    final isBelowFrom = linkDetails.fromPortPosition.y < linkDetails.toPortPosition.y;

    if (isLeftOfFrom && isBelowFrom) {
      linkPath.addLineTo(linkDetails.toPortPosition.x, linkDetails.fromPortPosition.y);
    } else if (isLeftOfFrom) {
      linkPath = _handleLeft(linkPath, linkDetails);
    } else if (isBelowFrom) {
      linkPath = _handleBelow(linkPath, linkDetails);
    } else {
      linkPath = _handleOtherPlacements(linkPath, linkDetails);
    }

    linkPath.addLineTo(linkDetails.toPortPosition.x, linkDetails.toPortPosition.y);
    return linkPath;
  }

  StandardLinkPath _handleLeft(StandardLinkPath linkPath, LinkDetails linkDetails) {
    final midX =
        (linkDetails.toNode.maxX +
            linkDetails.fromNode.position.x) /
        2;

    linkPath
      ..addLineTo(midX, linkDetails.fromPortPosition.y)
      ..addLineTo(
        midX,
        linkDetails.toNode.position.y - minDistanceFromNodes,
      )
      ..addLineTo(
        linkDetails.toPortPosition.x,
        linkDetails.toNode.position.y - minDistanceFromNodes,
      );

    return linkPath;
  }

  StandardLinkPath _handleBelow(StandardLinkPath linkPath, LinkDetails linkDetails) {
    final midY =
        (linkDetails.fromNode.maxY +
            linkDetails.toNode.position.y) /
        2;

    linkPath
      ..addLineTo(
        linkDetails.fromPortPosition.x - minDistanceFromNodes,
        linkDetails.fromPortPosition.y,
      )
      ..addLineTo(linkDetails.fromPortPosition.x - minDistanceFromNodes, midY)
      ..addLineTo(linkDetails.toPortPosition.x, midY);

    return linkPath;
  }

  StandardLinkPath _handleOtherPlacements(StandardLinkPath linkPath, LinkDetails linkDetails) {
    linkPath
      ..addLineTo(
        linkDetails.fromPortPosition.x - minDistanceFromNodes,
        linkDetails.fromPortPosition.y,
      )
      ..addLineTo(
        linkDetails.fromPortPosition.x - minDistanceFromNodes,
        linkDetails.toNode.position.y - minDistanceFromNodes,
      )
      ..addLineTo(
        linkDetails.toPortPosition.x,
        linkDetails.toNode.position.y - minDistanceFromNodes,
      );

    return linkPath;
  }
}
