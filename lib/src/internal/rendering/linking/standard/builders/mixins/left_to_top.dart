import 'package:schematic_diagrams/src/internal/constants.dart';
import 'package:schematic_diagrams/src/internal/models/link_details.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/builders/standard_link_router.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/standard_link_path.dart';

/// Helper for linking ports from left direction to top (up) direction.
mixin LeftToTop on StandardLinkRouter {
  /// Helper for linking ports from left direction to top (up) direction.
  StandardLinkPath leftToTop(LinkDetails linkDetails) {
    var linkPath = StandardLinkPath(start: linkDetails.fromPortPosition);

    final isLeftOfFrom =
        linkDetails.fromPortPosition.x > linkDetails.toPortPosition.x;
    final isBelowFrom =
        linkDetails.fromPortPosition.y < linkDetails.toPortPosition.y;

    if (isLeftOfFrom && isBelowFrom) {
      linkPath.addLineTo(
        linkDetails.toPortPosition.x,
        linkDetails.fromPortPosition.y,
      );
    } else if (isLeftOfFrom) {
      linkPath = _handleLeft(linkPath, linkDetails);
    } else if (isBelowFrom) {
      linkPath = _handleBelow(linkPath, linkDetails);
    } else {
      linkPath = _handleOtherPlacements(linkPath, linkDetails);
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
        (linkDetails.toNode.maxX + linkDetails.fromNode.position.x) / 2;

    linkPath
      ..addLineTo(midX, linkDetails.fromPortPosition.y)
      ..addLineTo(midX, linkDetails.toNode.position.y - standardMinSeparation)
      ..addLineTo(
        linkDetails.toPortPosition.x,
        linkDetails.toNode.position.y - standardMinSeparation,
      );

    return linkPath;
  }

  StandardLinkPath _handleBelow(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    final midY =
        (linkDetails.fromNode.maxY + linkDetails.toNode.position.y) / 2;

    linkPath
      ..addLineTo(
        linkDetails.fromPortPosition.x - standardMinSeparation,
        linkDetails.fromPortPosition.y,
      )
      ..addLineTo(linkDetails.fromPortPosition.x - standardMinSeparation, midY)
      ..addLineTo(linkDetails.toPortPosition.x, midY);

    return linkPath;
  }

  StandardLinkPath _handleOtherPlacements(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    linkPath
      ..addLineTo(
        linkDetails.fromPortPosition.x - standardMinSeparation,
        linkDetails.fromPortPosition.y,
      )
      ..addLineTo(
        linkDetails.fromPortPosition.x - standardMinSeparation,
        linkDetails.toNode.position.y - standardMinSeparation,
      )
      ..addLineTo(
        linkDetails.toPortPosition.x,
        linkDetails.toNode.position.y - standardMinSeparation,
      );

    return linkPath;
  }
}
