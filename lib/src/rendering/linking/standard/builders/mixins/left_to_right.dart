import 'package:schematic_diagrams/src/models/link_details.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/builders/standard_link_router.dart';
import 'package:schematic_diagrams/src/rendering/linking/standard/standard_link_path.dart';

mixin LeftToRight on StandardLinkRouter {
  StandardLinkPath leftToRight(LinkDetails linkDetails) {
    var linkPath = StandardLinkPath(start: linkDetails.fromPortPosition);

    final toIsLeft =
        linkDetails.toPortPosition.x <= linkDetails.fromPortPosition.x;
    final arePortsAligned =
        linkDetails.fromPortPosition.y == linkDetails.toPortPosition.y &&
        toIsLeft;

    if (arePortsAligned) {
      linkPath.addLineTo(
        linkDetails.toPortPosition.x,
        linkDetails.toPortPosition.y,
      );
      return linkPath;
    }

    final isLeft =
        linkDetails.toPortPosition.x < linkDetails.fromPortPosition.x;

    if (isLeft) {
      linkPath = _handleLeft(linkPath, linkDetails);
    } else {
      linkPath.addLineTo(
        linkDetails.fromPortPosition.x - minDistanceFromNodes,
        linkDetails.fromPortPosition.y,
      );

      final midX =
          (linkDetails.toPortPosition.x + linkDetails.fromPortPosition.x) / 2;
      linkPath
        ..addLineTo(midX, linkDetails.fromPortPosition.y)
        ..addLineTo(midX, linkDetails.toPortPosition.y);
    }

    linkPath.addLineTo(
      linkDetails.toPortPosition.x,
      linkDetails.toPortPosition.y,
    );
    return linkPath;
  }

  StandardLinkPath _handleLeft(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    final midX =
        (linkDetails.fromNode.position.x + linkDetails.toNode.maxX) / 2;

    linkPath
      ..addLineTo(midX, linkDetails.fromPortPosition.y)
      ..addLineTo(midX, linkDetails.toPortPosition.y);

    return linkPath;
  }
}
