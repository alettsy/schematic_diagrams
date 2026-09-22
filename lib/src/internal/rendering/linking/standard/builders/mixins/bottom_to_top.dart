import 'dart:math';

import 'package:schematic_diagrams/src/internal/constants.dart';
import 'package:schematic_diagrams/src/internal/models/link_details.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/builders/standard_link_router.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/standard_link_path.dart';

/// Helper for linking ports from bottom (down) direction to top (up) direction.
mixin BottomToTop on StandardLinkRouter {
  /// Helper for linking ports from bottom (down) direction to top (up)
  /// direction.
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
      offset: standardMinSeparation,
    );
    final isRightOfFrom = linkDetails.toNode.isRightOf(
      linkDetails.fromNode,
      offset: standardMinSeparation,
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
      offset: standardMinSeparation,
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
        linkDetails.fromPortPosition.y + standardMinSeparation,
      )
      ..addLineTo(midX, linkDetails.fromPortPosition.y + standardMinSeparation)
      ..addLineTo(midX, linkDetails.toNode.position.y - standardMinSeparation)
      ..addLineTo(
        linkDetails.toPortPosition.x,
        linkDetails.toNode.position.y - standardMinSeparation,
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
        linkDetails.fromPortPosition.y + standardMinSeparation,
      )
      ..addLineTo(
        drawOutX - standardMinSeparation,
        linkDetails.fromPortPosition.y + standardMinSeparation,
      )
      ..addLineTo(
        drawOutX - standardMinSeparation,
        linkDetails.toNode.position.y - standardMinSeparation,
      )
      ..addLineTo(
        linkDetails.toPortPosition.x,
        linkDetails.toNode.position.y - standardMinSeparation,
      );

    return linkPath;
  }
}
