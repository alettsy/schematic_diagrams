import 'package:schematic_diagrams/src/models/link_details.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/builders/standard_link_router.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/standard_link_path.dart';

mixin RightToBottom on StandardLinkRouter {
  StandardLinkPath rightToBottom(LinkDetails linkDetails) {
    var linkPath = StandardLinkPath(start: linkDetails.fromPortPosition);

    final isRightOfFrom =
        linkDetails.toPortPosition.x > linkDetails.fromPortPosition.x;
    final isAboveFrom =
        linkDetails.toPortPosition.y < linkDetails.fromPortPosition.y;

    if (isRightOfFrom && isAboveFrom) {
      linkPath.addLineTo(
        linkDetails.toPortPosition.x,
        linkDetails.fromPortPosition.y,
      );
    } else if (isRightOfFrom) {
      linkPath = _handleRight(linkPath, linkDetails);
    } else if (isAboveFrom) {
      linkPath = _handleAbove(linkPath, linkDetails);
    } else {
      linkPath = _handleOtherPlacements(linkPath, linkDetails);
    }

    linkPath.addLineTo(
      linkDetails.toPortPosition.x,
      linkDetails.toPortPosition.y,
    );
    return linkPath;
  }

  StandardLinkPath _handleRight(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    final midX =
        (linkDetails.fromNode.maxX + linkDetails.toNode.position.x) / 2;
    final toMaxY = linkDetails.toNode.maxY;

    linkPath
      ..addLineTo(midX, linkDetails.fromPortPosition.y)
      ..addLineTo(midX, toMaxY + minDistanceFromNodes)
      ..addLineTo(linkDetails.toPortPosition.x, toMaxY + minDistanceFromNodes);

    return linkPath;
  }

  StandardLinkPath _handleAbove(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    final midY =
        (linkDetails.toNode.maxY + linkDetails.fromNode.position.y) / 2;

    linkPath
      ..addLineTo(
        linkDetails.fromPortPosition.x + minDistanceFromNodes,
        linkDetails.fromPortPosition.y,
      )
      ..addLineTo(linkDetails.fromPortPosition.x + minDistanceFromNodes, midY)
      ..addLineTo(linkDetails.toPortPosition.x, midY);

    return linkPath;
  }

  StandardLinkPath _handleOtherPlacements(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    final toMaxY = linkDetails.toNode.maxY;

    linkPath
      ..addLineTo(
        linkDetails.fromPortPosition.x + minDistanceFromNodes,
        linkDetails.fromPortPosition.y,
      )
      ..addLineTo(
        linkDetails.fromPortPosition.x + minDistanceFromNodes,
        toMaxY + minDistanceFromNodes,
      )
      ..addLineTo(linkDetails.toPortPosition.x, toMaxY + minDistanceFromNodes);

    return linkPath;
  }
}
