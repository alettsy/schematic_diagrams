import 'dart:math';

import 'package:schematic_diagrams/src/internal/constants.dart';
import 'package:schematic_diagrams/src/internal/models/lines/straight_line.dart';
import 'package:schematic_diagrams/src/internal/models/link_details.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/builders/mixins/left_to_right.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/builders/mixins/right_to_bottom.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/builders/mixins/right_to_top.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/builders/standard_link_router.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/standard_link_path.dart';

/// Standard link router for links starting from the right direction.
class StandardRightRouter extends StandardLinkRouter
    with RightToBottom, LeftToRight, RightToTop {
  @override
  List<StraightLine> toBottom(LinkDetails linkDetails) {
    return rightToBottom(linkDetails).lines;
  }

  @override
  List<StraightLine> toLeft(LinkDetails linkDetails) {
    return leftToRight(linkDetails.flip()).lines;
  }

  @override
  List<StraightLine> toTop(LinkDetails linkDetails) {
    return rightToTop(linkDetails).lines;
  }

  @override
  List<StraightLine> toRight(LinkDetails linkDetails) {
    var linkPath = StandardLinkPath(start: linkDetails.fromPortPosition);

    final isAboveFrom = linkDetails.toNode.isAbove(
      linkDetails.fromNode,
      offset: standardMinSeparation,
    );
    final isBelowFrom = linkDetails.toNode.isBelow(
      linkDetails.fromNode,
      offset: standardMinSeparation,
    );

    if (isAboveFrom || isBelowFrom) {
      linkPath = _handleAboveOrBelow(linkPath, linkDetails);
    } else if (linkDetails.toNode.isLeftOf(
      linkDetails.fromNode,
      offset: standardMinSeparation,
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
    final toMaxX = linkDetails.toNode.maxX;
    final fromMaxX = linkDetails.fromNode.maxX;
    final drawOutX = max(
      toMaxX + standardMinSeparation,
      fromMaxX + standardMinSeparation,
    );

    linkPath
      ..addLineTo(drawOutX, linkDetails.fromPortPosition.y)
      ..addLineTo(drawOutX, linkDetails.toPortPosition.y);

    return linkPath;
  }

  StandardLinkPath _handleLeft(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    final toMaxX = linkDetails.toNode.maxX;
    final fromMaxY = linkDetails.fromNode.maxY;

    final midX = (toMaxX + linkDetails.fromNode.position.x) / 2;
    linkPath
      ..addLineTo(
        linkDetails.fromPortPosition.x + standardMinSeparation,
        linkDetails.fromPortPosition.y,
      )
      ..addLineTo(
        linkDetails.fromPortPosition.x + standardMinSeparation,
        fromMaxY + standardMinSeparation,
      )
      ..addLineTo(midX, fromMaxY + standardMinSeparation)
      ..addLineTo(midX, linkDetails.toPortPosition.y);

    return linkPath;
  }

  StandardLinkPath _handleRight(
    StandardLinkPath linkPath,
    LinkDetails linkDetails,
  ) {
    final toMaxX = linkDetails.toNode.maxX;
    final toMaxY = linkDetails.toNode.maxY;
    final fromMaxX = linkDetails.fromNode.maxX;
    final midX = (fromMaxX + linkDetails.toNode.position.x) / 2;

    linkPath
      ..addLineTo(midX, linkDetails.fromPortPosition.y)
      ..addLineTo(midX, toMaxY + standardMinSeparation)
      ..addLineTo(
        toMaxX + standardMinSeparation,
        toMaxY + standardMinSeparation,
      )
      ..addLineTo(toMaxX + standardMinSeparation, linkDetails.toPortPosition.y);

    return linkPath;
  }
}
