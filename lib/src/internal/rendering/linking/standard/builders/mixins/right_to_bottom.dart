import 'package:schematic_diagrams/src/internal/constants.dart';
import 'package:schematic_diagrams/src/internal/models/link_details.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/builders/standard_link_router.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/standard_link_path.dart';

/// Helper for linking ports from right direction to bottom (down) direction.
mixin RightToBottom on StandardLinkRouter {
  /// Helper for linking ports from right direction to bottom (down) direction.
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
      ..addLineTo(midX, toMaxY + standardMinSeparation)
      ..addLineTo(linkDetails.toPortPosition.x, toMaxY + standardMinSeparation);

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
        linkDetails.fromPortPosition.x + standardMinSeparation,
        linkDetails.fromPortPosition.y,
      )
      ..addLineTo(linkDetails.fromPortPosition.x + standardMinSeparation, midY)
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
        linkDetails.fromPortPosition.x + standardMinSeparation,
        linkDetails.fromPortPosition.y,
      )
      ..addLineTo(
        linkDetails.fromPortPosition.x + standardMinSeparation,
        toMaxY + standardMinSeparation,
      )
      ..addLineTo(linkDetails.toPortPosition.x, toMaxY + standardMinSeparation);

    return linkPath;
  }
}
